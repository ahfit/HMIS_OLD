 
$(document).ready(function() {
  $('.open').css("display","none");
	$('.close').click(function() {
		$('.close').css("display","none");
		$('.open').css("display","block");
		$('.leftnav').css("width","0px");		
		$('#ctl00_ContentPlaceHolder1_LabelSideMenu').hide();
		$.cookie('leftCol', 'collapsed');
	});
	
	$('.open').click(function() {
		$('.open').css("display","none");
		$('.close').css("display","block");
		$('.leftnav').css("width","208px");
		$('#ctl00_ContentPlaceHolder1_LabelSideMenu').show();
		 
		$.cookie('leftCol', 'expanded');
	});
   
	var leftCol = $.cookie('leftCol');
	if (leftCol == 'collapsed') {
		$('.close').css("display","none");
		$('.open').css("display","block");
		$('.leftnav').css("width","0");
		$('#ctl00_ContentPlaceHolder1_LabelSideMenu').hide();
	};
 
});
 