class Post < ApplicationRecord
  belongs_to :user
  has_many :answers, class_name: 'Post', foreign_key: :answered_id
  has_one :accepted_answer, class_name: 'Post', foreign_key: :accepted_id
  has_many :votes_relationships,  class_name: 'Vote',
                                  foreign_key: :post_id,
                                  dependent: :destroy
  has_many :votes_up,     -> { where(votes: { vote_type: 1 }) },
                          through: :votes_relationships,
                          source: :voter
  has_many :votes_down,   -> { where(votes: { vote_type: 0 }) },
                          through: :votes_relationships,
                          source: :voter

  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { minimum: 5, maximum: 255 }, if: -> { post_type == 'q' }
  validates :content, presence: true, length: { minimum: 5 }


  def delete_vote_up(other_user)
    votes_up.delete(other_user)
  end

  def delete_vote_down(other_user)
    votes_down.delete(other_user)
  end

  def voted_up?(other_user)
    votes_up.include?(other_user)
  end

  def voted_down?(other_user)
    votes_down.include?(other_user)
  end
end
