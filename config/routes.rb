Fnfi::Application.routes.draw do
  root 'order_types#index'
  
  resources :order_types do 
    resources :orders
    get 'date/:year(/:month(/:day))', to: 'orders#index'       
  end
end
