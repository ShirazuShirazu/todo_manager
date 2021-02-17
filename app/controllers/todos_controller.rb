# todos_controller.rb
class TodosController < ApplicationController
  def index
    render plain: "Hello world, this is Shizzy"
  end

  def db
    render plain: Todo.all.to_a
  end
end
