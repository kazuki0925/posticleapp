class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @user = User.find(params[:id])
    @user_articles = Kaminari.paginate_array(@user.articles).page(params[:user_articles_page]).per(3)
    @favorites = @user.favorites
    favorite_articles = []
    @favorites.each do |favorite|
      favorite_articles << favorite.article
    end
    @favorite_articles = Kaminari.paginate_array(favorite_articles).page(params[:favorite_articles_page]).per(3)
  end
end
