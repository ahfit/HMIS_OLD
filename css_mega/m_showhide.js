 
$(document).ready(function() {
  $('.open').css("display","none");
  
	$('.close').click(function() {
		$('.close').css("display","none");
		$('.open').css("display","block");
		$('.leftnav').css("width","0px");		
		$('.all_left').hide();
		$.cookie('leftCol', 'collapsed');
	});
	
	$('.open').click(function() {
		$('.open').css("display","none");
		$('.close').css("display","block");
		$('.leftnav').css("width","350px");
		$('.all_left').show();
		 
		$.cookie('leftCol', 'expanded');
	});
   
	var leftCol = $.cookie('leftCol');
	if (leftCol == 'collapsed') {
		$('.close').css("display","none");
		$('.open').css("display","block");
		$('.leftnav').css("width","0");
		$('.all_left').hide();
	};
 
});
 