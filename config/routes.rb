DonorsSelect::Application.routes.draw do
  root to: 'projects#index'
  resources :projects
  resources :projects_counts
end
