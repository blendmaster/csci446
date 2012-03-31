class RegistrationsController < Devise::RegistrationsController
  def after_sign_up_path_for resource
    members_path
  end

  # overridden to use recaptcha, and custom flash, and set role to member
  def create
    if verify_recaptcha
      build_resource
      resource.role = Role.member
      if resource.save
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up, user: resource if is_navigational_format?
          sign_in(resource_name, resource)
          respond_with resource, :location => after_sign_up_path_for(resource)
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
          expire_session_data_after_sign_in!
          respond_with resource, :location => after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        respond_with resource
      end
    else
      build_resource
      clean_up_passwords resource
      flash.now[:alert] = "You didn't type the verification correctly!"
      render :new
    end
  end
end
