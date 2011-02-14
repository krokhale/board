class JobsController < ApplicationController
  
  
  def index
    @posts = Post.all
  end
  
end