class CategoriesPosts < ActiveRecord::Base
  attr_accessible :post_id, :category_id
  belongs_to :posts
  belongs_to :categories
end
