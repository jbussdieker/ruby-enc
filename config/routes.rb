Enc::Application.routes.draw do
  resources :nodes, :id => /[A-Za-z0-9\-\.]+?/, :format => /json|csv|xml|yaml/ do
    member do
      get 'facts'
    end
    collection do
      get 'unresponsive'
      get 'failed'
      get 'pending'
      get 'changed'
      get 'unchanged'
      get 'unreported'
    end
  end
  resources :node_groups
  resources :node_classes
  resources :reports do
    member do
      get 'parse'
    end
    collection do
      post 'upload'
    end
  end
  root :to => 'nodes#index'
end
