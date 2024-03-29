Borrow::Application.routes.draw do
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
   root :to => 'pages#index'
   match "user/login" =>  "user#login"
   match "pages/om" => "pages#om"
   match "pages/topp" => "pages#topp"
   match "pages/referanser" => "pages#referanser"
   post "user/create"
   get "user/new"
   get "user/register"
   get "pages/hvorfor"
   get "pages/kontakt"
   get "user/home"
   get "user/logout"
   get "user/glemt"
   get "user/welcome"
   get "user/list"
   get "user/add"
   match "user" => "user#home"
   
   get "books/new"
   get "books/list"
   get "books/remove"
   get "books/compare"
   post "books/create"
   match "books/show:id"=> "books#show"
   match "books/list"=> "user#list"
   
   get "ajax/find_books"
   get "ajax/add_book"
   get "ajax/username_exists"
   match "ajax/find_postplace/:id" => "ajax#find_postplace"
   match "ajax/find_book_data/:id" => "ajax#find_book_data"
   match "ajax/username_exists/:id" => "ajax#username_exists"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
