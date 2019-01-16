class SessionsController < ApplicationController

  def new
  end

  def create
    artist = Artist.find_by(email: params[:session][:email].downcase)
    if artist && artist.authenticate(params[:session][:password])
      log_in artist
      remember artist
      redirect_to artist
      flash.now[:notice] = 'Music Boxへようこそ!'
    else
      flash.now[:alert] = 'Emailまたはパスワードが間違っています!'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
