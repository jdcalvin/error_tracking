Fnfi::Application.routes.draw do
  root 'static_pages#home'
  
  resources :order_types do 
  	match 'archive', 	to: 'order_types#archive', via: 'get' 
    resources :orders
    	get 'date/:year(/:month(/:day))', to: 'orders#index'     
    	 
  end
end
