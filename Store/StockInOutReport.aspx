<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true"
    CodeFile="StockInOutReport.aspx.cs" Inherits="Store_StockInOutReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <table width="100%">
        <tr>
            <td align="right" style="width: 40%">
                Sub Department :
            </td>
            <td>
                <asp:DropDownList runat="server" ID="ddlSubDepartment" DataSourceID="sdsSubDepartment"
                    DataTextField="SubDept_Name" DataValueField="SubDept_Id" Enabled="false">
                </asp:DropDownList>
                <asp:SqlDataSource runat="server" ID="sdsSubDepartment" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    SelectCommand="SELECT SubDept_Id, SubDept_Name FROM SubDepartment"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="right" width="50%">
                From Date :
            </td>
            <td align="left" width="50%">
                <igsch:WebDateChooser ID="wdc_StartDate" runat="server" Width="201px">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:WebDateChooser>
            </td>
        </tr>
        <tr>
            <td align="right" width="50%">
                To Date :
            </td>
            <td align="left" width="50%">
                <igsch:WebDateChooser ID="wdc_EndDate" runat="server" Width="201px">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:WebDateChooser>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Button runat="server" ID="btnSearch" Text="View Report" OnClick="btnSearch_Click" />
            </td>
        </tr>
    </table>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
    </rsweb:ReportViewer>
    <asp:SqlDataSource runat="server" ID="sdsReportData" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        SelectCommand="usp_StockInOutReport" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlSubDepartment" Name="Bysubdeptid" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:Parameter Name="startDate" Type="DateTime" />
            <asp:Parameter Name="endDate" Type="DateTime" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
