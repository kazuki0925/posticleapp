class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to article_path(@comment.article.id)
    else
      @article = Article.find(params[:article_id])
      @favorite = Favorite.find_by(user_id: current_user.id, article_id: @article.id)
      @good_evaluation = GoodEvaluation.find_by(user_id: current_user.id, article_id: @article.id)
      @bad_evaluation = BadEvaluation.find_by(user_id: current_user.id, article_id: @article.id)  
      @comments = Comment.all
      render "articles/show"
    end
  end

  def destroy
    comment = Comment.find(params[:article_id])
    comment.destroy
    @article = Article.find(params[:id])
    redirect_to article_path(@article)
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, article_id: params[:article_id])
  end
end
