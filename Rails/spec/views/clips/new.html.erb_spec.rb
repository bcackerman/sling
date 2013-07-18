require 'spec_helper'

describe "clips/new" do
  before(:each) do
    assign(:clip, stub_model(Clip,
      :name => "MyString",
      :file => "MyString",
      :shortlink => "MyString"
    ).as_new_record)
  end

  it "renders new clip form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", clips_path, "post" do
      assert_select "input#clip_name[name=?]", "clip[name]"
      assert_select "input#clip_file[name=?]", "clip[file]"
      assert_select "input#clip_shortlink[name=?]", "clip[shortlink]"
    end
  end
end
