<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/hacims_masterpage_admin.master"
    CodeFile="EmployeeDependentsDetailsReport.aspx.cs" Inherits="HR_EmployeeDependentsDetailsReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="bxmain inner_content" style="width:100%">
        <span>
            <h2>Employee Dependent Details</h2>
        </span>
        <table class="table-form">
             <tr>
                <td align="right">
                    Hospital :
                </td>
                <td align="left">
                    <asp:DropDownList runat="server" CssClass="drop_down" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" ID="DDL_Campus" DataTextField="hospital_Name" DataValueField="Hospital_Id" Width="200px">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Department :
                </td>
                <td align="left">
                    <asp:DropDownList runat="server" AutoPostBack="True" CssClass="drop_down" OnSelectedIndexChanged="DDL_Department_SelectedIndexChanged" ID="DDL_Department" DataTextField="Dept_Name" DataValueField="Dept_ID" Width="200px">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Sub Department :
                </td>
                <td align="left">
                    <asp:DropDownList runat="server" ID="DDL_SubDept" DataTextField="SubDept_Name" CssClass="drop_down" DataValueField="SubDept_Id" AutoPostBack="true" Width="200px" OnSelectedIndexChanged="DDL_SubDept_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
            </tr>
             <tr>
                <td align="right">
                    Employee :
                </td>
                <td align="left">
                    <asp:DropDownList ID="ddl_Employee" runat="server" AutoPostBack="true"
                                DataTextField="SubDept_Name" DataValueField="SubDept_Id" 
                                Width="200px" >
                            </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                <asp:Button runat="server" ID="btnSearch" OnClick="btnSearch_Click" Text="Search" CssClass="btn_hacims" />
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="SqlDataSource_religion" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
            SelectCommand="SELECT 0 AS Religion_ID,'--ALL--' AS Religion_Name UNION SELECT [Religion_ID], [Religion_name] FROM [Religion]"></asp:SqlDataSource>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="500px" >
    </rsweb:ReportViewer>
</asp:Content>
