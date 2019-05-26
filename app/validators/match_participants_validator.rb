class MatchParticipantsValidator < ActiveModel::Validator

  def validate(record)
    if record.home_player_id == record.away_player_id
      record.errors.add(:base, "Match participants must be different!")
      return false
    end
    return true
  end
end
