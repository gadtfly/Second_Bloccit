Bloccit::Application.routes.draw do

  devise_for :users
  resources :users, only: [:update]

  resources :topics do
    resources :posts, except: [:index] do
      resources :comments, only: [:create, :update, :edit, :destroy]
      #should it be just create and destroy? as in bloc? why?
    end
  end

  get 'about' => 'welcome#about'

  root to: 'welcome#index'

end

