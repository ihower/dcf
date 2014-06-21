class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.integer :politician_id
      t.datetime :created_at
    end

    add_index :accounts, :politician_id
  end
end
