class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches, id: :uuid do |t|
      t.uuid :home_player_id, null: false
      t.uuid :away_player_id, null: false
      t.uuid :tournament_id, foreign_key: true, null: false
      t.string :stage, null: false
      t.date :date, null: false
      t.string :home_seed
      t.string :away_seed
      t.integer :home_set_1_score
      t.integer :home_set_2_score
      t.integer :home_set_3_score
      t.integer :home_set_4_score
      t.integer :home_set_5_score
      t.integer :away_set_1_score
      t.integer :away_set_2_score
      t.integer :away_set_3_score
      t.integer :away_set_4_score
      t.integer :away_set_5_score
      t.string :tiebreak_set_1_score
      t.string :tiebreak_set_2_score
      t.string :tiebreak_set_3_score
      t.string :tiebreak_set_4_score
      t.string :tiebreak_set_5_score
      t.boolean :retirement, default: false

      t.timestamps
    end

    add_foreign_key :matches, :tournaments

    add_foreign_key :matches, :players, column: :home_player_id, primary_key: :id
    add_foreign_key :matches, :players, column: :away_player_id, primary_key: :id
  end
end
