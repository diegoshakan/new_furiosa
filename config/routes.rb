Rails.application.routes.draw do
  devise_for :users
  root "announcements#index"

  resources :announcements do
    resources :comments, only: [ :create ]
    resources :likes, only: [ :create ]
  end

  resource :profile, only: [ :show, :edit, :update ] do
    get :my_announcements, on: :member
  end

  resources :addresses, only: [] do
    collection do
      get :cities
    end
  end
end
