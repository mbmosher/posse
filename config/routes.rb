Posse::Application.routes.draw do
  get "events/new"
  get "events/show"
  devise_for :users
  get "welcome/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  
  resources :users
  
  resources :groups do
    resources :events do
      resources :comments
    end
  end
  
  resources :rsvps
  
  resources :invites
  
  post 'invites/:id/leave' => 'invites#leave', as: :leave
  
  post 'invites/:id/accept' => 'invites#accept', as: :accept
  
  post 'group_users' => 'groups#sendInvite'
  
  post 'rsvps/:id/attend' => 'rsvps#attend', as: :attend
  
  post 'rsvps/:id/flake' => 'rsvps#flake', as: :flake
  
  get 'myevents' => 'events#index'
  
  get 'allevents' => 'events#allevents'
  
  get 'pastevents' => 'events#pastevents'
  

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
