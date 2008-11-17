class User
  include DataMapper::Resource
  Merb::Authentication.user_class = self
  property :login, String
  property :id, Integer, :serial => true
  
  
end
