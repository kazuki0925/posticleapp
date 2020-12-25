class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates :password, format: { with: PASSWORD_REGEX, message: 'Include both letters and numbers' }, on: :create

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :good_evaluations, dependent: :destroy
  has_many :bad_evaluations, dependent: :destroy

  def favorite_by?(article_id)
    favorites.where(article_id: article_id).exists?
  end

  def good_by?(article_id)
    good_evaluations.where(article_id: article_id).exists?
  end

  def bad_by?(article_id)
    bad_evaluations.where(article_id: article_id).exists?
  end

end
