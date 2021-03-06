# Generated using rails generate controller Users

class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def index
    render plain: User.all.order(:id).to_a.map { |user| user.to_pleasant_string }.
             join("\n")
  end

  def show
    id = params[:id]
    user = User.find_by(id: id)

    if user == nil
      render plain: "No user found with id: #{id}"
    else
      render plain: user.to_pleasant_string
    end
  end

  def create
    User.create!(name: params[:name],
                 email: params[:email],
                 password_digest: params[:password])
    redirect_to "/"
  end

  def update
    id = params[:id]
    user = User.find_by(id: id)

    if user == nil
      render plain: "No user found with id: #{id}"
    else
      user.name = params[:name]
      user.email = params[:email]
      user.password = params[:password]

      user.save
      render plain: "Updated user."
    end
  end

  def destroy
    id = params[:id]
    user = User.find_by(id: id)

    if user == nil
      render plain: "No user found with id: #{id}"
    else
      User.destroy(id)
      render plain: "User with id: #{id}, was deleted."
    end
  end

  def new
    render "users/new"
  end
end
