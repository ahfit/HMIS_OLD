<%@ Page Language="VB" AutoEventWireup="false" CodeFile="test_booking123.aspx.vb" Inherits="Test_Booking" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>





<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:spry="http://ns.adobe.com/spry">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


<link href="../images/sheet_blue.css" rel="stylesheet" type="text/css" />
<link href="../images/sheet_form.css" rel="stylesheet" type="text/css" />


<script src="../images/highlight.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
function OpenNewPage()
{
var regno=document.getElementById("HiddenFieldRegNo").value;
var yearlyno=document.getElementById("HiddenFieldYearlyNo").value;
window.open("","MyWidows")
    
}
</script>

<style type="text/css">
body{background-image:none; margin-top:0px; }
html{background-image:none;}
.Grid_1 th {background-image:url(../images/block_title_2_large.gif); background-repeat:repeat-x; height:40px;}
*{margin:0 0 0 0;}
</style>

</head>

<body><form id="form1" runat = "server">

<div id="forms_items" class="forms_items">

<asp:ScriptManager ID="ScriptManager1" runat="server"> </asp:ScriptManager>
                  <asp:Label ID="Label2" runat="server" ></asp:Label>

<asp:Label CssClass="txt_bold" ForeColor="Red" ID="Label_Message" runat="server" ></asp:Label>
                            <asp:RangeValidator ID="RangeValidator_days" runat="server" ControlToValidate="TextBox_next_Date"
                                CssClass="text_lables_login" Display="Dynamic" ErrorMessage="Enter Correct Days"
                                MaximumValue="100" MinimumValue="0" Type="Integer"></asp:RangeValidator>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
<tr><td><br class="break" /> </td></tr>
  <tr>
    <td align="right" width="20%"><strong>Sample No. :&nbsp;</strong> </td>
    <td width="20%"><asp:TextBox CssClass="input_txt" ID="TextBox_Sample_number" ReadOnly="True" runat="server" Width="150px" TabIndex="12"></asp:TextBox></td>
    <td align="right" width="20%"><strong>Description :&nbsp;</strong> </td>
    <td width="20%" rowspan="3" valign="top">
    
    <asp:TextBox runat="server" TextMode="MultiLine"  ID="TextBoxDescription"   Width="150px" Style="height:73px;" TabIndex="19" />
    
    </td>
  </tr>
  <tr>
    <td align="right"><strong>Report Date :&nbsp;</strong> </td>
<td><div style="margin-left:-70px;"><igsch:WebDateChooser ID="WebDateChooser1" runat="server" AllowNull="False" Value="" Width="152px" TabIndex="13">
                    <CalendarLayout NextMonthImageUrl="ig_cal_blueN0.gif" PrevMonthImageUrl="ig_cal_blueP0.gif" 
                                    ShowMonthDropDown="False" ShowYearDropDown="False" TitleFormat="Month">
                      <TodayDayStyle BackgroundImage="ig_cal_blue1.gif" />
                      <FooterStyle BackgroundImage="ig_cal_blue2.gif" Font-Size="8pt" ForeColor="#505080"
                                        Height="16pt" />            
                      <SelectedDayStyle BackgroundImage="ig_cal_blue2.gif" ForeColor="White" />
                      <DayStyle BackgroundImage="ig_cal_blue3.gif" BorderColor="SteelBlue" BorderStyle="Solid"
                                        BorderWidth="1px" />
                      <NextPrevStyle BackgroundImage="ig_cal_blue1.gif" />
                      <OtherMonthDayStyle ForeColor="SlateGray" />
                      <DayHeaderStyle BackgroundImage="ig_cal_blue2.gif" Font-Bold="True" Font-Size="8pt"
                                        ForeColor="#606090" Height="1pt" />
                      <TitleStyle BackColor="#CCDDFF" BackgroundImage="ig_cal_blue1.gif" Font-Bold="True"
                                        Font-Size="10pt" ForeColor="#505080" Height="18pt" />
                      <CalendarStyle BackColor="#CCDDFF" BorderColor="SteelBlue" BorderStyle="Solid" BorderWidth="1px"
                                        Font-Bold="False" Font-Italic="False" Font-Names="Verdana" Font-Overline="False"
                                        Font-Size="9pt" Font-Strikeout="False" Font-Underline="False"> </CalendarStyle>
                    </CalendarLayout>
                  </igsch:WebDateChooser></div></td>
    <td align="right">&nbsp;</td>
    </tr>
  <tr>
    <td align="right"><strong>Collect Report After :&nbsp;</strong> </td>
