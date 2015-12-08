Rails.application.routes.draw do

  resources :lobbies
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  resources :conversations, only: [:create]
  as :user do
    root 'welcome#index'
    get 'welcome/index' => 'welcome#index'
    get 'signin' => 'devise/sessions#new'
    post 'signin' => 'devise/sessions#create'
    get 'signup' => 'devise/registrations#new'
    get '/Forgot%20your%20password?' => 'devise/password#new'
    get 'joingame' => 'conversations#index'
    post 'conversations' => 'conversations#create'
    post '/messages/sendMessage' => 'messages#send_message'
    delete 'signout' => 'devise/sessions#destroy'
  end

  # You can have the root of your site routed with "root"


  #root 'welcome#login'
  #direct to main page.
  #get 'welcome/lobby' => 'welcome#lobby'
  #root 'welcome#lobby'
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  #resources :games do
  #  post "reload" => "reloads#reload_all"
  #  post "reload_game_rules" => "reloads#reload_game_rules"
  #  post "fill_table" => "fill#fill_table"
  #  post "new_round" => "round#create"
  #  post "new_game_rule" => "game_rules#create"
  #  post "play_cards" => "cards_played#create"
  #  post "pass_cards" => "cards_to_pass#create"
  #  post "toggle_passing_status" => "cards_to_pass#toggle"
  #  post "passing_set_ready" => "cards_to_pass#passing_set_ready"
  #end
  # Devise authentication routing
  #login
  #resources :users do
  #  resources :conversations do
  #    resources :messages
  #  end
  #end



=begin
  #skipping default routing for devise (as is alias of devise_scope)
  devise_for :users, :skip => [:sessions]
  as :user do
    get 'signin' => 'devise/sessions#new', :as => :new_user_session
    post 'signin' => 'devise/sessions#create', :as => :user_session
    delete 'signout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end
=end

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
