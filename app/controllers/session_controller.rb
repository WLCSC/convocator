class SessionController < ApplicationController
  def new
      redirect_to root_path, :notice => 'You\'re already signed in.' if current_user
  end

  def create
      user = User.find_by :email => params[:email]
      if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect_to root_path, notice: "Signed in!"
      else
          redirect_to sign_in_path, alert: "Invalid credentials."
      end
  end

  def destroy
      session[:user_id] = nil
      redirect_to root_path, notice: "Signed out."
  end
end
