# todos_controller.rb
class TodosController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    # render plain: Todo.all.order(:due_date).to_a.map { |todo| todo.to_pleasant_string }.
    #          join("\n")
    render "index"
  end

  def show
    id = params[:id]
    # render plain: Todo.exists?(id)
    todo = Todo.find_by(id: id)

    if todo == nil
      render plain: "No todo found with id: #{id}"
    else
      render plain: todo.to_pleasant_string
    end
  end

  def create
    Todo.create!(todo_text: params[:todo_text], due_date: params[:due_date], completed: false, id: params[:id])
    redirect_to todos_path
  end

  def update
    id = params[:id]
    todo = Todo.find_by(id: id)

    if todo == nil
      render plain: "No todo found with id: #{id}"
    else
      todo.completed = true
      todo.save
      render plain: "Updated todo."
    end
  end

  def destroy
    id = params[:id]
    todo = Todo.find_by(id: id)

    if todo == nil
      render plain: "No todo found with id: #{id}"
    else
      Todo.destroy(id)
      render plain: "Todo with id: #{id}, was deleted."
    end
  end
end
