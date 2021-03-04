class RelationshipsController < ApplicationController
  
  # before_action :set_user

  def create
    # @user =User.find(params[:relationship][:follower_id])
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end
  
  def follow
    current_user.follow(params[:id])
    redirect_back(fallback_location: root_path)
  end
  
  def unfollow
    current_user.unfollow(params[:id])
    redirect_back(fallback_location: root_path)
  end
  
  # private

  # def set_user
  #   user = User.find(params[:relationship][:follow_id])
  # end
  
end
