class Survey < ActiveRecord::Base
  has_paper_trail

  STATIONS = {
    1 => 'Estación Mendoza',
    2 => 'Parador Belgrano',
    3 => 'Parador Pedro Molina',
    4 => 'Parador 25 de Mayo',
    5 => 'Parador Pellegrini',
    6 => 'Parador San Martín',
    7 => 'Estación Godoy Cruz',
    8 => 'Parador Progreso',
    9 => 'Parador Independencia',
    10 => 'Parador 9 de Julio',
    11 => 'Estación Luzuriaga',
    12 => 'Parador Piedra Buena',
    13 => 'Parador Alta Italia',
    14 => 'Parador Maza',
    15 => 'Estación Gutiérrez'
  }.with_indifferent_access.freeze

  attr_accessible :firstname, :lastname, :identification, :phone, :institution,
    :status_in_institution, :email, :travel_lines_attributes

  has_many :travel_lines, inverse_of: :survey

  validates :firstname, :lastname, :identification, :email, presence: true
  validates :identification, uniqueness: { scope: :lastname }

  before_save :assign_days_values

  accepts_nested_attributes_for :travel_lines, allow_destroy: true,
    reject_if: ->(attrs) { attrs['travel_to'].blank? && attrs['travel_from'].blank? }

  def initialize(attributes = nil, options = {})
    super(attributes, options)

  end

  def assign_days_values
    self.travel_lines.each do |tl|
      if tl.travel_days.try(:any?)
        tl.travel_days = tl.travel_days.compact.delete_if { |d| d.blank? }.join('|')
      end
    end
  end
end
