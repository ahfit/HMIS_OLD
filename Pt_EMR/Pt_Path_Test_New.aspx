<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage.master" inherits="Pt_Path_Test_New, App_Web_p0fljamz" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script language ="javascript"  type="text/JavaScript">
function ViewReport() 
{ 
//alert("sdfsd");
  window.open("PatalogyTestReport.aspx","MyWindow","");
 return false;
}
function message() 
{

 
window.alert("asdfsdfsdf");
}

</script>
  <script>
		$(document).ready(function(){
			 
			
			$(".openlink").colorbox({width:"900px", height:"85%", iframe:true});
			 
				
		});
	</script>
    
     <script language ="javascript"  type="text/JavaScript">
     $(document).ready( function() {
          $('#prevs1').click(function() {
 
    	      location.reload();
 
	});
    });
   
     
     </script>
    
    
    
  <script src="../css_hacims/ck.js" type="text/javascript"></script>
  <script src="../SpryAssets/mycollaps.js" type="text/javascript"></script>
  <script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript"></script>
  <script src="../css_hacims/SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>
  <link href="../css_hacims/SpryAssets/SpryTabbedPanels.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    <Services>
      <asp:ServiceReference Path="../autocomplete.asmx" />
    </Services>
  </asp:ScriptManager>
  
  <asp:Panel ID="Panel2" runat="server" Width="100%">
    </asp:Panel>
  <asp:Label ID="Label2" runat="server" CssClass="err" Visible="False"></asp:Label>
  <asp:DropDownList ID="DropDownListCategory" runat="server" Width="130px" AutoPostBack="True" Visible="False" >
    <asp:ListItem>Section</asp:ListItem>
    <asp:ListItem>Specimen</asp:ListItem>
  </asp:DropDownList>
  <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="ForTestGroup"
                          DataTextField="TGName" DataValueField="TGID" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged"
                          Width="132px" Visible="False"> </asp:DropDownList>
 
  <table width="100%" border="0" cellspacing="0" cellpadding="0" >
    <tr>
      <td class="leftnav" valign="top" ><asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
        <asp:Panel ID="Panel1" runat="server" Visible="False">
          </asp:Panel></td>
      <td   valign="top" ><div id="TabbedPanels1" class="TabbedPanels">
          <ul class="TabbedPanelsTabGroup" style="margin-left:10px;">
            <li class="TabbedPanelsTab" tabindex="0">Current Investigations</li><li id="prevs" class="TabbedPanelsTab" tabindex="0">Previous Investigations</li>
            <li  class="TabbedPanelsTab" tabindex="0" style="display:none;">Lab Reports</li></ul>
          <div class="TabbedPanelsContentGroup">
            <div class="TabbedPanelsContent" >
              <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
 

<cc1:AutoCompleteExtender id="GetMedication" runat="server" BehaviorID="GetPathTest" TargetControlID="TextBox_Test" ServicePath="../AutoComplete.asmx" ServiceMethod="GetPathTest" MinimumPrefixLength="3" EnableCaching="true" CompletionSetCount="12" CompletionListHighlightedItemCssClass="AutoExtenderHighlight" CompletionListItemCssClass="AutoExtenderList" CompletionListCssClass="AutoExtender" CompletionInterval="10"> </cc1:AutoCompleteExtender>&nbsp; <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0><TBODY>
<TR><TD vAlign=top width="40%">
<asp:GridView id="GridView_Test" runat="server" Width="100%" Visible="False" DataSourceID="SqlDataSource_Test_booking_new" AutoGenerateColumns="False" ShowHeader="False">
                            <Columns>
                            <asp:ButtonField CommandName="Select" DataTextField="TB_Name" SortExpression="TB_Name" />
                            <asp:BoundField DataField="TB_Name" HeaderText="TB_Name" SortExpression="TB_Name" />
                            <asp:BoundField DataField="TB_ID" HeaderText="TB_ID" InsertVisible="False" SortExpression="TB_ID" />
                            </Columns>
                            <RowStyle CssClass="GridItem" />
                            <FooterStyle CssClass="GridPager" />
                            <SelectedRowStyle CssClass="gridselect" />
                            <HeaderStyle CssClass="GridHeader" />
                            <EditRowStyle CssClass="gridedit" />
                            <AlternatingRowStyle CssClass="GridAltItem" />
                          </asp:GridView> &nbsp; 
                          <asp:HiddenField id="HiddenFieldGender" runat="server"></asp:HiddenField> <asp:SqlDataSource id="SqlDataSource_labTests" runat="server" SelectCommand="SELECT Test_Booking.TB_Name, Test_Booking.TB_ID, TestGroup.TGName FROM Test_Booking INNER JOIN TestGroup ON Test_Booking.MG_ID = TestGroup.TGID" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"></asp:SqlDataSource> <asp:DataList id="DataList1" runat="server" Width="100%" DataSourceID="ForTestGroup" DataKeyField="MG_ID" RepeatDirection="Horizontal" RepeatColumns="2" SelectedItemStyle-CssClass="link_datalist_sel">
                            <SelectedItemStyle CssClass="link_datalist_sel"></SelectedItemStyle>
                            <ItemTemplate>
                              <asp:LinkButton id="LinkButton1" runat="server" Text='<%# Eval("TGName", "{0}") %>' CssClass="link_datalist" CommandName="Select" CommandArgument='<%# Eval("MG_ID", "{0}") %>'></asp:LinkButton>
                            </ItemTemplate>
                          </asp:DataList> <DIV style="WIDTH: 98%" class="bxmain">
                          
                          <TABLE class="tbl_form" cellSpacing=0 cellPadding=0 width="100%" border=0>
                          <TBODY><TR><TD style="HEIGHT: 18px" align=right>Test Name :</TD><TD style="HEIGHT: 18px">
                          <asp:TextBox accessKey="n" id="TextBox_Test" runat="server" Width="95%" AutoPostBack="True"></asp:TextBox>
                          </TD>
                          </TR>
                          </TBODY></TABLE>
                          
                          
                          </DIV><BR /><DIV style="OVERFLOW-X: hidden; OVERFLOW: auto; WIDTH: 98%; HEIGHT: 250px"><asp:CheckBoxList style="FONT-SIZE: 10px" id="CheckBoxList_LabTest" runat="server" AutoPostBack="True" DataValueField="TB_ID" DataTextField="TB_Name" DataSourceID="SqlDataSource_Test_booking_new" RepeatDirection="Horizontal" RepeatColumns="2"></asp:CheckBoxList> <asp:SqlDataSource id="SqlDataSource_Test_booking_new" runat="server" ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>" SelectCommand="SELECT Test_Booking.TB_Name, Test_Booking.TB_ID, TestGroup.TGName FROM Test_Booking INNER JOIN TestGroup ON Test_Booking.MG_ID = TestGroup.TGID WHERE (Test_Booking.MG_ID like @MG_ID ) and (Test_Booking.TB_Name like '%' +@TB_Name + '%')" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>">
                              <SelectParameters>
                                <asp:ControlParameter ControlID="HiddenField_MG_ID" PropertyName="Value" DefaultValue="%" Name="MG_ID"></asp:ControlParameter>
                                <asp:ControlParameter ControlID="TextBox_Test" PropertyName="Text" DefaultValue="%" Name="TB_Name"></asp:ControlParameter>
                              </SelectParameters>
                            </asp:SqlDataSource> </DIV><BR /><DIV align=center><asp:Button id="Button_record" runat="server" Text="Add" Visible="False"></asp:Button> </DIV>
                            </TD><TD vAlign=top><DIV style="MARGIN-TOP: 0px; width:99%;" class="bxmain"><TABLE class="tbl_form" cellSpacing=0 cellPadding=0 width="100%" border=0><TBODY>
                            <TR><TD vAlign=top align=right>Test Type : </TD><TD vAlign=top>
                            <asp:RadioButtonList id="RadioButtonList_Type" tabIndex=16 runat="server" Width="100%" DataValueField="Test_Type_ID" 
                            DataTextField="Test_Type" DataSourceID="SqlDataSource_Test_Type" RepeatDirection="Horizontal" RepeatLayout="Flow"> </asp:RadioButtonList></TD>
                            </TR><TR><TD vAlign=top align=right>Comments: </TD><TD vAlign=top><asp:TextBox id="TextBoxDescription" tabIndex=19 runat="server" Width="98%" TextMode="MultiLine" Height="54px"></asp:TextBox></TD></TR></TBODY></TABLE></DIV><BR />
                            <div>
                            <asp:Label ID="lblMsg" runat="server" style="font-size:13px; font-weight:bold;" ></asp:Label>
                            </div>

                            <asp:GridView id="GridViewTest_Assign" runat="server" CssClass="Grid_1" Width="100%" AutoGenerateColumns="False" ShowFooter="True">
