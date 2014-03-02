$('.flip').click(function(){
	alert("yes")
  $(this).find('.card').addClass('flipped').mouseleave(function(){
      $(this).removeClass('flipped');
  });
  return false;
});