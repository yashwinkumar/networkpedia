class Comment < ActiveRecord::Base
  attr_accessible :text, :name, :post_id
  belongs_to :post
  validates :name, :presence => true
  validates :text, :presence => true
  end
