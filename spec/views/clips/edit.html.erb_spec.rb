require 'spec_helper'

describe "clips/edit" do
  before(:each) do
    @clip = assign(:clip, stub_model(Clip,
      :name => "MyString",
      :file => "MyString",
      :shortlink => "MyString"
    ))
  end

  it "renders the edit clip form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", clip_path(@clip), "post" do
      assert_select "input#clip_name[name=?]", "clip[name]"
      assert_select "input#clip_file[name=?]", "clip[file]"
      assert_select "input#clip_shortlink[name=?]", "clip[shortlink]"
    end
  end
end
