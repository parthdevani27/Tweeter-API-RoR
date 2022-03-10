class ChangejwtTableName < ActiveRecord::Migration[6.0]
  def change
    rename_table :jwt_denylists, :jwt_denylist
  end
end
