FightyTest::Application.routes.draw do

  resources :users
  resources :user_sessions
  resources :messages

  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'characters#index'
  resources :characters
  resources :battles, only: [:show, :index]
  resources :battle_requests
  resources :battle_sessions


  get 'inventory' => 'inventory#index'
  get 'explore' => 'areas#index'

  # areas

  # vendors / inns

  get 'vendors/:id' => 'vendors#show', as: :vendor
  get 'inns/:id' => 'inns#show', as: :inn


  post 'attack/:id' => 'battles#attack', as: :attack
  get 'reset' => 'characters#reset', as: :reset

  get 'battle_request/:id' => 'battle_requests#new', as: :request_battle

  post 'accept_battle_request/:id' => 'battles#create', as: :battle_accept
  post 'decline_battle_request/:id' => 'battle_requests#decline', as: :battle_decline

  post 'add_consumable' => 'consumables#add', as: :add_consumable
  post 'consume/:id' => 'consumables#consume', as: :consume

  post 'select_character/:id' => 'users#select_character', as: :select_character


  # post 'characters/new' => 'characters#new', as: :character_creation

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
