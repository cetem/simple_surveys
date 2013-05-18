Fabricator(:travel_line) do
  travel_from   { Survey::STATIONS.keys.sample }
  travel_to     { Survey::STATIONS.keys.sample }
  rise_time     { [[21, 22, 23, 00].sample, [20, 40, 00].sample].join(':') }
  travel_days   { I18n.t('date.day_names').sample }
  survey_id     { Fabricate(:survey).id }
end
