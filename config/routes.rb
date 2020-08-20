Rails.application.routes.draw do
  root 'welcome#index'
  get '/shelters', to: 'shelters#index'
  get '/shelters/:id', to: 'shelters#show'
end
