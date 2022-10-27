class CreateClients < ActiveRecord::Migration[6.1]
  def change
    create_table :clients do |t|
      t.string :name, null: false, default: ''
      t.integer :age
      t.text :private_note, default: ''
      t.string :address, default: ''

      t.timestamps
    end
  end
end
