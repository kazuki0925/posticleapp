class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_article, only: [:show, :edit, :update, :destroy] 

  def index
    @articles = Article.includes(:user).order("created_at DESC")
    @favorite_articles = Article.find(Favorite.group(:article_id).order('count(article_id) DESC').pluck(:article_id))
    articles_evaluation = []
    @articles.each do |article|
      if article.good_evaluations.length + article.bad_evaluations.length != 0
        article_evaluation = 100 * article.good_evaluations.length / (article.good_evaluations.length + article.bad_evaluations.length)
        articles_evaluation << {score: article_evaluation, count: article.good_evaluations.length, name: article}
      else
        article_evaluation = 0
        articles_evaluation << {score: article_evaluation, count: article.good_evaluations.length, name: article}
      end
    end
    @good_articles = articles_evaluation.sort_by{ |a| -a[:score] }.sort_by{ |a| -a[:count] }.pluck(:name)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @article.comments.includes(:user)
    if user_signed_in?
    @favorite = Favorite.find_by(user_id: current_user.id, article_id: params[:id])
    @good_evaluation = GoodEvaluation.find_by(user_id: current_user.id, article_id: params[:id])
    @bad_evaluation = BadEvaluation.find_by(user_id: current_user.id, article_id: params[:id])
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to article_path(@article) 
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to root_path
  end

  def search
    @articles = Article.search(params[:keyword])
  end

  def category
    @num = params[:id].to_i
    @article = Article.find_by(category_id: params[:id])
    @articles = Article.where(category_id: params[:id]).order("created_at DESC")
  end

  private
  def article_params
    params.require(:article).permit(:title, :text, :image, :category_id).merge(user_id: current_user.id)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def move_to_index
    if user_signed_in? && current_user.id != @article.user_id 
      redirect_to root_path
    end
  end
end
