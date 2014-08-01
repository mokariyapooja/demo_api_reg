Rails.application.routes.draw do
  

  devise_for :users
  namespace :api , :defaults => { :format => 'json' } do
    scope :module => :v1 do 
      #  #resources :sessions , :only => [:create , :destroy,:index] do
      #  # get "singin"
      #  resources :registration, :only => [:create]
      #  resources :sessions, :only => [:create] do
      #   collection do 
      #     post 'destroy'
      #   end
      #  end
      post 'update', to: 'user#update', as: :user
      get 'profile', to: 'user#profile', as: :user_profile
      # # post 'test', to: 'user#test', as: :test
      #  post 'change_password', to: 'password_resets#change_password', as: :password_resets
      #  post 'create', to: 'password_resets#create', as: :sent_mail
      # #resources :password_resets, :only => [:change_password]
      post 'signup' => 'registration#create',:as=>:signup
      post 'login' => 'sessions#create',:as => :end_user_login
      get 'logout' => 'sessions#destroy', :as => :end_user_logout
      post 'forgot_password' => 'password_resets#create'
      post 'change_password' => 'password_resets#change_password'
    end
  end
  

  #      #GET  "home" => "sessions/home" as: "home"
  #      get "sign_in", :to => "devise/sessions#new", as :user

  #     #GET "new" => "registration/new" as: "new"
  

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
