class Application < Merb::Controller
  before :get_settings
  
  protected
  
  def get_settings
    @setting = Setting.first
    if @setting.nil? && User.all.blank?
      @setting = Setting.run_setup
      redirect url(:new_user)
    end
  end
  
end