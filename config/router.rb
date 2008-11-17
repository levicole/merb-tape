Merb.logger.info("Compiling routes...")
Merb::Router.prepare do
  # RESTful routes
  resources :settings, :collection => {:update_password => :get}
  resources :songs

  match('/').to(:controller => 'songs', :action =>'index').name(:root)
  match('/admin').to(:controller => 'settings', :action => 'index').name(:admin)
  slice(:merb_auth_slice_password, :name_prefix => nil, :path_prefix => "")

  default_routes
  
  # Change this for your home page to be available at /
  
end