<RowStyle CssClass="GridItem"></RowStyle>
<Columns>
<asp:TemplateField HeaderText="TestName" SortExpression="TestName"><EditItemTemplate>
                                <asp:Label ID="Label_TestName" runat="server" Text='<%# Bind("TestName") %>'></asp:Label>
                              
</EditItemTemplate>
<ItemTemplate>
<asp:Label id="Label_TestName" runat="server" Text='<%# Bind("TestName") %>' __designer:wfdid="w1"></asp:Label> <asp:HiddenField id="HiddenField1" runat="server" Value='<%# Eval("TestType_ID") %>' __designer:wfdid="w2"></asp:HiddenField> 
</ItemTemplate>
</asp:TemplateField>
<asp:BoundField DataField="TID" HeaderText="TID" SortExpression="TID"></asp:BoundField>
<asp:TemplateField HeaderText="Test Type" SortExpression="Test Type"><EditItemTemplate>
                                <asp:RadioButtonList ID="RadioButtonList_TypeG" runat="server" DataSourceID="SqlDataSource_Test_Type_G"
                                                    DataTextField="Test_Type" DataValueField="Test_Type_ID" RepeatDirection="Horizontal"
                                                    RepeatLayout="Flow" TabIndex="16" Width="100%" SelectedValue='<%# Eval("[TestType_ID]") %>'> </asp:RadioButtonList>
                                <asp:SqlDataSource ID="SqlDataSource_Test_Type_G" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" SelectCommand="SELECT Test_Type, Test_Type_ID FROM Test_Type"> </asp:SqlDataSource>
                              
</EditItemTemplate>
<ItemTemplate>
<asp:Label id="Label_TestType" runat="server" Text='<%# Bind("[Test Type]") %>'></asp:Label> <asp:HiddenField id="HiddenField3" runat="server" Value='<%# Eval("TestType_ID") %>'></asp:HiddenField> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="Description" SortExpression="Description"><EditItemTemplate>
                                <asp:TextBox ID="TextBox_Description" runat="server" Text='<%# Eval("Description") %>'></asp:TextBox>
                              
</EditItemTemplate>
<ItemTemplate>
<asp:Label id="Label_Description" runat="server" Text='<%# Bind("Description") %>' Visible="False" __designer:wfdid="w3"></asp:Label> <asp:TextBox id="TextBox_Description" runat="server" Text='<%# Eval("Description") %>' Width="100px" __designer:wfdid="w4"></asp:TextBox> 
</ItemTemplate>
</asp:TemplateField>
<asp:BoundField DataField="TestType_ID" HeaderText="TestType_ID" SortExpression="TestType_ID" Visible="false"></asp:BoundField>
<asp:TemplateField HeaderText="Charges" SortExpression="Charges" Visible="false"><EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Enabled="False" Text='<%# Bind("Charges") %>' Visible="False"></asp:TextBox>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Charges") %>'></asp:Label>
                              
</EditItemTemplate>
<FooterTemplate>
                                <asp:Label ID="Label_Total_Charges" runat="server" Text="Label"></asp:Label>
                              
</FooterTemplate>
<ItemTemplate>
                                <asp:Label ID="Label_charges" runat="server" Text='<%# Bind("Charges") %>'></asp:Label>
                              
</ItemTemplate>

<FooterStyle HorizontalAlign="Right"></FooterStyle>

<ItemStyle HorizontalAlign="Right"></ItemStyle>
</asp:TemplateField>
<asp:TemplateField HeaderText="Is Inside Hospital" SortExpression="IS_inside_Hospital_Test" Visible="false"><EditItemTemplate>
    &nbsp;<asp:CheckBox ID="CheckBox_Is_Inside_Hospital_Edit" runat="server" Checked='<%# Bind("IS_inside_Hospital_Test") %>' />
                              
</EditItemTemplate>
<ItemTemplate>
 
                                <asp:CheckBox ID="CheckBox_Is_Inside_Hospital" runat="server" Checked='<%# Eval("IS_inside_Hospital_Test") %>' />
                              
</ItemTemplate>
</asp:TemplateField>
<asp:CommandField ShowEditButton="True"></asp:CommandField>
<asp:ButtonField CommandName="select" Text="Cancel"></asp:ButtonField>
</Columns>

<FooterStyle CssClass="GridPager"></FooterStyle>

<SelectedRowStyle CssClass="gridselect"></SelectedRowStyle>

<HeaderStyle CssClass="GridHeader"></HeaderStyle>

<EditRowStyle CssClass="gridedit"></EditRowStyle>

