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
  
  get "admin" => "admin/homes#top"
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
