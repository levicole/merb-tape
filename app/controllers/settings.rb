class Settings < Application
  before :login_required
  # ...and remember, everything returned from an action
  # goes to the client...
  def index
    @songs = Song.all
    render
  end
  
  def new
    @setting = Setting.new
    @user = User.new
    render
  end
  
  def create
    @setting = Setting.new(params[:setting])
    if @setting.save
      redirect url('/admin')
    end 
  end
  
  def update
    @setting = Setting.get(params[:id])
    if @setting.update_attributes(params[:setting])
      redirect url(:admin)
    end
  end
  
  def login
    if request.method == :post
      
    else
      "false"
    end
  end
  
end