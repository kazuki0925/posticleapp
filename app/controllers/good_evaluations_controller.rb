class GoodEvaluationsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_article, only: [:create, :destroy]

  def create
    @good_evaluation = GoodEvaluation.new(user_id: current_user.id, article_id: params[:article_id])
    @good_evaluation.save
    if BadEvaluation.find_by(user_id: current_user.id, article_id: params[:article_id])
      @bad_evaluation = BadEvaluation.find_by(user_id: current_user.id, article_id: params[:article_id])
      @bad_evaluation.destroy
    end
    redirect_to article_path(@article)
  end

  def destroy
    @good_evaluation = GoodEvaluation.find_by(user_id: current_user.id, article_id: params[:article_id])
    @good_evaluation.destroy
    redirect_to article_path(@article)
  end

  private
  def set_article
    @article = Article.find(params[:article_id])
  end
end
