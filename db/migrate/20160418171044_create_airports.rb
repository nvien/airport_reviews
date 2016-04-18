class CreateAirports < ActiveRecord::Migration
  def change
    create_table :airports do |t|
      t.string :name
      t.string :city
      t.string :IATA

      t.timestamps null: false
    end
  end
end
