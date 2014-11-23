Rails.application.routes.draw do
  #get 'sessions/new'
  
  # ressources
  #resources :users
  resources :sessions, :only => [:new, :create, :destroy]

  # named routes
  get 'home',             to: 'pages#home',             as: 'home'
  get 'contact',          to: 'pages#contact',          as: 'contact'
  get 'help',             to: 'pages#help',             as: 'help'
  get 'signup',           to: 'users#signup',           as: 'signup'
  post 'users/signup',    to: 'users#signup',           as: 'userssignup'
  get 'signin',           to: 'sessions#new',           as: 'signin'
  get 'signout',          to: 'sessions#destroy',       as: 'signout'
  get 'about',            to: 'pages#about',            as: 'about'
  get 'procol',           to: 'pages#procol',           as: 'procol'
  get 'users/:id',        to: 'users#show',             as: 'user'
  get 'users/show/:id',   to: 'users#show',             as: 'showuser'
  get 'error/404',        to: 'application#not_found',  as: 'fourohfour'
  post 'users/profile',   to: 'users#profile',          as: 'usersprofile'
  
  
  #get 'users/signup',     to: 'users#signup',   as: 'signupuser'
  get 'welcome/index'

  resources :widgets

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  root to: 'pages#home'

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
