<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Employee_Leaves_Individual.aspx.vb"
    MasterPageFile="~/hacims_masterpage_admin.master" Inherits="Leave_Management_Employee_Leaves_Individual" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    &nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Panel ID="Panel_diary" runat="server" Width="100%">
    </asp:Panel>
    <asp:Panel Width="100%" ID="Panel1" runat="server">
        <div class="bxmain">
            <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                <tr>
                    <td align="right" width="40%">
                        Department Name :
                    </td>
                    <td>
                        <asp:DropDownList ID="Dropdownlistdepartment" runat="server" AutoPostBack="True"
                            DataSourceID="SqlDataSourceDepartment" DataTextField="Dept_Name" DataValueField="Dept_ID"
                            TabIndex="5">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                            SelectCommand="SELECT [Dept_Name], [Dept_ID] FROM [Department] ORDER BY [Dept_Name]">
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Sub Department Name :
                    </td>
                    <td>
                        <asp:DropDownList ID="DropDownList_desg" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_desg"
                            DataTextField="SubDept_Name" DataValueField="SubDept_Id" TabIndex="5">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource_desg" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                            SelectCommand="SELECT SubDept_Id, SubDept_Name FROM SubDepartment WHERE (Dept_Id = @deptId)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="deptId" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSource_Employee" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                            SelectCommand="SELECT EmpID, ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS [Employee Name], Is_Deleted FROM Employee WHERE (DeptID = @deptId) AND (SubDeptId = @SubDeptId) AND (Is_Deleted = 0) ORDER BY [Employee Name]">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="DeptID" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="DropDownList_desg" Name="SubDeptId" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="height: 18px">
                        Employee Name :
                    </td>
                    <td style="height: 18px">
                        <asp:DropDownList ID="DropDownListEmployee" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_Employee"
                            DataTextField="Employee Name" DataValueField="EmpID">
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
        </div>
    </asp:Panel>
    <asp:SqlDataSource ID="dsEmployeeInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="Emp_BioData" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_EmpId" Name="EmpID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td valign="top">
                <asp:FormView ID="FormView1" runat="server" DataKeyNames="EmpID" DataSourceID="dsEmployeeInfo"
                    HorizontalAlign="Left" Width="100%">
                    <ItemTemplate>
                        <div class="bxinset radius4">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td valign="top" width="100" align="center">
                                        <asp:Image ID="Image2" runat="server" ImageUrl=' <%# Convert.ToString("~/DisplayPic.ashx?Emp_Id=") + Convert.ToString(Eval("EmpID")) %>'
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
    </table>
    <asp:HiddenField ID="HiddenField_EmpId" runat="server" />
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
            <td valign="top">
                <div class="bxmain" style="width: 98%;">
                    <table cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
                        <tr>
                            <td align="right" width="25%">
                                Leave :
                            </td>
                            <td>
                                <asp:DropDownList ID="DropDownList_Leave_Name" runat="server" DataSourceID="SqlDataSource_Leave_Type_Detail"
                                    DataTextField="Leave_Name" DataValueField="Type_Detail_id" AutoPostBack="True"
                                    Width="202px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="25%">
                                Leave Category:</td>
                            <td>
                                <asp:DropDownList ID="DropDownList_L_Sub_Cat" runat="server"
                                    Width="202px" AutoPostBack="True">
                                    <asp:ListItem Selected="True" Value="1">Full Leave Day</asp:ListItem>
                                    <asp:ListItem Value="2">Short Leave Day</asp:ListItem>
                                     <asp:ListItem Value="3">Half Leave Day</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Start Date :
                            </td>
                            <td>
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
                                Leave Day :
                            </td>
                            <td>
                                <asp:TextBox ID="TextBox_Leave_Day" Enabled="false" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Salary Day :
                            </td>
                            <td>
                                <asp:TextBox ID="TextBox_Salary_Day" Enabled="false" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Description :
                            </td>
                            <td>
                                <asp:TextBox ID="TextBox_Description" runat="server" Height="63px" TextMode="MultiLine"
                                    Width="300px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                            </td>
                            <td>
                                <asp:Button ID="Button1" runat="server" Text="Save" />
                                <asp:Label ID="lblMsg" runat="server" Font-Size="X-Large" ForeColor="Red"></asp:Label>
                            </td>
                        </tr>
                    </table>
            </td>
            <td valign="top" width="35%">
                <asp:Button ID="btnSelectAll" runat="server" Text="Select All" />
                <br />
                <br />
                <div style="border-style: solid; border-width: 1px; height: 230px; overflow-x: hidden; overflow-y: auto;">
                    <asp:CheckBoxList ID="CheckBoxList_Dates_Of_Leaves" runat="server" AutoPostBack="True" >
                    </asp:CheckBoxList>
                    <br />
                    <asp:SqlDataSource ID="SqlDataSource_DateSelect" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
                        SelectCommand="usp_WorkingDaysFind" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="HiddenField_StartDate" Name="StartDate" PropertyName="Value"
                                Type="DateTime" />
                            <asp:ControlParameter ControlID="HiddenField_EndDate" Name="EndDate" PropertyName="Value"
                                Type="DateTime" />
                            <asp:SessionParameter Name="Dept_Id" SessionField="Dept_Id" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <br />
                    <asp:HiddenField ID="HiddenField_StartDate" runat="server" />
                    <asp:HiddenField ID="HiddenField_EndDate" runat="server" />
                    <asp:HiddenField ID="HiddenField_LeaveDate" runat="server" />
                    <asp:HiddenField ID="HiddenField_LeaveID" runat="server" />
                </div>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SqlDataSource_Employee_Available" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Leave_ManagementConnectionString.ProviderName %>"
        SelectCommand="Employee_Available_Leaves" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_EmpId" Name="emp_ID" PropertyName="Value"
                Type="Int32" />
            <asp:Parameter DefaultValue="0" Name="year" Type="Int32" />
            <asp:Parameter DefaultValue="0" Name="month" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Leave_Type_Detail" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
        SelectCommand="Select Leave_Type_Detail.Leave_Name,Leave_Type_Detail.Type_Detail_id,Leave_Types.Leave_Type_Name
