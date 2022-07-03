Rails.application.routes.draw do
  namespace :site do
    get 'welcome/index'
    get 'search', to: 'search#questions'
  end
  namespace :users_backoffice do
    get 'welcome/index'
  end
  namespace :admins_backoffice do
    # dashboard
    get 'welcome/index'
    resources :admins
    resources :subjects
    resources :questions
  end

  devise_for :users
  devise_for :admins
  get 'start', to: "site/welcome#index"

  # Aqui defino a rota padrão do app. O inicio é sempre no site geral
  root 'site/welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
