class Vote < ApplicationRecord
  belongs_to :voter, class_name: 'User'
  belongs_to :post, class_name: 'Post'
  validates :voter_id, presence: true
  validates :post_id, presence: true
  validates :vote_type, presence: true, inclusion: { in: [0, 1] }
end
