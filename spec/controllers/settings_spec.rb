require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe Settings, "index action" do
  before(:each) do
    dispatch_to(Settings, :index)
  end
end