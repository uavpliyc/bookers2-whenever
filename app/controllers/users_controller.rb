class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit,:update]
  before_action :authenticate_user!,only: [:show,:index, :edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    if user_signed_in?
      @currentUserEntry = UserRoom.where(user_id: current_user.id) #currenr_userがすでにルームに参加しているか
      @userEntry = UserRoom.where(user_id: @user.id)  #ユーザー詳細ページの表示しているユーザーがルームに参加してるか
      unless @user.id == current_user.id
        @currentUserEntry.each do |cu|  #current_userが参加してる全てのルームidを出力
          @userEntry.each do |u|  #@userが参加してる全てのルームidを出力
            if cu.room_id == u.room_id
              @haveRoom = true  #すでにルームがある
              @roomId = cu.room_id
            end
          end
        end
        unless @haveRoom
          @room = Room.new
          @user_room = UserRoom.new
        end
      end
    end
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
