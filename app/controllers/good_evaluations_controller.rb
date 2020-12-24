class GoodEvaluationsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_article, only: [:create, :destroy]

  def create
    @good_evaluation = GoodEvaluation.create(user_id: current_user.id, article_id: params[:article_id])
    if BadEvaluation.find_by(user_id: current_user.id, article_id: params[:article_id])
      @bad_evaluation = BadEvaluation.find_by(user_id: current_user.id, article_id: params[:article_id])
      @bad_evaluation.destroy
    end
  end

  def destroy
    @good_evaluation = GoodEvaluation.find_by(user_id: current_user.id, article_id: params[:article_id])
    @good_evaluation.destroy
  end

  private
  def set_article
    @article = Article.find(params[:article_id])
  end
end
