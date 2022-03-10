class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :following
      t.timestamps
    end
    add_index :accounts,[:user_id,:following],unique: true
  end
end
