
<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PatientTestReportMain.aspx.vb" Inherits="Administrator_Test_Administrator_PatientTestReportMain" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
 <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Lahore General Hospital</title>
<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
<script language ="javascript" type ="text/javascript" >
function getQueryVariable(variable,variable1) 
{ 
//alert(variable);
var regno;
var yearlyno;
var query = window.location.search.substring(1); 
var vars = query.split("&"); 
    for (var i=0;i<vars.length;i++) 
    { 
   var  pair = vars[i].split("="); 
        if (pair[0] == variable) 
        { 
        regno = pair[1]
//        alert(regno.length);
//            for (i = 0;i < regno.length;i++)
//            {
//            alert(regno.charAt(i));
//            }        
        } 
   } 
//   alert(variable);
     var querys = window.location.search.substring(1); 
var varss = querys.split("&"); 
    for (var i=0;i<varss.length;i++) 
    { 
     var pairs = varss[i].split("="); 
        if (pairs[0] == variable1) 
        { 
        yearlyno = pairs[1]
        } 
    } 
 window.open("testpagepathology.aspx?RegNo=" + regno + "&YearlyNo=" + yearlyno,"Mywindow","")
return false;
} 

</script>

<style type="text/css">
.tablemine{border:#0066CC solid 1px; border-collapse:collapse; }
.tablemine td{border:#0066CC solid 1px; border-collapse:collapse; }


.style1 {color: #999999}
.style2 {color:#000000; text-decoration:none; font: 11px Verdana;}
#apDiv1 {
	position:absolute;
	left:887px;
	top:285px;
	width:108px;
	height:94px;
	z-index:1;
}
</style>
</head>

<body>

<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_top.gif" width="1003" height="24" /></td>
  </tr>
  <tr>
    <td width="23" rowspan="2" valign="top" class="left_border"><img src="images1/img_border_left.gif" width="23" height="15" /></td>
    <td width="1012" height="507" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
        <td width="1012" valign="top" style="height: 97px"><iframe 
      src=../tabs.aspx" name="holder" width="957" marginwidth="0" height="114" marginheight="0" 
      scrolling="No" frameborder="0" id="holder" style="height: 96px"></iframe></td>
          </tr>
      
      
      <tr>
        <td height="0" style="height: 19px"></td>
          </tr>
      <tr>
        <td height="0" align="center" ><iframe src="PatientBasicInfo_Iframe.aspx" name="holder1" scrolling="no" frameborder="0" 
            id="holder1" class="text_lables3" width="957" height="64" ></iframe>            </td>
          </tr>
      <tr>
        <td height="0"></td>
          </tr>
      <tr>
        <td height="313" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="mainframe_bg1">
          <!--DWLayoutTable-->
          <tr>
            <td width="20" rowspan="6" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td width="972" valign="top" style="width: 909px; height: 9px;"><img src="images1/img_spacer2.gif" width="2" height="10" /></td>
                  <td width="20" rowspan="6" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                </tr>
          <tr>
            <td valign="middle" style="height: 25px"><span class="text_heading_01">Select
              Test Main Group 
              
              </span></td>
                </tr>
          
          
          
          
          
          
          
          
          
          
          <tr>
            <td height="263" valign="top">
              <asp:TextBox ID="TextBox1" runat="server" Visible="False"></asp:TextBox>
              <asp:Button ID="Button1" runat="server" Text="Search" Visible="False" />              
              <br /><div id="apDiv1"><span style="width: 100px">
                <asp:LinkButton CssClass="btn_report"
                    ID="LinkButtonReport" runat="server">View Report</asp:LinkButton>
                </span></div>
                  <strong class="text_heading_01">
                    <table>
                      <tr>
                        <td >
                          Please Select The Test Main Group&nbsp;&nbsp;&nbsp;                          
                        <asp:Label CssClass="text_lables_login" ForeColor="Red" ID="LabelMessage" runat="server" Width="410px"></asp:Label></td>
                          <td >&nbsp;</td>
                      </tr>
                    </table>
                  </strong>
              <asp:RadioButtonList AutoPostBack="True" 
                            DataTextField="TGName" DataValueField="TGID" ID="RadioButtonListTestMainGroup" runat="server" Width="908px" DataSourceID="SqlDataSourceTestGroup" RepeatColumns="3" RepeatDirection="Horizontal"> </asp:RadioButtonList>
              <br />
              <asp:Button ID="ButtonSubmit" runat="server" Text="Conduct" Width="142px" />
              <br />
              <br />
              <asp:GridView ID="GridView_TestResult" runat="server" AutoGenerateColumns="False" DataKeyNames="trmId,TID,TCID" DataSourceID="SqlDataSourceTestResults" Width="910px" cssclass="Grid"><Columns>
                <asp:BoundField DataField="TGName" SortExpression="TGName" HeaderText="Pathology Group Name" Visible="False"></asp:BoundField>
                <asp:BoundField DataField="TSGName" SortExpression="TSGName" HeaderText="Test Group Name"></asp:BoundField>
                <asp:BoundField DataField="TestName" SortExpression="TestName" HeaderText="Test Name"></asp:BoundField>
                <asp:BoundField DataField="TCValue" SortExpression="TCValue" HeaderText="Value"></asp:BoundField>
                <asp:BoundField DataField="TUnitName" SortExpression="TUnitName" HeaderText="Unit Name"></asp:BoundField>
                <asp:BoundField DataField="TGID" Visible="False" SortExpression="TGID" HeaderText="TGID"></asp:BoundField>
                <asp:BoundField ReadOnly="True" DataField="trmId" InsertVisible="False" Visible="False" SortExpression="trmId" HeaderText="trmId"></asp:BoundField>
                <asp:BoundField ReadOnly="True" DataField="TID" InsertVisible="False" Visible="False" SortExpression="TID" HeaderText="TID"></asp:BoundField>
                <asp:BoundField ReadOnly="True" DataField="TCID" InsertVisible="False" Visible="False" SortExpression="TCID" HeaderText="TCID"></asp:BoundField>
                <asp:BoundField DataField="YearlyNo" Visible="False" SortExpression="YearlyNo" HeaderText="YearlyNo"></asp:BoundField>
                <asp:BoundField DataField="RegNo" Visible="False" SortExpression="RegNo" HeaderText="RegNo"></asp:BoundField>
                <asp:BoundField DataField="DateTime" HeaderText="Assign Date" SortExpression="DateTime" />
                <asp:BoundField DataField="Date_Time" HeaderText="Test Result Date" SortExpression="Date_Time" />
                </Columns>
                
                <RowStyle CssClass="GridItem"></RowStyle>
                
                <HeaderStyle CssClass="GridHeader"></HeaderStyle>
                
                <AlternatingRowStyle CssClass="GridAltItem"></AlternatingRowStyle>
                </asp:GridView>
              <asp:SqlDataSource ID="SqlDataSourceTestResults" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                            SelectCommand="Path_Test_Results" SelectCommandType="StoredProcedure" UpdateCommand="UPDATE path_PatientTestResult SET TCValue = @TCValue WHERE (trmID = @trmID) AND (TId = @TID) AND (TCId = @TCID)" ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>">
                <UpdateParameters>
                  <asp:ControlParameter ControlID="HiddenFieldValue" Name="TCValue" PropertyName="Value" />
                  <asp:ControlParameter ControlID="HiddenFieldTRMID" Name="trmID" PropertyName="Value" />
                  <asp:ControlParameter ControlID="HiddenFieldTestID" Name="TID" PropertyName="Value" />
                  <asp:ControlParameter ControlID="HiddenFieldTestComponent" Name="TCID" PropertyName="Value" />
                  </UpdateParameters>
                <SelectParameters>
                  <asp:ControlParameter ControlID="HiddenFieldregno" DefaultValue="" Name="Reg_No"
                                    PropertyName="Value" Type="String" />
                  <asp:ControlParameter ControlID="HiddenFieldYearlyNo" DefaultValue="" Name="Yearly_No"
                                    PropertyName="Value" Type="Decimal" />
                  <asp:ControlParameter ControlID="RadioButtonListTestMainGroup" DefaultValue="" Name="TGroup"
                                    PropertyName="SelectedValue" Type="Int32" />
                  </SelectParameters>
                </asp:SqlDataSource>
              
              <br />
              
              <asp:SqlDataSource ID="SqlDataSourceTestGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                            ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="Select_NoOfTestGroup"
                            SelectCommandType="StoredProcedure">
                <SelectParameters>
                  <asp:ControlParameter ControlID="HiddenFieldYearlyNo" Name="iPayID" PropertyName="Value" Type="Int32" />
                  </SelectParameters>
                </asp:SqlDataSource>
              <asp:HiddenField ID="HiddenFieldYearlyNo" runat="server" />
              <asp:HiddenField ID="HiddenFieldRegNo" runat="server" />
              <asp:HiddenField ID="HiddenFieldValue" runat="server" />
              <asp:HiddenField ID="HiddenFieldTestComponent" runat="server" />
              <asp:HiddenField ID="HiddenFieldTRMID" runat="server" />
              <asp:HiddenField ID="HiddenFieldTestID" runat="server" />
              
              <asp:ImageButton ID="ImageButtonHome" runat="server" ImageUrl="../images/image_bt_home.gif" Visible="false" />           
              <asp:ImageButton ID="ImageButtonBack" runat="server" ImageUrl="../images/image_bt_back.gif" Visible="false" />              
              
              <asp:ImageButton ID="ImageButtonLogOut" runat="server" ImageUrl="../images/image_logout_up.gif" Visible="false" />              
              <asp:Label ID="Label1" runat="server" CssClass="text_lables" Text="mm/gh" Visible="False"></asp:Label><asp:Label ID="LabelPulse" runat="server"  Visible="False"></asp:Label><asp:Label ID="Label2" runat="server" CssClass="text_lables" Text="bpm" Visible="False"></asp:Label><asp:Label ID="LabelRR" runat="server"  Visible="False"></asp:Label><asp:Label ID="Label3" runat="server" CssClass="text_lables" Text="per min." Visible="False"></asp:Label><asp:Label ID="LabelTemp" runat="server" CssClass="text_boxtitle" Visible="False"></asp:Label><asp:Label ID="Label4" runat="server" CssClass="text_lables" Text="F" Visible="False"></asp:Label><asp:Label ID="LabelBP" runat="server" CssClass="text_boxtitle" Visible="False"></asp:Label><asp:Label ID="LabelBPLow" runat="server" CssClass="text_boxtitle" Visible="False"></asp:Label></td>
                </tr>
          <tr>
            <td height="15" style="width: 696px"></td>
                </tr>
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          </table></td>
          </tr>
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
    </table></td>
    <td width="33" rowspan="2" valign="top" class="right_border" ><img src="images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  <tr>
    <td height="0"></td>
  </tr>
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_bottom.gif" width="1003" height="24" /></td>
  </tr>
</table>
</form>
</body>
</html>