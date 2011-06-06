$(document).ready(function() {

	$('#front').show();
	$('#back').hide();
	$('#tags').hide();

  $('#front').click(function() {
		$('#front').hide();
		$('#back').show();
	});

  $('#back').click(function() {
		$('#back').hide();
		$('#front').show();
	});

});
