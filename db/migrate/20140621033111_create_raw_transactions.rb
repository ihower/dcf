# 交易日期,收支科目,捐贈者/支出對象,身份證/統一編,收入金額,支出金額,
# 金錢類,地址,原始文件頁碼,原始文件行號

class CreateRawTransactions < ActiveRecord::Migration
  def change
    create_table :raw_transactions do |t|
      t.string :account_name

      t.date :date
      t.string :code
      t.string :donator
      t.string :identification
      t.integer :income
      t.integer :payout
      t.string :is_money
      t.string :address
      t.integer :page
      t.integer :row

      t.datetime :created_at
    end
  end
end
