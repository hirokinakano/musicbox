class ToppagesController < ApplicationController
  
  def index
    @artists = Artist.paginate(page: params[:page])
  end
  
end
