Rails.application.routes.draw do

  apipie
  resource :projects do
    resource :tasks, only: [:index, :show]
  end

end
