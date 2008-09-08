class MerbAuth::Users < MerbAuth::Application
  before :get_settings
  before :login_required_unless_no_users
  
  
  private
  def login_required_unless_no_users
    unless User.first.nil? && current_user
      redirect "/"
    end
  end
  
end