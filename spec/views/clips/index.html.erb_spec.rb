require 'spec_helper'

describe "clips/index" do
  before(:each) do
    assign(:clips, [
      stub_model(Clip,
        :name => "Name",
        :file => "File",
        :shortlink => "Shortlink"
      ),
      stub_model(Clip,
        :name => "Name",
        :file => "File",
        :shortlink => "Shortlink"
      )
    ])
  end

  it "renders a list of clips" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "File".to_s, :count => 2
    assert_select "tr>td", :text => "Shortlink".to_s, :count => 2
  end
end
