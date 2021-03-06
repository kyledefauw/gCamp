Rails.application.routes.draw do

  root 'welcome#index'
  get '/about', to: 'about#index'
  get '/terms', to: 'terms#index'
  get '/faq', to: 'common_questions#index'
  resources :users

  resources :projects do
    resources :memberships
    resources :tasks
  end

  resources :tasks do
    resources :comments
  end

  get 'sign-up', to: 'registrations#new'
  post 'sign-up', to: 'registrations#create'
  get 'sign-out', to: 'authentication#destroy'
  get 'sign-in', to: 'authentication#new'
  post 'sign-in', to: 'authentication#create'

  resources :tracker_projects, only: [:show]

end
