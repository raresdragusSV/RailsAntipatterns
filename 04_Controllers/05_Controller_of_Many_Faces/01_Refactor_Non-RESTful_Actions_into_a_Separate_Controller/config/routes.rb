resource :sessions, only: [:new, :create, :destroy]
match '/login' => 'sessions#new', as: :login
match '/logout' => 'sessions#destroy', as: :logout
