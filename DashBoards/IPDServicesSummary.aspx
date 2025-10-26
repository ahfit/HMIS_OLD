<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="IPDServicesSummary.aspx.cs" Inherits="DashBoards_IPDServicesSummary" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="bxmain inner_content " style="width: 100%;">
        <h2>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <span>Get Patient Record DateWise </span></h2>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tbl_form">

                 <tr>
        <td width = "50%" align = "right">
            Select Start Date :
        </td>
        <td width = "50%" >
            <igsch:WebDateChooser ID="WebDateChooser_SDate" runat="server" 
                    Width="202px">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:WebDateChooser>

            <asp:HiddenField ID="HiddenFieldfromDate" runat="server" />

        </td> 
    </tr>
    <tr>
        <td width = "50%" align = "right">
            Select End Date : </td>
        <td width = "50%" >
             <igsch:WebDateChooser ID="WebDateChooser_EndDate" runat="server" 
                    Width="202px">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:WebDateChooser>
            <asp:HiddenField ID="HiddenFieldToDate" runat="server" />

        </td>
    </tr>

 <tr>
        <td width = "50%" align = "right">
           Reg # : </td>
        <td width = "50%" >
            <asp:TextBox runat="server" ID="txtRegno"></asp:TextBox>

        </td>
    </tr>

    
              <tr>
            <td>
                &nbsp;</td>
            <td>
                <asp:Button ID="btn_Report" runat="server" Text="Show Report" OnClick="btn_Report_Click" />
               
            </td>

        </tr>


            </table>
        </div>
     
     <div style="margin-top:30px">
             <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
    </rsweb:ReportViewer>
    </div>
   
</asp:Content>

