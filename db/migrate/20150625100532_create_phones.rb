class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :name, null: false
      t.integer :diagonal, null: false
      t.integer :vendor_id, null: false
      t.timestamps
    end
  end
end
