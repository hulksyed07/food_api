Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :v1 do
    resources :categories do
      resources :food
    end
    resources :sessions do
      collection do
        post :login
        post :logout
      end
    end
  end


  root 'v1/categories#index'

end
