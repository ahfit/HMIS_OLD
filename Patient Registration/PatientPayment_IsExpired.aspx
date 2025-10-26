<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="PatientPayment_IsExpired.aspx.cs" Inherits="Patient_Registration_PatientPayment_IsExpired" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="bxmain">
        <div class="bxmain inner_content">
            <h2>Patient Payment IsExpiered</h2>
            <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                <tr>
                    <td align="right" width="40%">From Date :
                    </td>
                    <td>
                        <igsch:WebDateChooser ID="WebDateChooser1" runat="server" Width="210px">
                            <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                        </igsch:WebDateChooser>
                    </td>
                </tr>
                <tr>
                    <td align="right">To Date :
                    </td>
                    <td>
                        <igsch:WebDateChooser ID="WebDateChooser2" runat="server" Width="210px"  >
                            <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                        </igsch:WebDateChooser>
                    </td>
                </tr>
                <tr>
                <td align="right">
                    Discharge Status :
                </td>
                <td>
                     <asp:DropDownList ID="DropDownList1" runat="server" >
                             <asp:ListItem Value="Normal"  >Normal</asp:ListItem> 
                          <asp:ListItem Value="LAMA"  >LAMA</asp:ListItem> 
                          <asp:ListItem Value="DOR"  >DOR</asp:ListItem>
                         <asp:ListItem Value="Expired" Selected="True" >Expired</asp:ListItem> 

                     </asp:DropDownList>
                </td>
            </tr>
                <tr>
                    <td align="right" width="40%">Registeration No :</td>
                    <td>
                        <asp:TextBox ID="txtregisterationno" runat="server" Height="20px"></asp:TextBox>
                    </td>
                </tr>
                
                <tr>
                    <td align="right"></td>
                    <td style="padding: 10px">
                        <asp:Button ID="Button1" runat="server" Text="Report View" OnClick="Button1_Click" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server"></rsweb:ReportViewer>
    </div>
</asp:Content>

