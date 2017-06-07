class Vote < ApplicationRecord
  belongs_to :voter, class_name: 'User'
  validates :voter_id, presence: true
end
