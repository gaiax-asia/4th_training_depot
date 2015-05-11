class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name

      t.timestamps null: false
    end
    
    change_table :products do |t|
      t.integer :category_id
    end
    
    add_index :products, :category_id
  end
end
