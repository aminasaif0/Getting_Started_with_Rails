Rails.application.routes.draw do
  devise_for :users
  root "articles#index"
  get 'admin_page', to: 'articles#index', as: 'admin_page'

  resources :articles do
    resources :comments
    member do
      patch 'set_state', to: 'articles#update_state'
    end
  end
end
