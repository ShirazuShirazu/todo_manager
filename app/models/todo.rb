class Todo < ActiveRecord::Base
  def to_pleasant_string
    is_completed = completed ? "[X]" : "[ ]"
    return "#{id}) #{due_date.to_s(:short)} #{todo_text} #{is_completed}"
  end

  def due_today?
    due_date == Date.today
  end

  def overdue?
    due_date < Date.today
  end

  def self.overdue
    Todo.all.where("due_date < ?", Date.today)
  end

  def self.due_today
    Todo.all.where("due_date = ?", Date.today)
  end

  def self.due_later
    Todo.all.where("due_date > ?", Date.today)
  end

  def self.completed
    Todo.all.where(completed: TRUE).count
  end

  def self.show_list
    overdue = where("completed = ? and due_date = ?", false, Date.today - 1).to_displayable_list
    due_today = where(due_date: Date.today).to_displayable_list.join("\n")
    due_later = where("due_date > ?", Date.today).to_displayable_list.join("\n")

    puts "Overdue\n#{overdue}\nDue Today\n#{due_today} \nDue Later\n#{due_later} \n"
  end

  def self.add_task(todo_hash)
    create!(todo_text: todo_hash[:todo_text], due_date: Date.today + todo_hash[:due_in_days], completed: false)
  end

  def self.mark_as_complete!(todo_id)
    todo = find_by(id: todo_id)
    if (todo != nil)
      todo.completed = true
      todo.save
    else
      puts "Todo not found."
    end
  end
end
