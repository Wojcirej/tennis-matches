Rails.application.routes.draw do
  root 'web/base#index'
  namespace :web, path: '/', as: "" do
    resources :players
  end
end
