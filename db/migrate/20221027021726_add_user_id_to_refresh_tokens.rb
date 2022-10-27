class AddUserIdToRefreshTokens < ActiveRecord::Migration[6.1]
  def up
    remove_column :refresh_tokens, :admin_id
    add_reference :refresh_tokens, :user, index: true, foreign_key: true
  end

  def down
    remove_column :refresh_tokens, :user_id
  end
end
