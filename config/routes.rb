Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only:[:new, :create, :update, :edit]
  # get("users/:id/edit", {to: 'users#edit', as: 'edit_user'})
  get("users/:id/edit/pass_edit", {to: 'users#pass_edit', as: 'edit_user_password'})
  post("users/:id/edit/pass_edit/pass_update", {to: 'users#pass_update',as: 'create_user_password'})
  resource :session, only:[:new, :create, :destroy]

  resources :posts, except: [:index] do
    resources :comments, only: [:create, :destroy]
  end

  get("/", { to: 'posts#index', as: 'root' })
end
