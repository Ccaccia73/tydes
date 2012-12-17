
$(function() {
	// var shortly = new Date();

	// shortly.setSeconds(shortly.getSeconds() + 5.5);
	$curtainopen = true;

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
		$(this).blur();
		if ($curtainopen == false){
			$(this).stop().animate({top: '0px' }, {queue:false, duration:350, easing:'easeOutBounce'});
			$(".leftcurtain").stop().animate({width:'60px'}, 2000 );
			$(".rightcurtain").stop().animate({width:'60px'},2000 );
			$curtainopen = true;
		}else{
			$(this).stop().animate({top: '-40px' }, {queue:false, duration:350, easing:'easeOutBounce'});
			$(".leftcurtain").stop().animate({width:'50%'}, 2000 );
			$(".rightcurtain").stop().animate({width:'51%'}, 2000 );
			$curtainopen = false;
		}
		return false;		
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