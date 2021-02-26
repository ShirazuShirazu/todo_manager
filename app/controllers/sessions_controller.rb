class SessionsController < ApplicationController
  def new
    # Here it renders new.html.erb on its own. rails is pretty cool that way.
  end

  def create
    # checks if user exists
    user = User.find_by(email: params[:email])
    if user && user.password_digest == params[:password]
      render plain: "You are logged in"
    else
      render plain: "Incorrect email or password"
    end
  end
end
