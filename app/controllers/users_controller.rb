class UsersController < ApplicationController
  before_action :logged_in_user,  only: [:index, :edit, :update, :destroy,
                                         :following, :followers, :questions, :answers]
  before_action :correct_user,    only: [:edit, :update]
  before_action :admin_user,      only: :destroy

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.question_feed
    redirect_to root_url && return unless @user.activated?
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Info was successfully updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User was deleted"
    redirect_to users_url
  end

  def following
    @title = 'Following'
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def questions
    @user = User.find(params[:id])
    @title = !!@user == current_user ? 'My questions' : @user.name + "'s questions"
    questions = Post.where(post_type: 'q', user_id: @user.id)
    @posts = questions.count > 0 ? questions : []
    @post = Post.new
    render 'posts/index'
  end

  def answers
    @user = User.find(params[:id])
    @title = !!@user == current_user ? 'My answers' : @user.name + "'s answers"
    answers = Post.where(post_type: 'a', user_id: @user.id)
    @posts = answers.count > 0 ? answers : []
    render 'posts/answers'
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end


  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
