<%@ page title="" language="C#" masterpagefile="~/hacims_demo.master" autoeventwireup="true" inherits="HR_EmployeeContactInfo, App_Web_5t2nflla" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<table width="100%">
    <tr>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>
            <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="Button" />
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:HRConnectionString %>" 
                SelectCommand="usp_EmployeeContactInfo" SelectCommandType="StoredProcedure">
            </asp:SqlDataSource>
        </td>
        <td></td>
    </tr>
    <tr>
        <td>
            <asp:SqlDataSource ID="sdsEmployeeContactInf0" runat="server" 
                ConnectionString="<%$ ConnectionStrings:HRConnectionString %>" 
                SelectCommand="usp_EmployeeContactInfo" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        </td>
        <td></td>
    </tr>
    <tr>
        <td colspan="2">
            <asp:GridView ID="gvEmployeeContactInfo" runat="server" Width="100%" 
                DataSourceID="SqlDataSource1">
            </asp:GridView>
        </td>
       
    </tr>

</table>
</asp:Content>

