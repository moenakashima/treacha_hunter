Rails.application.routes.draw do

# ルートパス
root :to =>"public/homes#about"

get "/top" => "public/homes#top"


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
  # ランキング機能
  get '/teas/ranking' => "rankings#ranking"
  
  resources :users, only:[:index, :show, :edit, :update, :favorite] do
    get "/favorites" => "users#favorite"
  end
  resources :teas, only:[:show, :update, :edit, :destroy, :new, :create] do
    resource :favorites, only:[:create, :destroy]
    resources :tea_comments, only:[:create, :destroy]
    collection do
      get :new_confirm
    end
  end

  #検索機能
  get '/search_tea_tag', to: 'teas#search_tag'
  get '/search_tea_type', to: 'teas#search_tea_type'
  get '/search' => "searches#search"
  get '/sort_by_prefecture' => "users#sort_by_prefecture"
  
  # 投稿確認画面
  get '/teas/:id/confirm' => 'teas#confirm', as: 'teas_confirm'
  # get '/teas/:id/new_confirm' => 'teas#new_confirm', as: 'teas_new_confirm'


end

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
