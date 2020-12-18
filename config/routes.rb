Rails.application.routes.draw do
  root "boards#index"
  resources :boards
  get 'pricing', to: 'pages#pricing'

  resource :cart, only: [:show, :destroy] do
    # member do 
    #   post :add_item
    # end  
    # 這樣寫add_item沒辦法帶路徑
    post '/add_item/:id', action: 'add_item', as: 'add_item'
    get :checkout
  end

  resources :orders, only: [:index, :show, :create, :destroy] do
    
  end
  

  # get "/", to:"boards#index"
  #root "boards#index"

  # get "/users/sign_in" ,to: "sessions#new" 
  # delete "/users/sign_out" ,to: "sessions#destroy"

  # get "/users/sign_up" ,to: "registrations#new" 
  # post "/users/sign_up" ,to: "registrations#create" 

  
  
  # get "/users/edit", to: "registrations#edit", as: "edit_registration"
  # post "/users/edit", to: "registrations#update" as: "update_registration"# get '/users/sign_up', to: 'registrations#new', as: "registration"
  # 盡量使用resource : +only的寫法
  resource :users, controller: "registrations", only: [:create, :edit, :update] do
    get '/sign_up', action: "new"
  end

  resource :users, controller: "sessions", only:[] do
    get '/sign_in', action: 'new'
    post '/sign_in', action: 'create'
    delete '/sign_out', action: 'destroy'
  end

  resources :boards do
    member do
      patch :hide 
      patch :open 
      patch :lock 
    end
    resources :posts, shallow: true
  end

  resources :posts, only: [] do
    resources :comments, shallow: true, only: [:create, :destroy]
    member do
      post :favorite #POST /posts/:id/favorite
    end
  end

  # 影片11:00
  # -----------------------------------------------------------
  resources :accounts do
    resources :profiles, only: [:index, :new, :create] 
      # /accounts/2/profiles
  end
  resources :profiles, only: [:show, :edit, :update, :destroy]
     # /profiles/123
  # -----------------------------------------------------------
    # 以上可寫成下面，是rails的慣例
    resources :accounts do
      resources :profiles, shallow: true
    end


    resources :profiles, only: [] do
      member do
        get :say_hello
        #profile/3/say_hello 擴充路徑帶有id的寫法
      end

      collection do 
        get :say_hello
        #profile/say_hello 擴充路徑不帶id的寫法
      end
    end

    namespace :admin do
      resources :users
    end
# /admin/users 影片11:40
#admin/controllers/  admin不是controller 只是網址的前綴
    


    


end
