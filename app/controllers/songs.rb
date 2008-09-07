class Songs < Application
  before :login_required, :only => [:create]
  # ...and remember, everything returned from an action
  # goes to the client...
  def index
    @songs = Song.all
    display @songs
  end
  
  def new
    render
  end
  
  def create
    # params[:song].inspect
    @song = Song.new(params[:song])
    if @song.save
      redirect "/admin"
    end
  end
  
  def delete
    @song = Song.get(params[:id])
    if  @song.destroy
      redirect "/admin"
    end
  end
  
end
