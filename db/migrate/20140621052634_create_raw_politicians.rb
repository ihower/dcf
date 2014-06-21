class CreateRawPoliticians < ActiveRecord::Migration
  def change
    create_table :raw_politicians do |t|
      t.string :account_name
      t.string :politician_name
      t.string :bank_name
      t.string :bank_account
      t.string :bank_address
      t.string :date1
      t.string :date2
      t.datetime :created_at
    end

    add_index :raw_politicians, :account_name
  end
end
