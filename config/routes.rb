Enc::Application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  resources :nodes, :id => /[A-Za-z0-9\-\.]+?/, :format => /json|js|csv|xml|yaml/ do
    member do
      get 'facts'
      get 'resources'
      get 'status_history'
      get 'resource_times'
      get 'enable'
      get 'disable'
      get 'runonce'
    end
    collection do
      get 'unresponsive'
      get 'failed'
      get 'pending'
      get 'changed'
      get 'unchanged'
      get 'unreported'
      get 'sidebar'
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
      get 'report_history'
    end
  end
  resources :parameters, only: [:index, :new, :create]
  root :to => 'nodes#index'
end
