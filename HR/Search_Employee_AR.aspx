<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="~/HR/Search_Employee_AR.vb"
     Inherits="Search_Employee_AR" EnableEventValidation="false" Theme="theme_hacims" ViewStateEncryptionMode="Never" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">




    <asp:HiddenField ID="HiddenFieldPage_Name" runat="server" />
    <asp:HiddenField ID="HiddenFieldPage" runat="server" />


    <asp:Label ID="LabelDoctorName" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="Label_SubDepartment" runat="server" Visible="false" Text="Label_SubDepartment"></asp:Label><asp:Label ID="LabelDate" Visible="false" runat="server"></asp:Label>



    <asp:Panel ID="Panel6" runat="server"></asp:Panel>
    <div class="bxmain inner_content " style="width: 100%">
        <h2><span>Leave Request</span></h2>
       



    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="Grid_1" Width="100%" DataKeyNames="EmpID">
        <Columns>
            <%--<asp:ButtonField  CommandName="Select" DataTextField="EmployeeName" HeaderText="Employee Name" />--%>
            <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" SortExpression="EmployeeName" />
            <asp:BoundField DataField="SubDept_Name" HeaderText="Department" SortExpression="SubDept_Name" />
             <asp:BoundField DataField="Designation_Name" HeaderText="Designation" SortExpression="Designation_Name" />
            <asp:BoundField DataField="CNIC" HeaderText="CNIC" SortExpression="CNIC" />
            <asp:BoundField DataField="Join Date" HeaderText="Join Date" SortExpression="Join Date" />
            <asp:BoundField DataField="Leave_Name" HeaderText="Leave Name" SortExpression="Leave_Name" />
            <asp:BoundField DataField="Leave" HeaderText="Leave" SortExpression="Leave" />
            <asp:BoundField DataField="EmpID" HeaderText="EmpID" InsertVisible="False" ReadOnly="True"
                SortExpression="EmpID" Visible="False" />
            <asp:HyperLinkField DataNavigateUrlFields="Emp_Leave_Id,EMPID,SubDeptId,leaveApprovalID" DataNavigateUrlFormatString="~/Leave_Management/Employee_Leaves_Approve_Reject.aspx?Emp_Leave_Id={0}&Emp_ID={1}&SubDeptId={2}&leaveApprovalID={3}"
                 Text="Action" />
        </Columns>
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>




    <br />


        <div style="text-align:center">
            <asp:Button ID="btnRefresh" runat="server" Text="Refresh" OnClick="btnRefresh_Click" />
        </div>


    <asp:HiddenField ID="HiddenField_CNIC" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_desg" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT [Designation_ID], [Designation_Name] FROM [Designation]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>" ProviderName="<%$ ConnectionStrings:Leave_ManagementConnectionString.ProviderName %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="select SubDept_Id,SubDept_Name from SubDepartment where SubDept_Id=@SubDept_Id">

        <SelectParameters>
            <asp:SessionParameter Name="SubDept_Id" SessionField="SubDeptID" DefaultValue="0" Type="Int32" />
        </SelectParameters>


    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceGender" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT 0 AS Gender_ID, '' AS Gender UNION SELECT Gender_ID, Gender FROM Gender"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_religion" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
        SelectCommand="SELECT 0 AS Religion_ID, '' AS Religion_name UNION SELECT Religion_ID, Religion_name FROM Religion"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_place_of_birth" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
        SelectCommand="SELECT 0 AS DistrictCode, '' AS DistrictName UNION SELECT DistrictCode, DistrictName FROM DISTRICT ORDER BY DistrictName"></asp:SqlDataSource>






</asp:Content>
