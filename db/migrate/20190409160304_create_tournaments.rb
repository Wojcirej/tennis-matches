class CreateTournaments < ActiveRecord::Migration[5.2]
  def change
    create_table :tournaments, id: :uuid do |t|
      t.string :name, null: false
      t.string :country, null: false
      t.string :city, null: false
      t.string :category, null: false
      t.string :tour, null: false

      t.timestamps
    end
  end
end
