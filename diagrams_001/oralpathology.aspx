<%@ page language="VB" autoeventwireup="false" inherits="oralpathology, App_Web_lvdmlbh5" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>Heart Right Dominant</title>


<style type="text/css">
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px; 
}
</style>

	<link rel="stylesheet" href="jquery_ui/themes/base/jquery.ui.all.css">
	<script src="jquery.min.js"></script>
	<script src="jquery_ui/ui/jquery.ui.core.js"></script>
	<script src="jquery_ui/ui/jquery.ui.widget.js"></script>
	<script src="jquery_ui/ui/jquery.ui.mouse.js"></script>
	<script src="jquery_ui/ui/jquery.ui.draggable.js"></script>
    <script src="jquery_ui/ui/jquery.ui.sortable.js"></script>
    
	<style type="text/css" media="all">
	.draggable { width: 15px; height: 15px; position:absolute; top:46px; left:931px;   }
	.draggable img { cursor: pointer; }
	
	.infobx { border:#a4b8c5 solid 1px; background:#fff url(diagram_imgs/img_infobxbg.png) top left repeat-x; height:auto; min-height:156px; width:300px; display:block; position:absolute; -moz-box-shadow: 1px 0px 2px #7d878c; -moz-box-shadow: 1px 0px 2px #7d878c; box-shadow:1px 0px 2px #7d878c; -webkit-border-radius: 6px; -moz-border-radius:6px; border-radius: 6px; margin-top:-5px; margin-left:14px;   }
	.infobx img {float:right; margin-right:8px; cursor:pointer; position:absolute; margin-left:166px; margin-top:3px; }
	.infobx input { width:280px; height:120px; margin-left:6px; margin-top:3px; -webkit-border-radius: 6px; -moz-border-radius:6px; border-radius: 6px; }
	.infobx .span {float:left; clear:right; font-weight:bold; color:#000; font-size:10px; font-family:"Segoe UI"; line-height:16px; margin-left:8px;  }
	 .list_d {list-style:none; margin:0; padding:0; margin-left:8px; font-family:"Segoe UI"; font-size:10px; font-weight:bold; margin-top:2px; margin-bottom:5px; }
 
 #trash { position:absolute; margin-left:955px; margin-top:170px; display:block; height:88px; width:85px; background: url(diagram_imgs/img_trash.png) top left no-repeat;}
	.digt {font-size:10px; color:#FFFFFF; position:absolute; margin-left:2px; font-family:arial;    }
	.print { position:absolute; margin-left:922px;  margin-top:312px; cursor:pointer;}
 
	</style>
    
    
	<script language="javascript" type="text/javascript">
	   
	   $(function (event, ui) {
	        $(".draggable").draggable({ handle: "img" });	         
	        $(".draggable").draggable({ opacity: 0.35 });
			
			
			
	       

	      $("#dot_1").dblclick(function () {$(".bx_dot_1").fadeToggle("slow", "linear");})
		  $("#dot_2").dblclick(function () {$(".bx_dot_2").fadeToggle("slow", "linear");})
		  $("#dot_3").dblclick(function () {$(".bx_dot_3").fadeToggle("slow", "linear");})
		  $("#dot_4").dblclick(function () {$(".bx_dot_4").fadeToggle("slow", "linear");})
		  $("#dot_5").dblclick(function () {$(".bx_dot_5").fadeToggle("slow", "linear");})
		  $("#dot_6").dblclick(function () {$(".bx_dot_6").fadeToggle("slow", "linear");})
		  $("#dot_7").dblclick(function () {$(".bx_dot_7").fadeToggle("slow", "linear");})
		  $("#dot_8").dblclick(function () {$(".bx_dot_8").fadeToggle("slow", "linear");})
		  $("#dot_9").dblclick(function () {$(".bx_dot_9").fadeToggle("slow", "linear");})
		  $("#dot_10").dblclick(function () {$(".bx_dot_10").fadeToggle("slow", "linear");})
		  $("#dot_11").dblclick(function () {$(".bx_dot_11").fadeToggle("slow", "linear");})
		  $("#dot_12").dblclick(function () {$(".bx_dot_12").fadeToggle("slow", "linear");})
		  $("#dot_13").dblclick(function () {$(".bx_dot_13").fadeToggle("slow", "linear");})
		  $("#dot_14").dblclick(function () {$(".bx_dot_14").fadeToggle("slow", "linear");})
		  $("#dot_15").dblclick(function () {$(".bx_dot_15").fadeToggle("slow", "linear");})
		 	
			
	        $(".draggable").bind("dragstop", function (event, ui) {
	       
	            var myx = ui.position.left;
	            var myy = ui.position.top;
	            var txtval =  $("#txt_"+ui.helper.attr('id')).val()
				  
			 //	 $(".cls_1").click(function () { $("#dot_1").css("display","none"); var showdot_dot_1 = 0; alert(showdot_dot_1);  })
				 
				var str = 'ID=' + ui.helper.attr('id') + '&X=' + myx + '&Y=' + myy + '&Desc='+ txtval + '$';
	            if ((myx >= 530) && (myx<= 600) && (myy >= 180) && (myy<= 260))			
	            {
	            document.getElementById('HF_Trash_Array_String').value = document.getElementById('HF_Trash_Array_String').value + 'ID=' + ui.helper.attr('id') + '$';
	            }
				document.getElementById('HF_Array_OF_String').value = document.getElementById('HF_Array_OF_String').value + str; 
	           
			 
			    
	       });
			
			 
			

	    });

       
 
	</script>
 

<script language="javascript" type="text/javascript">
 
 $(document).ready(function () {
	 
	 $(".cls_1").click(function () { $(".bx_dot_1").css("display","none"); })
	  $(".cls_2").click(function () { $(".bx_dot_2").css("display","none"); })
	   $(".cls_3").click(function () { $(".bx_dot_3").css("display","none"); })
	    $(".cls_4").click(function () { $(".bx_dot_4").css("display","none"); })
		 $(".cls_5").click(function () { $(".bx_dot_5").css("display","none"); })
		  $(".cls_6").click(function () { $(".bx_dot_6").css("display","none"); })
		   $(".cls_7").click(function () { $(".bx_dot_7").css("display","none"); })
		    $(".cls_8").click(function () { $(".bx_dot_8").css("display","none"); })
			 $(".cls_9").click(function () { $(".bx_dot_9").css("display","none"); })
			  $(".cls_10").click(function () { $(".bx_dot_10").css("display","none"); })
			   $(".cls_11").click(function () { $(".bx_dot_11").css("display","none"); })
			    $(".cls_12").click(function () { $(".bx_dot_12").css("display","none"); })
				 $(".cls_13").click(function () { $(".bx_dot_13").css("display","none"); })
				  $(".cls_14").click(function () { $(".bx_dot_14").css("display","none"); })
				   $(".cls_15").click(function () { $(".bx_dot_15").css("display","none"); })
	  
	  
	  });
  
 
</script>


</head>
<body>
<form id="form1" runat="server">
<div class="print"><img src="../images_hacims/img_print.jpg" onclick="print();" /></div>
<div id="trash"></div>     
<asp:Label ID="lbl_Points" runat="server" Text=""></asp:Label>
<asp:Button ID="Btn_Save" runat="server" Text="Save" CssClass="btn_save" style="width:160px; margin-top:120px;   position:absolute; font-weight:bold; margin-left:922px;" />

<asp:Button ID="Btn_trash" runat="server" Text="Clear Trash" CssClass="btn_save" style="width:160px; margin-top:270px;   position:absolute; font-weight:bold; margin-left:922px;" />

<div id="picture">
<img src="diagram_imgs/oralpathology.png" width="1099" height="484" />
</div><!--End Picture-->
 
 
 

<div class="draggable" id="dot_15"><img src="diagram_imgs/img_dotgreen15.png" width="15" height="15" />
<div  class="infobx bx_dot_15" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_15" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_15" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_15_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_15_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  

<div class="draggable" id="dot_14"><img src="diagram_imgs/img_dotgreen14.png" width="15" height="15" />
<div  class="infobx bx_dot_14" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_14" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_14" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_14_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_14_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  



<div class="draggable" id="dot_13"><img src="diagram_imgs/img_dotgreen13.png" width="15" height="15" />
<div  class="infobx bx_dot_13" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_13" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_13" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_13_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_13_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  



<div class="draggable" id="dot_12"><img src="diagram_imgs/img_dotgreen12.png" width="15" height="15" />
<div  class="infobx bx_dot_12" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_12" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_12" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_12_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_12_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable" id="dot_11"><img src="diagram_imgs/img_dotgreen11.png" width="15" height="15" />
<div  class="infobx bx_dot_11" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_11" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_11" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_11_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_11_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  



<div class="draggable" id="dot_10"><img src="diagram_imgs/img_dotgreen10.png" width="15" height="15" />
<div  class="infobx bx_dot_10" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_10" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_10" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_10_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_10_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  

<div class="draggable" id="dot_9"><img src="diagram_imgs/img_dotgreen9.png" width="15" height="15" />
<div  class="infobx bx_dot_9" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_9" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_9" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_9_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_9_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  

<div class="draggable" id="dot_8"><img src="diagram_imgs/img_dotgreen8.png" width="15" height="15" />
<div  class="infobx bx_dot_8" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_8" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_8" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_8_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_8_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable" id="dot_7"><img src="diagram_imgs/img_dotgreen7.png" width="15" height="15" />
<div  class="infobx bx_dot_7" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_7" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_7" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_7_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_7_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  

<div class="draggable" id="dot_6"><img src="diagram_imgs/img_dotgreen6.png" width="15" height="15" />
<div  class="infobx bx_dot_6" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_6" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_6" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_6_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_6_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  

<div class="draggable" id="dot_5"><img src="diagram_imgs/img_dotgreen5.png" width="15" height="15" />
<div  class="infobx bx_dot_5" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_5" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_5" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_5_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_5_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  



<div class="draggable" id="dot_4"><img src="diagram_imgs/img_dotgreen4.png" width="15" height="15" />
<div  class="infobx bx_dot_4" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_4" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_4" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_4_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_4_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable" id="dot_3"><img src="diagram_imgs/img_dotgreen3.png" width="15" height="15" />
<div  class="infobx bx_dot_3" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_3" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_3" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_3_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server"  ID="dot_3_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  

<div class="draggable" id="dot_2"> <img src="diagram_imgs/img_dotgreen2.png" width="15" height="15"  />
<div  class="infobx bx_dot_2" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_2" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_2" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_2_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_2_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  

  
<div class="draggable" id="dot_1"> <img src="diagram_imgs/img_dotgreen1.png" width="15" height="15" />
<div  class="infobx bx_dot_1" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_1" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_1" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="100px" ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_1_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_1_date" Text=""></asp:Label></li>
 
</ul>
</div><!--End desc-->
</div><!--End dot-->  

  







 


  <span style="position:absolute; display:none;"> x : <asp:TextBox ID="xpos" runat="server" ></asp:TextBox></span> 
  <span style="position:absolute; margin-top:25px; display:none;"> y : <asp:TextBox ID="ypos" runat="server" ></asp:TextBox></span>
    <asp:HiddenField ID="HF_Array_OF_String" runat="server" />
    <asp:HiddenField ID="HF_Trash_Array_String" runat="server" />
  
    <asp:GridView ID="Grd_PAramaeter" runat="server" Visible="False">
    </asp:GridView>
    
    
    <asp:DataList ID="DL_Point_Summary" runat="server" DataSourceID="SDS_DL" Width="60%" style="margin-left:25px; border:#CCC solid 1px;"  >
        <ItemTemplate>
      
      <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-bottom:#999999 dotted 1px; padding-bottom:10px; padding-top:8px;"> 
  <tr>
    <td valign="top" width="25" align="center"> <asp:Image ID="img_Diagram" runat="server" ImageUrl='<%# Eval("ImgPath") %>' /></td>
    <td valign="top" ><asp:Label ID="lbl_Description" runat="server" style="line-height:17px; font-family:'Segoe UI'; font-size:12px; " Text='<%# Eval("Description") %>'></asp:Label></td>
  </tr>
</table>

    
            
        </ItemTemplate>
    </asp:DataList>
    
    <br />
<br />

    
    
    <asp:SqlDataSource ID="SDS_DL" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
        SelectCommand="SELECT     '~/diagrams_001/diagram_imgs/img_dotgreen' + RIGHT(Img_ID, LEN(Img_ID) - 4) + '.png' AS ImgPath, Description&#13;&#10;FROM         Images_Data&#13;&#10;WHERE     (Reg_No = @Reg_No)AND (YearlyNo = @YearlyNo)AND (Pic_ID = 6)&#13;&#10;and not(((X >= 530) and (X <= 600)) and ((Y >= 180) and (Y <= 260)))&#13;&#10;">
        <SelectParameters>
            <asp:SessionParameter Name="Reg_No" SessionField="RegistrationNo" />
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
        </SelectParameters>
    </asp:SqlDataSource>
 
 
 

 
</form>
</body>
</html>
