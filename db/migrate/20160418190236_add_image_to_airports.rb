class AddImageToAirports < ActiveRecord::Migration
  def change
    add_column :airports, :image, :string
  end
end
