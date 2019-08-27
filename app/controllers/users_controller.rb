class UsersController < ApplicationController
	before_action :authenticate_user!

  def index
  	 @users = User.all
  	 @new_book = Book.new
  	 @user = current_user
  end

  def show
  	 @user = User.find(params[:id])
  	 @books = @user.books
  	 @new_book = Book.new
  end

  def edit
  	 @user = User.find(params[:id])
  	 if @user.id != current_user.id
  	  redirect_to user_path(current_user)
  	end
  end

  def update
  	 @user = User.find(params[:id])
     if @user.update(user_params)
     flash[:notice] = "You have updated user successfully."
     redirect_to user_path(@user), notice: "You have updated user successfully."
     else
     render :edit
     end
  end

  private
         def user_params
         params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
