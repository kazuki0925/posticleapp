class FavoritesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_article, only: [:create, :destroy]


  def create
    @favorite = Favorite.new(user_id: current_user.id, article_id: params[:article_id])
    @favorite.save
    redirect_to article_path(@article)
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, article_id: params[:article_id])
    @favorite.destroy
    redirect_to article_path(@article)
  end

  private
  def set_article
    @article = Article.find(params[:article_id])
  end
end
