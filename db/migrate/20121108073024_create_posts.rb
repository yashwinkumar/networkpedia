class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content
      t.string :author, :default => "anonymous"
      t.string :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
