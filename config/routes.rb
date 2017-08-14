Rails.application.routes.draw do
  root "welcome#index"

  namespace :api do
    namespace :v1 do
      resources :foods, except: [:new, :edit]
      get "/meals", to: "meals#index", as: :meals
      get "/meals/:meal_id/foods", to: "meals#show", as: :meals_foods
      post "/meals/:meal_id/foods/:id", to: "meals#create", as: :meal_foods
      delete "/meals/:meal_id/foods/:id", to: "meals#destroy", as: :meal_food
    end
  end
end
