class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
    @games = Game.paginate page: params[:page]
  end
  
  # let's do some fancy metaprogramming
  def self.controls models, options = {}
    model = models.to_s.singularize
    model_instances = "@#{models}"
    model_instance = "@#{model}"
    constant = model.capitalize.constantize

    options[:only] ||= [:index, :show, :new, :create, :edit, :update, :destroy]

    before_filter only: [:show, :edit, :update] do
      instance_variable_set model_instance, constant.find(params[:id])
    end

    if options[:only].include? :index
      define_method :index do
        instance_variable_set model_instances, constant.paginate(page: params[:page])
      end
    end

    if options[:only].include? :show
      define_method :show do
      end
    end

    if options[:only].include? :new
      define_method :new do
        instance_variable_set model_instance, constant.new
      end
    end
    
    if options[:only].include? :create
      define_method :create do
        instance_variable_set model_instance, constant.new(params[model])
        if instance_variable_get(model_instance).save
          redirect_to instance_variable_get(model_instance), notice: "#{model.capitalize} successfully created!"
        else
          render :new
        end
      end
    end

    if options[:only].include? :edit
      define_method :edit do
      end
    end

    if options[:only].include? :update
      define_method :update do
        if instance_variable_get(model_instance).update_attributes(params[model])
          redirect_to instance_variable_get(model_instance), notice: "#{model.capitalize} sucessfully updated!"
        else
          render :edit
        end
      end
    end

    if options[:only].include? :destroy
      define_method :destroy do
        constant.find(params[:id]).destroy
        redirect_to send("#{models}_url".to_sym), notice: "#{model.capitalize} sucessfully purged!"
      end
    end
  end
end
