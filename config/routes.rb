Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :user do
        post "sign_in", to: "sessions#sign_in"
        delete "sign_out", to: "sessions#sign_out"
        get "me", to: "sessions#me"
        #get "blogs/index"
        #get "blogs/show"
        #get "blogs/create"
        #get "blogs/update"
        #get "blogs/destroy" สามารถแทนที่ด้วย resources
        resources :blogs
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
