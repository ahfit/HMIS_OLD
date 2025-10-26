<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master"
    AutoEventWireup="true" CodeFile="IncomeTaxLogReport.cs" Inherits="PayRoll_IncomeTaxLogReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="scriptMangerDeduction" runat="server">
    </asp:ScriptManager>
    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span>Income Tax Log</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
           
            <tr>
                <td align="right" width="10%">
                    Subdepartment :
                </td>
                <td align="left" width="15%">
                    <asp:DropDownList ID="ddlSubDepartment" runat="server" DataTextField="SubDept_Name"
                        DataValueField="SubDept_Id" AutoPostBack="True" OnSelectedIndexChanged="ddlSubDepartment_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
            
                <td align="right" width="10%">
                    Employee :
                </td>
                <td align="left" width="15%">
                    <asp:DropDownList ID="ddlEmployee" runat="server" DataTextField="EmpName" DataValueField="EmpID">
                    </asp:DropDownList>
                </td>
            
                <td align="right" width="10%">
                   Financial Year :
                </td>
                <td align="left" width="15%">
                    <asp:DropDownList ID="ddl_year" runat="server" DataTextField="Financial_Year" DataValueField="Financial_Year_Id">
                    </asp:DropDownList>
                </td>
           
                <td align="center">
                    <asp:Button ID="btnSearch" runat="server" Text="View Report" OnClick="btnSearch_Click" />
                </td>
            </tr>
        </table>
    </div>
    <div style="margin-top: 10px; text-align: center; width: 100%;">
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
        </rsweb:ReportViewer>
    </div>
</asp:Content>
