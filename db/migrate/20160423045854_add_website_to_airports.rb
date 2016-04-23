class AddWebsiteToAirports < ActiveRecord::Migration
  def change
    add_column :airports, :website, :string
  end
end
