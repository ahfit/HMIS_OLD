<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Store_Returnable_NonReturnable_GatePass_Report, App_Web_tnnmgguv" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" namespace="Infragistics.WebUI.WebSchedule" tagprefix="igsch" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style1 {
            height: 24px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="diagnosis_list">
        <tr>
            <td align="right"><strong>From Date :</strong></td>
            <td> 
                    <igsch:WebDateChooser Width="180px" ID="WebDateChooserToDate" runat="server">
                     <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                    </igsch:WebDateChooser>
                    
                   <asp:HiddenField ID="HiddenFieldToDate" runat="server" />
                    
                   </td>
        </tr>
        <tr>
            <td align="right"><strong>To Date :</strong></td>
            <td>
                    <igsch:WebDateChooser Width="180px" ID="WebDateChooser_Fromdate" runat="server">
                     <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                    </igsch:WebDateChooser>
                   <asp:HiddenField ID="HiddenFieldFromDate" runat="server" />
                </td>
        </tr>
        <tr>
            <td align="right" class="auto-style1">R<strong>eturnable / Non Returnable Type :</strong></td>
            <td class="auto-style1">
                <asp:DropDownList ID="DropDownList1" runat="server">
                    <asp:ListItem Selected="True" >All</asp:ListItem>
                    <asp:ListItem>Returnable</asp:ListItem>
                    <asp:ListItem>Non Returnable</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                       <asp:Button ID="Button_Report" runat="server" Text="View Report" OnClick="Button_Report_Click"/>
                   </td>
        </tr>
        <tr>
            <td colspan="2">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
            <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
            </rsweb:ReportViewer>
            </td>
        </tr>
    </table>
</asp:Content>