<AlternatingRowStyle CssClass="GridAltItem"></AlternatingRowStyle>
</asp:GridView> <BR /><DIV align=center><asp:Button id="btnAdd" runat="server" Text="Save"></asp:Button> </DIV><BR /><asp:Panel id="Panel_Register_Test" runat="server" Visible="False"><BR />&nbsp; 
<asp:SqlDataSource id="SqlDataSource_MG_Name" runat="server" 
ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" 
SelectCommand="SELECT TGName, TGID FROM TestGroup" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>" 
InsertCommand="INSERT INTO Test_Booking(TB_Name, Private_Price, Public_Price, MG_ID,S_Id) VALUES (@TB_Name, @Private_Price, @Public_Price, @MG_ID,@S_Id)">
                              <InsertParameters>
                                <asp:ControlParameter ControlID="TextBox_TBNAme" Name="TB_Name" PropertyName="Text" />
                                <asp:Parameter DefaultValue="0" Name="Private_Price" />
                                <asp:Parameter DefaultValue="0" Name="Public_Price" />
                                <asp:ControlParameter ControlID="DropDownList_MGName" Name="MG_ID" PropertyName="SelectedValue" />
                                <asp:Parameter DefaultValue="0" Name="S_Id" />
                              </InsertParameters>
                            </asp:SqlDataSource> 
    <TABLE class="tbl_form" cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY><TR><TD colSpan=2><STRONG>Test is not Registered in Hospital.</STRONG></TD></TR>
            <TR><TD align=right width="25%">Main Group : </TD><TD width="25%">&nbsp; 
                <asp:DropDownList id="DropDownList_MGName" runat="server" Width="200px" AutoPostBack="True" DataValueField="TGID" DataTextField="TGName" DataSourceID="SqlDataSource_MG_Name"> </asp:DropDownList></TD></TR><TR><TD align=right>Name :</TD><TD><asp:TextBox id="TextBox_TBNAme" runat="server" CssClass="input_txt" Width="200px"></asp:TextBox></TD></TR><TR><TD align=right></TD><TD><asp:Button id="Button_Save_TestBooking" onclick="Button_Save_TestBooking_Click" runat="server" Text="Save" Width="88px"></asp:Button> <asp:Button id="Button_Pnl_Cancel" onclick="Button_Pnl_Cancel_Click" runat="server" Text="Cancel"></asp:Button></TD></TR></TBODY></TABLE><BR /><BR />&nbsp; </asp:Panel></TD></TR></TBODY></TABLE>
                    <asp:Label id="labelGName" runat="server" CssClass="err" Visible="False"></asp:Label> <BR /><asp:TreeView id="TreeView1" runat="server" Visible="False"> </asp:TreeView><BR />&nbsp;<asp:HiddenField id="HiddenField_Order_ID" runat="server"></asp:HiddenField>&nbsp; <asp:SqlDataSource id="SqlDataSourceInsertSub" runat="server" ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" SelectCommand="&#13;&#10;" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>" InsertCommandType="StoredProcedure" InsertCommand="Insert_Pathology_Test_Total_Amount"><InsertParameters>
<asp:ControlParameter ControlID="HiddenFieldMain_ID" PropertyName="Value" Name="Main_ID"></asp:ControlParameter>
<asp:Parameter DefaultValue="0" Name="TOtal_Discount"></asp:Parameter>
<asp:Parameter DefaultValue="0" Name="Total_Paid"></asp:Parameter>
<asp:Parameter DefaultValue="0" Name="Total_AMount"></asp:Parameter>
</InsertParameters>
</asp:SqlDataSource> 

<%--<asp:SqlDataSource id="SqlDataSourceTest" runat="server" 
ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>" 

SelectCommand="SELECT DISTINCT &#13;&#10;                      CONVERT(varchar, Investigation_Order_Main.Date_Time, 103) + ' ' + CONVERT(varchar, Investigation_Order_Main.Date_Time, 108) AS TestAssignDate, &#13;&#10;                      TestGroup.TGName, TestGroup.TGID, ISNULL(Test_Type.Test_Type, 'Routine') AS Test_Type, Path_Test_Booking_Services.Sample_No, &#13;&#10;                      Investigation_Order_Main.YearlyNo AS Yearly_No, Path_Test_Booking_Services.Main_ID, Investigation_Order_Main.Date_Time, Test_Booking.TB_Name, &#13;&#10;                      Investigation_Order_Sub.TB_ID, Investigation_Order_Main.RegNo AS Reg_No, &#13;&#10;                      Investigation_Order_Main.Investigation_Order_ID,isnull( Test_Status.Status,'Advice') AS Status, Test_Status.Status_Id  AS Status_Id&#13;&#10;&#13;&#10;FROM         Test_Type INNER JOIN&#13;&#10;                      Investigation_Order_Sub INNER JOIN&#13;&#10;                      Investigation_Order_Main ON Investigation_Order_Sub.Investigation_Order_ID = Investigation_Order_Main.Investigation_Order_ID INNER JOIN&#13;&#10;                      Test_Booking INNER JOIN&#13;&#10;                      TestGroup ON Test_Booking.MG_ID = TestGroup.TGID ON Investigation_Order_Sub.TB_ID = Test_Booking.TB_ID ON &#13;&#10;                      Test_Type.Test_Type_ID = Investigation_Order_Sub.TestType_ID LEFT OUTER JOIN&#13;&#10;                      Path_Test_Booking_Services INNER JOIN&#13;&#10;                      Patient_Services ON Path_Test_Booking_Services.Main_ID = Patient_Services.Order_Id INNER JOIN&#13;&#10;                      Test_Status ON Path_Test_Booking_Services.Status = Test_Status.Status_ID ON Investigation_Order_Sub.Patient_Services_Billing_Id = Patient_Services.ID&#13;&#10;WHERE     (Investigation_Order_Main.RegNo = @RegNo) AND (Investigation_Order_Main.YearlyNo = @YearlyNo)&#13;&#10;ORDER BY Investigation_Order_Main.Date_Time DESC" 
ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"><SelectParameters>

<asp:SessionParameter SessionField="registrationNo" Name="RegNo" Type="String"></asp:SessionParameter>
<asp:SessionParameter SessionField="YearlyNo" Name="YearlyNo"></asp:SessionParameter>
</SelectParameters>
</asp:SqlDataSource>
--%>
<asp:SqlDataSource id="SqlDataSourceTest" runat="server" 
ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>" 

SelectCommand="SELECT DISTINCT Test_Booking.TB_Name,TestGroup.TGName,TestGroup.TGID, 
CONVERT(varchar, Investigation_Order_Main.Date_Time, 103) + ' ' + CONVERT(varchar, Investigation_Order_Main.Date_Time, 108) AS 
TestAssignDate,  Investigation_Order_Main.Date_Time,Path_Test_Booking_Services.Main_ID,Investigation_Order_Main.RegNo AS Reg_No, 
Path_Test_Booking_Services.Sample_No,isnull( Test_Status.Status,'Advice') AS Status,Test_Status.Status_Id  AS Status_Id,
Investigation_Order_Sub.TB_ID,ISNULL(Test_Type.Test_Type, 'Routine') AS Test_Type, 
 Investigation_Order_Main.YearlyNo AS Yearly_No,  Investigation_Order_Main.Investigation_Order_ID 
