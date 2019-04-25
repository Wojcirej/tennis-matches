class Web::TournamentsController < ApplicationController
  before_action :set_tournament, only: [:show, :edit, :update, :destroy]
  before_action :set_form_data, only: [:new, :edit]

  def index
    @tournaments = Paginator.call(Tournament.all, params[:page], params[:per_page])
  end

  def atp
    @atp_tournaments = Paginator.call(Tournament.atp_tournaments, params[:page], params[:per_page])
  end

  def wta
    @wta_tournaments = Paginator.call(Tournament.wta_tournaments, params[:page], params[:per_page])
  end

  def itf
    @itf_tournaments = Paginator.call(Tournament.itf_tournaments, params[:page], params[:per_page])
  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(tournament_params)
    if @tournament.save
      redirect_to @tournament, notice: 'Tournament was successfully created.'
    else
      flash[:alert] = @tournament.errors.values.flatten.join("<br>").html_safe
      render :new
    end
  end

  def update
    if @tournament.update(tournament_params)
      redirect_to @tournament, notice: 'Tournament was successfully updated.'
    else
      flash[:alert] = @tournament.errors.values.flatten.join("<br>").html_safe
      render :edit
    end
  end

  def destroy
    @tournament.destroy
    redirect_to tournaments_url, notice: 'Tournament was successfully destroyed.'
  end

  private
  def set_tournament
    @tournament = Tournament.find(params[:id])
  end

  def set_form_data
    @tour = params[:tour]
    @categories = "Enums::#{@tour.humanize}TournamentCategories".constantize
  end

  def tournament_params
    params.require(:tournament).permit(:name, :country, :city, :category, :tour)
  end
end
