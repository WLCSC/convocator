Convocator::Application.routes.draw do
  get "registration" => 'registration#index', :as => 'registration' 
  get "registration/:id" => 'registration#show', :as => 'registrant'
  get "registration/:id/charges" => 'registration#charges', :as => 'registrant_charges'
  post "registration/:id/charge" => 'registration#charge', :as => 'registrant_charge'
  post "registration/charge" => 'registration#charge', :as => 'user_charge'
  post "registration/create", :as => 'create_registrant'
  get "registration/:id/qualify" => 'registration#qualifiers', :as => 'qualifiers'
  post "registration/:id/qualify" => 'registration#qualify', :as => 'qualify'
  post "registration/:id/register" => 'registration#register', :as => 'register'
  get "registration/:id/unregister" => 'registration#unregister', :as => 'unregister'
  get "registration/:id/destroy" => 'registration#destroy', :as => 'destroy_registrant'

  ActiveAdmin.routes(self)
  get "events" => 'events#index', :as => 'events'
  get "events/:id" => 'events#show', :as => 'event'
  get "events/tagged/:id" => 'events#tagged', :as => 'tag'

  get "about" => 'about#index', :as => 'about'
  get "about/presenters", :as => 'presenters'
  get "about/presenters/:id" => 'about#presenter', :as => 'presenter'
  get "about/organizers", :as => 'organizers'
  get "about/organizers/:id" => 'about#organizer', :as => 'organizer'

  resources :users do
      post 'condense', :on => :member
  end
  get "me" => 'users#me', :as => 'me'
  get 'me/edit' => 'users#edit', :as => 'edit_me'

  get "sign-in" => 'session#new', :as => 'sign_in'
  get "sign-up" => 'users#new', :as => 'sign_up'
  post "sign-in" => 'session#create', :as => 'session_create'
  get "sign-out" => 'session#destroy', :as => 'sign_out'

  get "pages" => 'pages#index', :as => 'pages'

  get '/:id' => 'pages#show', :as => 'page'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

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
