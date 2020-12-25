class Comment < ApplicationRecord
  validates :text, {presence: true, length: { maximum: 2000 }}
  belongs_to :user
  belongs_to :article

end
