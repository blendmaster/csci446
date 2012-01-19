class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new params[:user]
		if @user.save
			redirect_to login_url, notice: "user #{@user.name} has been created"
		else
			render "new"
		end
	end
end
