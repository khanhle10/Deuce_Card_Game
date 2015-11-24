class SessionsController < ApplicationController
  def new
  end

  def create
    if user = User.authentication(params[:username], params[:password])
      session[user_id] = user.id
      redirect_back_or_default(root_path)
    else
      render :action => new
    end
  end

  def destory
    session[:user_id] = nil
    redirect_to root_url
  end
end
