class AddAirportIdToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :airport_id, :integer
  end
end
