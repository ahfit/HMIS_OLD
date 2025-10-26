<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master"
    AutoEventWireup="true" CodeFile="ApprovalAuthorities.aspx.cs" Inherits="Store_ApprovalAuthorities" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   <div class="row">
        <div class="col-md-12 col-sm-12">
            <div class="portlet">
                <div class="portlet-title">
                    <div class="caption">
                        Approval Authorites
                    </div>
                    <div class="tools">
                        <a href="#" class="collapse"></a><a href="#" class="remove"></a>
                    </div>
                </div>
                <div class="portlet-body">
                    <div class="form-horizontal">
                        <div class="col-md-6 col-sm-12">
                            <div class="form-group">
                                <label class="col-md-4 control-label">
                                    Sub Department:</label>
                                <div class="col-md-8">
                                    <asp:DropDownList ID="ddlSubDepartment" runat="server" CssClass="form-control" DataSourceID="SqlDataSource2"
                                        DataTextField="SubDept_Name" DataValueField="SubDept_Id" AppendDataBoundItems="true">
                                        <asp:ListItem Text=" --- Select --- " Value="0">
                                        </asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                                        SelectCommand="SELECT SubDept_Id,SubDept_Name
FROM SubDepartment 
ORDER BY SubDept_Name"></asp:SqlDataSource>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-12">
                            <div class="form-group">
                                <label class="col-md-4 control-label">
                                    Employee (Authority):</label>
                                <div class="col-md-8 form-contol-left">
                                    <asp:DropDownList ID="ddlEmployeeSubdept" runat="server" AutoPostBack="true" CssClass="form-control input-small"
                                        DataSourceID="SqlDataSource2" DataTextField="SubDept_Name" DataValueField="SubDept_Id"
                                        AppendDataBoundItems="true" onselectedindexchanged="ddlEmployeeSubdept_SelectedIndexChanged">
                                        <asp:ListItem Text=" --- Select --- " Value="0">
                                        </asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                                        SelectCommand="SELECT SubDept_Id,SubDept_Name + ' ( ' + Hospital_Abb + ' ) ' SubDept_Name
FROM SubDepartment 
Inner Join Department On SubDepartment.Dept_Id = Department.Dept_ID 
Inner Join Hospital On Department.Hospital_ID = Hospital.Hospital_ID
ORDER BY SubDept_Name"></asp:SqlDataSource>
                                    <asp:DropDownList ID="ddlAuthority" runat="server" DataSourceID="SqlDataSource1" CssClass="form-control input-medium"
                                        DataTextField="Employee_Name" DataValueField="EmpID">
                                        <asp:ListItem Text=" --- Select --- " Value="0">
                                        </asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                                        SelectCommand="SELECT Employee.EmpID, ISNULL(Employee.Prefix, '') + ' ' + ISNULL(Employee.EFName, ' ') + ISNULL(Employee.ELName, ' ') + ' ( ' + Department.Dept_Name + ' -- ' + Hospital.Hospital_Abb + ' )' AS Employee_Name FROM Employee INNER JOIN Department ON Employee.DeptID = Department.Dept_ID INNER JOIN Hospital ON Department.Hospital_ID = Hospital.Hospital_ID Where Employee.SubDeptId = @SubDeptId ORDER BY Employee.EFName">
                                        <selectparameters>
                        
                        <asp:ControlParameter ControlID="ddlEmployeeSubdept" Name="SubDeptId" 
                            PropertyName="SelectedValue" />
                        
                    </selectparameters>
                                    </asp:SqlDataSource>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-12">
                            <div class="form-group">
                                <label class="col-md-4 control-label">
                                    Level:</label>
                                <div class="col-md-8">
                                    <asp:DropDownList ID="ddlAuthLevel" runat="server" CssClass="form-control">
                                        <asp:ListItem Text=" --- Select --- " Value="0">
                                        </asp:ListItem>
                                        <asp:ListItem Text="1" Value="1">
                                        </asp:ListItem>
                                        <asp:ListItem Text="2" Value="2">
                                        </asp:ListItem>
                                        <asp:ListItem Text="3" Value="3">
                                        </asp:ListItem>
                                        <asp:ListItem Text="4" Value="4">
                                        </asp:ListItem>
                                        <asp:ListItem Text="5" Value="5">
                                        </asp:ListItem>
                                        <asp:ListItem Text="6" Value="6">
                                        </asp:ListItem>
                                        <asp:ListItem Text="7" Value="7">
                                        </asp:ListItem>
                                        <asp:ListItem Text="8" Value="8">
                                        </asp:ListItem>
                                        <asp:ListItem Text="9" Value="9">
                                        </asp:ListItem>
                                        <asp:ListItem Text="10" Value="10">
                                        </asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="dt-sc-hr_small">
                        </div>
                        <div class="col-lg-offset-6">
                            <asp:Button id="btnSave" Text="Save" runat="server" onclick="btnSave_Click" CssClass="btn btn-success" />
                        </div>
                        <div class="dt-sc-hr_small">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:GridView ID="gvApprovalAuthorities" runat="server" AutoGenerateColumns="False"
        Width="100%" DataKeyNames="Approve_Authority_Id" DataSourceID="sqlDs_ApprovalAuthorities">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton ID="imgDelete" OnClientClick="return confirm('Do you want to delete this record?');"
                        runat="server" CommandArgument='<%#Eval("Approve_Authority_Id")%>' ToolTip="Delete"
                        OnClick="imgDelete_Click" ImageUrl="~/Images/delete.png" Width="16" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Approve_Authority_Id" Visible="false" HeaderText="Approve_Authority_Id"
                InsertVisible="False" ReadOnly="True" SortExpression="Approve_Authority_Id" />
            <asp:BoundField DataField="SubDeptId" HeaderText="SubDeptId" Visible="false" SortExpression="SubDeptId" />
            <asp:BoundField DataField="EmployeeId" HeaderText="EmployeeId" Visible="false" SortExpression="EmployeeId" />
            <asp:BoundField DataField="Auth_Level" HeaderText="Auth. Level" SortExpression="Auth_Level" />
            <asp:BoundField DataField="SubDept_Name" HeaderText="Sub Department Name" SortExpression="SubDept_Name" />
            <asp:BoundField DataField="Employee_Name" HeaderText="Employee" ReadOnly="True" SortExpression="Employee_Name" />
            <asp:BoundField DataField="Designation_Name" HeaderText="Designation" SortExpression="Designation_Name" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sqlDs_ApprovalAuthorities" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        SelectCommand="SELECT     Approval_Authority.Approve_Authority_Id, Approval_Authority.SubDeptId, Approval_Authority.EmployeeId, Approval_Authority.Auth_Level, 
                        SubDepartment.SubDept_Name, ISNULL(Employee.Prefix, '') + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.ELName, '') AS Employee_Name, 
                        Designation.Designation_Name
                        FROM         Approval_Authority INNER JOIN
                        SubDepartment ON Approval_Authority.SubDeptId = SubDepartment.SubDept_Id INNER JOIN
                        Employee ON Approval_Authority.EmployeeId = Employee.EmpID INNER JOIN
                        Designation ON Employee.DesignationID = Designation.Designation_ID" DeleteCommand="Delete From Approval_Authority Where Approve_Authority_Id = @Approve_Authority_Id"
        UpdateCommand="usp_SaveApprovalAuthority" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Approve_Authority_Id" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="ddlSubDepartment" Name="SubdeptId" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="ddlAuthority" Name="EmployeeId" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="ddlAuthLevel" Name="AuthLevel" PropertyName="SelectedValue"
                Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
