<%@ Page Language="VB" AutoEventWireup="false" validateRequest="false"  Debug="true" 
    CodeFile="Pt_Presenting_Complaint.aspx.vb" 
    MasterPageFile="~/hacims_masterpage.master" 
    Inherits="Pt_EMR_Pt_Presenting_Complaint" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>



<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
  

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<!--<link href="../resources/css/jquery.mCustomScrollbar.css" rel="stylesheet" type="text/css"/>-->
 
 <link rel="stylesheet" href="../resources/js/jquery.mCustomScrollbar.css??" />
	<script src="../resources/js/jquery.mCustomScrollbar.concat.min.js"></script>
<script src="../resources/js/trumbowyg.min.js"></script>
  <link rel="stylesheet" href="../resources/js/trumbowyg.min.css">
  
 <script language="javascript" type="text/javascript">
		$(document).ready(function(){
			  $('#ctl00_ContentPlaceHolder1_TextBox_Remarks').trumbowyg();
		//	$(".link_review").colorbox({width:"1000px", height:"580px", iframe:true});
			//$("#ctl00_ContentPlaceHolder1_TextBox_Remarks").focus(); 
			
			
			
			
			//var tabhtml=""; var contentHtml ="";
//	   $('.CollapsiblePanelTab1').each(function(index, element) {
//		  
//        
//				    tabhtml += "<li><div>"+$(this).html()+"</div>";
//				    tabhtml +="<ul>"; 
//				   
//				   $(this).parent().find('a').each(function(index, element) {  
//				   						
//				   				   var href =  $(this).attr('href');
//								   var thisClass =  $(this).html().replace(' ','').replace(' ','').replace(' ','');
//				   				   tabhtml += '<li><a href="'+href+'" class="'+thisClass+'">'+$(this).html()+'</a></li>';
//				   });
//		 		  tabhtml +="<ul>"; 
//				  tabhtml +="</li>"; 	
//      });
//		
//		 $("#menuScroll").html("");
//		 $("#menuScroll").append("<ul class='tabs_left'>"+tabhtml+"</ul>");
//			
			
			
			
			
			
			
			
			
			
			
			
		});
		


	</script>
    
     
 
 
<style type="text/css">
.Grid_dynamic table td { border:0;   }

 	 
</style>
 
   
  <script type="text/javascript">
      $(document).ready(function() {
		   	
			//$('.pageTitle').html("Presenting Complaints"); 
			
			$('.PresentingComplaint').trigger('click');
		  	$('.pageTitle').html("<span>Presenting Complaints</span> &rsaquo; Presenting Complaints"); 
			$(document).on("click",".mainpage_tabs li a",function(e){
		  
		  	e.preventDefault();
			$('.mainpage_tabs li a').removeClass('active');
			$(this).addClass('active');
			var thisId = $(this).attr('id').split('_')[0];			 
			$('.hideall').hide();
			$('#'+thisId+'_content').show();
			Cookies.set('activeTab', thisId); 
		 
		     });
			 
			
			//var pageheight = $(document).height();
			//console.log(pageheight);
		//	$('.slideLeftMenu').height(pageheight+100);
			
			//var leftMenu = $("#ctl00_ContentPlaceHolder1_LabelSideMenu").html();
			//$(".slideLeftMenu").html(leftMenu);
			//console.log(leftMenu);
			//$("#ctl00_ContentPlaceHolder1_LabelSideMenu").hide();
			
			//var activeTab = Cookies.get('activeTab');
//			$('.mainpage_tabs li a').removeClass('active');  
//			$("#"+activeTab+"_show").addClass('active');
//			$("#form_content").hide();
//			$("#"+activeTab+"_content").show();
			//console.log(activeTab);
		   
		   
        //$("#ctl00_ContentPlaceHolder1_TextBox_Remarks").cleditor({width:"98%"});
		 	
			 
			
			 
				
			var opts = {
                  lines: 11, // lines 
                  length: 5, // line
                  width: 2, // thickness
                  radius: 5, // inner circle
                  rotate: 0, // offset
                  color: '#fff',
                  speed: 1,
                  trail: 60,
                  shadow: false,
                  hwaccel: false,
                  className: 'spinc',
                  zIndex: 2e9,
                  top: 'auto',
                  left: 'auto'
              };
              var spinner = new Spinner(opts);
			 $(document).on("click", ".spinner", function(e) {

                  spinner.spin();
                  $(".spinner").append(spinner.el);
                  $(".spinner").css("text-indent", "-9999px");
                  // spinner.stop(); 


              });
			 
				
		
      });
  </script>  
    
   
   
 </asp:Content>
 
 

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div id="lightbox_bgm"></div>
<div class="slideLeftMenu"><div id="menuScroll"><asp:Label ID="LabelSideMenu" runat="server" Visible="true"></asp:Label></div></div>
<div class="main_bx">
         <ul class="mainpage_tabs" style="padding-left:218px; box-sizing:border-box;">
         <li><a href="#" class="active" id="form_show">Form</a></li>
         <li><a href="#" id="remarks_show">Remarks</a></li>      
         </ul>
          <div class="leftMenu_div">
     		 <div class="leftMenu_divcnt"></div>
   	 </div><!--leftMenu_div-->
         
         
 		 <div class="pageContent" style="width:100%; padding-left:230px; box-sizing:border-box;">
       

