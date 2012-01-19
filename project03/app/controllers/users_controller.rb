class UsersController < ApplicationController
	def index
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes params[:user]
			redirect_to @user, notice: "user updated"
		else
			render "edit"
		end
	end

	def destroy
		@user = User.find params[:id]
		if @user = current_user
			redirect_to users_url, notice: "Can't delete your own user!"
		else
			@user.destroy
			redirect_to users_url, notice: "User destroyed"
		end
	rescue Exception => e
		redirect_to users_url, notice: e.message
	end

	def show
		@user = User.find(params[:id])
	end

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
