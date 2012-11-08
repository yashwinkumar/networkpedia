class Post < ActiveRecord::Base
  attr_accessible :title, :content, :author
  @posts = Post.all
end
