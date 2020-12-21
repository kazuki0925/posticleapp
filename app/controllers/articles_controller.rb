class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_article, only: [:show, :edit, :update, :destroy] 

  def index
    @articles = Article.includes(:user).order("created_at DESC")
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