FROM  Test_Type INNER JOIN Investigation_Order_Sub 
INNER JOIN
Investigation_Order_Main ON Investigation_Order_Sub.Investigation_Order_ID = Investigation_Order_Main.Investigation_Order_ID INNER JOIN
Test_Booking INNER JOIN TestGroup ON Test_Booking.MG_ID = TestGroup.TGID ON Investigation_Order_Sub.TB_ID = Test_Booking.TB_ID ON 
Test_Type.Test_Type_ID = Investigation_Order_Sub.TestType_ID LEFT OUTER JOIN 
Path_Test_Booking_Services INNER JOIN Patient_Services ON Path_Test_Booking_Services.Main_ID = Patient_Services.Order_Id INNER JOIN
Test_Status ON Path_Test_Booking_Services.Status = Test_Status.Status_ID ON Investigation_Order_Sub.Patient_Services_Billing_Id = Patient_Services.ID
WHERE    
(Investigation_Order_Main.RegNo = @RegNo) AND 
(Investigation_Order_Main.YearlyNo = @YearlyNo)

Union All 

Select Test_Booking.TB_Name,TestGroup.TGName,TestGroup.TGID,ABC.TestAssignDate,abc.Date_Time,ABC.Main_ID,abc.Reg_No,
abc.Sample_No,abc.Status,abc.Status_Id,abc.TB_ID,abc.Test_Type,abc.Yearly_No,0 From (SELECT DISTINCT 
Case When Investigation_Order_Main.Date_Time Is Not null Then CONVERT(varchar, Investigation_Order_Main.Date_Time, 103)
Else CONVERT(varchar, Patient_Services.sdatetime, 103) End  + ' ' + 
Case When Investigation_Order_Main.Date_Time Is Not Null Then CONVERT(varchar, Investigation_Order_Main.Date_Time, 108)
Else CONVERT(varchar, Patient_Services.sdatetime, 108) End AS TestAssignDate, 
ISNULL(Test_Type.Test_Type, 'Routine') AS Test_Type, Path_Test_Booking_Services.Sample_No, 
Case When Investigation_Order_Main.YearlyNo Is Not Null Then Investigation_Order_Main.YearlyNo Else Patient_Services.YearlyNo End AS Yearly_No, 
Path_Test_Booking_Services.Main_ID, Investigation_Order_Main.Date_Time, 
Case When Investigation_Order_Main.RegNo Is Not Null then Investigation_Order_Main.RegNo Else Patient_Services.RegNo End AS Reg_No, 
Investigation_Order_Main.Investigation_Order_ID, ISNULL(Test_Status.Status, 'Advice') AS Status, Test_Status.Status_ID AS Status_Id,
Path_Test_Booking_Services.TB_ID
FROM Path_Test_Booking_Services INNER JOIN
Patient_Services ON Path_Test_Booking_Services.Main_ID = Patient_Services.Order_Id INNER JOIN
Test_Status ON Path_Test_Booking_Services.Status = Test_Status.Status_ID FULL OUTER JOIN
Investigation_Order_Sub INNER JOIN
Investigation_Order_Main ON Investigation_Order_Sub.Investigation_Order_ID = Investigation_Order_Main.Investigation_Order_ID INNER JOIN
Test_Type ON Investigation_Order_Sub.TestType_ID = Test_Type.Test_Type_ID ON Patient_Services.ID = Investigation_Order_Sub.Patient_Services_Billing_Id
WHERE     (@RegNo = Case When Investigation_Order_Main.RegNo Is not null then Investigation_Order_Main.RegNo Else Patient_Services.RegNo End )
	AND ( @YearlyNo = Case When Investigation_Order_Main.YearlyNo Is Not Null Then Investigation_Order_Main.YearlyNo Else Patient_Services.YearlyNo End)) ABC
	Inner Join Test_Booking ON abc.TB_ID = test_booking.TB_ID Inner Join TestGroup On Test_Booking.MG_ID = TestGroup.TGID

ORDER BY Investigation_Order_Main.Date_Time DESC" 
ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"><SelectParameters>

<asp:SessionParameter SessionField="registrationNo" Name="RegNo" Type="String"></asp:SessionParameter>
<asp:SessionParameter SessionField="YearlyNo" Name="YearlyNo"></asp:SessionParameter>
</SelectParameters>
</asp:SqlDataSource>



 <asp:HiddenField id="HiddenField_integrationMain_Id" runat="server"></asp:HiddenField> <asp:HiddenField id="HiddenField_TestType" runat="server"></asp:HiddenField> <asp:HiddenField id="HiddenField_Sample_collection" runat="server"></asp:HiddenField> <asp:HiddenField id="HiddenField_Report_Date" runat="server"></asp:HiddenField> <asp:HiddenField id="HiddenFieldMain_ID" runat="server"></asp:HiddenField> <asp:SqlDataSource id="SqlDataSource_PatientServices" runat="server" ProviderName="<%$ ConnectionStrings:Pathology2ConnectionString.ProviderName %>" ConnectionString="<%$ ConnectionStrings:Pathology2ConnectionString %>" InsertCommand="INSERT INTO [BasicDataInfo].[dbo].[Patient_Services]&#13;&#10;           ([RegNo]&#13;&#10;           ,[YearlyNo]&#13;&#10;           ,[sdatetime]&#13;&#10;           ,[empid]&#13;&#10;           ,[S_ID]&#13;&#10;           ,[Amount]&#13;&#10;           ,[Payment_Status]&#13;&#10;           ,[Doctor_ID]&#13;&#10;           ,[SubDept_ID]&#13;&#10;           ,[Doctor_Payment]&#13;&#10;           ,[Dept_ID]&#13;&#10;           ,[ResonForCancellation]&#13;&#10;           ,Order_ID)&#13;&#10;  &#13;&#10;&#13;&#10;SELECT     Path_Result_Delivery.Reg_no, Path_Result_Delivery.Yearly_No, Path_Result_Delivery.Test_Booking_Date, Path_Result_Delivery.EmpID, Test_Booking.S_Id, &#13;&#10;                      Admin_Services.S_Amount, 0 AS Expr1, NULL AS Expr2, Path_Result_Delivery.To_SubDept_ID, NULL AS Expr3, Path_Result_Delivery.To_Dept_ID, NULL AS Expr4, &#13;&#10;                      Path_Result_Delivery.Main_ID&#13;&#10;FROM         Test_Booking_Services INNER JOIN&#13;&#10;                      Test_Booking ON Test_Booking_Services.TB_ID = Test_Booking.TB_ID INNER JOIN&#13;&#10;                      Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID INNER JOIN&#13;&#10;                      Admin_Services ON Test_Booking.S_Id = Admin_Services.S_ID&#13;&#10;WHERE     (Path_Result_Delivery.Main_ID = @Main_Id)"><InsertParameters>
<asp:ControlParameter ControlID="HiddenFieldMain_ID" PropertyName="Value" Name="Main_Id"></asp:ControlParameter>
</InsertParameters>
</asp:SqlDataSource> 

<asp:SqlDataSource id="SqlDataSource_InvestigationOrderMain" runat="server" ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>" 
    SelectCommand="SELECT DISTINCT CONVERT(varchar, Date_Time, 103) + ' ' + CONVERT(varchar, Date_Time, 108) AS TestAssignDate, Investigation_Order_ID&#13;&#10;FROM         Investigation_Order_Main&#13;&#10;WHERE     (YearlyNo = @YearlyNo) AND (RegNo = @RegNo)&#13;&#10;order by CONVERT(varchar, Date_Time, 103) + ' ' + CONVERT(varchar, Date_Time, 108) " ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>">
                    <SelectParameters>
                      <asp:SessionParameter SessionField="YearlyNo" Name="YearlyNo"></asp:SessionParameter>
                      <asp:SessionParameter SessionField="registrationNo" Name="RegNo"></asp:SessionParameter>
                    </SelectParameters>
