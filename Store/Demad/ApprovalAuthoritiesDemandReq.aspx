<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="ApprovalAuthoritiesDemandReq.aspx.cs" Inherits="Store_ApprovalAuthoritiesDemandReq" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%;">
        <h2><span>Approval Authorites for Demand Requisition</span></h2>
        <table width="100%">
            <tr>
                <td align="right" width="40%">Sub Department :
                </td>
                <td>
                    <asp:DropDownList ID="ddlSubDepartment" runat="server"
                        DataSourceID="SqlDataSource2" DataTextField="SubDept_Name"
                        DataValueField="SubDept_Id" AppendDataBoundItems="true">
                        <asp:ListItem Text=" --- Select --- " Value="0"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server"
                        ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                        SelectCommand="SELECT SubDept_Id,SubDept_Name
FROM SubDepartment 
ORDER BY SubDept_Name"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right">Employee (Authority) :
                </td>
                <td>
                    <asp:DropDownList ID="ddlEmployeeSubdept" runat="server" AutoPostBack="true"
                        DataSourceID="SqlDataSource2" DataTextField="SubDept_Name"
                        DataValueField="SubDept_Id" AppendDataBoundItems="true"
                        OnSelectedIndexChanged="ddlEmployeeSubdept_SelectedIndexChanged">
                        <asp:ListItem Text=" --- Select --- " Value="0"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server"
                        ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                        SelectCommand="SELECT SubDept_Id,SubDept_Name + ' ( ' + Hospital_Abb + ' ) ' SubDept_Name
