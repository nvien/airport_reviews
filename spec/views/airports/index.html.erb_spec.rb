require 'rails_helper'

RSpec.describe "airports/index", type: :view do
  before(:each) do
    assign(:airports, [
      Airport.create!(
        :name => "Name",
        :city => "City",
        :IATA => "Iata"
      ),
      Airport.create!(
        :name => "Name",
        :city => "City",
        :IATA => "Iata"
      )
    ])
  end

  it "renders a list of airports" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "Iata".to_s, :count => 2
  end
end
