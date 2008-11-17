require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe Song do

  it "should move the file to public/songs"
  
  it "should chmod file 755"
  
  it "should set file_name from uploaded_data"
  
  it "should set file_size from uploaded_data"
  
  it "should strip filename" 
  
  it "should read id3 tags after save"
  
  it "should set name from id3 tags"
  
  it "should set length from id3 tags"

end