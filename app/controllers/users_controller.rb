class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :destroy] 
  before_action :move_to_index, only: [:edit, :update, :destroy] 


  def show
    @user_articles = Kaminari.paginate_array(@user.articles).page(params[:user_articles_page]).per(3)
    @favorites = @user.favorites
    favorite_articles = []
    @favorites.each do |favorite|
      favorite_articles << favorite.article
    end
    @favorite_articles = Kaminari.paginate_array(favorite_articles).page(params[:favorite_articles_page]).per(3)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'ユーザー情報を更新しました'
      redirect_to user_path(@user) 
    else
      flash.now[:alert] = 'ユーザー情報の更新に失敗しました'
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:nickname, :email)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def move_to_index
    if user_signed_in? && current_user.id != @user.id
      redirect_to root_path
    end
  end
end
