Rails.application.routes.draw do
  root 'web/base#index'
  namespace :web, path: '/', as: "" do
    resources :players
    resources :tournaments do
      collection do
        get :atp
        get :wta
        get :itf
      end
    end
    resources :matches
  end
end
