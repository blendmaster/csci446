class UsersController < ApplicationController
  controls :users, only: [:new]
  
  def create
    @user = User.new params[:user]
    if @user.save
      redirect_to root_url, message: "Registration successful"
    else
      render :new
    end
  end
end
