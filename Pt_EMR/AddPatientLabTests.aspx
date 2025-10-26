<%@ Page  Language="VB" MasterPageFile="~/hacims_masterpage.master" AutoEventWireup="false" CodeFile="AddPatientLabTests.aspx.vb" Inherits="Pt_EMR_AddPatientLabTests" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<%@ Register TagName="InveestigationChartControl" Src="~/Pt_EMR/Controls/InveestigationChartControl.ascx" TagPrefix="INVC" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

	<link rel="stylesheet" href="../resources/js/jquery.mCustomScrollbar.css??" />
	<script src="../resources/js/jquery.mCustomScrollbar.concat.min.js"></script>



    <script language="javascript" type="text/JavaScript">
        function showHideTab(elem, toShow) {
            $(".tabbed_nav li").removeClass("active");
            $(elem).parent().addClass("active");
            $(".tabbed_nav-sub").hide();
            $("#" + toShow).show();
        }
    </script>
    
    
    
    
     <script type="text/javascript">
      $(document).ready(function() {
		 //  var pageheight = $(document).height();
		//  $('.slideLeftMenu').height(pageheight+100);
		   $(".leftMenu_Divcnt").mCustomScrollbar({ axis:"y",theme:"minimal-dark" });
		  
			$(document).on("click",".mainpage_tabs li a",function(e){
		  
		  	e.preventDefault();
			$('.mainpage_tabs li a').removeClass('active');
			$(this).addClass('active');
			var thisId = $(this).attr('id').split('_')[0];			 
			$('.hideall').hide();
			$('#'+thisId+'_content').show();
			 
		 
		     });   
		  
		  
      //  $("#ctl00_ContentPlaceHolder1_TextBox_Remarks").cleditor({width:800});
      });
  </script>  
  
  
  <style type="text/css">
  
 
  </style>
  
  

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<div id="lightbox_bgm"></div>
<div class="slideLeftMenu"><div id="menuScroll"><asp:Label ID="LabelSideMenu" runat="server" Visible="true"></asp:Label></div></div>

