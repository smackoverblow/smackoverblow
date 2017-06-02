class Post < ApplicationRecord
  belongs_to :user
  has_many :answers, class_name: 'Post', foreign_key: :answered_id
  has_many :accepted_answer, class_name: 'Post', foreign_key: :accepted_id

  default_scope -> {order(created_at: :desc)}
  validates :user_id, presence: true
  validates :title, presence: true
  validates :content, presence: true, length: {minimum: 5}
end
