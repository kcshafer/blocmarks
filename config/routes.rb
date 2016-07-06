Rails.application.routes.draw do
  post :incoming, to: 'incoming#create'

  resources :topics do
		resources :bookmarks, except: [:index]
	end

  devise_for :users

  root 'topics#index'
end
