class Article < ApplicationRecord
  with_options presence: true do
    validates :title, length: { maximum: 40 }
    validates :text, length: { maximum: 15000 }
  end  

  belongs_to :user
  has_one_attached :image
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
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
end