<td><asp:TextBox CssClass="input_txt" ID="TextBox_next_Date" runat="server" Width="50px" TabIndex="14">0</asp:TextBox>
                          <asp:DropDownList ID="DropDownList1" runat="server" Width="96px" TabIndex="15">
                            <asp:ListItem>Hours</asp:ListItem>
                            <asp:ListItem>Days</asp:ListItem>
                          </asp:DropDownList></td>
    <td align="right">&nbsp;</td>
    </tr>
  <tr>
    <td align="right" style="height: 19px"><strong>Test Type :&nbsp;</strong> </td>
<td colspan="3" style="height: 19px"><asp:RadioButtonList ID="RadioButtonList_Type" runat="server" DataSourceID="SqlDataSource_Test_Type"
                                DataTextField="Test_Type" DataValueField="Test_Type_ID" RepeatDirection="Horizontal" RepeatLayout="Flow" 
                                Width="100%" TabIndex="16">
                                <asp:ListItem Selected="True">Routine</asp:ListItem>
                                <asp:ListItem>Start(Now)</asp:ListItem>
                                <asp:ListItem>Urgent(Today)</asp:ListItem>
                            </asp:RadioButtonList></td>
    </tr>
    <tr><td><br class="break" /> </td></tr>
</table>

<br class="break" />
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td style="height: 82px">
            <asp:Panel ID="Panel_Payment" runat="server">
                <table>
                    <tr>
                        <td>
                            Total Price :
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox_Total_Price" runat="server" BorderStyle="None" BorderWidth="0px"
                                Font-Size="Large" ReadOnly="true" TabIndex="12">0</asp:TextBox></td>
                        <td>
                            Grand Discount :
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox_Grand_discount" runat="server" AutoPostBack="True" Width="113px" TabIndex="17">23</asp:TextBox></td>
                        <td>
                            <asp:DropDownList ID="DropDownList_Discount_Type" runat="server" AutoPostBack="True" TabIndex="18">
                                <asp:ListItem>Rs.</asp:ListItem>
                                <asp:ListItem>%age</asp:ListItem>
                            </asp:DropDownList></td>
                        <td>
                            Payment :
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox_Grand_total" runat="server" BorderStyle="None" BorderWidth="0px"
                                CssClass="d-active" Font-Size="Large" ReadOnly="True" Width="113px" TabIndex="12">0</asp:TextBox></td>
                    </tr>
                </table>
            </asp:Panel>
        </td>
    </tr>
  <tr>
    <td style="height: 52px">
<span style="float:left; background-image:url(../images/bg_input.jpg); display:block; height:34px; width:385px;">
    <asp:DropDownList ID="DropDownList_Main_Group" runat="server" AutoPostBack="True"
DataSourceID="SqlDataSource_Main_Group" DataTextField="TGName" DataValueField="TGID"
Width="218px"></asp:DropDownList><br style="line-height:4px;" />
&nbsp;&nbsp;
    <asp:TextBox ID="TextBox6" runat="server" AutoPostBack="True" CssClass="input_txt"
        OnTextChanged="TextBox6_TextChanged" Width="32px"></asp:TextBox>
<asp:TextBox ID="TextBox_Test" runat="server" AutoPostBack="True" Width="160px" CssClass="input_txt" TabIndex="1" ></asp:TextBox>&nbsp;<br />
    </span><span style="float:right;"><asp:Button ID="Button1" runat="server" CssClass="btn1" OnClientClick="ViewReport()" Text="Back Page" />
