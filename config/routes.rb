Fnfi::Application.routes.draw do
  
  #===============================================================
  #       DEVISE/USERS 
  #===============================================================
  resources :users
  devise_for :users, :skip => [:registrations, :sessions]
  as :user do
    get "/login"     => "devise/sessions#new",      :as => :new_user_session
    post "/login"    => "devise/sessions#create",   :as => :user_session
    delete "/logout" => "devise/sessions#destroy",  :as => :destroy_user_session
  end
  resources :organizations do
    match 'admin_panel', to: 'organizations#admin', via: 'get'
  end
	
  #===============================================================
  #         STATIC
  #===============================================================
  root 'static_pages#home'
  match 'contact',  to: 'static_pages#contact', via: 'get'
  match 'help',     to: 'static_pages#help',    via: 'get'
  match 'about',    to: 'static_pages#about',   via: 'get'

  #===============================================================
  #       SEARCH/DATE
  #===============================================================
  resources :search_results, only: [:search]
  get '/search_results', to: 'search_results#search', via: 'get'

  resources :order_types do 
  	match 'archive', 	   to: 'order_types#archive',   via: 'get'
    resources :orders
    	get 'date/:year(/:month(/:day))', to: 'orders#index', as: 'date'   	 
  end

end
