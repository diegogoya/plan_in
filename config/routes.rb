Rails.application.routes.draw do

  post '/events/:id/send_email', to: 'events#send_email', as: :send_email

  resources :events do
    resources :tasks do 
  	  resources :choices
  	end
  end
  
  devise_for :users

  root to: "home#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
