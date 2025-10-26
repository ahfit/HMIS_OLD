<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master"
    AutoEventWireup="true" CodeFile="Leave_Opening_Balance.aspx.cs" Inherits="Leave_Management_Leave_Opening_Balance" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Panel Width="100%" ID="Panel1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"> </asp:ScriptManager>
        <div class="bxmain inner_content" style="width:100%">
            <div><h2><span>Add Employee Leave Opening Balance</span></h2></div>
            <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                 <tr>
                    <td align="right" width="40%">
                        Branch :
                    </td>
                    <td>
                        <asp:DropDownList ID="DDL_Campus" runat="server" DataSourceID="SqlDataSourceCampus"
                            DataTextField="Hospital_Name" DataValueField="Hospital_id"  CssClass="drop_down"
                            Width="252px" AutoPostBack="True" 
                            onselectedindexchanged="DDL_Campus_SelectedIndexChanged">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSourceCampus" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                            SelectCommand="select Hospital_id,Hospital_Name from Hospital">
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td align="right" width="40%">
                        Department Name :
                    </td>
                    <td>
                        <asp:DropDownList ID="Dropdownlistdepartment" runat="server" DataSourceID="SqlDataSourceDepartment"
                            DataTextField="Dept_Name" DataValueField="Dept_ID"  CssClass="drop_down"
                            Width="252px" AutoPostBack="True" 
                            onselectedindexchanged="Dropdownlistdepartment_SelectedIndexChanged">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                            SelectCommand="SELECT [Dept_Name], [Dept_ID] FROM [Department]  where Hospital_Id=@Hospital_Id ORDER BY [Dept_Name]">
                            <SelectParameters>
                                <asp:ControlParameter Name="Hospital_Id" ControlID="DDL_Campus" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Sub Department Name :
                    </td>
                    <td>
                        <asp:DropDownList ID="DropDownList_SubDepartment" runat="server" CssClass="drop_down"
                            DataSourceID="SqlDataSource_SubDept" DataTextField="SubDept_Name" DataValueField="SubDept_Id"
                            TabIndex="2" Width="252px" AutoPostBack="True" OnSelectedIndexChanged="DropDownList_SubDepartment_SelectedIndexChanged">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource_SubDept" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                            SelectCommand="SELECT SubDept_Id, SubDept_Name FROM SubDepartment WHERE (Dept_Id = @deptid)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="deptid" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Employee Name :
                    </td>
                    <td>
                        <asp:DropDownList ID="DropDownListEmployee" runat="server" DataSourceID="SqlDataSource_Employee" CssClass="drop_down"
                            DataTextField="Employee Name" DataValueField="EmpID" Width="252px"  TabIndex="3" 
                            AutoPostBack="True" 
                            onselectedindexchanged="DropDownListEmployee_SelectedIndexChanged">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource_Employee" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                            SelectCommand="SELECT EmpID, ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') +' '+Cast(Employee.EmpID as varchar)+' '+' ('+ Designation.Designation_Name +')' AS [Employee Name], Is_Deleted FROM Employee
                            inner join  Designation on Employee.DesignationID = Designation.Designation_ID
                            WHERE (DeptID = @DeptID) AND (SubDeptId = @SubDeptId) and (ActiveStatus=1) AND (Is_Deleted = 0) ORDER BY [Employee Name]">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="DeptID" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="DropDownList_SubDepartment" Name="SubDeptId" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Leave Type :
                    </td>
                    <td>
                        <asp:DropDownList ID="DropDownList_LeaveType" runat="server" CssClass="drop_down" Width="252px" 
                            DataSourceID="SqlDataSource_Leave_Type_Detail" DataTextField="Leave_Name" DataValueField="Type_Detail_id"
                            TabIndex="4" >
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource_Leave_Type_Detail" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
                            SelectCommand="Select Leave_Type_Detail.Leave_Name,Leave_Type_Detail.Type_Detail_id,Leave_Types.Leave_Type_Name
