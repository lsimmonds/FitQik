require 'api_constraints'

FitQik::Application.routes.draw do
  namespace :api do  namespace :v1 do resources :transactions, except: [:new, :edit] end end
  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do

      #get "pay/auth"
      get "pay/pay_paypal"
      get "pay/verify_paypal"
      get "pay/cancel_paypal"

      get '/appointments(.:format)', to: 'appointments#index', as: 'appointments'
      post '/appointments(.:format)', to: 'appointments#create'
      get '/appointments/:id(.:format)', to: 'appointments#show', as: 'appointment'
      get '/appointments/:id(.:format)/teachers', to: 'appointments#teachers'
      post '/appointments/:id(.:format)', to: 'appointments#update'
      delete '/appointments/:id(.:format)', to: 'appointments#destroy'

      #resources :students
      get '/students(.:format)', to: 'students#index', as: 'students'
      get '/my_student(.:format)', to: 'students#show_my_student'
      post '/students(.:format)', to: 'students#create'
      get '/students/:id(.:format)', to: 'students#show', as: 'student'
      post '/students/:id(.:format)', to: 'students#update'
      delete '/students/:id(.:format)', to: 'students#destroy'

      #resources :teachers
      get '/teachers(.:format)', to: 'teachers#index', as: 'teachers'
      get '/my_teacher(.:format)', to: 'teachers#show_my_teacher'
      post '/teachers(.:format)', to: 'teachers#create'
      get '/teachers/:id(.:format)', to: 'teachers#show', as: 'teacher'
      post '/teachers/:id(.:format)', to: 'teachers#update'
      delete '/teachers/:id(.:format)', to: 'teachers#destroy'
      get '/teachers/:id(.:format)/appointments', to: 'teachers#show_appoinments'
      post '/teachers/:id(.:format)/appointment', to: 'teachers#add_appoinments'
      get '/teachers/:id(.:format)/day_map', to: 'teachers#get_day_map'
      match '/teachers/:id(.:format)', to: 'teachers#options', via: [:options]

      #resources :admins
      get '/admins(.:format)', to: 'admins#index', as: 'admins'
      post '/admins(.:format)', to: 'admins#create'
      get '/admins/:id(.:format)', to: 'admins#show', as: 'admin'
      post '/admins/:id(.:format)', to: 'admins#update'
      delete '/admins/:id(.:format)', to: 'admins#destroy'

      get '/disciplines(.:format)', to: 'disciplines#index', as: 'disciplines'
      post '/disciplines(.:format)', to: 'disciplines#create'
      get '/disciplines/:id(.:format)', to: 'disciplines#show', as: 'discipline'
      post '/disciplines/:id(.:format)', to: 'disciplines#update'
      delete '/disciplines/:id(.:format)', to: 'disciplines#destroy'

      get '/subjects(.:format)', to: 'subjects#index', as: 'subjects'
      post '/subjects(.:format)', to: 'subjects#create'
      get '/subjects/:id(.:format)', to: 'subjects#show', as: 'subject'
      post '/subjects/:id(.:format)', to: 'subjects#update'
      delete '/subjects/:id(.:format)', to: 'subjects#destroy'

      get '/skills(.:format)', to: 'skills#index', as: 'skills'
      post '/skills(.:format)', to: 'skills#create'
      get '/skills/:id(.:format)', to: 'skills#show', as: 'skill'
      post '/skills/:id(.:format)', to: 'skills#update'
      delete '/skills/:id(.:format)', to: 'skills#destroy'

      get '/specialties(.:format)', to: 'specialties#index', as: 'specialties'
      post '/specialties(.:format)', to: 'specialties#create'
      get '/specialties/:id(.:format)', to: 'specialties#show', as: 'specialty'
      post '/specialties/:id(.:format)', to: 'specialties#update'
      delete '/specialties/:id(.:format)', to: 'specialties#destroy'

      get '/certifications(.:format)', to: 'certifications#index', as: 'certifications'
      post '/certifications(.:format)', to: 'certifications#create'
      get '/certifications/:id(.:format)', to: 'certifications#show', as: 'certification'
      post '/certifications/:id(.:format)', to: 'certifications#update'
      delete '/certifications/:id(.:format)', to: 'certifications#destroy'

       #devise_for :users, :skip => [:registrations]
      devise_for :users
      #options '/users(.:format)', to: 'registrations#create'
      #match '/users(.:format)', :controller => 'registrations', :action => 'create', :constraints => {:method => 'OPTIONS'}
      #devise_for :users

      devise_scope :api_user do
        #match '/users(.:format)', :controller => 'registrations', :action => 'create', :constraints => {:method => 'OPTIONS'}, via: [:options]
        #match '/users(.:format)', to: 'registrations#create', via: [:options, :post], as: 'user_registration'
        match '/users(.:format)', to: 'registrations#options', via: [:options]
        match '/users/sign_in(.:format)', to: 'sessions#options', via: [:options]
      end
  
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
