Rails.application.routes.draw do
  root 'web/base#index'
  namespace :web, path: '/', as: "" do
    resources :players do
      collection do
        post :import
      end
    end
    resources :tournaments do
      collection do
        get :atp
        get :wta
        get :itf
        post :import
      end
    end
    resources :matches
  end
end
