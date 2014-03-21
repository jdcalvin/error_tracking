Fnfi::Application.routes.draw do
  devise_for :users
  get "users/new"
  root 'static_pages#home'
  
  match 'contact', 	to: 'static_pages#contact', via: 'get'
  match 'help', 		to: 'static_pages#help', 		via: 'get'

  resources :orders, only: [:edit, :show ]

  resources :order_types do 
  	match 'archive', 	to: 'order_types#archive', via: 'get'
    resources :orders
    	get 'date/:year(/:month(/:day))', to: 'orders#index'
    	match 'new', to: 'orders#new', via: 'get'
    	 
  end
end
