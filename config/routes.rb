Rails.application.routes.draw do

  post '/events/:id/send_email', to: 'events#send_email', as: :send_email

  post '/events/save_options', to: 'events#save_options'

  resources :events do
    resources :tasks do 
  	  resources :choices
  	end
  end
  
  devise_for :users

  root to: "home#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
