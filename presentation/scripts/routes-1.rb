# Instead of
match "controller#action"

resources :users do
  match :action, on: :member, via: :post
end

# Use
get "controller#action"

resources :users do
  post :action, on: :member
end