</asp:SqlDataSource>


<%--<asp:SqlDataSource id="SqlDataSource_InvestigationOrderMain" runat="server" ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>" 

SelectCommand=" Select Test_Booking.TB_Name,TestGroup.TGName,TestGroup.TGID,ABC.TestAssignDate,abc.Date_Time,ABC.Main_ID,abc.Reg_No,
abc.Sample_No,abc.Status,abc.Status_Id,abc.TB_ID,abc.TestAssignDate,abc.Test_Type,abc.Yearly_No From (SELECT DISTINCT 
Case When Investigation_Order_Main.Date_Time Is Not null Then CONVERT(varchar, Investigation_Order_Main.Date_Time, 103)
Else CONVERT(varchar, Patient_Services.sdatetime, 103) End  + ' ' + 
Case When Investigation_Order_Main.Date_Time Is Not Null Then CONVERT(varchar, Investigation_Order_Main.Date_Time, 108)
Else CONVERT(varchar, Patient_Services.sdatetime, 108) End AS TestAssignDate, 
ISNULL(Test_Type.Test_Type, 'Routine') AS Test_Type, Path_Test_Booking_Services.Sample_No, 
Case When Investigation_Order_Main.YearlyNo Is Not Null Then Investigation_Order_Main.YearlyNo Else Patient_Services.YearlyNo End AS Yearly_No, 
Path_Test_Booking_Services.Main_ID, Investigation_Order_Main.Date_Time, 
Case When Investigation_Order_Main.RegNo Is Not Null then Investigation_Order_Main.RegNo Else Patient_Services.RegNo End AS Reg_No, 
Investigation_Order_Main.Investigation_Order_ID, ISNULL(Test_Status.Status, 'Advice') AS Status, Test_Status.Status_ID AS Status_Id,
Path_Test_Booking_Services.TB_ID
FROM Path_Test_Booking_Services INNER JOIN
Patient_Services ON Path_Test_Booking_Services.Main_ID = Patient_Services.Order_Id INNER JOIN
Test_Status ON Path_Test_Booking_Services.Status = Test_Status.Status_ID FULL OUTER JOIN
Investigation_Order_Sub INNER JOIN
Investigation_Order_Main ON Investigation_Order_Sub.Investigation_Order_ID = Investigation_Order_Main.Investigation_Order_ID INNER JOIN
Test_Type ON Investigation_Order_Sub.TestType_ID = Test_Type.Test_Type_ID ON Patient_Services.ID = Investigation_Order_Sub.Patient_Services_Billing_Id
WHERE     (@RegNo = Case When Investigation_Order_Main.RegNo Is not null then Investigation_Order_Main.RegNo Else Patient_Services.RegNo End )
	AND (@YearlyNo = Case When Investigation_Order_Main.YearlyNo Is Not Null Then Investigation_Order_Main.YearlyNo Else Patient_Services.YearlyNo End)) ABC
	Inner Join Test_Booking ON abc.TB_ID = test_booking.TB_ID Inner Join TestGroup On ON Test_Booking.MG_ID = TestGroup.TGID
 " 
ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"

>
                    <SelectParameters>
                      <asp:SessionParameter SessionField="YearlyNo" Name="YearlyNo"></asp:SessionParameter>
                      <asp:SessionParameter SessionField="registrationNo" Name="RegNo"></asp:SessionParameter>
                    </SelectParameters>
</asp:SqlDataSource>
--%>
<asp:GridView id="GridView_Sample_Recieved" runat="server" CssClass="Grid_1" Width="100%" Visible="False" DataSourceID="SqlDataSource_For_Grid" AutoGenerateColumns="False">
<RowStyle CssClass="GridItem"></RowStyle>
<Columns>
<asp:TemplateField HeaderText="Sr. No."><ItemTemplate>
<asp:Label id="Label_SrNo" runat="server" Width="70px"></asp:Label> <asp:HiddenField id="HiddenField_TB_ID" runat="server" Value='<%# Bind("TB_ID", "{0}") %>'></asp:HiddenField> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="Request Date" SortExpression="Request_Date"><EditItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("Request_Date") %>'></asp:Label>
                            
</EditItemTemplate>
<ItemTemplate>
<asp:Label id="Label2" runat="server" Text='<%# Bind("Request_Date") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="Request Time" SortExpression="Request_Time"><EditItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("Request_Time") %>'></asp:Label>
                            
</EditItemTemplate>
<ItemTemplate>
<asp:Label id="Label3" runat="server" Text='<%# Bind("Request_Time") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="Suggested By" SortExpression="Employee"><EditItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("Employee") %>'></asp:Label>
                            
</EditItemTemplate>
<ItemTemplate>
<asp:Label id="Label4" runat="server" Text='<%# Bind("Employee") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="Test Category" SortExpression="TGName"><EditItemTemplate>
                                <asp:Label ID="Label8" runat="server" Text='<%# Bind("TGName") %>'></asp:Label>
                            
</EditItemTemplate>
<ItemTemplate>
<asp:Label id="Label5" runat="server" Text='<%# Bind("TGName") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="Test Name" SortExpression="TB_Name"><EditItemTemplate>
                                <asp:Label ID="Label9" runat="server" Text='<%# Bind("TB_Name") %>'></asp:Label>
                            
</EditItemTemplate>
<ItemTemplate>
<asp:Label id="Label6" runat="server" Text='<%# Bind("TB_Name") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="Test Type" SortExpression="TestType_ID"><EditItemTemplate>
<asp:DropDownList id="DropDownList3" runat="server" AutoPostBack="True" DataValueField="Test_Type_ID" DataTextField="Test_Type" DataSourceID="SqlDataSource1" SelectedValue='<%# Bind("Test_Type_Id") %>'>
                                </asp:DropDownList> <asp:SqlDataSource id="SqlDataSource1" runat="server" SelectCommand="SELECT Test_Type_ID, Test_Type FROM Test_Type" ConnectionString="<%$ ConnectionStrings:Pathology2ConnectionString %>"></asp:SqlDataSource><asp:HiddenField id="HiddenField_TestBookingId" runat="server" Value='<%# Eval("Test_Booking_ID") %>'></asp:HiddenField> 
