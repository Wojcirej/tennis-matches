module Matches
  module Decorators
    class Details < SimpleDelegator

      def initialize(match)
        @match = match
        super
      end

      def summary_without_participants
        "#{tournament.name} #{date.year} #{humanized_stage}"
      end

      def winner_player
        send("#{winner}_player")
      end

      def loser_player
        send("#{loser}_player")
      end

      def scoreline
        content = ""
        5.times do |index|
          next unless set_played?(index + 1)
          content += "#{send("#{winner}_set_#{index + 1}_score")}-#{send("#{loser}_set_#{index + 1}_score")}"
          if tie_break_contested?(index + 1)
            content += "(#{format_tiebreak_score(index + 1)}) "
          else
            content += " "
          end
        end
        content += "ret." if retirement
        return content.squish
      end

      private
      def winner
        set_winners.count(:home) > set_winners.count(:away) ? :home : :away
      end

      def loser
        set_winners.count(:home) > set_winners.count(:away) ? :away : :home
      end

      def set_winners
        winners = []
        5.downto(1) do |index|
          next unless set_played?(index)
          if send("home_set_#{index}_score") > send("away_set_#{index}_score")
            winners << :home
          else
            winners << :away
          end
        end
        return winners
      end

      def set_played?(set_number)
        send("home_set_#{set_number}_score").present? &&
        send("away_set_#{set_number}_score").present?
      end

      def tie_break_contested?(set_number)
        send("tiebreak_set_#{set_number}_score").present?
      end

      def format_tiebreak_score(set_number)
        send("tiebreak_set_#{set_number}_score").split("-").map(&:to_i).min
      end

      def humanized_stage
        Tournaments::Enums::TournamentStages.to_h.find { |key, value| value == stage }[0].to_s.humanize
      end
    end
  end
end
