# encoding: UTF-8

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
    :status_in_institution, :email, :travel_lines_attributes,
    :another_institution

  attr_accessor :another_institution

  has_many :travel_lines, inverse_of: :survey

  validates :firstname, :lastname, :identification, :email, presence: true
  validates :identification, uniqueness: { scope: :lastname }
  validate :must_have_one_item
  validate :must_have_day_and_time_if_select_a_travel
  validate :must_have_institution

  before_create :assign_another_institution

  accepts_nested_attributes_for :travel_lines, allow_destroy: true,
    reject_if: ->(attrs) { attrs['travel_to'].blank? && attrs['travel_from'].blank? }

  def initialize(attributes = nil, options = {})
    super(attributes, options)
  end

  def must_have_one_item
    if self.travel_lines.reject(&:marked_for_destruction?).size < 1
      self.errors.add :base, :must_have_one_item
    end
  end

  def must_have_day_and_time_if_select_a_travel
    self.travel_lines.reject(&:marked_for_destruction?).each do |tl|

      if tl.travel_from && tl.travel_to
        tl.errors.add :rise_time, :blank if tl.rise_time.blank?
      end
    end
  end

  def assign_another_institution
    inst = self.institution

    if inst == 'other'
      self.institution = self.another_institution
    else
      self.institution = I18n.t("view.surveys.institutions_list.#{inst}")
    end
  end

  def must_have_institution
    if self.institution.blank? || 
      (self.institution == 'other' && self.another_institution.blank?)

      self.errors.add :institution, :blank
    end
  end
end
