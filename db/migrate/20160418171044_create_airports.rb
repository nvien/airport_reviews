class CreateAirports < ActiveRecord::Migration
  def change
    create_table :airports do |t|
      t.string :name, null: false
      t.string :city, null: false
      t.string :IATA, null: false

      t.timestamps null: false
    end
  end
end
