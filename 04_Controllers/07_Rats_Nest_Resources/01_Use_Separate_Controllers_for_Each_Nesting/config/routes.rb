resources :messages
resources :users do
  resources :messages, controller: 'users/messages'
end
