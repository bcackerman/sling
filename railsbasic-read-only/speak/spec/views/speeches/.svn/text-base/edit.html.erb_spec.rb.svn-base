require 'spec_helper'

describe "speeches/edit" do
  before(:each) do
    @speech = assign(:speech, stub_model(Speech))
  end

  it "renders the edit speech form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => speeches_path(@speech), :method => "post" do
    end
  end
end
