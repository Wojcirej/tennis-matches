class Web::BaseController < ApplicationController

  def index
    @players_count = Player.count
    @tournaments_count = Tournament.count
    @matches_count = Match.count
  end
end
