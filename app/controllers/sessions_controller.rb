class SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user] = user.id
      render json: user, status: :accepted
    else
      render json: {error: "wrong username or password"}, status: :unauthenticated
    end
  end
  
  def destroy
      session.delete(:user)
  end
end
