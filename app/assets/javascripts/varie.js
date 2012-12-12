
(function($){
	$('#shortly').countdown({until: shortly,
							 onExpiry: liftOff,
							 onTick: watchCountdown});

	$('#shortlyStart').click(function() {
			alert('Start!');
			shortly = new Date();
			shortly.setSeconds(shortly.getSeconds() + 5.5);
			$('#shortly').countdown('option', {until: shortly});
	});

	function liftOff() {
		alert('We have lift off!');
		//window.location.replace("http://www.google.com");
	}

	function watchCountdown(periods) {
			$('#monitor').text('Just ' + periods[5] + ' minutes and ' + periods[6] + ' seconds to go'); 
	}
})(jQuery);