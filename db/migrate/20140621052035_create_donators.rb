class CreateDonators < ActiveRecord::Migration
  def change
    create_table :donators do |t|
      t.string :name
      t.string :identification
      t.datetime :created_at
    end

    add_index :donators, :name
    add_index :donators, :identification
  end
end