<asp:Button ID="btnAdd" runat="server" Text="Print" CssClass="btn1" />
<asp:Button ID="Button_Move_Next" runat="server" Text="Move Next" Visible="False" CssClass="btn1" />
<asp:Button ID="Button6" runat="server" Text="View Report" CssClass="btn1" Visible="False" OnClientClick="ViewReport()" />
<asp:Button ID="BTNcheckAll" runat="server" Text="Check All" Height="22px"  CssClass="btn1" Visible="False" />
<asp:Button ID="BtnUncheckAll" runat="server" Text="UnCheck All" Height="22px"  CssClass="btn1" Visible="False" />
</span>

</td>
  </tr>
</table>
<br class="break" />



<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="40%" style="border:#CCCCCC solid 1px; padding:5px;"> 
   

<asp:GridView ID="GridView_Booking" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
DataKeyNames="TB_ID" DataSourceID="SqlDataSource_Booking" Width="100%">
                                <Columns>
                                    <asp:ButtonField CommandName="Select" DataTextField="TB_Name" HeaderText="Test Name " />
                                    <asp:TemplateField HeaderText="TB_Name" SortExpression="TB_Name" Visible="False">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("TB_Name") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("TB_Name") %>'></asp:Label>&nbsp;
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Group Name" SortExpression="TGName">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("TGName") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("TGName") %>'></asp:Label><br />
                                            &nbsp;
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="TB_ID" HeaderText="TB_ID" InsertVisible="False" ReadOnly="True"
                                        SortExpression="TB_ID" Visible="False" />
                                    <asp:TemplateField HeaderText="Public Price" SortExpression="Public_Price">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Public_Price") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("Public_Price") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Private Price" SortExpression="Private_Price">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Private_Price") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("Private_Price") %>'></asp:Label>
                                            <asp:HiddenField ID="HiddenField_TB_ID" runat="server" Value='<%# Bind("TB_ID", "{0}") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle CssClass="GridItem" />
                                <HeaderStyle CssClass="GridHeader2" />
                                <AlternatingRowStyle CssClass="GridAltItem" />
                            </asp:GridView>
                      
                            <asp:SqlDataSource ID="SqlDataSource_Booking" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                                InsertCommand="INsert_Test_Booking_Services" InsertCommandType="StoredProcedure"
                                ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="Select_TB_Name" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropDownList_Main_Group" Name="MG_ID" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="HiddenField_Flag" DefaultValue="" Name="Flag" PropertyName="Value"
                                        Type="Boolean" />
                                    <asp:ControlParameter ControlID="TextBox_Test" DefaultValue="%%" Name="TB_Name" PropertyName="Text"
                                        Type="String" />
                                </SelectParameters>
                                <InsertParameters>
                                    <asp:SessionParameter DefaultValue="" Name="YearlyNo" SessionField="YearlyNo" />
                                    <asp:SessionParameter DefaultValue="" Name="RegNo" SessionField="registrationNo" />
                                    <asp:ControlParameter ControlID="HiddenField_TBID" DefaultValue="" Name="TB_ID" PropertyName="Value" />
                                    <asp:Parameter DefaultValue="1" Name="Status" Type="Int32" />
                                    <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" Type="Int32" />
                                    <asp:ControlParameter ControlID="HiddenFieldMain_ID" Name="Main_ID" PropertyName="Value"
                                        Type="Int32" />
                                </InsertParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSource_Main_Group" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT TGID, TGName FROM TestGroup">
                            </asp:SqlDataSource>
                            <asp:HiddenField ID="HiddenField_TBID" runat="server" />
                            <asp:HiddenField ID="HiddenField_Flag" runat="server" /></td>
    <td width="35%" valign="top" style="border:#CCCCCC solid 1px; padding:5px;"><asp:Label ID="labelGName" CssClass="err" runat="server" ></asp:Label>
                                <asp:GridView ID="GridView_Services" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_Booking_Service"
                                    Width="100%" DataKeyNames="ID" CssClass="Grid_1">
                                    <Columns>
                                        <asp:BoundField DataField="TB_Name" HeaderText="Name" SortExpression="TB_Name" />
                                        <asp:BoundField DataField="TGName" HeaderText="Group Name" SortExpression="TGName" />
                                        <asp:CommandField DeleteText="Cancel" ShowDeleteButton="True" />
                                    </Columns>
                                    <RowStyle CssClass="GridItem" />
                                    <HeaderStyle CssClass="GridHeader" />
                                    <AlternatingRowStyle CssClass="GridAltItem" />
                                </asp:GridView>
                                <asp:SqlDataSource ID="SqlDataSource_Booking_Service" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT     Test_Booking.TB_Name, TestGroup.TGName, Test_Booking_Services.ID&#13;&#10;FROM         Test_Booking_Services INNER JOIN&#13;&#10;                      Test_Booking ON Test_Booking_Services.TB_ID = Test_Booking.TB_ID INNER JOIN&#13;&#10;                      TestGroup ON Test_Booking.MG_ID = TestGroup.TGID INNER JOIN&#13;&#10;                      Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID&#13;&#10;WHERE     (Path_Result_Delivery.Yearly_No = @YearlyNo) AND (Path_Result_Delivery.Reg_no = @RegNo)" DeleteCommand="DELETE FROM Test_Booking_Services WHERE (ID = @ID)">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                                        <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                                    </SelectParameters>
                                    <DeleteParameters>
                                        <asp:ControlParameter ControlID="GridView_Services" Name="ID" PropertyName="SelectedValue" />
                                    </DeleteParameters>
                                </asp:SqlDataSource></td>
    <td width="35%" valign="top" style="border:#CCCCCC solid 1px; padding:5px;"> <asp:TreeView ID="TreeView1" runat="server" > </asp:TreeView></td>
  </tr>
