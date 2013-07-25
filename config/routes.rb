Yatapi::Application.routes.draw do

  root to: 'home#index'
  get '/tour', to: 'tour#index'

end
