<%@ page title="" language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="Administrator_ViewPassword, App_Web_lwhdjlgh" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="diagnosis_list">
        <tr>
            <td align="right">
                <strong>Department :</strong></td>
            <td>
                            <asp:DropDownList ID="ddlDepartment" runat="server" DataSourceID="SqlDataSourceDept"
                                DataTextField="Dept_Name" DataValueField="Dept_ID" 
                    AutoPostBack="True">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSourceDept" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                                
                    SelectCommand="

                                    SELECT Dept_ID, Dept_Name FROM Department  order by Dept_Name "></asp:SqlDataSource>
                        </td>
        </tr>
        <tr>
            <td align="right">
                <strong>SubDepartment :</strong></td>
            <td>
                            <asp:DropDownList ID="ddlSubDepartment" runat="server" DataSourceID="SqlDataSourceSubDept"
                                DataTextField="SubDept_Name" DataValueField="SubDept_Id" 
                                AutoPostBack="True">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSourceSubDept" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                                SelectCommand="SELECT SubDept_Id, SubDept_Name FROM dbo.SubDepartment 
                                    WHERE Dept_Id = @deptid ORDER BY SubDept_Name">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="ddlDepartment" Name="deptid" 
                                        PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            </td>
        </tr>
        <tr>
            <td align="right">
                <strong>Employee :</strong></td>
            <td>
                            <asp:DropDownList ID="ddlEmployee" runat="server" DataSourceID="SqlDataSourceEmployee"
                                DataTextField="Name" DataValueField="EmpID" AutoPostBack="True">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSourceEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                                
                                SelectCommand="
select Employee.EmpID,
Employee.Prefix + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') 
                      + ' ' + ISNULL(Employee.ELName, '') AS Name
                      FROM         Employee
                      WHERE     (DeptID = @DeptID) AND ActiveStatus=1 AND (SubDeptId = @SubDeptId)and EmpID in (Select EmpID from User_management.dbo.Login)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="ddlDepartment" Name="DeptID" 
                                        PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="ddlSubDepartment" Name="SubDeptId" 
                                        PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                            <asp:Button ID="Button1" runat="server" Text="Search" />
                            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="SqlForGrid">
                    <Columns>
                        <asp:CommandField ShowEditButton="True" />
                    <asp:TemplateField HeaderText="Sr No."> 
<ItemTemplate> <%#Container.DataItemIndex+1%> 
</ItemTemplate>
<ItemStyle Width="8%" /> 
</asp:TemplateField>
                        <asp:BoundField DataField="EmpID" HeaderText="EmpID" SortExpression="EmpID" />
                        <asp:BoundField DataField="UserName" HeaderText="User Name" 
                            SortExpression="UserName" />
                        <asp:BoundField DataField="Password" HeaderText="Password" 
                            SortExpression="Password" />
                        <asp:BoundField DataField="Remarks" HeaderText="Remarks" 
                            SortExpression="Remarks" />
                       
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlForGrid" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:UsersConnectionString %>" 
                    
                    SelectCommand="SELECT     Login.EmpID, Login.UserName, Login.Password, Login.Remarks, Employee.DeptID, Employee.SubDeptId
FROM         Login INNER JOIN
                      Employee ON Login.EmpID = Employee.EmpID
WHERE     (Employee.DeptID = @DeptID) AND (Employee.SubDeptId = @SubDeptId) AND (Login.EmpID = @EmpID)" UpdateCommand="UPDATE    Login
SET              UserName = @UserName, Password = @Password
WHERE     (EmpID = @EmpID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlDepartment" Name="DeptID" 
                            PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="ddlSubDepartment" Name="SubDeptId" 
                            PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="ddlEmployee" Name="EmpID" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="UserName" />
                        <asp:Parameter Name="Password" />
                        <asp:ControlParameter ControlID="ddlEmployee" Name="EmpID" 
                            PropertyName="SelectedValue" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
</asp:Content>

