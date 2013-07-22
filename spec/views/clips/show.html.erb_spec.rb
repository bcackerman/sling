require 'spec_helper'

describe "clips/show" do
  before(:each) do
    @clip = assign(:clip, stub_model(Clip,
      :name => "Name",
      :file => "File",
      :shortlink => "Shortlink"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/File/)
    rendered.should match(/Shortlink/)
  end
end
