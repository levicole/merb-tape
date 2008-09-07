require 'dm-validations'
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
  
  before :create, :set_attributes_by_id3tags
  after :create, :move_file
  after :destroy, :delete_file
  attr_accessor :tempfile_path, :id3_tags
  
  class << self
    def file_location
      @@file_location
    end
    
    def file_location=(file_location)
      @@file_location = file_location
    end
  end
  
  self.file_location = "#{Merb.root}/public/songs/"
  
  def uploaded_data=(uploaded_data)
    self.tempfile_path = uploaded_data[:tempfile].path
    self.file_size = uploaded_data[:size]
    self.file_name = uploaded_data[:filename]
    self.content_type = uploaded_data[:content_type]
    self.id3_tags = read_id3_tags
  end

  def read_id3_tags
    Mp3Info.open(self.tempfile_path)
  end
  
  def public_filename
    self.class.file_location + self.file_name
  end
  
  def title_and_artist
    "#{self.title} - #{self.artist}"
  end
  
  private
  
  def move_file
    FileUtils.mv self.tempfile_path, self.class.file_location + "#{self.file_name}"
    FileUtils.chmod 0755, "#{self.class.file_location}#{self.file_name}"
  end
  
  def delete_file
    FileUtils.rm("#{self.class.file_location}#{self.file_name}")
  end
  
  def set_attributes_by_id3tags
    self.title = self.id3_tags.tag.title
    self.length = set_song_length(self.id3_tags.length)
    self.artist = self.id3_tags.tag.artist.nil? ?  self.id3_tags.tag2.TP1 :  self.id3_tags.tag.artist
    self.album = self.id3_tags.tag.album
  end
  
  def set_song_length(length)
    "#{(length/60).round}:#{(length % 60).round}"
  end
  
end
