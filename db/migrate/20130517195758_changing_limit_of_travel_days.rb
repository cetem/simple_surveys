class ChangingLimitOfTravelDays < ActiveRecord::Migration
  def change
    change_column :travel_lines, :travel_days, :string
  end
end
