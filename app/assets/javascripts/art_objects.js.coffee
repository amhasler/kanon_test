jQuery ->
  $('.flip_back').click ->
    $(@).parents('.card').addClass('flipped')
  $('.flip_front').click ->
    $(@).parents('.card').removeClass('flipped')


  $('#max-date-trigger').click ->
  	$('#max-date').html('
  		<input id="artobject_maxyear" name="artobject[maxyear]" class="artobject_input" type="text">
  		<div class="checkbox">
  			<label>
  				<input id="max_bce" name="max_bce" type="checkbox">
  				BCE
  			</label>
  		</div>')


  $(".artobject_tags").each -> 
    el = $(this);
    el.tokenInput("/tags/index.json", {
      crossDomain: false,
      prePopulate: el.data("pre"),
      preventDuplicates: true,
      theme: "facebook"
      hintText: "Choose an existing entry or create a new one"
    })

  $(".favorite_box").bind('change', ->
    if @.checked
      $.ajax
        url: '/favorites/',
        type: 'POST',
        data: {"artobject": this.id} 
    else
      $.ajax
        url: '/favorites/' + this.id,
        type: 'DELETE',
        data: {"artobject": this.id}
  )
