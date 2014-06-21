class CreateRawCashes < ActiveRecord::Migration
  def change
    create_table :raw_cashes do |t|
      t.integer :no
      t.integer :page
      t.integer :row
      t.date :txn_dt
      t.string :txn_code
      t.string :user_nm
      t.string :identification # id
      t.integer :receive_money
      t.integer :pay_money
      t.string :cash_ind
      t.string :area
      t.string :correct_rate
      t.string :correct_rate_imp
      t.string :file
      t.string :account
      t.string :position
      t.float :term

      t.datetime :created_at
    end
  end
end
