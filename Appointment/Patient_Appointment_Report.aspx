<%@ page language="VB" autoeventwireup="false" inherits="Patient_Registration_Patient_Appointment_Report, App_Web_xjzmobwq" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >


    <form id="form1" runat="server">
    <div>
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true"  Width="100%" ToolbarImagesFolderUrl="~/aspnet_client/system_web/2_0_50727/CrystalReportWebFormViewer4/images/toolbar/calendar.gif" />
    
    </div>
    </form>

</html>
