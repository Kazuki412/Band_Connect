Rails.application.routes.draw do
  
  root to: "public/homes#top"
  
  devise_for :user, controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  # 管理者については登録済のため[新規登録・パスワード変更]のpathを使えないようにしています。
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :public do
    resources :bands, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resource :band_members, only: [:create, :destroy]
    end
    resources :rooms, only: [:create, :show]
    resources :messages, only: [:create]
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorite, only: [:create, :destroy]
    end
    resources :users, only: [:index, :show, :edit, :update]
    get "search" => "public/searches#search"
    get "tagsearches/search" => "public/tagsearches#search"
    get "users/unsubscribe" => "users#unsubscribe"
    patch "users/withdraw" => "users#withdraw"
  end

  get "admin" => "admin/homes#top"
  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :motivations, only: [:index, :create, :edit, :update]
    resources :musical_instruments, only: [:index, :create, :edit, :update]
    resources :users, only: [:show, :edit, :update]
    resources :bands, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :destroy]
    get "search" => "admin/searches#search"
    get "tagsearches/search" => "admin/tagsearches#search"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
