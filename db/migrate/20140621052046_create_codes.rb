class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.string :name
      t.datetime :created_at
    end

    add_index :codes, :name
  end
end
