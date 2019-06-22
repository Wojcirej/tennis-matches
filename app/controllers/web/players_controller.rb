class Web::PlayersController < Web::BaseController
  before_action :set_player, except: [:index, :new, :create]

  def index
    @players = Paginator.call(Player.all, params[:page], params[:per_page])
    respond_to do |format|
      format.html
      format.csv do
         send_data(
           Players::Export.call(Paginator.call(Player.all, params[:page], params[:per_page])),
           filename: "players-#{Date.today}.csv")
      end
    end
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      redirect_to player_path(@player), notice: "Player has been created successfully."
    else
      flash[:alert] = @player.errors.values.flatten.join("<br>").html_safe
      render :new
    end
  end

  def update
    if @player.update(player_params)
      redirect_to player_path(@player), notice: "Player has been updated successfully."
    else
      flash[:alert] = @player.errors.values.flatten.join("<br>").html_safe
      render :edit
    end
  end

  def destroy
    @player.destroy
    redirect_to players_path, notice: "Player #{@player.full_name} has been deleted."
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
