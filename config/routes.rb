Fnfi::Application.routes.draw do
  devise_for :users
  get "users/new"

  resources :organizations
	resources :users, only: [:show, :index]

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
