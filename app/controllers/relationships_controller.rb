class RelationshipsController < ApplicationController
  before_action :set_user

  def set_user
    @user = User.find(params[:relationship][:follow_id])
  end

  def create
    following = current_user.follow(@user)
    if following.save
      redirect_to request.referer, notice: "You have followed this user."
    else
      flash.now[:alert] = "You failed to follow this user."
      redirect_to request.referer
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      redirect_to request.referer, notice: "You have removed this user."
    else
      flash.now[:alert] = "You failed to remove this user."
      redirect_to request.referer
    end
  end
end