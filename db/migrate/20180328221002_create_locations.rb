class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.st_point :location_lonlat, using: :gist
      t.string :location_address

      t.timestamps
    end

    add_index :locations, :location_lonlat, using: :gist
  end
end
