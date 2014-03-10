XconfApp::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  resources :topics do
    get 'vote_for/:id', to: 'topics#vote_for', :on => :collection
    get 'contribute_for/:id', to: 'topics#contribute_for', :on => :collection
    get 'get_speakers/:id', to: 'topics#get_speakers', :on => :collection
    get 'add_speakers/:id', to: 'topics#add_speakers', :on => :collection
    get 'topics_list', to: 'topics#topics_list', :on => :collection
    get 'revoke_vote/:id', to: 'topics#revoke_vote', :on => :collection
  end

  resources :users do
    get 'registered_topics', to: 'users#registered_topics', :on => :collection
    get 'voted_topics', to: 'users#voted_topics', :on => :collection
  end

  resources :users, :topics, :logout

  root 'topics#index'


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
