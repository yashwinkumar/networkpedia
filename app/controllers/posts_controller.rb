class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index_old.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])



    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    if user_signed_in?
      @post = Post.new
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @post }
      end
    else
      redirect_to posts_url, notice: "Login to create new post"
    end
  end

  # GET /posts/1/edit
  def edit
    if user_signed_in?  && current_user.id == Post.find(params[:id]).user_id.to_i
    @post = Post.find(params[:id])
    else
      redirect_to Post.find(params[:id]), alert: "Your are not authorized to edit this post"
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @post.user_id = current_user.id
    checked_categories = params[:categories].collect{|cid| Category.find_by_id(cid.to_i)}
    removed_categories = Category.all - checked_categories
    respond_to do |format|
      if @post.save
        checked_categories.each{|cat| @post.categories << cat if !@post.categories.include?(cat)}
        removed_categories.each{|cat| @post.categories.delete(cat) if @post.categories.include?(cat)}
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    checked_categories = params[:categories].collect{|cid| Category.find_by_id(cid.to_i)}
    removed_categories = Category.all - checked_categories

    respond_to do |format|
      if @post.update_attributes(params[:post])
        checked_categories.each{|cat| @post.categories << cat if !@post.categories.include?(cat)}
        removed_categories.each{|cat| @post.categories.delete(cat) if @post.categories.include?(cat)}
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    if user_signed_in?
      @post.destroy
      @post.comments.destroy
      flash[:notice] = "Post Deleted"
      respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
    else
      redirect_to @post, notice: "You cannot delete the post"
    end
  end
end
