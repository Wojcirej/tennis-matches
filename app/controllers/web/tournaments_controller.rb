class Web::TournamentsController < ApplicationController
  before_action :set_tournament, only: [:show, :edit, :update, :destroy]

  def index
    @tournaments = Paginator.call(Tournament.all, params[:page], params[:per_page])
    respond_to do |format|
      format.html
      format.csv do
         send_data(
           Tournaments::Export.call(Paginator.call(Tournament.all, params[:page], params[:per_page])),
           filename: "tournaments-#{Date.today}.csv")
      end
    end
  end

  def atp
    @tournaments = Paginator.call(Tournament.atp_tournaments, params[:page], params[:per_page])
  end

  def wta
    @tournaments = Paginator.call(Tournament.wta_tournaments, params[:page], params[:per_page])
  end

  def itf
    @tournaments = Paginator.call(Tournament.itf_tournaments, params[:page], params[:per_page])
  end

  def new
    @form_utils = Tournaments::Facades::FormUtils.new(params[:tour])
  end

  def create
    @form_utils = Tournaments::Facades::FormUtils.new(tournament_params[:tour])
    @tournament = Tournament.new(tournament_params)
    if @tournament.save
      redirect_to @tournament, notice: 'Tournament was successfully created.'
    else
      flash[:alert] = @tournament.errors.values.flatten.join("<br>").html_safe
      render :new
    end
  end

  def edit
    @form_utils = Tournaments::Facades::FormUtils.new(@tournament.tour, @tournament)
  end

  def update
    @form_utils = Tournaments::Facades::FormUtils.new(@tournament.tour, @tournament)
    if @tournament.update(tournament_params)
      redirect_to @tournament, notice: 'Tournament was successfully updated.'
    else
      flash[:alert] = @tournament.errors.values.flatten.join("<br>").html_safe
      render :edit
    end
  end

  def destroy
    @tournament.destroy
    redirect_to send("#{@tournament.tour.downcase}_tournaments_url"), notice: "Tournament #{@tournament.name} has been deleted."
  end

  private
  def set_tournament
    @tournament = Tournament.find(params[:id])
  end

  def tournament_params
    params.require(:tournament).permit(:name, :country, :city, :category, :tour)
  end
end
