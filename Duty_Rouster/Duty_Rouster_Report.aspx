<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="Duty_Rouster_Report.aspx.cs" Inherits="Duty_Rouster_Duty_Rouster_Report" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="diagnosis_list">
        <tr>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server"  ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False" 
                    SelectCommand="[sp_SearchDuties]">
                    <SelectParameters>
                        <asp:QueryStringParameter DefaultValue="" Name="stDate" 
                            QueryStringField="Sdate" Type="DateTime" />
                        <asp:QueryStringParameter Name="edDate" QueryStringField="EDate" 
                            Type="DateTime" />
                        <asp:QueryStringParameter Name="deptid" QueryStringField="Dept" Type="Int32" />
                        <asp:QueryStringParameter DefaultValue="SubDept" Name="subdeptid" 
                            Type="Int32" QueryStringField="subdept" />
                        <asp:QueryStringParameter DefaultValue="empdep" Name="empdep" 
                            Type="String" QueryStringField="empdep" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
                </rsweb:ReportViewer>
            </td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>

