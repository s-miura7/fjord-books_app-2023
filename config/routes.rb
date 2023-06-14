Rails.application.routes.draw do
  resources :reports
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :books
  resources :users, only: %i(index show)

  resources :reports do
    scope module: :reports do
      resources :comments
    end
  end

  resources :books do
    scope module: :books do
      resources :comments
    end
  end
end
