class RemoveSomeFieldsFromSurveys < ActiveRecord::Migration
  def change
    remove_column :surveys, :out_time
    remove_column :surveys, :travel_from
    remove_column :surveys, :travel_to
  end
end

