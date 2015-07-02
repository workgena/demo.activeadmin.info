class AddColumnManufacturedAtToPhones < ActiveRecord::Migration
  def change
    add_column :phones, :manufactured_at, :datetime
  end
end
