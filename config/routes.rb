Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      get '/books' => 'catalog#search_books'
      get '/authors' => 'catalog#search_authors'
      resources :sessions, only: [:create, :destroy]
      namespace :admin do
        resources :author
        resources :books
        get '/outofstock' => 'books#out_of_stock'
        resources :loans
      end
      namespace :member do
        get '/' => 'history#index'
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
