<%@ Page Title="" Language="C#" MasterPageFile="~/Hacims_MasterPage_Admin_New.master" AutoEventWireup="true" CodeFile="ContractExpiryDetail.aspx.cs" Inherits="HR_ContractExpiryDetail" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <div class="bxmain inner_content" style="width: 100%">
        <h2>
            <span>Contract Expiry Details
            </span>
        </h2>
        <table>
            <tr>
               <td style="width: 74% !important; text-align: right">
                    <strong>Select Type :</strong> </td>
                <td colspan="2">
    <asp:RadioButtonList ID="RadioButtonList1" runat="server" 
        onselectedindexchanged="RadioButtonList1_SelectedIndexChanged" 
    RepeatDirection="Horizontal">
        <asp:ListItem Selected="True" Value="1">Expired Contracts</asp:ListItem>
        <asp:ListItem Value="2">Pre Expiry</asp:ListItem>
    </asp:RadioButtonList>
                      </td>
            </tr>
      </table>
        <div style="text-align: center; margin-top: .5%">
    <asp:Button ID="btnSearch" runat="server" Text="Search" 
        onclick="btnSearch_Click" />
                </div>
        </div>
    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:HRConnectionString %>" 
        SelectCommand="usp_ContractExpiryDetail" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="RadioButtonList1" Name="choice" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
    Font-Size="8pt" InteractiveDeviceInfos="(Collection)" 
    WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%">
    <LocalReport ReportPath="HR\ContractExpiryDetail.rdlc">
    </LocalReport>
</rsweb:ReportViewer>
<asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>
</asp:Content>

