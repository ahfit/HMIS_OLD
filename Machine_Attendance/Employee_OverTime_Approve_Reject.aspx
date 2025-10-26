<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Employee_OverTime_Approve_Reject, App_Web_mrdzezyb" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

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
    &nbsp;<div class="bxmain">
        <asp:Panel ID="Panel_Leave" runat="server" Visible="True">
            <table cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
                <tr>
                    <td align="right" colspan="2" style="height: 15px">
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
                                <div id="p_info" class="patient-info" style="min-height: 20px; line-height: 22px">
                                    <ul style="margin-left: 10px">
                                        <li style="display: inline"><span class="age" style="display: inline"></span>Emp # &nbsp;<span
                                            class="reg"><strong><asp:Label ID="RegistrationNo" runat="server" Text='<%# Eval("EmpID") %>'
                                                ToolTip="Patient Registration Number"></asp:Label>
                                                ,<asp:Label ID="Designation_NameLabel" runat="server" Text='<%# Bind("Designation_Name") %>'></asp:Label></strong></span><span
                                                    class="splt">|</span> <span class="name-p">
                                                        <asp:Label ID="Label_EmpName" runat="server" Text='<%# Eval("[Employee Name]") %>'
                                                            ToolTip="Employee"></asp:Label>
                                                    </span><span class="relation">&nbsp;&nbsp;</span> <strong></strong><span class="splt">
                                                        | <span style="color: #333333">Join Date :</span></span> <span class="age" style="display: inline">
                                                            <asp:Label ID="Label_JoinDate" runat="server" Text='<%# Bind("JoinDate") %>' ToolTip="Patient Age"></asp:Label>
                                                            <span style="color: #a5a5a5">| </span><span style="color: #333333"></span>CNIC<span
                                                                class="splt"></span><asp:Label ID="Label_CNIC" runat="server" Text='<%# Eval("CNIC") %>'
                                                                    ToolTip="Identity Card No"></asp:Label><span style="color: #a5a5a5">|</span><span
                                                                        class="splt"></span>Gender :
                                                            <asp:Label ID="LabelGender" runat="server" Text='<%# Eval("Gender") %>' ToolTip="Patient Gender"></asp:Label></span>&nbsp;
                                        </li>
                                    </ul>
                                    &nbsp; &nbsp;
                                </div>
                                </SPAN>
                            </ItemTemplate>
                        </asp:FormView>
                    </td>
                </tr>
              <%--  <tr>
                    <td align="right" width="40%" style="height: 15px">
                        Leave :
                    </td>
                    <td width="60%" style="height: 15px">
                        <asp:DropDownList ID="DropDownList_Leave_Name" runat="server" DataSourceID="SqlDataSource_Leave_Type_Detail"
                            DataTextField="Leave_Name" DataValueField="Type_Detail_id" AutoPostBack="True"
                            Enabled="False">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="height: 18px">
                        Start Date :
                    </td>
                    <td style="height: 18px">
                        <igsch:WebDateChooser ID="WebDateChooser_Start_Date" runat="server" CssClass="drop_date">
                            <AutoPostBack ValueChanged="True" />
                            <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                        </igsch:WebDateChooser>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        End Date :
                    </td>
                    <td>
                        <igsch:WebDateChooser ID="WebDateChooser_End_Date" CssClass="drop_date" runat="server">
                            <AutoPostBack ValueChanged="True" />
                            <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                        </igsch:WebDateChooser>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Requested Leaves :
                    </td>
                    <td>
                        <asp:TextBox ID="TextBox_Requested_Leave" runat="server" Enabled="False" ReadOnly="True"
                            Width="31px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Leave Day :
                    </td>
                    <td>
                        <asp:TextBox ID="TextBox_Leave_Day" runat="server" Width="33px"></asp:TextBox>
                    </td>
                </tr>--%>
                <tr>
                    <td align="right" style="height: 18px">
                        Over Time :
                    </td>
                    <td style="height: 18px">
                        <asp:TextBox ID="txtBoxOverTime" runat="server" Width="60px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
            <td align="right" class="style1">
                <strong>Salary Month :</strong></td>
            <td>
                <asp:DropDownList ID="DDLMonth" runat="server"  Width="100px"></asp:DropDownList>
                  <%-- <igsch:webdatechooser id="WebDateChooser_Start_Date" runat="server" CssClass="drop_down">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:webdatechooser>
        <asp:HiddenField ID="HiddenField_Start_Date" runat="server" />--%>
           
                        <asp:DropDownList ID="DDLYear" runat="server"  Width="60px">
                            <asp:ListItem Value="2011">2011</asp:ListItem>
                            <asp:ListItem Value="2012">2012</asp:ListItem>
                            <asp:ListItem Value="2013">2013</asp:ListItem>
                            <asp:ListItem Value="2014">2014</asp:ListItem>
                            <asp:ListItem Value="2015">2015</asp:ListItem>
                            <asp:ListItem Value="2016">2016</asp:ListItem>
                            <asp:ListItem Value="2017">2017</asp:ListItem>
                            <asp:ListItem Value="2018">2018</asp:ListItem>
                            <asp:ListItem Value="2019">2019</asp:ListItem>
                            <asp:ListItem Value="2020">2020</asp:ListItem>
                            <asp:ListItem Value="2021">2021</asp:ListItem>
                            <asp:ListItem Value="2022">2022</asp:ListItem>

                        </asp:DropDownList>
                    </td>
        </tr>
                <tr>
                    <td align="right">
                        Reason :
                    </td>
                    <td>
                        <asp:TextBox ID="TextBox_Description" runat="server" Height="63px" TextMode="MultiLine"
                            Width="358px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:SqlDataSource ID="SqlDataSource_Leaves_For_Approval" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
                            ProviderName="<%$ ConnectionStrings:Leave_ManagementConnectionString.ProviderName %>"
                            SelectCommand="SELECT     CONVERT(varchar, Employee_Leaves.Start_Date, 103) + ' To ' + CONVERT(varchar, Employee_Leaves.End_Date, 103) + ' ' + CONVERT(Varchar, &#13;&#10;                      Employee_Leaves.Leave_Days) + ' Days ' + Leave_Type_Detail.Leave_Name + ' Leave' AS Leave, Employee_Leaves.Emp_Id, Employee_Leaves.Emp_Leave_Id&#13;&#10;FROM         Employee_Leaves INNER JOIN&#13;&#10;                      Leave_Type_Detail ON Employee_Leaves.Type_Detail_Id = Leave_Type_Detail.Type_Detail_id&#13;&#10;WHERE     (Employee_Leaves.is_Approved = 0)"
                            UpdateCommand="Update_Leave_Request" UpdateCommandType="StoredProcedure">
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
                                    PropertyName="Value" Type="Boolean" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:SqlDataSource ID="SqlDataSource_Leave_Type_Detail" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
                            SelectCommand="SELECT [Type_Detail_id], [Leave_Name] FROM [Leave_Type_Detail]">
                        </asp:SqlDataSource>
                    </td>
                    <td>
                        <asp:Button ID="Button_approve" runat="server" Text="Approve" />
                        <asp:Button ID="ButtonRejected" runat="server" Text="Rejected" />
                        <asp:Label ID="LBL_Message" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:HiddenField ID="HiddenField_Approved_Rejected" runat="server" />
        <asp:HiddenField ID="HiddenField_Emp_Leave_ID" runat="server" />
    </div>
    <br>
    <asp:SqlDataSource ID="SqlDataSource_Employee_Available" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Leave_ManagementConnectionString.ProviderName %>"
        SelectCommand="[Employee_Available_Leaves]" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="emp_ID" QueryStringField="Emp_ID" Type="Int32" />
            <asp:Parameter DefaultValue="0" Name="year" Type="Int32" />
            <asp:Parameter DefaultValue="0" Name="month" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Employee_Leaves" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
        DeleteCommand="DELETE FROM [Employee_Leaves] WHERE [Emp_Leave_Id] = @Emp_Leave_Id"
        InsertCommand="INSERT INTO Employee_Leaves(Emp_Id, Start_Date, End_Date, Leave_Days, Description, Type_Detail_Id, Office_Ins_Id, Salary_Day) VALUES (@Emp_Id, @Start_Date, @End_Date, @Leave_Days, @Description, @Type_Detail_Id, @Office_Ins_Id, @Salary_Day)"
        SelectCommand="SELECT Employee_Leaves.Emp_Leave_Id, Employee_Leaves.Emp_Id, Employee_Leaves.Start_Date, Employee_Leaves.End_Date, Employee_Leaves.Leave_Days, Employee_Leaves.Description, Employee_Leaves.Type_Detail_Id, Employee_Leaves.Office_Ins_Id, Leave_Type_Detail.Leave_Name, ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS [Employee Name] FROM Employee_Leaves INNER JOIN Leave_Type_Detail ON Employee_Leaves.Type_Detail_Id = Leave_Type_Detail.Type_Detail_id INNER JOIN Employee ON Employee_Leaves.Emp_Id = Employee.EmpID 
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
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td valign="top" width="50%">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_Employee_Available"
                    Visible="False" Width="98%" CssClass="Grid_1">
                    <Columns>
                        <asp:BoundField DataField="Leave_Type_Name" HeaderText="Leave Type" SortExpression="Leave_Type_Name" />
                        <asp:BoundField DataField="Leave_Name" HeaderText="Leave Name" SortExpression="Leave_Name" />
                        <asp:BoundField DataField="OneTime_MaxDays" HeaderText="Max At A Time" SortExpression="OneTime_MaxDays" />
                        <asp:BoundField DataField="Avail_Time_Limit" HeaderText="No of Times Avail" SortExpression="Avail_Time_Limit" />
                        <asp:BoundField DataField="Max_Days" HeaderText="Total Leaves" SortExpression="Max_Days" />
                        <asp:BoundField DataField="leave_Earned" HeaderText="leaves Earned" SortExpression="leave_Earned" />
                        <asp:BoundField DataField="Period_Id" HeaderText="Period" SortExpression="Period_Id" />
                    </Columns>
                    <RowStyle CssClass="GridItem" />
                    <FooterStyle CssClass="GridPager" />
                    <SelectedRowStyle CssClass="gridselect" />
                    <HeaderStyle CssClass="GridHeader" />
                    <EditRowStyle CssClass="gridedit" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
            </td>
            <td valign="top" width="50%">
                <asp:GridView ID="GridView6" runat="server" Width="100%" CssClass="Grid_1">
                    <RowStyle CssClass="GridItem" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
            </td>
        </tr>
    </table>
    <br />
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
    <asp:HiddenField ID="HiddenField_to_Date" runat="server" />
    <asp:HiddenField ID="HiddenField_From_Date" runat="server" />
    <br />
</asp:Content>
