# admin.js.coffee

$ ->
  $('#property-add-icon').click ->
    $('.pictures-form').append $(window.picture_form)

window.admin =
  get_and_remove: (path, id) ->
    $.get path, () ->
      $("##{ id }").remove()
