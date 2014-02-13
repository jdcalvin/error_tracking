Fnfi::Application.routes.draw do
  root 'order_types#index'
  
  resources :order_types do 
    resources :tasks, only: [:index, :new, :create, :destroy]
		resources :categories, only: [:index, :new, :create, :destroy]
    resources :orders
    get 'date/:year(/:month(/:day))', to: 'orders#index'       
  end
end
