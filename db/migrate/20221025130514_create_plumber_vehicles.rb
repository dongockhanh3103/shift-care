class CreatePlumberVehicles < ActiveRecord::Migration[6.1]
  def change
    create_table :plumber_vehicles do |t|
      t.references :plumber
      t.references :vehicle

      t.timestamps
    end
  end
end
