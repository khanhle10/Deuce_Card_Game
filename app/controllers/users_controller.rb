class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.where.not("id = ?",current_user.id).order("created_at DESC")
    @conversations = Conversation.involving(current_user).order("created_at DESC")
  end

  def show
    @users = User.find(params[:id])
  end

  def new
    @users = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url
    else
      render action: "new"
    end
  end

  def update
    @user
  end
end
