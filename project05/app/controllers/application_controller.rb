class ApplicationController < ActionController::Base
  protect_from_forgery

  # let's do some fancy metaprogramming
  def self.controls models
    model = models.to_s.singularize
    model_instances = "@#{models}"
    model_instance = "@#{model}"
    constant = model.capitalize.constantize

    before_filter only: [:show, :edit, :update] do
      instance_variable_set model_instance, constant.find(params[:id])
    end

    define_method :index do
      instance_variable_set model_instances, constant.paginate(page: params[:page])
    end

    define_method :show do
    end

    define_method :new do
      instance_variable_set model_instance, constant.new
    end
    
    define_method :create do
      instance_variable_set model_instance, constant.new(params[model])
      if instance_variable_get(model_instance).save
        redirect_to instance_variable_get(model_instance), notice: "#{model.capitalize} successfully created!"
      else
        render :new
      end
    end

    define_method :edit do
    end

    define_method :update do
      if instance_variable_get(model_instance).update_attributes(params[model])
        redirect_to instance_variable_get(model_instance), notice: "#{model.capitalize} sucessfully updated!"
      else
        render :edit
      end
    end

    define_method :destroy do
      constant.find(params[:id]).destroy
      redirect_to send("#{models}_url".to_sym), notice: "#{model.capitalize} sucessfully purged!"
    end
  end
end
