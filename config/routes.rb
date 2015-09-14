Rails.application.routes.draw do





  resources :tickets

  get 'admin_dashboard', to: 'admin_dashboard#index'
  get 'admin_dashboard/analytics', to: 'admin_dashboard#analytics'
  get 'admin_dashboard/:id/resolve', to: 'admin_dashboard#resolve', :as => 'resolve_ticket'
  patch 'admin_dashboard/:id/', to: 'admin_dashboard#update'
  delete 'admin_dashboard/:id/destroy', to: 'admin_dashboard#destroy', :as => 'destroy_ticket'
  get 'admin_dashboard/:id/show', to: 'admin_dashboard#show', :as => 'show_admin'
  get 'admin_dashboard/activity', to: 'admin_dashboard#activity'

  post 'notifications/notify' => 'notifications#notify'


resources :admin_settings





  devise_for :users, controllers: { sessions: "users/sessions", passwords: "users/passwords", registrations: "users/registrations" }, :path_prefix => 'u'

  


  devise_scope :user do
    authenticated :user do
      root :to => 'tickets#index', as: :authenticated_user_root
    end
    unauthenticated :user do
      root :to => 'users/sessions#new', as: :unauthenticated_user_root
    end
  end



  
  resources :users

















  devise_for :admins, controllers: { sessions: "admins/sessions", passwords: "admins/passwords", registrations: "admins/registrations" }







  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
      post :restore
      post :mark_as_read
    end
    collection do
      delete :empty_trash
    end
  end
  resources :messages, only: [:new, :create]






  resources :to_dos, :path => "taskmanager"














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
