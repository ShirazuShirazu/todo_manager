# Generated with migrate

class User < ApplicationRecord
  def to_pleasant_string
    return "User ID: #{id}, User Name: #{name}. User email: #{email}"
  end

  def get_password
    return password
  end
end