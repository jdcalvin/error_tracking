Fnfi::Application.routes.draw do
  root 'order_types#index'

  resources :categories
  
  resources :order_types do 
    resources :tasks, only: [:index, :new, :create]
    resources :orders, only: [:index, :new, :create, :show, :edit, :destroy]   
  end
  
  resources :tasks, only: [:show, :edit, :update, :destroy]
  
end
