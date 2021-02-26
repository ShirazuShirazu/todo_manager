class SessionsController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
    # Here it renders new.html.erb on its own. rails is pretty cool that way.
  end

  def create
    # checks if user exists and log them in.
    user = User.find_by(email: params[:email])
    if user && user.password_digest == params[:password]
      session[:current_user_id] = user.id
      redirect_to "/"
    else
      render plain: "Incorrect email or password"
    end
  end

  def destroy
    session[:current_user_id] = nil
    @current_user = nil
    redirect_to "/"
  end
end
