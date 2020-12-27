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
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  def favorite_by?(article_id)
    favorites.where(article_id: article_id).exists?
  end

  def good_by?(article_id)
    good_evaluations.where(article_id: article_id).exists?
  end

  def bad_by?(article_id)
    bad_evaluations.where(article_id: article_id).exists?
  end

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    if relationship
      relationship.destroy
    end
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end


end
