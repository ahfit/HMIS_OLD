<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="false" CodeFile="DocterNotesOrdersReport.aspx.vb" Inherits="Nursing_DocterNotesOrdersReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td valign="top" class="leftnav">
                <asp:Label ID="LabelSideMenu" runat="server"></asp:Label><asp:Panel
                    ID="Panel1" runat="server" Visible="False">
                </asp:Panel>
            </td>
            <td style="width: auto;" valign="top">

                <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="500px">
                </rsweb:ReportViewer>
                <asp:HiddenField ID="hdfReg_NO" runat="server" />
                <asp:HiddenField ID="hdfYearlyNum" runat="server" />
                <asp:SqlDataSource ID="sdsDoctorOrdersNotes" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                    SelectCommand="usp_Orders_notes_For_pt" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hdfYearlyNum" Name="Yearly_No"
                            PropertyName="Value" Type="Decimal" />
                        <asp:ControlParameter ControlID="hdfReg_NO" Name="Reg_No" PropertyName="Value"
                            Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
    
</asp:Content>

