Rails.application.routes.draw do

  root to: "public/homes#top"

  devise_for :user, controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

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
    resources :users, only: [:index, :show, :edit, :update] do
      member do #user.idが必要なためmemberを使用しています。
        get :bookmarks #ブックマーク登録した投稿を一覧で表示するアクションです
      end
    end
    get "search" => "searches#search"
    get "tagsearches/search" => "tagsearches#tagsearch"
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
    resources :post_comments, only: [:index, :destroy]
    get "search" => "admin/searches#search"
    get "tagsearches/search" => "admin/tagsearches#search"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
