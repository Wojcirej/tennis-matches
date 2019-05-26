class MatchResultPresenceValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    @record = record
    @attribute = attribute
    if value.blank?
      record.errors.add(attribute, format_message)
      return false
    end
    return true
  end

  private

  def format_message
    "#{humanized_score_set_content} for #{player_name} is missing."
  end

  def humanized_score_set_content
    splitted = @attribute.to_s.split("_")
    splitted.shift
    splitted.join(" ").humanize
  end

  def player_name
    @record.send("#{@attribute.to_s.split("_").first}_player").full_name
  end
end
