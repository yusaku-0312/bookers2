class BooksController < ApplicationController
  
  before_action :is_matching_login_user, only: [:edit]
  before_action :move_to_sign_in
  
  def new
    @book = Book.new
  end

  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      
      redirect_to book_path(@book.id)
    else
      @user = @book.user
      @books = Book.all
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    
    @new_book = Book.new

  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end


  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
  
  def is_matching_login_user
    book = Book.find(params[:id])
    user = User.find(book.user_id)
    if user_signed_in?
      unless user.id == current_user.id
        redirect_to books_path
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
