<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Path_Test.aspx.vb" Inherits="Path_Test" %>

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

<style type="text/css">
body{background-image:none; margin-top:0px; }
html{background-image:none;}
*{margin:0 0 0 0;}
</style>


<script language="javascript" type="text/javascript">
function OpenNewPage()
{
var regno=document.getElementById("HiddenFieldRegNo").value;
var yearlyno=document.getElementById("HiddenFieldYearlyNo").value;
window.open("","MyWidows")
    
}
</script>
</head>

<body><form id="form1" runat = "server">

<div id="forms_items" class="forms_items">
<asp:ScriptManager ID="ScriptManager1" runat="server"> </asp:ScriptManager> <asp:Label ID="Label2" runat="server" ></asp:Label>
<asp:Label CssClass="txt_bold" ForeColor="Red" ID="Label_Message" runat="server" ></asp:Label>
                            <asp:RangeValidator ID="RangeValidator_days" runat="server" ControlToValidate="TextBox_next_Date"
                                CssClass="err" Display="Dynamic" ErrorMessage="Enter Correct Days"
                                MaximumValue="100" MinimumValue="0" Type="Integer"></asp:RangeValidator>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
<tr><td><br class="break" /> </td></tr>
  <tr>
    <td align="right" width="20%"><strong>Sample No. :&nbsp;</strong> </td>
    <td width="20%"><asp:TextBox CssClass="input_txt" ID="TextBox_Sample_number" ReadOnly="True" runat="server" Width="150px"></asp:TextBox></td>
    <td align="right" width="20%"><strong>Description :&nbsp;</strong> </td>
    <td width="20%" rowspan="3" valign="top">
    
    <asp:TextBox runat="server" TextMode="MultiLine"  ID="TextBoxDescription"   Width="150px" Style="height:73px;" />
    
    </td>
  </tr>
  <tr>
    <td align="right"><strong>Report Date :&nbsp;</strong> </td>
    <td><div style="margin-left:-70px;"><igsch:WebDateChooser ID="WebDateChooser1" runat="server" AllowNull="False" Value="" Width="152px">
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
    <td><asp:TextBox CssClass="input_txt" ID="TextBox_next_Date" runat="server" Width="50px">0</asp:TextBox>
                          <asp:DropDownList ID="DropDownList1" runat="server" Width="96px">
                            <asp:ListItem>Hours</asp:ListItem>
                            <asp:ListItem>Days</asp:ListItem>
                          </asp:DropDownList></td>
    <td align="right">&nbsp;</td>
    </tr>
  <tr>
    <td align="right"><strong>Test Type :&nbsp;</strong> </td>
    <td colspan="3"><asp:RadioButtonList ID="RadioButtonList_Type" runat="server" DataSourceID="SqlDataSource_Test_Type"
                                DataTextField="Test_Type" DataValueField="Test_Type_ID" RepeatDirection="Horizontal" RepeatLayout="Flow" 
                                Width="100%">
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
    <td>
<span style="float:left; background-image:url(../images/bg_input.jpg); display:block; height:34px; width:385px;">
<br style="line-height:4px;" />
&nbsp;&nbsp;  <asp:DropDownList ID="DropDownList2" runat="server" 
                              AutoPostBack="True" DataSourceID="ForTestGroup"
                          DataTextField="MSTG_Name" DataValueField="MS_TGID" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged"
                          Width="350px"> </asp:DropDownList>
</span>
<span style="float:right;">
<asp:Button ID="Button1" runat="server" Text="New Template" CssClass="btn2" OnClientClick="ViewReport()" />
<asp:Button ID="BTNcheckAll" runat="server" Text="Check All" CssClass="btn1"/>
<asp:Button ID="btnAdd" runat="server" Text="Save" CssClass="btn1"/>
<asp:Button ID="BtnUncheckAll" runat="server" Text="UnCheck All" CssClass="btn1"/>
<asp:Button ID="Button_Move_Next" runat="server" Text="Move Next" Visible="False" CssClass="btn1"/>
<asp:Button ID="Button6" runat="server" Text="View Report" CssClass="btn1" Visible="False" OnClientClick="ViewReport()" /></span>

</td>
  </tr>
</table>
<br class="break" />



<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="40%" style="border:#CCCCCC solid 1px; padding:5px;" valign="top"> 
   

