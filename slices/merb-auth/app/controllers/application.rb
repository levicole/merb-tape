module MerbAuth
  class Application < Merb::Controller

    controller_for_slice
    
    def get_settings
      @setting = Setting.first
    end
  
  end
end