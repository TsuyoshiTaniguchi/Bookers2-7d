Rails.application.routes.draw do
  devise_for :users

  root to: "homes#top"
  get "about" => "homes#about"

  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
    collection do
      get 'search'
      get 'tag_search'  # タグ検索用のルートを追加
    end
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  get "search" => "searches#search"
end
