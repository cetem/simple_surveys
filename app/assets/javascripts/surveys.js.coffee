new Rule
  condition: -> $('#c_surveys[data-action="new"], #c_surveys[data-action="create"]').length
  load: ->
    @map.cleanInputs ||= (e)->
      e.preventDefault()
      e.stopPropagation()

      $('input:not(select):not(:submit)').each ->
        $(this).val('')

    @map.toggleAnotherInstitution ||= ()->
      another_div = $('[data-another-institution]')
      console.log('cambio')
      if $(this).val() == 'other'
        EffectHelper.show(another_div)
        another_div.find('input').focus()
      else
        EffectHelper.hide another_div
    
    $(document).on 'click', 'a[data-clean-inputs]', @map.cleanInputs
    $(document).on 'change', '#survey_institution', @map.toggleAnotherInstitution

  unload: ->
    $(document).off 'click', 'a[data-clean-inputs]', @map.cleanInputs
    $(document).off 'change', '#survey_institution', @map.toggleAnotherInstitution

jQuery ($)->
  if $('#survey_institution').val() == 'other'
    EffectHelper.show($('[data-another-institution]'))
