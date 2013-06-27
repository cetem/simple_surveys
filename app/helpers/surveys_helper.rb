module SurveysHelper

  def select_stations_for_travel_line(form, field)
    collection = Survey::STATIONS.map { |k, v| [v, k] }

    form.input field, collection: collection, include_blank: true, label: false,
      input_html: { class: 'span12' }
  end

  def select_rise_time_with_interval(form)
    collection = []

    [21, 22, 23, 00].each do |h|
      [20, 40, 00].each do |i| 
        hour = i == 00 ? (h + 1) : h
        hour = 0 if hour == 24

        collection << ["#{'%02d' % hour}:#{'%02d' % i}"]
      end
    end

    form.input :rise_time, collection: collection, 
      label: t('view.surveys.wait_time'), label_html: { class: 'span6' },
      input_html: { class: 'span5' }
  end

  def show_station_by_key(key)
    Survey::STATIONS[key]
  end

  def return_id_for_travel_line(tl, i, worked_days)
    @used_days ||= []

    id = if tl.object.try(:travel_days)
      tl.object.travel_days
    else
      (
        t('date.day_names') + [worked_days]- @used_days.map(&:downcase)
      ).first.camelize
    end

    @used_days << id

    id
  end

  def institutions_select_for_survey(form)
    collection = t('view.surveys.institutions_list').invert.map(&:to_a)

    form.input :institution, collection: collection, include_blank: true,
      required: true, input_html: { class: 'span11' }
  end
end
