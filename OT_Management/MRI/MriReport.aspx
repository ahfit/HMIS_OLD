<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MriReport.aspx.vb" Inherits="MriReport" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />

<style type="text/css">
<!--
.style2 {
	font: 18px "Trebuchet MS";
	color: #CC6666;
	font-weight: bold;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 14px;
}
-->
</style>

    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
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
    <td width="957" height="312" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
        <td colspan="2" valign="top" style="height: 98px"><iframe 
      src="tabs.aspx" name="holder" width="957" marginwidth="0" height="97" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
          </tr>
      
      
      <tr>
        <td width="20" height="25" valign="top" style="height: 25px"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="937" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <!--DWLayoutTable-->
              <tr>
                <td width="937" height="25" align="left" valign="middle" class="text_lables3"></td>
              </tr>
            </table>
            </td>
          </tr>
      <tr>
        <td height="189" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="mainframe_bg15">
          <!--DWLayoutTable-->
          <tr>
            <td width="20" rowspan="2" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
            <td width="918" height="176" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <!--DWLayoutTable-->
              <tr>
                <td width="918" height="176" valign="top">  <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="True"
            EnableParameterPrompt="False" Height="1121px" ReportSourceID="CrystalReportSourceMriReport"
            Width="918px" HasGotoPageButton="False" HasToggleGroupTreeButton="False" HasCrystalLogo="False" HasDrillUpButton="False" HasPrintButton="False" HasSearchButton="False"  />
        <CR:CrystalReportSource ID="CrystalReportSourceMriReport" runat="server">
<Report FileName="PT_MRI_Report.rpt"><Parameters>
<CR:ControlParameter PropertyName="Value" ReportName="" Name="@reg_No" DefaultValue="" ConvertEmptyStringToNull="False" ControlID="HiddenFieldRegistrationNo"></CR:ControlParameter>
<CR:ControlParameter PropertyName="Value" ReportName="" Name="@Yearly_No" DefaultValue="" ConvertEmptyStringToNull="False" ControlID="HiddenFieldYearlyNo"></CR:ControlParameter>
<CR:ControlParameter PropertyName="Value" ReportName="pt_Mri_Discription" Name="@reg_No" DefaultValue="" ConvertEmptyStringToNull="False" ControlID="HiddenFieldRegistrationNo"></CR:ControlParameter>
<CR:ControlParameter PropertyName="Value" ReportName="pt_Mri_Discription" Name="@Yearly_No" DefaultValue="" ConvertEmptyStringToNull="False" ControlID="HiddenFieldYearlyNo"></CR:ControlParameter>
<CR:ControlParameter PropertyName="Value" ReportName="pt_Mri_Discription" Name="@PRadiologyID" DefaultValue="" ConvertEmptyStringToNull="False" ControlID="HiddenFieldRadiologyId"></CR:ControlParameter>
<CR:ControlParameter PropertyName="Value" ReportName="pt_Mri_Discription" Name="@Pt_test_id" DefaultValue="" ConvertEmptyStringToNull="False" ControlID="HiddenFieldTestId"></CR:ControlParameter>
</Parameters>
</Report>
</CR:CrystalReportSource>
        <asp:HiddenField ID="HiddenFieldRegistrationNo" runat="server" />
        <asp:HiddenField ID="HiddenFieldYearlyNo" runat="server" />
        <br />
        <asp:HiddenField ID="HiddenFieldTestId" runat="server" />
        <asp:HiddenField ID="HiddenFieldRadiologyId" runat="server" /></td>
                </tr>
              
              

              
              
            </table></td>
                <td width="19" rowspan="2" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
          </tr>
          <tr>
            <td height="13"></td>
          </tr>
          
          
          
          
          
         </table></td>
          </tr>
   
    </table></td>
    <td width="33" rowspan="2" valign="top" class="right_border" style="width: 33px"><img src="images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  <tr>
    <td height="0"></td>
  </tr>
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_bottom.gif" width="1003" height="24" /> </td>
  </tr>
</table>
<script type="text/javascript" src="images1/flash_01.js"></script>
</form><script type="text/javascript">
<!--
-->
</script>
</body>
</html>