</EditItemTemplate>
<ItemTemplate>
<asp:Label id="Label1" runat="server" Text='<%# Bind("Test_Type") %>'></asp:Label> <asp:HiddenField id="HiddenField_TestBookingId" runat="server" Value='<%# Eval("Test_Booking_ID") %>'></asp:HiddenField> <asp:HiddenField id="HiddenField_Current" runat="server" Value='<%# Eval("Test_Type_Id") %>'></asp:HiddenField> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="Emp_ID" SortExpression="Emp_ID" Visible="False"><ItemTemplate>
<asp:Label id="Label7" runat="server" Text='<%# Bind("Emp_ID") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="Description" SortExpression="Description"><EditItemTemplate>
<asp:TextBox id="TextBox1" runat="server" Text='<%# Bind("Description") %>'></asp:TextBox> 
</EditItemTemplate>
<ItemTemplate>
<asp:Label id="Label8" runat="server" Text='<%# Bind("Description") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="Specimen Received"><ItemTemplate>
<asp:CheckBox id="CheckBox1" runat="server" Checked="True"></asp:CheckBox> 
</ItemTemplate>
</asp:TemplateField>
</Columns>

<HeaderStyle CssClass="GridHeader"></HeaderStyle>

<AlternatingRowStyle CssClass="GridAltItem"></AlternatingRowStyle>
</asp:GridView><asp:SqlDataSource id="SqlDataSource_For_Grid" runat="server" ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" SelectCommand="SELECT CONVERT (varchar, Investigation_Order_Main.Date_Time, 107) AS Request_Date, CONVERT (varchar, Investigation_Order_Main.Date_Time, 108) AS Request_Time, TestGroup.TGName, Test_Booking.TB_Name, Investigation_Order_Main.Emp_ID, ISNULL(Employee.Prefix, '') + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS Employee, Investigation_Order_Sub.TB_ID, Test_Type.Test_Type, Test_Booking.Test_Type_Id, Test_Booking.TB_ID AS Test_Booking_ID, Investigation_Order_Sub.Description FROM Employee INNER JOIN Test_Booking INNER JOIN TestGroup ON Test_Booking.MG_ID = TestGroup.TGID INNER JOIN Investigation_Order_Sub INNER JOIN Investigation_Order_Main ON Investigation_Order_Sub.Investigation_Order_ID = Investigation_Order_Main.Investigation_Order_ID ON Test_Booking.TB_ID = Investigation_Order_Sub.TB_ID ON Employee.EmpID = Investigation_Order_Main.Emp_ID INNER JOIN Admin_Services ON Test_Booking.S_Id = Admin_Services.S_ID INNER JOIN Test_Type ON Test_Booking.Test_Type_Id = Test_Type.Test_Type_ID WHERE (Investigation_Order_Main.RegNo = @RegNo) AND (Investigation_Order_Main.YearlyNo = @YearlyNo) AND (Investigation_Order_Main.Investigation_Order_ID = @Investigation_Order_ID) AND (Investigation_Order_Main.Status = 11) AND (Investigation_Order_Sub.TB_ID NOT IN (SELECT Test_Booking_Services.TB_ID FROM Path_Result_Delivery INNER JOIN Test_Booking_Services ON Path_Result_Delivery.Main_ID = Test_Booking_Services.Main_ID WHERE (Path_Result_Delivery.Reg_no = @RegNo) AND (Path_Result_Delivery.Yearly_No = @YearlyNo) AND (Path_Result_Delivery.HospitalOrderNo = @Order_ID)))" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>" UpdateCommand="Update Investigation_Order_Sub &#13;&#10;set Investigation_Order_Sub.TestType_ID=@Test_Type_Id, Investigation_Order_Sub.Description=@description&#13;&#10;From Investigation_Order_Main INNER JOIN&#13;&#10;                      Investigation_Order_Sub ON Investigation_Order_Main.Investigation_Order_ID = Investigation_Order_Sub.Investigation_Order_ID &#13;&#10;where Investigation_Order_Sub.TB_ID=@TB_ID and Investigation_Order_Main.YearlyNo=@YearlyNo &#13;&#10;                      and Investigation_Order_Main.RegNo=@RegNo&#13;&#10;&#13;&#10;&#13;&#10;UPDATE Test_Booking SET Test_Type_Id = @Test_Type_Id WHERE (TB_ID = @TB_ID)"><UpdateParameters>
<asp:ControlParameter PropertyName="Value" Name="Test_Type_Id" ControlID="HiddenField2"></asp:ControlParameter>
<asp:ControlParameter PropertyName="Value" Name="TB_ID" ControlID="HiddenField1"></asp:ControlParameter>
<asp:ControlParameter PropertyName="Value" Name="description" ControlID="HiddenField_Description"></asp:ControlParameter>
<asp:QueryStringParameter Name="YearlyNo" QueryStringField="YearlyNo"></asp:QueryStringParameter>
<asp:QueryStringParameter Name="RegNo" QueryStringField="Reg_No"></asp:QueryStringParameter>
</UpdateParameters>
<SelectParameters>
<asp:SessionParameter SessionField="RegistrationNo" Name="RegNo"></asp:SessionParameter>
<asp:SessionParameter SessionField="YearlyNo" Name="YearlyNo"></asp:SessionParameter>
<asp:ControlParameter PropertyName="Value" Name="Investigation_Order_ID" ControlID="HiddenField_Order_ID"></asp:ControlParameter>
<asp:Parameter DefaultValue="10" Name="Dept_ID"></asp:Parameter>
<asp:ControlParameter PropertyName="Value" Name="Order_ID" ControlID="HiddenField_Order_ID"></asp:ControlParameter>
</SelectParameters>
</asp:SqlDataSource> <asp:SqlDataSource id="SqlDataSource1" runat="server" ProviderName="<%$ ConnectionStrings:LGHConnectionString12.ProviderName %>" SelectCommand="Select @PFNAME = PFNAME from patient" ConnectionString="<%$ ConnectionStrings:LGHConnectionString12 %>"> </asp:SqlDataSource> <asp:HiddenField id="HiddenField2" runat="server"></asp:HiddenField> <asp:SqlDataSource id="ForTestGroup" runat="server" ProviderName="<%$ ConnectionStrings:Pathology2ConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT TestGroup.TGID, TestGroup.TGName, Admin_Dept_Services.Dept_ID, TestGroup.TGID as MG_ID FROM Test_Booking LEFT OUTER JOIN Admin_Dept_Services ON Test_Booking.S_Id = Admin_Dept_Services.S_ID LEFT OUTER JOIN TestGroup ON Test_Booking.MG_ID = TestGroup.TGID WHERE (Admin_Dept_Services.Dept_ID = 10) " ConnectionString="<%$ ConnectionStrings:Pathology2ConnectionString %>"></asp:SqlDataSource> <asp:SqlDataSource id="ForTestSubGroup" runat="server" ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>" SelectCommand="SELECT isnull(TestSubGroup.TSGName,'') as TSGName, TestSubGroup.TSGID, isnull(TestGroup.TGName,'') as TGName FROM TestSubGroup INNER JOIN TestGroup ON TestSubGroup.TGID = TestGroup.TGID WHERE (TestSubGroup.TGID = @TGID)" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>">
                    <SelectParameters>
                      <asp:ControlParameter ControlID="Dropdownlist2" Name="TGID" PropertyName="SelectedValue"
                                Type="Int32" />
                    </SelectParameters>
                  </asp:SqlDataSource> <asp:SqlDataSource id="ForTest" runat="server" ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>" SelectCommand="SELECT [TestName], [TID] FROM [Test] WHERE ([TGID] = @TGID)" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>">
                    <SelectParameters>
                      <asp:ControlParameter ControlID="HiddenFieldTestSubGroup" Name="TGID" PropertyName="Value"
                      Type="Int32" />
                    </SelectParameters>
                  </asp:SqlDataSource> <asp:SqlDataSource id="SqlDataSource_Test_Type" runat="server" ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" SelectCommand="SELECT Test_Type, Test_Type_ID FROM Test_Type" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"> </asp:SqlDataSource> <asp:HiddenField id="HiddenFieldTestSubGroup" runat="server"></asp:HiddenField> <asp:SqlDataSource id="SqlDataSourcefortsetSG" runat="server" ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>" SelectCommand="SELECT [TID], [TestName] FROM [Test] WHERE ([TSGID] = @TSGID)" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>">
                    <SelectParameters>
                      <asp:ControlParameter ControlID="HiddenField_for_test" Name="TSGID" PropertyName="Value"
                        Type="Int32" />
                    </SelectParameters>
                  </asp:SqlDataSource> <asp:HiddenField id="HiddenField_for_test" runat="server"></asp:HiddenField> 
