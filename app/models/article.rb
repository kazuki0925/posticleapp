class Article < ApplicationRecord
  with_options presence: true do
    validates :title, length: { maximum: 40 }
    validates :text, length: { maximum: 15000 }
  end  

  belongs_to :user
  has_one_attached :image, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :good_evaluations, dependent: :destroy
  has_many :bad_evaluations, dependent: :destroy

  def self.search(search)
    if search != ""
      Article.where('text LIKE(?) OR title LIKE(?) OR category_id LIKE(?)', "%#{search}%", "%#{search}%", "%#{search}%")
    else
      Article.all
    end
  end

  def self.evaluation(articles_evaluation, articles)
    articles.each do |article|
      if article.good_evaluations.length + article.bad_evaluations.length != 0
        article_evaluation = 100 * article.good_evaluations.length / (article.good_evaluations.length + article.bad_evaluations.length)
        articles_evaluation << {score: article_evaluation, count: article.good_evaluations.length, name: article}
      else
        article_evaluation = 0
        articles_evaluation << {score: article_evaluation, count: article.good_evaluations.length, name: article}
      end
    end
  end
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
end
