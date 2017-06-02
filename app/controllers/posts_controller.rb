class PostsController < ApplicationController
  before_action :logged_in_user

  def index
    @posts = Post.all
    @title = "All questions"
  end

  def show
    @post = Post.find(params[:id])
    @answers = Post.find_by_answered(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def answer
    @post = Post.find(params[:id])
    @answer = Post.new
    @title = 'Answer for: "' + @post.title + '"'
  end


  def create
    post = current_user.posts.build(post_params)
    if post.valid? && post.save
      flash[:success] = "New question was created!"
      redirect_to posts_url
    else
      redirect_to user_path current_user
    end
  end


  def update
    post = Post.find(params[:id])
    if post.update_attributes(post_params)
      flash[:success] = "Post was successfully updated"
      redirect_to post
    else
      render 'edit'
    end
  end


  def destroy
    @post = current_user.posts.find_by(id: params[:id])
    @post.destroy
    flash[:success] = "Question was destroyed"
    redirect_to questions_user_url current_user
  end


  private

    def post_params
      params.require(:post).permit(:title, :content)
    end
end
