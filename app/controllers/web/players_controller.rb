class Web::PlayersController < Web::BaseController

  def index
    @players = Paginator.call(Player.all, params[:page], params[:per_page])
  end

  def create
  end
end
