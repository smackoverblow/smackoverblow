class VotesController < ApplicationController
  before_filter :logged_in_user

  def create
    user = User.find(params[:voter_id])
    post = Post.find(params[:post_id])
    type = params[:vote_type].to_i
    if type == 1
      if post.voted_up? user
        flash[:warning] = 'You already voted for this post!'
      else
        post.delete_vote_down user if post.voted_down? user
        post.votes_relationships.build(vote_params).save!
        flash[:success] = 'Congratz! You voted for this post!'
      end
    elsif type.zero?
      if post.voted_down? user
        flash[:warning] = 'You already disvoted this post! CHILL!'
      else
        post.delete_vote_up user if post.voted_up? user
        post.votes_relationships.build(vote_params).save!
        flash[:success] = 'Meh, You disvoted for this post!'
      end
    else
      flash[:warning] = "I DON'T KNOW WHAT HAPPENED"
    end
    redirect_to request.referrer
  end

  def destroy
  end

  private
    def vote_params
      params.permit(:post_id, :voter_id, :vote_type)
    end
end