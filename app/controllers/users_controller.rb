class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]


  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def show
    @user = User.find(params[:id])
    @books = Book.where(user_id: @user).sort_by_favorites
    @relationship = current_user.relationships.find_by(follow_id: @user.id)
    @new_relationship = current_user.relationships.new
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
  end

  def index
    @users = User.all
    @relationship = current_user.relationships.find_by(follow_id: @users.ids)
    @new_relationship = current_user.relationships.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.followings.all
    @relationship = current_user.relationships.find_by(follow_id: @users.ids)
    @new_relationship = current_user.relationships.new
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.all
    @relationship = current_user.relationships.find_by(follow_id: @users.ids)
    @new_relationship = current_user.relationships.new
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
