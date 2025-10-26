<%@ page language="VB" autoeventwireup="false" inherits="CMOsurgical, App_Web_rbfdm1yf" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title> </title>
<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
<script src="SpryAssets/SpryCollapsiblePanel.js" type="text/javascript"></script>
<link href="SpryAssets/SpryCollapsiblePanel.css" rel="stylesheet" type="text/css" />

</head>

<body >
<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_top.gif" width="1003" height="24" /></td>
  </tr>
  <tr>
    <td width="23" height="550" valign="top" class="left_border"><img src="images1/img_border_left.gif" width="23" height="15" /></td>
    <td width="957" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
        <td height="97" colspan="2" valign="top"><iframe 
      src="tabs.aspx" name="holder" width="957" marginwidth="0" height="97" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
      </tr>
      
      <tr>
        <td width="19" height="25" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td width="929" valign="middle" class="text_lables3">Patient Search </td>
        </tr>
      <tr>
        <td height="428" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="mainframe_bg13">
          <!--DWLayoutTable-->
          <tr>
            <td width="20" rowspan="6" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td width="917" height="10" valign="top"><img src="images1/img_spacer2.gif" width="2" height="10" /></td>
                  <td width="20" rowspan="6" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
              </tr>
          <tr>
            <td height="25" style="height: 25px"><div id="CollapsiblePanel1" class="CollapsiblePanel">
      <div class="CollapsiblePanelTab" tabindex="0">&nbsp;Click here for Patient Search</div>
      <div class="CollapsiblePanelContent">
        <asp:Panel ID="Panel2" runat="server"  Width="915px"></asp:Panel></div></div></td>
                </tr>
          <tr>
            <td height="13" align="right" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
          </tr>
            <tr>
                <td align="center" height="13" valign="top">
                    <asp:Button CssClass="bt2up" ID="ButtonSearch" runat="server" Text="Search" /></td>
            </tr>
          <tr>
            <td height="19" valign="top"><span style="text-align: center">
              <asp:Label CssClass="text_lables_login" ID="Label_message" runat="server" ></asp:Label>
            </span></td>
          </tr>
          <tr>
            <td height="318" valign="top"><span style="height: 390px">
              <asp:GridView ID="GridView2" runat="server"  EmptyDataText="No data"
                    Width="100%">
                <Columns>
                <asp:HyperLinkField DataNavigateUrlFields="PayID,RegNo" DataNavigateUrlFormatString="Pt_history.aspx?PayId={0}&amp;?RegNo={1}&amp;cmo=&quot;cmo&quot;"
                            Text="View Patient" Visible="False" />
                <asp:ButtonField CommandName="Select" Text="View Patient" Visible="False" />
                </Columns>
                <RowStyle CssClass="GridItem" />
                <HeaderStyle CssClass="GridHeader" />            
                <AlternatingRowStyle CssClass="GridAltItem" />
              </asp:GridView>
              <asp:HiddenField ID="HiddenFieldpfname" runat="server" />
              <asp:HiddenField ID="HiddenFieldSubDept" runat="server" />
              <asp:SqlDataSource ID="SqlDataSourceUpdate" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" UpdateCommand="UPDATE Forward_To_Sub_Dept SET dumypointer = @Pointer WHERE (Reg_No = @RegNO) AND (yearly_no = @yearlyNo) AND (status = 0) AND (request_type_id = 1)">
                <UpdateParameters>
                  <asp:ControlParameter ControlID="HiddenFieldEMpID" Name="Pointer" PropertyName="Value" />
                  <asp:ControlParameter ControlID="HiddenFieldRegNo" Name="RegNO" PropertyName="Value" />
                  <asp:ControlParameter ControlID="HiddenFieldYearlyNo" Name="yearlyNo" PropertyName="Value" />
                </UpdateParameters>
              </asp:SqlDataSource>
              <asp:HiddenField ID="HiddenFieldYearlyNo" runat="server" />
              <asp:HiddenField ID="HiddenFieldPMName" runat="server" />
              <asp:HiddenField ID="HiddenFieldRelationFirstName" runat="server" />
              <asp:HiddenField ID="HiddenFieldRelation" runat="server" />
              <asp:HiddenField ID="HiddenFieldRMName" runat="server" />
              <asp:HiddenField ID="HiddenFieldRegNo" runat="server" />
              <asp:HiddenField ID="HiddenFieldAge" runat="server" />
              <asp:HiddenField ID="HiddenFieldEMpID" runat="server" />
              <br />
              <asp:ImageButton ID="ImageButtonhome" ImageUrl="images/image_bt_home.gif" Width="64" Height="30" runat="server" Visible="false" />            
              <asp:ImageButton ID="ImageButtonback" ImageUrl="images/image_bt_back.gif" Width="66" Height="30" runat="server" Visible="false" />            
              <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="images/image_logout_up.gif" Visible="false" />            
  </span>
              <h2>&nbsp;    </h2>            </td>
          </tr>
         </table></td>
          </tr>
    </table></td>
    <td width="33" valign="top" class="right_border" ><img src="images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_bottom.gif" width="1003" height="24" /></td>
  </tr>
  
  <tr>
    <td height="1"></td>
    <td></td>
    <td></td>
  </tr>
</table>
<script type="text/javascript" src="images1/flash_01.js"></script>
</form>
<script type="text/javascript">
<!--
var CollapsiblePanel1 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel1", {contentIsOpen:false});
//-->
</script>
</body>
</html>