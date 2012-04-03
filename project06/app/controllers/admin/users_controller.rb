class Admin::UsersController < ApplicationController
  authorize_resource
  controls :users, as: :admin, redirect_url: :admin_users_url
  before_filter only: :update do
    # if user didn't edit password
    # update_attributes is trying to blank it out ;_;
    # this is a bad check to have to do, and devise should feel bad
    # about it
    unless params[:user][:password].length > 0
      params[:user][:password] = @user.password 
      params[:user][:password_confirmation] = @user.password 
    end
  end
end
