Rails.application.routes.draw do
  root 'welcome#index'
  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  get '/shelters/:id', to: 'shelters#show'
  post '/shelters', to: 'shelters#create'
  delete 'shelters/:id', to: 'shelters#destroy'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch 'shelters/:id', to: 'shelters#update'
end
