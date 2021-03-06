Rails.application.routes.draw do
  root to: "domains#index"

  # custom routes
  get    :landing,              to: "landing_pages#landing",              as: :landing
  post   :contact,              to: "landing_pages#contact_form",         as: :contact
  get    :contact_confirmation, to: "landing_pages#contact_confirmation", as: :confirmation
  get    :signin,               to: "sessions#new",                       as: :signin
  get    :signup,               to: "users#new",                          as: :signup

  # maybe make into a named resource
  get    :request_password,        to: "password_resets#request_password", as: :request_password
  get    "/reset_password/:token", to: "password_resets#reset_password",   as: :reset_password
  patch  "/reset_password/:token", to: "password_resets#update",           as: :password_reset


  # resource routes
  resources :sites, only: [:show]

  resources :users do
    resources :subscriptions, only: [:new, :create, :edit, :destroy]

    resources :properties, only: [:new, :create, :show, :edit, :update] do
      # get "confirmation",    on: :collection
      post "sort",           on: :collection
      patch "update_images", on: :member

      resources :photos, only: [:new, :create, :index, :destroy] do
        get "backgrounds", on: :collection
      end

      resources :downloads, only: [:index, :create]

      resources :disclosures, only: [:new, :create, :index, :destroy]
    end
  end

  resources :sessions, only: [:new, :create, :destroy]

  resources :password_resets, only: [:create]

  # custom url routing
  # Need to find a way to catch root domains
  get "someplaceelse.com", to: "custom_domains#router", as: :domain_domains

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
