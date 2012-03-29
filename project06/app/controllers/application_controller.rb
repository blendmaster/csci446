class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # let's do some fancy metaprogramming
  def self.controls models, options = {}
    model = models.to_s.singularize
    model_instances = "@#{models}"
    model_instance = "@#{model}"
    constant = model.camelcase.constantize

    options[:only] ||= [:index, :show, :new, :create, :edit, :update, :destroy]
    options[:except] ||= []
    
    actions = { # looks like javascript, huh
      index: lambda do
        instance_variable_set model_instances, constant.paginate(page: params[:page])
      end,
      show: lambda {}, # don't really need to do anything
      new: lambda do
        instance_variable_set model_instance, constant.new
      end,
      create: lambda do
        instance_variable_set model_instance, constant.new(params[model])
        if instance_variable_get(model_instance).save
          redirect_to instance_variable_get(model_instance), notice: "#{model.capitalize} successfully created!"
        else
          render :new
        end
      end,
      edit: lambda {},
      update: lambda do
        if instance_variable_get(model_instance).update_attributes(params[model])
          redirect_to instance_variable_get(model_instance), notice: "#{model.capitalize} sucessfully updated!"
        else
          render :edit
        end
      end,
      destroy: lambda do
        constant.find(params[:id]).destroy
        redirect_to send("#{models}_url".to_sym), notice: "#{model.capitalize} sucessfully purged!"
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