</table>
<br />
<br />

<div style="display:none">
 <asp:Label ID="LabelRelation" runat="server" CssClass="text_boxtitle" ></asp:Label>
                  <asp:Label ID="LabelRName" runat="server" CssClass="text_boxtitle" ></asp:Label>
                   <asp:TextBox ID="TextBox_Grand_discount_1" runat="server" Visible="False" Width="113px">0</asp:TextBox>


                      <asp:Label ID="Label3" runat="server" Width="211px"></asp:Label>
                    <asp:Label CssClass="text_lables3" ID="Label1" runat="server"></asp:Label>
                          <asp:DropDownList ID="DropDownList2" runat="server" 
                              AutoPostBack="True" DataSourceID="ForTestGroup"
                          DataTextField="MSTG_Name" DataValueField="MS_TGID" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged"
                          Width="240px" Visible="False"> </asp:DropDownList>

                      <asp:HiddenField ID="HiddenField_Sample_collection" runat="server" />
                      <asp:HiddenField ID="HiddenField_Report_Date" runat="server" />
                      <asp:HiddenField ID="HiddenFieldMain_ID" runat="server" />
                      <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                    ProviderName="<%$ ConnectionStrings:LGHConnectionString12.ProviderName %>" SelectCommand="Select @PFNAME = PFNAME from patient"> </asp:SqlDataSource>
                      <asp:HiddenField ID="HiddenField2" runat="server" /><asp:SqlDataSource ID="SqlDataSource_Test_Type" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                        SelectCommand="SELECT Test_Type, Test_Type_ID FROM Test_Type" ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>">
                      </asp:SqlDataSource>
                        <asp:HiddenField ID="HiddenFieldRegNo" runat="server" />

                        <asp:HiddenField ID="HiddenFieldYearlyNo" runat="server" />
                      <asp:Label ID="LabelDOB" runat="server" Width="123px" Visible="False"></asp:Label>
                      <asp:Label ID="LabelCNIC" runat="server" Width="125px" Visible="False"></asp:Label>

                      <asp:SqlDataSource ID="ForTestGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                        SelectCommand="SELECT     Test_Main_Sub_Grouping.MSTG_Name, Test_Main_Sub_Grouping.MS_TGID&#13;&#10;FROM         Test_Main_Sub_Grouping INNER JOIN&#13;&#10;                      TestGroup ON Test_Main_Sub_Grouping.TGID = TestGroup.TGID&#13;&#10;order by Test_Main_Sub_Grouping .priority asc&#13;&#10;"></asp:SqlDataSource>
                      <asp:SqlDataSource ID="ForTestSubGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                        
                        SelectCommand="SELECT isnull(TestSubGroup.TSGName,'') as TSGName, TestSubGroup.TSGID, &#13;&#10;isnull(TestGroup.TGName,'') as TGName &#13;&#10;FROM TestSubGroup INNER JOIN TestGroup ON TestSubGroup.TGID = TestGroup.TGID &#13;&#10;WHERE (TestSubGroup.MS_TGID = @TGID)&#13;&#10;order by TestSubGroup.Sort_order asc" 
                        ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>">
                        <SelectParameters>
                          <asp:ControlParameter ControlID="Dropdownlist2" Name="TGID" PropertyName="SelectedValue"
                                Type="Int32" />
                        </SelectParameters>
                      </asp:SqlDataSource>
                      <asp:SqlDataSource ID="ForTest" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                        SelectCommand="SELECT Test.TestName, Test.TID FROM Test INNER JOIN Test_Main_Sub_Grouping ON Test.TGID = Test_Main_Sub_Grouping.TGID WHERE (Test.Active = @Active) AND (Test_Main_Sub_Grouping.MS_TGID = @TGID) ">
                        <SelectParameters>
                          <asp:ControlParameter ControlID="DropDownList2" Name="TGID" PropertyName="SelectedValue"
                      Type="Int32" DefaultValue="%%" />
                            <asp:Parameter DefaultValue="1" Name="Active" />
                        </SelectParameters>
                      </asp:SqlDataSource>
                      <asp:HiddenField ID="HiddenFieldTestSubGroup" runat="server" />
                      <asp:SqlDataSource ID="SqlDataSourcefortsetSG" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                SelectCommand="SELECT [TID], [TestName] FROM [Test] WHERE ([TSGID] = @TSGID)">
                        <SelectParameters>
                          <asp:ControlParameter ControlID="HiddenField_for_test" Name="TSGID" PropertyName="Value"
                        Type="Int32" />
                        </SelectParameters>
                      </asp:SqlDataSource>
                      <asp:HiddenField ID="HiddenField_for_test" runat="server" />
    <asp:HiddenField ID="HiddenFieldTotalAmount" runat="server" />
    <asp:HiddenField ID="HiddenFieldTotalPaid" runat="server" />
    <asp:HiddenField ID="HiddenFieldTotal_Discount" runat="server" />

</div>
    <asp:SqlDataSource ID="SqlDataSourceInsertSub" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
        InsertCommand="Insert_Pathology_Test_Total_Amount" InsertCommandType="StoredProcedure"
        ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="&#13;&#10;">
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenFieldMain_ID" Name="Main_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldTotal_Discount" Name="TOtal_Discount"
                PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldTotalPaid" Name="Total_Paid" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldTotalAmount" Name="Total_AMount" PropertyName="Value" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
        Visible="False" Width="100%">
        <Columns>
            <asp:BoundField DataField="Reg_no" HeaderText="Registration No." SortExpression="Reg_no" />
            <asp:BoundField DataField="Yearly_No" HeaderText="Yearly No." SortExpression="Yearly_No" />
            <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
            <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time" />
            <asp:BoundField DataField="TGName" HeaderText="Test Group Name" SortExpression="TGName" />
            <asp:BoundField DataField="TB_Name" HeaderText="Test Name" SortExpression="TB_Name" />
            <asp:BoundField DataField="Fee" HeaderText="Fee" SortExpression="Fee" />
        </Columns>
        <RowStyle CssClass="GridItem" />
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>

</form>
</body>
</html>