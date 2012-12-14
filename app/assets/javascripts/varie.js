
$(function() {
	// var shortly = new Date();

	// shortly.setSeconds(shortly.getSeconds() + 5.5);


	// $('#shortly').countdown({until: shortly, format: 'MS'});

	$('#shortlyStart').click(function() {
			// alert('Start!');
			$('#shortlyStart').fadeOut("slow");
			$('#trSamples').css("visibility","visible");
			var shortly = new Date();
			shortly.setSeconds(shortly.getSeconds() + 10.5);
			$('#shortly').countdown({until: shortly, format: 'MS', onExpiry: liftOff});
	});

	function liftOff() {
		alert('Get ready!');
	}

	/*
	$('#shortly').countdown({until: shortly,
							 onExpiry: liftOff,
							 onTick: watchCountdown});

	
	
	function watchCountdown(periods) {
			$('#monitor').text('Just ' + periods[5] + ' minutes and ' + periods[6] + ' seconds to go'); 
	}
	*/
})