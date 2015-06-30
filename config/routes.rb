Tracker::Application.routes.draw do
  
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
    get 'admin_panel' =>  'organizations#admin'
  end

	
  #===============================================================
  #         STATIC
  #===============================================================
  root 'static_pages#home'
  get 'contact'  => 'static_pages#contact'
  get 'help'     => 'static_pages#help'  
  get 'about'    => 'static_pages#about'   

  #===============================================================
  #       SEARCH/DATE
  #===============================================================
  resources :search_results, only: [:search]
  get '/search_results' => 'search_results#search'

  resources :order_types do 
  	get 'archive' => 'order_types#archive'
    resources :orders
    resources :date, only: [:show_year, :show_month, :show_day]

    get 'date/:year/:month/:day' => 'dates#show_day'
    get 'date/:year/:month'      => 'dates#show_month'
    get 'date/:year'             => 'dates#show_year'
  end

end
