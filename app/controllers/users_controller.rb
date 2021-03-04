class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit,:update]
  before_action :authenticate_user!,only: [:show,:index, :edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    # @following_users = current_user.following_user
    # @follower_users = current_user.follower_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  def following
    @user = User.find(params[:id])
    @users = @user.follower
    render 'following'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followed
    render 'followers'
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to new_user_session_path
    end
  end

end
