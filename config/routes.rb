Bloccit::Application.routes.draw do

  devise_for :users
  resources :users, only: [:update]

  resources :topics do
    resources :posts, except: [:index]
  end

  get 'about' => 'welcome#about'

  root to: 'welcome#index'

end


# GET /topics     TopicsController#index

# GET /galleries/123
#   galleries#show
#     @gallery = Galary.find(123)
#     @photos = @gallery.photos
#     # render webpage that shows these things
# GET /galleries/123/photos/new
# POST /galleries/123/photos
# GET /galleries/123/photos/1