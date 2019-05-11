module Matches
  module Facades
    class FormUtils

      attr_reader :match

      def initialize(match = Match.new)
        @match = match.persisted? ? Matches::Decorators::Details.new(match) : match
      end

      def players
        Player.all.collect { |player| [player.full_name, player.id] }
      end

      def tournaments
        Tournament.all.collect { |tournament| [tournament.name, tournament.id] }
      end

      def stages
        Tournaments::Enums::TournamentStages.to_h.collect { |key, value| [key.to_s.humanize, value] }
      end

      def seeds
        (1..32).to_a + ["LL", "WC", "PR", "Q"]
      end

      def date
        match.persisted? ? match.date : Date.today
      end

      def lead_text
        return nil unless match.persisted?
        match.summary_without_participants
      end
    end
  end
end
