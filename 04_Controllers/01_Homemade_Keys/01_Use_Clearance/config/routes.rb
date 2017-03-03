Rails.application.routes.draw do
  # ...
  map.resources :session, controller: 'sessions'
end
