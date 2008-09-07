Merb.logger.info("Compiling routes...")
Merb::Router.prepare do |r|
  # RESTful routes
  r.resources :settings
  r.resources :songs
  r.match('/').to(:controller => 'songs', :action =>'index').name(:root)
  r.match('/admin').to(:controller => 'settings', :action => 'index').name(:admin)


  r.add_slice(:MerbAuth, :path => "", :default_routes => false)
  
  r.default_routes
  
  # Change this for your home page to be available at /
  
end