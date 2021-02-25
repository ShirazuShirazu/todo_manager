# Generated with migrate

class User < ApplicationRecord
  has_many :todos
  has_secure_password

  def to_pleasant_string
    return "User ID: #{id}, User Name: #{name}. User email: #{email}"
  end
end
