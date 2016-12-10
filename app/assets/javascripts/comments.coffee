$(document).on "turbolinks:load", ->
  $('#comments-link').click (event) ->
    event.preventDefault()
    $('#comments-section').fadeToggle()
    $('#textarea1').focus()
