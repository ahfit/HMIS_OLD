<%@ Page Language="VB" AutoEventWireup="true" CodeFile="OPD_Encounter_Form.aspx.vb" Inherits="OPD_Encounter_Form" MaintainScrollPositionOnPostback="true" MasterPageFile="~/hacims_masterpage.master" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	
    <link rel="stylesheet" href="../resources/js/jquery.mCustomScrollbar.css??" />
	<script src="../resources/js/jquery.mCustomScrollbar.concat.min.js"></script>
 
	<link rel="stylesheet" href="../resources/css/jquery-ui.css">
    <script src="../resources/js/jquery-ui.js"></script>
    <script src="../resources/js/jquery.ui.touch-punch.min.js"></script>

    <script type="text/javascript">
	  
         


        $(document).ready(function () {
			
			
			
$(".leftMenu_Divcnt").mCustomScrollbar({ axis:"y",theme:"minimal-dark" });
           // var tabs = $("#accordian").accordion({
//                heightStyle: "content",
//                activate: function (event, ui) {
//                    localStorage.setItem("accIndex", $(this).accordion("option", "active"))
//                },
//                active: parseInt(localStorage.getItem("accIndex"))
//            });

        });

        $('#LinkpreviusTestPatholog').click(function () {
            
            $('div#prevoiusTest').show();
        }
            );

        $('[id$="DataList_Frequency"]').css('visibility', 'visible')
         
        if ($('[id$="hfForAutoPostBack"]').val() == "0") {

            $('[id$="rdbtnMedicines"]').val("Dept");
            $('[id$="ddlDepartmentMedicines"]').show();
            $('[id$="TextBox_specificMedicine"]').hide()
        }
        else {
            $('[id$="ddlDepartmentMedicines"]').hide();
            $('[id$="TextBox_specificMedicine"]').show()
        }


        $('[id$="rdbtnMedicines"]').change(function () {
            var text = $('[id$="rdbtnMedicines"] input[type="radio"]:checked').next().text();

            if (text == "Department Specific") {
                $('[id$="TextBox_specificMedicine"]').val("")
                $('[id$="ddlDepartmentMedicines"]').show()
                $('[id$="TextBox_specificMedicine"]').hide()
            }
            else {
                $('[id$="ddlDepartmentMedicines"]').val("0")
                $('[id$="ddlDepartmentMedicines"]').hide()
                $('[id$="TextBox_specificMedicine"]').show()
            }
        });

        $('[id$="ButtonSaveMedicine"]').click(function () {
            var text = $('[id$="rdbtnMedicines"] input[type="radio"]:checked').next().text();
            if (text == "Department Specific") {
                var value = $('[id$="ddlDepartmentMedicines"] option:selected').val();
                if (value == "0") {
                    alert("Please Select Correct Medicine")
                    return false;
                }
            }

            var MedincineCode = $('#<%=hfName.ClientID%>').val();

            if (MedincineCode == "" || $('[id$="TextBox_specificMedicine"]').val() == "") {
                alert("Please Select Correct Medicine")
                return false;
            }
            //else if (MedincineCode != "" && $('[id$="TextBox_specificMedicine"]').val() != "") {
            //    alert("Please Select Correct Medicine")
            //    return false;
            //}
        });

        $('[id$="ddlDepartmentMedicines"]').change(function () {
            var value = $('[id$="ddlDepartmentMedicines"] option:selected').val();
            if (value == "0") {
                alert("Please Select Correct Medicine")
                return false;
            }
            else {
                $('#<%=hfName.ClientID%>').val(value)
                }
            });





            $('#btnSave').click(function () {

                $.ajax({
                    url: 'OPD_Encounter_Form.aspx/Save',
                    method: 'POST',
                    contentType: 'application/json',
                    dataType: 'json',
                    data: JSON.stringify({
                        consultant: $('[id$="ddlDiabetologistName"] option:selected').val(),
                        stime: $('[id$="txtboxStart"]').val(), etime: $('[id$="txtboxEnd"]').val(),
                        assistant: $('[id$="ddlAssistant"] option:selected').val(), diabetiesType: $('[id$="ddlDiabetiesType"] option:selected').val(),
                        diagnosedTime: $('[id$="txtboxDate"]').val(), age: $('[id$="txtboxAge"]').val(),
                        duration: $('[id$="txtboxDuration"]').val()
                    }),
                    success: function (data) {
                        alert(data.d);
                    }
                });


            });






    </script>


    <script type="text/javascript">
        function ClientItemSelected(sender, e) {
            $get("<%=hfName.ClientID %>").value = e.get_value();
        }
        function ForRadSelected(sender, e) {
            $get("<%=hfForRad.ClientID%>").value = e.get_value();
        }




    </script>
 

    <script language="javascript" type="application/javascript">
       
	    $(document).ready(function () {
			
			
			//$("#exam_select").append();
			
			 $('.tabs_left div').each(function(index, element) {
		  
		  	   if($(this).html()=="Examination"){
			  
			  	$('.tabs_left_exam').html($(this).next('ul').html());	
			  
			   }
			   
			    if($(this).html()=="History"){
			  
			  	$('.tabs_left_history').html($(this).next('ul').html());	
				//$('#exam_select').();
				 
			     }
			   
			   
			   });  
					 
			 $(document).on("click",".tabs_left_exam a",function(e){
		  
		    var text = $(this).attr('href');
		    var Urll = "Pt_Physical_Examination_Main_HeadForIframe.aspx?" + text.split('?')[1];
		    $('[id$="IframeExamination"]').attr('src', Urll);
			e.preventDefault();
		    });
			
			 $(document).on("click",".tabs_left_history a",function(e){
		  
		    var text = $(this).attr('href');
		    var Urll = "pt_History_Main_HeadingForIframe.aspx?" + text.split('?')[1];
		    $('[id$="iframhistory"]').attr('src', Urll);
			e.preventDefault();
		    });
			  
			
            //if (window.location.search.indexOf("Medicine") > 0) {
//                $('html, body').animate({
//                    scrollTop: $("#divMedicine").offset().top
//                });
//            }
//            $('.medication li:nth-child(odd)').addClass('alternate');
			
			///////
			
			
			//var pageheight = $(document).height();
		 // $('.slideLeftMenu').height(pageheight+100);
		   
			
			///////////////////////////
			
			 
			 function updateComplaints(){
			 var pCHtml="";		 
			 var pComplaint = $("#ctl00_ContentPlaceHolder1_dataListComplaints td span").html().split(',');
			 $(pComplaint).each(function(index, element) {
                
					pCHtml +="<li>"+element+"</li>" 
				
             }); 
			
			 $(".pCHtml").html(pCHtml);
			
			 }
			 
			 updateComplaints();
			
			$(document).on("click","#add_diagnosis_btn1",function(e){
		  
		  	e.preventDefault();
 
						 $("#lightbox_bg,#pr_complaints").fadeIn(200); 
						 $("#ctl00_ContentPlaceHolder1_TextBoxComplaint_Name").focus();
			 
		    });
			
			 
			
			 $(document).on("click",".closeBox",function(e){
		  
		  	e.preventDefault();
			   
						 $(".lightbox,#lightbox_bg").fadeOut(200); 
						 	
			 
		    });
			
			
			 $(document).on("click","#show_CurrentMedicine",function(e){
		  
		  	  e.preventDefault();
			   			 $("#PreviousMedicine").hide(); 	
						 $("#CurrentMedicine").show(); 
						 $("#show_PreviousMedicine").removeClass('active');
						  $(this).addClass('active');
		      });
			
			$(document).on("click","#show_PreviousMedicine",function(e){
		  
		  	  e.preventDefault();
			   			 $("#CurrentMedicine").hide(); 
						 $("#PreviousMedicine").show(); 
						  $("#show_CurrentMedicine").removeClass('active');
			 			 $(this).addClass('active');	
		      });
			  
			   $(document).on("click","#show_CurrentTest",function(e){
		  
		  	  e.preventDefault();
			   			 $("#PreviousTest").hide(); 	
						 $("#CurrentTest").show(); 
						 $("#show_PreviousTest").removeClass('active');
			  			 $(this).addClass('active');
		      });
			
			$(document).on("click","#show_PreviousTest",function(e){
		  
		  	  e.preventDefault();
			   			 $("#CurrentTest").hide(); 
						 $("#PreviousTest").show(); 
						 $("#show_CurrentTest").removeClass('active');
			 			 $(this).addClass('active');	
		      });
			  
			  
			     $(document).on("click","#show_RadCurrentTest",function(e){
		  
		  	  e.preventDefault();
			   			 $("#RadPreviousTest").hide(); 	
						 $("#RadCurrentTest").show(); 
						 $("#show_RadPreviousTest").removeClass('active');
			  			 $(this).addClass('active');
		      });
			
			$(document).on("click","#show_RadPreviousTest",function(e){
		  
		  	  e.preventDefault();
			   			 $("#RadCurrentTest").hide(); 
						 $("#RadPreviousTest").show(); 
						 $("#show_RadCurrentTest").removeClass('active');
			 			 $(this).addClass('active');	
		      });
			  
			  
			     
			
			
			
			 $(document).on("focusout","#ctl00_ContentPlaceHolder1_LinkButton_Add",function(e){
		   
						   
						   updateComplaints();
				 
		      });
			    
	 			 
				  $("#sortable_listone, #sortable_listtwo").sortable({
                connectWith: ['.connectedSortable'],            
			    handle: 'h3',
                scroll: true,
                revert: false,
                stop: function( e, ui ) {
                     salvaCookie();
                }
            }); 
			
			$("#sortable_listone, #sortable_listtwo").disableSelection();
		 
		     var sortable_listone = Cookies.get('list_dragndrop_enca');
			 var sortable_listtwo = Cookies.get('list_dragndrop_encb');
			 
           if(sortable_listone){
			   sortable_listone = sortable_listone.substr(1).slice(0, -1).split(",");
		       
			   $.each(sortable_listone, function(index, value){
				  	 
					var setthis = value.substr(1).slice(0, -1);
					  	if(setthis!=""){						 
				  		$('#sortable_listone').append($('#'+setthis));
					}
        		});
		   }
		   
		    if(sortable_listtwo){
			   sortable_listtwo = sortable_listtwo.substr(1).slice(0, -1).split(",");
		       
			   $.each(sortable_listtwo, function(index, value){
				  	 
					var setthis = value.substr(1).slice(0, -1);
					  	if(setthis!=""){						 
				  		$('#sortable_listtwo').append($('#'+setthis));
					}
        		});
		   }
		   
	        
            var salvaCookie = function() {
            var ordea = $('#sortable_listone').sortable('toArray');	
			var ordeb = $('#sortable_listtwo').sortable('toArray');	 	 
            Cookies.set('list_dragndrop_enca', ordea);
			Cookies.set('list_dragndrop_encb', ordeb);
			 
      	  }
		  
		  
		  
		  
		 	
			//////////////////////////////
			
        });

    </script>

    <script language="javascript" type="text/javascript">
        function ShowPanel(Control_ID) {
            document.getElementById("HiddenFieldTextOther").value = Control_ID;
            document.getElementById('Div_Text').style.visibility = 'visible';
            //document.getElementById('Div_Text').style.left=event.clientX-100;
            document.getElementById('Div_Text').style.top = event.clientY - 100;
            document.getElementById("TextBox1").value = document.getElementById(Control_ID).value;
        }

        function Show_Text_Value() {
            var id = document.getElementById("HiddenFieldTextOther").value;
            var text = document.getElementById("TextBox1").value;
            if (id != "") {
                document.getElementById(id).value = text;
            }
            document.getElementById("HiddenFieldTextOther").value = "";
        }

    </script>
    
    
<script>

$(document).ready(function(e) {
    
	 //full_width
		 	// var showGrid = true;  var showRow = false;
			 $(document).on("click",".show_grid",function(e){
		   
						  e.preventDefault();
						     $('.show_row').removeClass('show_row_sel');
						  	$(this).addClass('show_grid_sel');
						 	$("#sortable_listone,#sortable_listtwo").css("width","49.5%");
							 $("#sortable_listtwo").css("margin-left","1%");
							 Cookies.set('showRow',false);
							 Cookies.set('showGrid',true);
						   
				 
		      });
			  
			   $(document).on("click",".show_row",function(e){
		   
						  e.preventDefault();
						  	$('.show_grid').removeClass('show_grid_sel');
						  	$(this).addClass('show_row_sel');
						    $("#sortable_listone,#sortable_listtwo").removeAttr('style');
						 	$("#sortable_listone,#sortable_listtwo").css("width","100%").css("margin-left","0");
						   	 Cookies.set('showRow',true);
				 			 Cookies.set('showGrid',false);	
		      });
			  
			 
			   var showGrid = Cookies.get('showGrid'); 
			   var showRow = Cookies.get('showRow'); 
			    
			   if(showGrid=="true") { 
			   					console.log("Grid");
				    			 $('.show_row').removeClass('show_row_sel');
						  		 $('.show_grid').addClass('show_grid_sel');
						 	     $("#sortable_listone,#sortable_listtwo").css("width","49.5%");
				   		 		 $("#sortable_listtwo").css("margin-left","1%");
				   
				   }
 				   
 				    if(showRow=="true") {
				   			console.log("Row");
								 
							$('.show_grid').removeClass('show_grid_sel');
						    $('.show_row').addClass('show_row_sel');
						    $("#sortable_listone,#sortable_listtwo").removeAttr('style');
						 	$("#sortable_listone,#sortable_listtwo").css("width","100%").css("margin-left","0");
							
				 		
				   			}
			  
		 	 
			  
			   $(document).on("click",".openIt",function(e){
		   
						  e.preventDefault();
						  
						$(this).addClass('closeIt').removeClass('openIt'); 
						  
						$(this).parent().find('.bx_01_content').css('display','block');
						var thisId = $(this).parent().find('.bx_01_content').attr('id');
						  
						 
						
						 Cookies.set('activeBx', thisId); 	
						   
				 
		      });
			  		
					
			  
			     $(document).on("click",".closeIt",function(e){
		   
						  e.preventDefault();
						  
						$(this).addClass('openIt').removeClass('closeIt');						  
						$(this).parent().find('.bx_01_content').hide();
						 Cookies.set('activeBx', null); 	   
				 
		       });
			  
					//console.log(activeBx);
					var activeBx = Cookies.get('activeBx'); 
					if(activeBx!=""){					 
					 $("#"+activeBx).css('display','block');
					 
					$("#"+activeBx+"_toggle").removeClass('openIt').addClass('closeIt');
					 
					
					}
	
	
});



