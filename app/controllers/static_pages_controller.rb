class StaticPagesController < ApplicationController

  def home
  end

  def help
  end

  def about
  end

  def contacts
  end

  def rating
    @users = User.joins(:posts).group('users.id').order('count(users.id) DESC')
  end

  def rating_votes
    users = User.joins(:posts).group('users.id').where('posts."post_type" = ?', 'q')
    @users = []
    users.each do |user|
      up = 0 & down = 0
      user.posts.each { |p| up += p.votes_up.count && down += p.votes_down.count }
      @users << {user: user, up: up, down: down, total: up+down}
    end
    @users = @users.sort_by { |obj| [obj[:total], obj[:up], obj[:down], obj[:user].name] }.reverse
  end
end
