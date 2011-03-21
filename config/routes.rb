FypApp::Application.routes.draw do


  resources :sessions, :only => [:new, :create, :destroy]
  resources :users
  resources :songs 
  resources :artists 
  resources :albums
  
  match '/like/:id', :to => 'UserLikeSongs#new' , :as =>"like"
  match '/unlike/:id', :to => 'UserLikeSongs#destroy' , :as =>"unlike"
  
  match '/addallsingersfrommj', :to => 'artists#addallsingersfrommj', :as =>"addallsingersfrommj"
  match '/addfromcm', :to => 'artists#addfromcm', :as =>"addfromcm"
  
  match '/tag_cloud', :to => 'songs#tag_cloud'
 
  match '/tag/:tag', :to => 'songs#tag', :as =>"tag"

  match '/female', :to =>'artists#female', :as =>"female"
  match '/male', :to =>'artists#male', :as =>"male"
  match '/group', :to =>'artists#group', :as =>"group"
  match '/addartist',  :to => 'artists#new'
  match '/addsong',  :to => 'songs#new'
  match '/signup',  :to => 'users#new'
  match '/signupfb',  :to => 'users#facebook_create', :as=> "signupfb"
  match '/joiningfb/:id',  :to => 'users#joining_facebook', :as=> "joiningfb"
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  match '/help',    :to => 'pages#help'
  match '/admin',    :to => 'pages#admin'
  
  root :to => "pages#home"
  
  get "pages/home"
  get "pages/about"
  get "pages/contact"
  get "pages/help"
  

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
  

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
