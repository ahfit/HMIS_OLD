<%@ Page Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true"
    codefile="~/Patient Registration/AreaWisePatient.aspx.cs" Inherits="Patient_Registration_AreaWisePatient" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="bxmain">
        
        <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
               <tr>
            <td align="right"><strong>Hospital :</strong></td>
            <td>
                  <asp:DropDownList ID="ddl_Hospital" runat="server" Width="250px" OnSelectedIndexChanged="ddl_Hospital_SelectedIndexChanged" AutoPostBack="true" >
                    
                </asp:DropDownList> 
            </td>
        </tr>
            <tr>
                <td align="right" width="40%">
                    Patient Type :</td>
                <td>
                    <asp:DropDownList ID="DropDownList1" runat="server" Width="202px">
                    </asp:DropDownList>
                </td>
                <tr>
                <td align="right" width="40%">
                    From Date :
                </td>
                <td>
                    <igsch:WebDateChooser ID="WebDateChooser1" runat="server">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
                <tr>
                    <td align="right">
                        To Date :
                    </td>
                    <td>
                        <igsch:WebDateChooser ID="WebDateChooser2" runat="server">
                            <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                        </igsch:WebDateChooser>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                    </td>
                    <td>
                        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Search" />
                    </td>
                </tr>
        </table>
    </div>
    <br />
    <div class="rpt_pos">
       
    </div>
    <rsweb:ReportViewer ID="ReportViewer1" Width="100%" runat="server"></rsweb:ReportViewer>

</asp:Content>
