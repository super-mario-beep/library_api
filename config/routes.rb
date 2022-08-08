Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      get '/books' => 'catalog#search_authors'
      get '/authors' => 'catalog#search_books'
      resources :sessions, only: [:create, :destroy]
      namespace :admin do
        resources :authors
        resources :books
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