From Leave_Type_Detail
INNER JOIN Leave_Types ON Leave_Type_Detail.Leave_Type_id = Leave_Types.Leave_Type_Id where isnull(Has_Opening,0) = 1">
                            
                        </asp:SqlDataSource>
                        <%--<asp:SqlDataSource ID="SqlDataSource_LeaveType" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
                            SelectCommand="SELECT Type_Detail_id, Leave_Name FROM Leave_Type_Detail WHERE (Leave_Name &lt;&gt; '') ORDER BY Leave_Name">
                        </asp:SqlDataSource>--%>
                    </td>
                </tr>
                <tr style="display:none;">
                    <td align="right">
                        Opening Date :
                    </td>
                    <td>
                       <%-- <igsch:WebDateChooser ID="WDC_OpeningDate" runat="server"  TabIndex="5">
                            <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                        </igsch:WebDateChooser>--%>
                        <asp:TextBox ID="WDC_OpeningDate" runat="server"  TabIndex="5" TextMode="Date" Width="252px"></asp:TextBox>
                        <asp:HiddenField ID="HiddenField_OpeningDate" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Balance year :
                    </td>
                    <td>
                        <asp:DropDownList ID="DDLyearBalance" runat="server"  TabIndex="6" Width="252px">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Leave Balance :
                    </td>
                    <td>
                        <asp:TextBox ID="txtLeaveBalance" runat="server"  TabIndex="7" Width="252px"></asp:TextBox>
                    </td>
                </tr>
                <tr style="display:none">
                    <td align="right">
                        Without cash leaves :
                    </td>
                    <td>
                        <asp:TextBox ID="txtWithoutCashLeaves" runat="server"  TabIndex="8"></asp:TextBox>
                    </td>
                </tr>
                 <tr >
                     <td align="right">Reason / Remarks / Comment :</td>
                     <td>
                         <asp:TextBox ID="txtRemarks" runat="server" TabIndex="9" TextMode="MultiLine" Width="252px" Height="150px"></asp:TextBox>
                     </td>
                 </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                        <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Save" CssClass="btn_hacims"  TabIndex="10" />
                        <asp:Label ID="lblMsg" runat="server" ForeColor="#C00000"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <div class ="inner_content bxmain">
                <h2>Employee(s) Opening Balance Detail(s)...</h2>
          <%--  <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>--%>
                    <asp:GridView ID="grdOpeningBalanace" runat="server" AutoGenerateColumns="False"
                        AllowSorting="true"
                        DataKeyNames="ID" DataSourceID="SqlDataSource_OpeningBalance" CssClass="Grid_1"
                        Width="100%">
                        <Columns>
                            <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                                SortExpression="ID" Visible="False" />
                            <asp:BoundField DataField="Employee Name" HeaderText="Employee Name" SortExpression="Employee Name"
                                ReadOnly="True" />
                            <asp:BoundField DataField="Department" HeaderText="Department" SortExpression="Department" />
                            <asp:BoundField DataField="SubDept_Name" HeaderText="SubDepartment" SortExpression="SubDept_Name" />
                            <asp:BoundField DataField="Leave_Name" HeaderText="Leave Type" SortExpression="Leave_Name" />
                            <asp:BoundField DataField="Remaning Leaves" HeaderText="Opening Leave(s)" SortExpression="Remaning Leaves" />
                            <asp:BoundField DataField="Without Cash Leaves" HeaderText="Without Cash Leaves"
                                SortExpression="Without Cash Leaves" Visible="False" />
                            <asp:TemplateField HeaderText="Update Record" Visible="False">
                                <ItemTemplate>
                                    <asp:LinkButton ID="Delete" runat="server" CommandArgument='<%#Eval("ID") %>'
                                        OnClick="Delete_Click">Delete Record</asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                           
                            <asp:BoundField DataField="Enter By" HeaderText="Enter By" SortExpression="Enter By" />
                            <asp:BoundField DataField="On Date" HeaderText="On Date" ReadOnly="True" SortExpression="On Date" />
			<asp:BoundField DataField="Balance_Year" HeaderText="Balance_Year" SortExpression="Balance_Year" />
                            <asp:BoundField DataField="Remarks" HeaderText="Remarks" SortExpression="Remarks" />
                             <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnk_UpdateRecord" runat="server" Text="Update Balance" CommandArgument='<%#Eval("ID") %>'
                                        OnClick="lnk_UpdateRecord_Click" Visible='<%#Eval("IsUpdateShow") %>'></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                        </EmptyDataTemplate>
                    </asp:GridView>
                   <%-- <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                        <ProgressTemplate>
                            <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #ffffff; opacity: 0.7;">
                                <span style="border-width: 0px; position: fixed; padding: 50px; background-color: #ffffff; font-size: 36px; left: 40%; top: 40%;">
                                    <img src="../images/progressbarimg.png" width="120px" height="120px" style="background: #ffffff" alt="" />
                                </span>
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>--%>
               <%-- </ContentTemplate>
            </asp:UpdatePanel>--%>
        <asp:SqlDataSource ID="SqlDataSource_OpeningBalance" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
            SelectCommand="sp_LeaveOpeningBalance" SelectCommandType="StoredProcedure" UpdateCommand="UPDATE Employee_Leave_Balance SET Leave_detail_type_id=@Leave_detail_type_id, Emp_id = @Emp_id, Leave_Balance_Date = @Leave_Balance_Date, Leaves = @Leaves, Without_Cash_Leave = @Without_Cash_Leave, Dept_id = @Dept_id, Designation_id = @Designation_id WHERE (ID = @ID)"
            DeleteCommand="DELETE FROM Employee_Leave_Balance WHERE (ID = @id)">
            <DeleteParameters>
                <asp:Parameter Name="id" />
            </DeleteParameters>
            <SelectParameters>
               <%-- <asp:Parameter DefaultValue="-1" Name="emp_id" Type="Int32" />--%>
                 <asp:ControlParameter Name="emp_id" DefaultValue="-1"  PropertyName="SelectedValue" ControlID="DropDownListEmployee"/>
                <asp:ControlParameter Name="Subdept_Id" PropertyName="SelectedValue" ControlID="DropDownList_SubDepartment" DefaultValue=""/>
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Emp_id" />
                <asp:Parameter Name="Leave_Balance_Date" />
                <asp:Parameter Name="Leaves" />
                <asp:Parameter Name="Without_Cash_Leave" />
                <asp:Parameter Name="Dept_id" />
                <asp:Parameter Name="Designation_id" />
                <asp:Parameter Name="ID" />
                <asp:Parameter Name="Leave_detail_type_id" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenField_ID" runat="server" />
            </div>
    </asp:Panel>
</asp:Content>
