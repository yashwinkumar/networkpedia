class Category < ActiveRecord::Base
  attr_accessible :name, :short_name, :description
  has_and_belongs_to_many :posts
end
