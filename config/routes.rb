Enc::Application.routes.draw do
  resources :nodes, :id => /[A-Za-z0-9\.]+?/, :format => /json|csv|xml|yaml/
  resources :reports do
    member do
      get 'parse'
    end
    collection do
      post 'upload'
    end
  end
end