</ContentTemplate>
              </asp:UpdatePanel>
              <asp:HiddenField ID="HiddenField_MG_ID" runat="server" />
            </div>
            <div class="TabbedPanelsContent"> 
            
            
<asp:GridView id="GridView1" runat="server" Width="100%" DataSourceID="SqlDataSourceTest" AutoGenerateColumns="False" DataKeyNames="Main_ID">
                    <RowStyle CssClass="GridItem"></RowStyle>
                    <Columns>
                    <asp:BoundField DataField="TGID" HeaderText="Test Group #" ReadOnly="True" InsertVisible="False" SortExpression="TGID"></asp:BoundField>
                    <asp:BoundField DataField="TestAssignDate" HeaderText="Advise Date" ReadOnly="True" SortExpression="TestAssignDate"></asp:BoundField>
                    <asp:BoundField DataField="TGName" HeaderText="Group" SortExpression="TGName"></asp:BoundField>
                    <asp:BoundField DataField="TB_Name" HeaderText="Test" SortExpression="TB_Name"></asp:BoundField>
                    <asp:BoundField DataField="Main_ID" HeaderText="Lab #" ReadOnly="True" InsertVisible="False" SortExpression="Main_ID"></asp:BoundField>
                        <asp:BoundField DataField="Sample_No" SortExpression="Sample_No" HeaderText="Lab Sample #" />
                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status"></asp:BoundField>
                    <asp:HyperLinkField DataNavigateUrlFields="Reg_no,Yearly_No,TGID,Main_ID,Sample_No,Status_Id" DataNavigateUrlFormatString="~/Pathology/Patient_Result_Report.aspx?RegNo={0}&amp;YearlyNo={1}&amp;TGID={2}&amp;Main_ID={3}&amp;Sample_No={4}&amp;Status={5}" Text="Report" HeaderText="Report" Visible="false">
                      <ControlStyle CssClass="openlink"></ControlStyle>
                    </asp:HyperLinkField>
                        <asp:BoundField DataField="Reg_No" SortExpression="Reg_No" Visible="False" />
                        <asp:BoundField DataField="Yearly_No" SortExpression="Yearly_No" Visible="False" />
                    </Columns>
                    <HeaderStyle CssClass="GridHeader"></HeaderStyle>
                    <AlternatingRowStyle CssClass="GridAltItem"></AlternatingRowStyle>
                  </asp:GridView>             
            
            <asp:DataList id="DataList_InvestigationOrderMain" runat="server" OnSelectedIndexChanged="DataList_InvestigationOrderMain_SelectedIndexChanged" DataSourceID="SqlDataSource_InvestigationOrderMain" DataKeyField="Investigation_Order_ID" Width="100%" AlternatingItemStyle-BackColor="#d7e6ee" CssClass="Grid_1" style="font-size:11px;" Visible="False">
                    <HeaderTemplate>
                    <strong>   TestAssignDate </strong>
                    </HeaderTemplate>
                    <ItemTemplate>
                     <table  cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%" style="margin-top:5px;">
  <tr>
    <td valign="top" style="width:130px;" align="left"  ><asp:Label ID="TestAssignDateLabel" runat="server" Text='<%# Eval("TestAssignDate") %>'></asp:Label> </td>
    <td valign="top"> <asp:DataList ID="DataList_InvestigationOrderSub" runat="server" DataSourceID="SqlDataSource_InvestigationOrderSub">
                              <ItemTemplate>
                                 
                                  
                                     <asp:Label ID="TGNameLabel" runat="server" Text='<%# Eval("TGName") %>'></asp:Label>&nbsp;|&nbsp; 
                                    <asp:Label ID="TB_NameLabel" runat="server" Text='<%# Eval("TB_Name") %>'></asp:Label> &nbsp;|&nbsp;
                                    <asp:Label ID="Test_TypeLabel" runat="server" Text='<%# Eval("Test_Type") %>'></asp:Label> &nbsp;|&nbsp;
                                   
                                     <asp:Label ID="StatusLabel" runat="server" Text='<%# Eval("Status") %>'></asp:Label> 
                                 
                              </ItemTemplate>
                            </asp:DataList></td>
    <td valign="top" style="width:50px; padding-right:5px;" align="right"  ><asp:LinkButton ID="LinkButton_Report" runat="server" CommandName="Select">Report</asp:LinkButton> </td>
  </tr>
