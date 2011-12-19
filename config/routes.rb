Micro::Application.routes.draw do
  resources :contracts do
    get :sign, :on => :member
    post :invite, :on => :member
    post :auth, :on => :member
  end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'contracts#index'
  match "/signature" => 'signature#create_signature'
  match "/notify" => 'notify#add_email'

end