From Leave_Type_Detail
INNER JOIN Leave_Types ON Leave_Type_Detail.Leave_Type_id = Leave_Types.Leave_Type_Id " InsertCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_EmpId" Name="EmpID" PropertyName="Value"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <%--<asp:SqlDataSource ID="SqlDataSource_Leave_Type_Detail" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
        
        
        SelectCommand="SELECT DISTINCT Leave_Type_Detail.Leave_Name, Leave_Type_Detail.Type_Detail_id, Leave_Types.Leave_Type_Name, Hospital.Hospital_Name FROM Employee_Leave_Balance INNER JOIN Leave_Type_Detail ON Employee_Leave_Balance.Leave_detail_type_id = Leave_Type_Detail.Type_Detail_id INNER JOIN Leave_Types ON Leave_Type_Detail.Leave_Type_id = Leave_Types.Leave_Type_Id INNER JOIN Hospital ON Leave_Types.Hospital_ID = Hospital.Hospital_ID WHERE (Employee_Leave_Balance.Emp_id = @EmpID) AND (Leave_Types.Hospital_ID = @Hospital_ID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_EmpId" Name="EmpID" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="dropdownlist_Hospital" Name="Hospital_ID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>--%>
    <asp:SqlDataSource ID="SqlDataSource_Employee_Leaves" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
        DeleteCommand="
DELETE FROM Employee_Leaves WHERE (Emp_Leave_Id = @Emp_Leave_Id) 

