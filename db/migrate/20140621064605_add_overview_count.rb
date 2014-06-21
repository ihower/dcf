class AddOverviewCount < ActiveRecord::Migration

  def change
    add_column :politicians, :transactions_count, :integer
    add_column :politicians, :income_amount, :integer
    add_column :politicians, :payout_amount, :integer

    add_column :accounts, :transactions_count, :integer
    add_column :accounts, :income_amount, :integer
    add_column :accounts, :payout_amount, :integer

    add_column :donators, :transactions_count, :integer
    add_column :donators, :income_amount, :integer
    add_column :donators, :payout_amount, :integer
  end

end
