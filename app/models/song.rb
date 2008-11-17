class Song
  include DataMapper::Resource
  property :id, Integer, :serial => true
  property :title, String
  property :artist, String
  property :length, String
  property :album, String
  property :file_name, String
  property :file_size, String
  property :content_type, String
  
  validates_with_method :check_for_upload
  
  before :create, :set_attributes_by_id3tags
  after :create, :move_file
  after :destroy, :delete_file
  attr_accessor :tempfile_path, :id3_tags
  attr_reader :attachment
  
  class << self
    def file_location
      @@file_location
    end
    
    def file_location=(file_location)
      @@file_location = file_location
    end
  end
  
  self.file_location = "#{Merb.root}/public/songs/"
  
  def attachment=(song_data)
    @attachment = song_data
    return nil if @attachment.blank?
    self.tempfile_path = @attachment[:tempfile].path
    self.file_size = @attachment[:size]
    self.file_name = @attachment[:filename]
    self.content_type = @attachment[:content_type]
    self.id3_tags = read_id3_tags
  end

  def read_id3_tags
    Mp3Info.open(tempfile_path)
  end
  
  def public_filename
    self.class.file_location + self.file_name
  end
  
  def title_and_artist
    "#{title} - #{artist}"
  end
  
  private
  
  def check_for_upload
    if self.attachment.blank?
      [false, "Hey!  How about you upload a REAL file?"]
    else
      true
    end
  end
  
  def delete_file
    FileUtils.rm("#{self.class.file_location}#{self.file_name}")
  end
  
  def move_file
    FileUtils.mv self.tempfile_path, self.class.file_location + "#{self.file_name}"
    FileUtils.chmod 0755, "#{self.class.file_location}#{self.file_name}"
  end
  
  def set_attributes_by_id3tags
    unless self.id3_tags.nil?
      self.title = self.id3_tags.tag.title
      self.length = set_song_length(self.id3_tags.length)
      self.artist = self.id3_tags.tag.artist.nil? ?  self.id3_tags.tag2.TP1 :  self.id3_tags.tag.artist
      self.album = self.id3_tags.tag.album
    end
  end
  
  def set_song_length(length)
    "#{(length/60).round}:#{(length % 60).round}"
  end
  
end
