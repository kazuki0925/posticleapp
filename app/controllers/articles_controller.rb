class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_article, only: [:show, :edit, :update, :destroy] 

  def index
    @articles = Article.includes(:user).order("created_at DESC")
    @new_articles = Kaminari.paginate_array(@articles).page(params[:new_articles_page]).per(3)
    @favorites = Article.find(Favorite.group(:article_id).order('count(article_id) DESC').pluck(:article_id))
    @favorite_articles = Kaminari.paginate_array(@favorites).page(params[:favorite_articles_page]).per(3)
    articles_evaluation = []
    Article.evaluation(articles_evaluation, @articles)
    @goods = articles_evaluation.sort_by{ |a| -a[:score] }.sort_by{ |a| -a[:count] }.pluck(:name)
    @good_articles = Kaminari.paginate_array(@goods).page(params[:good_articles_page]).per(3)
    if user_signed_in?
      follow_users = current_user.followings
      follow_users_articles = []
      follow_users.each do |follow_user|
        follow_user.articles.each do |follow_user_article|
          follow_users_articles << follow_user_article
        end
      end
      @follow_users_articles = Kaminari.paginate_array(follow_users_articles).page(params[:follow_users_articles_page]).per(3)
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = '記事を投稿しました'
      redirect_to root_path
    else
      flash.now[:alert] = '記事の投稿に失敗しました'
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
      flash[:success] = '記事を更新しました'
      redirect_to article_path(@article) 
    else
      flash.now[:alert] = '記事の更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @article.destroy
    flash[:success] = '記事を削除しました'
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
