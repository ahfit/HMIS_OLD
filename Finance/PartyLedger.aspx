<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="false" CodeFile="PartyLedger.aspx.vb" Inherits="Finance_PartyLedgerReportNew" %>
<%@ Register assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" namespace="Infragistics.WebUI.WebSchedule" tagprefix="igsch" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <div style="width:100%;">
    <table width="500px" style="margin:auto;">
        <tr>
            <td>
                Company Branch
            </td>
            <td>
                :
            </td>
            <td>
                
                <asp:DropDownList ID="ddlCompanyBranch" runat="server" AutoPostBack="true"
                    DataSourceID="sqlDsCompanyBranch" DataTextField="Company_Branch_Name" 
                    DataValueField="Company_Branch_Id">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sqlDsCompanyBranch" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" 
                    SelectCommand=" SELECT Company_Branch_Id, Company_Branch_Name FROM Group_Company_Branches Where Company_Branch_Id in (Select Company_Branch_Id From Employee_Rights_Company_Wise where Emp_ID =@Emp_ID)  ORDER BY Company_Branch_Name">
                    <SelectParameters>
                        <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" />
                    </SelectParameters>
                </asp:SqlDataSource>
                
            </td>
        </tr>
        <tr>
            <td>
                Party
            </td>
            <td>
                :
            </td>
            <td>
                <asp:DropDownList ID="ddlParty" runat="server" DataSourceID="dsParty" 
                    DataTextField="Party_Name" DataValueField="Party_Id"></asp:DropDownList>
                <asp:SqlDataSource ID="dsParty" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>" 
                    SelectCommand="usp_GetPartiesForCompanyBranch"
                    SelectCommandType="StoredProcedure"
                    >
                <SelectParameters>
                    <asp:ControlParameter Name="BranchId" Type="Int32" ControlID="ddlCompanyBranch" PropertyName="SelectedValue" />
                </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                From Date
            </td>
            <td>
                :
            </td>
            <td>
                <igsch:WebDateChooser ID="wdcFromDate" Width="202px" 
                runat="server">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
            </td>
        </tr>
        <tr>
            <td>
                To Date
            </td>
            <td>
                :
            </td>
            <td>
                <igsch:WebDateChooser ID="wdcToDate" Width="202px" 
                runat="server">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
            </td>
        </tr>
        <tr>
                <td align="right">
                    &nbsp;
                </td>
                <td colspan="3" style="text-align:Left;padding-left:10px;">
                    <asp:RadioButtonList ID="DDLVoucher" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Selected="True" Value="2">All</asp:ListItem>
                        <asp:ListItem  Value="1">Posted</asp:ListItem>
                        <asp:ListItem  Value="0">UnPosted</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
        <tr>
            <td>
                
            </td>
            <td>
                
            </td>
            <td>
                <asp:Button ID="btnViewReport" runat="server" Text="View Report" />
            </td>
        </tr>
    </table>
    </div>

    <table width="100%">
        <tr>
            <td>
                <rsweb:ReportViewer ID="ReportViewer1" runat="server"  Width="100%">
                </rsweb:ReportViewer> 
            </td>
        </tr>
    </table>
</asp:Content>

