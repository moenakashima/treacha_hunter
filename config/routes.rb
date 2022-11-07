Rails.application.routes.draw do

# ルートパス
root :to =>"public/homes#top"

# ユーザー用devise
# URL /users/sign_in ...
devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用devise
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}


# 管理者用
# URL /admin/...
namespace :admin do
  resources :tea_types, only:[:index, :create, :edit, :update, :destroy]
end

# ユーザー用
# URL /users/...
scope module: :public do
  resources :users, only:[:index, :show, :edit, :update]
end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
