Rails.application.routes.draw do





  resources :tickets

  get 'admin_dashboard', to: 'admin_dashboard#index'
  get 'admin_dashboard/metrics', to: 'admin_dashboard#metrics'
  get 'admin_dashboard/:id/resolve', to: 'admin_dashboard#resolve', :as => 'resolve_ticket'
  patch 'admin_dashboard/:id/', to: 'admin_dashboard#update'
  delete 'admin_dashboard/:id/destroy', to: 'admin_dashboard#destroy', :as => 'destroy_ticket'
  get 'admin_dashboard/:id/show', to: 'admin_dashboard#show', :as => 'show_admin'
  get 'admin_dashboard/activity', to: 'admin_dashboard#activity'
  get 'admin_dashboard/admin_user_management', to: 'admin_dashboard#admin_user_management'

  post 'notifications/notify' => 'notifications#notify'


resources :admin_settings



resources :user_settings, :except => :patch

patch 'user_settings/:id/deactivate', to: 'user_settings#deactivate', :as => 'cancel_account'





    get 'deactivated_users', to: 'users#deactivated_user_index'

    resources :users do
      member do
        patch 'deactivate'
        patch 'reactivate'
      end
    end


    resources :users, :except => :patch

    # delete 'users/:id' => 'users#destroy', :as => :destroy_user























  devise_for :users, controllers: { sessions: "users/sessions", passwords: "users/passwords", registrations: "users/registrations" }, :path_prefix => 'u'

  


  devise_scope :user do
    authenticated :user do
      root :to => 'tickets#index', as: :authenticated_user_root
    end
    unauthenticated :user do
      root :to => 'users/sessions#new', as: :unauthenticated_user_root
    end
  end





  






























  devise_for :admins, controllers: { sessions: "admins/sessions", passwords: "admins/passwords", registrations: "admins/registrations" }

  devise_scope :admin do
    authenticated :admin do
      root :to => 'admin_dashboard#index', as: :authenticated_admin_root
    end
    unauthenticated :admin do
      root :to => 'admins/sessions#new', as: :unauthenticated_admin_root
    end
  end










    resources :admins do
      member do
        patch 'deactivate'
        patch 'reactivate'
        get  'send_smstext'
        get 'smstext'
      end
    end

    resources :admins, :except => :patch

    #get 'admins/smstext/:id', to: 'admins#smstext'


    # delete 'users/:id' => 'users#destroy', :as => :destroy_user
    # delete 'admins/:id' => 'admins#destroy', :as => :destroy_admin






















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






  resources :tasks do
    member do
      put :toggle
    end
  end
 
  get 'cancel', to: 'tasks#cancel'




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
