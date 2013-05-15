class TravelLine < ActiveRecord::Base
  has_paper_trail

  attr_accessible :travel_from, :travel_to, :rise_time, :line_days, :survey_id

  belongs_to :survey, inverse_of: :travel_lines

  def line_days
    travel_days.split('|') if travel_days
  end

  def line_days=(days)
    self.travel_days = days.compact.join('|') if days.present?
  end
end
