<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PatientAppointmentwise.aspx.vb" Inherits="PatientAppointmentwise" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

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
                <td width="937" height="25" align="left" valign="middle" class="text_lables3">Appointmentwise Patients</td>
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
                <td width="389" align="right" valign="middle"  style="height: 43px">&nbsp;&nbsp;Appointment Start Date :&nbsp; </td>
                    <td width="529" valign="middle" style="height: 43px"> <igsch:WebDateChooser ID="WebDateChooserDate" runat="server" Editable="False">
                    </igsch:WebDateChooser>
                        &nbsp;
                    </td>
                    </tr>
                <tr>
                    <td align="right"  valign="middle" width="389">
                        Appointment End Date :&nbsp;
                    </td>
                    <td valign="middle" width="529">
                        <igsch:WebDateChooser ID="WebDateChooserEndDate" runat="server" Editable="False">
                        </igsch:WebDateChooser>
                    </td>
                </tr>
              <tr>
                <td height="7"></td>
                <td>
                 
                  <asp:Button ID="ButtonSubmit" runat="server" Text="Submit" UseSubmitBehavior="False" /></td>
                </tr>
              
              <tr>
                <td height="144" colspan="2" valign="top"> <CR:CrystalReportViewer ID="CrystalReportViewerReport" runat="server" AutoDataBind="True"
            EnableParameterPrompt="False" Height="1055px" ReportSourceID="CrystalReportSourceForReport"
            Width="918px" ToolPanelView="None" HasToggleGroupTreeButton="False" />
        <CR:CrystalReportSource ID="CrystalReportSourceForReport" runat="server">
            <Report FileName="AppointmentwiseData.rpt">
                <Parameters>
                    <CR:ControlParameter ControlID="HiddenFieldDate" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@StartDate" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldEndDate" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@EndDate" PropertyName="Value" ReportName="" />
                </Parameters>
            </Report>
        </CR:CrystalReportSource>
        <asp:HiddenField ID="HiddenFieldDate" runat="server" /><asp:HiddenField ID="HiddenFieldEndDate" runat="server" /></td>
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
