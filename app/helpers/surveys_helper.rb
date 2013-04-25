module SurveysHelper

  def checkboxes_for_travel_days_in_survey(form)
    collection = []

    t('date.day_names')[1..5].each_with_index do |d, i|
      collection << [i+1, d]
    end
    
    form.collection_check_boxes :travel_days, collection, :first, :last, 
      item_wrapper_class: 'inline checkbox'
  end

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

  def show_travel_days(days)
    numbers = days.split('|').map(&:to_i)

    related_names = numbers.map { |n| t('date.day_names')[n] }

    related_names.join(' - ')
  end
end
