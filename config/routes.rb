Rails.application.routes.draw do
  get "todos", to: "todos#db"
  get "todos/:id", to: "todos#show"
end
