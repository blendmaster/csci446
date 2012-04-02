class ApplicationController < ActionController::Base
  protect_from_forgery

  check_authorization unless: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  # let's do some fancy metaprogramming
  def self.controls models, options = {}
    model = models.to_s.singularize
    model_instances = "@#{models}"
    model_instance = "@#{model}"
    constant = model.camelcase.constantize

    options[:only] ||= [:index, :show, :new, :create, :edit, :update, :destroy]
    options[:except] ||= []
    options[:as] ||= :default # for scoped mass assignment
    
    # the url redirect_url handling is dumb, since url helpers aren't available
    # in the class evaulation scope of controllers
    # thus, it's passed as a symbol, which is sent (dynamic method calling)
    # also, using the symbol :redirect breaks rails for some reason, thus :redirect_url

    actions = { # looks like javascript, huh
      index: lambda do
        instance_variable_set model_instances, constant.paginate(page: params[:page])
      end,
      show: lambda {}, # don't really need to do anything
      new: lambda do
        instance_variable_set model_instance, constant.new
      end,
      create: lambda do
        instance_variable_set model_instance, constant.new(params[model], as: options[:as])
        if instance_variable_get(model_instance).save
          redirect_to(
            (options[:redirect_url] ? send( options[:redirect_url] ) : instance_variable_get(model_instance)),
            notice: "#{model.capitalize} successfully created!")
        else
          render :new
        end
      end,
      edit: lambda {},
      update: lambda do
        if instance_variable_get(model_instance).update_attributes(params[model], as: options[:as])
          redirect_to(
            (options[:redirect_url] ? send( options[:redirect_url] ) : instance_variable_get(model_instance)),
            notice: "#{model.capitalize} sucessfully updated!" )
        else
          render :edit
        end
      end,
      destroy: lambda do
        constant.find(params[:id]).destroy
        redirect_to(
          (options[:redirect_url] ?
           send( options[:redirect_url] ) :
           send("#{models}_url".to_sym)), 
           notice: "#{model.capitalize} sucessfully purged!" )
      end
    }

    # set @object for applicable methods
    before_filter only: [:show, :edit, :update] do
      instance_variable_set model_instance, constant.find(params[:id])
    end
    
    # add methods
    (options[:only] - options[:except]).each do |method|
      define_method method, actions[method]
    end
  end
end
