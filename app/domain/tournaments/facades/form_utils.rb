module Tournaments
  module Facades
    class FormUtils

      attr_reader :tour, :tournament

      def initialize(tour, tournament = Tournament.new)
        @tour = tour
        @tournament = tournament
      end

      def tournament_categories
        "Tournaments::Enums::#{tour.humanize}TournamentCategories".constantize.values
      end
    end
  end
end
