namespace :admin do
  resources :users do
    resource :passwords
    resource :activations
  end
end
