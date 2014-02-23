jQuery ->
	###
	$('ul').each(

    var $ul = $(this);

    var $liArr = $ul.children('li');

    $liArr.sort(function(a,b){

      var temp = parseInt( Math.random()*10 );

      var isOddOrEven = temp%2;

      var isPosOrNeg = temp>5 ? 1 : -1;

      return( isOddOrEven*isPosOrNeg );

    .appendTo($ul);            

  ###