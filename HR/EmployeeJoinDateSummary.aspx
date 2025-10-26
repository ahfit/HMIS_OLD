<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="HR_EmployeeJoinDateSummary, App_Web_5t2nflla" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div id="big_wrapper" style="width: 100%" class="bxmain inner_content">
        <h2>
            <span>Employees Service Wise List</span></h2>
        <table width="100%" class="tbl_form">
            <tr>
                <td style="width: 40%; text-align: right;">
                    <asp:Label ID="Label4" runat="server" Text="Department :"></asp:Label>
                </td>
                <td style="width: 50%; text-align: left;">
                    <asp:DropDownList ID="ddlDept" runat="server" AutoPostBack="true" 
                        OnSelectedIndexChanged="ddlDept_SelectedIndexChanged">
                    </asp:DropDownList>

                </td>
            </tr>

            <tr>
                <td style="width: 40%; text-align: right;">
                    <asp:Label ID="Label7" runat="server" Text="Sub Department:"></asp:Label>
                </td>
                <td style="width: 50%; text-align: left;">
                    <asp:DropDownList ID="ddlSubDept" runat="server"></asp:DropDownList>
                </td>
            </tr>

            <tr>
                <td style="text-align: center; padding-top: 7px;" colspan="2">&nbsp;</td>
            </tr>
        </table>
        <div style="text-align: center;">
            <asp:Button ID="btn_Search" runat="server" Text="View Report"
                OnClick="btn_Search_Click" />
        </div>
    </div>


    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%"
        Height="500px">
    </rsweb:ReportViewer>



</asp:Content>

