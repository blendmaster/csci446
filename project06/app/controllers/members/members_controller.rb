class Members::MembersController < ApplicationController
  before_filter :authenticate_user!

  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    # if user didn't edit password
    # update_attributes is trying to blank it out ;_;
    # this is a bad check to have to do, and devise should feel bad
    # about it
    unless params[:user][:password].length > 0
      params[:user][:password] = @user.password 
      params[:user][:password_confirmation] = @user.password 
    end
    
    if @user.update_attributes params[:user]
      # bypass validation in case user edited password
      sign_in @user, bypass: true
      redirect_to root_path, notice: "Successfully updated profile"
    else
      render :edit
    end
  end
end
