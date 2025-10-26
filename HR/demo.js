window.addEvent('domready', function() {
	var status = {
		'true': 'open',
		'false': 'close'
	};
	
	//-vertical


	//--horizontal
	var myHorizontalSlide = new Fx.Slide('horizontal_slide', {mode: 'horizontal'});

	

	$('h_toggle').addEvent('click', function(e){
		e.stop();
		myHorizontalSlide.toggle();
	});

	
	// When Horizontal Slide ends its transition, we check for its status
	// note that complete will not affect 'hide' and 'show' methods
	myHorizontalSlide.addEvent('complete', function() {
		$('horizontal_status').set('html', status[myHorizontalSlide.open]);
	});
});