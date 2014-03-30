Fnfi::Application.routes.draw do
    resources :users

  devise_for :users, :skip => [:registrations, :sessions]

  as :user do
    get "/login" => "devise/sessions#new", :as => :new_user_session
    post "/login" => "devise/sessions#create", :as => :user_session
    delete "/logout" => "devise/sessions#destroy", :as => :destroy_user_session
  end
  resources :organizations
	

  get '/search_results', to: 'search_results#search', via: 'get'
  root 'static_pages#home'
  match 'contact',  to: 'static_pages#contact', via: 'get'
  match 'help',     to: 'static_pages#help',    via: 'get'
  match 'about',    to: 'static_pages#about',   via: 'get'  

  resources :search_results, only: [:search]

  resources :order_types do 
  	match 'archive', 	to: 'order_types#archive', via: 'get'
    resources :orders
    	get 'date/:year(/:month(/:day))', to: 'orders#index', as: 'date'   	 
  end

end
