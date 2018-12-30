class ArtistsController < ApplicationController
  before_action :logged_in_artist, only: [:edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user, only: [:destroy]
  
  def index
     @artists = Artist.paginate(page: params[:page]).search(params[:search])
  end

  def show
    @artist = Artist.find(params[:id])
    @posts = @artist.posts.paginate(page: params[:page])
  end

  def new
    @artist = Artist.new
  end
  
  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      flash[:success] = "新規登録に成功しました!"
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def edit
    logged_in_artist
    @artist = Artist.find(params[:id])
  end
  
  def update
    @artist = Artist.find(params[:id])
    if @artist.update_attributes(artist_params)
      flash[:success] = "Profile updated"
      redirect_to @artist 
    else
      render 'edit'
    end
  end
  
  def destroy
    Artist.find(params[:id]).destroy  
    flash[:success] = "User deleted"
    redirect_to artists_url
  end
  

  private
    # ストロングパラメーター
    def artist_params
      params.require(:artist).permit(:name, :email, :password,
                                     :password_confirmation, :content, :image)
    end

    # 正しいユーザーかどうかを確認 
    def correct_user
      @artist = Artist.find(params[:id])
      redirect_to(root_url) unless @artist == current_user
    end
   
    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end