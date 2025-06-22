Rails.application.routes.draw do
  devise_for :users
  resources :announcements do
    resources :comments, only: [ :create ]
    resources :likes, only: [ :create ]
  end
  resource :profile, only: [ :show, :edit, :update ] do
    get :my_announcements, on: :member
  end
  root "announcements#index"
end
