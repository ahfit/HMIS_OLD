<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="~/HR/EmployeeAppraisalRequest.aspx.vb"
     Inherits="EmployeeAppraisalRequest" EnableEventValidation="false" Theme="theme_hacims" ViewStateEncryptionMode="Never" MaintainScrollPositionOnPostback="true" %>

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
        <h2><span>Appraisal Request</span></h2>
       



    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="Grid_1" Width="100%">
        <Columns>
            <%--<asp:ButtonField  CommandName="Select" DataTextField="EmployeeName" HeaderText="Employee Name" />--%>
           <asp:BoundField DataField="EmpID" HeaderText="Employee ID" SortExpression="EmpID" />
             <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" SortExpression="EmployeeName" />
            <asp:BoundField DataField="Dept_Name" HeaderText="Department" SortExpression="Dept_Name" />
             <asp:BoundField DataField="Designation_Name" HeaderText="Designation" SortExpression="Designation_Name" />
            <asp:BoundField DataField="Financial_Year" HeaderText="Financial Year Heading" SortExpression="Financial_Year" />
            <asp:BoundField DataField="appraisalheading" HeaderText="appraisalheading" SortExpression="appraisalheading" />
            <asp:BoundField DataField="Title" HeaderText="Title " SortExpression="Title" />
             <%--  <asp:BoundField DataField="Type" HeaderText="Type " SortExpression="Type" />--%>
            <asp:BoundField DataField="EmployeeAppraisalID" HeaderText="Leave" SortExpression="EmployeeAppraisalID"  Visible="false"/>
            
            <asp:HyperLinkField DataNavigateUrlFields="EmployeeAppraisalID"  DataNavigateUrlFormatString="~/hr/AddemployeeAppraisal.aspx?EmployeeAppraisalID={0}"   Text="Action"/>
              <%--<asp:BoundField DataField="EmpID" HeaderText="EmpID" InsertVisible="False" ReadOnly="True"--%>
              <%--SortExpression="EmpID" Visible="False" />--%>
            <%--<asp:HyperLinkField DataNavigateUrlFields="Emp_Leave_Id,EMPID,SubDeptId,leaveApprovalID" DataNavigateUrlFormatString="~/Leave_Management/Employee_Leaves_Approve_Reject.aspx?Emp_Leave_Id={0}&Emp_ID={1}&SubDeptId={2}&leaveApprovalID={3}"--%>
                 <%--Text="Action" />--%>
        </Columns>
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>




    <br />


        <div style="text-align:center">
            <asp:Button ID="btnRefresh" runat="server" Text="Refresh" OnClick="btnRefresh_Click" />
        </div>


    
   






</asp:Content>
