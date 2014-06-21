class CreatePoliticians < ActiveRecord::Migration
  def change
    create_table :politicians do |t|
      t.string :name
      t.datetime :created_at
    end

    add_index :politicians, :name
  end
end
