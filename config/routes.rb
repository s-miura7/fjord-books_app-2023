Rails.application.routes.draw do
  # config/routes.rb
# scope "(:locale)", locale: /en|ja/ do
#   resources :books
# end
  resources :books
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
