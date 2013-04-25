class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :firstname
      t.string :lastname
      t.string :identification
      t.string :phone
      t.string :institution
      t.string :status_in_institution
      t.integer :travel_from
      t.integer :travel_to
      t.string :out_time, limit: 5

      t.timestamps
    end

    add_index :surveys, :travel_from
    add_index :surveys, :travel_to
    add_index :surveys, :out_time
    add_index :surveys, [:lastname, :identification], unique: true
  end
end
