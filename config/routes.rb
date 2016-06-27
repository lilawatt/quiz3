Rails.application.routes.draw do

    resources :users, only: [:new, :create]

    resources :sessions, only: [:new, :create] do
      delete :destroy, on: :collection
    end

    resources :suggestions do
        resources :members, only: [:create, :update, :destroy]

    get :search, on: :collection
    post :flag, on: :member
    post :mark_done

    resources :ideas, only: [:create, :destroy]
      resources :likes, only: [:create, :destroy]
  end

resources :likes, only: [:index]


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'home#index'
end