</script>

    <style type="text/css">
 		.ui-state-highlight { height: 1.5em; line-height: 1.2em; background:red; }
		
		 
		
    	.main_bx { margin-top:0px !important;  float:left; margin-left:1%; background:#fff url(../resources/images/img_logo_hacimsbg.png) center center no-repeat;    }		 
		/* width:48%;*/
 	  .bx_01 { width:98%; float:none; box-sizing:border-box; padding: 10px; padding-top:15px; min-height:30px; padding-bottom:15px; float:left;    }    
      .bx_01 h3 { margin-top:-20px; cursor:move; }
      .bx_01_content { width: 100%; min-height:100px; background1:red; padding-top:5px; } 
	  
	   a.add_btn { width: 40px; height: 40px; display: block;   background: #fff; line-height: 40px; font-size: 40px; font-weight: bold; text-decoration: none; border:#ccc solid 1px; border-radius: 100%; text-align: center; color: #bbb;    position:relative;  box-shadow: 0px 3px 4px #dee1e5;   margin-top:-15px;  margin-top:-42px; float:right;     }
      
      a.add_btn:hover { color: #099;  }
  	
	
	 .pCHtml { list-style:none; display:non1e; width:99%; margin-top:5px;}
	 .pCHtml li { padding-left:10px; background:url(../resources/images/img_bullet_1.png) 0px 8px no-repeat; background-size:4px 4px; width:auto; font-weight:bold; color:#cb2d2d; border-bottom1:#eee dotted 1px; height:20px; line-height:20px; float:left; display:inline-block; margin-left:10px;}
	
	 .small_tabs_cnt {text-align:center; background:red1; width:100%; height:32px; display:block;}
	  .small_tabs { list-style:none; width:auto;    }
	  .small_tabs li { float:left1;     list-style:none; height:35px; width:auto; display:inline-block; }
	  .small_tabs li a {    height:30px; display:block; padding-left:15px; padding-right:15px; line-height:30px; text-align:center; color:#555; font-weight:bold; border:#ccc solid 1px; text-decoration:none; font-size:14px; background-image: linear-gradient(#fff 10%, #eaeaea); margin-right:-3px;    }
	   .small_tabs li a.active { background:#006dae; color:#fff; box-shadow:inset 0px 0px 12px #00253c;     }
	   
	   
	  .small_tabs li a.first { border-bottom-left-radius:25px;  border-top-left-radius:25px; border-right:rgba(255,255,255,.2) solid 1px;    }
	 .small_tabs li a.last { border-bottom-right-radius:25px;  border-top-right-radius:25px;  border-left:rgba(255,255,255,.2) solid 1px;     }
		

		.list_diagnosis { list-style:none; }
		.list_diagnosis li { float:left; width:100%; border-bottom:#CCC dashed 1px; min-height:25px; line-height:inherit; padding-top:5px; padding-bottom:5px; }
		.list_diagnosis li .diseaseDate { font-weight:bold; padding-right:8px; border-right:#ccc solid 1px; }
		.list_diagnosis li .codeName {   }
		.list_diagnosis li .diseaseName {  font-weight:bold; color:#C30; padding-left:8px; text-transform:capitalize;  }
		.list_diagnosis li .cancelLink { float:right;    }
		
		.plainBtn { border:none; height:20px; padding-left:5px; padding-right:5px;    }


		
		.tabs_left_history { width:200px; height:auto; box-shadow: 0px 3px 4px #dee1e5; float:left; border:#ccc solid 1px; background:#fff; border-radius:4px; display:none; position:absolute; z-index:1;   }
		.tabs_left_history li { float:left; height:25px; border-bottom:#ccc dotted 1px; width:100%;  padding-left:15px;}
		.tabs_left_history li a { width:100%; height:100%; line-height:25px; font-size:14px; text-decoration:none; box-sizing:border-box;}
		.tabs_left_history li:last-child { border-bottom:none; }
		.tabs_left_history li a:hover { text-decoration:underline; }
		
		
		.tabs_left_exam { width:250px; height:auto; box-shadow: 0px 3px 4px #dee1e5; float:left; border:#ccc solid 1px; background:#fff; border-radius:4px; display:none; position:absolute; z-index:1;   }
		.tabs_left_exam li { float:left; height:25px; border-bottom:#ccc dotted 1px; width:100%;  padding-left:15px;}
		.tabs_left_exam li a { width:100%; height:100%; line-height:25px; font-size:14px; text-decoration:none; box-sizing:border-box;}
		.tabs_left_exam li:last-child { border-bottom:none; }
		.tabs_left_exam li a:hover { text-decoration:underline; }
		 


.dropbtn { color:#333; cursor:pointer; font-size:15px; font-weight:bold; width:auto; height:35px; line-height:35px; }
.dropbtn span { width:35px; height:35px; float:left; display:inline-block;   margin-right:0px; background:#fff url(../resources/images/menu.svg) center center no-repeat; background-size:50%; } 
.dropdown { position: relative; display: inline-block; }  
.dropdown:hover .tabs_left_history {display: block;}


.dropbtnb { color:#333; cursor:pointer; font-size:15px; font-weight:bold; width:auto; height:35px; line-height:35px; }
.dropbtnb span { width:35px; height:35px; float:left; display:inline-block;   margin-right:0px; background:#fff url(../resources/images/menu.svg) center center no-repeat; background-size:50%; } 
.dropdownb { position: relative; display: inline-block; }  
.dropdownb:hover .tabs_left_exam {display: block;}
 

.view_style { float:right; list-style:none; margin-top:8px; margin-left:10px; }
.view_style  li { list-style:none; width:auto; display:inline-block;    }
.view_style  li a.show_grid { width:25px; height:25px;  display:block; background:url(../resources/images/img_grid.png) 0px 0px no-repeat; background-size:25px; margin-right:10px; }
.view_style  li a.show_grid_sel { width:25px; height:25px;  display:block; background:url(../resources/images/img_grid_sel.png) 0px 0px no-repeat; background-size:25px; margin-right:10px; }
.view_style  li a.show_row { width:25px; height:25px;  display:block; background:url(../resources/images/img_row.png) 0px 0px no-repeat; background-size:25px; margin-right:10px;  }
.view_style  li a.show_row_sel { width:25px; height:25px;  display:block; background:url(../resources/images/img_row_sel.png) 0px 0px no-repeat; background-size:25px; margin-right:10px;  }


a.openIt { width:25px; height:25px; border-radius:100px; display:block; float:right; margin-right:0px;  box-shadow: 0 3px 3px rgba(0, 0, 0, 0.1); border:#ccc solid 1px; margin-top:-28px; 
 background:#f1f1f1 url(../resources/images/img_arrowright.png) 9px 7px no-repeat;  
 background-size: 6px 11px;
   }
a.closeIt { width:25px; height:25px; border-radius:100px; display:block; float:right; margin-right:0px;  box-shadow:inset 0 0px 6px rgba(0, 0, 0, 0.3); border:#999 solid 1px; margin-top:-28px; 
 background:#f1f1f1 url(../resources/images/img_downarrow.png) 5px 10px no-repeat;  
 background-size: 13px 6px;
   }  
 
   .hidebx1 { display:none; }
    
	#sortable_listone, #sortable_listtwo { width:49.5%; display:block; float:left;   }
	#sortable_listtwo { margin-left:1%;   }
	.pageContent {   height:100%; display:none; }
	
	@media only screen and (max-width: 600px) {
		
		#sortable_listone, #sortable_listtwo { width:100%;  margin-left:0;      }
		 
		
	}

    </style>

<!--PhilHealth_Form-->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="lightbox_bgm"></div>
    <div class="slideLeftMenu">
        <div id="menuScroll">
            <asp:Label ID="SideMenu" runat="server" Visible="true"></asp:Label></div>
    </div>
    <div class="main_bx">
        <div style="height: 32px; min-width: 100px; text-align: right; margin-top:8px; margin-right: 20px">
              <asp:HyperLink id="hyperlink1" 
                  NavigateUrl="/HMIS2/Doctor_Main_Page_New.aspx"
                  Text="Back"
                  runat="server"/> 
            <asp:Button ID="btnreport" runat="server" OnClick="btnreport_Click" Text="Report"></asp:Button>
            &nbsp;</div>
      
         <div class="leftMenu_div" style="margin-top:8px;">
     		 <div class="leftMenu_divcnt"></div>
   	 </div><!--leftMenu_div-->
        
        <div class="pageContent" style="width:100%; padding-left:230px; padding-top:0; box-sizing:border-box;">
           
            <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true">
                <Services>
                    <asp:ServiceReference Path="../autocomplete.asmx" />
                </Services>
            </asp:ScriptManager>

            <asp:HiddenField ID="hfForRad" runat="server" />


            <div class="connectedSortable" id="sortable_listone">

                <div class="bx_01" id="box_pr_complaints">
                    <h3>Presenting Complaints</h3>
                    <a href="#" class="closeIt" id="presentingComplaints_bx_toggle"></a>
 			
 	
                        <asp:UpdatePanel ID="updatepanel1" runat="server">
                            <ContentTemplate>
                          
                                <asp:DataList ID="dataListComplaints" Width="100%" runat="server" DataSourceID="SqlDataSourceShowComplaints" Style="display: 1none;" RepeatLayout="Flow">
                                    <ItemTemplate>
                                   
                                        <asp:Label ID="Label1" runat="server" Style="font-weight:bold; color:#cb2d2d;" Text='<%# Eval("Complaints") %>'></asp:Label>
                                        
                                    </ItemTemplate>
                                </asp:DataList>
                                
                                
                                <cc1:AutoCompleteExtender
                                    ID="AutoComplete_Complaint"
                                    runat="server"
                                    CompletionListCssClass="AutoExtender"
                                    CompletionListItemCssClass="AutoExtenderList"
                                    CompletionListHighlightedItemCssClass="AutoExtenderHighlight"
                                    CompletionInterval="10"
                                    CompletionSetCount="12"
                                    EnableCaching="true"
                                    MinimumPrefixLength="3"
                                    ServiceMethod="pre_complaint"
                                    ServicePath="../AutoComplete.asmx"
                                    TargetControlID="TextBoxComplaint_Name">
                                </cc1:AutoCompleteExtender>

                                <asp:HiddenField ID="hfName" runat="server" />

	                   <div class="bx_01_content" id="presentingComplaints_bx" style="display: block; min-height: 75px;">
 


                                <asp:Panel ID="pnlPresentingComplaints" runat="server" DefaultButton="LinkButton_Add" Width="100%" Style="float: left;">
                                    <div class="bx_style_1" style="width: 100%; margin-bottom: 0; margin-top:10px; float: none;">
                                        <table>
                                            <tr>
                                                <td>
                                                    <ul class="form_list_s" style="width: 100%; margin-left: 10px;">
                                                        <li>
                                                            <label></label>
                                                            <asp:TextBox ID="TextBoxComplaint_Name" PlaceHolder="Complaint" runat="server" Width="200px"></asp:TextBox>
                                                            <asp:Button ID="ButtonSearch" runat="server" Text="Search" Width="55px" Visible="false" />
                                                        </li>
                                                        <li style="margin-left: 10px;">
                                                            <label></label>
                                                            <asp:TextBox ID="TextBoxDuration" runat="server" SkinID="intdata" PlaceHolder="Duration" Width="70px"></asp:TextBox></li>
                                                        <li style="margin-left: 5px;">
                                                            <label></label>
                                                            <asp:DropDownList ID="DropDownListDuration" runat="server" Width="75px">
                                                                <asp:ListItem>Hours</asp:ListItem>
                                                                <asp:ListItem>Days</asp:ListItem>
                                                                <asp:ListItem>Week</asp:ListItem>
                                                                <asp:ListItem>Month</asp:ListItem>
                                                                <asp:ListItem>Year</asp:ListItem>
                                                            </asp:DropDownList>

                                                        </li>
                                                        <li style="margin-left: 10px;">
                                                            <label></label>
                                                            <asp:LinkButton ID="LinkButton_Add" CssClass="btn_hacims lnkBtnNormalText" runat="server" OnClick="LinkButton_Add_Click" Style="min-width:65px;">Save</asp:LinkButton>
                                                            <asp:LinkButton ID="LinkButton_Cancel" runat="server" Visible="False">Cancel</asp:LinkButton></li>
                                                    </ul>
                                                </td>
                                            </tr>
                                        </table>

                                    </div>
                                </asp:Panel>

                                <asp:HiddenField ID="HiddenFieldChief_Complaint" runat="server" Value="0" />
                                <asp:HiddenField ID="HiddenFieldComplaint_ID" runat="server" Value="0" />
                                <asp:HiddenField ID="HiddenField_Complaint_new" runat="server" />
                                <asp:SqlDataSource ID="SqlDataSourceSaveComplaints" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                    InsertCommand="Insert_Patient_Complaint" ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                    InsertCommandType="StoredProcedure">
                                    <InsertParameters>
                                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                                        <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                                        <asp:ControlParameter ControlID="HiddenFieldComplaint_ID" Name="Complaint_ID" PropertyName="Value" />
                                        <asp:SessionParameter Name="empid" SessionField="emp_id" />
                                        <asp:ControlParameter ControlID="HiddenFieldChief_Complaint" Name="Chief_Complaint"
                                            PropertyName="Value" />
                                    </InsertParameters>
                                </asp:SqlDataSource>


                                <asp:SqlDataSource ID="SqlDataSourceShowComplaints" runat="server" SelectCommand="usp_GetPatientCompalints"
                                    SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                                        <asp:SessionParameter Name="YearlyNo" SessionField="Yearlyno" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
								</div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <!-- <table style="width:100%;"><tr><td> <ul class="pCHtml"></ul></td></tr></table>-->

                    
                </div>


                <!--///////////////////////////////////////////////////////////////////////////////////////////////////////////-->
                <div class="bx_01" id="box_histories">
                    <h3>History</h3>
                    <a href="#" class="closeIt" id="history_bx_toggle"></a>
                    <div class="bx_01_content" id="history_bx" style="display: block;">

                        <asp:UpdatePanel ID="updatepanel8" runat="server">
                            <ContentTemplate>



                                <div class="dropdown">
                                    <div class="dropbtn"><span></span>Select History</div>

                                    <ul class="tabs_left_history" id="tabs_history"></ul>

                                </div>

                                <asp:Label ID="LabelSideMenu" runat="server"></asp:Label>

                                <asp:TreeView ID="TreeView1" runat="server" CssClass="Grid_tree" ShowLines="True" SelectedNodeStyle-CssClass="SelectedNodeStyle" ExpandDepth="0"></asp:TreeView>

                                <asp:Panel ID="panel_Remarks" Visible="false" runat="server">
                                    <div class="bx_infos_patients" style="margin-left: 46px; height: 294px;">
                                        <h2>
                                            <span>Remarks (
                                                    <asp:Literal ID="lblRemarkCategory" runat="server" Text=""></asp:Literal>
                                                )</span></h2>
                                        <div class="bxinfo_margin">
                                            <asp:TextBox ID="TextBox_Remarks" runat="server" Height="200px" TextMode="MultiLine"
                                                Width="99%"></asp:TextBox>
                                        </div>
                                    </div>
                                </asp:Panel>

                                <div style="margin-left: 31px; display: none;" class="bx_infos_patients">
                                    <div class="bxinfo_margin">
                                        <asp:Panel ID="Panel_history" runat="server" Width="100%">
                                        </asp:Panel>

                                        <asp:Panel ID="Panel1" runat="server" Width="100%">
                                        </asp:Panel>
                                    </div>
                                </div>

                                <div style="margin-left: 70px; display: none" class="bx_infos_patients">
                                    <h2>
                                        <span>Previous Remarks
                                        </span></h2>
                                    <div class="bxinfo_margin">
                                        <asp:DataList ID="dataListPreviousRemarks" runat="server" DataSourceID="SqlDataSource_select_all"
                                            Width="80%" Style="margin-left: 2px;">
                                            <ItemTemplate>
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form" style="border-bottom: #CCC dotted 1px;">
                                                    <tr>
                                                        <td style="padding-bottom: 5px;">
                                                            <strong>
                                                                <asp:Label ID="Complaint_NameLabel" runat="server" Text='<%# Eval("MH_Heading") %>'></asp:Label></strong><br />
                                                            <asp:LinkButton ID="LinkButton_Description" runat="server" CommandName="Select" CssClass="linkc"
                                                                Text='<%# Eval("Remarks") %>'></asp:LinkButton></td>
                                                    </tr>
                                                </table>
                                                <asp:HiddenField ID="HiddenField_Complaint_ID" runat="server" Value='<%# Eval("MH_Code", "{0}") %>' />
                                            </ItemTemplate>
                                        </asp:DataList>

                                        <asp:SqlDataSource ID="SqlDataSource_select_all" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                                            InsertCommand="Insert_ComplaintMainGroup" InsertCommandType="StoredProcedure"
                                            ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                            SelectCommand="OPD_previous_history_exam" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                                                <asp:ControlParameter ControlID="HiddenField_root" Name="type" PropertyName="Value"
                                                    Type="String" />
                                            </SelectParameters>
                                            <InsertParameters>
                                                <asp:Parameter Direction="Output" Name="Complaint_ID" Type="Int32" />
                                                <asp:ControlParameter ControlID="TextBoxComplaint_Name" Name="Description" PropertyName="Text"
                                                    Type="String" />
                                            </InsertParameters>
                                        </asp:SqlDataSource>


                                    </div>
                                </div>
                                <asp:Button ID="Button4" runat="server" Text="save" Visible="false"></asp:Button>
                                <asp:SqlDataSource ID="SqlDataSource_OPD_Encounter_Form_Remarks" runat="server"
                                    SelectCommand="SELECT  [Remarks] FROM [OPD_Encounter_Form_Remarks] where [Reg_No]=@Reg_No and  [Yearly_No]=@Yearly_No And MH_Code = @MH_Code"
                                    ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>" UpdateCommand="UPDATE [OPD_Encounter_Form_Remarks] SET [Remarks] = @Remarks WHERE [Reg_No] = @Reg_No AND [Yearly_No] = @Yearly_No AND [MH_Code] = @MH_Code"
                                    InsertCommand="OPD_Encounter_Form_Remarks_Insert" DeleteCommand="DELETE FROM [OPD_Encounter_Form_Remarks] WHERE [Reg_No] = @Reg_No AND [Yearly_No] = @Yearly_No AND [MH_Code] = @MH_Code"
                                    InsertCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" />
                                        <asp:SessionParameter Name="Yearly_No" SessionField="Yearlyno" />
                                        <asp:ControlParameter ControlID="HiddenField_MH_Code" Name="MH_Code" PropertyName="Value" />
                                    </SelectParameters>
                                    <DeleteParameters>
                                        <asp:Parameter Name="Reg_No" Type="String" />
                                        <asp:Parameter Name="Yearly_No" Type="String" />
                                        <asp:Parameter Name="MH_Code" Type="Int32" />
                                    </DeleteParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="Remarks" Type="String" />
                                        <asp:Parameter Name="Reg_No" Type="String" />
                                        <asp:Parameter Name="Yearly_No" Type="String" />
                                        <asp:Parameter Name="MH_Code" Type="Int32" />
                                    </UpdateParameters>
                                    <InsertParameters>
                                        <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" Type="String" />
                                        <asp:SessionParameter Name="Yearly_No" SessionField="Yearlyno" Type="String" />
                                        <asp:ControlParameter ControlID="HiddenField_MH_Code" Name="MH_Code" PropertyName="Value" Type="Int32" />
                                        <asp:ControlParameter ControlID="TextBox_Remarks" Name="Remarks" PropertyName="Text" Type="String" />
                                        <asp:ControlParameter ControlID="HiddenField_root" Name="type" PropertyName="Value" Type="String" />
                                    </InsertParameters>
                                </asp:SqlDataSource>

                                <iframe id="iframhistory" runat="server" width="100%" height="250px"></iframe>

                                <asp:HiddenField ID="HiddenField_count_val" runat="server"></asp:HiddenField>
                                <asp:HiddenField ID="HiddenField_Type" runat="server"></asp:HiddenField>

                                <div style="display: none;">
                                    <asp:Button Style="margin-top: 5px" ID="Button_Save" runat="server" Text="Save" CssClass="btn1"></asp:Button>
                                </div>


                                <asp:SqlDataSource ID="SqlDataSourcePresentComp" runat="server" ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>"
                                    SelectCommand="SELECT Admin_Complaint_MainGroup.Complaint_Name, Admin_Complaint_MainGroup.Complaint_ID, Admin_Complaint_MainGroup.Pirority FROM Admin_Complaint_MainGroup INNER JOIN Admin_Template_Presenting_Complaints ON Admin_Complaint_MainGroup.Complaint_ID = Admin_Template_Presenting_Complaints.Complaint_Id INNER JOIN Admin_Assign_Template ON Admin_Template_Presenting_Complaints.Template_Id = Admin_Assign_Template.Template_Id WHERE (Admin_Assign_Template.Dept_id = @Dept_id) AND (Admin_Assign_Template.subdept_id = @subdept_id) AND (Admin_Assign_Template.Template_Id = @Template_Id) AND (Admin_Complaint_MainGroup.Complaint_Name LIKE '%' + @Complaint_Name + '%') &#13;&#10;ORDER BY Admin_Complaint_MainGroup.Complaint_Name asc"
                                    ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="Dept_id" SessionField="dept_id" />
                                        <asp:SessionParameter DefaultValue="" Name="subdept_id" SessionField="SubDeptID" />
                                        <asp:ControlParameter ControlID="HiddenFieldTemplate_id" DefaultValue="" Name="Template_Id"
                                            PropertyName="Value" />
                                        <asp:Parameter DefaultValue="%" Name="Complaint_Name" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSourceSave" runat="server" ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                    SelectCommand="SELECT Description FROM Pt_Presenting_Complaint_saveRecord WHERE (YearlyNo = @YearlyNo) AND (RegNo = @RegNo) AND (Complaint_ID = @Complaint_ID)"
                                    ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>" InsertCommand="Insert_Patient_Complaint_out"
                                    InsertCommandType="StoredProcedure">
                                    <InsertParameters>
                                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                                        <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                                        <asp:ControlParameter ControlID="HiddenField_Mg_Code" Name="Complaint_ID" PropertyName="Value" />
                                        <asp:SessionParameter Name="empid" SessionField="emp_id" />
                                        <asp:ControlParameter ControlID="TextBox_Remarks" Name="Description" PropertyName="Text"
                                            Type="String" />
                                    </InsertParameters>
                                    <SelectParameters>
                                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                                        <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                                        <asp:ControlParameter ControlID="HiddenField_Mg_Code" Name="Complaint_ID" PropertyName="Value" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                            </ContentTemplate>
                        </asp:UpdatePanel>

                    </div>
                </div>
                <!--bx_01-->

                <!--///////////////////////////////////////////////////////////////////////////////////////////////////////////-->
                <div class="bx_01" id="box_examinations">
                    <h3>Examinations</h3>
                    <a href="#" class="closeIt" id="examination_bx_toggle"></a>
                    <div class="bx_01_content" id="examination_bx" style="display: block;">
                        <div class="dropdownb">
                            <div class="dropbtnb"><span></span>Select Examination</div>

                            <ul class="tabs_left_exam"></ul>

                        </div>


                        <asp:Label ID="labaelExamination" CssClass="examMenu" runat="server" Visible="false"></asp:Label>
                        <asp:TreeView ID="TreeViewExamination" runat="server" CssClass="Grid_tree" ShowLines="True"
                            SelectedNodeStyle-CssClass="SelectedNodeStyle" ExpandDepth="0">
                        </asp:TreeView>


                        <iframe id="IframeExamination" runat="server" width="100%" height="250px"></iframe>

                    </div>
                </div>
                <!--bx_01-->


                <!--///////////////////////////////////////////////////////////////////////////////////////////////////////////-->
                <div class="bx_01" id="box_diagnosis">
                    <h3>Diagnosis</h3>
                    <a href="#" class="closeIt" id="diagnosis_bx_toggle"></a>
                    <asp:UpdatePanel ID="updatepanelForDiagnose" runat="server">
                        <ContentTemplate>

                            <asp:DataList ID="DataList_CurrentVisitDiagnosis" runat="server" DataKeyField="Diagnosis_ID"
                                DataSourceID="SqlDataSource_DataListCurrnentDiagnosis" RepeatLayout="Flow" RepeatDirection="Horizontal" Width="100%">
                                <%--<AlternatingItemStyle CssClass="dataListAltItemStyle" BackColor="#F0F0F0"></AlternatingItemStyle>--%>
                                <ItemStyle CssClass="dataListItemStyle" />
                                <HeaderTemplate>
                                    <ul class="list_diagnosis">
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <li>
                                        <asp:Label ID="Label4" CssClass="diseaseDate" runat="server" Text='<%# Eval("Diagnose Date") %>'></asp:Label>
                                        <asp:Label ID="ICD10_CodeLabel" ToolTip="ICD10 Code name" CssClass="codeName" runat="server" Text='<%# Eval("[ICD10 Code]") %>'> </asp:Label>

                                        <asp:Label ToolTip="Disease Name" ID="DiseaseNameLabel" CssClass="diseaseName" runat="server" Text='<%# Eval("DiseaseName") %>'> </asp:Label>


                                        <asp:LinkButton ID="LinkButton_Cancel" runat="server" CommandArgument='<%# Eval("Diagnosis_ID") %>'
                                            CommandName="remove" Visible='<%# Eval("EN_DIS") %>' CssClass="cancelLink">Cancel</asp:LinkButton>

                                    </li>
                                    <asp:Label ID="YearlyNoLabel" Visible="false" runat="server" Text='<%# Eval("YearlyNo") %>'></asp:Label>
                                    <asp:Label Visible="false" ID="DoctorLabel" runat="server" Text='<%# Eval("Doctor") %>'></asp:Label>
                                    <asp:Label ID="FinalLabel" runat="server" Visible="false" Text='<%# Eval("Final") %>'></asp:Label>
                                    <asp:Label ID="Diagnosis_IDLabel" Visible="false" runat="server" Text='<%# Eval("Diagnosis_ID") %>'> </asp:Label>

                                </ItemTemplate>
                                <FooterTemplate></ul> </FooterTemplate>
                            </asp:DataList>

                            <cc1:AutoCompleteExtender ID="AutoComplete_Search" runat="server" CompletionListCssClass="AutoExtender"
                                CompletionListItemCssClass="AutoExtenderList" CompletionListHighlightedItemCssClass="AutoExtenderHighlight"
                                CompletionInterval="10" CompletionSetCount="12" EnableCaching="true" MinimumPrefixLength="3"
                                ServiceMethod="GetDiagnosisList" ServicePath="../AutoComplete.asmx" TargetControlID="TextBox_Diagnosis_search">
                            </cc1:AutoCompleteExtender>


                            <div class="bx_01_content hidebx" id="diagnosis_bx" style="min-height: 55px;">





                                <div class="bx_style_1" style="width: 100%; margin-top: 10px; margin-bottom: 0;">
                                    <asp:Label ID="Label_messageAddDiagnosis" runat="server" CssClass="err"></asp:Label>
                                    <table style="width: 100%;">
                                        <tr>

                                            <td>
                                                <asp:TextBox PlaceHolder="Add Diagnosis" ID="TextBox_Diagnosis_search" runat="server" AutoPostBack="True" CssClass="input_txt"
                                                    Style="width: 80%"></asp:TextBox>
                                                <asp:Button ID="btnAddDiagnosis" runat="server" Text="Save" Style="height: 32px; min-width: 65px; line-height: 30px;" />
                                                </li>
		 <asp:CheckBoxList ID="chkboxDepartmentDiagnoses" runat="server" RepeatColumns="5" RepeatDirection="Horizontal"></asp:CheckBoxList>
                                            </td>
                                        </tr>
                                    </table>
                                </div>

                                <asp:SqlDataSource ID="SqlDataSourceDiagnosis" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                    InsertCommand="INSERT INTO pt_Diagnosis(emp_id, YearlyNo, RegNo, dsCode, Past, Provisional, DiseaseName, diseaseCode) VALUES (@emp_id, @YearlyNo, @RegNo, @dsCode, @Past, @Provisional, @DiseaseName, @diseaseCode)"
                                    ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>">
                                    <InsertParameters>
                                        <asp:SessionParameter Name="emp_id" SessionField="emp_id" />
                                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                                        <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                                        <asp:ControlParameter ControlID="HiddenFieldDiagnosis" Name="dsCode" PropertyName="Value" />
                                        <asp:ControlParameter ControlID="HiddenFieldPast" Name="Past" PropertyName="Value" />
                                        <asp:ControlParameter ControlID="HiddenFieldProvisional" Name="Provisional" PropertyName="Value" />
                                        <asp:ControlParameter ControlID="HiddenFieldDisease" Name="DiseaseName" PropertyName="Value" />
                                        <asp:ControlParameter ControlID="HiddenFieldDiagnosis" Name="diseaseCode" PropertyName="Value" />
                                    </InsertParameters>
                                </asp:SqlDataSource>
                                <asp:HiddenField ID="HiddenFieldDiagnosis" runat="server" />
                                <asp:HiddenField ID="HiddenFieldPast" runat="server" />
                                <asp:HiddenField ID="HiddenFieldProvisional" runat="server" />
                                <asp:HiddenField ID="HiddenFieldDisease" runat="server" />
                                <asp:HiddenField ID="HiddenFieldFinal" runat="server" />
                                <%--<asp:Timer ID="Timer1" runat="server" Interval="50000"></asp:Timer>--%>


                                <asp:HiddenField ID="HF_Diagnosis_ID" runat="server" />
                                <asp:SqlDataSource ID="SqlDataSource_UpdateDiagnosis" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                    InsertCommand="INSERT INTO pt_Diagnosis(emp_id, YearlyNo, RegNo, Past, Provisional, Final, DiseaseName) VALUES (@emp_id, @YearlyNo,@RegNo,@Past, @Provisional, @Final, @DiseaseName)"
                                    ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                    UpdateCommand="UPDATE    pt_Diagnosis&#13;&#10;SET              Provisional = NULL, Final = 1&#13;&#10;WHERE     (Diagnosis_ID = @Diagnosis_ID)"
                                    DeleteCommand="delete&#13;&#10;FROM         pt_Diagnosis&#13;&#10;WHERE     (Diagnosis_ID = @Diagnosis_ID) AND (YearlyNo = @YearlyNo) AND (RegNo = @RegNo)">
                                    <UpdateParameters>
                                        <asp:ControlParameter ControlID="DataList_CurrentVisitDiagnosis" Name="Diagnosis_ID"
                                            PropertyName="SelectedValue" />
                                    </UpdateParameters>
                                    <InsertParameters>
                                        <asp:SessionParameter Name="emp_id" SessionField="emp_id" />
                                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                                        <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                                        <asp:ControlParameter ControlID="HiddenFieldPastNew" Name="Past" PropertyName="Value" />
                                        <asp:ControlParameter ControlID="HiddenFieldProvisionalNew" Name="Provisional" PropertyName="Value" />
                                        <asp:ControlParameter ControlID="HiddenFieldFinalNew" Name="Final" PropertyName="Value" />
                                        <asp:ControlParameter ControlID="TextBoxDiagnosis" Name="DiseaseName" PropertyName="Text" />
                                    </InsertParameters>
                                    <DeleteParameters>
                                        <asp:ControlParameter ControlID="HF_Diagnosis_ID" Name="Diagnosis_ID" PropertyName="Value" />
                                        <asp:SessionParameter Name="YearlyNo" SessionField="yearlyno" />
                                        <asp:SessionParameter Name="RegNo" SessionField="registrationno" />
                                    </DeleteParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSource_DataListCurrnentDiagnosis" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                    SelectCommand="SELECT DISTINCT pt_Diagnosis.YearlyNo, ISNULL(Employee.Prefix, ' ') + ' ' + ISNULL(Employee.EFName, ' ') + ' ' + ISNULL(Employee.EMName, ' ') + '' + ISNULL(Employee.ELName, ' ') + ' (' + Designation.Designation_Name + ')' AS Doctor, ISNULL(pt_Diagnosis.DiseaseName, '') AS DiseaseName, ISNULL(pt_Diagnosis.dsCode, '') AS [ICD10 Code], &#13;&#10;CASE WHEN pt_Diagnosis.Provisional = 1 THEN 'Provisional' ELSE '' END AS Provisional, &#13;&#10;case when (CASE WHEN pt_Diagnosis.Provisional = 1 THEN 'Provisional' ELSE '' END  =  'Provisional') then  'Provisional' else&#13;&#10;(case when (CASE WHEN pt_Diagnosis.Final = 1 THEN 'Final' ELSE '' END = 'Final') then 'Final' else '' end) end&#13;&#10;AS Final,&#13;&#10;case when (CASE WHEN pt_Diagnosis.Provisional = 1 THEN 'Provisional' ELSE '' END  =  'Provisional') then  1 else&#13;&#10;(case when (CASE WHEN pt_Diagnosis.Final = 1 THEN 'Final' ELSE '' END = 'Final') then 0 else 1 end) end&#13;&#10;AS EN_DIS,&#13;&#10; pt_Diagnosis.Diagnosis_ID, CONVERT (varchar, pt_Diagnosis.DiagnoseDate, 103) AS [Diagnose Date] FROM Designation RIGHT OUTER JOIN Employee ON Designation.Designation_ID = Employee.DesignationID RIGHT OUTER JOIN pt_Diagnosis ON Employee.EmpID = pt_Diagnosis.emp_id WHERE (pt_Diagnosis.YearlyNo = @yearlyNo) AND (pt_Diagnosis.RegNo = @regno)">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="yearlyNo" SessionField="yearlyno" />
                                        <asp:SessionParameter Name="regno" SessionField="registrationno" />
                                    </SelectParameters>
                                </asp:SqlDataSource>


                                <asp:SqlDataSource ID="SqlDataSourceGridView" runat="server" ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                    SelectCommandType="StoredProcedure" SelectCommand="pt_get_diagnosis_OPD_Encounter"
                                    ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>" UpdateCommand="UPDATE pt_Diagnosis SET Past = @Past, Provisional = @Provisional, Final = @Final WHERE (Diagnosis_ID = @Diagnosis_ID)"
                                    DeleteCommand="DELETE FROM pt_Diagnosis WHERE (Diagnosis_ID = @Diagnosis_ID)">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="COD" SessionField="YearlyNo" Type="String" />
                                        <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
                                    </SelectParameters>
                                    <DeleteParameters>
                                        <asp:ControlParameter ControlID="GridView3" Name="Diagnosis_ID" PropertyName="SelectedValue" />
                                    </DeleteParameters>
                                    <UpdateParameters>
                                        <asp:ControlParameter ControlID="GridView3" Name="Diagnosis_ID" PropertyName="SelectedValue" />
                                        <asp:ControlParameter ControlID="HiddenFieldPastUpdate" Name="Past" PropertyName="Value" />
                                        <asp:ControlParameter ControlID="HiddenFieldProvisonalUpdate" Name="Provisional"
                                            PropertyName="Value" />
                                        <asp:ControlParameter ControlID="HiddenFieldFinalUpdate" Name="Final" PropertyName="Value" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>



                            </div>

                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
                <!--bx_01-->


                <!--///////////////////////////////////////////////////////////////////////////////////////////////////////////-->
                <div class="bx_01" id="box_medicine">
                    <h3>Medicine</h3>
                    <a href="#" class="closeIt" id="medicine_bx_toggle"></a>
                    <asp:UpdatePanel ID="updatepanel4" runat="server">
                        <ContentTemplate>
                            <div class="bx_01_content" id="medicine_bx" style="display: block;">

                                <div class="small_tabs_cnt" style="display: block;">
                                    <ul class="small_tabs">
                                        <li><a href="#" class="first active" id="show_CurrentMedicine">Current</a></li>
                                        <li><a href="#" class="last" id="show_PreviousMedicine">Previous</a></li>
                                    </ul>
                                </div>
                                <div id="CurrentMedicine">
                                    <cc1:AutoCompleteExtender ID="GetMedication" runat="server" TargetControlID="TextBox_specificMedicine"
                                        ServicePath="../AutoComplete.asmx" ServiceMethod="GetMedication" MinimumPrefixLength="3"
                                        EnableCaching="true" CompletionSetCount="12" CompletionListHighlightedItemCssClass="AutoExtenderHighlight"
                                        CompletionListItemCssClass="AutoExtenderList" CompletionListCssClass="AutoExtender" OnClientItemSelected="ClientItemSelected"
                                        CompletionInterval="10">
                                    </cc1:AutoCompleteExtender>


                                    <asp:TextBox ID="TextBox_Medicine" runat="server" Height="1px" Visible="false" Width="1px"></asp:TextBox>
                                    <asp:RadioButtonList RepeatDirection="Horizontal" ID="rdbtnMedicines" runat="server">
                                        <asp:ListItem Text="All" Selected="True" Value="All"></asp:ListItem>
                                        <asp:ListItem Text="Department Specific" Value="Dept"></asp:ListItem>
                                    </asp:RadioButtonList>


                                    <asp:RadioButtonList ID="RadioButtonList_HospitalMed" runat="server" Visible="false" AutoPostBack="True"
                                        RepeatColumns="2">
                                        <asp:ListItem Selected="True" Value="0">All</asp:ListItem>
                                        <asp:ListItem Value="1">Hospital Stock</asp:ListItem>
                                    </asp:RadioButtonList>


                                    <div class="bx_style_1" style="width: 100%; float: left;">

                                        <ul class="form_list_s" style="width: auto;">

                                            <li>
                                                <label>Name</label>
                                                <asp:TextBox AccessKey="n" Style="width: 250px" ID="TextBox_specificMedicine" runat="server" CssClass="input_txt" AutoPostBack="false"></asp:TextBox>

                                                <asp:DropDownList Width="100%" Visible="false" ID="ddlDepartmentMedicines" runat="server"></asp:DropDownList>

                                                <asp:TextBox AccessKey="n" Style="width: 100%" ID="TextBox_specificMedicine_hs" runat="server" CssClass="input_txt" AutoPostBack="True" Visible="false"></asp:TextBox>
                                                <br />
                                                <asp:Label ID="Label1" runat="server" CssClass="red"></asp:Label></li>
                                            <li style="margin-left: 10px;">
                                                <label>Route</label>
                                                <asp:DropDownList ID="DropDownList_route" runat="server" Style="width: 100%" DataSourceID="SqlDataSource_route"
                                                    DataValueField="Id" DataTextField="Description">
                                                </asp:DropDownList>
                                                <asp:DropDownList ID="DropDownList_dosage" Visible="false" runat="server" Style="width: 100%" DataSourceID="SqlDataSource_dosage"
                                                    DataValueField="Name" DataTextField="Name">
                                                </asp:DropDownList></li>
                                            <li style="margin-left: 5px;">
                                                <label>Frequency</label>
                                                <asp:DropDownList ID="DropDownList_frequencyName" runat="server" Width="85px" DataSourceID="SqlDataSource_frequency"
                                                    AutoPostBack="false" DataValueField="id" DataTextField="Name">
                                                </asp:DropDownList>
                                                <asp:TextBox ID="TextBox_Frequency" runat="server" Width="16px"
                                                    AutoPostBack="True" CssClass="dataListAltItemStyle " Style="display: none">1</asp:TextBox>

                                                <ul id="CollapsiblePanel1" style="display: none;">
                                                    <li style="text-align: right">
                                                        <asp:ImageButton ID="ImageButton_Frequency_ShowHide" OnClick="ImageButton_Frequency_ShowHide_Click"
                                                            runat="server" ImageUrl="../images_hacims/add.png"></asp:ImageButton></li>
                                                    <li>
                                                        <asp:DataList ID="DataList_Frequency" runat="server" RepeatDirection="Horizontal"
                                                            RepeatColumns="10" DataSourceID="SqlDataSource_FrequencyDataList" DataKeyField="Frequency_Sub_Id"
                                                            Visible="false">
                                                            <ItemTemplate>
                                                                <div class="medbg">
                                                                    <asp:Label ID="FrequencyLabel" runat="server" Text='<%# Eval("Frequency") %>' Style="display: block; font-family: arial; font-size: 9px;"></asp:Label>
                                                                    <asp:TextBox ID="TextBox_dosage2" runat="server" Width="30px" Style="height: 12px; display: inline;">1</asp:TextBox>
                                                                    <asp:HiddenField ID="HF_F_S_Id" runat="server" Value='<%# Eval("Frequency_Sub_Id") %>' />
                                                                </div>
                                                            </ItemTemplate>
                                                        </asp:DataList>
                                                    </li>
                                                </ul>


                                            </li>
                                            <li style="margin-left: 5px;">
                                                <label>Days</label>
                                                <asp:TextBox ID="TextBox_days" runat="server" CssClass="input_txt" Style="width: 50px" AutoPostBack="false">1</asp:TextBox>
                                                <asp:CheckBox ID="CheckBox_CT" runat="server" Text="CT" Visible="False"></asp:CheckBox></li>
                                            <li style="margin-left: 10px;">
                                                <label>Start Date</label><igsch:WebDateChooser ID="WebDateChooserStartDate" runat="server" CssClass="drop_date" Style="border: #ccc solid 1px; height: 30px;"
                                                    Width="100px" Value="2008-01-16">
                                                    <CalendarLayout Culture="English (United Kingdom)">
                                                    </CalendarLayout>
                                                </igsch:WebDateChooser>
                                                <igsch:WebDateChooser ID="WebDateChooserEndDate" runat="server" CssClass="drop_date"
                                                    Width="100px" Visible="false" Value="2010-06-17">
                                                    <AutoPostBack ValueChanged="True" />
                                                    <CalendarLayout Culture="English (United Kingdom)">
                                                    </CalendarLayout>
                                                </igsch:WebDateChooser>
                                            </li>
                                            <li style="margin-left: 5px;">
                                                <label>Med. Type</label>
                                                <asp:DropDownList ID="ddlMedicineType" runat="server" Style="width: 100%">
                                                    <asp:ListItem Text="Discharge Medicine" Value="Discharge Medicine"></asp:ListItem>
                                                    <asp:ListItem Text="Emergency Treatment" Value="Emergency Treatment"></asp:ListItem>
                                                </asp:DropDownList></li>
                                            <li style="margin-left: 5px;">
                                                <label>Before Meal</label><asp:DropDownList ID="DropDownList_Meal" runat="server" Width="87px" Visible="false">
                                                    <asp:ListItem Value="NA">.NA</asp:ListItem>
                                                    <asp:ListItem Value="Before Meal">Before</asp:ListItem>
                                                    <asp:ListItem Value="After Meal">After</asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:TextBox ID="txtboxBeforeMeal" TextMode="MultiLine" Style="width: 100%; height: 35px;" runat="server"></asp:TextBox>
                                                <asp:DropDownList ID="DropDownList_Medicine_Advice_Category" runat="server" DataSourceID="SqlDataSource_Medicine_Advice_Category"
                                                    Visible="false" DataValueField="Medicine_Advice_Category_ID" DataTextField="Medicine_Advice_Category_Name">
                                                </asp:DropDownList>
                                                <asp:DropDownList ID="DropDownList_diution" runat="server" Width="65px" DataSourceID="SqlDataSource_dilution"
                                                    Visible="False" DataValueField="name" DataTextField="name">
                                                </asp:DropDownList>
                                                <asp:TextBox ID="TextBox_dilution" runat="server" CssClass="input_txt" Width="25px"
                                                    Visible="False"></asp:TextBox>
                                                <asp:Label ID="Label_Dilution" runat="server" Text="Dilution" Visible="False"></asp:Label></li>
                                            <li style="margin-left: 5px;">
                                                <label>After Meal</label><asp:TextBox ID="txtboxAfterMeal" TextMode="MultiLine" Style="width: 100%; height: 35px;" runat="server"></asp:TextBox></li>
                                            <li style="margin-left: 5px;">
                                                <label>Comments</label><asp:TextBox ID="TextBoxInstruction" Style="width: 100%; height: 35px;" runat="server" TextMode="MultiLine" CssClass="input_txt"></asp:TextBox></li>

                                        </ul>
                                    </div>


                                    <div align="center" style="padding: 10px;">
                                        <asp:TextBox ID="TextBox_dosage" runat="server" CssClass="input_txt" Width="25px"
                                            Visible="False">1</asp:TextBox>
                                        <asp:Button ID="ButtonSaveMedicine" runat="server" Text="Save" OnClick="ButtonSaveMedicine_Click"
                                            CausesValidation="False"></asp:Button>
                                        <asp:Button ID="Button_UpdateMedicine" runat="server" Text="Update" Visible="False"
                                            OnClick="Button_UpdateMedicine_Click" CausesValidation="False"></asp:Button>
                                        <asp:Label ID="LabelMessageMedicine" runat="server" Font-Bold="True" CssClass="red"></asp:Label>
                                    </div>


                                    <asp:UpdatePanel ID="UpdatePanelMedicine" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
                                        <ContentTemplate>

                                            <div style="width: 100%; text-align: right;">
                                                <asp:LinkButton ID="lnkButtonDetailSlip" CssClass="plainBtn" runat="server" Text="View Detail Slip" PostBackUrl="~/Pt_EMR/MedicineDetailSlip.aspx"></asp:LinkButton>
                                                <asp:LinkButton ID="lnkReport" CssClass="plainBtn" runat="server" Text="View Slip" PostBackUrl="~/Pt_EMR/MedicineSlip.aspx"></asp:LinkButton>


                                            </div>

                                            <asp:DataList ID="DataList_ConfirmedPrescriptions" runat="server" DataKeyField="priscription_id"
                                                DataSourceID="SqlDataSource_Confirmed_Prescriptions" RepeatLayout="Flow"
                                                Width="100%">

                                                <ItemTemplate>
                                                    <ul class="medication_cnt">

                                                        <li>
                                                            <asp:ImageButton ID="btn_delete"
                                                                CommandArgument='<%# Eval("priscription_id") %>' runat="server"
                                                                ImageUrl="~/resources/images/img_delgray.png" CssClass="right_btn_delete" OnClick="btn_delete_Click" /></li>
                                                        <li><span class="mname"><%# Eval("[Medicine_Name]")%></span>
                                                            <%#Eval("Para")%>
                                                        </li>
                                                        <li>
                                                            <%#Eval("para_Urdu")%>
                                                        </li>

                                                        <asp:HiddenField ID="HiddenField_PrescriptionID" runat="server" Value='<%# Eval("priscription_id") %>' />
                                                    </ul>
                                                </ItemTemplate>

                                            </asp:DataList>
                                            <asp:SqlDataSource ID="SqlDataSource_Confirmed_Prescriptions" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                                DeleteCommand="DELETE FROM Pt_Prescription_Detail WHERE (priscription_id = @priscription_id)"
                                                SelectCommand="Select_Med_Presc_Urdu" SelectCommandType="StoredProcedure"
                                                CancelSelectOnNullParameter="False">
                                                <SelectParameters>
                                                    <asp:SessionParameter Name="RegNo" SessionField="registrationno" Type="String" />
                                                    <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
                                                </SelectParameters>
                                                <DeleteParameters>
                                                    <asp:ControlParameter ControlID="HiddenField_Prescription_Id" Name="priscription_id"
                                                        PropertyName="Value" />
                                                </DeleteParameters>
                                            </asp:SqlDataSource>
                                        </ContentTemplate>
                                        <%--    <Triggers>
                                         <asp:AsyncPostBackTrigger ControlID="ButtonSaveMedicine" EventName="Click" />
                                         </Triggers>--%>
                                    </asp:UpdatePanel>

                                    <asp:DataList ID="DataList_old" runat="server" DataSourceID="SqlDataSource2" Width="100%"
                                        Visible="false" DataKeyField="priscription_id">
                                        <ItemStyle CssClass="dataListItemStyle" />
                                        <AlternatingItemStyle CssClass="dataListAltItemStyle" />
                                        <ItemTemplate>
                                            <ul class="medication_cnt">
                                                <li style="border-bottom: #cccccc dotted 1px; border-right: 0; border-left: 0;"><strong
                                                    class="mname"><%# Eval("[Medicine Name]") %></strong>
                                                </li>
                                                <li>Dosage : <span class="darkc">
                                                    <%# Eval("Doze") %>
                                                </span><span>|</span>Frequency : <span class="darkc">
                                                    <%# Eval("Qty") %>
                                                </span><span>|</span>Start Date : <span class="darkc">
                                                    <%# Eval("[Start Date]") %>
                                                </span><span>|</span>End Date : <span class="darkc">
                                                    <%# Eval("[End Date]") %>
                                                </span><span>| <span style="color: #6f6f6f">Doctor : </span>&nbsp;<asp:Label ID="Label5"
                                                    runat="server" Text='<%# Eval("DOCTOR") %>'></asp:Label>
                                                    |&nbsp;</span><span class="darkc">
                                                        <asp:Label ID="Label_Date" runat="server" Text='<%# Eval("date") %>'></asp:Label>
                                                        <%--<asp:LinkButton ID="LinkButton_Edit" runat="server" CausesValidation="False" CommandName="Select"
                                                    CssClass="editit" ToolTip="Edit Medicine"></asp:LinkButton>--%>
                                                        <asp:HiddenField ID="HiddenField3" runat="server" />
                                                        <%# Eval("CT") %>
                                                    </span></li>
                                            </ul>
                                        </ItemTemplate>
                                    </asp:DataList>
                                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                        SelectCommand="OPD_Encounter_Medication_prev" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="RegNo" SessionField="registrationno" Type="String" />
                                            <asp:SessionParameter Name="YearlyNo" SessionField="yearlyno" Type="Decimal" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>

                                    <asp:DataList ID="DataList_new" runat="server" DataSourceID="SqlDataSource1" Width="100%"
                                        Visible="false" DataKeyField="priscription_id">
                                        <ItemTemplate>
                                            <ul class="medication_cnt">
                                                <li style="border-bottom: #cccccc dotted 1px; border-right: 0; border-left: 0;"><strong
                                                    class="mname">
                                                    <%# Eval("[Medicine Name]") %>
                                                </strong><span>|</span> Dosage : <span class="darkc">
                                                    <%# Eval("Doze") %>
                                                </span><span>|</span>Frequency :
                                                    <asp:Label ID="Label_Frequency" runat="server" ForeColor="Red" Text="Label"></asp:Label><span
                                                        class="darkc"><%#Eval("Dosage")%></span><span>|</span>Start Date : <span class="darkc">
                                                            <%# Eval("[Start Date]") %>
                                                        </span><span>|</span>For Days :
                                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("days") %>'></asp:Label><span
                                                        class="darkc"></span><span>|</span><%# Eval("CT") %>&nbsp;
                                                    <asp:LinkButton ID="LinkButton_Edit" runat="server" ToolTip="Edit Medicine" CssClass="editit"
                                                        CommandName="Select" CausesValidation="False"></asp:LinkButton>
                                                    <asp:LinkButton ID="LinkButton_Delete" runat="server" CausesValidation="False" CommandName="Delete"
                                                        CssClass="cancel_btn" ToolTip="Delete Medicine"></asp:LinkButton>
                                                    <asp:CheckBox ID="CheckBox_Confirm" runat="server" ToolTip="Confirm Medicine" Checked="True" />
                                                    <asp:HiddenField ID="HiddenField_PrescriptionID" runat="server" Value='<%# Eval("priscription_id") %>' />
                                                    <asp:HiddenField ID="HiddenField_CT" runat="server" Value='<%# Eval("CT") %>' />
                                                    <asp:HiddenField ID="HiddenField_EndDate" runat="server" Value='<%# Eval("[End Date]") %>' />
                                                    <asp:HiddenField ID="HiddenField_Start_Date" runat="server" Value='<%# Eval("[Start Date]") %>' />
                                                    <asp:HiddenField ID="HiddenField_Dosage" runat="server" Value='<%# Eval("Dosage") %>' />
                                                    <asp:HiddenField ID="HiddenField_Doze" runat="server" Value='<%# Eval("Doze") %>' />
                                                    <asp:HiddenField ID="HiddenField_MedicineName" runat="server" Value='<%# Eval("[Medicine Name]") %>' />
                                                </li>
                                            </ul>
                                        </ItemTemplate>
                                    </asp:DataList>
                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                        SelectCommand="OPD_Encounter_Medication" SelectCommandType="StoredProcedure"
                                        DeleteCommand="DELETE FROM Pt_Prescription_Detail WHERE (priscription_id = @priscription_id)">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="RegNo" SessionField="registrationno" Type="String" />
                                            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
                                        </SelectParameters>
                                        <DeleteParameters>
                                            <asp:ControlParameter ControlID="HiddenField_Prescription_Id" Name="priscription_id"
                                                PropertyName="Value" />
                                        </DeleteParameters>
                                    </asp:SqlDataSource>
                                    <asp:SqlDataSource ID="SqlDataSource_Prescription" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                        InsertCommand="Insert_Patient_Prescription_Detail" InsertCommandType="StoredProcedure"
                                        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                        UpdateCommand="Update_Patient_Prescription_Detail" UpdateCommandType="StoredProcedure">
                                        <InsertParameters>
                                            <asp:SessionParameter Name="Yearly_NO" SessionField="YearlyNo" />
                                            <asp:ControlParameter ControlID="HiddenField_MedCode" Name="Med_Code" PropertyName="Value" />
                                            <asp:SessionParameter Name="Registration_NO" SessionField="registrationNo" />
                                            <asp:ControlParameter ControlID="HiddenField_dosage" Name="Dosage" PropertyName="Value" />
                                            <asp:ControlParameter ControlID="DropDownList_route" Name="Route_ID" PropertyName="SelectedValue" />
                                            <asp:ControlParameter ControlID="HiddenField_Dilution" Name="Dilution" PropertyName="Value"
                                                DefaultValue="1" />
                                            <asp:ControlParameter ControlID="DropDownList_Meal" Name="Meal" PropertyName="SelectedValue"
                                                DefaultValue="1" />
                                            <asp:ControlParameter ControlID="DropDownList_frequencyName" Name="Frequency_ID"
                                                PropertyName="SelectedValue" />
                                            <asp:ControlParameter ControlID="txtboxBeforeMeal" Name="BeforeMeal" Type="String"
                                                PropertyName="Text" />
                                            <asp:ControlParameter ControlID="txtboxAfterMeal" Name="AfterMeal" Type="String"
                                                PropertyName="Text" />
                                            <asp:ControlParameter ControlID="TextBoxInstruction" Name="Instruction" PropertyName="Text"
                                                DefaultValue="" />
                                            <asp:ControlParameter ControlID="TextBox_days" Name="days" PropertyName="Text" />
                                            <asp:SessionParameter Name="emp_ID" SessionField="emp_id" />
                                            <asp:ControlParameter ControlID="HiddenFieldStartDate" Name="StartDate" PropertyName="Value" />
                                            <asp:ControlParameter ControlID="HiddenFieldEndDate" Name="EndDate" PropertyName="Value" />
                                            <asp:ControlParameter ControlID="DropDownList_dosage" Name="Dose"
                                                PropertyName="SelectedValue" />
                                            <asp:ControlParameter ControlID="HiddenField_CT" Name="CT" PropertyName="Value" Type="String" />

                                            <asp:ControlParameter ControlID="DropDownList_diution" Name="Duration" PropertyName="SelectedValue"
                                                Type="String" />
                                            <asp:ControlParameter ControlID="DropDownList_Medicine_Advice_Category" Name="Medicine_Advice_Category_ID"
                                                PropertyName="SelectedValue" Type="Int32" />
                                            <asp:ControlParameter ControlID="ddlMedicineType" Name="MedicineType" PropertyName="SelectedValue" Type="String" />
                                            <asp:ControlParameter ControlID="HiddenField_Prescription_Id" Direction="InputOutput"
                                                Name="Prescription_Id" PropertyName="Value" Type="Decimal" />
                                        </InsertParameters>
                                        <UpdateParameters>
                                            <asp:SessionParameter Name="Yearly_NO" SessionField="YearlyNo" Type="String" />
                                            <asp:ControlParameter ControlID="HiddenField_MedCode" Name="Med_Code" PropertyName="Value"
                                                Type="String" />
                                            <asp:SessionParameter Name="Registration_NO" SessionField="registrationno" Type="String" />
                                            <asp:ControlParameter ControlID="HiddenField_dosage" Name="Dosage" PropertyName="Value"
                                                Type="String" />
                                            <asp:ControlParameter ControlID="DropDownList_route" Name="Route_ID" PropertyName="SelectedValue"
                                                Type="String" />
                                            <asp:ControlParameter ControlID="HiddenField_Dilution" Name="Dilution" PropertyName="Value"
                                                Type="String" />
                                            <asp:ControlParameter ControlID="DropDownList_Meal" Name="Meal" PropertyName="SelectedValue"
                                                Type="String" />
                                            <asp:ControlParameter ControlID="HiddenField_frequency" Name="Frequency_ID" PropertyName="Value"
                                                Type="String" />
                                            <asp:ControlParameter ControlID="TextBox_days" Name="days" PropertyName="Text" Type="Int32" />
                                            <asp:SessionParameter Name="emp_ID" SessionField="emp_id" Type="String" />
                                            <asp:ControlParameter ControlID="TextBoxInstruction" Name="Instruction" PropertyName="Text"
                                                Type="String" />
                                            <asp:ControlParameter ControlID="HiddenField_start_date" Name="StartDate" PropertyName="Value"
                                                Type="DateTime" />
                                            <asp:ControlParameter ControlID="HiddenField_end_date" Name="EndDate" PropertyName="Value"
                                                Type="DateTime" />
                                            <asp:ControlParameter ControlID="HiddenFieldDose" Name="Dose" PropertyName="Value"
                                                Type="String" />
                                            <asp:ControlParameter ControlID="HiddenField_CT" Name="CT" PropertyName="Value" Type="String" />
                                            <asp:ControlParameter ControlID="DropDownList_diution" Name="Duration" PropertyName="SelectedValue"
                                                Type="String" />
                                            <asp:ControlParameter ControlID="DropDownList_Medicine_Advice_Category" Name="Medicine_Advice_Category_ID"
                                                PropertyName="SelectedValue" Type="Int32" />

                                        </UpdateParameters>
                                    </asp:SqlDataSource>


                                    <asp:GridView ID="GridView_Template_Medicine" runat="server" AutoGenerateColumns="False"
                                        DataSourceID="SqlDataSourceForGrid" Width="100%" Visible="false">
                                        <Columns>
                                            <asp:BoundField DataField="Medicine Name" HeaderText="Medicine Name" SortExpression="Medicine Name" />
                                            <asp:BoundField DataField="Meal" HeaderText="Meal" SortExpression="Meal" />
                                            <asp:BoundField DataField="Qty" HeaderText="Qty" SortExpression="Qty" Visible="False" />
                                            <asp:BoundField DataField="Dosage" HeaderText="Dosage" SortExpression="Dosage" />
                                            <asp:BoundField DataField="Doze" HeaderText="Doze" SortExpression="Doze" Visible="False" />
                                            <asp:BoundField DataField="Start Date" HeaderText="Start Date" SortExpression="Start Date" />
                                            <asp:BoundField DataField="days" HeaderText="Days" SortExpression="days" />
                                            <asp:BoundField DataField="End Date" HeaderText="End Date" SortExpression="End Date" />
                                            <asp:TemplateField HeaderText="Total Qty" ShowHeader="False">
                                                <ItemTemplate>
                                                    <asp:Label ID="LabelTotalQty" runat="server"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <RowStyle CssClass="GridItem" />
                                        <HeaderStyle CssClass="GridHeader2" />
                                        <AlternatingRowStyle CssClass="GridAltItem" />
                                    </asp:GridView>

                                    <asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                        SelectCommand="Select_Patient_Prescription_Detail" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
                                            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
                                            <asp:ControlParameter Name="date" ControlID="HiddenFieldDate" PropertyName="Value" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>


                                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceForDateList"
                                        Width="100%" DataKeyNames="Column1" ShowHeader="False" Style="margin-top: 5px; display: none;">
                                        <Columns>
                                            <asp:BoundField DataField="Column1" HeaderText="Prescriptions Date" ReadOnly="True"
                                                SortExpression="Column1" Visible="False" ShowHeader="False" />
                                            <asp:ButtonField CommandName="Select" DataTextField="Column1" HeaderText="Prescription Date"
                                                Text="Button" />
                                        </Columns>
                                        <RowStyle CssClass="GridItem" />
                                        <FooterStyle CssClass="GridPager" />
                                        <SelectedRowStyle CssClass="gridselect" />
                                        <HeaderStyle CssClass="GridHeader" />
                                        <EditRowStyle CssClass="gridedit" />
                                        <AlternatingRowStyle CssClass="GridAltItem" />
                                    </asp:GridView>


                                    <asp:SqlDataSource ID="SqlDataSourceForDateList" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                        SelectCommand="SELECT distinct convert(varchar,date,103) FROM Pt_Prescription_Detail WHERE (Yearly_NO = @Yearly_NO) AND (Registration_NO = @Registration_NO)">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="Yearly_NO" SessionField="YearlyNo" />
                                            <asp:SessionParameter Name="Registration_NO" SessionField="registrationNo" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:HiddenField ID="HiddenField_yearly_no" runat="server" />
                                    <asp:HiddenField ID="HiddenFieldEndDate" runat="server" />
                                    <asp:HiddenField ID="HiddenFieldStartDate" runat="server" />
                                    <asp:HiddenField ID="HiddenField_dosage" runat="server" />
                                    <asp:HiddenField ID="HiddenField_Dilution" runat="server" />
                                    <asp:HiddenField ID="HiddenField_start_date" runat="server" />
                                    <asp:HiddenField ID="HiddenField_end_date" runat="server" />
                                    <asp:HiddenField ID="HiddenField_CT" runat="server" />

                                    <asp:HiddenField ID="HiddenFieldDose" runat="server" />
                                    <asp:HiddenField ID="HiddenField_Prescription_Id" runat="server" />
                                    <asp:HiddenField ID="HiddenField_Medicine_Category" runat="server" />
                                    <asp:HiddenField ID="HiddenField_priscription_id" runat="server" />
                                    <asp:HiddenField ID="HiddenField_MedCode" runat="server"></asp:HiddenField>
                                    <asp:HiddenField ID="HiddenField_DL_Dosage" runat="server" />
                                    <asp:HiddenField ID="HiddenField_Frequency_Sub_Id" runat="server" />
                                    <asp:HiddenField ID="HiddenField_flag" runat="server" />
                                    <asp:HiddenField ID="HiddenFieldDate" runat="server" />

                                    <%--<asp:HiddenField ID="HiddenField_priscription_id" runat="server" />                                        --%>
                                    <asp:SqlDataSource ID="SqlDataSource_Frequency_detail" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                        InsertCommand="Insert_Patient_Frequency_Detail" InsertCommandType="StoredProcedure"
                                        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>">
                                        <InsertParameters>
                                            <asp:ControlParameter ControlID="HiddenField_DL_Dosage" Name="Dosage" PropertyName="Value" />
                                            <asp:ControlParameter ControlID="HiddenField_Prescription_Id" Name="Prescription_Id"
                                                PropertyName="Value" Type="Decimal" />
                                            <asp:ControlParameter ControlID="HiddenField_Frequency_Sub_Id" Name="Frequency_Sub_Id"
                                                PropertyName="Value" Type="Int32" />
                                        </InsertParameters>
                                    </asp:SqlDataSource>
                                    <asp:SqlDataSource ID="SqlDataSource_route" runat="server" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"
                                        SelectCommandType="StoredProcedure" SelectCommand="Select_Medicine_Category"
                                        ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                        CancelSelectOnNullParameter="False">
                                        <%-- <SelectParameters>
                            <asp:ControlParameter ControlID="HiddenField_MedCode" Name="Item_Code" PropertyName="Value"
                                Type="String" />
                        </SelectParameters>--%>
                                    </asp:SqlDataSource>
                                    <asp:SqlDataSource ID="SqlDataSource_FrequencyDataList" runat="server" ProviderName="<%$ ConnectionStrings:StoreConnectionString2.ProviderName %>"
                                        SelectCommand="SELECT     Medicine_Frequency.Name, Medicine_Frequency_Detail.Frequency , &#13;&#10;                      Medicine_Frequency_Detail.TimeDuration_Hour, Medicine_Frequency_Detail.Sequence_No, Medicine_Frequency_Detail.Frequency_Sub_Id,&#13;&#10;                      Medicine_Frequency_Detail.Frequency_Id&#13;&#10;FROM         Medicine_Frequency_Detail INNER JOIN&#13;&#10;                      Medicine_Frequency ON Medicine_Frequency_Detail.Frequency_Id = Medicine_Frequency.id&#13;&#10;WHERE     (Medicine_Frequency.id = @id)"
                                        ConnectionString="<%$ ConnectionStrings:StoreConnectionString2 %>">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="DropDownList_frequencyName" Name="id" PropertyName="SelectedValue" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>


                                    <asp:SqlDataSource ID="SqlDataSource_FrequencyDataListForPrevious" runat="server" ProviderName="<%$ ConnectionStrings:StoreConnectionString2.ProviderName %>"
                                        SelectCommand="SELECT     Medicine_Frequency.Name, Medicine_Frequency_Detail.Frequency , &#13;&#10;                      Medicine_Frequency_Detail.TimeDuration_Hour, Medicine_Frequency_Detail.Sequence_No, Medicine_Frequency_Detail.Frequency_Sub_Id,&#13;&#10;                      Medicine_Frequency_Detail.Frequency_Id&#13;&#10;FROM         Medicine_Frequency_Detail INNER JOIN&#13;&#10;                      Medicine_Frequency ON Medicine_Frequency_Detail.Frequency_Id = Medicine_Frequency.id&#13;&#10;WHERE     (Medicine_Frequency.id = @id)"
                                        ConnectionString="<%$ ConnectionStrings:StoreConnectionString2 %>">
                                        <SelectParameters>
                                            <asp:Parameter Name="id" Type="String" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>



                                    <asp:SqlDataSource ID="SqlDataSource_Medicine_Advice_Category" runat="server" SelectCommand="SELECT [Medicine_Advice_Category_ID], [Medicine_Advice_Category_Name] FROM [Medicine_Advice_Category]"
                                        ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"></asp:SqlDataSource>
                                    <asp:SqlDataSource ID="SqlDataSource_dilution" runat="server" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"
                                        SelectCommand="SELECT name FROM Medicine_Dilution" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"></asp:SqlDataSource>
                                    <asp:SqlDataSource ID="SqlDataSource_dosage" runat="server" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"
                                        SelectCommand="SELECT Name FROM Medicine_Dosage" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"></asp:SqlDataSource>
                                    <asp:SqlDataSource ID="SqlDataSource_frequency" runat="server" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"
                                        SelectCommand="SELECT     id, Name + ' (' + Occasion + ')' AS Name, CASE WHEN dbo.ufn_CountChar(Occasion, '+') > 0 THEN dbo.ufn_CountChar(Occasion, '+') ELSE 1000 END AS count&#13;&#10;FROM         Medicine_Frequency&#13;&#10;WHERE     (IS_Available = 1)"
                                        ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"></asp:SqlDataSource>


                                    <asp:GridView Style="display: none" ID="GridView_Medicine" runat="server" CssClass="Grid_1"
                                        Width="100%" DataSourceID="SqlDataSourceMedcine1" AutoGenerateColumns="False">
                                        <Columns>
                                            <asp:BoundField DataField="MGName" HeaderText="Medicine" ReadOnly="True" SortExpression="MGName" />
                                            <asp:BoundField DataField="Time" HeaderText="Time" ReadOnly="True" SortExpression="Time" />
                                            <asp:BoundField DataField="Doctor" HeaderText="Doctor" ReadOnly="True" SortExpression="Doctor"
                                                Visible="False" />
                                            <asp:BoundField DataField="Dosage" HeaderText="Dosage" SortExpression="Dosage" />
                                            <asp:BoundField DataField="days" HeaderText="days" SortExpression="days" />
                                        </Columns>
                                        <RowStyle CssClass="GridItem" />
                                        <HeaderStyle CssClass="GridHeader" />
                                        <AlternatingRowStyle CssClass="GridAltItem" />
                                    </asp:GridView>

                                    <asp:SqlDataSource ID="SqlDataSourceMedcine1" runat="server" ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                        SelectCommandType="StoredProcedure" SelectCommand="pt_Select_Medicine_Prescription"
                                        ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
                                            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>


                                    <%--                    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                        <ContentTemplate>--%>
                                    <%--<asp:Timer ID="Timer5" runat="server" Interval="50000">
            </asp:Timer>--%>


                                    <asp:Repeater ID="Repeater_yimportexport" Visible="false" runat="server" DataSourceID="XmlDataSource_Medicine">
                                        <ItemTemplate>
                                            <ul class="medication_cnt">
                                                <li style="border-bottom: #cccccc dotted 1px; border-right: 0; border-left: 0;"><strong
                                                    class="mname">
                                                    <%#XPath("MedicineName")%>
                                                </strong></li>
                                                <li>Dosage : <span class="darkc">
                                                    <%#XPath("Dosage")%>
                                                </span><span>|</span>Frequency : <span class="darkc">
                                                    <%#XPath("Qty")%>
                                                </span><span>|</span>Start Date : <span class="darkc">
                                                    <%#XPath("startdate")%>
                                                </span><span>|</span>End Date : <span class="darkc">
                                                    <%#XPath("enddate")%>
                                                </span></li>
                                            </ul>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <%--  </ContentTemplate>
                    </asp:UpdatePanel>--%>

                                    <asp:XmlDataSource ID="XmlDataSource_Medicine" runat="server" XPath="Medicationdatewise/item"
                                        DataFile="~/Pt_EMR/OPD_Encounter_Medication.xml"></asp:XmlDataSource>
                                </div>

                                <div id="PreviousMedicine" style="display: none;">

                                    <span style="display: block; text-align: right; padding-bottom: 10px;">
                                        <asp:Button ID="btnSavePreviousMedicine" runat="server" OnClick="btnSavePreviousMedicine_Click" Text="Assign Previous Medicine" SkinID="medicine_btn" />
                                    </span>


                                    <asp:DataList ID="datalistForPreviousMedicine" OnItemDataBound="datalistForPreviousMedicine_ItemDataBound" runat="server" DataKeyField="priscription_id" RepeatLayout="Flow"
                                        Width="100%">


                                        <ItemTemplate>
                                            <div class="bx_style_1" style="width: 100%; float: left;">

                                                <ul class="form_list_s" style="width: 100%;">
                                                    <li style="display: block; width: 100%; margin-top: 0px; margin-bottom: 5px; border-bottom: #ccc dotted 1px;">
                                                        <label style="font-weight: bold;">Select Medicine</label>
                                                        <asp:CheckBox ID="assign" runat="server" ToolTip='<%# Eval("priscription_id") %>' />
                                                        <span style="color: #039; font-weight: bold;"><%# Eval("Medicine_Name") %></span>
                                                        <asp:HiddenField ID="hfMedicine_Name" runat="server" Value='<%# Eval("Medicine_Name") %>' />
                                                        <asp:HiddenField ID="hfMedicine_Code" runat="server" Value='<%# Eval("MedCode") %>' />
                                                    </li>


                                                    <li style="margin-left: 10px;">
                                                        <label>Route</label>
                                                        <asp:DropDownList ID="DropDownList_routeForPreviousMedicine" runat="server" DataSourceID="SqlDataSource_route"
                                                            DataValueField="Id" DataTextField="Description">
                                                        </asp:DropDownList>
                                                    </li>

                                                    <li style="margin-left: 5px;">
                                                        <label>Frequency</label>

                                                        <asp:DropDownList ID="DropDownList_frequencyNameForPreviousMedicine" runat="server" Width="85px" DataSourceID="SqlDataSource_Frequency"
                                                            AutoPostBack="True" DataValueField="id" DataTextField="Name" OnSelectedIndexChanged="DropDownList_frequencyNameForPreviousMedicine_SelectedIndexChanged">
                                                        </asp:DropDownList>

                                                        <asp:TextBox ID="TextBox_FrequencyForPreviousMedicine" runat="server" Width="16px"
                                                            AutoPostBack="false" CssClass="dataListAltItemStyle " Style="display: none">1</asp:TextBox>

                                                        <asp:ImageButton ID="ImageButton_Frequency_ShowHideForPreviousMedicine" OnClick="ImageButton_Frequency_ShowHideForPreviousMedicine_Click"
                                                            runat="server" ImageUrl="../images_hacims/add.png"></asp:ImageButton></li>

                                                    <asp:DataList ID="DataList_FrequencyForPreviousMedicine" runat="server" RepeatDirection="Horizontal"
                                                        RepeatColumns="10" DataKeyField="Frequency_Sub_Id">
                                                        <ItemTemplate>
                                                            <div class="medbg">
                                                                <asp:Label ID="FrequencyLabelForPreviousMedicine" runat="server" Text='<%# Eval("Frequency") %>' Style="display: block; font-family: arial; font-size: 9px;"></asp:Label>
                                                                <asp:TextBox ID="TextBox_dosage2ForPreviousMedicine" runat="server" Width="30px" Style="height: 12px; display: inline;">1</asp:TextBox>
                                                                <asp:HiddenField ID="HF_F_S_IdForPreviousMedicine" runat="server" Value='<%# Eval("Frequency_Sub_Id") %>' />
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:DataList>


                                                    </li>
                                                        
                                                        <li style="margin-left: 5px;">
                                                            <label>Days</label>
                                                            <asp:TextBox ID="TextBox_daysForPreviousMedicine" runat="server" CssClass="input_txt" Style="width: 50px" AutoPostBack="true">1</asp:TextBox>
                                                        </li>
                                                    <li style="margin-left: 10px;">
                                                        <div style="float: left;">
                                                            <label>Start Date</label>
                                                            <igsch:WebDateChooser ID="WebDateChooserPreviousStartDate" runat="server" CssClass="drop_box" Style="border: #ccc solid 1px; height: 30px;"
                                                                Width="100px">
                                                                <CalendarLayout Culture="English (United Kingdom)">
                                                                </CalendarLayout>
                                                            </igsch:WebDateChooser>
                                                        </div>
                                                    </li>
                                                    <li style="margin-left: 10px;">
                                                        <label>Med. Type</label>
                                                        <asp:DropDownList ID="ddlMedicineTypeForPreviousMedicine" runat="server" Style="width: 100%">
                                                            <asp:ListItem Text="Discharge Medicine" Value="Discharge Medicine"></asp:ListItem>
                                                            <asp:ListItem Text="Emergency Treatment" Value="Emergency Treatment"></asp:ListItem>
                                                        </asp:DropDownList>

                                                        <asp:DropDownList ID="DropDownList_MealForPreviousMedicine" runat="server" Width="87px" Visible="false">
                                                            <asp:ListItem Value="NA">.NA</asp:ListItem>
                                                            <asp:ListItem Value="Before Meal">Before</asp:ListItem>
                                                            <asp:ListItem Value="After Meal">After</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </li>

                                                    <li style="margin-left: 5px;">
                                                        <label>Before Meal</label>
                                                        <asp:TextBox ID="txtboxBeforeMealForPreviousMedicine" TextMode="MultiLine" Style="width: 100%" runat="server"></asp:TextBox>
                                                    </li>
                                                    <li style="margin-left: 5px;">
                                                        <label>After Meal</label>
                                                        <asp:TextBox ID="txtboxAfterMealForPreviousMedicine" TextMode="MultiLine" Style="width: 100%" runat="server"></asp:TextBox>
                                                    </li>
                                                    <li style="margin-left: 5px;">
                                                        <label>Comments</label>
                                                        <asp:TextBox ID="TextBoxInstructionForPreviousMedicine" Style="width: 100%" runat="server" TextMode="MultiLine" CssClass="input_txt"></asp:TextBox>
                                                    </li>
                                                </ul>
                                            </div>
                                        </ItemTemplate>

                                    </asp:DataList>
                                </div>





                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <!--bx_01-->
            </div>
            <!--sortable_listone-->




            <div style="display: none">
                <h4 id="GeneralInformation" style="display: none">General Information</h4>
                <table style="display: none" width="100%">
                    <tr>
                        <td>Seen by Diabetologist </td>
                        <td>
                            <asp:DropDownList ID="ddlDiabetologistName" runat="server"></asp:DropDownList>
                            <asp:TextBox TextMode="time" ID="txtboxStart" runat="server" Width="100px"></asp:TextBox>
                            - <span style="padding-left: 10px">
                                <asp:TextBox ID="txtboxEnd" TextMode="time" runat="server" Width="100px"></asp:TextBox></span>
                        </td>
                    </tr>
                    <tr>
                        <td>Translator or assistant </td>
                        <td>
                            <asp:DropDownList ID="ddlAssistant" runat="server"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr style="display: none">
                        <td runat="server">Type of Diabetes </td>
                        <td>
                            <asp:DropDownList ID="ddlDiabetiesType" runat="server">
                                <asp:ListItem Text="Type 2"></asp:ListItem>
                                <asp:ListItem Text="Type 1"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>Diagnosed Date </td>
                        <td>
                            <asp:TextBox ID="txtboxDate" TextMode="date" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Age at Diagnosis </td>
                        <td>
                            <asp:TextBox ID="txtboxAge" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Duration </td>
                        <td>
                            <asp:TextBox ID="txtboxDuration" runat="server"></asp:TextBox>
                            <span style="padding-left: 15px">
                                <input class="btn_hacims" id="btnSave" type="button" value="Save" />
                            </span>
                        </td>
                    </tr>
                </table>
            </div>



            <!--///////////////////////////////////////////////////////////////////////////////////////////////////////////-->

            <div class="connectedSortable" id="sortable_listtwo">

                <div class="bx_01" id="box_pathology">
                    <h3>Pathology</h3>
                    <a href="#" class="closeIt" id="pathology_bx_toggle"></a>
                    <div class="bx_01_content" id="pathology_bx" style="display: block;">

                        <div class="small_tabs_cnt" style="display: none;">
                            <ul class="small_tabs" style="display: none;">
                                <li><a href="#" class="first active" id="show_CurrentTest">Current Test</a></li>
                                <li style="display: none"><a href="#" class="last" id="show_PreviousTest">Previous Test</a></li>
                            </ul>
                        </div>

                        <asp:UpdatePanel ID="updatepanel5" runat="server">
                            <ContentTemplate>
                                <div id="CurrentTest">

                                    <div class="bx_style_1" style="width: 100%; margin-top: 10px;">

                                        <table class="tbl_form2c">
                                            <tr>

                                                <td>
                                                    <asp:TextBox AccessKey="n" PlaceHolder="Enter Test Name" ID="TextBox_Test" runat="server" Style="width: 100%;" ></asp:TextBox>
                                                    <asp:Button Text="Add" ID="btnAddPathology"  OnClick="btnAddPathology_Click" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>

                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" BehaviorID="GetPathTest"
                                        TargetControlID="TextBox_Test" ServicePath="../AutoComplete.asmx" ServiceMethod="GetPathTest"
                                        MinimumPrefixLength="3" EnableCaching="true" CompletionSetCount="12" CompletionListHighlightedItemCssClass="AutoExtenderHighlight"
                                        CompletionListItemCssClass="AutoExtenderList" CompletionListCssClass="AutoExtender"
                                        CompletionInterval="10">
                                    </cc1:AutoCompleteExtender>
                                    <asp:HiddenField ID="HiddenField_MG_ID" runat="server" />
                                    <asp:HiddenField ID="HiddenFieldGender" runat="server"></asp:HiddenField>
                                    <asp:HiddenField ID="HiddenField_Order_ID" runat="server" Value="0"></asp:HiddenField>


                                    <asp:DataList ID="DataList_Test" runat="server" DataSourceID="SqlDataSourceTestNew"
                                        Width="100%" RepeatLayout="Flow">
                                        <ItemTemplate>
                                            <ul class="list_diagnosis">

                                                <li style="border-color: #999;">
                                                    <asp:Label ID="Label_TestDate" runat="server" Style="font-weight: bold;" Text='<%# Eval("TestDate") %>'></asp:Label>
                                                </li>

                                                <asp:DataList ID="DataList_Test_Sub" RepeatDirection="Vertical" RepeatColumns="1" runat="server" DataSourceID="SqlDataSource_Test_Sub" Visible="true" RepeatLayout="Flow">
                                                    <ItemTemplate>
                                                        <li style="height: auto; padding-bottom: 4px; font-size: 12px; padding-left: 25px;">
                                                            <asp:Label ID="TB_NameLabel" Style="color: #09C;" runat="server" Text='<%# Eval("TBName") %>'></asp:Label>
                                                            <asp:ImageButton CommandArgument='<%# Eval("TB_ID") %>' ImageUrl="~/resources/images/img_delgray.png" CssClass="right_btn_delete" ToolTip="Remove" Style="float: right; width: 10px; margin-top: 4px; height: 10px;" OnClick="imgDeletePath_Click" runat="server" ID="imgDeletePath" />
                                                        </li>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                            </ul>
                                            <asp:SqlDataSource ID="SqlDataSource_Test_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                                ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                                SelectCommand="SELECT DISTINCT Investigation_Order_Main.Investigation_Order_ID,Investigation_Order_Sub.TB_ID, TestGroup.TGName,Test_Booking.TB_Name as TBName FROM  
                   Test_Booking INNER JOIN 
                    TestGroup ON Test_Booking.MG_ID = TestGroup.TGID INNER JOIN 
                    Investigation_Order_Sub INNER JOIN  
                    Investigation_Order_Main ON Investigation_Order_Sub.Investigation_Order_ID = Investigation_Order_Main.Investigation_Order_ID ON 
                    Test_Booking.TB_ID = Investigation_Order_Sub.TB_ID  where    (Investigation_Order_Main.YearlyNo = @YearlyNo) AND (Investigation_Order_Main.RegNo = @RegNo) and (CONVERT(varchar,Investigation_Order_Main.Date_Time, 103) = @Date)&#13;&#10;">
                                                <SelectParameters>
                                                    <asp:Parameter Name="YearlyNo" />
                                                    <asp:Parameter Name="RegNo" />
                                                    <asp:Parameter Name="Date" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </ItemTemplate>
                                    </asp:DataList>
                                    <asp:SqlDataSource ID="SqlDataSourceTestNew" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                        SelectCommand="  SELECT DISTINCT CONVERT(varchar, Date_Time, 103) AS TestDate FROM     
	     Investigation_Order_Main WHERE     (YearlyNo = @PayID) and (RegNo = @RegNo)">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="PayID" SessionField="YearlyNO" Type="Int32" />
                                            <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>

                                    <asp:SqlDataSource ID="SqlDataSourceTest" runat="server" ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                        SelectCommand="SELECT DISTINCT CONVERT (varchar, Investigation_Order_Main.Date_Time, 103) + ' ' + CONVERT (varchar, Investigation_Order_Main.Date_Time, 108) AS TestAssignDate, TestGroup.TGName, Test_Booking.TB_Name, Path_Result_Delivery.Main_ID, TestGroup.TGID FROM Path_Test_Booking_Services INNER JOIN Path_Result_Delivery ON Path_Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID RIGHT OUTER JOIN Investigation_Order_Sub INNER JOIN Investigation_Order_Main ON Investigation_Order_Sub.Investigation_Order_ID = Investigation_Order_Main.Investigation_Order_ID INNER JOIN Test_Booking INNER JOIN TestGroup ON Test_Booking.MG_ID = TestGroup.TGID ON Investigation_Order_Sub.TB_ID = Test_Booking.TB_ID ON Path_Result_Delivery.Yearly_No = Investigation_Order_Main.YearlyNo AND Path_Result_Delivery.Reg_no = Investigation_Order_Main.RegNo AND Path_Result_Delivery.HospitalOrderNo = Investigation_Order_Main.Investigation_Order_ID WHERE (Investigation_Order_Main.YearlyNo = @PayID) AND (Investigation_Order_Main.RegNo = @RegNo)"
                                        ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="PayID" SessionField="YearlyNo" Type="Int32" />
                                            <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                            </ContentTemplate>


                        </asp:UpdatePanel>
                    </div>

                    <div id="PreviousTest" style="display: none;">

                        <asp:DataList ID="DataListForPreviousTestPathology" runat="server" DataSourceID="SqlDataSourcePreviousTestForPathology"
                            Width="100%" RepeatLayout="Flow">
                            <ItemTemplate>
                                <ul class="list_diagnosis">
                                    <li style="border-color: #999;">
                                        <asp:Label ID="Label_TestDate" Style="font-weight: bold;" runat="server" Text='<%# Eval("TestDate") %>'></asp:Label>
                                        <span title="Yearly Number">(<%# Eval("YearlyNo") %>)</span> </li>
                                    <asp:HiddenField ID="hfForPathologyYearlyNo" runat="server" Value='<%#Eval("YearlyNo") %>' />

                                    <asp:DataList ID="DataListPreviousTestOfPathology_Sub" RepeatDirection="Vertical" RepeatColumns="1" runat="server" RepeatLayout="Flow">
                                        <ItemTemplate>
                                            <li style="height: auto; padding-bottom: 4px; font-size: 12px; padding-left: 25px;">
                                                <asp:Label ID="TB_NameLabel" Style="color: #09C;" runat="server" Text='<%# Eval("TBName") %>'></asp:Label>
                                            </li>

                                        </ItemTemplate>
                                    </asp:DataList>
                                </ul>
                                <asp:SqlDataSource ID="SqlDataSource_Test_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                    SelectCommand="SELECT DISTINCT Investigation_Order_Main.Investigation_Order_ID,Investigation_Order_Sub.TB_ID, TestGroup.TGName,Test_Booking.TB_Name as TBName FROM  
                   Test_Booking INNER JOIN 
                    TestGroup ON Test_Booking.MG_ID = TestGroup.TGID INNER JOIN 
                    Investigation_Order_Sub INNER JOIN  
                    Investigation_Order_Main ON Investigation_Order_Sub.Investigation_Order_ID = Investigation_Order_Main.Investigation_Order_ID ON 
                    Test_Booking.TB_ID = Investigation_Order_Sub.TB_ID  where    (Investigation_Order_Main.YearlyNo = @YearlyNo) AND (Investigation_Order_Main.RegNo = @RegNo) and (CONVERT(varchar,Investigation_Order_Main.Date_Time, 103) = @Date)&#13;&#10;">
                                    <SelectParameters>
                                        <asp:Parameter Name="YearlyNo" />
                                        <asp:Parameter Name="RegNo" />
                                        <asp:Parameter Name="Date" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                            </ItemTemplate>
                        </asp:DataList>

                        <asp:SqlDataSource ID="SqlDataSourcePreviousTestForPathology" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                            ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                            SelectCommand="  SELECT DISTINCT CONVERT(varchar, Date_Time, 103) AS TestDate,YearlyNo FROM     
	     Investigation_Order_Main a inner join Investigation_Order_Sub b on 
		 a.Investigation_Order_ID=b.Investigation_Order_ID
		  WHERE    YearlyNo in( select top(3) PayID  from Payment  where PayID not in 
(select MAX(PayID) from Payment) and  RegNo=@RegNo  order by PayID desc)">
                            <SelectParameters>
                                <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>



                    </div>

                </div>
            </div>
            <!--bx_01-->


            <!--///////////////////////////////////////////////////////////////////////////////////////////////////////////-->
            <div class="bx_01" id="box_radiology">
                <h3>Investigation</h3>
                <a href="#" class="closeIt" id="radiology_bx_toggle"></a>
                <div class="bx_01_content" id="radiology_bx" style="display: block;">

                    <div class="small_tabs_cnt" style="display: none;">
                        <ul class="small_tabs">
                            <li><a href="#" class="first active" id="show_RadCurrentTest">Current Test</a></li>
                            <li style="display: none"><a href="#" class="last" id="show_RadPreviousTest">Previous Test</a></li>
                        </ul>
                    </div>
                    <asp:UpdatePanel ID="updatepanel6" runat="server">
                        <ContentTemplate>
                            <asp:HiddenField ID="HiddenField_Radiology_Order_ID" runat="server" Value="0"></asp:HiddenField>
                            <div id="RadCurrentTest">

                                <cc1:AutoCompleteExtender ID="Get_Radiology_Test" runat="server" CompletionInterval="10"
                                    CompletionListCssClass="AutoExtender" CompletionListItemCssClass="AutoExtenderList"
                                    CompletionListHighlightedItemCssClass="AutoExtenderHighlight" CompletionSetCount="12"
                                    EnableCaching="true" MinimumPrefixLength="3" ServiceMethod="Get_Radiology_Test"
                                    ServicePath="../AutoComplete.asmx" OnClientItemSelected="ForRadSelected" TargetControlID="TextBox_TestRadiology" BehaviorID="Get_Radiology_Test">
                                </cc1:AutoCompleteExtender>
                                <div class="bx_style_1" style="width: 100%; margin-top: 10px;">
                                    <table class="tbl_form2c">
                                        <tr>

                                            <td>
                                                <asp:TextBox AccessKey="n" PlaceHolder="Enter Test Name" ID="TextBox_TestRadiology" runat="server" Style="width: 100%"
                                                    ></asp:TextBox>
                                                <asp:Button Text="Add" ID="btnAddRadiologyTest"  OnClick="btnAddRadiologyTest_Click" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>

                                <asp:UpdatePanel ID="UpdatePanelRadiology" runat="server" UpdateMode="Always">
                                    <ContentTemplate>
                                        <asp:DataList ID="DataList_Radiology" runat="server" DataSourceID="SqlDataSourceRadiology"
                                            Width="100%" RepeatLayout="Flow">
                                            <ItemTemplate>
                                                <ul class="list_diagnosis">

                                                    <li style="border-color: #999;">
                                                        <asp:Label ID="Label_Date" Style="font-weight: bold;" runat="server" Text='<%# Eval("DateTime")  %>'></asp:Label></li>
                                                    <asp:DataList ID="DataList_Radiology_Sub" runat="server" RepeatDirection="Vertical" RepeatLayout="Flow"
                                                        RepeatColumns="1" DataSourceID="SqlDataSource_Radiology_Sub">
                                                        <ItemTemplate>
                                                            <li style="height: auto; padding-bottom: 4px; font-size: 12px; padding-left: 25px;">
                                                                <asp:Label ID="RadiologyNameLabel" Style="color: #09C" runat="server" Text='<%# Eval("tbname") %>'></asp:Label>
                                                                <asp:ImageButton OnClick="imgDeletRadiology_Click" CommandArgument='<%# Eval("Radiology_SubId")%>' runat="server" ID="imgDeletRadiology" ImageUrl="~/resources/images/img_delgray.png" CssClass="right_btn_delete" Style="float: right; width: 10px; margin-top: 4px; height: 10px;" ToolTip="Remove" />
                                                            </li>
                                                        </ItemTemplate>
                                                    </asp:DataList>

                                                </ul>
                                                <asp:SqlDataSource ID="SqlDataSource_Radiology_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                                    ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                                    SelectCommand="SELECT DISTINCT Radiology_Order_Main.Order_ID,Radiology_Order_Sub.Radiology_SubId, Radiology.dbo.TestGroup.TGName,Radiology_Order_Sub.RadiologyTestName  AS tbname FROM         Radiology_Order_Sub INNER JOIN  Radiology_Order_Main 
ON Radiology_Order_Sub.Order_ID = Radiology_Order_Main.Order_ID INNER JOIN  radiology.dbo.Test_Booking 
ON Radiology_Order_Sub.TB_ID = Radiology.dbo.Test_Booking.TB_ID INNER JOIN  
Radiology.dbo.TestGroup ON Radiology.dbo.Test_Booking.MG_ID = Radiology.dbo.TestGroup.TGID WHERE   (Radiology_Order_Main.YearlyNo = @YearlyNo) AND (Radiology_Order_Main.RegNo =@RegNo) AND (CONVERT(varchar, Radiology_Order_Main.Date_Time, 103) &#13;&#10;                      = @Date)">
                                                    <SelectParameters>
                                                        <asp:Parameter Name="YearlyNo" />
                                                        <asp:Parameter Name="RegNo" />
                                                        <asp:Parameter Name="Date" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </ItemTemplate>
                                        </asp:DataList>
                                    </ContentTemplate>
                                </asp:UpdatePanel>

                            </div>
                            <div id="RadPreviousTest" style="display: none;">


                                <asp:DataList ID="DataListPreviousTestParent" runat="server" DataSourceID="SqlDataSourceRadiologyPreviousTest_Parent"
                                    Width="100%" RepeatLayout="Flow">
                                    <ItemTemplate>
                                        <ul class="list_diagnosis">

                                            <li style="border-color: #999;">
                                                <asp:Label ID="Label_Date" Style="font-weight: bold;" runat="server" Text='<%# Eval("DateTime") %>'></asp:Label>
                                                <span title="Yearly Number"><%#  "(" & Eval("YearlyNo") & ")" %></span></li>

                                            <asp:HiddenField ID="yearlyNO" runat="server" Value='<%# Eval("YearlyNo") %>' />
                                            <asp:DataList ID="DataListPreviousTest_Sub" runat="server" RepeatDirection="Vertical" RepeatLayout="Flow"
                                                RepeatColumns="1">
                                                <ItemTemplate>
                                                    <li style="height: auto; padding-bottom: 4px; font-size: 12px; padding-left: 25px;">
                                                        <asp:Label ID="RadiologyNameLa" Style="color: #09C" runat="server" Text='<%# Eval("tbname") %>'></asp:Label></li>


                                                </ItemTemplate>
                                            </asp:DataList>

                                        </ul>
                                        <asp:SqlDataSource ID="SqlDataSource_Radiology_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                            ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                            SelectCommand="SELECT DISTINCT Radiology_Order_Main.Order_ID,Radiology_Order_Sub.Radiology_SubId, Radiology.dbo.TestGroup.TGName,Radiology_Order_Sub.RadiologyTestName  AS tbname FROM         Radiology_Order_Sub INNER JOIN  Radiology_Order_Main 
ON Radiology_Order_Sub.Order_ID = Radiology_Order_Main.Order_ID INNER JOIN  radiology.dbo.Test_Booking 
ON Radiology_Order_Sub.TB_ID = Radiology.dbo.Test_Booking.TB_ID INNER JOIN  
Radiology.dbo.TestGroup ON Radiology.dbo.Test_Booking.MG_ID = Radiology.dbo.TestGroup.TGID WHERE   (Radiology_Order_Main.YearlyNo = @YearlyNo) AND (Radiology_Order_Main.RegNo =@RegNo) AND (CONVERT(varchar, Radiology_Order_Main.Date_Time, 103) &#13;&#10;                      = @Date)">
                                            <SelectParameters>
                                                <asp:Parameter Name="YearlyNo" />
                                                <asp:Parameter Name="RegNo" />
                                                <asp:Parameter Name="Date" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </ItemTemplate>
                                </asp:DataList>
                                </td>
                                </tr>
                            </table>
                            </div>

                            </div>        
    </div><!--bx_01-->



                            <%--  <asp:SqlDataSource ID="SqlDataSource_Radiology_PreviousTest_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                            ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                            SelectCommand="SELECT DISTINCT Radiology_Order_Main.Order_ID,Radiology_Order_Sub.Radiology_SubId, Radiology.dbo.TestGroup.TGName,Radiology_Order_Sub.RadiologyTestName  AS tbname FROM         Radiology_Order_Sub INNER JOIN  Radiology_Order_Main 
ON Radiology_Order_Sub.Order_ID = Radiology_Order_Main.Order_ID INNER JOIN  radiology.dbo.Test_Booking 
ON Radiology_Order_Sub.TB_ID = Radiology.dbo.Test_Booking.TB_ID INNER JOIN  
Radiology.dbo.TestGroup ON Radiology.dbo.Test_Booking.MG_ID = Radiology.dbo.TestGroup.TGID WHERE   (Radiology_Order_Main.YearlyNo = @YearlyNo) AND (Radiology_Order_Main.RegNo =@RegNo) AND (CONVERT(varchar, Radiology_Order_Main.Date_Time, 103) &#13;&#10;                      = @Date)">
                                            <SelectParameters>
                                                <asp:Parameter Name="YearlyNo" />
                                                <asp:Parameter Name="RegNo" />
                                                <asp:Parameter Name="Date" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>    --%>


                            <asp:SqlDataSource ID="SqlDataSourceRadiology" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                SelectCommand="SELECT DISTINCT CONVERT(varchar, Date_Time, 103) AS DateTime&#13;&#10;FROM         Radiology_Order_Main&#13;&#10;WHERE     (YearlyNo = @PayID) and (RegNo = @RegNo)&#13;&#10;">
                                <SelectParameters>
                                    <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" Type="String" />
                                    <asp:SessionParameter Name="PayID" SessionField="YearlyNo" Type="Decimal" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSourceRadiologyPreviousTest_Parent" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                SelectCommand="SELECT distinct CONVERT(varchar, Date_Time, 103) AS DateTime,YearlyNo FROM     Radiology_Order_Main WHERE     (YearlyNo in ( select top(3) PayID  from Payment  where PayID not in 
(select MAX(PayID) from Payment) and  RegNo=@RegNo  order by PayID desc
	))
	">
                                <SelectParameters>
                                    <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" Type="String" />

                                </SelectParameters>
                            </asp:SqlDataSource>


                            <%--<asp:GridView ID="GridViewRadiology" runat="server" CssClass="Grid_1" Width="100%"
                                                DataSourceID="SqlDataSourceRadiology" AutoGenerateColumns="False">
                                                <Columns>
                                                    <asp:BoundField DataField="DateTime" HeaderText="Advise Date" SortExpression="DateTime" />
                                                    <asp:BoundField DataField="TGName" HeaderText="Group" SortExpression="TGName" />
                                                    <asp:BoundField DataField="TB_Name" HeaderText="Radiology Investigation" SortExpression="TB_Name" />
                                                </Columns>
                                                <RowStyle CssClass="GridItem" />
                                                <HeaderStyle CssClass="GridHeader" />
                                                <AlternatingRowStyle CssClass="GridAltItem" />
                                            </asp:GridView>--%>
                            <%--<asp:SqlDataSource ID="SqlDataSourceRadiology" runat="server" SelectCommandType="StoredProcedure"
                                                SelectCommand="pt_Radiology_Select_Tests" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>">
                                                <SelectParameters>
                                                    <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" Type="String" />
                                                    <asp:SessionParameter Name="PayID" SessionField="YearlyNo" Type="Decimal" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>--%>

                            <asp:SqlDataSource ID="SqlDataSourceXray" runat="server" ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                SelectCommand="SELECT   TestGroup.TGName, Radiology_Order_Sub.Instructions, Radiology_Order_Sub.RadiologyTestName&#13;&#10;FROM         Radiology_Order_Main INNER JOIN&#13;&#10;                      Radiology_Order_Sub ON Radiology_Order_Main.Order_ID = Radiology_Order_Sub.Order_ID INNER JOIN&#13;&#10;                      Test_Booking ON Radiology_Order_Sub.TB_ID = Test_Booking.TB_ID INNER JOIN&#13;&#10;                      TestGroup ON Test_Booking.MG_ID = TestGroup.TGID&#13;&#10;WHERE     (Radiology_Order_Main.YearlyNo = @YearlyNo) AND (Radiology_Order_Main.RegNo = @RegNo) AND &#13;&#10;                      (Radiology_Order_Main.SubDept_Id = @SubDept_Id) AND (Radiology_Order_Main.DeptId = @DeptId)"
                                ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>">
                                <SelectParameters>
                                    <asp:SessionParameter Name="YearlyNo" SessionField="Yearlyno" />
                                    <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                                    <asp:SessionParameter Name="SubDept_Id" SessionField="SubDeptID" />
                                    <asp:SessionParameter Name="DeptId" SessionField="dept_id" />
                                </SelectParameters>
                            </asp:SqlDataSource>


                            <div style="border-right: #999999 3px solid; padding-right: 10px; border-top: #999999 3px solid; padding-left: 10px; z-index: 100; left: 568px; visibility: hidden; padding-bottom: 10px; border-left: #999999 3px solid; width: 250px; padding-top: 10px; border-bottom: #999999 3px solid; position: absolute; top: 16px; height: 100px; background-color: #ffffff"
                                id="Div_Text">
                                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                    <tbody>
                                        <tr>
                                            <td style="width: 255px" align="right">
                                                <asp:Button ID="Button1" runat="server" Text="" CssClass="btn_close"></asp:Button></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 255px">
                                                <asp:TextBox ID="TextBox1" runat="server" CssClass="input_txt" Width="100%" Height="88px"
                                                    TextMode="MultiLine"></asp:TextBox></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                    <!--///////////////////////////////////////////////////////////////////////////////////////////////////////////-->
                    <div class="bx_01" id="box_notes">
                        <h3>Physician Notes</h3>
                        <a href="#" class="closeIt" id="physicianNotes_bx_toggle"></a>
                        <div class="bx_01_content" id="physicianNotes_bx" style="display: block;">

                            <asp:UpdatePanel runat="server" ID="UpdatePanel3">
                                <ContentTemplate>
                                    <asp:HiddenField ID="hdnPhyNotesId" runat="server" Value="0" />
                                    
                                    <div style="float: right">
                                         Follow up days<asp:TextBox ID="txtFUDays" Style="margin-right: 354px" runat="server"></asp:TextBox>
                                    </div>

                                    <asp:TextBox ID="txtPhycicianNotes" runat="server" TextMode="MultiLine" Style="width: 100%; height: 100px; margin-top: 12px"></asp:TextBox>
                                    <div align="center" style="padding-top: 10px;">
                                        <asp:Button ID="Button_phy_Notes" runat="server" Text="save"></asp:Button>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>


                        </div>
                    </div>
                    <!--bx_01-->

                    <!--///////////////////////////////////////////////////////////////////////////////////////////////////////////-->
                    <div class="bx_01" style="display: none" id="box_doctor_notes">
                        <h3>Referal Doctor Notes</h3>
                        <a href="#" class="closeIt" id="referalDoctorNotes_bx_toggle"></a>
                        <div class="bx_01_content" id="referalDoctorNotes_bx" style="display: block;">
                            <asp:UpdatePanel ID="updatepanel7" runat="server">
                                <ContentTemplate>

                                    <table class="tbl_form2c">

                                        <tr>
                                            <td>Department</td>
                                            <td>
                                                <asp:DropDownList AutoPostBack="true" ID="ddlDept" runat="server">
                                                </asp:DropDownList><asp:RequiredFieldValidator ID="vaddlDept" runat="server" ControlToValidate="ddlDept"
                                                    ErrorMessage="*" ForeColor="Red" Text="*" ValidationGroup="mainAppForRef" InitialValue=""></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>Consultant</td>
                                            <td>
                                                <asp:DropDownList ID="ddlConsultant" runat="server">
                                                </asp:DropDownList>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlConsultant"
                                                    ErrorMessage="*" Display="Dynamic" Text="*" ForeColor="Red" ValidationGroup="mainAppForRef"
                                                    InitialValue=""></asp:RequiredFieldValidator></td>

                                        </tr>

                                        <tr>
                                            <td></td>
                                            <td>
                                                <asp:HiddenField ID="hdnReferalNotes" runat="server" />
                                                <asp:TextBox ID="txtReferalNotes" runat="server" TextMode="MultiLine" Style="width: 100%; height: 60px;"></asp:TextBox>
                                                <asp:HiddenField ID="hdnReferalId" runat="server" Value="0" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>
                                                <asp:Button ID="btnSaveReferal" CausesValidation="true" ValidationGroup="mainAppForRef"
                                                    runat="server" Text="save"></asp:Button></td>
                                        </tr>
                                    </table>

                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                    <!--bx_01-->

                </div>
                <!--sortable_listtwo-->



                <asp:SqlDataSource ID="SqlDataSource_Alert" runat="server"
                    SelectCommand="SELECT [Reg_No], [Yearly_No], [Alert], [Alert_ID] FROM [OPD_Alert] where [Reg_No]=@Reg_No and [Yearly_No]=@Yearly_No"
                    ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>" UpdateCommand="UPDATE [OPD_Alert] SET [Reg_No] = @Reg_No, [Yearly_No] = @Yearly_No, [Alert] = @Alert WHERE [Alert_ID] = @Alert_ID"
                    InsertCommand="INSERT INTO [OPD_Alert] ([Reg_No], [Yearly_No], [Alert]) VALUES (@Reg_No, @Yearly_No, @Alert)"
                    DeleteCommand="DELETE FROM [OPD_Alert] WHERE [Alert_ID] = @Alert_ID">
                    <SelectParameters>
                        <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" />
                        <asp:SessionParameter Name="Yearly_No" SessionField="Yearlyno" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="Alert_ID" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Reg_No" Type="String" />
                        <asp:Parameter Name="Yearly_No" Type="String" />
                        <asp:Parameter Name="Alert" Type="String" />
                        <asp:Parameter Name="Alert_ID" Type="Int32" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" Type="String" />
                        <asp:SessionParameter Name="Yearly_No" SessionField="Yearlyno" Type="String" />
                        <asp:ControlParameter ControlID="TextBox_Alert" Name="Alert" PropertyName="Text"
                            Type="String" />
                    </InsertParameters>
                </asp:SqlDataSource>


                <div class="bx_infos_patients" style="display: none;">
                    <h2>
                        <span>Vitals
                                            <asp:HyperLink ID="HyperLink5" runat="server" CssClass="example_vitals" NavigateUrl="~/Nursing/nursevitals_encounterform.aspx">Add Vitals</asp:HyperLink></span></h2>

                    <div class="bxinfo_marginb">

                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>

                                <asp:GridView ID="GridViewVitals" runat="server" CssClass="Grid_1" Width="100%">
                                    <RowStyle CssClass="GridItem" />
                                    <HeaderStyle CssClass="GridHeader_abs" />
                                    <AlternatingRowStyle CssClass="GridAltItem" />
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>



                        <asp:RadioButtonList ID="RadioButtonListCategory" runat="server" RepeatDirection="Horizontal"
                            RepeatLayout="Flow" Visible="False">
                            <asp:ListItem>Ward</asp:ListItem>
                            <asp:ListItem>ICU</asp:ListItem>
                            <asp:ListItem>OT</asp:ListItem>
                        </asp:RadioButtonList>

                    </div>
                </div>

                <asp:SqlDataSource ID="SqlDataSourcevitals" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                    InsertCommand="Insert_Patient_Vital_Nurse" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                    DeleteCommand="DELETE FROM Pt_Stages_Vitals WHERE (vitalsid = @vitalsID)" UpdateCommand="UPDATE Pt_Stages_Vitals SET TemperatureF = @TempF, TemperatureC = @TempC, Pulsebeats = @Pulse, Respirationbeats = @RR, BPHigh = @BPHigh, BPLow = @BPlow, datetime = @DateTime WHERE (vitalsid = @VitalsID)">
                    <InsertParameters>
                        <asp:ControlParameter ControlID="HiddenFieldVitalID" Name="VitalID" PropertyName="Value"
                            Type="Int32" />
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
                        <asp:SessionParameter Name="SubDeptID" SessionField="SubDeptID" Type="Int32" />
                        <asp:ControlParameter ControlID="RadioButtonListCategory" Name="Category" PropertyName="SelectedValue"
                            Type="String" />
                        <asp:SessionParameter Name="EmpID" SessionField="emp_Id" Type="Int32" />
                        <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
                        <asp:ControlParameter ControlID="HiddenFieldVital_Value" Name="Result" PropertyName="Value"
                            Type="Double" />
                        <asp:ControlParameter ControlID="HiddenFieldVitalTakeDate" Name="DateTime" PropertyName="Value"
                            Type="DateTime" />
                        <asp:Parameter DefaultValue="0" Name="Transfusion_Id" Type="Int32" />
                        <asp:Parameter DefaultValue=" " Name="val" Type="String" />
                        <asp:ControlParameter ControlID="hf_Remarks_Identity" Name="Vital_Remark_ID" PropertyName="Value"
                            Type="Int32" />
                    </InsertParameters>
                    <DeleteParameters>
                        <asp:ControlParameter ControlID="GridViewVitals" Name="vitalsID" PropertyName="SelectedValue" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="HiddenFieldTemp" Name="TempF" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenFieldTempC" Name="TempC" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenFieldPulse" Name="Pulse" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenFieldRR" Name="RR" PropertyName="Value" />
                        <asp:ControlParameter ControlID="RangeValidatorBPHigh" Name="BPHigh" PropertyName="Text" />
                        <asp:ControlParameter ControlID="RangeValidatorBPLow" Name="BPlow" PropertyName="Text" />
                        <asp:ControlParameter ControlID="HiddenFieldDateTime" Name="DateTime" PropertyName="Value" />
                        <asp:ControlParameter ControlID="GridViewVitals" Name="VitalsID" PropertyName="SelectedValue" />
                    </UpdateParameters>
                </asp:SqlDataSource>

                <asp:HiddenField ID="hf_Remarks_Identity" runat="server" />
                <asp:HiddenField ID="HiddenFieldVital_Value" runat="server"></asp:HiddenField>
                <asp:HiddenField ID="HiddenFieldVitalTakeDate" runat="server"></asp:HiddenField>
                <asp:HiddenField ID="HiddenFieldVitalID" runat="server"></asp:HiddenField>




                <asp:SqlDataSource ID="SqlDataSourceTemplate" runat="server" ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                    SelectCommand="SELECT Admin_Assign_Template.Template_Id, Admin_Template.Template_Name FROM Admin_Assign_Template INNER JOIN Admin_Template ON Admin_Assign_Template.Template_Id = Admin_Template.Template_Id WHERE (Admin_Assign_Template.subdept_id = @subdeptid)&#13;&#10;and (Admin_Assign_Template.dept_id = @deptid)"
                    ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>">
                    <SelectParameters>
                        <asp:SessionParameter Name="subdeptid" SessionField="SubDeptID" />
                        <asp:SessionParameter Name="deptid" SessionField="dept_id" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenField2" runat="server" Value="0"></asp:HiddenField>
                <asp:HiddenField ID="HiddenField3" runat="server"></asp:HiddenField>
                <asp:HiddenField ID="HiddenFieldTextOther" runat="server"></asp:HiddenField>
                <asp:HiddenField ID="HiddenFieldTemplate_ID" runat="server"></asp:HiddenField>
                <asp:HiddenField ID="HiddenFieldToolTIp" runat="server" Value="true"></asp:HiddenField>
                <asp:HiddenField ID="HiddenField1" runat="server" Value="true"></asp:HiddenField>
                <asp:HiddenField ID="HiddenField_Mg_Code" runat="server"></asp:HiddenField>
                <asp:HiddenField ID="HiddenField_Count" runat="server"></asp:HiddenField>
                <asp:HiddenField ID="HiddenField_root" runat="server"></asp:HiddenField>
                <asp:HiddenField ID="HiddenField_MH_Code" runat="server"></asp:HiddenField>
                <br />
                <br />
                <asp:Label ID="LabelFooter" runat="server" Visible="false" Text=""></asp:Label>



                <asp:UpdateProgress ID="UpdateProgress_search" runat="server" DisplayAfter="0">
                    <ProgressTemplate>
                        <div style="top: 50%; left: 45%; margin-top: 5px; font-size: 11px; position: absolute; margin-top: -29px;">
                            <img id="Img1" src="~/Images_hacims/process.gif" alt="" runat="server" />
                            <span style="margin-left: 5px; color: #999999; display: inline-block; margin-top: 5px; float: right;">Processing your request.  Please wait.... </span>
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>

                <asp:HiddenField ID="hdnSelectedTab" runat="server" />
                <asp:HiddenField ID="hdnSelectedTabforRadiology" runat="server" />
                <asp:HiddenField ID="hdnSelectedTabforPathology" runat="server" />

                <asp:HiddenField ID="hfForAutoPostBack" runat="server" />



            </div>
            <!--pageContent-->
        </div>
        <!--main_bx-->
    </div>
   <div id="lightbox_bg"></div>
   
   <script>
   
   $(document).ready(function(e) {
    	 
				$('.pageContent').show();
				$('.main_bx').css("background","#fff");
	
	
});
   
   
   </script>
   
   
</asp:Content>
