Newdad::Application.routes.draw do

  root :to => 'sessions#new'

  match '/about', to: 'pages#about'
  match '/contact', to: 'pages#contact'
  match '/signup', to: 'users#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/eventi', to: 'pages#eventi'
  match '/muro_sfogo', to: 'pages#wall_outburst'

  resources :users do
    member do
      get :following, :followers, :messages, :friends, :my_questions, :informazioni_profilo
    end

    collection do
      get :search
    end
  end

  resources :sessions, only: [:new, :create, :destroy]
  resources :posts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :messages, only: [:new, :create, :destroy]

  resources :questions do

    collection do
      get :home, :search
    end
  end

  resources :like_questions, only: [:create, :destroy]
  resources :categories
  resources :answers, only: [:create, :destroy]
  resources :age_groups, only: [:show]
  resources :like_answers, only: [:create, :destroy]

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
