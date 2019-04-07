class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players, id: :uuid do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :country, null: false
      t.date :date_of_birth
      t.string :born
      t.string :sex, null: false

      t.timestamps
    end
  end
end
