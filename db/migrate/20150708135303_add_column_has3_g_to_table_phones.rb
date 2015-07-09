class AddColumnHas3GToTablePhones < ActiveRecord::Migration
  def change
    add_column :phones, :has_3g, :boolean
  end
end
