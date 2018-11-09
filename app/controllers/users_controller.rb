class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def index
		@users = User.all
	end

	def create
		@user = User.new(user_params)
		if @user.save
			#send confirmation
			UsersMailer.signup_confirmation(@user).deliver
			redirect_to root_path
		else
			render "new"
		end
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to users_path
		else
			render "edit"
		end
	end
	
	def change_password
		@user = User.find(params[:id])
	end

	def update_pass
		@user = User.find(params[:id])


	private 
	def user_params
		params.require(:user).permit(:username, :email, :password, :membership, :admin, :active, :confirm_password)
	end
end
