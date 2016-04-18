require 'rails_helper'

RSpec.describe "airports/new", type: :view do
  before(:each) do
    assign(:airport, Airport.new(
      :name => "MyString",
      :city => "MyString",
      :IATA => "MyString"
    ))
  end

  it "renders new airport form" do
    render

    assert_select "form[action=?][method=?]", airports_path, "post" do

      assert_select "input#airport_name[name=?]", "airport[name]"

      assert_select "input#airport_city[name=?]", "airport[city]"

      assert_select "input#airport_IATA[name=?]", "airport[IATA]"
    end
  end
end
