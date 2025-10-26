<%@ page language="VB" autoeventwireup="false" inherits="Telemedicine_Reports_MainReport, App_Web_aflja2q4" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="Paragma" content="no-cache"/>

<link href="../images1/st_sheet_01.css" rel="stylesheet" type="text/css" />

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
<script language="javascript" type="text/javascript">
// <!CDATA[

function holder_onclick() {

}

// ]]>
</script>




</head>

<body onload="MM_preloadImages('../images1/img_btn_over.gif')" dir="ltr">
<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="../images1/img_border_top.gif" alt="" width="1003" height="24" /></td>
  </tr>
  
  
  <tr>
    <td width="23" height="478" valign="top" class="left_border"><img src="../images1/img_border_left.gif" alt="" width="23" height="15" /></td>
    <td width="957" valign="top">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <!--DWLayoutTable-->
        <tr>
          <td height="157" colspan="2" valign="bottom" bgcolor="#F4F4F4" ><iframe 
      src="../tabs.aspx" name="holder" width="957" marginwidth="0" height="215" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
        </tr>
        
        
        <tr>
          <td width="19" height="25" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="938" valign="middle" class="text_lables3" ><!--DWLayoutEmptyCell-->&nbsp;</td>
          </tr>
        <tr><td height="296" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
          <!--DWLayoutTable-->
          <tr>
            <td width="957" height="296" valign="top">        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="True"
            Height="1054px" ReportSourceID="CrystalReportSource1" Width="919px" EnableParameterPrompt="False" />
        <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
            <Report FileName="D:\Projects\Telemedicine\Telemedicine Application\Telemedicine_Reports\MainReport.rpt">
                <Parameters>
                    <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@reg_No" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@Yearly_No" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@RegNo" PropertyName="Value" ReportName="AssignTest.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@PayID" PropertyName="Value" ReportName="AssignTest.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@YearlyNo" PropertyName="Value" ReportName="Group.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@Registration_NO" PropertyName="Value" ReportName="Medication.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@Yearly_No" PropertyName="Value" ReportName="Medication.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@RegNo" PropertyName="Value" ReportName="Physicain_order.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@PayID" PropertyName="Value" ReportName="Physicain_order.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@RegNo" PropertyName="Value" ReportName="Physical_examination.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@YearlyNo" PropertyName="Value" ReportName="Physical_examination.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@RegNo" PropertyName="Value" ReportName="Radiology_Test.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@PayID" PropertyName="Value" ReportName="Radiology_Test.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@RegNo" PropertyName="Value" ReportName="Sympotoms.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@YearlyNo" PropertyName="Value" ReportName="Sympotoms.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@RegNo" PropertyName="Value" ReportName="ViewXray.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@YearlyNo" PropertyName="Value" ReportName="ViewXray.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@RegNo" PropertyName="Value" ReportName="vital.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@YearlyNo" PropertyName="Value" ReportName="vital.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@RegNo" PropertyName="Value" ReportName="Group.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@RegNo" PropertyName="Value" ReportName="Diagonosis.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@COD" PropertyName="Value" ReportName="Diagonosis.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@reg_No" PropertyName="Value" ReportName="Patinet_Discharge.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@Yearly_No" PropertyName="Value" ReportName="Patinet_Discharge.rpt" />
                </Parameters>
            </Report>
        </CR:CrystalReportSource>
        <asp:HiddenField ID="HiddenFieldReg_No" runat="server" />
        <asp:HiddenField ID="HiddenFieldYearly_No" runat="server" />
&nbsp;</td>
              </tr>
        </table>
          
          </table></td>
    <td width="33" valign="top" class="right_border" style="width: 33px"><img src="../images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  <tr>
    <td height="24" colspan="3" valign="top"><img src="../images1/img_border_bottom.gif" alt="" width="1003" height="24" /></td>
  </tr>
</table>



</form>
     
          
       
      
      
      
      
      
      
      
      
      
      
      
      
      
   
    
</body>
</html>