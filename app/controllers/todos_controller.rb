# todos_controller.rb
class TodosController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def index
    @todos = current_user.todos
    @current_user_name = current_user.name
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
    new_todo = Todo.new(todo_text: params[:todo_text],
                        due_date: params[:due_date],
                        completed: false,
                        user_id: session[:current_user_id])

    if new_todo.save
      redirect_to todos_path
    else
      flash[:error] = new_todo.errors.full_messages[0]
      redirect_to todos_path
    end
  end

  def update
    id = params[:id]
    todo = Todo.find_by(id: id)

    if todo == nil
      render plain: "No todo found with id: #{id}"
    else
      todo.completed = (not todo.completed)
      todo.save
      redirect_to todos_path
    end
  end

  def destroy
    id = params[:id]
    todo = Todo.find_by(id: id)

    if todo == nil
      render plain: "No todo found with id: #{id}"
    else
      Todo.destroy(id)
      redirect_to todos_path
    end
  end
end
