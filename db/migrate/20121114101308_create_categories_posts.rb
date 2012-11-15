class CreateCategoriesPosts < ActiveRecord::Migration
  def change
    create_table :categories_posts, :id => false do |t|
      t.integer :category_id, :null => false
      t.integer :post_id, :null => false
      t.timestamps :datetime, :null => true
    end
  end

  def down
    drop_table :categories_posts
  end
end

