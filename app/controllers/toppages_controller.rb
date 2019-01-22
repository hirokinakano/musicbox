class ToppagesController < ApplicationController

  def index
    @artists = Artist.paginate(page: params[:page])
    @artist = Artist.first
  end

  # 全アーティストの中からランダムに３ユーザーを選択する
  def randomArtist
    randomArtist = Artist.find(Artist.pluck(:id).shuffle[0..2])
  end

end
