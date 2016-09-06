Rails.application.routes.draw do
  root 'welcome#index'

  resources :products, only: %i(index show)
  resources :inquiries, only: %i(new create)

  namespace :mylist do
    Daimon::Exhibition.routes :products, self
  end
end
