jQuery ->
  $('.flip_back').click ->
    $(@).parents('.card').addClass('flipped')
  $('.flip_front').click ->
    $(@).parents('.card').removeClass('flipped')


  $('#max-date-trigger').click ->
  	$('#max-date').html('
  		<input id="artobject_maxyear" name="artobject[maxyear]" placeholder="Year" type="text">
  		<div class="checkbox">
  			<label>
  				<input id="max_bce" name="max_bce" type="checkbox">
  				BCE
  			</label>
  		</div>')