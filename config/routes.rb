Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  resources :cocktails, only: [:index, :show, :new, :create, :edit, :update] do
    resources :doses, only: %i[new create update]
  end
  resources :doses, only: :destroy
end
