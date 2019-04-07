class Web::PlayersController < Web::BaseController
  before_action :set_player, only: :show

  def index
    @players = Paginator.call(Player.all, params[:page], params[:per_page])
  end

  def new
    @player = Player.new
  end

  def show
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      redirect_to web_player_path(@player), notice: "Player has been created successfully."
    else
      flash[:alert] = @player.errors.values.flatten.join("<br>").html_safe
      render :new
    end
  end

  private
  def player_params
    params.require(:player).permit(:first_name, :last_name, :date_of_birth,
      :country, :born, :sex)
  end

  def set_player
    @player = Player.find(params[:id])
  end
end
