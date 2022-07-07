Rails.application.routes.draw do
  namespace :site do
    get 'welcome/index'
    get 'search', to: 'search#questions'
    get 'subject/:subject_id/:subject', to: 'search#subject', as: "search_subject"
    post 'answer', to: 'answer#verify'
  end
  namespace :users_backoffice do
    get 'welcome/index'
    get 'profile', to: 'profile#edit'
    patch 'profile', to: 'profile#update'
    get 'zip_code', to: 'zip_code#show'
  end
  namespace :admins_backoffice do
    # dashboard
    get 'welcome/index'
    resources :admins
    resources :subjects
    resources :questions
  end

  devise_for :users
  # Aqui eu retiro a rota externa de registro de administradores
  devise_for :admins, skip: [:registrations]
  get 'start', to: "site/welcome#index"
  get 'admin', to: "admins_backoffice/welcome#index"

  # Aqui defino a rota padrão do app. O inicio é sempre no site geral
  root 'site/welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
