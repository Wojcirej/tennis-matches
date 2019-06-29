class Web::BaseController < ApplicationController
  include Web::CommonExceptionHandlers

  def index
    @players_count = Player.count
    @tournaments_count = Tournament.count
    @matches_count = Match.count
  end
end
