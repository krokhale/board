class JobsController < ApplicationController
  
  
  def index
    @link = Gchart.line(:data => [300, 100, 30, 200, 100, 200, 300, 10], :size => "300x170" )
    @posts = Post.all.reverse.paginate :page => params[:page], :per_page => 10, :order => 'created_at DESC'
    @posts_today = Post.where(:created_at => (Time.now.midnight - 1.day)..Time.now).count
  end
  
end