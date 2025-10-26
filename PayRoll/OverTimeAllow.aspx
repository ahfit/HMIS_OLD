<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="PayRoll_OverTimeAllow, App_Web_tchaehmk" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .header
        {
            font-weight: bold;
            background: #E7E7E7;
            font-size: 20px;
        }
        .style1
        {
            width: 399px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain">
        <table cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
            <tr>
                <td>
                    <h2>
                        <span>
                            <asp:Label ID="lblAccountHead" runat="server" Text=""></asp:Label>
                        </span>
                    </h2>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Hospital :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_Hospital" runat="server" DataSourceID="SqlDataSource_Hospital"
                        DataTextField="Hospital_Name" DataValueField="Hospital_ID" AutoPostBack="True" 
                        onselectedindexchanged="DropDownList_SalaryHeads_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Hospital" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="SELECT     Hospital_ID, Hospital_Name
FROM         BasicDataInfo.dbo.Hospital">
                    </asp:SqlDataSource>
                </td>
            </tr>

            <tr>
                <td align="right">
                    Department :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_Department" runat="server" DataSourceID="SqlDataSource_Department"
                        DataTextField="Dept_Name" DataValueField="Dept_ID" AutoPostBack="True" 
                        onselectedindexchanged="DropDownList_SalaryHeads_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Department" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        
                        SelectCommand=" select 0 as Dept_ID, ' All' as Dept_Name union select Dept_ID, Dept_Name from Department where @HospitalId  = 0  or Hospital_ID = @HospitalId order by Dept_Name ">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownList_Hospital" DefaultValue="0" 
                                Name="HospitalId" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>

            <tr>
                <td align="right">
                    SalaryHead:
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_SalaryHeads" runat="server" DataSourceID="SqlDataSource_SalaryHead"
                        DataTextField="Head_Name" DataValueField="E_ID" AutoPostBack="True" 
                        onselectedindexchanged="DropDownList_SalaryHeads_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_SalaryHead" runat="server" ConnectionString="<%$ ConnectionStrings:PayRollConnectionString %>"
                        SelectCommand="select E_ID, Head_Name from Salary_Allowance_Deduction_Setup
where E_ID = 1675">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <td align="right">
                Salary Month :
            </td>
            <td>
                <asp:DropDownList ID="DropDownList_SalaryMonth" runat="server" 
                    AutoPostBack="True">
                    <asp:ListItem Value="1">January</asp:ListItem>
                    <asp:ListItem Value="2">February</asp:ListItem>
                    <asp:ListItem Value="3">March</asp:ListItem>
                    <asp:ListItem Value="4">April</asp:ListItem>
                    <asp:ListItem Value="5">May</asp:ListItem>
                    <asp:ListItem Value="6">Jun</asp:ListItem>
                    <asp:ListItem Value="7">July</asp:ListItem>
                    <asp:ListItem Value="8">August</asp:ListItem>
                    <asp:ListItem Value="9">September</asp:ListItem>
                    <asp:ListItem Value="10">October</asp:ListItem>
                    <asp:ListItem Value="11">November</asp:ListItem>
                    <asp:ListItem Value="12">December</asp:ListItem>
                </asp:DropDownList>
            </td>
            </tr>
            <tr>
                <td align="right">
                    Salary Year:
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_SalaryYear" runat="server" 
                        AutoPostBack="True">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Employee No :
                </td>
                <td>
                    <asp:TextBox ID="txtEmpID" runat="server" AutoPostBack="True" OnTextChanged="txtEmpID_TextChanged"></asp:TextBox>
                </td>
                <tr>
                    <td align="right">
                        Employee Name:
                    </td>
                    <td>
                        <asp:TextBox ID="txtEmployeeeName" runat="server" AutoPostBack="True" OnTextChanged="txtEmployeeeName_TextChanged"></asp:TextBox>
                        <asp:Label ID="lblMsg" runat="server" Font-Size="12px"></asp:Label>
                    </td>
                </tr>

                <tr>
                    <td align="right">
                        Search type :
                    </td>
                    <td>

                        <asp:RadioButtonList ID="RadioButtonList_SearchType" runat="server" 
                            AutoPostBack="True" Height="16px" 
                            onselectedindexchanged="RadioButtonList_SearchType_SelectedIndexChanged" 
                            Width="180px">
                            <asp:ListItem Value="1">Single</asp:ListItem>
                            <asp:ListItem Value="2">List</asp:ListItem>
                        </asp:RadioButtonList>

                    </td>
                </tr>
        </table>
    </div>
    <asp:GridView ID="GridView1" runat="server" ShowHeader="False" Width="100%" AutoGenerateColumns="False"
        DataSourceID="SqlDataSource1">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <table class="diagnosis_list">
                        <tr>
                            <td class="header" align="right">
                                Employee ID:
                            </td>
                            <td class="style1">
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("EmpID") %>' Font-Size="15px"></asp:Label>
                            </td>
                            <td class="header" align="right">
                                Name:
                            </td>
                            <td>
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("Name") %>' Font-Size="15px"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="header" align="right">
                                Join Date:
                            </td>
                            <td class="style1">
                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("JoinDate") %>' Font-Size="15px"></asp:Label>
                            </td>
                            <td class="header" align="right">
                                Designation:
                            </td>
                            <td>
                                <asp:Label ID="Label5" runat="server" Text='<%# Eval("Designation_Name") %>' 
                                    Font-Size="15px"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="header" align="right">
                                Department:
                            </td>
                            <td class="style1">
                                <asp:Label ID="Label4" runat="server" Font-Size="15px" 
                                    Text='<%# Eval("Dept_Name") %>'></asp:Label>
                            </td>
                            <td class="header" align="right">
                                Last Month Gross Amount:
                            </td>
                            <td>
                                <asp:Label ID="Label6" runat="server" Font-Size="15px" 
                                    Text='<%# Eval("Amount") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" class="header">
                                Over Time Days:</td>
                            <td class="style1">
                                <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Size="Larger" ForeColor="#FF0066" 
                                    Text='<%# Eval("TotalDays") %>'></asp:Label>
                            </td>
                            <td align="right" class="header">
                                Increment</td>
                            <td>
                                 <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Size="Larger" ForeColor="#FF0066" 
                                    Text='<%# Eval("Increment") %>'></asp:Label>
                                </td>
                        </tr>
                        <tr>
                            <td class="header" align="right">
                                Days of OverTime:</td>
                            <td class="style1">
                                <asp:TextBox ID="txtAllDedAmount0" runat="server" Font-Size="15px" 
                                     AutoPostBack="True" ontextchanged="txtAllDedAmount0_TextChanged" Width="50px" Text="0"></asp:TextBox> Days
                                <asp:TextBox ID="txtOverTimeHours" runat="server" Width="50px" Text="0" OnTextChanged="txtOverTimeHours_TextChanged" AutoPostBack="true"></asp:TextBox> Hours
                                <asp:HiddenField ID="hdfDiration" runat="server" Value ='<%# Eval("Duration") %>' />
                            </td>
                            <td class="header" align="right">
                                Amount</td>
                                
                            <td>
                                <asp:TextBox ID="txtAllDedAmount" runat="server" Font-Size="15px" TabIndex="0" 
                                    AutoPostBack="True" ontextchanged="txtAllDedAmount_TextChanged"></asp:TextBox>
                                <asp:HiddenField ID="HiddenField_Empid" runat="server"  Value='<%# Bind("EmpID") %>' />
                                <asp:HiddenField ID="HiddenField_Increment" runat="server"  Value='<%# Bind("Increment") %>' />
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource_HeadSelect" runat="server" ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>"
        SelectCommand="select E_ID, Head_Name from Salary_Allowance_Deduction_Setup where E_ID = @E_ID">
        <SelectParameters>
            <asp:QueryStringParameter Name="E_ID" QueryStringField="E_Id" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" CancelSelectOnNullParameter="False" runat="server"
        ConnectionString="<%$ ConnectionStrings:PayRollConnectionString %>" 
        SelectCommand="usp_SearchDataArrear" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_Empid" Name="Empid" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Name" Name="Name" PropertyName="Value" />
            <asp:ControlParameter ControlID="DropDownList_Department" Name="DeptID" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList_Hospital" Name="HospitalId" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Empid" runat="server" />
    <asp:HiddenField ID="HiddenField_Name" runat="server" />
    <div align="center">
        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
    </div>



    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="id"
        DataSourceID="SqlDataSource2" CssClass="Grid_1" Width="100%">
        <Columns>
            <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True"
                SortExpression="id" Visible="False" />
            <asp:BoundField DataField="EmpId" HeaderText="EmpId" SortExpression="EmpId" />
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
            <asp:BoundField DataField="Head_Name" HeaderText="Head Name" SortExpression="Head_Name" />
            <asp:BoundField DataField="Designation" HeaderText="Designation" SortExpression="Designation" />
            <asp:BoundField DataField="Department" HeaderText="Department" SortExpression="Department" />
            <asp:BoundField DataField="Month_Name" HeaderText="Month" SortExpression="Month_Name" />
            <asp:BoundField DataField="SalaryYear" HeaderText="SalaryYear" SortExpression="SalaryYear" />
            <asp:BoundField DataField="TotalDays" HeaderText="Days" SortExpression="TotalDays" />
            <asp:BoundField DataField="TotalHours" HeaderText="Total Hours" SortExpression="TotalHours" />
            
            <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" />
             
            <asp:BoundField DataField="EntryBy" HeaderText="EntryBy" SortExpression="EntryBy"
                Visible="False" />
            <asp:BoundField DataField="ApproveBy" HeaderText="ApproveBy" SortExpression="ApproveBy"
                Visible="False" />
            <asp:BoundField DataField="Remarks" HeaderText="Remarks" SortExpression="Remarks"
                Visible="False" />
            <asp:BoundField DataField="EntryDate" HeaderText="EntryDate" SortExpression="EntryDate"
                Visible="False" />
            <asp:BoundField DataField="ApproveStatus" HeaderText="ApproveStatus" SortExpression="ApproveStatus"
                Visible="False" />
            <asp:TemplateField HeaderText="Approve" ItemStyle-Width="5px" Visible="False">
                <HeaderTemplate>
                    <asp:CheckBox ID="chk" runat="server" AutoPostBack="True" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="chkApprove" Width="5px" runat="server" />
                    <asp:HiddenField ID="HiddenField_Empid" runat="server" Value='<%# Eval("EmpId") %>' />
                </ItemTemplate>
                <ItemStyle Width="5px"></ItemStyle>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:PayRollConnectionString %>"
        SelectCommand="SELECT     MonthlySalaryDetail.id, MonthlySalaryDetail.EmpId, Employee.Name, Salary_Allowance_Deduction_Setup.Head_Name, Employee.Designation, Employee.Department, 
                      Year_Months.Month_Name, MonthlySalaryDetail.SalaryYear, MonthlySalaryDetail.Amount, MonthlySalaryDetail.EntryBy, MonthlySalaryDetail.ApproveBy, MonthlySalaryDetail.Remarks, 
                      MonthlySalaryDetail.EntryDate, MonthlySalaryDetail.ApproveStatus,MonthlySalaryDetail.TotalDays,MonthlySalaryDetail.TotalHours
FROM         MonthlySalaryDetail INNER JOIN
                      Employee ON MonthlySalaryDetail.EmpId = Employee.EmpID INNER JOIN
                      Salary_Allowance_Deduction_Setup ON MonthlySalaryDetail.E_ID = Salary_Allowance_Deduction_Setup.E_ID
                      inner join Year_Months on Year_Months.Month_No = MonthlySalaryDetail.SalaryMonth
WHERE     (MonthlySalaryDetail.ApproveStatus = 0) and (MonthlySalaryDetail.E_ID = @E_ID) AND (MonthlySalaryDetail.SalaryMonth = @SalaryMonth) AND (MonthlySalaryDetail.SalaryYear = @SalaryYear)
Order by MonthlySalaryDetail.EntryDate desc,  Employee.EmpID, Employee.Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_SalaryHeads" Name="E_ID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownList_SalaryMonth" Name="SalaryMonth" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownList_SalaryYear" Name="SalaryYear" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

