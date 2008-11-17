class Settings < Application
  before :ensure_authenticated
  # ...and remember, everything returned from an action
  # goes to the client...

  def new
    @setting = Setting.new
    @user = User.new
    render
  end
  
  def create
    @setting = Setting.new(params[:setting])
    if @setting.save
      redirect url(:root)
    end 
  end
  
  def update
    @setting = Setting.get(params[:id])
    if @setting.update_attributes(params[:setting])
      redirect url(:root)
    end
  end
  
  def update_user
    
  end
  
end