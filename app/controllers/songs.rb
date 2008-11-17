class Songs < Application
  before :ensure_authenticated, :only => [:create]
  # ...and remember, everything returned from an action
  # goes to the client...
  def index
    @songs = Song.all
    display @songs
  end
  
  def new
    @song = Song.new
    render
  end
  
  def create(song)
    # song[:attachment].inspect
    @song = Song.new(song)
    if @song.save
      redirect "/admin"
    else
      @songs = Song.all
      render :new, :template => "settings/index"
    end
  end
  
  def delete(id)
    @song = Song.get(id)
    if  @song.destroy
      redirect "/admin"
    end
  end
  
  def update(id)
    @song = Song.get(id)
    if @song.update_attributes[params[:song]]
      redirect "/admin"
    else
      render :index
    end
  end
  
end
