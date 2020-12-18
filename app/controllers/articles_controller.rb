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
    @favorite = Favorite.find_by(user_id: current_user.id, article_id: params[:id])
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

  private
  def article_params
    params.require(:article).permit(:title, :text, :image).merge(user_id: current_user.id)
  end

  def set_article
    @article = Article.find(params[:id])
  end

end
