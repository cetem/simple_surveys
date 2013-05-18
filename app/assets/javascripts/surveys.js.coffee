new Rule
  condition: -> $('#c_surveys[data-action="new"]').length
  load: ->
    @map.cleanInputs ||= (e)->
      e.preventDefault()
      e.stopPropagation()

      $('input:not(select):not(:submit)').each ->
        $(this).val('')
    
    $(document).on 'click', 'a[data-clean-inputs]', @map.cleanInputs

  unload: ->
    $(document).off 'click', 'a[data-clean-inputs]', @map.cleanInputs
