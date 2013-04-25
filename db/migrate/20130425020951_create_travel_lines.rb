class CreateTravelLines < ActiveRecord::Migration
  def change
    create_table :travel_lines do |t|
      t.integer :travel_from, null: false
      t.integer :travel_to, null: false
      t.string :rise_time, limit: 5, null: false
      t.string :travel_days, limit: 9, null: false
      t.integer :survey_id, null: false

      t.timestamps
    end

    add_index :travel_lines, :survey_id
  end
end
