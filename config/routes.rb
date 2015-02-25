Rails.application.routes.draw do
  namespace :admin do
  get 'assignment/new'
  end

  namespace :admin do
  get 'assignment/create'
  end

  get 'assignment/new'

  get 'assignment/create'

  resources :subjects

  root             'static_pages#home'
  get 'help'    => 'static_pages#help'
  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'signup'  =>  'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :users
  namespace :admin do
    resources :users
    resources :courses do
      resources :assignment
    end
    resources :subjects
  end
end