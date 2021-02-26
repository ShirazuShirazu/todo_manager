Rails.application.routes.draw do
  get "/", to: "home#welcome"

  get "todos", to: "todos#index"
  get "todos/:id", to: "todos#show"
  post "todos", to: "todos#create"
  put "todos/:id", to: "todos#update"
  delete "todos/:id", to: "todos#destroy"

  resources :users

  get "/signin" => "sessions#new"
end
