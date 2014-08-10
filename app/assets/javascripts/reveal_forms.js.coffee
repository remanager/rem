$('.reveal-modal form').each (index, element) ->
  $(element)
    .attr('data-remote', true)
    .on 'ajax:success', (e, data, status, xhr) ->
      console.log 'success'
      console.log data
      console.log xhr.responseText

    .on 'ajax:error', (e, xhr, status, error) ->
      console.log 'error'
      console.log xhr.responseText
      response = JSON.parse xhr.responseText
      console.log response
      console.log "category[#{key}] -> #{value[0]}" for key, value of response
      $('small.error').remove()
      $("#category_#{key}")
        .addClass('error')
        .after("<small class='error'>#{value[0]}</small>")

