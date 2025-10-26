<%@ page language="VB" autoeventwireup="false" inherits="Telemedicine_Reports_Diagosis, App_Web_k5og3yv0" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

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
<body><iframe 
      src="../tabs.aspx" name="holder" width="957" marginwidth="0" height="215" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe>
    <form id="form1" runat="server">
    <div>
        &nbsp;<CR:CrystalReportSource ID="CrystalReportSourceDiagnosis" runat="server">
            <Report FileName="D:\Projects\Telemedicine\Telemedicine Application\Telemedicine_Reports\withDiagosis.rpt">
                <Parameters>
                    <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@reg_No" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@Yearly_No" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@COD" PropertyName="Value" ReportName="Diagonosis.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@RegNo" PropertyName="Value" ReportName="Diagonosis.rpt" />
                </Parameters>
            </Report>
        </CR:CrystalReportSource>
        &nbsp; &nbsp;<asp:Button ID="ButtonDiagnosis" runat="server" Text="Diagnosis" CssClass="btnup" /><asp:Button
            ID="ButtonExamination" runat="server" Text="Physical Examination" /><asp:Button ID="ButtonHistories"
                runat="server" Text="Histories" /><asp:Button ID="ButtonMedication" runat="server"
                    Text="Medication" /><asp:Button ID="ButtonPathologyTest" runat="server" Text=" Pathology Test" /><asp:Button
                        ID="ButtonPhysicianOrder" runat="server" Text="Physician Order" /><asp:Button ID="ButtonRadiology"
                            runat="server" Text="Radiology" /><asp:Button ID="ButtonSympotoms" runat="server"
                                Text="Sympotoms" /><asp:Button ID="ButtonVital" runat="server" Text="Vital" /><asp:Button
                                    ID="ButtonXray" runat="server" Text="Xray" /><CR:CrystalReportSource ID="CrystalReportSourceExamination"
                                        runat="server">
                                        <Report FileName="D:\Projects\Telemedicine\Telemedicine Application\Telemedicine_Reports\withExamination.rpt">
                                            <Parameters>
                                                <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                                                    DefaultValue="" Name="@Yearly_No" PropertyName="Value" ReportName="" />
                                                <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                                                    DefaultValue="" Name="@reg_No" PropertyName="Value" ReportName="" />
                                                <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                                                    DefaultValue="" Name="@regno" PropertyName="Value" ReportName="Physical_examination.rpt" />
                                                <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                                                    DefaultValue="" Name="@yearlyno" PropertyName="Value" ReportName="Physical_examination.rpt" />
                                            </Parameters>
                                        </Report>
                                    </CR:CrystalReportSource>
        &nbsp;
        <CR:CrystalReportViewer ID="CrystalReportViewerReport" runat="server" AutoDataBind="True"
            EnableParameterPrompt="False" Height="1121px"
            Width="893px" />
        <CR:CrystalReportSource ID="CrystalReportSourceHistories" runat="server">
            <Report FileName="D:\Projects\Telemedicine\Telemedicine Application\Telemedicine_Reports\withHistories.rpt">
                <Parameters>
                    <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@Yearly_No" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@reg_No" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@YearlyNo" PropertyName="Value" ReportName="Group.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@RegNo" PropertyName="Value" ReportName="Group.rpt" />
                </Parameters>
            </Report>
        </CR:CrystalReportSource>
    
    </div>
        <CR:CrystalReportSource ID="CrystalReportSourceMedication" runat="server">
            <Report FileName="D:\Projects\Telemedicine\Telemedicine Application\Telemedicine_Reports\withMedication.rpt">
                <Parameters>
                    <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@Yearly_No" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@reg_No" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@Yearly_No" PropertyName="Value" ReportName="Medication.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@Registration_NO" PropertyName="Value" ReportName="Medication.rpt" />
                </Parameters>
            </Report>
        </CR:CrystalReportSource>
        <CR:CrystalReportSource ID="CrystalReportSourcePathalogyTest" runat="server">
            <Report FileName="D:\Projects\Telemedicine\Telemedicine Application\Telemedicine_Reports\withPathalogyTest.rpt">
                <Parameters>
                    <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@Yearly_No" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@reg_No" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@PayID" PropertyName="Value" ReportName="AssignTest.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@RegNo" PropertyName="Value" ReportName="AssignTest.rpt" />
                </Parameters>
            </Report>
        </CR:CrystalReportSource>
        <CR:CrystalReportSource ID="CrystalReportSourcePhysicianOrder" runat="server">
            <Report FileName="D:\Projects\Telemedicine\Telemedicine Application\Telemedicine_Reports\withPhysicianOrder.rpt">
                <Parameters>
                    <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@Yearly_No" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@reg_No" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@regno" PropertyName="Value" ReportName="Physicain_order.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@payid" PropertyName="Value" ReportName="Physicain_order.rpt" />
                </Parameters>
            </Report>
        </CR:CrystalReportSource>
        <CR:CrystalReportSource ID="CrystalReportSourceRadiology" runat="server">
            <Report FileName="D:\Projects\Telemedicine\Telemedicine Application\Telemedicine_Reports\withRadiology.rpt">
                <Parameters>
                    <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@Yearly_No" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@reg_No" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@RegNo" PropertyName="Value" ReportName="Radiology_Test.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@PayID" PropertyName="Value" ReportName="Radiology_Test.rpt" />
                </Parameters>
            </Report>
        </CR:CrystalReportSource>
        <CR:CrystalReportSource ID="CrystalReportSourceSymptoms" runat="server">
            <Report FileName="D:\Projects\Telemedicine\Telemedicine Application\Telemedicine_Reports\withSympotoms.rpt">
                <Parameters>
                    <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@Yearly_No" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@reg_No" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@YearlyNo" PropertyName="Value" ReportName="Sympotoms.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@RegNo" PropertyName="Value" ReportName="Sympotoms.rpt" />
                </Parameters>
            </Report>
        </CR:CrystalReportSource>
        <CR:CrystalReportSource ID="CrystalReportSourceVital" runat="server">
            <Report FileName="D:\Projects\Telemedicine\Telemedicine Application\Telemedicine_Reports\withVitals.rpt">
                <Parameters>
                    <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@Yearly_No" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@reg_No" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@YearlyNo" PropertyName="Value" ReportName="vital.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@RegNo" PropertyName="Value" ReportName="vital.rpt" />
                </Parameters>
            </Report>
        </CR:CrystalReportSource>
        <CR:CrystalReportSource ID="CrystalReportSourceXray" runat="server">
            <Report FileName="D:\Projects\Telemedicine\Telemedicine Application\Telemedicine_Reports\withXray.rpt">
                <Parameters>
                    <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@reg_No" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@Yearly_No" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldReg_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@regno" PropertyName="Value" ReportName="ViewXray.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldYearly_No" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@yearlyno" PropertyName="Value" ReportName="ViewXray.rpt" />
                </Parameters>
            </Report>
        </CR:CrystalReportSource>
        <asp:HiddenField ID="HiddenFieldReg_No" runat="server" />
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
        <asp:HiddenField ID="HiddenFieldYearly_No" runat="server" />
    </form>
</body>
</html>
