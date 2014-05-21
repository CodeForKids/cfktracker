Rails.application.routes.draw do

  root 'application#root'

  controller :sessions do
    get "/auth/:provider/callback", to: :create, as: :sign_in
    get "/sign-out", to: :destroy, as: :sign_out
  end

  get '/user/:id', to: 'timetrackers#user_times', as: :user_times
  put '/user/:id/receive_all', to: 'timetrackers#receive_all', as: :receive_all_times
  resources :timetrackers do
    put '/toggle', to: :toggle, as: :toggle
  end

end