DELETE FROM tbl_Employee_Leave_Detail
WHERE     (Emp_Leave_id = @Emp_Leave_Id)"
        InsertCommand="Insert_Leave_Request" SelectCommand="Emp_Leave_Info" UpdateCommand="UPDATE [Employee_Leaves] SET [Emp_Id] = @Emp_Id, [Start_Date] = @Start_Date, [End_Date] = @End_Date, [Leave_Days] = @Leave_Days, [Description] = @Description, [Type_Detail_Id] = @Type_Detail_Id, [Office_Ins_Id] = @Office_Ins_Id WHERE [Emp_Leave_Id] = @Emp_Leave_Id"
        SelectCommandType="StoredProcedure" InsertCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_EmpId" Name="Emp_ID" PropertyName="Value" />
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
            <asp:ControlParameter ControlID="HiddenField_EmpId" Name="Emp_Id" PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_From_Date" Name="Start_Date" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_to_Date" Name="End_Date" PropertyName="Value" />
            <asp:ControlParameter ControlID="TextBox_Description" Name="Description" PropertyName="Text" />
            <asp:ControlParameter ControlID="DropDownList_Leave_Name" Name="Type_Detail_Id" PropertyName="SelectedValue" />
            <asp:Parameter DefaultValue="1" Name="Office_Ins_Id" Type="Int32" />
            <asp:ControlParameter ControlID="TextBox_Leave_Day" Name="Requested_Days" PropertyName="Text"
                Type="Decimal" />
            <asp:Parameter Name="id" DefaultValue="1" Direction="InputOutput" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList_L_Sub_Cat" 
                Name="Leave_Sub_Category" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="Leave_Days" Type="Double" />
            <asp:Parameter Name="Salary_Day" Type="Double" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_InsertLeaveDetail" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
        InsertCommand="[usp_InsertEmployeeLeaveDetail]" InsertCommandType="StoredProcedure"
        SelectCommand="SELECT id, Emp_Leave_id, Emp_id, Leave_Date, Leave_Detail_Type_Id, Shift__Id FROM tbl_Employee_Leave_Detail">
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenField_EmpId" Name="Emp_id" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_LeaveID" Name="Emp_Leave_id" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_LeaveDate" Name="Leave_Date" PropertyName="Value"
                Type="DateTime" />
            <asp:ControlParameter ControlID="DropDownList_Leave_Name" Name="Leave_Detail_Type_Id"
                PropertyName="SelectedValue" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Balance" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
        SelectCommand="usp_LeaveBalance" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_EmpId" Name="empid" PropertyName="Value"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDs_CheckEmpAttendance" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" 
        SelectCommand="uspIsEmployeeAttendanceMarked" 
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="Emp_Id" Type="Int32" />
            <asp:Parameter Name="For_Day" Type="DateTime" />
            <asp:Parameter Direction="InputOutput" Name="AttendanceMarked" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="hfldAttendanceMarked" Value="N" runat="server" />
    <br />
    <div>
        <h2>
            <span >Leave
           
            </span></h2>
        <p>
            <span></span>&nbsp;</p>
        <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataKeyNames="Emp_Leave_Id"
            DataSourceID="SqlDataSource_Employee_Leaves" Width="100%" OnRowDataBound="GridView4_RowDataBound"
            AllowPaging="True">
            <Columns>
                <asp:BoundField DataField="Employee_Name" HeaderText="Employee Name" SortExpression="Employee_Name" />
                
                                   <asp:TemplateField HeaderText="Leave Name" SortExpression="Leave_Name">
                             
                                <ItemTemplate>
                                    <asp:Label ID="lblLeave_Name" runat="server" Text='<%# Bind("Leave_Name") %>'></asp:Label>
                                   
                                </ItemTemplate>
                            </asp:TemplateField>
                               <asp:TemplateField HeaderText="Start Date" SortExpression="Start_Date">
                             
                                <ItemTemplate>
                                    <asp:Label ID="lblStart_Date" runat="server" Text='<%# Eval("Start_Date", "{0:dd-MMM-yyyy}")%>' ></asp:Label>
                                   
                                </ItemTemplate>
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="End Date" SortExpression="End_Date">
                             
                                <ItemTemplate>
                                    <asp:Label ID="lblEnd_Date" runat="server" Text='<%# Eval("End_Date", "{0:dd-MMM-yyyy}")%>' ></asp:Label>
                                   
                                </ItemTemplate>
                            </asp:TemplateField>

                <asp:BoundField DataField="Leave_Days" HeaderText="Leaves Requested" SortExpression="Leave_Days" />
                <asp:BoundField DataField="Description" HeaderText="Reason for Leave" SortExpression="Description" />
                <asp:TemplateField HeaderText="Delete">
                    <ItemTemplate>
                        <asp:LinkButton Visible="false" ID="lb_delete" runat="server" CausesValidation="False" 
                              Text="Delete" onclick="lb_delete_Click"></asp:LinkButton>
                        <br />
                        <asp:HiddenField ID="hf_e_l_id" runat="server" 
                            Value='<%# Eval("Emp_Leave_Id") %>' />
                            <asp:HiddenField ID="hf_status" runat="server" 
                            Value='<%# Eval("is_approved") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:HyperLinkField DataNavigateUrlFields="Emp_Leave_Id,Emp_Id" DataNavigateUrlFormatString="Employee_Leaves_Detail.aspx?Emp_Leave_Id={0}&amp;Emp_Id={1}"
                    Text="Detail" Visible="False" />
                <asp:TemplateField HeaderText="Approve / Reject">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click" 
                            Text="Approve / Reject" 
                            CommandArgument='<%# Eval("Emp_Leave_Id") %>' 
                            Visible="false"></asp:LinkButton>
                        <asp:Label ID="Label1" runat="server" ForeColor="#FF0066" 
                            Text='<%# Eval("CBExpression") %>'></asp:Label>
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
    <div align="right" width="100%">
        <asp:Button ID="btn_return" runat="server" Text="Return Back" />
    </div>
    <br />
    <asp:HiddenField ID="HiddenField_to_Date" runat="server" />
    <asp:Panel ID="Panel2" runat="server" CssClass = "lightbox" Visible = "false" ><%--CssClass = "lightbox"--%>
        <table cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
            <tr>
                <td align="right" colspan="2" style="height: 15px">
                    <asp:SqlDataSource ID="dsEmployeeInfo0" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                            SelectCommand="Emp_BioData" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="EmpID" QueryStringField="Emp_Id" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right" width="40%" style="height: 15px">
                    Leave :
                </td>
                <td width="60%" style="height: 15px">
                    <asp:DropDownList ID="DropDownList_Leave_Name0" runat="server" DataSourceID="SqlDataSource_Leave_Type_Detail0"
                            DataTextField="Leave_Name" DataValueField="Type_Detail_id" AutoPostBack="True"
                            Enabled="False">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" style="height: 15px" width="40%">
                    Leave Category:</td>
                <td style="height: 15px" width="60%">
                    <asp:DropDownList ID="DropDownList_L_Sub_Cat0" runat="server" Width="202px">
                        <asp:ListItem Selected="True" Value="1">Full Leave Day</asp:ListItem>
                        <asp:ListItem Value="2">Short Leave Day</asp:ListItem>
                          <asp:ListItem Value="3">Half Leave Day</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" style="height: 18px">
                    Start Date :
                </td>
                <td style="height: 18px">
                    <igsch:WebDateChooser ID="WebDateChooser_Start_Date0" runat="server" 
                            CssClass="drop_date">
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
                    <igsch:WebDateChooser ID="WebDateChooser_End_Date0" CssClass="drop_date" 
                            runat="server">
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
                    <asp:TextBox ID="TextBox_Leave_Day0" runat="server" Width="33px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right" style="height: 18px">
                    Salary Day :
                </td>
                <td style="height: 18px">
                    <asp:TextBox ID="TextBox_Salary_Day0" runat="server" Width="33px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Reason :
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
                            UpdateCommand="Update_Leave_Request1" 
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
                            <asp:ControlParameter ControlID="DropDownList_L_Sub_Cat0" Name="Recommend_Id" 
                                PropertyName="SelectedValue" Type="Int32" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:SqlDataSource ID="SqlDataSource_Leave_Type_Detail0" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
                            
                            
                        SelectCommand="SELECT [Type_Detail_id], [Leave_Name] FROM [Leave_Type_Detail]">
                    </asp:SqlDataSource>
                </td>
                <td>
                    <asp:Button ID="Button_approve" runat="server" Text="Approve" />
                    <asp:Button ID="ButtonRejected" runat="server" Text="Rejected" />
                    <asp:Button ID="buttonCancel" runat="server" Text="Cancel" />
                    <asp:Label ID="LBL_Message" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
    </asp:Panel>

    <asp:Panel ID="pnl_app_delete" runat="server" Width ="350px" Visible = "false" CssClass = "lightbox">
    
                   <span class = "h1"> <h3>Remarks to Delete Approved Leave</h3></span>
                   <asp:TextBox id = "txt_delete" runat ="server" TextMode ="MultiLine" Height = "150px" Width ="300"></asp:TextBox>
                   <asp:Label ID = "lbl_dele_msg" runat ="server" ForeColor = "Red"></asp:Label>
                   <asp:HiddenField ID ="hf_el_id" runat = "server" />
                   <div width ="100%" align ="center" >
                   
                   <asp:Button ID="btn_del" runat="server" Text="Delete" />
                                &nbsp;&nbsp;&nbsp;
                                <asp:Button ID="Btn_Cancel" runat="server" Text="Cancel" />
                    </div> 
        <asp:SqlDataSource ID="sds_record" runat="server" 
                       ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>" 
                       InsertCommand="insert_approved_delete_rec" InsertCommandType="StoredProcedure" 
                       ProviderName="<%$ ConnectionStrings:Leave_ManagementConnectionString.ProviderName %>">
            <InsertParameters>
                <asp:SessionParameter Name="Deleted_By" SessionField="emp_id" Type="Int32" />
                <asp:QueryStringParameter Name="Emp_ID" QueryStringField="Emp_ID" Type="Int32" />
                <asp:ControlParameter ControlID="txt_delete" Name="remarks" PropertyName="Text" 
                    Type="String" />
                <asp:ControlParameter ControlID="hf_el_id" Name="emp_leave_ID" 
                    PropertyName="Value" Type="Int32" />
            </InsertParameters>
                   </asp:SqlDataSource>
                    
                    </asp:Panel>
        <asp:HiddenField ID="HiddenField_Emp_Leave_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_to_Date0" runat="server" />
    <asp:HiddenField ID="HiddenField_From_Date0" runat="server" />
    
    <asp:HiddenField ID="HiddenField_Approved_Rejected" runat="server" />
    <asp:HiddenField ID="HiddenField_Emp_Leave_ID0" runat="server" />
    
    <br />
        <asp:SqlDataSource ID="SqlDataSource_Company" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
            SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"></asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_From_Date" runat="server" />
    <asp:HiddenField runat="server" ID="hdfFinalMinDate" />
     <asp:HiddenField runat="server" ID="hdfFinalMaxDate" />
    <br />
</asp:Content>
