class Post < ActiveRecord::Base
  attr_accessible :title, :content, :author,:user_id
  has_many :comments , :dependent => :delete_all
  has_and_belongs_to_many :categories
  belongs_to :user

  def all_categories
    Categories.find(:all, :order => 'name ASC')
  end

end
