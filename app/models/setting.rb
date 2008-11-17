require "digest/sha1"
require 'dm-validations'
class Setting
  include DataMapper::Resource
  attr_accessor :password, :password_confirmation
  property :id, Integer, :serial => true
  property :title, String, :length => 1..150
  property :subtitle, String, :length => 1..150
  property :header_background, String, :length => 3..6
  property :header_foreground, String, :length => 3..6

  def self.run_setup
    setting = Setting.new
    setting.title = "My Mixtape"
    setting.subtitle = "Is better than yours"
    setting.header_background = "99267F"
    setting.header_foreground = "000"
    setting.save
    setting
  end

  def header_bg_default
    header_background.blank? ? "99267F" : header_background
  end
  
  def header_fg_default
    header_foreground.blank? ? "000" : header_foreground
  end



end
