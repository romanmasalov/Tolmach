ActionController::Routing::Routes.draw do |map|
  
  map.filter 'locale'

  map.resources :messages
  map.resources :translations, :collection => {:switch_language => :get}

  map.root :controller => 'messages', :action => 'index'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
