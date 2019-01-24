Rails.application.routes.draw do
  root 'main#index'
  get '/under_construction', to: 'main#under_construction'
  get '/vocab_list', to: 'main#vocab_list'
  delete 'vocab_list/:id', :to => 'main#destroy'
  get '/vocab_list/new', to: 'main#new_vocab'
  post '/vocab_list/new', :to => 'main#create_vocab'
  get '/profile', to: 'main#profile'
  get '/help', to: 'main#help'
  get '/coming_soon', to: 'main#under_construction'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
