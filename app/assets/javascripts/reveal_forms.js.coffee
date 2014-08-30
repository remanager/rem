$('.reveal-modal form').each (index, element) ->
  $(element)
    .attr('data-remote', true)
    .on 'ajax:success', (e, data, status, xhr) ->
      $('#category-modal small').remove()
      $("#category_name").removeClass('error')
      $('#category-modal').foundation('reveal', 'close')

    .on 'ajax:error', (e, xhr, status, error) ->
      response = JSON.parse xhr.responseText
      console.log "category[#{key}] -> #{value[0]}" for key, value of response
      $('small.error').remove()
      $('#category-modal small').remove()
      $("#category_name").addClass('error')
        .after("<small class='error'>#{value[0]}</small>")
