class Web::MatchesController < Web::BaseController
  before_action :set_match, only: [:show, :update, :destroy]

  def index
    @matches = Paginator.call(Match.all, params[:page], params[:per_page])
    respond_to do |format|
      format.html
      format.csv do
         send_data(
           Matches::Export.call(Paginator.call(Match.all, params[:page], params[:per_page])),
           filename: "matches-#{Date.today}.csv")
      end
    end
  end

  def show
    @match = Matches::Decorators::Details.new(@match)
  end

  def new
    @form_utils = Matches::Facades::FormUtils.new
  end

  def create
    @form_utils = Matches::Facades::FormUtils.new
    @match = Match.new(match_params)
    if @match.save
      redirect_to @match, notice: 'Match was successfully created.'
    else
      flash[:alert] = @match.errors.values.flatten.join("<br>").html_safe
      render :new
    end
  end

  def edit
    @form_utils = Matches::Facades::FormUtils.new(Match.find(params[:id]))
  end

  def update
    @form_utils = Matches::Facades::FormUtils.new(Match.find(params[:id]))
    if @match.update(match_params)
      redirect_to @match, notice: 'Match was successfully updated.'
    else
      flash[:alert] = @match.errors.values.flatten.join("<br>").html_safe
      render :edit
    end
  end

  def destroy
    @match.destroy
    redirect_to matches_url, notice: 'Match has been deleted.'
  end

  private
  def set_match
    @match = Match.find(params[:id])
  end

  def match_params
    params.require(:match).permit(:home_player_id, :away_player_id,
      :tournament_id, :stage, :date, :home_seed, :away_seed, :home_set_1_score,
      :home_set_2_score, :home_set_3_score, :home_set_4_score, :home_set_5_score,
      :away_set_1_score, :away_set_2_score, :away_set_3_score, :away_set_4_score,
      :away_set_5_score, :tiebreak_set_1_score, :tiebreak_set_2_score,
      :tiebreak_set_3_score, :tiebreak_set_4_score, :tiebreak_set_5_score,
      :retirement)
  end
end
