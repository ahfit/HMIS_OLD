<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="~/Patient Billing/ApprovalAuthoritiesForClearance.cs" Inherits="ApprovalAuthoritiesForClearance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="bxmain inner_content" style="width:100%;">
<h2><span>Approval Authorities for Clearance</span></h2>
<table width="100%">
    <tr style="visibility:hidden">
        <td align="right" width="40%">
            Department :
        </td>
        <td >
            <asp:DropDownList ID="ddlSubDepartment" runat="server" 
                DataSourceID="SqlDataSource2" DataTextField="SubDept_Name" 
                DataValueField="SubDept_Id" AppendDataBoundItems="true">
                <asp:ListItem Text=" --- Select --- " Value="0"></asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>" 
                SelectCommand="select SubDepartment.SubDept_Name,SubDepartment.SubDept_Id 
	FROM SubDepartment 
	JOIN Department ON Department.Dept_ID=SubDepartment.Dept_Id
	WHERE -- SubDepartment.SubDept_Type = 1  AND 
                Department.Hospital_ID=@HospitalId

	ORDER BY SubDept_Name ">
                <SelectParameters >
                     <asp:SessionParameter  SessionField="HospitalId" Name="HospitalId"  />
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td align="right">
            Employee (Authority) :
        </td>
        <td>
            <asp:DropDownList ID="ddlEmployeeSubdept" runat="server" AutoPostBack="false" 
                DataSourceID="SqlDataSource2" DataTextField="SubDept_Name" 
                DataValueField="SubDept_Id" AppendDataBoundItems="true" 
                onselectedindexchanged="ddlEmployeeSubdept_SelectedIndexChanged">
                <asp:ListItem Text=" --- Select --- " Value="0"></asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>" 
                SelectCommand="SELECT SubDept_Id,SubDept_Name + ' ( ' + Hospital_Abb + ' ) ' SubDept_Name
FROM SubDepartment 
Inner Join Department On SubDepartment.Dept_Id = Department.Dept_ID 
Inner Join Hospital On Department.Hospital_ID = Hospital.Hospital_ID
ORDER BY SubDept_Name"></asp:SqlDataSource> 
<%--<asp:DropDownList ID="ddlAuthority" runat="server" 
                DataSourceID="SqlDataSource1" DataTextField="Employee_Name" 
                DataValueField="EmpID">
                <asp:ListItem Text=" --- Select --- " Value="0"></asp:ListItem>
            </asp:DropDownList> --%>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:StoreConnectionString %>" 
                SelectCommand="SELECT Employee.EmpID, Name + ' ( ' + Designation.Designation_Name + ' )' AS Employee_Name FROM Employee INNER JOIN Designation ON Employee.DesignationID = Designation.Designation_ID  Where Employee.SubDeptId = @SubDeptId ORDER BY Employee.EFName">
                    <SelectParameters>
                        
                        <asp:ControlParameter ControlID="ddlEmployeeSubdept" Name="SubDeptId" 
                            PropertyName="SelectedValue" />
                        
                    </SelectParameters>
                </asp:SqlDataSource>   
        </td>
        </tr>
   <%-- <tr>
        <td align="right">
            Authority Level :</td>
        <td>
            <asp:DropDownList ID="DDL_AuthorityLevel" runat="server" Width="100px">
                <asp:ListItem>1</asp:ListItem>
                <asp:ListItem>2</asp:ListItem>
                <asp:ListItem>3</asp:ListItem>
                <asp:ListItem>4</asp:ListItem>
                <asp:ListItem>5</asp:ListItem>
            </asp:DropDownList>
        </td>
        </tr>--%>
    <tr>
        <td align="right"> Remarks: </td>
        <td>
            <asp:TextBox ID="txtRemarks" runat="server" height="60px" Width="420px" TextMode="MultiLine" ></asp:TextBox>
        </td>
    </tr>
    <tr>
   
        <td>
        
        </td>
        <td>
            <asp:Button id="btnSave" Text="Save" runat="server" onclick="btnSave_Click" />       
        </td>
    </tr>
  
</table>
</div>
<br />
<asp:GridView ID="gvApprovalAuthorities" runat="server" AutoGenerateColumns="False" 
      Width="100%"  DataKeyNames="Id" DataSourceID="sqlDs_ApprovalAuthorities">
    <Columns>
        <asp:TemplateField>
            <ItemTemplate>
                <asp:ImageButton ID="imgDelete" OnClientClick="return confirm('Do you want to delete this record?');" runat="server" CommandArgument='<%#Eval("ID")%>' ToolTip="Delete" OnClick="imgDelete_Click"
                   ImageUrl="~/Images/delete.png" Width="16" />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="QutationSubDept" HeaderText="Clearance Department"
            SortExpression="QutationSubDept"  />
       
        
       
       
    </Columns>
</asp:GridView>

<asp:SqlDataSource ID="sqlDs_ApprovalAuthorities" runat="server" 
        ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>" SelectCommand="usp_ApprovalAutoritiesForClearance" SelectCommandType="StoredProcedure"
        DeleteCommand="Delete From Discharge_Department_Approval Where Id = @Id"
        UpdateCommand="usp_PatientClearanceAuthority" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>
        <UpdateParameters>
          
            <asp:ControlParameter ControlID="ddlEmployeeSubdept" Name="approvaldept" 
                PropertyName="SelectedValue" Type="Int32" />
             
         
           </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

