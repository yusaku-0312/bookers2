class UsersController < ApplicationController
  
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :move_to_sign_in
  
  def new
  end
  
  def create
  end
  
  def index
    @users = User.all
    @user = current_user
    @new_book = Book.new
  end
  
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @new_book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    if user_signed_in?
      unless user.id == current_user.id
        redirect_to user_path(current_user.id)
      end
    else
      redirect_to new_user_session_path
    end
  end
  
  def move_to_sign_in
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
end
