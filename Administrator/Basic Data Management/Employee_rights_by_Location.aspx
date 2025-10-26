<%@ page title="" language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="Administrator_Basic_Data_Management_Employee_rights_by_Location, App_Web_4ljwkhe5" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="style1">
        <tr>
            <td colspan="2">
                &nbsp;</td>
        </tr>
        <tr>
            <td align="right">
               Employee Name :
            </td>
            <td>
                
                <asp:DropDownList ID="DDL_EMP_ID" runat="server" DataSourceID="SDS_emp_id" 
                    AutoPostBack="True" DataTextField="EFName" DataValueField="EmpID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SDS_emp_id" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>" 
                    SelectCommand="SELECT EmpID, isnull(EFName,'')+' '+isnull(ElName,'') as EFName FROM Employee where activestatus=1 order by EFName"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="right">
                Company Name:</td>
            <td>
            <asp:DropDownList ID="DDL_FCI" runat="server" DataSourceID="SDS_FCI" 
                    DataTextField="Financial_Company_Name" 
                    DataValueField="Financial_Company_Id" AutoPostBack="True">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SDS_FCI" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:UsersConnectionString %>" 
                    
                    
                    
                    SelectCommand="SELECT [Financial_Company_Id], [Financial_Company_Name] FROM [Group_Financial_Companies] ORDER BY [Financial_Company_Name]">
                </asp:SqlDataSource>

            </td>
        </tr>
        <tr>
            <td align="right">
             Branch Name
                </td>
            <td>
                                <asp:DropDownList ID="DDL_CBI" runat="server" DataSourceID="SDS_CBI" 
                                    AutoPostBack="True" DataTextField="Company_Branch_Name" 
                                    DataValueField="Company_Branch_Id"></asp:DropDownList>
                <asp:SqlDataSource ID="SDS_CBI" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:UsersConnectionString %>" 
                    
                                    SelectCommand="SELECT Company_Branch_Id, Company_Branch_Name FROM Group_Company_Branches WHERE (Company_Branch_Id NOT IN (SELECT Company_Branch_ID FROM Employee_Rights_Company_Wise WHERE (Emp_ID = @Emp_ID)))">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DDL_EMP_ID" Name="Emp_ID" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                                </asp:SqlDataSource></td>
        </tr>
        <tr>
            <td align="center" colspan="2">
                <asp:Button ID="Btn_Save" runat="server" Text="Save" />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                &nbsp;</td>
        </tr>
        <tr>
            <td align="center" colspan="2">
                <asp:GridView ID="GridView1" runat="server" Width="100%" 
                    DataSourceID="SDS_For_Grid" AutoGenerateColumns="False" DataKeyNames="id" 
                    EnableModelValidation="True">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" />
                        <asp:BoundField DataField="Employee" HeaderText="Employee" 
                            SortExpression="Employee" />
                        <asp:BoundField DataField="Department" HeaderText="Department" 
                            SortExpression="Department" />
                        <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
                        <asp:BoundField DataField="Subdepartment" HeaderText="Subdepartment" 
                            SortExpression="Subdepartment" />
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:SqlDataSource ID="SDS_For_Grid" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:Users_ConnectionString %>" 
                    InsertCommand="INSERT INTO Employee_Rights_Company_Wise(Emp_ID, Financial_Company_ID, Company_Branch_ID, Date, Added_by, Is_approved) VALUES (@Emp_ID, @Financial_Company_ID, @Company_Branch_ID, GETDATE(), @Added_by, 1)" 
                    SelectCommand="SELECT Employee.EFName AS Employee, Group_Financial_Companies.Financial_Company_Name AS Department, Employee_Rights_Company_Wise.Date, Employee_Rights_Company_Wise.id, Group_Company_Branches.Company_Branch_Name AS Subdepartment FROM Employee_Rights_Company_Wise INNER JOIN Employee ON Employee_Rights_Company_Wise.Emp_ID = Employee.EmpID INNER JOIN Group_Company_Branches ON Employee_Rights_Company_Wise.Company_Branch_ID = Group_Company_Branches.Company_Branch_Id INNER JOIN Group_Financial_Companies ON Employee_Rights_Company_Wise.Financial_Company_ID = Group_Financial_Companies.Financial_Company_Id WHERE (Employee_Rights_Company_Wise.Is_approved = 1) " 
                    
                    UpdateCommand="UPDATE Employee_Rights_Company_Wise SET Is_approved = 0 WHERE (id = @id)" 
                    DeleteCommand="DELETE FROM Employee_Rights_Company_Wise WHERE (id = @id)">
                    <DeleteParameters>
                        <asp:Parameter Name="id" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:ControlParameter ControlID="DDL_EMP_ID" Name="Emp_ID" 
                            PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="DDL_FCI" Name="Financial_Company_ID" 
                            PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="DDL_CBI" Name="Company_Branch_ID" 
                            PropertyName="SelectedValue" />
                        <asp:SessionParameter Name="Added_by" SessionField="emp_id" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="id" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
</asp:Content>

