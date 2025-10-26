<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="PayRoll_EmployeeMonthlyInstalmentReport, App_Web_tchaehmk" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="scriptMangerDeduction" runat="server">
    </asp:ScriptManager>
    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span>Employee Monthly Installments Detail</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td align="right" width="50%">
                    Hospital :
                </td>
                <td align="left" width="50%">
                    <asp:DropDownList ID="ddlHospital" runat="server" DataTextField="Hospital_Name" DataValueField="Hospital_ID"
                        AutoPostBack="True" OnSelectedIndexChanged="ddlHospital_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" width="50%">
                    Department :
                </td>
                <td align="left" width="50%">
                    <asp:DropDownList ID="ddlDepartment" runat="server" DataTextField="Dept_Name" DataValueField="Dept_ID"
                        AutoPostBack="True" OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" width="50%">
                    Subdepartment :
                </td>
                <td align="left" width="50%">
                    <asp:DropDownList ID="ddlSubDepartment" runat="server" DataTextField="SubDept_Name"
                        DataValueField="SubDept_Id" AutoPostBack="True" OnSelectedIndexChanged="ddlSubDepartment_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" width="50%">
                    Employee :
                </td>
                <td align="left" width="50%">
                    <asp:DropDownList ID="ddlEmployee" runat="server" DataTextField="EmpName" DataValueField="EmpID">
                    </asp:DropDownList>
                </td>
            </tr>
             <tr>
                <td align="right" width="50%">
                    Type :
                </td>
                <td align="left" width="50%">
                    <asp:DropDownList ID="ddlType" runat="server">
                        <asp:ListItem Text="Advance" Value="Advance" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Arrear" Value="Arrear"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                </td>
            </tr>
        </table>
    </div>
    <div style="margin-top: 10px; text-align: center; width: 100%;">
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
        </rsweb:ReportViewer>
    </div>
</asp:Content>
