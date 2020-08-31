Rails.application.routes.draw do
  root 'welcome#index'

  get '/shelters',              to: 'shelters#index'
  get '/shelters/new',          to: 'shelters#new'
  get '/shelters/:id',          to: 'shelters#show'
  post '/shelters',             to: 'shelters#create'
  delete 'shelters/:id',        to: 'shelters#destroy'
  get '/shelters/:id/edit',     to: 'shelters#edit'
  patch 'shelters/:id',         to: 'shelters#update'

  get '/shelters/:id/pets',     to: 'shelterpets#index'

  get '/pets',                  to: 'pets#index'
  get '/shelters/:id/pets/new', to: 'pets#new'
  get '/pets/:id',              to: 'pets#show'
  post '/shelters/:id/pets',    to: 'pets#create'
  delete '/pets/:id',           to: 'pets#destroy'
  get '/pets/:id/edit',         to: 'pets#edit'
  patch 'pets/:id',             to: 'pets#update'

  get '/shelters/:shelter_id/reviews/new', to: 'reviews#new'
  post '/shelters/:shelter_id/reviews', to: 'reviews#create'
  get '/shelters/:shelter_id/reviews/:id/edit', to: 'reviews#edit'
  patch '/shelters/:shelter_id/reviews/:id', to: 'reviews#update'
  delete '/shelters/:shelter_id/reviews/:id/delete', to: 'reviews#destroy'

  patch '/favorites/:pet_id', to: 'favorites#update'
  delete '/favorites', to: 'favorites#destroy'
  delete '/favorites/:pet_id', to: 'favorites#destroy'
  delete '/favorites/index/:pet_id', to: 'favorites#delete'
  get '/favorites', to: 'favorites#index'

  get '/application', to: 'applications#new'
  post '/application', to: 'applications#create'
  get '/applications/:id', to: 'applications#show'
  get '/applications/:pet_id/index', to: 'applications#index'

end
