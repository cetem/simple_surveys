new Rule
  condition: -> $('#c_surveys[data-action="new"]').length
  load: ->
    @map.cleanInputs ||= (e)->
      e.preventDefault()
      e.stopPropagation()

      $('input:not(select):not(:submit)').each ->
        $(this).val('')
    
    @map.updateHiTitle ||= -> $('#hi-title').text $(this).val()

    $(document).on 'click', 'a[data-clean-inputs]', @map.cleanInputs
    $(document).on 'keyup', '#survey_firstname', @map.updateHiTitle

  unload: ->
    $(document).off 'click', 'a[data-clean-inputs]', @map.cleanInputs
    $(document).off 'keyup', '#survey_firstname', @map.updateHiTitle
