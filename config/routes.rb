Rails.application.routes.draw do
  devise_for :customers, controllers: { registrations: 'customer_registrations' }
  devise_for :instructors

  resources :agenda

  authenticated :instructor do
    devise_scope :instructor do
      namespace :instructors do
        resources :appointments
        resources :approvals, only: [:create]
        resource  :calendar
      end
      root to: "instructors/appointments#index", as: :instructor_root
    end
  end

  authenticated :customer do
    devise_scope :customer do
      namespace :customers do
        resources :appointments, only: [:index, :create, :show]
        resource  :calendar
      end
      root to: "customers/calendar#show", as: :customer_root
    end
  end

  unauthenticated do
    root to: "homepage#index"
  end

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
