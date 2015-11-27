Rottenpotatoes::Application.routes.draw do
  resources :movies
  root :to => 'movies#index'
  # map '/' to be a redirect to '/movies'



  resources :movies do
    get "/similar" => "movies#similar", :as => :similar
  end

end
