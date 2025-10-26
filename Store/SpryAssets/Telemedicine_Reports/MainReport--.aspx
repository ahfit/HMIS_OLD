<%@ page language="VB" autoeventwireup="false" inherits="Telemedicine_Reports_MainReport, App_Web_k5og3yv0" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    
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
<body>

    <form id="form1" runat="server">
    <iframe 
      src="../tabs.aspx" name="holder" width="957" marginwidth="0" height="180" marginheight="0" 
      scrolling="No" frameborder="0" id="holder" onclick="return holder_onclick()"></iframe>
    <div>
        &nbsp; &nbsp; &nbsp;
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="True"
            Height="1054px" ReportSourceID="CrystalReportSource1" Width="919px" EnableParameterPrompt="False" />
        <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
            <Report FileName="\\Server\D\Projects\Telemedicine\Telemedicine Application\Telemedicine_Reports\MainReport.rpt">
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
        &nbsp;
    
    </div>
    </form>
</body>
</html>
