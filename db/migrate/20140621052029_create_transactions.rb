class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :transaction_type

      t.date :date
      t.integer :account_id
      t.integer :politician_id
      t.integer :donator_id
      t.integer :code_id

      t.integer :amount
      t.boolean :is_money
      t.string :address
      t.integer :page
      t.integer :row
      t.datetime :created_at
    end

    add_index :transactions, :date
    add_index :transactions, :account_id
    add_index :transactions, :politician_id
    add_index :transactions, :donator_id
    add_index :transactions, :code_id
  end
end
