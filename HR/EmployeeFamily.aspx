<%@ page language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="HR_EmployeeFamily, App_Web_2qu1gl2y" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:GridView ID="grdFamilyTree" runat ="server" AutoGenerateColumns="False" 
        DataSourceID="dsFamilyTree" >
    <Columns>
        <asp:BoundField DataField="Family_No" HeaderText="Family #" 
            SortExpression="Family_No" />
        <asp:BoundField DataField="EmpName" HeaderText="Employee Name" 
            SortExpression="EmpName" />
        <asp:BoundField DataField="RelationName" HeaderText="Relation Name" 
            SortExpression="RelationName" />
        <asp:BoundField DataField="CNIC" HeaderText="CNIC" SortExpression="CNIC" />
        <asp:BoundField DataField="Gender" HeaderText="Gender" 
            SortExpression="Gender" />
        <asp:BoundField DataField="DateOfBirth" HeaderText="DateOfBirth" 
            SortExpression="DateOfBirth" />
        <asp:BoundField DataField="Religion_name" HeaderText="Religion" 
            SortExpression="Religion_name" />
        <asp:BoundField DataField="Nationality_Name" HeaderText="Nationality" 
            SortExpression="Nationality_Name" />
        <asp:BoundField DataField="JoinDate" HeaderText="JoinDate" 
            SortExpression="JoinDate" />
        <asp:BoundField DataField="Designation_Name" HeaderText="Designation" 
            SortExpression="Designation_Name" />
        <asp:BoundField DataField="Dept_Name" HeaderText="Department" 
            SortExpression="Dept_Name" />
        <asp:BoundField DataField="SubDept_Name" HeaderText="Sub Department" 
            SortExpression="SubDept_Name" />
    </Columns>
    </asp:GridView>
<asp:SqlDataSource ID="dsFamilyTree" runat ="server" 
        ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" SelectCommand="SELECT     Employee.Family_No, Employee.EFName + ' ' + Employee.ELName AS EmpName, 
                      Employee.Relation + ' ' + Employee.RFName + ' ' + Employee.RLName AS RelationName, Employee.DateOfBirth, Employee.JoinDate, Employee.CNIC, 
                      Religion.Religion_name, Designation.Designation_Name, Department.Dept_Name, SubDepartment.SubDept_Name, Gender.Gender, 
                      Nationality.Nationality_Name
FROM         Gender INNER JOIN
                      Employee INNER JOIN
                      Religion ON Employee.Religion = Religion.Religion_ID INNER JOIN
                      Designation ON Employee.DesignationID = Designation.Designation_ID ON Gender.Gender_ID = Employee.SexID INNER JOIN
                      Nationality ON Employee.Nationality = Nationality.Nationality_ID FULL OUTER JOIN
                      SubDepartment INNER JOIN
                      Department ON SubDepartment.Dept_Id = Department.Dept_ID ON Designation.Dept_Id = Department.Dept_ID
WHERE     (Employee.Family_No IN
                          (SELECT     Family_No
                            FROM          Employee AS Employee_1
                            WHERE      (EmpID = @EmpID)))" >
    <SelectParameters>
        <asp:QueryStringParameter Name="EmpID" QueryStringField="eid" />
    </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