<div id="form_content" class="hideall"> 

 <asp:ScriptManager ID="ScriptManager1" runat="server">
          </asp:ScriptManager>
    
          
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
              TargetControlID="TextBoxComplaint_Name"> </cc1:AutoCompleteExtender>
        
  							<asp:CheckBox ID="CheckBox1" Visible="false" runat="server" Text="Chief Complaint" />

<div class="left_box" style="width:350px; height:auto; float:left; background:red1; ">


 <div class="bx_style_1" style="float:left;"  > 
          
          
          <ul class="form_list_s">
              
              <li><label>Complaint</label><asp:TextBox  ID="TextBoxComplaint_Name" runat="server" style="height:28px;" Width="160px" ></asp:TextBox> 
                <asp:Button ID="ButtonSearch" runat="server" Text="Search"  Width="55px" Visible="false" /></li>                          
                <li style="margin-left:10px;"><label>Duration</label><asp:TextBox ID="TextBoxDuration" runat="server" style="height:28px;" SkinId="intdata" Width="40px"></asp:TextBox>               
                <asp:DropDownList ID="DropDownListDuration" runat="server"  Width="75px" style="height:28px; margin-left:2px;">
                  <asp:ListItem>Hours</asp:ListItem>
                  <asp:ListItem>Days</asp:ListItem>
                  <asp:ListItem>Week</asp:ListItem>
                  <asp:ListItem>Month</asp:ListItem>
                  <asp:ListItem>Year</asp:ListItem>
                </asp:DropDownList> <asp:LinkButton ID="LinkButton_Add" runat="server" CssClass="btn_hacims" style="height:28px; width:50px; padding-left:5px; padding-right:5px; min-width:35px; line-height:28px; font-size:13px;"  >Add</asp:LinkButton>
                  <asp:LinkButton ID="LinkButton_Cancel" runat="server" Visible="False" style="float:right; margin-right:10px;">Cancel</asp:LinkButton>
                  </li>
                  </ul>
                  
   </div>   
  
    <asp:ListBox ID="ListBox2"  runat="server" AutoPostBack="True"  Width="100%"  CssClass="listbox" > </asp:ListBox>  
    <asp:ListBox ID="ListBox1" runat="server" DataSourceID="SqlDataSourcePresentComp" Visible="False" DataTextField="Complaint_Name" DataValueField="Complaint_ID" Height="145px" Width="100%" AutoPostBack="True"  CssClass="listbox"> </asp:ListBox><asp:XmlDataSource ID="XmlDataSource1" runat="server" DataFile="~/Complaints1.xml" > </asp:XmlDataSource>
          
  <asp:Label ID="LabelComplaint" runat="server" CssClass="red" Visible="false" style="background:none; padding-left:0;" ></asp:Label> 
  
 <div style="padding:10px; width:100%; text-align:center; height:auto; display:block; float:left;">
  <asp:Button  ID="ButtonRemove" runat="server" Text="Remove" SkinID="remove_btn" OnClick="ButtonRemove_Click" Visible="False" />                        
  <asp:Button  ID="ButtonEdit" runat="server" Text="Edit" SkinID="edit_btn" Visible="False" />                           
 </div>       
        
        
        
     </div>
     
    <div class="right_box" style="width:70%; height:auto; float:left; margin-left:2%;"> 
     
         
        <asp:Panel ID="Panel1" runat="server"  Width="100%"></asp:Panel>

