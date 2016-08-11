Rails.application.routes.draw do
  apipie

  resources :projects do
    collection do
      get 'unfinished'
    end
    resources :tasks, only: [:index, :show]
  end
  resources :users do
    collection do
      get 'born_in_september' 
      get 'adults'
    end
  end
end
