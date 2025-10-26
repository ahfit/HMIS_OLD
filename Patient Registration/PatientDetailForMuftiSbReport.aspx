<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="PatientDetailForMuftiSbReport.aspx.cs" Inherits="Patient_Registration_PatientDetailForMuftiSbReport" %>
<%@ Register assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" namespace="Infragistics.WebUI.WebSchedule" tagprefix="igsch" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
    .style1
    {
        width:100%;
        text-align:center;
    }
    .style2
    {
        width:50%;
        text-align:right;
    }
    .style3
    {
        width:50%;
        text-align:left;
    }
</style>
    <script type="text/javascript">
        
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
           <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
        </asp:ToolkitScriptManager>
           <div class="bxmain inner_content" style="width:100%;">
           <h2><span>Patient Detail For Zakat</span></h2>
                <asp:HiddenField ID="Hf_RegNo" runat="server"/>
    </div>
    <div>
     <rsweb:reportviewer id="ReportViewer1" runat="server" Width="100%">
                </rsweb:reportviewer>
    </div>
</asp:Content>
