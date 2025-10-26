<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="HR_View_Employee, App_Web_ybbpntbq" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

 
 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="tbl_form">
  <tr>
    <td width="42%" align="right"> Department :</td>
    <td width="58%"> <asp:DropDownList ID="Dropdownlistdepartment" runat="server" AutoPostBack="True"
                       DataSourceID="SqlDataSourceDepartment" DataTextField="Dept_Name"
                      DataValueField="Dept_ID" TabIndex="5" Width="250px">
                  </asp:DropDownList></td>
  </tr>
</table>

 
 <br />

 
 
  
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSourceGrid"  Width="100%">
        <Columns>
            <asp:ButtonField CommandName="Select" DataTextField="EmployeeName" HeaderText="Employee Name" />
            <asp:HyperLinkField DataNavigateUrlFields="EmpID" DataNavigateUrlFormatString="~/hr/convert.aspx?Enter_emp_ID={0}"
                DataTextField="EmployeeName" HeaderText="Employee Name" Visible="False" />
            <asp:BoundField DataField="RelationName" HeaderText="RelationName" SortExpression="RelationName" />
            <asp:BoundField DataField="CNIC" HeaderText="CNIC" SortExpression="CNIC" />
            <asp:BoundField DataField="Join Date" HeaderText="Join Date" SortExpression="Join Date" />
            <asp:BoundField DataField="EmpID" HeaderText="EmpID" InsertVisible="False" ReadOnly="True"
                SortExpression="EmpID" />
            <asp:HyperLinkField DataNavigateUrlFields="EmpID,Min_PayScale" DataNavigateUrlFormatString="ACR/Employee_ACR.aspx?EmpID={0}&amp;Min_PayScale={1}"
                HeaderText="Make ACR" Text="Make ACR" Visible="False" />
            <asp:HyperLinkField DataNavigateUrlFields="EmpID,Min_PayScale" DataNavigateUrlFormatString="ACR/Employee_ACR_View.aspx?EmpID={0}&amp;Min_PayScale={1}"
                HeaderText="View ACR" Text="View ACR" Visible="False" />
            <asp:HyperLinkField DataNavigateUrlFields="EmpID,Min_PayScale" DataNavigateUrlFormatString="ACR/ACR_view_Comparison.aspx?EmpID={0}&amp;Min_PayScale={1}"
                HeaderText="View ACR" Text="View ACR" Visible="False" />
        </Columns>
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
            
            
            <br />

    <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
        SelectCommand="SELECT Employee.Prefix + Employee.EFName + ' ' + ISNULL(Employee.EMName, ' ') + ' ' + ISNULL(Employee.ELName, ' ') AS EmployeeName, Employee.Relation + ' ' + Employee.RFName + ' ' + ISNULL(Employee.RMName, ' ') + ' ' + ISNULL(Employee.RLName, ' ') AS RelationName, Employee.CNIC, Employee.EmpID, CONVERT (varchar, Employee.JoinDate, 107) AS [Join Date], Designation.Min_PayScale FROM Employee INNER JOIN Designation ON Employee.DesignationID = Designation.Designation_ID WHERE (Employee.DeptID = @deptid) AND (Employee.Entry_Employee_ID = @emp_ID) ORDER BY Employee.EmpID DESC">
        <SelectParameters>
            <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="deptid" PropertyName="SelectedValue" />
            <asp:SessionParameter Name="emp_ID" SessionField="emp_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT [Dept_Name], [Dept_ID] FROM [Department] ORDER BY [Dept_Name]">
    </asp:SqlDataSource>
   

         </asp:Content>