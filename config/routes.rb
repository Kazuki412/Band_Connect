Rails.application.routes.draw do

  root to: "public/homes#top"

  devise_for :user, controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  # ゲストログイン用です
  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  # 管理者については登録済のため[新規登録・パスワード変更]のpathを使えないようにしています。
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :public do
    resources :bands, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resource :band_permits, only: [:create, :destroy]
      resource :band_members, only: [:create, :destroy]
    end
    # バンドに参加申請をしているユーザー一覧を表示するため
    get "bands/:id/band_permits" => "bands#band_permits", as: :band_permit

    resources :messages, only: [:create]
    resources :dm_rooms, only: [:create, :index, :show, :edit, :update, :destroy]
    get "dm_rooms/new/:id" => "dm_rooms#new", as: "new_dm_room"
    post "entry" => "dm_rooms#room_add_user"
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
  end

  get "admin" => "admin/homes#top"
  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :motivations, only: [:index, :create, :edit, :update]
    resources :musical_instruments, only: [:index, :create, :edit, :update]
    resources :users, only: [:show, :update]
    resources :bands, only: [:index, :show, :update]
    resources :posts, only: [:index, :show, :destroy]
    resources :post_comments, only: [:index, :destroy]
    get "search" => "admin/searches#search"
    get "tagsearches/search" => "admin/tagsearches#search"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
