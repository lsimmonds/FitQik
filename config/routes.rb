require 'api_constraints'

FitQik::Application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      post "appointment/add"
      post "appointment/update"
      #resources :students
      get '/students(.:format)', to: 'students#index', as: 'students'
      post '/students(.:format)', to: 'students#create'
      get '/students/:id(.:format)', to: 'students#show', as: 'student'
      post '/students/:id(.:format)', to: 'students#update'
      delete '/students/:id(.:format)', to: 'students#destroy'

      #resources :teachers
      get '/teachers(.:format)', to: 'teachers#index', as: 'teachers'
      post '/teachers(.:format)', to: 'teachers#create'
      get '/teachers/:id(.:format)', to: 'teachers#show', as: 'teacher'
      post '/teachers/:id(.:format)', to: 'teachers#update'
      delete '/teachers/:id(.:format)', to: 'teachers#destroy'

      #resources :admins
      get '/admins(.:format)', to: 'admins#index', as: 'admins'
      post '/admins(.:format)', to: 'admins#create'
      get '/admins/:id(.:format)', to: 'admins#show', as: 'admin'
      post '/admins/:id(.:format)', to: 'admins#update'
      delete '/admins/:id(.:format)', to: 'admins#destroy'

      devise_for :users
    end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
#  authenticated :user  do
#    root :to => 'home#index', as: :authenticated_root
    #get '/users/:id', to: 'users#show', as: :authenticated_root
#  end

  #unauthenticated do
    #root :to => "home#index", as: :unauthenticated_root
    #root :to => "home#index"
#    root :to => "static#home"
  #end


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
