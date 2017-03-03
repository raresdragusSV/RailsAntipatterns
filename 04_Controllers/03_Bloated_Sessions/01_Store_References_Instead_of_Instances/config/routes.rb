resources :orders do
  collection do
    post :shipping
    post :billing
    post :payment
  end
end
