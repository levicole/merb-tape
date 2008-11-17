module Merb
  module GlobalHelpers
    
    def logged_in?
      session.user.nil? ? false : true
    end
    
  end
end
