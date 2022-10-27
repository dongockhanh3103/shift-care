class CreateRefreshTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :refresh_tokens do |t|
      t.references :admin
      t.string :crypted_token
      t.string :token

      t.timestamps
    end
  end
end
