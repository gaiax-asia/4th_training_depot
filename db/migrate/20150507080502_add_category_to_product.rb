class AddCategoryToProduct < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.string :category
    end
  end
end