</div>
</div>


<div  id="remarks_content" class="hideall" style="display:none;">


<asp:Label ID="Label_name" runat="server" CssClass="title_heading" Style="margin-bottom:10px; display:block;"></asp:Label>

<asp:TextBox ID="TextBox_Remarks" CssClass="editor1"  runat="server" Height="100%" TextMode="MultiLine"
        Width="100%"></asp:TextBox>
        
        
<asp:Label ID="Label_Select_All" runat="server" style="margin-left:5px; margin-top:5px;"></asp:Label>
                            
                            
                            <asp:DataList ID="DataList_remarks" runat="server" DataSourceID="SqlDataSource_select_all" Visible="false" >
                                <ItemTemplate>
                                    
                                      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td> <strong><asp:Label ID="Complaint_NameLabel" runat="server" Text='<%# Eval("Complaint_Name") %>'></asp:Label></strong><br />
  <asp:LinkButton ID="LinkButton_Description" runat="server" CommandName="Select" CssClass="linkc"  Text='<%# Eval("Description") %>'></asp:LinkButton></td>
  </tr>
</table>
                                    <asp:HiddenField ID="HiddenField_Complaint_ID" runat="server" Value='<%# Eval("Complaint_ID", "{0}") %>' />
                                </ItemTemplate>
                            </asp:DataList>   
        
         
