class TravelLine < ActiveRecord::Base
  has_paper_trail

  attr_accessible :travel_from, :travel_to, :rise_time, :travel_days, :survey_id

  validates :travel_days, presence: true

  belongs_to :survey, inverse_of: :travel_lines
end
