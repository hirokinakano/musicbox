class PostsController < ApplicationController
  before_action :logged_in_artist, only:[:create, :destroy]
  before_action :correct_user, only:[:destroy]
  
  def new 
    @post = current_user.posts.build
  end
  
  def create 
    @post = current_user.posts.build(post_params)
    @artist = current_user
    if @post.save
      flash[:success] = "投稿に成功しました!"
      redirect_to @artist
    else
      @feed_items = []  
      render 'toppages/index'
    end
  end
  
  def destroy
    @post.destroy
    flash[:success] = "Post deleted"
    redirect_to request.referrer || root_url
  end
  
  private
    def post_params
      params.require(:post).permit(:content, :picture, :music, :title)
    end
    
    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end
