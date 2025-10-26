/* <![CDATA[ */
 $(document).ready(function() {
    $('#pause').click(function() { $('#slides').cycle('pause'); return false; });
    $('#play').click(function() { $('#slides').cycle('resume'); return false; });
    
    $('#slideshow').hover(
        function() { $('#controls').fadeIn(); },
        function() { $('#controls').fadeOut(); }
		 
    );
   

    $('#slides').cycle({
        fx:     'fade',
        speed:   1200,
        timeout: 6000,
        next:   '#next',
        prev:   '#prev',
		after:     function() {
        $('#caption').html(this.alt);
        }

	


    });
	
	 	var pausestate;
	function pauseit(e){
		e.preventDefault();
		if(!pausestate){
			$('#slides').cycle('pause');
			pausestate = true;
		}
	}

	function resumeit(e){
		e.preventDefault();
		if(pausestate){
			$('#slides').cycle('resume');
			pausestate = false;
		}
	}

	$('.pauseButton').click(pauseit);

	$('.resumeButton').click(resumeit);
	
	$('#slides').bind('mouseenter mouseleave', function(e){
		if (e.type === 'mouseenter'){
			pauseit(e);
		} else {
			resumeit(e);
		}
	});
});
	
 
 
 
 
 
/* ]]> */