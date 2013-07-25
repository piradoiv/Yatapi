Yatapi::Application.routes.draw do

  get "tour/index"

  root to: 'home#index'
  get '/tour', to: 'tour#index'

end
