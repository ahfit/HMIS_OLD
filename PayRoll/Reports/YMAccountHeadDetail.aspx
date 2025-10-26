<%--ehsan--%>
<%@ page title="" language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="PayRoll_Reports_YMAccountHeadDetail, App_Web_0baqw4fh" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

   <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <rsweb:ReportViewer ID="ReportViewer1" Width="98%" Height="500px" ProcessingMode="local" runat="server">
    </rsweb:ReportViewer>
    <asp:SqlDataSource ID="sqlDsSalaryReport" runat="server" 
        ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>" 
        SelectCommand="usp_GetEmployeeSalaryDetailData" 
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="Year" Type="Int32" />
            <asp:Parameter Name="Month" Type="Int32" />
            <asp:Parameter Name="E_ID" Type="Int32" />
            <asp:Parameter Name="DesignationID" Type="Int32" />
            <asp:Parameter Name="Dept_Id" Type="Int32" />
            <asp:Parameter Name="Emp_Id" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDsSalaryYearlyReport" runat="server" 
        ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>" 
        SelectCommand="usp_GetEmployeeSalaryYearlyData" 
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="Year" Type="Int32" />
            <asp:Parameter Name="E_ID" Type="Int32" />
            <asp:Parameter Name="DesignationID" Type="Int32" />
            <asp:Parameter Name="Dept_Id" Type="Int32" />
            <asp:Parameter Name="Emp_Id" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>

