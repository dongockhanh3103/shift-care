class CreatePlumbers < ActiveRecord::Migration[6.1]
  def change
    create_table :plumbers do |t|
      t.string :name, null: false, default: ''
      t.string :address, default: ''
      t.timestamps
    end
  end
end