<div class="main_bx" >
         <ul class="mainpage_tabs" style="padding-left:218px; box-sizing:border-box;">
         <li><a href="#" class="active" id="addTest_show">Add Test</a></li>
         <li><a href="#" id="testResults_show">Test Results</a></li>      
         </ul>
         
          <div class="leftMenu_div">
     		 <div class="leftMenu_divcnt"></div>
   	 </div><!--leftMenu_div-->
         
         
 		 <div class="pageContent" style="width:100%; padding-left:230px; box-sizing:border-box;">


		


    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="../autocomplete.asmx" />
        </Services>
    </asp:ScriptManager>
    
   
 
	 <div id="addTest_content" class="hideall">
      <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
            
            
                <div class="bx_left">
                    
                    <asp:DataList  ID="DataList1" CssClass="dataListTestGroup" runat="server" Width="100%" 
                        DataSourceID="ForTestGroup" DataKeyField="MG_ID" RepeatDirection="Horizontal" RepeatColumns="2" SelectedItemStyle-CssClass="link_datalist_sel">
                        <SelectedItemStyle CssClass="link_datalist_sel"></SelectedItemStyle>
                        <ItemTemplate>
                            <asp:LinkButton  ID="LinkButton1" runat="server" Text='<%# Eval("TGName", "{0}") %>' CssClass="link_datalist" 
                                CommandName="Select" CommandArgument='<%# Eval("MG_ID", "{0}") %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:DataList>
                    

                    <asp:SqlDataSource ID="ForTestGroup" runat="server" ProviderName="<%$ ConnectionStrings:Pathology2ConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT TestGroup.TGID, TestGroup.TGName, TestGroup.TGID as MG_ID FROM Test_Booking JOIN TestGroup ON Test_Booking.MG_ID = TestGroup.TGID  WHERE TGID in (SELECT DISTINCT MG_ID FROM Test_Booking WHERE ACTIVE=1)" ConnectionString="<%$ ConnectionStrings:Pathology2ConnectionString %>"></asp:SqlDataSource>
                   
                <asp:TextBox AccessKey="n" ID="TextBox_Test" runat="server" Width="100%" Style="margin-top:12px; background:#fff url(../resources/images/img_search.svg) 99% 6px no-repeat; background-size:16px; padding-right:10px; " PlaceHolder="Enter Test Name" AutoPostBack="True"></asp:TextBox>     
                    
                    
                    
                    <cc1:AutoCompleteExtender ID="GetMedication" runat="server" BehaviorID="GetPathTest" TargetControlID="TextBox_Test" ServicePath="../AutoComplete.asmx" ServiceMethod="GetPathTest" MinimumPrefixLength="3" EnableCaching="true" CompletionSetCount="12" CompletionListHighlightedItemCssClass="AutoExtenderHighlight" CompletionListItemCssClass="AutoExtenderList" CompletionListCssClass="AutoExtender" CompletionInterval="10"></cc1:AutoCompleteExtender>

                     <div class="bx_01" style="width:100%; float:none; margin-left:0px; margin-top:10px; min-height:260px; height:260px; overflow:auto; overflow-x:hidden;">
                        
                        <asp:CheckBoxList Style="font-size: 12px; width:100%" ID="CheckBoxList_LabTest" runat="server" AutoPostBack="True" DataValueField="TB_ID" DataTextField="TB_Name" DataSourceID="SqlDataSource_Test_booking_new" RepeatDirection="Horizontal" RepeatColumns="2"></asp:CheckBoxList>
                       
                        <asp:SqlDataSource ID="SqlDataSource_Test_booking_new" runat="server" ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" SelectCommand="SELECT Test_Booking.TB_Name, Test_Booking.TB_ID, TestGroup.TGName FROM Test_Booking INNER JOIN TestGroup ON Test_Booking.MG_ID = TestGroup.TGID WHERE (Test_Booking.MG_ID like @MG_ID ) and (Test_Booking.TB_Name like '%' +@TB_Name + '%') and active=1" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="HiddenField_MG_ID" PropertyName="Value" DefaultValue="%" Name="MG_ID"></asp:ControlParameter>
                                <asp:ControlParameter ControlID="TextBox_Test" PropertyName="Text" DefaultValue="%" Name="TB_Name"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>
                   
                   
                    </div>
                    
                </div>
                
              <!-- ///////////////////////////////////////////////////////////////////////-->
               
                 
                   <div class="bx_right">

                     <table class="" cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tbody>
                            <tr style="display: none;">
                                <td valign="top" align="right" style="font-weight: bold;">Special Notes: </td>
                                <td>
                                    <span style="max-height: 40px;">
                                        <asp:TextBox ID="TextBoxDescription" TabIndex="19" runat="server" Width="98%" TextMode="MultiLine" Height="54px"></asp:TextBox>
                                    </span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    
                    
                        <asp:Label ID="lblMsg" runat="server" Style="font-size: 13px; font-weight: bold;"></asp:Label>
                    
                    
                    
                    
                    <asp:GridView ID="GridViewTest_Assign" runat="server" CssClass="Grid_1" Width="100%" AutoGenerateColumns="False" ShowFooter="false">
                        <RowStyle CssClass="GridItem"></RowStyle>
                        <Columns>
                            <asp:TemplateField HeaderText="Test Name" SortExpression="TestName">
                                <ItemTemplate>
                                    <asp:Label ID="Label_TestName" runat="server" Text='<%# Bind("TestName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Urgent" SortExpression="Test Type">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkUrgent" runat="server" />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Special Inst">
                                <ItemTemplate>
                                    <asp:TextBox ID="TextBox_Description" runat="server" Text='<%# Eval("Description") %>' Width="98%"></asp:TextBox>
                                    <asp:HiddenField ID="hdnTID" runat="server" Value='<%# Eval("TID") %>' />

                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Charges" SortExpression="Charges" Visible="false">
                                <FooterTemplate>
                                    <asp:Label ID="Label_Total_Charges" runat="server" Text="Label"></asp:Label>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label_charges" runat="server" Text='<%# Bind("Charges") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterStyle HorizontalAlign="Right"></FooterStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Is Inside Hospital" SortExpression="IS_inside_Hospital_Test" Visible="false">
                                <ItemTemplate>
                                    <asp:CheckBox ID="CheckBox_Is_Inside_Hospital" runat="server" Checked='<%# Eval("IS_inside_Hospital_Test") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField Visible="false" ShowEditButton="True"></asp:CommandField>
                            <asp:ButtonField CommandName="select" Text="Cancel"></asp:ButtonField>
                        </Columns>

                        <FooterStyle CssClass="GridPager"></FooterStyle>

                        <SelectedRowStyle CssClass="gridselect"></SelectedRowStyle>

                        <HeaderStyle CssClass="GridHeader"></HeaderStyle>

                        <EditRowStyle CssClass="gridedit"></EditRowStyle>

                        <AlternatingRowStyle CssClass="GridAltItem"></AlternatingRowStyle>
                    </asp:GridView>



                     <div align="center" style="padding: 10px;">
                        <asp:Button ID="btnAdd" runat="server" Text="Save"></asp:Button>
                    </div>

 
                        
                        <asp:GridView ID="GridView_PatientAssignedTests" runat="server" CssClass="Grid_1" Width="100%" AutoGenerateColumns="False" ShowFooter="false">
                            <RowStyle CssClass="GridItem"></RowStyle>
                            <Columns>
                                <asp:TemplateField HeaderText="Test Name" SortExpression="TestName">
                                    <ItemTemplate>
                                        <asp:Label ID="Label_TestName" runat="server" Text='<%# Bind("TestName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Urgent" SortExpression="Test Type">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkUrgent" runat="server" Checked='<%# Bind("TestType") %>' />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Special Inst">
                                    <ItemTemplate>
                                        <asp:Label ID="Label_Description" runat="server" Text='<%# Bind("Description") %>'></asp:Label>
                                        <asp:HiddenField ID="hdnTID" runat="server" Value='<%# Eval("TID") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>

                            </Columns>
                        </asp:GridView>
                    
                </div>

                 <asp:HiddenField ID="HiddenField_Order_ID" runat="server"></asp:HiddenField>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:HiddenField ID="HiddenField_MG_ID" runat="server" />

      
     </div>

	  <div id="testResults_content" class="hideall" style="display:none;">
     
   			  <INVC:InveestigationChartControl runat="server" ID="patientInvestigation" />
     
     </div>
 
      <asp:Label ID="LabelFooter" runat="server" Text="" Visible="false"></asp:Label>
      
       </div><!--pageContent-->
  </div><!--main_bx-->
      
</asp:Content>

