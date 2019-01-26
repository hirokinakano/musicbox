class SessionsController < ApplicationController

  def new
  end

  def create
    artist = Artist.find_by(email: params[:session][:email].downcase)
    if artist && artist.authenticate(params[:session][:password])
      log_in artist
      params[:session][:remember_me] == '1' ? remember(artist) : forget(artist)
      redirect_to artist
      flash[:notice] = 'Music Boxへようこそ!'
    else
      flash[:alert] = 'Emailまたはパスワードが間違っています!'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
    flash[:notice] = "ログアウトに成功しました!"
  end
end
