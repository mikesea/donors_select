DonorsSelect::Application.routes.draw do
  root to: 'projects#index'
  resources :projects, only: [ :index ]
  resources :projects_counts, only: [ :index ]
end
