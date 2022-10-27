class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.references :client
      t.string :state, default: 'open'
      t.datetime :entry_time
      t.datetime :start_at
      t.datetime :assigned_at
      t.datetime :finish_at
  
      t.timestamps
    end
  end
end
