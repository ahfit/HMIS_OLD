<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ptXrayView.aspx.vb" Inherits="ptXrayView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <link rel="stylesheet" href="../css_hacims/jquery-ui-1.7.1.custom.css" type="text/css" media="screen" />
    <link rel="stylesheet" href="../css_hacims/jquery.gzoom.css" type="text/css" media="screen" /> 
<script src="../css_hacims/jquery.min.js" type="text/javascript"></script>

    
</head>
<body >

 
<form id="form1" runat="server">
   
 
 

   <div id="zoom04" class="zoom"> 
				
                <asp:Image ID="ImageXray" runat="server" title="Xray - Image"  /> 
                 
             
			  </div>      
 
        
 </form>
 
 		<script type="text/javascript" src="../css_hacims/jquery-1.3.2.min.js"></script> 
		<script type="text/javascript" src="../css_hacims/ui.core.min.js"></script> 
		<script type="text/javascript" src="../css_hacims/ui.slider.min.js"></script> 
		<script type="text/javascript" src="../css_hacims/jquery.mousewheel.js"></script> 
		<script type="text/javascript" src="../css_hacims/jquery.gzoom.js"></script>
		<script type= "text/javascript"> 
			/*<![CDATA[*/
			$(function() {
				 
				$("#zoom04").gzoom({
						sW: 500,
						sH: 300,
						lW: 1024,
						lH: 768,
						lightbox: true,
						zoomIcon: '../images_hacims/gtk-zoom-in.png'
				});
			});
			/*]]>*/
		</script> 
 
</body>
</html>
