class Player < ApplicationRecord
  validates :first_name, presence: { message: "Please specify player's first name." }
  validates :last_name, presence: { message: "Please specify player's last name." }
  validates :country, presence: { message: "Please specify player's nationality." }
  validates :sex, presence: { message: "Please specify player's sex." }
  validates_inclusion_of :sex, in: ["female", "male"]

  default_scope -> { order("created_at ASC") }

  def age
    ((Time.current - date_of_birth.to_time) / 1.year.seconds).floor
  end
end
