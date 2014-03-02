jQuery ->
  $('.flip_back').click ->
    $(@).parents('.card').addClass('flipped')
  $('.flip_front').click ->
    $(@).parents('.card').removeClass('flipped')