</div>

 <asp:Label ID="LabelComplaintID" CssClass="err" runat="server" Visible="False"  ></asp:Label>
 
 
 
     
  
   
        
       <br />
 
 	<div style="width:100%; text-align:center; float:left; display:block;">
        <asp:LinkButton  ID="Button_Save" CssClass="btn_hacims spinner" runat="server" Text="Save" />
         
        </div>
  <asp:TextBox ID="remarks"   Height="100px" runat="server"  TextMode="MultiLine" style="display:none;" Visible="false"></asp:TextBox> 
        
        
        
       
        
           
        
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
        InsertCommand="Insert_Patient_Complaint_out" InsertCommandType="StoredProcedure"
        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
        SelectCommand="SELECT Description FROM Pt_Presenting_Complaint_saveRecord WHERE (YearlyNo = @YearlyNo) AND (RegNo = @RegNo) AND (Complaint_ID = @Complaint_ID)">
          <SelectParameters>
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
            <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
            <asp:ControlParameter ControlID="HiddenFieldComplaint_ID" Name="Complaint_ID" PropertyName="Value" />
          </SelectParameters>
          <InsertParameters>
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
            <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
            <asp:ControlParameter ControlID="HiddenFieldComplaint_ID" Name="Complaint_ID" PropertyName="Value" />
            <asp:SessionParameter Name="empid" SessionField="emp_id" />
            <asp:ControlParameter ControlID="TextBox_Remarks" Name="Description" PropertyName="Text"
                Type="String" />
          </InsertParameters>
        </asp:SqlDataSource>
        
        
        <asp:SqlDataSource ID="SqlDataSource_select_all" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
        InsertCommand="Admin_Complaint_MainGroup_insert" InsertCommandType="StoredProcedure"
        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
        SelectCommand="SELECT Pt_Presenting_Complaint_saveRecord.Description, Admin_Complaint_MainGroup.Complaint_Name + ' ' + ISNULL(CONVERT (varchar, Pt_Presenting_Complaint_saveRecord.Duration), '') + ' ' + ISNULL(Pt_Presenting_Complaint_saveRecord.Duration_Time, '') AS Complaint_Name, Admin_Complaint_MainGroup.Complaint_ID FROM Pt_Presenting_Complaint_saveRecord INNER JOIN Admin_Complaint_MainGroup ON Pt_Presenting_Complaint_saveRecord.Complaint_ID = Admin_Complaint_MainGroup.Complaint_ID WHERE (Pt_Presenting_Complaint_saveRecord.YearlyNo = @YearlyNo) AND (Pt_Presenting_Complaint_saveRecord.RegNo = @RegNo)" UpdateCommand="UPDATE Pt_Presenting_Complaint_saveRecord SET Duration =@Duration, Duration_Time =@Duration_Time WHERE YearlyNo =@YearlyNo and  RegNo =@RegNo and Complaint_ID =@Complaint_ID">
          <SelectParameters>
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
            <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
          </SelectParameters>
          <InsertParameters>
              <asp:ControlParameter ControlID="TextBoxComplaint_Name" Name="Complaint_Name" PropertyName="Text"
                  Type="String" />
              <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
              <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
              <asp:SessionParameter Name="empid" SessionField="emp_ID" Type="Int32" />
              <asp:ControlParameter ControlID="TextBoxDuration" Name="Duration" PropertyName="Text"
                  Type="Int32" />
              <asp:ControlParameter ControlID="DropDownListDuration" Name="Duration_Time" PropertyName="SelectedValue"
                  Type="String" />
              <asp:Parameter Direction="Output" Name="Complaint_ID_new" Type="Int32" />
          </InsertParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="TextBoxDuration" Name="Duration" PropertyName="Text" />
                <asp:ControlParameter ControlID="DropDownListDuration" Name="Duration_Time" PropertyName="SelectedValue" />
                <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                <asp:ControlParameter ControlID="HiddenFieldComplaint_ID" Name="Complaint_ID" PropertyName="Value" />
            </UpdateParameters>
        </asp:SqlDataSource>
        
        
 
        <asp:XmlDataSource ID="XmlDataSourceXML" runat="server" DataFile="~/Complaints1.xml" XPath="/root/Pt_Presenting_Complaint"> </asp:XmlDataSource>
        <asp:DataList ID="DataList1" runat="server" DataKeyField="Complaint_ID" DataSourceID="SqlDataSource1"
                                RepeatColumns="5" RepeatDirection="Horizontal" Visible="False" >
          <ItemTemplate>
            <asp:LinkButton ID="LinkButtonName" runat="server" CommandName="Select" Text='<%# Eval("Complaint_Name") %>'></asp:LinkButton>
            <asp:Label ID="Column1Label" runat="server" Text='<%# Eval("Column1") %>' Visible="False"></asp:Label>
            </ItemTemplate>
          </asp:DataList><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                SelectCommand="SELECT DISTINCT Admin_Complaint_MainGroup.Complaint_Name, Admin_Complaint_MainGroup.Complaint_ID,isnull(Chief_Complaint,0) FROM Pt_Presenting_Complaint_saveRecord INNER JOIN Admin_Complaint_MainGroup ON Pt_Presenting_Complaint_saveRecord.Complaint_ID = Admin_Complaint_MainGroup.Complaint_ID WHERE (Pt_Presenting_Complaint_saveRecord.YearlyNo = @YearlyNo) AND (Pt_Presenting_Complaint_saveRecord.RegNo = @RegNo)">
            <SelectParameters>
              <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
              <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
            </SelectParameters>
            </asp:SqlDataSource>
  <asp:SqlDataSource ID="SqlDataSourcePresentComp" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>"
                                SelectCommand="SELECT Admin_Complaint_MainGroup.Complaint_Name, Admin_Complaint_MainGroup.Complaint_ID, Admin_Complaint_MainGroup.Pirority FROM Admin_Complaint_MainGroup INNER JOIN Admin_Template_Presenting_Complaints ON Admin_Complaint_MainGroup.Complaint_ID = Admin_Template_Presenting_Complaints.Complaint_Id INNER JOIN Admin_Assign_Template ON Admin_Template_Presenting_Complaints.Template_Id = Admin_Assign_Template.Template_Id WHERE (Admin_Assign_Template.Dept_id = @Dept_id) AND (Admin_Assign_Template.subdept_id = @subdept_id) AND (Admin_Assign_Template.Template_Id = @Template_Id) AND (Admin_Complaint_MainGroup.Complaint_Name LIKE '%' + @Complaint_Name + '%') &#13;&#10;ORDER BY Admin_Complaint_MainGroup.Complaint_Name asc">
    <SelectParameters>
      <asp:SessionParameter Name="Dept_id" SessionField="dept_id" />
      <asp:SessionParameter DefaultValue="" Name="subdept_id" SessionField="SubDeptID" />
      <asp:ControlParameter ControlID="HiddenFieldTemplate_id" DefaultValue="" Name="Template_Id"
                                        PropertyName="Value" />
      <asp:ControlParameter ControlID="TextBoxComplaint_Name" DefaultValue="%" Name="Complaint_Name"
                                PropertyName="Text" />
      </SelectParameters>
    </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceSave" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
            InsertCommand="Insert_Patient_Complaint"
            ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>" InsertCommandType="StoredProcedure">
          <InsertParameters>
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
            <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
            <asp:ControlParameter ControlID="HiddenFieldComplaint_ID" Name="Complaint_ID" PropertyName="Value" />
            <asp:SessionParameter Name="empid" SessionField="emp_id" />
            <asp:ControlParameter ControlID="HiddenFieldChief_Complaint" Name="Chief_Complaint"
                                    PropertyName="Value" />
          </InsertParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenFieldTemplate_id" runat="server" Value="0" />
        <asp:HiddenField ID="HiddenFieldChief_Complaint" runat="server" />
        <asp:HiddenField ID="HiddenFieldDuration" runat="server" />
        <asp:HiddenField ID="HiddenFieldZone" runat="server" />
        <asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
            ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>" SelectCommand="SELECT     Admin_Complaint_MainGroup.Complaint_Name AS [Complaint Name], CONVERT(varchar, Pt_Presenting_Complaint_saveRecord.Date, 103) &#13;&#10;                      AS [Complaint Date]&#13;&#10;FROM         Pt_Presenting_Complaint_saveRecord INNER JOIN&#13;&#10;                      Admin_Complaint_MainGroup ON Pt_Presenting_Complaint_saveRecord.Complaint_ID = Admin_Complaint_MainGroup.Complaint_ID&#13;&#10;WHERE     (Pt_Presenting_Complaint_saveRecord.YearlyNo = @yearlyNo) AND (Pt_Presenting_Complaint_saveRecord.RegNo = @regno)">
          <SelectParameters>
            <asp:SessionParameter Name="regno" SessionField="registrationNo" Type="String" />
            <asp:SessionParameter Name="yearlyNo" SessionField="YearlyNo" />
          </SelectParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenFieldComplaint_ID" runat="server" />
        <asp:HiddenField ID="HiddenFieldBodyPart" runat="server" />
        <asp:SqlDataSource ID="SqlDataSourceBodyPart" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT Pt_Main_Body_Part.pt_Main_Body_Part_ID, Pt_Main_Body_Part.pt_Main_Body_Part FROM Pt_Main_Body_Part INNER JOIN pt_BodyPart_Maintain ON Pt_Main_Body_Part.pt_Main_Body_Part_ID = pt_BodyPart_Maintain.Pt_Main_Body_Part WHERE (pt_BodyPart_Maintain.Complain_Id = @Complain_Id) ORDER BY Pt_Main_Body_Part.Pirority">
          <SelectParameters>
            <asp:ControlParameter ControlID="HiddenFieldComplaint_ID" Name="Complain_Id" PropertyName="Value" />
          </SelectParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenFieldSide" runat="server" />
        <asp:HiddenField ID="HiddenFieldDurationTime" runat="server" />
        <asp:HiddenField ID="HiddenField2" runat="server" Value="0" />
        <asp:HiddenField ID="HiddenField3" runat="server" Value="0" />                
          <asp:HiddenField ID="HiddenField_Complaint_new" runat="server" />
        
        <asp:GridView ID="GridViewComplaint" runat="server" AutoGenerateColumns="False" Visible="false"
                        DataSourceID="SqlDataSourceForGrid" Width="100%" >
          <Columns>
          <asp:BoundField DataField="Complaint Name" HeaderText="Complaint Name" SortExpression="Complaint Name" />
          <asp:BoundField DataField="Complaint Date" HeaderText="Complaint Date" SortExpression="Complaint Date" />
          </Columns>
          <RowStyle CssClass="GridItem" />
          <HeaderStyle CssClass="GridHeader" />                      
          <AlternatingRowStyle CssClass="GridAltItem" />
        </asp:GridView>
 
 
  
<asp:Label ID="LabelFooter" runat="server" Visible="false" Text="Label"></asp:Label>
  
  
        </div><!--pageContent-->
  </div><!--main_bx-->
  
</asp:Content>