</table>

                      
                          
                         
                            
                            
                             
                      
                      
                      
                      <asp:HiddenField ID="HiddenField_Investigation_Order_ID" runat="server" Value='<%# Eval("Investigation_Order_ID") %>' />
                      <asp:SqlDataSource ID="SqlDataSource_InvestigationOrderSub" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                    SelectCommand="SELECT DISTINCT &#13;&#10;                      CONVERT(varchar, Investigation_Order_Main.Date_Time, 103) + ' ' + CONVERT(varchar, Investigation_Order_Main.Date_Time, 108) AS TestAssignDate, &#13;&#10;                      TestGroup.TGName,  Test_Type.Test_Type, Test_Status.Status, &#13;&#10;                      Path_Result_Delivery.Reg_no, Path_Result_Delivery.Yearly_No,[dbo].[Pathology_TB_Name_INVOrderID](Investigation_Order_Main.YearlyNo,Investigation_Order_Main.RegNo,TestGroup.TGID,Investigation_Order_Main.Investigation_Order_ID) as TB_Name&#13;&#10;FROM         Test_Status INNER JOIN&#13;&#10;                      Investigation_Order_Sub INNER JOIN&#13;&#10;                      Investigation_Order_Main ON Investigation_Order_Sub.Investigation_Order_ID = Investigation_Order_Main.Investigation_Order_ID INNER JOIN&#13;&#10;                      Test_Booking INNER JOIN&#13;&#10;                      TestGroup ON Test_Booking.MG_ID = TestGroup.TGID ON Investigation_Order_Sub.TB_ID = Test_Booking.TB_ID ON &#13;&#10;                      Test_Status.Status_ID = Investigation_Order_Main.Status LEFT OUTER JOIN&#13;&#10;                      Test_Type ON Investigation_Order_Sub.TestType_ID = Test_Type.Test_Type_ID LEFT OUTER JOIN&#13;&#10;                      Path_Test_Booking_Services INNER JOIN&#13;&#10;                      Path_Result_Delivery ON Path_Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID ON &#13;&#10;                      Investigation_Order_Main.YearlyNo = Path_Result_Delivery.Yearly_No AND Investigation_Order_Main.RegNo = Path_Result_Delivery.Reg_no AND &#13;&#10;                      Investigation_Order_Main.Investigation_Order_ID = Path_Result_Delivery.HospitalOrderNo&#13;&#10;WHERE     (Investigation_Order_Main.YearlyNo = @YearlyNo) AND (Investigation_Order_Main.RegNo = @RegNo) AND &#13;&#10;                      (Investigation_Order_Main.Investigation_Order_ID = @Investigation_Order_ID)">
                        <SelectParameters>
                          <asp:ControlParameter ControlID="HiddenField_Investigation_Order_ID" Name="Investigation_Order_ID"
                            PropertyName="Value" />
                          <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                          <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                        </SelectParameters>
                      </asp:SqlDataSource>
                    </ItemTemplate>
                <AlternatingItemStyle BackColor="#D7E6EE" />
                  </asp:DataList><br />
                
               
                  </div>
                  
                <div class="TabbedPanelsContent" ><asp:Panel ID="pnl_Lab_Test" runat="server" Width="100%">
                    <asp:GridView ID="GridView2pnl" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
                        DataKeyNames="TGID" DataSourceID="SqlDataSource_Grid_2" Width="100%">
                        <Columns>
                            <asp:BoundField DataField="RegNo" HeaderText="Registration No" SortExpression="RegNo"
                                Visible="False" />
                            <asp:BoundField DataField="YearlyNo" HeaderText="Visit No" SortExpression="YearlyNo" />
                            <asp:BoundField DataField="Test Booking Name" HeaderText="Test Name" SortExpression="Test Booking Name" />
                            <asp:BoundField DataField="Date_Time" HeaderText="Booking Date" SortExpression="Date_Time" />
                            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                            <asp:BoundField DataField="Dept_Name" HeaderText="Department" SortExpression="Dept_Name" />
                            <asp:HyperLinkField DataNavigateUrlFields="RegNo,YearlyNo,TGID,Main_ID,Sample_No,Status_ID"
                                DataNavigateUrlFormatString="~/Pathology/Patient_Result_Report.aspx?RegNo={0}&amp;YearlyNo={1}&amp;TGID={2}&amp;Main_ID={3}&amp;Sample_No={4}&amp;Status={5}"
                                Text="Report" />
                            <asp:TemplateField Visible="False">
                                <ItemTemplate>
                                    <asp:CheckBox ID="CheckBox1" runat="server" />
                                    <asp:HiddenField ID="HiddenFieldTCID" runat="server" Value='<%# Bind("TGID", "{0}") %>' />
                                    <asp:HiddenField ID="HiddenField1" runat="server" />
                                    <asp:HiddenField ID="HiddenFieldTID" runat="server" Value='<%# Eval("TGID", "{0}") %>' />
                                    <asp:HiddenField ID="HiddenField_Main_ID" runat="server" Value='<%# Eval("Main_ID", "{0}") %>' />
                                    &nbsp; &nbsp;
                                    <asp:HiddenField ID="HiddenField_TB_ID" runat="server" Value='<%# Eval("TB_ID", "{0}") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="YearlyNo" HeaderText="YearlyNo" SortExpression="YearlyNo"
                                Visible="False" />
                            <asp:BoundField DataField="TGID" HeaderText="TGID" InsertVisible="False" SortExpression="TGID"
                                Visible="False" />
                            <asp:BoundField DataField="Status_ID" HeaderText="Status_ID" InsertVisible="False"
                                ReadOnly="True" SortExpression="Status_ID" Visible="False" />
                            <asp:BoundField DataField="Main_ID" HeaderText="Main_ID" InsertVisible="False" SortExpression="Main_ID"
                                Visible="False" />
                        </Columns>
                        <HeaderStyle CssClass="GridHeader" />
                        <AlternatingRowStyle CssClass="GridAltItem" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource_Grid_2" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
                        InsertCommand="insert_lab_status_record" InsertCommandType="StoredProcedure"
                        ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT Path_Result_Delivery.Yearly_No AS YearlyNo, Path_Result_Delivery.Reg_no AS RegNo, Patient.PFName, Patient.PMName, Patient.PLName, Patient.Relation, ISNULL(Patient.RFName + ' ', '') + ISNULL(Patient.RMName + ' ', '') + ISNULL(Patient.RLName + ' ', '') AS PatientName, Test_Status.Status, CONVERT (varchar, Path_Result_Delivery.Sample_Collection_Date, 107) AS Date_Time, TestGroup.TGName, TestGroup.TGID, Path_Result_Delivery.Main_ID, Department.Dept_Name, Test_Booking.TB_ID, Test_Booking.TB_Name AS [Test Booking Name], Test_Booking_Services.Sample_No, Test_Status.Status_ID FROM Test_Booking INNER JOIN TestGroup ON Test_Booking.MG_ID = TestGroup.TGID INNER JOIN Test_Booking_Services INNER JOIN Test_Status ON Test_Booking_Services.Status = Test_Status.Status_ID INNER JOIN Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID INNER JOIN Payment INNER JOIN Patient ON Payment.RegNo = Patient.RegNo ON Path_Result_Delivery.Yearly_No = Payment.PayID ON Test_Booking.TB_ID = Test_Booking_Services.TB_ID LEFT OUTER JOIN Department ON Path_Result_Delivery.From_Dept_ID = Department.Dept_ID WHERE (Test_Status.Status_ID = 8) AND (Path_Result_Delivery.Reg_no = @RegNo) AND (Path_Result_Delivery.Yearly_No = @YearlyNo)">
                        <SelectParameters>
                            <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                        </SelectParameters>
                        <InsertParameters>
                            <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" Type="Int32" />
                            <asp:Parameter DefaultValue="8" Name="Status" Type="Int32" />
                            <asp:ControlParameter ControlID="HiddenField_TB_ID" Name="TB_ID" PropertyName="Value"
                                Type="Int32" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                </asp:Panel>
                  </div>   
                  
          </div>
        </div></td>
    </tr>
  </table>
  <asp:Label ID="LabelFooter" runat="server" Text=""></asp:Label>


  <script type="text/javascript">

var cookies = Spry.Utils.Cookie("read","tabbedpanels_pathologytst");
var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1", { defaultTab: cookies ? parseFloat(cookies) : 0 });
Spry.Utils.addUnLoadListener(function(){
    // save the current value
    Spry.Utils.Cookie('create','tabbedpanels_pathologytst',TabbedPanels1.getCurrentTabIndex());
});

</script> 
</asp:Content>
