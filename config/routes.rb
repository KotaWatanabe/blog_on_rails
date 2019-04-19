Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts, except: [:index] do
    resources :comments, only: [:create, :destroy]
  end

  get("/", { to: 'posts#index', as: 'root' })
end
