<%@ Page Language="VB" AutoEventWireup="false"  MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="Employee_Leaves_Approve_RejectForHR.aspx.vb"
    Inherits="Employee_Leaves_Approve_RejectForHR" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function backto() {
            history.go(-1);
        }
    </script>
    <style type="text/css">
        #navigation
        {
            display: none;
        }
        #header
        {
            display: none;
        }
        #content
        {
            margin-top: 10px;
        }
        .hinfo
        {
            display: none;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content">
        <h2> Employee Leave Approval By HR</h2>

        <asp:Panel ID="Panel_Leave" runat="server" Visible="True">
            <table cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
                <tr>
                    <td align="right" colspan="3" style="height: 15px">
                        <asp:SqlDataSource ID="dsEmployeeInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                            SelectCommand="Emp_BioData" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="EmpID" QueryStringField="Emp_Id" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:FormView ID="FormView1" runat="server" DataKeyNames="EmpID" DataSourceID="dsEmployeeInfo"
                    HorizontalAlign="Left" Width="100%">
                    <ItemTemplate>
                        <div class="bxinset radius4">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td valign="top" width="100" align="center">
                                        <asp:Image ID="Image2" runat="server" ImageUrl="~/images_hacims/picplace.jpg"
                                            Width="77px" Height="90px" />
                                    </td>
                                    <td valign="top">
                                        <ul class="empinfo">
                                            <li class="name">
                                                <asp:Label ID="Label_EmpName" runat="server" Text='<%# Eval("[Employee Name]") %>'
                                                    ToolTip="Employee Name"></asp:Label></li>
                                            <li>
                                                <asp:Label ID="Designation_NameLabel" runat="server" Style="color: #c60c0c; font-weight: bold;"
                                                    Text='<%# Bind("Designation_Name") %>'></asp:Label>
                                                <asp:Label ID="Designation_NameLabel0" runat="server" Text='<%# Convert.ToString("( ")+ Convert.ToString(Eval("SubDept_Name"))+Convert.ToString(" )") %>'></asp:Label></li>
                                            <li class="div">
                                                <asp:Label ID="Designation_NameLabel1" runat="server" Text='<%# Eval("Dept_Name") %>'></asp:Label></li>
                                            <li>Emp # <strong>
                                                <asp:Label ID="RegistrationNo" runat="server" Text='<%# Eval("EmpID") %>' 
                                                    ToolTip="Patient Registration Number"></asp:Label></strong>
                                                <span class="spl">|</span> Join Date : <strong>
                                                    <asp:Label ID="Label_JoinDate" runat="server" Text='<%# Bind("JoinDate") %>' ToolTip="Patient Age"></asp:Label></strong>
                                                <span class="spl">|</span> CNIC : <strong>
                                                    <asp:Label ID="Label_CNIC" runat="server" Text='<%# Eval("CNIC") %>' ToolTip="Identity Card #"></asp:Label></strong>
                                                <span class="spl">|</span> <strong>
                                                    <asp:Label ID="LabelGender" runat="server" Text='<%# Eval("Gender") %>' ToolTip="Patient Gender"></asp:Label></strong>
                                            </li>
                                        </ul>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </ItemTemplate>
                </asp:FormView>
                    </td>
                </tr>
                <tr>
                    <td style="width:33%;  vertical-align:top;" >
                        <div class="bxmain inner_content" >
                            <H2>Employee leave Balance</H2>
                            <asp:GridView ID="GridView6" runat="server" Width="98%" CssClass="Grid_1" AutoGenerateColumns="False">
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
                                   
                                    <br />
                                    <asp:HiddenField ID="lbltypeID" runat="server" value='<%# Bind("Leave_detail_type_id")%>'></asp:HiddenField>
                                    <br />
                                   
                                </ItemTemplate>
                            </asp:TemplateField>
                            </Columns>
                        </asp:GridView>

                            <br />

                            <h2> Approval Authorities</h2>
                <asp:GridView ID="GridView1" runat="server" EmptyDataText="No Record Found . . ." AutoGenerateColumns="False" 
                     Width="98%" CssClass="Grid_1">
                    <Columns>                         
                        <asp:BoundField DataField="Employee_Name" HeaderText="Approved By" />
                        <asp:BoundField DataField="Designation_Name" HeaderText="Designation" />                        
                        <asp:BoundField DataField="Leave_Days" HeaderText="Leave Days"  />
                        <asp:BoundField DataField="Leave_Name" HeaderText="Name" />
                        <asp:BoundField DataField="RequestStatus" HeaderText="Status" />
                        
                        <asp:BoundField DataField="ApprovedDate" HeaderText="Approved Date" />
                        <asp:BoundField DataField="Description" HeaderText="Description"  />                        
                        <asp:TemplateField Visible="False">
                            <ItemTemplate>
                                <asp:HiddenField ID="HF_Status" runat="server" Value  ='<%# Bind("RequestStatus")%>' />
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
                        </div>
                     </td>
                     <td style="width:34%;  vertical-align:top;" >
                        <div class="bxmain inner_content">
                            <H2>Employee leave Approval</H2>
                                <table width="100%">
                                    <tr>
                   
                                    <td align="right" width="40%" style="height: 15px">
                                        Leave :
                                    </td>
                                    <td width="60%" style="height: 15px">
                                        <asp:DropDownList ID="DropDownList_Leave_Name" runat="server" DataSourceID="SqlDataSource_Leave_Type_Detail"
                                            DataTextField="Leave_Name" DataValueField="Type_Detail_id" AutoPostBack="True" OnSelectedIndexChanged="DropDownList_Leave_Name_SelectedIndexChanged"
                                            Enabled="true" Width="80%">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                    <tr>
                                            <td align="right" width="40%">
                                                Leave Category:</td>
                                            <td width="60%">
                                                <asp:DropDownList ID="DropDownList_L_Sub_Cat" runat="server"
                                                    Width="80%" AutoPostBack="True">
                                                    <asp:ListItem Selected="True" Value="1">Full Day Leave</asp:ListItem>
                                                    <asp:ListItem Value="2">Short Leave Day</asp:ListItem>
                                                     <asp:ListItem Value="3">Half Day Leave</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                    <tr>
                                    <td align="right" style="height: 18px" width="40%">
                                        Start Date :
                                    </td>
                                    <td style="height: 18px" width="60%">
                                        <igsch:WebDateChooser ID="WebDateChooser_Start_Date" runat="server" CssClass="drop_date" Width="80%">
                                            <AutoPostBack ValueChanged="True" />
                                            <CalendarLayout Culture="English (United Kingdom)">
                                            </CalendarLayout>
                                        </igsch:WebDateChooser>
                                    </td>
                                </tr>
                                    <tr>
                                    <td align="right" width="40%">
                                        End Date :
                                    </td>
                                    <td width="60%">
                                        <igsch:WebDateChooser ID="WebDateChooser_End_Date" CssClass="drop_date" runat="server" Width="80%">
                                            <AutoPostBack ValueChanged="True" />
                                            <CalendarLayout Culture="English (United Kingdom)">
                                            </CalendarLayout>
                                        </igsch:WebDateChooser>
                                    </td>
                                </tr>
                                    <tr>
                                    <td align="right" width="40%">
                                        Requested Leaves :
                                    </td>
                                    <td width="60%">
                                        <asp:TextBox ID="TextBox_Requested_Leave" runat="server" Enabled="False" ReadOnly="True"
                                            Width="80%"></asp:TextBox>
                                    </td>
                                </tr>
                                    <tr>
                                    <td align="right" width="40%">
                                        Leave Day :
                                    </td>
                                    <td width="60%">
                                        <asp:TextBox ID="TextBox_Leave_Day" runat="server" Width="80%"></asp:TextBox>
                                    </td>
                                </tr>
                                    <tr>
                                    <td align="right" style="height: 18px" width="40%">
                                        Salary Day :
                                    </td>
                                    <td style="height: 18px" width="60%">
                                        <asp:TextBox ID="TextBox_Salary_Day" runat="server" Width="80%"></asp:TextBox>
                                    </td>
                                </tr>
                                    <tr>
                                    <td align="right" width="40%">
                                        Reason :
                                    </td>
                                    <td width="60%">
                                        <asp:TextBox ID="TextBox_Description" runat="server" Height="63px" TextMode="MultiLine"
                                            Width="80%"></asp:TextBox>
                                    </td>
                                </tr>
                                    <tr>
                                    <td align="right">
                                        <asp:SqlDataSource ID="SqlDataSource_Leaves_For_Approval" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
                                            ProviderName="<%$ ConnectionStrings:Leave_ManagementConnectionString.ProviderName %>"
                                            SelectCommand="SELECT     CONVERT(varchar, Employee_Leaves.Start_Date, 103) + ' To ' + CONVERT(varchar, Employee_Leaves.End_Date, 103) + ' ' + CONVERT(Varchar, &#13;&#10;                      Employee_Leaves.Leave_Days) + ' Days ' + Leave_Type_Detail.Leave_Name + ' Leave' AS Leave, Employee_Leaves.Emp_Id, Employee_Leaves.Emp_Leave_Id&#13;&#10;FROM         Employee_Leaves INNER JOIN&#13;&#10;                      Leave_Type_Detail ON Employee_Leaves.Type_Detail_Id = Leave_Type_Detail.Type_Detail_id&#13;&#10;WHERE     (Employee_Leaves.is_Approved = 0)"
                                            UpdateCommand="Update_Leave_RequestForHR" UpdateCommandType="StoredProcedure">
                                            <UpdateParameters>
                                                <asp:ControlParameter Name="Start_Date" Type="DateTime" ControlID="HiddenField_From_Date"
                                                    PropertyName="Value" />
                                                <asp:ControlParameter ControlID="HiddenField_to_Date" Name="End_Date" PropertyName="Value"
                                                    Type="DateTime" />
                                                <asp:ControlParameter ControlID="TextBox_Leave_Day" Name="Leave_Days" PropertyName="Text"
                                                    Type="Double" />
                                                <asp:ControlParameter ControlID="TextBox_Description" Name="Remarks" PropertyName="Text"
                                                    Type="String" />
                                                <asp:ControlParameter ControlID="TextBox_Salary_Day" Name="Salary_Day" PropertyName="Text"
                                                    Type="Double" />
                                                <asp:ControlParameter ControlID="HiddenField_Emp_Leave_ID" Name="Emp_Leave_Id" PropertyName="Value"
                                                    Type="Int32" />
                                                <asp:ControlParameter ControlID="HiddenField_Approved_Rejected" Name="is_Approved"
                                                    PropertyName="Value" Type="Int32" />

                                                  <asp:ControlParameter ControlID="DropDownList_Leave_Name" Name="leaveType"
                                                    PropertyName="SelectedValue" Type="Int32" />

                                                  <asp:SessionParameter Name="emp_id" SessionField="emp_id" DefaultValue="0" Type="Int32" />
                                                <asp:SessionParameter Name="LoginEmpSubdeptID" SessionField="SubDeptID" DefaultValue="0" Type="Int32" />
                                           <asp:QueryStringParameter Name="LeaveEmpSubdeptID" DbType = "Int32"   QueryStringField="SubDeptId" DefaultValue="0" />
                                                <asp:QueryStringParameter Name="LeaveEmpLogApprovalID" DbType = "Int32"   QueryStringField="leaveApprovalID" DefaultValue="0" />
                                                <asp:Parameter Name="data" Type="String" />
                                            </UpdateParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                    <tr>
                                    <td align="right">
                                        <asp:SqlDataSource ID="SqlDataSource_Leave_Type_Detail" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
                                            SelectCommand="
               Select Leave_Type_Detail.Leave_Name,Leave_Type_Detail.Type_Detail_id,Leave_Types.Leave_Type_Name,ISNULL(Leave_Type_Detail.Salary_Day,1) AS Salary_Day
                                                        From Leave_Type_Detail INNER JOIN Leave_Types ON Leave_Type_Detail.Leave_Type_id = Leave_Types.Leave_Type_Id"   >
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="Emp_ID" QueryStringField="Emp_ID" DefaultValue="0" Type="Int32" />
                                            </SelectParameters>

                                        </asp:SqlDataSource>
                                    </td>
                                    <td>
                                        <asp:Button ID="Button_approve" runat="server" Text="Approve" />
                                        <asp:Button ID="ButtonRejected" runat="server" Text="Rejected" />
                                        <asp:Label ID="LBL_Message" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                </table>
                        </div>
                     </td>
                     <td style="width:33%; vertical-align:top; " >
                        <div class="bxmain inner_content"><h2>Employee Request</h2>
                            <asp:GridView ID="GridView2" runat="server" EmptyDataText="No Record Found . . ." AutoGenerateColumns="False" 
                     Width="98%" CssClass="Grid_1">
                    <Columns>                         
                        <asp:BoundField DataField="Employee_Name" HeaderText="Employee" />
                        <asp:BoundField DataField="Designation_Name" HeaderText="Designation" />                        
                        <asp:BoundField DataField="Leave_Days" HeaderText="Leave Days"  />
                        <asp:BoundField DataField="Leave_Name" HeaderText="Name" />
                        <asp:BoundField DataField="CreatedDatee" HeaderText="Created Date" />
                        <asp:BoundField DataField="Description" HeaderText="Description"  />                        
                    </Columns>
                    <RowStyle CssClass="GridItem" />
                    <FooterStyle CssClass="GridPager" />
                    <SelectedRowStyle CssClass="gridselect" />
                    <HeaderStyle CssClass="GridHeader" />
                    <EditRowStyle CssClass="gridedit" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
                             <br />
                            <h2>Leave(s) Detail Date Wise </h2>
                            <asp:CheckBoxList ID="CheckBoxList_Dates_Of_Leaves" runat="server" AutoPostBack="True" Height="24px">
                            </asp:CheckBoxList>
                            <br />
                            <h2>Leave Documents</h2>
                            <asp:GridView ID="GridView_LeaveDouments" runat="server" AutoGenerateColumns="False" CssClass="Grid_1" EmptyDataText="No Record Found . . ." Width="98%">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr #">
                                        <ItemStyle Width="10%" />
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="leave Document">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkDownload" CausesValidation="false" Text='<%# Bind("FileName") %>' CommandName='<%# Bind("ContentType") %>' runat="server" OnClick="lnkDownload_Click"></asp:LinkButton>
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
                        </div>
                     </td>
              </tr>
            </table>
        </asp:Panel>
        <asp:HiddenField ID="HiddenField_Approved_Rejected" runat="server" />
        <asp:HiddenField ID="HiddenField_Emp_Leave_ID" runat="server" />
        <asp:HiddenField ID="hf_has_balance" runat="server" />
    </div>
    <br>
    <asp:SqlDataSource ID="SqlDataSource_Employee_Available" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Leave_ManagementConnectionString.ProviderName %>"
        SelectCommand="uspSelectEmployeeLevaesApprovaLogs" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="Emp_Leave_Id" QueryStringField="Emp_Leave_Id" Type="Int32" />            
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Employee_Leaves" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
        DeleteCommand="DELETE FROM [Employee_Leaves] WHERE [Emp_Leave_Id] = @Emp_Leave_Id"
        InsertCommand="INSERT INTO Employee_Leaves(Emp_Id, Start_Date, End_Date, Leave_Days, Description, Type_Detail_Id, Office_Ins_Id, Salary_Day) VALUES (@Emp_Id, @Start_Date, @End_Date, @Leave_Days, @Description, @Type_Detail_Id, @Office_Ins_Id, @Salary_Day)"
        SelectCommand="SELECT Employee_Leaves.Emp_Leave_Id, Employee_Leaves.Emp_Id, Convert(varchar,Employee_Leaves.Start_Date,103) AS Start_Date, Convert(varchar,Employee_Leaves.End_Date,103) AS End_Date, Employee_Leaves.Leave_Days, Employee_Leaves.Description, Employee_Leaves.Type_Detail_Id, Employee_Leaves.Office_Ins_Id, Leave_Type_Detail.Leave_Name, ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS [Employee Name] FROM Employee_Leaves INNER JOIN Leave_Type_Detail ON Employee_Leaves.Type_Detail_Id = Leave_Type_Detail.Type_Detail_id INNER JOIN Employee ON Employee_Leaves.Emp_Id = Employee.EmpID 
where Employee_Leaves.Emp_Id=@Emp_ID" UpdateCommand="UPDATE [Employee_Leaves] SET [Emp_Id] = @Emp_Id, [Start_Date] = @Start_Date, [End_Date] = @End_Date, [Leave_Days] = @Leave_Days, [Description] = @Description, [Type_Detail_Id] = @Type_Detail_Id, [Office_Ins_Id] = @Office_Ins_Id WHERE [Emp_Leave_Id] = @Emp_Leave_Id">
        <SelectParameters>
            <asp:QueryStringParameter Name="Emp_ID" QueryStringField="Emp_ID" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Emp_Leave_Id" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Emp_Id" Type="Int32" />
            <asp:Parameter Name="Start_Date" Type="DateTime" />
            <asp:Parameter Name="End_Date" Type="DateTime" />
            <asp:Parameter Name="Leave_Days" Type="Int32" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="Type_Detail_Id" Type="String" />
            <asp:Parameter Name="Office_Ins_Id" Type="Int32" />
            <asp:Parameter Name="Emp_Leave_Id" Type="Decimal" />
        </UpdateParameters>
        <InsertParameters>
            <asp:QueryStringParameter Name="Emp_Id" QueryStringField="emp_ID" />
            <asp:ControlParameter ControlID="HiddenField_From_Date" Name="Start_Date" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_to_Date" Name="End_Date" PropertyName="Value" />
            <asp:ControlParameter ControlID="TextBox_Leave_Day" Name="Leave_Days" PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBox_Description" Name="Description" PropertyName="Text" />
            <asp:ControlParameter ControlID="DropDownList_Leave_Name" Name="Type_Detail_Id" PropertyName="SelectedValue" />
            <asp:Parameter DefaultValue="1" Name="Office_Ins_Id" Type="Int32" />
            <asp:ControlParameter ControlID="TextBox_Salary_Day" Name="Salary_Day" PropertyName="Text" />
        </InsertParameters>
    </asp:SqlDataSource>
    
    <br />
     <asp:SqlDataSource ID="SqlDataSource_Balance" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
        SelectCommand="usp_LeaveBalance" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="empid" DefaultValue="0" QueryStringField="Emp_ID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
     <div class ="inner_content bxmain">
        <h2>Previous Leave History</h2>
            <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataKeyNames="Emp_Leave_Id"
        DataSourceID="SqlDataSource_Employee_Leaves" Width="100%" AllowPaging="True"
        Visible="False" CssClass="Grid_1">
        <Columns>
            <asp:BoundField DataField="Employee Name" HeaderText="Employee Name" SortExpression="Employee Name" />
            <asp:BoundField DataField="Leave_Name" HeaderText="Leave Name" SortExpression="Leave_Name" />
            <asp:BoundField DataField="Start_Date" HeaderText="Start Date" SortExpression="Start_Date" />
            <asp:BoundField DataField="End_Date" HeaderText="End Date" SortExpression="End_Date" />
            <asp:BoundField DataField="Leave_Days" HeaderText="Leave Days" SortExpression="Leave_Days" />
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
        </Columns>
        <RowStyle CssClass="GridItem" />
        <FooterStyle CssClass="GridPager" />
        <SelectedRowStyle CssClass="gridselect" />
        <HeaderStyle CssClass="GridHeader" />
        <EditRowStyle CssClass="gridedit" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
     </div>
    <asp:HiddenField ID="HiddenField_to_Date" runat="server" />
    <asp:HiddenField ID="HiddenField_From_Date" runat="server" />
    <asp:HiddenField ID="HiddenField_EmpId" runat="server" />
    
    <br />
</asp:Content>
