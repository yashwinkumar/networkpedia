class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :name
      t.text   :text
      t.string :email
      t.integer :post_id
      t.timestamps
    end
  end

  def down
    drop_table :comments
  end
end
