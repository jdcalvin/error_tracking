Fnfi::Application.routes.draw do
  root 'static_pages#home'
  resources :orders, only: [:edit, :show ]

  resources :order_types do 
  	match 'archive', 	to: 'order_types#archive', via: 'get'
    resources :orders
    	get 'date/:year(/:month(/:day))', to: 'orders#index'
    	match 'new', to: 'orders#new', via: 'get'
    	 
  end
end
