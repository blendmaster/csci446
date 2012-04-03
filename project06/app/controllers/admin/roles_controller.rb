class Admin::RolesController < ApplicationController
  authorize_resource
  controls :roles, as: :admin, redirect_url: :admin_roles_url
end
