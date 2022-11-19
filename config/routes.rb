Rails.application.routes.draw do

# ルートパス
root :to =>"public/homes#top"

get "/about" => "public/homes#about"


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

# ゲストユーザー用devise
devise_scope :user do
  post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
end

# 管理者用
# URL /admin/...
namespace :admin do
  root :to => "homes#top"
  resources :tea_types, only:[:index, :create, :edit, :update, :destroy]
  resources :users, only:[:show, :edit, :update]
  resources :teas, only:[:show, :index] do
   resources :tea_comments, only:[:destroy]
  end 
  
end

# ユーザー用
# URL /users/...
scope module: :public do
  resources :users, only:[:index, :show, :edit, :update, :favorite] do
    get "/favorites" => "users#favorite"
  end
  resources :teas, only:[:show, :update, :edit, :destroy, :new, :create] do
    resource :favorites, only:[:create, :destroy]
    resources :tea_comments, only:[:create, :destroy]
    
  end
  
  #タグ検索
  #タグによって絞り込んだ投稿を表示するアクションへのルーティング
  get '/search_tea_tag', to: 'teas#search_tag'
  get '/search_tea_type', to: 'teas#search_tea_type'
  get '/search' => "searches#search"
  

end

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
