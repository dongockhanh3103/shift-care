class CreatePlumberJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :plumber_jobs do |t|
      t.references :plumber
      t.references :job

      t.timestamps
    end
  end
end
