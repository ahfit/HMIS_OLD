<%@ page language="VB" autoeventwireup="false" inherits="initial_periodontal_examination, App_Web_lvdmlbh5" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>Initial Periodontal Examination</title>


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
	.mark_a { width: 15px; height: 15px; position:absolute; top:72px; left:970px;   }
	.mark_a img { cursor: pointer; }
	
	.mark_b { width: 15px; height: 15px; position:absolute; top:95px; left:966px;   }
	.mark_b img { cursor: pointer; }
	
	.mark_c { width: 15px; height: 15px; position:absolute; top:110px; left:968px;   }
	.mark_c img { cursor: pointer; }
	
	.mark_d { width: 15px; height: 15px; position:absolute; top:131px; left:968px;   }
	.mark_d img { cursor: pointer; }
	
	.mark_e { width: 15px; height: 15px; position:absolute; top:150px; left:968px;   }
	.mark_e img { cursor: pointer; }
	
	.mark_f { width: 15px; height: 15px; position:absolute; top:170px; left:970px;   }
	.mark_f img { cursor: pointer; }
	
	.mark_g { width: 15px; height: 15px; position:absolute; top:190px; left:970px;   }
	.mark_g img { cursor: pointer; }
	
	.mark_h { width: 15px; height: 15px; position:absolute; top:208px; left:968px;   }
	.mark_h img { cursor: pointer; }
	
	.mark_i { width: 15px; height: 15px; position:absolute; top:230px; left:970px;   }
	.mark_i img { cursor: pointer; }
	
	.mark_j { width: 15px; height: 15px; position:absolute; top:250px; left:968px;   }
	.mark_j img { cursor: pointer; }
	
	.mark_k { width: 15px; height: 15px; position:absolute; top:270px; left:968px;   }
	.mark_k img { cursor: pointer; }
	
	.mark_l { width: 15px; height: 15px; position:absolute; top:291px; left:968px;   }
	.mark_l img { cursor: pointer; }
	
	.mark_m { width: 15px; height: 15px; position:absolute; top:310px; left:968px;   }
	.mark_m img { cursor: pointer; }
	
  
	.infobx { border:#a4b8c5 solid 1px; background:#fff url(diagram_imgs/img_infobxbg.png) top left repeat-x; height:auto; min-height:156px; width:300px; display:block; position:absolute; -moz-box-shadow: 1px 0px 2px #7d878c; -moz-box-shadow: 1px 0px 2px #7d878c; box-shadow:1px 0px 2px #7d878c; -webkit-border-radius: 6px; -moz-border-radius:6px; border-radius: 6px; margin-top:-5px; margin-left:14px;   }
	.infobx img {float:right; margin-right:8px; cursor:pointer; position:absolute; margin-left:166px; margin-top:3px; }
	.infobx input { width:280px; height:120px; margin-left:6px; margin-top:3px; -webkit-border-radius: 6px; -moz-border-radius:6px; border-radius: 6px; }
	.infobx .span {float:left; clear:right; font-weight:bold; color:#000; font-size:10px; font-family:"Segoe UI"; line-height:16px; margin-left:8px;  }
	 .list_d {list-style:none; margin:0; padding:0; margin-left:8px; font-family:"Segoe UI"; font-size:10px; font-weight:bold; margin-top:2px; margin-bottom:5px; }
 
 #trash { position:absolute; margin-left:870px; margin-top:385px; display:block; height:88px; width:85px; background: url(diagram_imgs/img_trash.png) top left no-repeat;}
	.digt {font-size:10px; color:#FFFFFF; position:absolute; margin-left:2px; font-family:arial;    }
	.print { position:absolute; margin-left:830px;  margin-top:510px; cursor:pointer;}
 
	</style>
    
    
	<script language="javascript" type="text/javascript">
	   
	   $(function (event, ui) {
	        $(".draggable").draggable({ handle: "img" });	         
	        $(".draggable").draggable({ opacity: 0.35 });
	 
	      


$("#dot_1").dblclick(function () { $(".bx_dot_1").fadeToggle("slow","linear"); })
$("#dot_2").dblclick(function () { $(".bx_dot_2").fadeToggle("slow","linear"); })
$("#dot_3").dblclick(function () { $(".bx_dot_3").fadeToggle("slow","linear"); })
$("#dot_4").dblclick(function () { $(".bx_dot_4").fadeToggle("slow","linear"); })
$("#dot_5").dblclick(function () { $(".bx_dot_5").fadeToggle("slow","linear"); })
$("#dot_6").dblclick(function () { $(".bx_dot_6").fadeToggle("slow","linear"); })
$("#dot_7").dblclick(function () { $(".bx_dot_7").fadeToggle("slow","linear"); })
$("#dot_8").dblclick(function () { $(".bx_dot_8").fadeToggle("slow","linear"); })
$("#dot_9").dblclick(function () { $(".bx_dot_9").fadeToggle("slow","linear"); })
$("#dot_10").dblclick(function () { $(".bx_dot_10").fadeToggle("slow","linear"); })
$("#dot_11").dblclick(function () { $(".bx_dot_11").fadeToggle("slow","linear"); })
$("#dot_12").dblclick(function () { $(".bx_dot_12").fadeToggle("slow","linear"); })
$("#dot_13").dblclick(function () { $(".bx_dot_13").fadeToggle("slow","linear"); })
$("#dot_14").dblclick(function () { $(".bx_dot_14").fadeToggle("slow","linear"); })
$("#dot_15").dblclick(function () { $(".bx_dot_15").fadeToggle("slow","linear"); })
$("#dot_16").dblclick(function () { $(".bx_dot_16").fadeToggle("slow","linear"); })
$("#dot_17").dblclick(function () { $(".bx_dot_17").fadeToggle("slow","linear"); })
$("#dot_18").dblclick(function () { $(".bx_dot_18").fadeToggle("slow","linear"); })
$("#dot_19").dblclick(function () { $(".bx_dot_19").fadeToggle("slow","linear"); })
$("#dot_20").dblclick(function () { $(".bx_dot_20").fadeToggle("slow","linear"); })
$("#dot_21").dblclick(function () { $(".bx_dot_21").fadeToggle("slow","linear"); })
$("#dot_22").dblclick(function () { $(".bx_dot_22").fadeToggle("slow","linear"); })
$("#dot_23").dblclick(function () { $(".bx_dot_23").fadeToggle("slow","linear"); })
$("#dot_24").dblclick(function () { $(".bx_dot_24").fadeToggle("slow","linear"); })
$("#dot_25").dblclick(function () { $(".bx_dot_25").fadeToggle("slow","linear"); })
$("#dot_26").dblclick(function () { $(".bx_dot_26").fadeToggle("slow","linear"); })
$("#dot_27").dblclick(function () { $(".bx_dot_27").fadeToggle("slow","linear"); })
$("#dot_28").dblclick(function () { $(".bx_dot_28").fadeToggle("slow","linear"); })
$("#dot_29").dblclick(function () { $(".bx_dot_29").fadeToggle("slow","linear"); })
$("#dot_30").dblclick(function () { $(".bx_dot_30").fadeToggle("slow","linear"); })
$("#dot_31").dblclick(function () { $(".bx_dot_31").fadeToggle("slow","linear"); })
$("#dot_32").dblclick(function () { $(".bx_dot_32").fadeToggle("slow","linear"); })
$("#dot_33").dblclick(function () { $(".bx_dot_33").fadeToggle("slow","linear"); })
$("#dot_34").dblclick(function () { $(".bx_dot_34").fadeToggle("slow","linear"); })
$("#dot_35").dblclick(function () { $(".bx_dot_35").fadeToggle("slow","linear"); })
$("#dot_36").dblclick(function () { $(".bx_dot_36").fadeToggle("slow","linear"); })
$("#dot_37").dblclick(function () { $(".bx_dot_37").fadeToggle("slow","linear"); })
$("#dot_38").dblclick(function () { $(".bx_dot_38").fadeToggle("slow","linear"); })
$("#dot_39").dblclick(function () { $(".bx_dot_39").fadeToggle("slow","linear"); })
$("#dot_40").dblclick(function () { $(".bx_dot_40").fadeToggle("slow","linear"); })
$("#dot_41").dblclick(function () { $(".bx_dot_41").fadeToggle("slow","linear"); })
$("#dot_42").dblclick(function () { $(".bx_dot_42").fadeToggle("slow","linear"); })
$("#dot_43").dblclick(function () { $(".bx_dot_43").fadeToggle("slow","linear"); })
$("#dot_44").dblclick(function () { $(".bx_dot_44").fadeToggle("slow","linear"); })
$("#dot_45").dblclick(function () { $(".bx_dot_45").fadeToggle("slow","linear"); })
$("#dot_46").dblclick(function () { $(".bx_dot_46").fadeToggle("slow","linear"); })
$("#dot_47").dblclick(function () { $(".bx_dot_47").fadeToggle("slow","linear"); })
$("#dot_48").dblclick(function () { $(".bx_dot_48").fadeToggle("slow","linear"); })
$("#dot_49").dblclick(function () { $(".bx_dot_49").fadeToggle("slow","linear"); })
$("#dot_50").dblclick(function () { $(".bx_dot_50").fadeToggle("slow","linear"); })
$("#dot_51").dblclick(function () { $(".bx_dot_51").fadeToggle("slow","linear"); })
$("#dot_52").dblclick(function () { $(".bx_dot_52").fadeToggle("slow","linear"); })
$("#dot_53").dblclick(function () { $(".bx_dot_53").fadeToggle("slow","linear"); })
$("#dot_54").dblclick(function () { $(".bx_dot_54").fadeToggle("slow","linear"); })
$("#dot_55").dblclick(function () { $(".bx_dot_55").fadeToggle("slow","linear"); })
$("#dot_56").dblclick(function () { $(".bx_dot_56").fadeToggle("slow","linear"); })
$("#dot_57").dblclick(function () { $(".bx_dot_57").fadeToggle("slow","linear"); })
$("#dot_58").dblclick(function () { $(".bx_dot_58").fadeToggle("slow","linear"); })
$("#dot_59").dblclick(function () { $(".bx_dot_59").fadeToggle("slow","linear"); })
$("#dot_60").dblclick(function () { $(".bx_dot_60").fadeToggle("slow","linear"); })
$("#dot_61").dblclick(function () { $(".bx_dot_61").fadeToggle("slow","linear"); })
$("#dot_62").dblclick(function () { $(".bx_dot_62").fadeToggle("slow","linear"); })
$("#dot_63").dblclick(function () { $(".bx_dot_63").fadeToggle("slow","linear"); })
$("#dot_64").dblclick(function () { $(".bx_dot_64").fadeToggle("slow","linear"); })
$("#dot_65").dblclick(function () { $(".bx_dot_65").fadeToggle("slow","linear"); })
$("#dot_66").dblclick(function () { $(".bx_dot_66").fadeToggle("slow","linear"); })
$("#dot_67").dblclick(function () { $(".bx_dot_67").fadeToggle("slow","linear"); })
$("#dot_68").dblclick(function () { $(".bx_dot_68").fadeToggle("slow","linear"); })
$("#dot_69").dblclick(function () { $(".bx_dot_69").fadeToggle("slow","linear"); })
$("#dot_70").dblclick(function () { $(".bx_dot_70").fadeToggle("slow","linear"); })
$("#dot_71").dblclick(function () { $(".bx_dot_71").fadeToggle("slow","linear"); })
$("#dot_72").dblclick(function () { $(".bx_dot_72").fadeToggle("slow","linear"); })
$("#dot_73").dblclick(function () { $(".bx_dot_73").fadeToggle("slow","linear"); })
$("#dot_74").dblclick(function () { $(".bx_dot_74").fadeToggle("slow","linear"); })
$("#dot_75").dblclick(function () { $(".bx_dot_75").fadeToggle("slow","linear"); })
$("#dot_76").dblclick(function () { $(".bx_dot_76").fadeToggle("slow","linear"); })
$("#dot_77").dblclick(function () { $(".bx_dot_77").fadeToggle("slow","linear"); })
$("#dot_78").dblclick(function () { $(".bx_dot_78").fadeToggle("slow","linear"); })
$("#dot_79").dblclick(function () { $(".bx_dot_79").fadeToggle("slow","linear"); })
$("#dot_80").dblclick(function () { $(".bx_dot_80").fadeToggle("slow","linear"); })
$("#dot_81").dblclick(function () { $(".bx_dot_81").fadeToggle("slow","linear"); })
$("#dot_82").dblclick(function () { $(".bx_dot_82").fadeToggle("slow","linear"); })
$("#dot_83").dblclick(function () { $(".bx_dot_83").fadeToggle("slow","linear"); })
$("#dot_84").dblclick(function () { $(".bx_dot_84").fadeToggle("slow","linear"); })
$("#dot_85").dblclick(function () { $(".bx_dot_85").fadeToggle("slow","linear"); })
$("#dot_86").dblclick(function () { $(".bx_dot_86").fadeToggle("slow","linear"); })
$("#dot_87").dblclick(function () { $(".bx_dot_87").fadeToggle("slow","linear"); })
$("#dot_88").dblclick(function () { $(".bx_dot_88").fadeToggle("slow","linear"); })
$("#dot_89").dblclick(function () { $(".bx_dot_89").fadeToggle("slow","linear"); })
$("#dot_90").dblclick(function () { $(".bx_dot_90").fadeToggle("slow","linear"); })
$("#dot_91").dblclick(function () { $(".bx_dot_91").fadeToggle("slow","linear"); })
$("#dot_92").dblclick(function () { $(".bx_dot_92").fadeToggle("slow","linear"); })
$("#dot_93").dblclick(function () { $(".bx_dot_93").fadeToggle("slow","linear"); })
$("#dot_94").dblclick(function () { $(".bx_dot_94").fadeToggle("slow","linear"); })
$("#dot_95").dblclick(function () { $(".bx_dot_95").fadeToggle("slow","linear"); })
$("#dot_96").dblclick(function () { $(".bx_dot_96").fadeToggle("slow","linear"); })
$("#dot_97").dblclick(function () { $(".bx_dot_97").fadeToggle("slow","linear"); })
$("#dot_98").dblclick(function () { $(".bx_dot_98").fadeToggle("slow","linear"); })
$("#dot_99").dblclick(function () { $(".bx_dot_99").fadeToggle("slow","linear"); })
$("#dot_100").dblclick(function () { $(".bx_dot_100").fadeToggle("slow","linear"); })
 
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
$(".cls_16").click(function () { $(".bx_dot_16").css("display","none"); })
$(".cls_17").click(function () { $(".bx_dot_17").css("display","none"); })
$(".cls_18").click(function () { $(".bx_dot_18").css("display","none"); })
$(".cls_19").click(function () { $(".bx_dot_19").css("display","none"); })
$(".cls_20").click(function () { $(".bx_dot_20").css("display","none"); })
$(".cls_21").click(function () { $(".bx_dot_21").css("display","none"); })
$(".cls_22").click(function () { $(".bx_dot_22").css("display","none"); })
$(".cls_23").click(function () { $(".bx_dot_23").css("display","none"); })
$(".cls_24").click(function () { $(".bx_dot_24").css("display","none"); })
$(".cls_25").click(function () { $(".bx_dot_25").css("display","none"); })
$(".cls_26").click(function () { $(".bx_dot_26").css("display","none"); })
$(".cls_27").click(function () { $(".bx_dot_27").css("display","none"); })
$(".cls_28").click(function () { $(".bx_dot_28").css("display","none"); })
$(".cls_29").click(function () { $(".bx_dot_29").css("display","none"); })
$(".cls_30").click(function () { $(".bx_dot_30").css("display","none"); })
$(".cls_31").click(function () { $(".bx_dot_31").css("display","none"); })
$(".cls_32").click(function () { $(".bx_dot_32").css("display","none"); })
$(".cls_33").click(function () { $(".bx_dot_33").css("display","none"); })
$(".cls_34").click(function () { $(".bx_dot_34").css("display","none"); })
$(".cls_35").click(function () { $(".bx_dot_35").css("display","none"); })
$(".cls_36").click(function () { $(".bx_dot_36").css("display","none"); })
$(".cls_37").click(function () { $(".bx_dot_37").css("display","none"); })
$(".cls_38").click(function () { $(".bx_dot_38").css("display","none"); })
$(".cls_39").click(function () { $(".bx_dot_39").css("display","none"); })
$(".cls_40").click(function () { $(".bx_dot_40").css("display","none"); })
$(".cls_41").click(function () { $(".bx_dot_41").css("display","none"); })
$(".cls_42").click(function () { $(".bx_dot_42").css("display","none"); })
$(".cls_43").click(function () { $(".bx_dot_43").css("display","none"); })
$(".cls_44").click(function () { $(".bx_dot_44").css("display","none"); })
$(".cls_45").click(function () { $(".bx_dot_45").css("display","none"); })
$(".cls_46").click(function () { $(".bx_dot_46").css("display","none"); })
$(".cls_47").click(function () { $(".bx_dot_47").css("display","none"); })
$(".cls_48").click(function () { $(".bx_dot_48").css("display","none"); })
$(".cls_49").click(function () { $(".bx_dot_49").css("display","none"); })
$(".cls_50").click(function () { $(".bx_dot_50").css("display","none"); })
$(".cls_51").click(function () { $(".bx_dot_51").css("display","none"); })
$(".cls_52").click(function () { $(".bx_dot_52").css("display","none"); })
$(".cls_53").click(function () { $(".bx_dot_53").css("display","none"); })
$(".cls_54").click(function () { $(".bx_dot_54").css("display","none"); })
$(".cls_55").click(function () { $(".bx_dot_55").css("display","none"); })
$(".cls_56").click(function () { $(".bx_dot_56").css("display","none"); })
$(".cls_57").click(function () { $(".bx_dot_57").css("display","none"); })
$(".cls_58").click(function () { $(".bx_dot_58").css("display","none"); })
$(".cls_59").click(function () { $(".bx_dot_59").css("display","none"); })
$(".cls_60").click(function () { $(".bx_dot_60").css("display","none"); })
$(".cls_61").click(function () { $(".bx_dot_61").css("display","none"); })
$(".cls_62").click(function () { $(".bx_dot_62").css("display","none"); })
$(".cls_63").click(function () { $(".bx_dot_63").css("display","none"); })
$(".cls_64").click(function () { $(".bx_dot_64").css("display","none"); })
$(".cls_65").click(function () { $(".bx_dot_65").css("display","none"); })
$(".cls_66").click(function () { $(".bx_dot_66").css("display","none"); })
$(".cls_67").click(function () { $(".bx_dot_67").css("display","none"); })
$(".cls_68").click(function () { $(".bx_dot_68").css("display","none"); })
$(".cls_69").click(function () { $(".bx_dot_69").css("display","none"); })
$(".cls_70").click(function () { $(".bx_dot_70").css("display","none"); })
$(".cls_71").click(function () { $(".bx_dot_71").css("display","none"); })
$(".cls_72").click(function () { $(".bx_dot_72").css("display","none"); })
$(".cls_73").click(function () { $(".bx_dot_73").css("display","none"); })
$(".cls_74").click(function () { $(".bx_dot_74").css("display","none"); })
$(".cls_75").click(function () { $(".bx_dot_75").css("display","none"); })
$(".cls_76").click(function () { $(".bx_dot_76").css("display","none"); })
$(".cls_77").click(function () { $(".bx_dot_77").css("display","none"); })
$(".cls_78").click(function () { $(".bx_dot_78").css("display","none"); })
$(".cls_79").click(function () { $(".bx_dot_79").css("display","none"); })
$(".cls_80").click(function () { $(".bx_dot_80").css("display","none"); })
$(".cls_81").click(function () { $(".bx_dot_81").css("display","none"); })
$(".cls_82").click(function () { $(".bx_dot_82").css("display","none"); })
$(".cls_83").click(function () { $(".bx_dot_83").css("display","none"); })
$(".cls_84").click(function () { $(".bx_dot_84").css("display","none"); })
$(".cls_85").click(function () { $(".bx_dot_85").css("display","none"); })
$(".cls_86").click(function () { $(".bx_dot_86").css("display","none"); })
$(".cls_87").click(function () { $(".bx_dot_87").css("display","none"); })
$(".cls_88").click(function () { $(".bx_dot_88").css("display","none"); })
$(".cls_89").click(function () { $(".bx_dot_89").css("display","none"); })
$(".cls_90").click(function () { $(".bx_dot_90").css("display","none"); })
$(".cls_91").click(function () { $(".bx_dot_91").css("display","none"); })
$(".cls_92").click(function () { $(".bx_dot_92").css("display","none"); })
$(".cls_93").click(function () { $(".bx_dot_93").css("display","none"); })
$(".cls_94").click(function () { $(".bx_dot_94").css("display","none"); })
$(".cls_95").click(function () { $(".bx_dot_95").css("display","none"); })
$(".cls_96").click(function () { $(".bx_dot_96").css("display","none"); })
$(".cls_97").click(function () { $(".bx_dot_97").css("display","none"); })
$(".cls_98").click(function () { $(".bx_dot_98").css("display","none"); })
$(".cls_99").click(function () { $(".bx_dot_99").css("display","none"); })
$(".cls_100").click(function () { $(".bx_dot_100").css("display","none"); })
 
	  
	  
	  });
  
 
</script>


</head>
<body>
<form id="form1" runat="server">
<div class="print"><img src="../images_hacims/img_print.jpg" onclick="print();" /></div>
<div id="trash"></div>     
<asp:Label ID="lbl_Points" runat="server" Text=""></asp:Label>
<asp:Button ID="Btn_Save" runat="server" Text="Save" CssClass="btn_save" style="width:160px; margin-top:350px;   position:absolute; font-weight:bold; margin-left:830px;" />

<asp:Button ID="Btn_trash" runat="server" Text="Clear Trash" CssClass="btn_save" style="width:160px; margin-top:480px;   position:absolute; font-weight:bold; margin-left:830px;" />

<div id="picture">
<img src="diagram_imgs/initial_periodontal_examination.png" width="1000" height="350" />
</div><!--End Picture-->

 
<div class="draggable mark_a" id="dot_1"><img src="diagram_imgs/mark_a1.png"  />
<div  class="infobx bx_dot_1" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_1" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_1" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_1_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_1_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  

<div class="draggable mark_a" id="dot_2"><img src="diagram_imgs/mark_a1.png"  />
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

<div class="draggable mark_a" id="dot_3"><img src="diagram_imgs/mark_a1.png"  />
<div  class="infobx bx_dot_3" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_3" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_3" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_3_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_3_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_a" id="dot_4"><img src="diagram_imgs/mark_a1.png"  />
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

<div class="draggable mark_a" id="dot_5"><img src="diagram_imgs/mark_a1.png"  />
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

<div class="draggable mark_a" id="dot_6"><img src="diagram_imgs/mark_a1.png"  />
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


<div class="draggable mark_a" id="dot_7"><img src="diagram_imgs/mark_a1.png"  />
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

<div class="draggable mark_a" id="dot_8"><img src="diagram_imgs/mark_a1.png"  />
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

<div class="draggable mark_a" id="dot_9"><img src="diagram_imgs/mark_a1.png"  />
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

<div class="draggable mark_a" id="dot_10"><img src="diagram_imgs/mark_a1.png"  />
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


<div class="draggable mark_b" id="dot_11"><img src="diagram_imgs/mark_b1.png"  />
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


<div class="draggable mark_b" id="dot_12"><img src="diagram_imgs/mark_b1.png"  />
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


<div class="draggable mark_b" id="dot_13"><img src="diagram_imgs/mark_b1.png"  />
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


<div class="draggable mark_b" id="dot_14"><img src="diagram_imgs/mark_b1.png"  />
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


<div class="draggable mark_b" id="dot_15"><img src="diagram_imgs/mark_b1.png"  />
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


<div class="draggable mark_b" id="dot_16"><img src="diagram_imgs/mark_b1.png"  />
<div  class="infobx bx_dot_16" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_16" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_16" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_16_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_16_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_b" id="dot_17"><img src="diagram_imgs/mark_b1.png"  />
<div  class="infobx bx_dot_17" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_17" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_17" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_17_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_17_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  



<div class="draggable mark_b" id="dot_18"><img src="diagram_imgs/mark_b1.png"  />
<div  class="infobx bx_dot_18" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_18" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_18" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_18_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_18_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_b" id="dot_19"><img src="diagram_imgs/mark_b1.png"  />
<div  class="infobx bx_dot_19" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_19" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_19" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_19_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_19_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  

<div class="draggable mark_b" id="dot_20"><img src="diagram_imgs/mark_b1.png"  />
<div  class="infobx bx_dot_20" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_20" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_20" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_20_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_20_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_c" id="dot_21"><img src="diagram_imgs/mark_c1.png"  />
<div  class="infobx bx_dot_21" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_21" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_21" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_21_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_21_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_c" id="dot_22"><img src="diagram_imgs/mark_c1.png"  />
<div  class="infobx bx_dot_22" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_22" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_22" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_22_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_22_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_c" id="dot_23"><img src="diagram_imgs/mark_c1.png"  />
<div  class="infobx bx_dot_23" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_23" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_23" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_23_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_23_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_c" id="dot_24"><img src="diagram_imgs/mark_c1.png"  />
<div  class="infobx bx_dot_24" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_24" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_24" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_24_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_24_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  



<div class="draggable mark_c" id="dot_25"><img src="diagram_imgs/mark_c1.png"  />
<div  class="infobx bx_dot_25" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_25" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_25" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_25_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_25_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  



<div class="draggable mark_c" id="dot_26"><img src="diagram_imgs/mark_c1.png"  />
<div  class="infobx bx_dot_26" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_26" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_26" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_26_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_26_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  

<div class="draggable mark_c" id="dot_27"><img src="diagram_imgs/mark_c1.png"  />
<div  class="infobx bx_dot_27" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_27" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_27" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_27_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_27_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_c" id="dot_28"><img src="diagram_imgs/mark_c1.png"  />
<div  class="infobx bx_dot_28" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_28" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_28" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_28_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_28_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_c" id="dot_29"><img src="diagram_imgs/mark_c1.png"  />
<div  class="infobx bx_dot_29" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_29" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_29" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_29_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_29_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_c" id="dot_30"><img src="diagram_imgs/mark_c1.png"  />
<div  class="infobx bx_dot_30" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_30" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_30" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_30_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_30_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  

<div class="draggable mark_d" id="dot_31"><img src="diagram_imgs/mark_d1.png"  />
<div  class="infobx bx_dot_31" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_31" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_31" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_31_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_31_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_d" id="dot_32"><img src="diagram_imgs/mark_d1.png"  />
<div  class="infobx bx_dot_32" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_32" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_32" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_32_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_32_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_d" id="dot_33"><img src="diagram_imgs/mark_d1.png"  />
<div  class="infobx bx_dot_33" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_33" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_33" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_33_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_33_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_d" id="dot_34"><img src="diagram_imgs/mark_d1.png"  />
<div  class="infobx bx_dot_34" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_34" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_34" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_34_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_34_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  

<div class="draggable mark_d" id="dot_35"><img src="diagram_imgs/mark_d1.png"  />
<div  class="infobx bx_dot_35" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_35" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_35" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_35_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_35_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_d" id="dot_36"><img src="diagram_imgs/mark_d1.png"  />
<div  class="infobx bx_dot_36" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_36" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_36" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_36_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_36_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_d" id="dot_37"><img src="diagram_imgs/mark_d1.png"  />
<div  class="infobx bx_dot_37" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_37" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_37" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_37_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_37_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_d" id="dot_38"><img src="diagram_imgs/mark_d1.png"  />
<div  class="infobx bx_dot_38" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_38" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_38" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_38_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_38_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_d" id="dot_39"><img src="diagram_imgs/mark_d1.png"  />
<div  class="infobx bx_dot_39" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_39" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_39" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_39_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_39_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  

<div class="draggable mark_d" id="dot_40"><img src="diagram_imgs/mark_d1.png"  />
<div  class="infobx bx_dot_40" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_40" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_40" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_40_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_40_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  

<div class="draggable mark_e" id="dot_41"><img src="diagram_imgs/mark_e1.png"  />
<div  class="infobx bx_dot_41" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_41" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_41" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_41_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_41_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_e" id="dot_42"><img src="diagram_imgs/mark_e1.png"  />
<div  class="infobx bx_dot_42" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_42" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_42" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_42_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_42_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot--> 


<div class="draggable mark_e" id="dot_43"><img src="diagram_imgs/mark_e1.png"  />
<div  class="infobx bx_dot_43" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_43" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_43" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_43_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_43_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_e" id="dot_44"><img src="diagram_imgs/mark_e1.png"  />
<div  class="infobx bx_dot_44" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_44" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_44" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_44_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_44_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_e" id="dot_45"><img src="diagram_imgs/mark_e1.png"  />
<div  class="infobx bx_dot_45" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_45" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_45" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_45_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_45_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->   


<div class="draggable mark_e" id="dot_46"><img src="diagram_imgs/mark_e1.png"  />
<div  class="infobx bx_dot_46" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_46" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_46" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_46_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_46_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_e" id="dot_47"><img src="diagram_imgs/mark_e1.png"  />
<div  class="infobx bx_dot_47" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_47" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_47" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_47_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_47_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_e" id="dot_48"><img src="diagram_imgs/mark_e1.png"  />
<div  class="infobx bx_dot_48" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_48" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_48" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_48_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_48_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_e" id="dot_49"><img src="diagram_imgs/mark_e1.png"  />
<div  class="infobx bx_dot_49" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_49" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_49" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_49_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_49_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_e" id="dot_50"><img src="diagram_imgs/mark_e1.png"  />
<div  class="infobx bx_dot_50" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_50" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_50" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_50_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_50_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_f" id="dot_51"><img src="diagram_imgs/mark_f1.png"  />
<div  class="infobx bx_dot_51" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_51" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_51" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_51_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_51_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_f" id="dot_52"><img src="diagram_imgs/mark_f1.png"  />
<div  class="infobx bx_dot_52" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_52" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_52" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_52_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_52_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  

<div class="draggable mark_f" id="dot_53"><img src="diagram_imgs/mark_f1.png"  />
<div  class="infobx bx_dot_53" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_53" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_53" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_53_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_53_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  

<div class="draggable mark_f" id="dot_54"><img src="diagram_imgs/mark_f1.png"  />
<div  class="infobx bx_dot_54" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_54" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_54" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_54_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_54_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  

<div class="draggable mark_f" id="dot_55"><img src="diagram_imgs/mark_f1.png"  />
<div  class="infobx bx_dot_55" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_55" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_55" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_55_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_55_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_f" id="dot_56"><img src="diagram_imgs/mark_f1.png"  />
<div  class="infobx bx_dot_56" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_56" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_56" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_56_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_56_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot--> 

<div class="draggable mark_f" id="dot_57"><img src="diagram_imgs/mark_f1.png"  />
<div  class="infobx bx_dot_57" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_57" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_57" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_57_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_57_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->   

<div class="draggable mark_f" id="dot_58"><img src="diagram_imgs/mark_f1.png"  />
<div  class="infobx bx_dot_58" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_58" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_58" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_58_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_58_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_f" id="dot_59"><img src="diagram_imgs/mark_f1.png"  />
<div  class="infobx bx_dot_59" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_59" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_59" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_59_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_59_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_f" id="dot_60"><img src="diagram_imgs/mark_f1.png"  />
<div  class="infobx bx_dot_60" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_60" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_60" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_60_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_60_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_g" id="dot_61"><img src="diagram_imgs/mark_g1.png"  />
<div  class="infobx bx_dot_61" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_61" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_61" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_61_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_61_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_g" id="dot_62"><img src="diagram_imgs/mark_g1.png"  />
<div  class="infobx bx_dot_62" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_62" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_62" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_62_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_62_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_g" id="dot_63"><img src="diagram_imgs/mark_g1.png"  />
<div  class="infobx bx_dot_63" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_63" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_63" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_63_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_63_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_g" id="dot_64"><img src="diagram_imgs/mark_g1.png"  />
<div  class="infobx bx_dot_64" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_64" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_64" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_64_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_64_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_g" id="dot_65"><img src="diagram_imgs/mark_g1.png"  />
<div  class="infobx bx_dot_65" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_65" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_65" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_65_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_65_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_g" id="dot_66"><img src="diagram_imgs/mark_g1.png"  />
<div  class="infobx bx_dot_66" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_66" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_66" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_66_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_66_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_g" id="dot_67"><img src="diagram_imgs/mark_g1.png"  />
<div  class="infobx bx_dot_67" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_67" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_67" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_67_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_67_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_g" id="dot_68"><img src="diagram_imgs/mark_g1.png"  />
<div  class="infobx bx_dot_68" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_68" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_68" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_68_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_68_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_g" id="dot_69"><img src="diagram_imgs/mark_g1.png"  />
<div  class="infobx bx_dot_69" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_69" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_69" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_69_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_69_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_g" id="dot_70"><img src="diagram_imgs/mark_g1.png"  />
<div  class="infobx bx_dot_70" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_70" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_70" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_70_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_70_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot--> 


<div class="draggable mark_h" id="dot_71"><img src="diagram_imgs/mark_h1.png"  />
<div  class="infobx bx_dot_71" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_71" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_71" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_71_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_71_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot--> 


<div class="draggable mark_h" id="dot_72"><img src="diagram_imgs/mark_h1.png"  />
<div  class="infobx bx_dot_72" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_72" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_72" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_72_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_72_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->   


<div class="draggable mark_h" id="dot_73"><img src="diagram_imgs/mark_h1.png"  />
<div  class="infobx bx_dot_73" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_73" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_73" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_73_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_73_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_h" id="dot_74"><img src="diagram_imgs/mark_h1.png"  />
<div  class="infobx bx_dot_74" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_74" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_74" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_74_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_74_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->   


<div class="draggable mark_h" id="dot_75"><img src="diagram_imgs/mark_h1.png"  />
<div  class="infobx bx_dot_75" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_75" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_75" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_75_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_75_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_h" id="dot_76"><img src="diagram_imgs/mark_h1.png"  />
<div  class="infobx bx_dot_76" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_76" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_76" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_76_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_76_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  



<div class="draggable mark_h" id="dot_77"><img src="diagram_imgs/mark_h1.png"  />
<div  class="infobx bx_dot_77" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_77" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_77" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_77_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_77_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_h" id="dot_78"><img src="diagram_imgs/mark_h1.png"  />
<div  class="infobx bx_dot_78" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_78" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_78" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_78_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_78_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_h" id="dot_79"><img src="diagram_imgs/mark_h1.png"  />
<div  class="infobx bx_dot_79" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_79" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_79" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_79_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_79_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  



<div class="draggable mark_h" id="dot_80"><img src="diagram_imgs/mark_h1.png"  />
<div  class="infobx bx_dot_80" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_80" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_80" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_80_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_80_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_i" id="dot_81"><img src="diagram_imgs/mark_i1.png"  />
<div  class="infobx bx_dot_81" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_81" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_81" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_81_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_81_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_i" id="dot_82"><img src="diagram_imgs/mark_i1.png"  />
<div  class="infobx bx_dot_82" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_82" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_82" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_82_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_82_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_i" id="dot_83"><img src="diagram_imgs/mark_i1.png"  />
<div  class="infobx bx_dot_83" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_83" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_83" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_83_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_83_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_i" id="dot_84"><img src="diagram_imgs/mark_i1.png"  />
<div  class="infobx bx_dot_84" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_84" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_84" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_84_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_84_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_i" id="dot_85"><img src="diagram_imgs/mark_i1.png"  />
<div  class="infobx bx_dot_85" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_85" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_85" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_85_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_85_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_i" id="dot_86"><img src="diagram_imgs/mark_i1.png"  />
<div  class="infobx bx_dot_86" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_86" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_86" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_86_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_86_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_i" id="dot_87"><img src="diagram_imgs/mark_i1.png"  />
<div  class="infobx bx_dot_87" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_87" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_87" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_87_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_87_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_i" id="dot_88"><img src="diagram_imgs/mark_i1.png"  />
<div  class="infobx bx_dot_88" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_88" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_88" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_88_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_88_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_i" id="dot_89"><img src="diagram_imgs/mark_i1.png"  />
<div  class="infobx bx_dot_89" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_89" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_89" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_89_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_89_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_i" id="dot_90"><img src="diagram_imgs/mark_i1.png"  />
<div  class="infobx bx_dot_90" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_90" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_90" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_90_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_90_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_j" id="dot_91"><img src="diagram_imgs/mark_j1.png"  />
<div  class="infobx bx_dot_91" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_91" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_91" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_91_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_91_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_j" id="dot_92"><img src="diagram_imgs/mark_j1.png"  />
<div  class="infobx bx_dot_92" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_92" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_92" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_92_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_92_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_j" id="dot_93"><img src="diagram_imgs/mark_j1.png"  />
<div  class="infobx bx_dot_93" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_93" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_93" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_93_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_93_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_j" id="dot_94"><img src="diagram_imgs/mark_j1.png"  />
<div  class="infobx bx_dot_94" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_94" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_94" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_94_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_94_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_j" id="dot_95"><img src="diagram_imgs/mark_j1.png"  />
<div  class="infobx bx_dot_95" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_95" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_95" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_95_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_95_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_j" id="dot_96"><img src="diagram_imgs/mark_j1.png"  />
<div  class="infobx bx_dot_96" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_96" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_96" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_96_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_96_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_j" id="dot_97"><img src="diagram_imgs/mark_j1.png"  />
<div  class="infobx bx_dot_97" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_97" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_97" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_97_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_97_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_j" id="dot_98"><img src="diagram_imgs/mark_j1.png"  />
<div  class="infobx bx_dot_98" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_98" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_98" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_98_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_98_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_j" id="dot_99"><img src="diagram_imgs/mark_j1.png"  />
<div  class="infobx bx_dot_99" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_99" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_99" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_99_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_99_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_j" id="dot_100"><img src="diagram_imgs/mark_j1.png"  />
<div  class="infobx bx_dot_100" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_100" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_100" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_100_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_100_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_k" id="dot_101"><img src="diagram_imgs/mark_j1.png"  />
<div  class="infobx bx_dot_101" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_101" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_101" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_101_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_101_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_k" id="dot_102"><img src="diagram_imgs/mark_k1.png"  />
<div  class="infobx bx_dot_102" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_102" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_102" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_102_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_102_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_k" id="dot_103"><img src="diagram_imgs/mark_k1.png"  />
<div  class="infobx bx_dot_103" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_103" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_103" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_103_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_103_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_k" id="dot_104"><img src="diagram_imgs/mark_k1.png"  />
<div  class="infobx bx_dot_104" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_104" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_104" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_104_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_104_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot--> 


<div class="draggable mark_k" id="dot_105"><img src="diagram_imgs/mark_k1.png"  />
<div  class="infobx bx_dot_105" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_105" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_105" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_105_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_105_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->   


<div class="draggable mark_k" id="dot_106"><img src="diagram_imgs/mark_k1.png"  />
<div  class="infobx bx_dot_106" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_106" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_106" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_106_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_106_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_k" id="dot_107"><img src="diagram_imgs/mark_k1.png"  />
<div  class="infobx bx_dot_107" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_107" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_107" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_107_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_107_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_k" id="dot_108"><img src="diagram_imgs/mark_k1.png"  />
<div  class="infobx bx_dot_108" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_108" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_108" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_108_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_108_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_k" id="dot_109"><img src="diagram_imgs/mark_k1.png"  />
<div  class="infobx bx_dot_109" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_109" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_109" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_109_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_109_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_k" id="dot_110"><img src="diagram_imgs/mark_k1.png"  />
<div  class="infobx bx_dot_110" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_110" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_110" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_110_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_110_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  

<div class="draggable mark_l" id="dot_111"><img src="diagram_imgs/mark_l1.png"  />
<div  class="infobx bx_dot_111" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_111" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_111" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_111_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_111_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_l" id="dot_112"><img src="diagram_imgs/mark_l1.png"  />
<div  class="infobx bx_dot_112" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_112" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_112" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_112_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_112_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_l" id="dot_113"><img src="diagram_imgs/mark_l1.png"  />
<div  class="infobx bx_dot_113" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_113" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_113" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_113_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_113_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_l" id="dot_114"><img src="diagram_imgs/mark_l1.png"  />
<div  class="infobx bx_dot_114" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_114" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_114" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_114_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_114_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_l" id="dot_115"><img src="diagram_imgs/mark_l1.png"  />
<div  class="infobx bx_dot_115" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_115" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_115" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_115_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_115_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_l" id="dot_116"><img src="diagram_imgs/mark_l1.png"  />
<div  class="infobx bx_dot_116" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_116" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_116" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_116_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_116_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_l" id="dot_117"><img src="diagram_imgs/mark_l1.png"  />
<div  class="infobx bx_dot_117" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_117" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_117" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_117_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_117_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_l" id="dot_118"><img src="diagram_imgs/mark_l1.png"  />
<div  class="infobx bx_dot_118" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_118" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_118" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_118_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_118_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_l" id="dot_119"><img src="diagram_imgs/mark_l1.png"  />
<div  class="infobx bx_dot_119" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_119" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_119" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_119_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_119_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_l" id="dot_120"><img src="diagram_imgs/mark_l1.png"  />
<div  class="infobx bx_dot_120" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_120" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_120" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_120_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_120_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot--> 


<div class="draggable mark_m" id="dot_121"><img src="diagram_imgs/mark_m1.png"  />
<div  class="infobx bx_dot_121" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_121" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_121" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_121_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_121_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->   


<div class="draggable mark_m" id="dot_122"><img src="diagram_imgs/mark_m1.png"  />
<div  class="infobx bx_dot_122" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_122" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_122" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_122_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_122_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot--> 


<div class="draggable mark_m" id="dot_123"><img src="diagram_imgs/mark_m1.png"  />
<div  class="infobx bx_dot_123" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_123" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_123" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_123_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_123_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->   


<div class="draggable mark_m" id="dot_124"><img src="diagram_imgs/mark_m1.png"  />
<div  class="infobx bx_dot_124" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_124" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_124" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_124_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_124_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_m" id="dot_125"><img src="diagram_imgs/mark_m1.png"  />
<div  class="infobx bx_dot_125" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_125" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_125" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_125_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_125_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_m" id="dot_126"><img src="diagram_imgs/mark_m1.png"  />
<div  class="infobx bx_dot_126" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_126" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_126" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_126_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_126_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_m" id="dot_127"><img src="diagram_imgs/mark_m1.png"  />
<div  class="infobx bx_dot_127" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_127" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_127" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_127_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_127_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_m" id="dot_128"><img src="diagram_imgs/mark_m1.png"  />
<div  class="infobx bx_dot_128" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_128" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_128" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_128_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_128_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  



<div class="draggable mark_m" id="dot_129"><img src="diagram_imgs/mark_m1.png"  />
<div  class="infobx bx_dot_129" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_129" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_129" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_129_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_129_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  


<div class="draggable mark_m" id="dot_130"><img src="diagram_imgs/mark_m1.png"  />
<div  class="infobx bx_dot_130" style="display:none;">
<span class="span">Add Description</span><img src="diagram_imgs/img_cls.png" class="clsbtn cls_130" width="44" height="16" alt="close box" title="Delete Mark" />
 
<asp:TextBox ID="txt_dot_130" TextMode="MultiLine" CssClass="mytxt" runat="server" Width="280px" style="margin-left:8px; margin-top:5px;" Height="120px"  ></asp:TextBox>
<ul class="list_d">
<li>Doctor : <asp:Label runat="server" ID="dot_130_doc" Text=""></asp:Label></li>
<li>Date   :<asp:Label runat="server" ID="dot_130_date" Text=""></asp:Label></li>
<li></li>
</ul>
</div><!--End desc-->
</div><!--End dot-->  
 

<!--//////////////////////////////////////////////////-->



  <span style="position:absolute; display:none;"> x : <asp:TextBox ID="xpos" runat="server" ></asp:TextBox></span> 
  <span style="position:absolute; margin-top:25px; display:none;"> y : <asp:TextBox ID="ypos" runat="server" ></asp:TextBox></span>
    <asp:HiddenField ID="HF_Array_OF_String" runat="server" />
    <asp:HiddenField ID="HF_Trash_Array_String" runat="server" />
  
    <asp:GridView ID="Grd_PAramaeter" runat="server" Visible="False">
    </asp:GridView>
    
    
    <asp:DataList ID="DL_Point_Summary" runat="server" DataSourceID="SDS_DL" Width="58%" style="margin-left:10px; border:#CCC solid 1px;"  >
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
        SelectCommand="SELECT     '~/diagrams_001/diagram_imgs/mark_a' + RIGHT(Img_ID, LEN(Img_ID) - 4) + '.png' AS ImgPath, Description&#13;&#10;FROM         Images_Data&#13;&#10;WHERE     (Reg_No = @Reg_No)AND (YearlyNo = @YearlyNo)AND (Pic_ID = 8)&#13;&#10;and not(((X >= 530) and (X <= 600)) and ((Y >= 180) and (Y <= 260)))&#13;&#10;">
        <SelectParameters>
            <asp:SessionParameter Name="Reg_No" SessionField="Registrationno" />
            <asp:SessionParameter DefaultValue="YearlyNo" Name="YearlyNo" SessionField="YearlyNo" />
        </SelectParameters>
    </asp:SqlDataSource>
 
  
</form>
</body>
</html>
