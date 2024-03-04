Rails.application.routes.draw do
  
  root to: "public/homes#top"
  
  devise_for :user, controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admin, controllers: {
    # 管理者登録後 skip: [:registrations, :passwords]を実装する
    registrations: "admin/registrations",
    sessions: "admin/sessions"
  }
  
  get "admin" => "admin/homes#top"
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
