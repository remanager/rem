$('.reveal-modal form').each (index, element) ->
  $(element)
    .attr('data-remote', true)
    .attr('action', $(element).attr('action') + '.json')
    .on('ajax:success', (evt, data, status, xhr) ->
      console.log data
      console.log xhr.responseText
    )
    .on('ajax:error', (evt, xhr, status, error) ->
      console.log xhr.responseText
      response = JSON.parse xhr.responseText
      console.log response
      console.log "category[#{key}] -> #{value[0]}" for key, value of response
      $('small.error').remove()
      $("#category_#{key}")
        .addClass('error')
        .after("<small class='error'>#{value[0]}</small>")
    )