FROM SubDepartment 
Inner Join Department On SubDepartment.Dept_Id = Department.Dept_ID 
Inner Join Hospital On Department.Hospital_ID = Hospital.Hospital_ID
ORDER BY SubDept_Name"></asp:SqlDataSource>
                    &nbsp;&nbsp;
                    <asp:DropDownList ID="ddlAuthority" runat="server"
                        DataSourceID="SqlDataSource1" DataTextField="Employee_Name"
                        DataValueField="EmpID">
                        <asp:ListItem Text=" --- Select --- " Value="0"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                        ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                        SelectCommand="SELECT Employee.EmpID, ISNULL(Employee.EFName, ' ') + ISNULL(Employee.ELName, ' ') + ' ( ' + Department.Dept_Name + ' -- ' + Hospital.Hospital_Abb + ' )' AS Employee_Name FROM Employee INNER JOIN Department ON Employee.DeptID = Department.Dept_ID INNER JOIN Hospital ON Department.Hospital_ID = Hospital.Hospital_ID Where Employee.SubDeptId = @SubDeptId ORDER BY Employee.EFName">
                        <SelectParameters>

                            <asp:ControlParameter ControlID="ddlEmployeeSubdept" Name="SubDeptId"
                                PropertyName="SelectedValue" />

                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right">Level
                </td>
                <td>
                    <asp:DropDownList ID="ddlAuthLevel" runat="server">
                        <asp:ListItem Text=" --- Select --- " Value="0"></asp:ListItem>
                        <asp:ListItem Text="1" Value="1"></asp:ListItem>
                        <asp:ListItem Text="2" Value="2"></asp:ListItem>
                        <asp:ListItem Text="3" Value="3"></asp:ListItem>
                        <asp:ListItem Text="4" Value="4"></asp:ListItem>
                        <asp:ListItem Text="5" Value="5"></asp:ListItem>
                        <asp:ListItem Text="6" Value="6"></asp:ListItem>
                        <asp:ListItem Text="7" Value="7"></asp:ListItem>
                        <asp:ListItem Text="8" Value="8"></asp:ListItem>
                        <asp:ListItem Text="9" Value="9"></asp:ListItem>
                        <asp:ListItem Text="10" Value="10"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">Per Demand Max Limit :
                </td>
                <td>
                    <asp:TextBox ID="txtPerDemandLimit" required runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">Per Month Max Limit :
                </td>
                <td>
                    <asp:TextBox ID="txtPerMonthLimit" required runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Button ID="btnSave" Text="Save" runat="server" OnClick="btnSave_Click" />
                </td>
            </tr>

        </table>
        <div style="text-align:center;width:100%">
        <asp:Label runat="server" Text="" Font-Bold="true" ForeColor="Red" ID="lblMsg"></asp:Label>
        </div>
    </div>
    <br />
    <asp:GridView ID="gvApprovalAuthorities" runat="server" AutoGenerateColumns="False"
        Width="100%" DataKeyNames="Approve_Authority_Id" DataSourceID="sqlDs_ApprovalAuthorities">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton ID="imgDelete" OnClientClick="return confirm('Do you want to delete this record?');" runat="server" CommandArgument='<%#Eval("Approve_Authority_Id")%>' ToolTip="Delete" OnClick="imgDelete_Click"
                        ImageUrl="~/Images/delete.png" Width="16" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Approve_Authority_Id" Visible="false"
                HeaderText="Approve_Authority_Id" InsertVisible="False" ReadOnly="True"
                SortExpression="Approve_Authority_Id" />
            <asp:BoundField DataField="SubDeptId" HeaderText="SubDeptId" Visible="false"
                SortExpression="SubDeptId" />
            <asp:BoundField DataField="EmployeeId" HeaderText="EmployeeId" Visible="false"
                SortExpression="EmployeeId" />
            <asp:BoundField DataField="Auth_Level" HeaderText="Auth. Level"
                SortExpression="Auth_Level" />
            <asp:BoundField DataField="SubDept_Name" HeaderText="Sub Department Name"
                SortExpression="SubDept_Name" />
            <asp:BoundField DataField="Employee_Name" HeaderText="Employee"
                ReadOnly="True" SortExpression="Employee_Name" />
            <asp:BoundField DataField="PerDemandMaxLimit" HeaderText="Per Demand Limit"
                SortExpression="PerDemandMaxLimit" />
            <asp:BoundField DataField="PerMonthMaxLimit" HeaderText="Per Month Limit"
                SortExpression="PerMonthMaxLimit" />
            <asp:BoundField DataField="Designation_Name" HeaderText="Designation"
                SortExpression="Designation_Name" />

        </Columns>
    </asp:GridView>

    <asp:SqlDataSource ID="sqlDs_ApprovalAuthorities" runat="server"
        ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" SelectCommand="SELECT
	Approval_Authority_For_Demand.Approve_Authority_Id,
	Approval_Authority_For_Demand.SubDeptId,
	Approval_Authority_For_Demand.EmployeeId,
	Approval_Authority_For_Demand.Auth_Level,
	SubDepartment.SubDept_Name,
	ISNULL(Employee.Prefix, '') + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.ELName, '') AS Employee_Name,
	Designation.Designation_Name,
    Approval_Authority_For_Demand.PerDemandMaxLimit,
    Approval_Authority_For_Demand.PerMonthMaxLimit
FROM Approval_Authority_For_Demand
INNER JOIN SubDepartment
	ON Approval_Authority_For_Demand.SubDeptId = SubDepartment.SubDept_Id
INNER JOIN Employee
	ON Approval_Authority_For_Demand.EmployeeId = Employee.EmpID
INNER JOIN Designation
	ON Employee.DesignationID = Designation.Designation_ID"
        DeleteCommand="Delete From Approval_Authority_For_Demand Where Approve_Authority_Id = @Approve_Authority_Id"
        UpdateCommand="usp_SaveDemandApprovalAuthority" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Approve_Authority_Id" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="ddlSubDepartment" Name="SubdeptId"
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="ddlAuthority" Name="EmployeeId"
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="ddlAuthLevel" Name="AuthLevel"
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtPerDemandLimit" Name="PerDemandMaxLimit"
                PropertyName="Text" Type="Decimal" />
            <asp:ControlParameter ControlID="txtPerMonthLimit" Name="PerMonthMaxLimit"
                PropertyName="Text" Type="Decimal" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