<asp:GridView ID ="GridGorSubGroup" runat="server" AutoGenerateColumns="False" DataSourceID="ForTestSubGroup" DataKeyNames="TSGID" Width="100%" CssClass="Grid_1" OnSelectedIndexChanged="GridGorSubGroup_SelectedIndexChanged1">
                    <columns>
                    <asp:ButtonField CommandName="Select" Text="Select" Visible="False" />
                    <asp:TemplateField ShowHeader="False">
                      <itemtemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                                      Text='<%# Bind("TSGName", "{0}") %>'></asp:LinkButton>
                        <asp:HiddenField ID="HiddenField_SG_Name" runat="server" Value='<%# Bind("TSGName", "{0}") %>' />
                        <asp:HiddenField ID="HiddenField3" runat="server" Value='<%# Bind("TGName", "{0}") %>' />
                      </itemtemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="TSGName" HeaderText="Sub Group Name" SortExpression="TSGName" Visible="False" />
                    <asp:BoundField DataField="TSGID" HeaderText="TSGID" InsertVisible="False" ReadOnly="True"
                                        SortExpression="TSGID" Visible="False" />
                    <asp:TemplateField>
                      <edititemtemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" />            
                      </edititemtemplate>
                      <itemtemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" />            
                        <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("TSGID", "{0}") %>' />
                      </itemtemplate>
                    </asp:TemplateField>
                    </columns>
                    <RowStyle CssClass="GridItem" />
                    <headerstyle CssClass="GridHeader" />            
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>


</td>
    <td width="35%" valign="top" style="border:#CCCCCC solid 1px; padding:5px;">
    
<asp:Label CssClass="err" ID="labelGName" runat="server" ></asp:Label><br class="break" />

<strong>Test Name : </strong><asp:TextBox ID="TextBox_Test_NAme" runat="server" AutoPostBack="True" CssClass="input_txt" ></asp:TextBox>

<asp:CheckBoxList CellPadding="1" CellSpacing="2" CssClass="txt_normal" DataTextField="TestName"
                DataValueField="TID" ID="CheckBoxListTest" RepeatColumns="2" runat="server" Width="100%" DataSourceID="ForTest" > </asp:CheckBoxList>
                    <asp:CheckBoxList ID="CheckBoxListForTestSG" runat="server" DataSourceID="SqlDataSourcefortsetSG"
                DataTextField="TestName" DataValueField="TID" RepeatColumns="2" Width="100%" CssClass="txt_normal"> </asp:CheckBoxList>    
    
    </td>


    <td width="35%" valign="top" style="border:#CCCCCC solid 1px; padding:5px;">  <asp:TreeView ID="TreeView1" runat="server" > </asp:TreeView></td>
  </tr>
</table>
<br />
<br />

<div style="display:none">
 <asp:Label ID="LabelRelation" runat="server" CssClass="text_boxtitle" ></asp:Label>
                  <asp:Label ID="LabelRName" runat="server" CssClass="text_boxtitle" ></asp:Label>
                    <span class="tabletabs" style="height: 32px">
                  <asp:TextBox ID="TextBox_Grand_discount" runat="server" Visible="False" Width="113px">0</asp:TextBox>
                  
                  
                  
                    <asp:Label ID="Label3" runat="server" Width="211px"></asp:Label>
                    <asp:Label CssClass="text_lables3" ID="Label1" runat="server"></asp:Label>
                   
                      <asp:HiddenField ID="HiddenField_Sample_collection" runat="server" />
                      <asp:HiddenField ID="HiddenField_Report_Date" runat="server" />
                      <asp:HiddenField ID="HiddenFieldMain_ID" runat="server" />
                      <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                    ProviderName="<%$ ConnectionStrings:LGHConnectionString12.ProviderName %>" SelectCommand="Select @PFNAME = PFNAME from patient"> </asp:SqlDataSource>
                      <asp:HiddenField ID="HiddenField2" runat="server" /><asp:SqlDataSource ID="SqlDataSource_Test_Type" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                        SelectCommand="SELECT Test_Type, Test_Type_ID FROM Test_Type" ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>">
                      </asp:SqlDataSource>
                        <asp:HiddenField ID="HiddenFieldRegNo" runat="server" />
                    </span>
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
                        SelectCommand="SELECT Test.TestName, Test.TID FROM Test INNER JOIN Test_Main_Sub_Grouping ON Test.TGID = Test_Main_Sub_Grouping.TGID WHERE (Test.Active = @Active) AND (Test_Main_Sub_Grouping.MS_TGID = @TGID) AND(Test.TestName Like '%' + @TName + '%')">
                        <SelectParameters>
                          <asp:ControlParameter ControlID="DropDownList2" Name="TGID" PropertyName="SelectedValue"
                      Type="Int32" DefaultValue="%%" />
                            <asp:Parameter DefaultValue="1" Name="Active" />
                            <asp:ControlParameter ControlID="TextBox_Test_NAme" DefaultValue="%%" Name="TName"
                                PropertyName="Text" />
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



</div>

</form>
</body>
</html>