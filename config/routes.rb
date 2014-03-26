Fnfi::Application.routes.draw do
  devise_for :users
  get "users/new"

  get '/search_results', to: 'search_results#search', via: 'get'

  root 'static_pages#home'
  
  match 'contact', 	to: 'static_pages#contact', via: 'get'
  match 'help', 		to: 'static_pages#help', 		via: 'get'
  match 'about',    to: 'static_pages#about',   via: 'get'	
  resources :search_results, only: [:index]
	resources :users, only: [:show]


  resources :order_types do 
  	match 'archive', 	to: 'order_types#archive', via: 'get'
    resources :orders
    	get 'date/:year(/:month(/:day))', to: 'orders#index', as: 'date'
    	match 'new', to: 'orders#new', via: 'get'
    	 
  end
end
