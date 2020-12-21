class Article < ApplicationRecord
  validates :title, presence: true
  validates :text, presence: true

  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :good_evaluations, dependent: :destroy
  has_many :bad_evaluations, dependent: :destroy

  def self.search(search)
    if search != ""
      Article.where('text LIKE(?) OR title LIKE(?)', "%#{search}%", "%#{search}%")
    else
      Article.all
    end
  end
end
