<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="false" 
    CodeFile="LeaveBalanceTransferAndLaps.aspx.vb" Inherits="Leave_Management_LeaveBalanceTransferAndLaps" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <style type="text/css">
        .tab
        {
            width:100;
        }

        .rightTD
        {
            width : 50%;
            text-align:right;
        }
        .leftTD
        {
            width : 50%;
            align-content :left ;
        }
    </style>
    <script type="text/javascript">
        function confirmationSave(text) {
            if (confirm('Are you sure you want to Save ' + text + '?')) {
                return true;
            } else {
                return false;
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="bxmain ; inner_content ">
        <h2> Leave Balance Transfer And laps </h2>
        <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                <tr>
                    <td align="right" width="40%">
                        Institute :
                    </td>
                    <td>
                        <asp:DropDownList ID="DDL_Campus" runat="server" DataSourceID="SqlDataSourceCampus"
                            DataTextField="Hospital_Name" DataValueField="Hospital_id"  CssClass="drop_down"
                            Width="252px" AutoPostBack="True"  >
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSourceCampus" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                            SelectCommand="select 0 as Hospital_id,'---ALL---' as Hospital_Name union select Hospital_id,Hospital_Name from Hospital order by Hospital_Name">
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td align="right" width="40%">
                        Department :
                    </td>
                    <td>
                        <asp:DropDownList ID="Dropdownlistdepartment" runat="server" DataSourceID="SqlDataSourceDepartment"
                            DataTextField="Dept_Name" DataValueField="Dept_ID"  CssClass="drop_down"
                            Width="252px" AutoPostBack="True" >
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                            SelectCommand="SELECT '---ALL---' AS [Dept_Name],0 as [Dept_ID] UNION SELECT [Dept_Name], [Dept_ID] FROM [Department]  where (@Hospital_Id =0 or Hospital_Id=@Hospital_Id) ORDER BY [Dept_Name]">
                            <SelectParameters>
                                <asp:ControlParameter Name="Hospital_Id" ControlID="DDL_Campus" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Sub Department :
                    </td>
                    <td>
                        <asp:DropDownList ID="DropDownList_SubDepartment" runat="server" CssClass="drop_down"
                            DataSourceID="SqlDataSource_SubDept" DataTextField="SubDept_Name" DataValueField="SubDept_Id"
                            TabIndex="2" Width="252px" AutoPostBack="True">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource_SubDept" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                            SelectCommand="SELECT 0 as SubDept_Id, '---ALL---' SubDept_Name UNION SELECT SubDept_Id, SubDept_Name FROM SubDepartment WHERE (@deptid =0 or Dept_Id = @deptid) order by SubDept_Name">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="deptid" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr style="display:none;">
                    <td align="right">
                        Employee Type:
                    </td>
                    <td>
                        <asp:RadioButtonList ID="RBL_E_Type" runat="server" RepeatDirection="Horizontal" Width="252px" AutoPostBack="True">
                            <asp:ListItem Selected="True" Value="0">All</asp:ListItem>
                            <asp:ListItem Value="2">Contractual</asp:ListItem>
                            <asp:ListItem Value="8">Permanent</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Employee :
                    </td>
                    <td>
                        <asp:DropDownList ID="DropDownListEmployee" runat="server" DataSourceID="SqlDataSource_Employee" CssClass="drop_down"
                            DataTextField="Employee Name" DataValueField="EmpID" Width="252px"  TabIndex="3" 
                            AutoPostBack="True" >
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource_Employee" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                            SelectCommand="SELECT 0 AS EmpID, '---ALL---' AS [Employee Name] UNION 
SELECT EmpID, ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '')+' '+Cast(Employee.EmpID as varchar)+' '+' ('+Cast( Designation.Designation_Name as varchar )+')'  AS [Employee Name]
FROM Employee inner join Designation on Employee.DesignationID=Designation.Designation_ID
WHERE (@DeptID =0 or DeptID = @DeptID) AND (@SubDeptId =0 or SubDeptId = @SubDeptId) AND (Is_Deleted = 0 ) and (ActiveStatus =1)  and (@emp_type_ID =0 or Employee_Type_ID= @emp_type_ID)
 ORDER BY [Employee Name]">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="DeptID" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="DropDownList_SubDepartment" Name="SubDeptId" PropertyName="SelectedValue" />
                                <asp:ControlParameter Name="emp_type_ID" ControlID="RBL_E_Type" PropertyName="SelectedValue" />
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
                            TabIndex="4" AutoPostBack="True" >
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource_Leave_Type_Detail" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
                            SelectCommand="Select Leave_Type_Detail.Leave_Name,Leave_Type_Detail.Type_Detail_id,Leave_Types.Leave_Type_Name
From Leave_Type_Detail
INNER JOIN Leave_Types ON Leave_Type_Detail.Leave_Type_id = Leave_Types.Leave_Type_Id">
                            
                        </asp:SqlDataSource>
                        
                    </td>
                </tr>
                
                <tr>
                    <td align="right">
                        Balance year :
                    </td>
                    <td>
                        <asp:DropDownList ID="DDLyearBalance" runat="server"  TabIndex="6" Width="252px" AutoPostBack="True">
                        </asp:DropDownList>
                        <asp:RadioButtonList ID="rdlForYear" runat="server" Visible="false" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Encashment For Current Year" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Encashment For Previous Year" Value="2" Selected="True"></asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>

            <tr>
                    <td align="right">
                        Earned Leaves Date :
                    </td>
                    <td>
                       <igsch:WebDateChooser ID="WebDateChooser_Start_Date" runat="server" CssClass="drop_down">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                    </td>
                </tr>  
              <tr style="display:none;">
                    <td align="right">
                        Leave Balance Type :
                    </td>
                    <td>
                        <asp:RadioButtonList Width="252px" ID="rdLBtype" RepeatDirection="Horizontal" runat="server" >
                            <asp:ListItem Text="Lapse" Value="Lapse"></asp:ListItem>
                            <asp:ListItem Text="Forward" Value="Forward"></asp:ListItem>
                            </asp:RadioButtonList>
                    </td>
                </tr>    



                <tr>
                    <td>
                    </td>
                    <td>
                        <asp:Button ID="btnSearch" runat="server"  OnClick="btnSearch_Click" Text="Search" CssClass="btn_hacims"  TabIndex="9" />
<span Style="padding-left:50px"> 
                        <asp:Button ID="btnSave" runat="server" Text="Save Opening Balance" CssClass="btn_hacims"  TabIndex="10" OnClientClick="return confirmationSave('Opening Balance')" /> </span>
                        <asp:Button ID="btn_leave_encashment" runat="server" CssClass="btn_hacims" Text="Save Encashment"  TabIndex="11" OnClientClick="return confirmationSave('Leave Encashment')" Visible="false"/>
                        <asp:Label ID="lblMsg" runat="server" ForeColor="#C00000"></asp:Label>
                    </td>
                </tr>
            </table>
    </div>
    <br />
    <br />
<div class="bxmain ; inner_content " >
        <h2> Emmployee Opening Detail(s) </h2>
    <asp:gridview ID ="GV_Rec" runat="server" Width="100%" EmptyDataText="No Opening balance Found..." AutoGenerateColumns="False"
        DataSourceID="SDS_Rec" align="center">
        <Columns>
            <%--<asp:BoundField DataField="CurrentYearLeaveBalance" HeaderText="" SortExpression="CurrentYearLeaveBalance" />--%>
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
            <asp:BoundField DataField="Leave_Name" HeaderText="Leave Name" SortExpression="Leave_Name" />
            <asp:TemplateField HeaderText="Maximum Available Days" SortExpression="MaximumAvailDays">
                
                <ItemTemplate>
                    <asp:Label ID="lbl_MAD" runat="server" Text='<%# Bind("MaximumAvailDays") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Maximum Forwardable Days" SortExpression="FD">
               <ItemTemplate>
                    <asp:Label ID="lbl_FD" runat="server" Text='<%# Bind("FD") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Previous Year Leave Balance" SortExpression="PreviousLeaveBalance">
                
                <ItemTemplate>
                    <asp:Label ID="lbl_PLB" runat="server" Text='<%# Bind("PreviousLeaveBalance") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:BoundField DataField="Total_leave_Days" HeaderText="Total leave Availed" SortExpression="Total_leave_Days" />
            <asp:TemplateField HeaderText="Encashed Leaves" SortExpression="EncashedLeaves">
                
                <ItemTemplate>
                    <asp:Label ID="lblEncashLeaves" runat="server" Text='<%# Bind("EncashedLeaves") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Lapsed Leaves">
                
                <ItemTemplate>
                    <asp:Label ID="lblLapsedLeaves" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Remaining Leave" SortExpression="remainingLeave">
                <ItemTemplate>
                    <asp:Label ID="lblReLeave" runat="server" Text='<%# Bind("remainingLeave") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

              <asp:TemplateField HeaderText="Current Leave Balance">                
                <ItemTemplate>
                    <asp:TextBox ID="txtboxLapsedLeaves" runat="server" min="0" TextMode="Number" Width="60px" ></asp:TextBox>
                    <asp:HiddenField ID ="HF_CurrentYearLeaveBalance" runat="server" Value='<%# Eval("CurrentYearLeaveBalance") %>'  />
                </ItemTemplate>
                  <ItemStyle Width="70px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Encash leave">                
                <ItemTemplate>
                    <asp:TextBox ID="txtboxEncashLeave" runat="server" min="0"  Max="30" TextMode="Number" Width="60px"  Visible='<%# Eval("Encashment") %>' ></asp:TextBox>
                    <%--Text='<%# Bind("EncashAmount") %>'--%>
                    <asp:HiddenField ID ="HF_is_encashment" runat="server" Value='<%# Eval("Encashment")%>'  />
                </ItemTemplate>
                  <ItemStyle Width="70px" />
            </asp:TemplateField>
            
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:CheckBox OnCheckedChanged="checkboxSelectAll_CheckedChanged" AutoPostBack="true" ID="checkboxSelectAll" runat="server" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="chkboxSelect" runat="server" />
                    <asp:HiddenField ID="hfEmpID" runat="server" Value='<%# Eval("Emp_id") %>' />
                    <asp:HiddenField ID="hfPreviousLeaveBalance" runat="server" Value='<%# Eval("PreviousLeaveBalance")%>' />
                    <asp:HiddenField ID="hfTotal_leave_Days" runat="server" Value='<%# Eval("Total_leave_Days")%>' />            
                    <asp:HiddenField ID="hfIsEncash" runat="server" Value='<%# Eval("Encashment")%>' /> 
                        
                    
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>

    </asp:gridview>
    <asp:SqlDataSource ID ="SDS_Rec" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>" ProviderName="<%$ ConnectionStrings:Leave_ManagementConnectionString.ProviderName %>" SelectCommand="get_Leave_opening_transfer" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDL_Campus" Name="hospotalID" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList_SubDepartment" Name="SubdeptID" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="deptID" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownListEmployee" Name="EmpID" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DDLyearBalance" Name="year" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList_LeaveType" Name="LeaveTypeID" PropertyName="SelectedValue" Type="Int32" />



            <asp:ControlParameter ControlID="RBL_E_Type" Name="E_Type" PropertyName="SelectedValue" Type="Int32" />

            <asp:ControlParameter ControlID="rdlForYear" Name="YearValue" PropertyName="SelectedValue" Type="Int32" />

        </SelectParameters>
        </asp:SqlDataSource>
    <asp:HiddenField ID ="HF_Search_Item" runat="server" Value="0" />
     </div>    
</asp:Content>

