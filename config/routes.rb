Rails.application.routes.draw do
  root 'web/base#index'
  namespace :web, path: '/' do
    resources :players
  end
end
