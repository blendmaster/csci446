class SessionsController < Devise::SessionsController

  def after_sign_in_path_for resource
    resource.admin? ? admin_root_path : members_path
  end

  # overridding this to customize flash
  def create
    resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in, user: resource) if is_navigational_format?
    sign_in(resource_name, resource)
    respond_with resource, :location => after_sign_in_path_for(resource)
  end 
end
