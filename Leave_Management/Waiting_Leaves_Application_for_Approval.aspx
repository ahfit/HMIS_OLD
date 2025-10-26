<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Waiting_Leaves_Application_for_Approval.aspx.vb"
    MasterPageFile="~/hacims_masterpage_admin.master" Inherits="Waiting_Leaves_Application_for_Approval" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function backto() {
            history.go(-1);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%">
        <h2><span>All Pending Leaves Request</span></h2>
    </div>
    <div>
        </br></br></br>
        <asp:SqlDataSource ID="SqlDataSource_Employee" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
            ProviderName="<%$ ConnectionStrings:Leave_ManagementConnectionString.ProviderName %>"
            SelectCommand="SELECT distinct Employee_Leaves.Emp_Leave_Id,Case when Employee_Leaves.is_approved is NULL then 1 else 0 end  HStatus
,case when Employee_Leaves.is_approved is null then 'Approve/Reject' when Employee_Leaves.is_approved=0 then 'Rejected' else 'Approved' end CBExpression,
                            Employee_Leaves.Start_Date,Employee_Leaves.End_Date,Employee_Leaves.Requested_Days
							,Employee_Leaves.Remarks,Employee_Leaves.Salary_Day,Employee.EmpID
							, Employee.Prefix + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS EmployeeName
							, Designation.Designation_Name, Department.Dept_Name 
							FROM
							EmployeeReportingAuthority
inner join LeaveApprovalProcess on LeaveApprovalProcess.ApprovalID=EmployeeReportingAuthority.EmpID
inner join Employee on Employee.EmpID=RequestBy
 INNER JOIN  Designation ON Employee.DesignationID = Designation.Designation_ID 
                            INNER JOIN  Department ON Employee.DeptID = Department.Dept_ID  
							INNER JOIN  Employee_Leaves ON Employee.EmpID = Employee_Leaves.Emp_Id 
							inner join Leave_Type_Detail on Employee_Leaves.Type_Detail_Id=Leave_Type_Detail.Type_Detail_id
							 inner join Leave_Types on Leave_Type_Detail.Leave_Type_id =Leave_Types.Leave_Type_Id 
         where EmployeeReportingAuthority.EmpID=@EmpID and IsApproved is null  ">
            <SelectParameters>
                <asp:SessionParameter Name="EmpID" Type="Int32" SessionField="emp_id" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="GridView1" CssClass="Grid_1" ShowHeaderWhenEmpty="true" runat="server" AutoGenerateColumns="false" DataSourceID="SqlDataSource_Employee"
            Width="100%">
            <Columns>
                <asp:BoundField DataField="EmployeeName" HeaderText="EmployeeName" SortExpression="EmployeeName" />
                <asp:BoundField DataField="Designation_Name" HeaderText="Designation_Name" SortExpression="Designation_Name" />
                <asp:BoundField DataField="Dept_Name" HeaderText="Dept_Name" SortExpression="Dept_Name" />
                <asp:BoundField DataField="Requested_days" HeaderText="Requested Days" SortExpression="Requested_days" />
                <asp:BoundField DataField="salary_day" HeaderText="Salary Days" SortExpression="salary_day" />
                <asp:BoundField DataField="Start_Date" HeaderText="From Date" SortExpression="Start_Date" />
                <asp:BoundField DataField="End_Date" HeaderText="End Date" SortExpression="End_Date" />
                <asp:BoundField DataField="Remarks" HeaderText="Remarks" SortExpression="Remarks" />
               
                <asp:TemplateField HeaderText="Approve / Reject">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server"
                            Text='<%# Eval("CBExpression") %>'
                            CommandArgument='<%# Eval("Emp_Leave_Id") %>'
                            Visible='<%# Eval("HStatus") %>' OnClick="LinkButton1_Click"></asp:LinkButton>
                        <%--<asp:Label ID="Label1" runat="server" ForeColor="#FF0066"
                            Text='<%# Eval("CBExpression") %>'></asp:Label>--%>
                        <asp:HiddenField ID="hfdEmpID" runat ="server" Value='<%# Eval("EmpID") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle CssClass="GridItem" />
            <FooterStyle CssClass="GridPager" />
            <SelectedRowStyle CssClass="gridselect" />
            <HeaderStyle CssClass="GridHeader" />
            <EditRowStyle CssClass="gridedit" />
            <AlternatingRowStyle CssClass="GridAltItem" />
        </asp:GridView>
        <br />
    </div>
    <asp:HiddenField ID="HiddenField_EmpId" runat="server" />
    <div>
        <asp:Panel ID="Panel2" runat="server" CssClass="lightbox" Visible="false">
            <%--CssClass = "lightbox"--%>
             <asp:SqlDataSource ID="SqlDataSource_Balance" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
        SelectCommand="usp_LeaveBalance" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_EmpId" Name="empid" PropertyName="Value"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
               <td valign="top" width="25%">
                <div class="bxmain" style="width: 97%;">
                    <h2>
                        <span>Leave Balance</span></h2>
                    <p>
                        <span></span>&nbsp;</p>
                    <div style="border-style: solid; border-width: 0px; height: 220px; overflow-x: hidden; overflow-y: auto;">
                        <asp:GridView ID="GridView6" runat="server" Width="98%" CssClass="Grid_1" AutoGenerateColumns="False"
                            DataSourceID="SqlDataSource_Balance" EnableModelValidation="True">
                            <AlternatingRowStyle CssClass="GridAltItem" />
                            <Columns>
                              <asp:TemplateField HeaderText="Leave Name" SortExpression="Leave_Name">
                             
                                <ItemTemplate>
                                    <asp:Label ID="lblLeave_Name" runat="server" Text='<%# Bind("Leave_Name") %>'></asp:Label>
                                   
                                </ItemTemplate>
                            </asp:TemplateField>



                           
                                <asp:BoundField DataField="Allow Leaves" HeaderText="Allow Leaves" SortExpression="Allow Leaves" />
                                <asp:BoundField DataField="Avail" HeaderText="Avail" ReadOnly="True" SortExpression="Avail" />
                               
                                  <asp:TemplateField HeaderText="Remaining" SortExpression="Remaining">
                             
                                <ItemTemplate>
                                    <asp:Label ID="lblRemaining" runat="server" Text='<%# Bind("Remaining") %>'></asp:Label>
                                   
                                </ItemTemplate>
                            </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </td>
            <td>
                
                 
            <table cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
              <tr> 
                    <td align="right" colspan="2" style="height: 15px">
                        <asp:SqlDataSource ID="dsEmployeeInfo0" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
                            ProviderName="<%$ ConnectionStrings:Leave_ManagementConnectionString.ProviderName %>"
                            SelectCommand="Emp_BioData" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="EmpID" QueryStringField="Emp_Id" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td align="right" width="40%" style="height: 15px">Leave :
                    </td>
                    <td width="60%" style="height: 15px">
                        <asp:DropDownList ID="DropDownList_Leave_Name0" runat="server" DataSourceID="SqlDataSource_Leave_Type_Detail0"
                            DataTextField="Leave_Name" DataValueField="Type_Detail_id" AutoPostBack="True"
                            Enabled="False">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="height: 15px" width="40%">Leave Category:</td>
                    <td style="height: 15px" width="60%">
                        <asp:DropDownList ID="DropDownList_L_Sub_Cat0" runat="server" Width="202px">
                            <asp:ListItem Selected="True" Value="1">Full Leave Day</asp:ListItem>
                            <asp:ListItem Value="2">Short Leave Day</asp:ListItem>
                            <asp:ListItem Value="3">Half Leave Day</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="height: 18px">Start Date :
                    </td>
                    <td style="height: 18px">
                        <igsch:WebDateChooser ID="WebDateChooser_Start_Date0" runat="server" Enabled="false"
                            CssClass="drop_date">
                            <AutoPostBack ValueChanged="True" />
                            <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                        </igsch:WebDateChooser>
                    </td>
                </tr>
                <tr>
                    <td align="right">End Date :
                    </td>
                    <td>
                        <igsch:WebDateChooser ID="WebDateChooser_End_Date0" CssClass="drop_date" Enabled="false"
                            runat="server">
                            <AutoPostBack ValueChanged="True" />
                            <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                        </igsch:WebDateChooser>
                    </td>
                </tr>
                <tr>
                    <td align="right">Requested Leaves :
                    </td>
                    <td>
                        <asp:TextBox ID="TextBox_Requested_Leave" runat="server" Enabled="False" ReadOnly="True"
                            Width="31px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">Leave Day :
                    </td>
                    <td>
                        <asp:TextBox ID="TextBox_Leave_Day0" runat="server" Width="33px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="height: 18px">Salary Day :
                    </td>
                    <td style="height: 18px">
                        <asp:TextBox ID="TextBox_Salary_Day0" runat="server" Width="33px"></asp:TextBox>
                    </td>
                </tr>
                 <tr>
                    <td align="right" style="height: 18px">Recommended To :
                    </td>
                    <td style="height: 18px">
                        <asp:DropDownList ID="DDL_Recommended_To" DataTextField="Employee_Name" DataValueField="EmpID" runat="server" DataSourceID="SqlDataSource1">
                        </asp:DropDownList>
                         <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
                            ProviderName="<%$ ConnectionStrings:Leave_ManagementConnectionString.ProviderName %>"
                            SelectCommand="Select e.EmpID,e.Employee_Name  from EmployeeReportingAuthority as er inner join Employee as e on er.EmpID=e.EmpID where er.EmpID<>@CompID and PriorityLevel>(Select PriorityLevel from EmployeeReportingAuthority where EmpID=@CompID) and er.SubDeptId=(Select SubDeptId from Employee where EmpID=@EmpId)">
                            <SelectParameters>
                                <asp:SessionParameter SessionField="emp_id" Name="CompID" Type="Int32" />
                                 <asp:Parameter  Name="Emp_Leave_Id" Type="Int32" />
                               
                                  <asp:ControlParameter ControlID="HiddenField_EmpId" Name="EmpId" PropertyName="Value"
                                Type="Int32" />
                            </SelectParameters>
                              </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td align="right">Reason :
                    </td>
                    <td>
                        <asp:TextBox ID="TextBox_Description0" runat="server" Height="63px" TextMode="MultiLine"
                            Width="358px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:SqlDataSource ID="SqlDataSource_Leaves_For_Approval" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
                            ProviderName="<%$ ConnectionStrings:Leave_ManagementConnectionString.ProviderName %>"
                            SelectCommand="SELECT     CONVERT(varchar, Employee_Leaves.Start_Date, 103) + ' To ' + CONVERT(varchar, Employee_Leaves.End_Date, 103) + ' ' + CONVERT(Varchar, &#13;&#10;                      Employee_Leaves.Leave_Days) + ' Days ' + Leave_Type_Detail.Leave_Name + ' Leave' AS Leave, Employee_Leaves.Emp_Id, Employee_Leaves.Emp_Leave_Id&#13;&#10;FROM         Employee_Leaves INNER JOIN&#13;&#10;                      Leave_Type_Detail ON Employee_Leaves.Type_Detail_Id = Leave_Type_Detail.Type_Detail_id&#13;&#10;WHERE     (Employee_Leaves.is_Approved = 0)"
                            UpdateCommand="Update_Leave_Request"
                            UpdateCommandType="StoredProcedure">
                            <UpdateParameters>
                                <asp:ControlParameter Name="Start_Date" Type="DateTime" ControlID="HiddenField_From_Date0"
                                    PropertyName="Value" />
                                <asp:ControlParameter ControlID="HiddenField_to_Date0" Name="End_Date" PropertyName="Value"
                                    Type="DateTime" />
                                <asp:ControlParameter ControlID="TextBox_Leave_Day0" Name="Leave_Days" PropertyName="Text"
                                    Type="Double" />
                                <asp:ControlParameter ControlID="TextBox_Description0" Name="Remarks" PropertyName="Text"
                                    Type="String" />
                                <asp:ControlParameter ControlID="TextBox_Salary_Day0" Name="Salary_Day" PropertyName="Text"
                                    Type="Double" />
                                <asp:ControlParameter ControlID="HiddenField_Emp_Leave_ID" Name="Emp_Leave_Id" PropertyName="Value"
                                    Type="Int32" />
                                <asp:ControlParameter ControlID="HiddenField_Approved_Rejected" Name="is_Approved"
                                    PropertyName="Value" Type="Boolean" />
                               <asp:Parameter Name="Recommend_Id" DefaultValue="0" Type="Int32" />
                               
                                   <asp:SessionParameter SessionField="emp_id" Name="EmployeeID" Type="Int32" /> 
                            </UpdateParameters>
                        </asp:SqlDataSource>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:SqlDataSource ID="SqlDataSource_Leave_Type_Detail0" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
                            SelectCommand="SELECT [Type_Detail_id], [Leave_Name] FROM [Leave_Type_Detail]"></asp:SqlDataSource>
                    </td>
                    <td>
                        <asp:Button ID="Button_approve" runat="server" Text="Approve" />
                        <asp:Button ID="ButtonRejected" runat="server" Text="Rejected" />
                        <asp:Button ID="ButtonRecommend" runat="server" Text="Recommend" OnClick="ButtonRecommend_Click" />
                        <asp:Button ID="buttonCancel" runat="server" Text="Cancel" />
                        <asp:Label ID="LBL_Message" runat="server"></asp:Label>
                        <asp:HiddenField ID="HiddenField_to_Date0" runat="server" />
                        <asp:HiddenField ID="HiddenField_From_Date0" runat="server" />
                        <asp:HiddenField ID="HiddenField_Emp_Leave_ID" runat="server" />
                        <asp:HiddenField ID="HiddenField_Approved_Rejected" runat="server" />
                    </td>
                </tr>
                 </table>
                </td>
             </tr>
            </table>
        </asp:Panel>
    </div>
</asp:Content>
