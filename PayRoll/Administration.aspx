<%@ page language="C#" autoeventwireup="true" inherits="MasterPage, App_Web_tchaehmk" masterpagefile="~/hacims_masterpage_admin.master" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>
    <link href="../SpryAssets/SpryTabbedPanels.css" rel="stylesheet" type="text/css" />
    <script src="../css_hacims/ck.js" type="text/javascript"></script>
    <style type="text/css">
        .Grid_1 input
        {
            width: 9%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:PayRollConnectionString %>"
        ProviderName="<%$ ConnectionStrings:PayRollConnectionString.ProviderName %>"
        SelectCommand="SELECT Employee.* FROM Employee WHERE (EmpID = @EmpID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="EmpID" QueryStringField="Employee" />
        </SelectParameters>
    </asp:SqlDataSource>
    <table cellspacing="0" cellpadding="0" border="0" width="100%">
        <tr>
            <td>
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
                                                <asp:Label ID="RegistrationNo" runat="server" Text='<%# Eval("EmpNo") %>' ToolTip="Patient Registration Number"></asp:Label></strong>
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
                        <br />
                    </ItemTemplate>
                </asp:FormView>
                <asp:SqlDataSource ID="dsEmployeeInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                    SelectCommand="Emp_BioData" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="EmpID" QueryStringField="Employee" DefaultValue="0" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                <br />
                <asp:HyperLink ID="hlnkSalaryMainPage" runat="server" Text="Salary Main Page" 
                    NavigateUrl="~/Payroll/NewMakeSalaryPermananet.aspx"></asp:HyperLink>
                <br />
                <br />
                <div id="tabs_section">
                    <div id="TabbedPanels1" class="TabbedPanels">
                        <ul class="TabbedPanelsTabGroup">
                            <li class="TabbedPanelsTab" style="margin-left: 20px;">Bank Accounts </li>
                            <li class="TabbedPanelsTab">Personal Allowances </li>
                            <li class="TabbedPanelsTab">Deduction </li>
                            <li class="TabbedPanelsTab" style="display: none;">Loans </li>
                        </ul>
                        <div class="TabbedPanelsContentGroup" style="margin-top: -4px;">
                            <div class="TabbedPanelsContent">
                                <br />
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                    <ContentTemplate>
                                        <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                                            <tr>
                                                <td align="right" width="25%">
                                                    Branch Name :
                                                </td>
                                                <td width="25%">
                                                    <asp:DropDownList ID="DropDownList_Branch_Name" runat="server" DataSourceID="SqlDataSource3"
                                                        DataTextField="Branch_Name" DataValueField="Branch_ID" Width="182px">
                                                    </asp:DropDownList>
                                                </td>
                                                <td width="25%" align="right">
                                                    Purpose :
                                                </td>
                                                <td width="25%">
                                                    <asp:DropDownList ID="DropDownList_Purpose" runat="server" DataSourceID="SqlDataSource4"
                                                        DataTextField="Name" DataValueField="ID" Width="182px">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    Account Number :
                                                </td>
                                                <td colspan="3">
                                                    <asp:TextBox ID="TextBox_Account_Number" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
                                        <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" Width="100%"
                                            DataKeyNames="Emp_ID,For_Purpose_ID,Branch_ID" DataSourceID="SqlDataSource13">
                                            <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
                                            <Columns>
                                                <asp:BoundField DataField="Name" HeaderText="Branch Name" SortExpression="Name" />
                                                <asp:BoundField DataField="Text" HeaderText="For Purpose" SortExpression="Text" />
                                                <asp:BoundField DataField="Account_Number" HeaderText="Account Number" SortExpression="Account_Number" />
                                                <asp:TemplateField ShowHeader="False">
                                                    <EditItemTemplate>
                                                        <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images/icon_ok.png" />
                                                        <asp:ImageButton ID="ImageButton4" runat="server" CommandName="Cancel" ImageUrl="~/images/icon_err.gif" />
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        &nbsp;<asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/images/icon_edit.png"
                                                            OnClientClick="return confirm('are you sure you want To Edit ?');" />
                                                        <asp:ImageButton ID="ImageButton2" runat="server" CommandName="Delete" ImageUrl="~/images/icon_delete.png"
                                                            OnClientClick="return confirm('are you sure you want To delete ?');" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <RowStyle CssClass="GridItem" />
                                            <HeaderStyle CssClass="GridHeader" />
                                            <AlternatingRowStyle CssClass="GridAltItem" />
                                        </asp:GridView>
                                        <asp:SqlDataSource ID="SqlDataSource13" runat="server" ConnectionString="<%$ ConnectionStrings:PayRollConnectionString %>"
                                            DeleteCommand="DELETE FROM [Bank_Accounts] WHERE [Emp_ID] = @Emp_ID AND [For_Purpose_ID] = @For_Purpose_ID"
                                            InsertCommand="INSERT INTO [Bank_Accounts] ([Emp_ID], [Branch_ID], [For_Purpose_ID], [Account_Number]) VALUES (@Emp_ID, @Branch_ID, @For_Purpose_ID, @Account_Number)"
                                            SelectCommand="SELECT     Bank_Accounts.Emp_ID, Bank_Accounts.Branch_ID, Bank_Accounts.For_Purpose_ID, Bank_Accounts.Account_Number,  Bank_Deffination.Name + ' ( ' + Bank_Branch.Branch_Name + ' )' AS Name, Account_for_Purpose.Text FROM         Bank_Accounts INNER JOIN  Account_for_Purpose ON Bank_Accounts.For_Purpose_ID = Account_for_Purpose.ID INNER JOIN   Bank_Branch ON Bank_Accounts.Branch_ID = Bank_Branch.Branch_ID INNER JOIN   Bank_Deffination ON Bank_Branch.Bank_ID = Bank_Deffination.Code WHERE (Bank_Accounts.Emp_ID = @Emp_ID)"
                                            UpdateCommand="UPDATE [Bank_Accounts] SET [Branch_ID] = @Branch_ID, [Account_Number] = @Account_Number WHERE [Emp_ID] = @Emp_ID AND [For_Purpose_ID] = @For_Purpose_ID">
                                            <DeleteParameters>
                                                <asp:Parameter Name="Emp_ID" Type="Int32" />
                                                <asp:Parameter Name="For_Purpose_ID" Type="Int32" />
                                            </DeleteParameters>
                                            <UpdateParameters>
                                                <asp:Parameter Name="Branch_ID" Type="Int32" />
                                                <asp:Parameter Name="Account_Number" Type="String" />
                                                <asp:Parameter Name="Emp_ID" Type="Int32" />
                                                <asp:Parameter Name="For_Purpose_ID" Type="Int32" />
                                            </UpdateParameters>
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="Emp_ID" QueryStringField="Employee" Type="Int32" />
                                            </SelectParameters>
                                            <InsertParameters>
                                                <asp:Parameter Name="Emp_ID" Type="Int32" />
                                                <asp:Parameter Name="Branch_ID" Type="Int32" />
                                                <asp:Parameter Name="For_Purpose_ID" Type="Int32" />
                                                <asp:Parameter Name="Account_Number" Type="String" />
                                            </InsertParameters>
                                        </asp:SqlDataSource>
                                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:PayRollConnectionString %>"
                                            InsertCommand="[Bank_Account_Insertion]" InsertCommandType="StoredProcedure"
                                            ProviderName="<%$ ConnectionStrings:PayRollConnectionString.ProviderName %>">
                                            <InsertParameters>
                                                <asp:QueryStringParameter Name="Emp" QueryStringField="Employee" Type="Int32" />
                                                <asp:ControlParameter ControlID="DropDownList_Branch_Name" Name="Branch" PropertyName="SelectedValue"
                                                    Type="Int32" />
                                                <asp:ControlParameter ControlID="DropDownList_Purpose" Name="For_Purpose" PropertyName="SelectedValue"
                                                    Type="Int32" />
                                                <asp:ControlParameter ControlID="TextBox_Account_Number" Name="Account_Number" PropertyName="Text"
                                                    Type="String" />
                                                <asp:ControlParameter ControlID="HiddenField_UsedFor" Name="Used_For" PropertyName="Value"
                                                    Type="String" />
                                            </InsertParameters>
                                        </asp:SqlDataSource>
                                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:PayRollConnectionString %>"
                                            ProviderName="<%$ ConnectionStrings:PayRollConnectionString.ProviderName %>"
                                            SelectCommand="SELECT Bank_Deffination.Code AS ID, Bank_Branch.Branch_Code, Bank_Branch.Branch_Name, Bank_Branch.Branch_ID FROM Bank_Deffination INNER JOIN Bank_Branch ON Bank_Deffination.Code = Bank_Branch.Bank_ID ORDER BY Bank_Deffination.Name">
                                        </asp:SqlDataSource>
                                        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:PayRollConnectionString %>"
                                            ProviderName="<%$ ConnectionStrings:PayRollConnectionString.ProviderName %>"
                                            SelectCommand="SELECT ID, Text AS Name FROM Account_for_Purpose"></asp:SqlDataSource>
                                        <asp:HiddenField ID="HiddenField_UsedFor" runat="server" />
                                        <asp:HiddenField ID="HiddenField_AccountNumer" runat="server" />
                                        <asp:SqlDataSource ID="SqlDataSource_Employee_Salary_Attendance" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                                            SelectCommand="SELECT Employee.EFName, Employee_Salary_Attendance.Machine_Attendance, Employee_Salary_Attendance.Other_Attendance, Employee_Salary_Attendance.Deducted, Employee_Salary_Attendance.Leave, Employee_Salary_Attendance.Over_Time, Employee_Salary_Attendance.Holy_day, Employee_Salary_Attendance.Working_Day, Employee_Salary_Attendance.Public_Holy_Day FROM Employee_Salary_Attendance INNER JOIN Employee ON Employee_Salary_Attendance.Emp_ID = Employee.EmpID WHERE (Employee_Salary_Attendance.Salary_Month = MONTH(GETDATE())) AND (Employee_Salary_Attendance.Salary_Year = YEAR(GETDATE())) AND (Employee.EmpID = @EmpID)">
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="EmpID" QueryStringField="employee" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <asp:SqlDataSource ID="SqlDataSource_Salary" runat="server" ConnectionString="<%$ ConnectionStrings:PayRollConnectionString %>"
                                            DeleteCommand="delete_salary" DeleteCommandType="StoredProcedure" InsertCommand="make_salary"
                                            InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:PayRollConnectionString.ProviderName %>"
                                            SelectCommand="select_salary" SelectCommandType="StoredProcedure">
                                            <DeleteParameters>
                                                <asp:QueryStringParameter Name="Employee" QueryStringField="Employee" Type="Int32" />
                                                <asp:ControlParameter ControlID="HiddenField_Salary_ID" Name="Salary_ID" PropertyName="Value"
                                                    Type="String" />
                                            </DeleteParameters>
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="Employee" QueryStringField="Employee" Type="Int32" />
                                            </SelectParameters>
                                            <InsertParameters>
                                                <asp:QueryStringParameter Name="Employee" QueryStringField="Employee" Type="Int32" />
                                                <asp:ControlParameter ControlID="HiddenField_Salary_ID" Name="Salary_ID" PropertyName="Value"
                                                    Type="String" />
                                                <asp:ControlParameter ControlID="TextBox_Total_Salary" Name="Basic_Salary" PropertyName="Text"
                                                    Type="Int32" />
                                            </InsertParameters>
                                        </asp:SqlDataSource>
                                        <asp:HiddenField ID="HiddenField_Salary_ID" runat="server" />
                                        <asp:SqlDataSource ID="SqlDataSource10" runat="server" ConnectionString="<%$ ConnectionStrings:PayRollConnectionString %>"
                                            DeleteCommand="DELETE FROM [Allowances] WHERE [Emp_ID] = @Emp_ID AND [E_ID] = @E_ID"
                                            InsertCommand="INSERT INTO [Allowances] ([Emp_ID], [A_Code], [Amount]) VALUES (@Emp_ID, @A_Code, @Amount)"
                                            SelectCommand=" SELECT Allowances.Emp_ID, Allowances.E_ID, Allowances.Amount,  C.Head_Name E_Name 
                                                            FROM Allowances 
                                                            Left Join Salary_Allowance_Deduction_Setup 
                                                            C On Allowances.E_ID = C.E_ID WHERE (Allowances.Emp_ID = @Emp_ID)and C.Allowance_Deduction='Allowance'  Order By C.Sort_Order

															 "
                                            UpdateCommand="UPDATE [Allowances] SET [Amount] = @Amount WHERE [Emp_ID] = @Emp_ID AND [E_ID] = @E_ID">
                                            <DeleteParameters>
                                                <asp:Parameter Name="Emp_ID" Type="Int32" />
                                                <asp:Parameter Name="E_ID" />
                                            </DeleteParameters>
                                            <UpdateParameters>
                                                <asp:Parameter Name="Amount" Type="Double" />
                                                <asp:Parameter Name="Emp_ID" Type="Int32" />
                                                <asp:Parameter Name="E_ID" />
                                            </UpdateParameters>
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="Emp_ID" QueryStringField="Employee" Type="Int32" />
                                            </SelectParameters>
                                            <InsertParameters>
                                                <asp:Parameter Name="Emp_ID" Type="Int32" />
                                                <asp:Parameter Name="A_Code" Type="Int32" />
                                                <asp:Parameter Name="Amount" Type="Double" />
                                            </InsertParameters>
                                        </asp:SqlDataSource>
                                        <asp:SqlDataSource ID="SqlDataSource12" runat="server" ConnectionString="<%$ ConnectionStrings:PayRollConnectionString %>"
                                            DeleteCommand="DELETE FROM [Deductions] WHERE [Emp_ID] = @Emp_ID AND [D_Code] = @D_Code"
                                            InsertCommand="INSERT INTO [Deductions] ([Emp_ID], [D_Code], [Amount], [Start_Date], [End_Date]) VALUES (@Emp_ID, @D_Code, @Amount, @Start_Date, @End_Date)"
                                            SelectCommand="SELECT Deductions.Emp_ID, Deductions.D_Code, Deductions.Amount, Deductions.Start_Date, 
Deductions.End_Date, Expenditure.Head_Name AS D_Name, 
Deductions.Formula_ID, PayRoll_Formula.Formula_Name
FROM         Deductions INNER JOIN
                   Salary_Allowance_Deduction_Setup Expenditure    ON Deductions.D_Code = Expenditure.E_ID LEFT OUTER JOIN
                      PayRoll_Formula ON Deductions.Formula_ID = PayRoll_Formula.Formula_ID
WHERE     (Deductions.Emp_ID = @Emp_ID)" UpdateCommand="UPDATE [Deductions] SET [Amount] = @Amount, [Start_Date] = @Start_Date, [End_Date] = @End_Date WHERE [Emp_ID] = @Emp_ID AND [D_Code] = @D_Code">
                                            <DeleteParameters>
                                                <asp:Parameter Name="Emp_ID" Type="Int32" />
                                                <asp:Parameter Name="D_Code" Type="Int32" />
                                            </DeleteParameters>
                                            <UpdateParameters>
                                                <asp:Parameter Name="Amount" Type="Double" />
                                                <asp:Parameter Name="Start_Date" Type="DateTime" />
                                                <asp:Parameter Name="End_Date" Type="DateTime" />
                                                <asp:Parameter Name="Emp_ID" Type="Int32" />
                                                <asp:Parameter Name="D_Code" Type="Int32" />
                                            </UpdateParameters>
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="Emp_ID" QueryStringField="Employee" Type="Int32" />
                                            </SelectParameters>
                                            <InsertParameters>
                                                <asp:Parameter Name="Emp_ID" Type="Int32" />
                                                <asp:Parameter Name="D_Code" Type="Int32" />
                                                <asp:Parameter Name="Amount" Type="Double" />
                                                <asp:Parameter Name="Start_Date" Type="DateTime" />
                                                <asp:Parameter Name="End_Date" Type="DateTime" />
                                            </InsertParameters>
                                        </asp:SqlDataSource>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <div align="center">
                                    <asp:Button ID="Button1" runat="server" Text="Save" OnClick="Button1_Click" Width="51px" />
                                    <asp:Label ID="lblMSgACN" runat="server" Font-Bold="True"></asp:Label>
                                </div>
                                <br />
                            </div>
                            <div class="TabbedPanelsContent">
                                <br />
                                <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                    <ContentTemplate>
                                        <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                                            <tr>
                                                <td align="right" width="20%">
                                                    Expenditure Sub Head :
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="DropDownList_Sub_ESH_name" runat="server" AutoPostBack="True"
                                                        DataSourceID="SqlDataSource_sub_ESH" DataTextField="ESH_Name" DataValueField="ESH_Code"
                                                        Visible="False" Width="90%">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:PayRollConnectionString %>"
                                            InsertCommand="Allowance_Insert" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:PayRollConnectionString.ProviderName %>">
                                            <InsertParameters>
                                                <asp:QueryStringParameter Name="Emp_ID" QueryStringField="Employee" Type="Int32" />
                                                <asp:ControlParameter ControlID="HiddenField_E_ID" Name="E_ID" PropertyName="Value" />
                                                <asp:ControlParameter ControlID="HiddenField_Amount" Name="Amount" PropertyName="Value"
                                                    Type="Int32" />
                                            </InsertParameters>
                                        </asp:SqlDataSource>
                                        <asp:SqlDataSource ID="SqlDataSource_E_Code" runat="server" ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>"
                                            SelectCommand=" Select B.E_ID,B.Head_Name E_Name,B.E_ID E_Code,NULL As Formula_ID From Salary_Allowance_Deduction_Setup B Where B.Allowance_Deduction = 'Allowance' Order By Sort_Order ">
                                        </asp:SqlDataSource>
                                        <br />
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td valign="top" width="50%">
                                                    <asp:GridView ID="GridView6" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_E_Code"
                                                        CssClass="Grid_1" Width="100%" OnSelectedIndexChanged="GridView6_SelectedIndexChanged"
                                                        DataKeyNames="E_ID" EnableModelValidation="True">
                                                        <Columns>
                                                            <asp:BoundField DataField="E_Name" HeaderText="Allowance" SortExpression="E_Name" />
                                                            <asp:TemplateField HeaderText="Amount">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="TextBox4" runat="server" Width="200px" OnTextChanged="TextBox4_TextChanged"
                                                                        AutoPostBack="True"></asp:TextBox><br />
                                                                    <asp:HiddenField ID="HiddenField_E_ID" runat="server" Value='<%# Eval("E_ID", "{0}") %>' />
                                                                    <asp:HiddenField ID="HiddenField_formula" runat="server" Value='<%# Eval("Formula_ID", "{0}") %>' />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                    <asp:HiddenField ID="HiddenField_E_ID" runat="server" />
                                                    <asp:HiddenField ID="HiddenField_Amount" runat="server" />
                                                    <asp:SqlDataSource ID="SqlDataSource_sub_ESH" runat="server" ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>"
                                                        SelectCommand="SELECT ESH_Code, ESH_Name, EH_Code FROM Expenditure_Sub_Heading WHERE (ESH_Code = 6502)">
                                                    </asp:SqlDataSource>
                                                    <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:PayRollConnectionString %>"
                                                        ProviderName="<%$ ConnectionStrings:PayRollConnectionString.ProviderName %>"
                                                        SelectCommand="Allow_Allowance_List" SelectCommandType="StoredProcedure">
                                                        <SelectParameters>
                                                            <asp:QueryStringParameter Name="Emp_ID" QueryStringField="employee" Type="Int32" />
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                </td>
                                                <td valign="top" width="50%">
                                                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" Width="100%"
                                                        CssClass="Grid_1" DataKeyNames="Emp_ID,E_ID" DataSourceID="SqlDataSource10" OnPreRender="GridView2_PreRender"
                                                        OnSelectedIndexChanged="GridView2_SelectedIndexChanged">
                                                        <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
                                                        <Columns>
                                                            <asp:BoundField DataField="E_Name" HeaderText="Allowance Name" ReadOnly="True" SortExpression="E_Name" />
                                                            <asp:TemplateField HeaderText="Amount" SortExpression="Amount">
                                                                <ItemTemplate>
                                                                    <%--<asp:Label ID="Label1" runat="server" Text='<%# Bind("Amount") %>'></asp:Label>--%>
                                                                    <asp:TextBox ID="TextBox_Amount" Width="200px" runat="server" Text='<%# Bind("Amount") %>'></asp:TextBox>
                                                                    <asp:HiddenField ID="HiddenField_E_ID" runat="server" Value='<%# Eval("E_ID", "{0}") %>' />
                                                                    <asp:HiddenField ID="HiddenField_Amount" runat="server" Value='<%# Eval("Amount") %>' />
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Amount") %>'></asp:TextBox>
                                                                </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ShowHeader="False">
                                                                <EditItemTemplate>
                                                                    <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images/updatebtn.png"
                                                                        Height="11px" Width="10" />
                                                                    &nbsp;<asp:ImageButton ID="ImageButton4" runat="server" CommandName="Cancel" ImageUrl="~/images/deletebtn.png"
                                                                        Width="10px" Height="11px" />
                                                                </EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/images/editbtn.png"
                                                                        Width="10px" Height="11px" OnClientClick="return confirm('are you sure you want To Edit ?');" />&nbsp;
                                                                    <asp:ImageButton ID="ImageButton2" runat="server" CommandName="Delete" ImageUrl="~/images/deletebtn.png"
                                                                        Width="10px" Height="11px" OnClientClick="return confirm('are you sure you want To delete ?');" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <RowStyle CssClass="GridItem" />
                                                        <HeaderStyle CssClass="GridHeader" />
                                                        <AlternatingRowStyle CssClass="GridAltItem" />
                                                    </asp:GridView>
                                                    <br />
                                                    <div align="center">
                                                        <asp:Button ID="Btn_Allowance" runat="server" OnClick="Btn_Allowance_Click" Text="Add Allowances"
                                                            Visible="False" /></div>
                                                    <br />
                                                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Width="100%"
                                                        CssClass="Grid_1" DataKeyNames="Emp_ID,E_ID" DataSourceID="SqlDataSource10" Visible="False">
                                                        <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
                                                        <Columns>
                                                            <asp:BoundField DataField="Emp_ID" HeaderText="Emp_ID" ReadOnly="True" SortExpression="Emp_ID" />
                                                            <asp:BoundField DataField="E_ID" HeaderText="E_ID" ReadOnly="True" SortExpression="E_ID" />
                                                            <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" />
                                                            <asp:BoundField DataField="E_Name" HeaderText="E_Name" SortExpression="E_Name" />
                                                        </Columns>
                                                        <RowStyle CssClass="GridItem" />
                                                        <HeaderStyle CssClass="GridHeader" />
                                                        <AlternatingRowStyle CssClass="GridAltItem" />
                                                    </asp:GridView>
                                                    <br />
                                                    <div align="center">
                                                        <asp:Button ID="Button7" runat="server" OnClick="Button7_Click" Text="Month Allowances"
                                                            Visible="False" /></div>
                                                </td>
                                            </tr>
                                        </table>
                                        <asp:SqlDataSource ID="SqlDataSource_allowance_Salary" runat="server" ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>"
                                            DeleteCommand="DELETE FROM [Allowance_Salary] WHERE [Emp_ID] = @Emp_ID AND [E_ID] = @E_ID AND [S_Month] = @S_Month AND [S_Year] = @S_Year"
                                            InsertCommand="INSERT INTO [Allowance_Salary] ([Emp_ID], [E_ID], [S_Month], [S_Year], [Amount]) VALUES (@Emp_ID, @E_ID, @S_Month, @S_Year, @Amount)"
                                            SelectCommand="SELECT Allowance_Salary.Emp_ID, Allowance_Salary.E_ID, Allowance_Salary.S_Month, Allowance_Salary.S_Year, Allowance_Salary.Amount, Expenditure.E_Name FROM Allowance_Salary INNER JOIN Expenditure ON Allowance_Salary.E_ID = Expenditure.E_ID WHERE (Allowance_Salary.S_Month = MONTH(GETDATE())) AND (Allowance_Salary.S_Year = YEAR(GETDATE())) AND (Allowance_Salary.Emp_ID = @emp)"
                                            UpdateCommand="UPDATE [Allowance_Salary] SET [Amount] = @Amount WHERE [Emp_ID] = @Emp_ID AND [E_ID] = @E_ID AND [S_Month] = @S_Month AND [S_Year] = @S_Year">
                                            <DeleteParameters>
                                                <asp:Parameter Name="Emp_ID" Type="Int32" />
                                                <asp:Parameter Name="E_ID" Type="Int32" />
                                                <asp:Parameter Name="S_Month" Type="Int32" />
                                                <asp:Parameter Name="S_Year" Type="Int32" />
                                            </DeleteParameters>
                                            <UpdateParameters>
                                                <asp:Parameter Name="Amount" Type="Int32" />
                                                <asp:Parameter Name="Emp_ID" Type="Int32" />
                                                <asp:Parameter Name="E_ID" Type="Int32" />
                                                <asp:Parameter Name="S_Month" Type="Int32" />
                                                <asp:Parameter Name="S_Year" Type="Int32" />
                                            </UpdateParameters>
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="emp" QueryStringField="Employee" />
                                            </SelectParameters>
                                            <InsertParameters>
                                                <asp:QueryStringParameter Name="Emp_ID" QueryStringField="Employee" />
                                                <asp:ControlParameter ControlID="HiddenField_S_E_ID" Name="E_ID" PropertyName="Value" />
                                                <asp:ControlParameter ControlID="HiddenField_Month" Name="S_Month" PropertyName="Value" />
                                                <asp:ControlParameter ControlID="HiddenField_Year" Name="S_Year" PropertyName="Value" />
                                                <asp:ControlParameter ControlID="HiddenField_S_Amount" Name="Amount" PropertyName="Value" />
                                            </InsertParameters>
                                        </asp:SqlDataSource>
                                        <asp:HiddenField ID="HiddenField_S_E_ID" runat="server" />
                                        <asp:HiddenField ID="HiddenField_S_Amount" runat="server" />
                                        <asp:HiddenField ID="HiddenField_Month" runat="server" />
                                        <asp:HiddenField ID="HiddenField_Year" runat="server" />
                                        <br />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <asp:HiddenField ID="HiddenField_Dept_ID" runat="server" />
                                <div align="center">
                                    <asp:Button ID="Button2" runat="server" Text="Save" OnClick="Button2_Click" /><br />
                                </div>
                                <asp:HiddenField ID="HiddenField_Emp_ID" runat="server" />
                            </div>
                            <div class="TabbedPanelsContent">
                                <br />
                                <asp:UpdatePanel ID="UpdatePanel3" runat="server" RenderMode="Inline">
                                    <ContentTemplate>
                                        <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                                            <tr>
                                                <td align="right" width="25%">
                                                    Deduction :
                                                </td>
                                                <td width="25%">
                                                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource7"
                                                        DataTextField="E_Name" DataValueField="ID" Width="292px" AutoPostBack="True"
                                                        OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                </td>
                                                <td width="25%" align="right">
                                                    Amount :
                                                </td>
                                                <td width="25%">
                                                    <asp:TextBox ID="TextBox1" runat="server" CssClass="input_txt"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    Start Date :
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="TextBox_start_date_dd" runat="server" MaxLength="2" Width="30px"></asp:TextBox>
                                                    /
                                                    <asp:TextBox ID="TextBox_start_Date_mm" runat="server" MaxLength="2" Width="33px"></asp:TextBox>
                                                    /
                                                    <asp:TextBox ID="TextBox_start_date_yyyy" runat="server" MaxLength="4" Width="53px"></asp:TextBox>
                                                    <span class="dim">dd/mm/yyyy</span>
                                                </td>
                                                <td align="right">
                                                    End Date :
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="TextBox_End_date_dd" runat="server" MaxLength="2" Width="30px"></asp:TextBox>
                                                    /
                                                    <asp:TextBox ID="TextBox_end_Date_mm" runat="server" MaxLength="2" Width="33px"></asp:TextBox>
                                                    /
                                                    <asp:TextBox ID="TextBox_end_date_yyyy" runat="server" MaxLength="4" Width="53px"></asp:TextBox>
                                                    <span class="dim">dd/mm/yyyy</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    Formula :
                                                </td>
                                                <td>
                                                </td>
                                                <td align="right">
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
                                        <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                        </asp:UpdatePanel>
                                        <asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:PayRollConnectionString %>"
                                            ProviderName="<%$ ConnectionStrings:PayRollConnectionString.ProviderName %>"
                                            SelectCommand="Select B.Head_Name E_Name,CONVERT (varchar, B.E_ID) + '-0' ID 
From Salary_Allowance_Deduction_Setup B 
Where B.Allowance_Deduction = 'Deduction'"
                                            InsertCommand="deduction_insertion" InsertCommandType="StoredProcedure">
                                            <InsertParameters>
                                                <asp:QueryStringParameter Name="Emp_ID" QueryStringField="employee" Type="Int32" />
                                                <asp:ControlParameter ControlID="HiddenField_head" Name="Deduction" PropertyName="Value" />
                                                <asp:ControlParameter ControlID="TextBox1" Name="Amount" PropertyName="Text" Type="Double" />
                                                <asp:ControlParameter ControlID="HiddenField_start_Date" Name="Start_Date" PropertyName="Value" />
                                                <asp:ControlParameter ControlID="HiddenField_end_date" Name="End_Date" PropertyName="Value" />
                                                <asp:ControlParameter ControlID="HiddenField_formula" Name="Formula_ID" PropertyName="Value"
                                                    Type="Int32" />
                                            </InsertParameters>
                                        </asp:SqlDataSource>
                                        <asp:HiddenField ID="HiddenField_head" runat="server" />
                                        <asp:HiddenField ID="HiddenField_formula" runat="server" />
                                        <asp:SqlDataSource ID="SqlDataSource_formula" runat="server" ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>"
                                            SelectCommand="SELECT Formula_ID, Formula_Name FROM PayRoll_Formula UNION SELECT NULL AS Expr1, '' AS Expr2">
                                        </asp:SqlDataSource>
                                        <asp:HiddenField ID="HiddenField_start_Date" runat="server" />
                                        <asp:HiddenField ID="HiddenField_end_date" runat="server" />
                                        <br />
                                        <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" Width="100%"
                                            CssClass="Grid_1" DataKeyNames="Emp_ID,D_Code" DataSourceID="SqlDataSource12"
                                            OnPreRender="GridView4_PreRender" EnableModelValidation="True">
                                            <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
                                            <Columns>
                                                <asp:BoundField DataField="D_Name" ReadOnly="True" HeaderText="Deduction" SortExpression="D_Name" />
                                                <asp:TemplateField HeaderText="Amount" SortExpression="Amount">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Amount") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Amount") %>' Visible="False"></asp:Label>
                                                        <asp:TextBox ID="TextBox_Amount" runat="server" Text='<%# Bind("Amount") %>' Width="85px"></asp:TextBox>
                                                        <asp:HiddenField ID="HiddenField_D_Code" runat="server" Value='<%# Bind("D_Code") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="Start_Date" HeaderText="Start Date" SortExpression="Start_Date" />
                                                <asp:BoundField DataField="End_Date" HeaderText="End Date" SortExpression="End_Date" />
                                                <asp:TemplateField HeaderText="Formula Name" SortExpression="Formula_Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Formula_Name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:DropDownList ID="DropDownList_formula" runat="server" DataSourceID="SqlDataSource_formula"
                                                            DataTextField="Formula_Name" DataValueField="Formula_ID" SelectedValue='<%# Bind("Formula_ID", "{0}") %>'
                                                            Width="200px">
                                                        </asp:DropDownList>
                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField ShowHeader="False" Visible="False">
                                                    <EditItemTemplate>
                                                        <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images/icon_ok.png" />
                                                        <asp:ImageButton ID="ImageButton4" runat="server" CommandName="Cancel" ImageUrl="~/images/icon_err.gif" />
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/images/icon_edit.png"
                                                            OnClientClick="return confirm('are you sure you want To Edit ?');" />
                                                        <asp:ImageButton ID="ImageButton2" runat="server" CommandName="Delete" ImageUrl="~/images/icon_delete.png"
                                                            OnClientClick="return confirm('are you sure you want To delete ?');" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:CommandField ShowDeleteButton="True" />
                                            </Columns>
                                            <RowStyle CssClass="GridItem" />
                                            <HeaderStyle CssClass="GridHeader" />
                                            <AlternatingRowStyle CssClass="GridAltItem" />
                                        </asp:GridView>
                                        <div align="center">
                                            <br />
                                            <asp:Button ID="Button_Update_Deductions" runat="server" Text="Save Deductions" OnClick="Button_Update_Deductions_Click" /></div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <div align="center">
                                    <br />
                                    <asp:Button ID="Button3" runat="server" Text="Save" OnClick="Button3_Click1" /></div>
                            </div>
                            <div class="TabbedPanelsContent" style="display: none;">
                                <br />
                                <asp:UpdatePanel ID="UpdatePanel4" runat="server" Visible="false">
                                    <ContentTemplate>
                                        <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                                            <tr>
                                                <td width="25%" align="right">
                                                    Loan :
                                                </td>
                                                <td width="25%">
                                                    <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource8"
                                                        DataTextField="E_Name" DataValueField="E_ID" Width="90%">
                                                    </asp:DropDownList>
                                                </td>
                                                <td width="25%" align="right">
                                                    Amount :
                                                </td>
                                                <td width="25%">
                                                    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    Sanction Date :
                                                </td>
                                                <td>
                                                    <igsch:WebDateChooser ID="WebDateChooser3" runat="server">
                                                        <CalendarLayout Culture="English (United Kingdom)">
                                                        </CalendarLayout>
                                                    </igsch:WebDateChooser>
                                                </td>
                                                <td align="right">
                                                    Time Period :
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="TextBox_Time_period" runat="server">
                                                    </asp:TextBox>
                                                    <asp:Label ID="Label_Month" runat="server" Text="Month">
                                                    </asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    Interest Rate :
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="TextBox_Interest_Rate" runat="server"></asp:TextBox>
                                                    %
                                                </td>
                                                <td align="right">
                                                    Pay to Party :
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="DropDownList_Pay_to_Party" runat="server" Width="90%" DataSourceID="SqlDataSource_Pay_to_party"
                                                        DataTextField="Party_Name" DataValueField="Party_Id">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    Head :
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="DropDownList_Head" runat="server" DataSourceID="SqlDataSource_Account_Head_For_Loan"
                                                        DataTextField="E_Name" Width="90%" DataValueField="E_ID">
                                                    </asp:DropDownList>
                                                </td>
                                                <td align="right">
                                                    Start Date :
                                                </td>
                                                <td>
                                                    <igsch:WebDateChooser ID="WebDateChooser_Start_Date" runat="server">
                                                        <CalendarLayout Culture="English (United Kingdom)">
                                                        </CalendarLayout>
                                                    </igsch:WebDateChooser>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    Current Balance :
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label_Current_Balance" runat="server">
                                                    </asp:Label>
                                                </td>
                                                <td align="right">
                                                    Total Installment :
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="TextBox_Total_Installment" runat="server">
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
                                        <div align="center">
                                            <asp:Label ID="Label2" runat="server" Text="Label" Visible="False"></asp:Label>
                                        </div>
                                        <br />
                                        <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" Width="100%"
                                            CssClass="Grid_1" DataKeyNames="Loan_Id" DataSourceID="SqlDataSource11" OnPreRender="GridView3_PreRender"
                                            OnRowEditing="GridView3_RowEditing" OnSelectedIndexChanged="GridView3_SelectedIndexChanged">
                                            <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
                                            <Columns>
                                                <asp:ButtonField CommandName="Select" DataTextField="L_Name" HeaderText="Loan" />
                                                <asp:BoundField DataField="Sanction_Date" HeaderText="Sanction Date" SortExpression="Sanction_Date"
                                                    ReadOnly="True" />
                                                <asp:BoundField DataField="Recovery_Date" HeaderText="Recovery Date" SortExpression="Recovery_Date"
                                                    ReadOnly="True" />
                                                <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" ReadOnly="True" />
                                                <asp:BoundField DataField="Amount_Per_Month" HeaderText="Amount Per Month" SortExpression="Amount_Per_Month"
                                                    ReadOnly="True" />
                                                <asp:TemplateField ShowHeader="False">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="ImageButton2" runat="server" CommandName="Delete" ImageUrl="~/images/icon_delete.png"
                                                            OnClientClick="return confirm('are you sure you want To delete ?');" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="ImageButton5" runat="server" CommandName="Edit" ImageUrl="~/images/icon_edit.png"
                                                            OnClientClick="return confirm('are you sure you want To Edit ?');" />
                                                        <asp:HiddenField ID="HiddenField_Emp_ID" runat="server" Value='<%# Eval("Emp_ID", "{0}") %>' />
                                                        <asp:HiddenField ID="HiddenField_Loan_ID" runat="server" Value='<%# Eval("Loan_Id") %>' />
                                                        <asp:HiddenField ID="HiddenField_Amount" runat="server" Value='<%# Eval("Amount", "{0}") %>' />
                                                        <asp:HiddenField ID="HiddenField_Sanction_Date" runat="server" Value='<%# Eval("Sanction_Date", "{0}") %>' />
                                                        <asp:HiddenField ID="HiddenField_Loan_Code" runat="server" Value='<%# Eval("Loan_Code", "{0}") %>' />
                                                        <asp:HiddenField ID="HiddenField_Start_Date" runat="server" Value='<%# Eval("Start_Date") %>' />
                                                        <asp:HiddenField ID="HiddenField_Interest_Rate" runat="server" Value='<%# Eval("Interest_Rate") %>' />
                                                        <asp:HiddenField ID="HiddenField_Pay_To_Party" runat="server" Value='<%# Eval("Pay_To_Party") %>' />
                                                        <asp:HiddenField ID="HiddenField_Pay_To_Head" runat="server" Value='<%# Eval("Pay_To_Head") %>' />
                                                        <asp:HiddenField ID="HiddenField_Time_period" runat="server" Value='<%# Eval("Ins_TimePeriod_Month") %>' />
                                                        <asp:HiddenField ID="HiddenField_Recovery_Date" runat="server" Value='<%# Eval("Recovery_Date") %>' />
                                                        <asp:HiddenField ID="HiddenField_Total_Installment" runat="server" Value='<%# Eval("Total_Installment", "{0}") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <RowStyle CssClass="GridItem" />
                                            <HeaderStyle CssClass="GridHeader" />
                                            <AlternatingRowStyle CssClass="GridAltItem" />
                                        </asp:GridView>
                                        <br />
                                        <asp:GridView ID="GridView8" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
                                            DataSourceID="SqlDataSource_Loan_Installments" OnPreRender="GridView3_PreRender"
                                            Width="100%">
                                            <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
                                            <Columns>
                                                <asp:BoundField DataField="For Month" HeaderText="For Month" SortExpression="For Month" />
                                                <asp:BoundField DataField="Installment Date" HeaderText="Installment Date" SortExpression="Installment Date" />
                                                <asp:BoundField DataField="Total Amount" HeaderText="Total Amount" SortExpression="Total Amount" />
                                                <asp:BoundField DataField="Principal Amount" HeaderText="Principal Amount" SortExpression="Principal Amount" />
                                                <asp:BoundField DataField="Interest" HeaderText="Interest" SortExpression="Interest" />
                                                <asp:BoundField DataField="Installment" HeaderText="Installment" SortExpression="Installment" />
                                                <asp:BoundField DataField="Balance" HeaderText="Balance" SortExpression="Balance" />
                                                <asp:BoundField DataField="Paid" HeaderText="Paid" SortExpression="Paid" />
                                            </Columns>
                                            <RowStyle CssClass="GridItem" />
                                            <HeaderStyle CssClass="GridHeader" />
                                            <AlternatingRowStyle CssClass="GridAltItem" />
                                        </asp:GridView>
                                        <asp:HiddenField ID="HiddenField_Loan_Code" runat="server" />
                                        <asp:HiddenField ID="HiddenField_Loan_ID" runat="server" />
                                        <br />
                                        <asp:SqlDataSource ID="SqlDataSource_Loan_Installments" runat="server" ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>"
                                            SelectCommand="SELECT DATENAME(month, Loan_Installments.Ins_Last_Date) + '-' + CONVERT (varchar, DATEPART(yyyy, Loan_Installments.Ins_Last_Date)) AS [For Month], Loan_Installments.Ins_Last_Date AS [Installment Date], Loans.Amount AS [Total Amount], Loan_Installments.Principal_Amount AS [Principal Amount], Loan_Installments.Interest, Loan_Installments.Principal_Amount + Loan_Installments.Interest AS Installment, Loan_Installments.Late_Fee, Loan_Installments.Paid, Loan_Installments.Balance FROM Loan_Installments INNER JOIN Loans ON Loan_Installments.Loan_Id = Loans.Loan_Id INNER JOIN Expenditure ON Loans.Loan_Code = Expenditure.E_ID WHERE (Loans.Loan_Code = @Loan_Code)">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="HiddenField_Loan_Code" Name="Loan_Code" PropertyName="Value" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <asp:SqlDataSource ID="SqlDataSource8" runat="server" ConnectionString="<%$ ConnectionStrings:PayRollConnectionString %>"
                                            InsertCommand="loan_insertion&#13;&#10;" InsertCommandType="StoredProcedure"
                                            ProviderName="<%$ ConnectionStrings:PayRollConnectionString.ProviderName %>"
                                            SelectCommand="SELECT E_Name, E_ID, E_Code FROM Expenditure WHERE (ESH_Code = '1340')">
                                            <InsertParameters>
                                                <asp:QueryStringParameter Name="Emp_ID" QueryStringField="Employee" Type="Int32" />
                                                <asp:ControlParameter ControlID="DropDownList2" Name="Loan_Code" PropertyName="SelectedValue"
                                                    Type="Int32" />
                                                <asp:ControlParameter ControlID="HiddenField_sensation_Date" Name="Sensation_Date"
                                                    PropertyName="Value" Type="DateTime" />
                                                <asp:ControlParameter ControlID="HiddenField_loan_recovery_date" Name="Recovery_Date"
                                                    PropertyName="Value" Type="DateTime" />
                                                <asp:ControlParameter ControlID="TextBox2" Name="Amount" PropertyName="Text" Type="Double" />
                                                <asp:ControlParameter ControlID="TextBox3" Name="Amount_Per_Month" PropertyName="Text"
                                                    Type="Double" />
                                            </InsertParameters>
                                        </asp:SqlDataSource>
                                        <asp:HiddenField ID="HiddenField_Amount_Per_Month" runat="server" />
                                        <asp:HiddenField ID="HiddenField_Recovery_Date" runat="server" />
                                        <asp:SqlDataSource ID="SqlDataSource_Pay_to_party" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                            SelectCommand="SELECT [Party_Id], [Party_Name] FROM [Parties]"></asp:SqlDataSource>
                                        <asp:SqlDataSource ID="SqlDataSource_Account_Head_For_Loan" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                                            SelectCommand="SELECT [E_Code], [E_Name], [E_ID] FROM [Expenditure]"></asp:SqlDataSource>
                                        <asp:SqlDataSource ID="SqlDataSource9" runat="server" ConnectionString="<%$ ConnectionStrings:PayRollConnectionString %>"
                                            InsertCommand="Loan_Insertion" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:PayRollConnectionString.ProviderName %>"
                                            UpdateCommand="Loan_Update_Insertion" UpdateCommandType="StoredProcedure">
                                            <UpdateParameters>
                                                <asp:ControlParameter ControlID="DropDownList2" Name="Loan_Code" PropertyName="SelectedValue"
                                                    Type="Int32" />
                                                <asp:ControlParameter ControlID="HiddenField_sensation_Date" Name="Sanction_Date"
                                                    PropertyName="Value" Type="DateTime" />
                                                <asp:ControlParameter ControlID="HiddenField_Recovery_Date" Name="Recovery_Date"
                                                    PropertyName="Value" Type="DateTime" />
                                                <asp:ControlParameter ControlID="TextBox2" Name="Amount" PropertyName="Text" Type="Double" />
                                                <asp:ControlParameter ControlID="TextBox_Interest_Rate" Name="Interest_Rate" PropertyName="Text"
                                                    Type="Double" />
                                                <asp:ControlParameter ControlID="TextBox2" Name="Current_Balance" PropertyName="Text"
                                                    Type="Double" />
                                                <asp:ControlParameter ControlID="TextBox_Time_period" Name="Ins_TimePeriod_Month"
                                                    PropertyName="Text" Type="Int32" />
                                                <asp:ControlParameter ControlID="DropDownList_Pay_to_Party" Name="Pay_To_Party" PropertyName="SelectedValue"
                                                    Type="Decimal" />
                                                <asp:ControlParameter ControlID="DropDownList_Head" Name="Pay_To_Head" PropertyName="SelectedValue"
                                                    Type="Decimal" />
                                                <asp:ControlParameter ControlID="DropDownList2" Name="Load_Type" PropertyName="SelectedItem.text"
                                                    Type="String" />
                                                <asp:ControlParameter ControlID="HiddenField_loan_recovery_date" Name="Start_Date"
                                                    PropertyName="Value" Type="DateTime" />
                                                <asp:ControlParameter ControlID="TextBox_Total_Installment" Name="Total_Installment"
                                                    PropertyName="Text" Type="Int32" />
                                                <asp:ControlParameter ControlID="HiddenField_Loan_ID" Name="Loan_ID" PropertyName="Value"
                                                    Type="Int32" />
                                                <asp:ControlParameter ControlID="HiddenField_Amount_Per_Month" Name="Amount_Per_Month"
                                                    PropertyName="Value" Type="Double" />
                                            </UpdateParameters>
                                            <InsertParameters>
                                                <asp:QueryStringParameter Name="Emp_ID" QueryStringField="Employee" />
                                                <asp:ControlParameter ControlID="DropDownList2" Name="Loan_Code" PropertyName="SelectedValue" />
                                                <asp:ControlParameter ControlID="HiddenField_Recovery_Date" Name="Recovery_Date"
                                                    PropertyName="Value" />
                                                <asp:ControlParameter ControlID="TextBox2" Name="Amount" PropertyName="Text" />
                                                <asp:ControlParameter ControlID="HiddenField_sensation_Date" Name="Sanction_Date"
                                                    PropertyName="Value" />
                                                <asp:ControlParameter ControlID="TextBox_Interest_Rate" Name="Interest_Rate" PropertyName="Text" />
                                                <asp:ControlParameter ControlID="TextBox2" Name="Current_Balance" PropertyName="Text" />
                                                <asp:ControlParameter ControlID="TextBox_Time_period" Name="Ins_TimePeriod_Month"
                                                    PropertyName="Text" />
                                                <asp:ControlParameter ControlID="DropDownList_Pay_to_Party" Name="Pay_To_Party" PropertyName="SelectedValue" />
                                                <asp:ControlParameter ControlID="DropDownList_Head" Name="Pay_To_Head" PropertyName="SelectedValue" />
                                                <asp:ControlParameter ControlID="DropDownList2" Name="Load_Type" PropertyName="SelectedItem.text" />
                                                <asp:ControlParameter ControlID="HiddenField_loan_recovery_date" Name="Start_Date"
                                                    PropertyName="Value" />
                                                <asp:ControlParameter ControlID="HiddenField_Amount_Per_Month" Name="Amount_Per_Month"
                                                    PropertyName="Value" />
                                                <asp:ControlParameter ControlID="TextBox_Total_Installment" Name="Total_Installment"
                                                    PropertyName="Text" Type="Int32" />
                                            </InsertParameters>
                                        </asp:SqlDataSource>
                                        <asp:HiddenField ID="HiddenField_sensation_Date" runat="server" />
                                        <asp:HiddenField ID="HiddenField_loan_recovery_date" runat="server" />
                                        <asp:SqlDataSource ID="SqlDataSource11" runat="server" ConnectionString="<%$ ConnectionStrings:PayRollConnectionString %>"
                                            DeleteCommand="DELETE FROM [Loans] WHERE  [Loan_ID] = @Loan_ID" InsertCommand="INSERT INTO [Loans] ([Emp_ID], [Loan_Code], [Sensation_Date], [Recovery_Date], [Amount], [Amount_Per_Month]) VALUES (@Emp_ID, @Loan_Code, @Sensation_Date, @Recovery_Date, @Amount, @Amount_Per_Month)"
                                            SelectCommand="SELECT Loans.Emp_ID, Loans.Loan_Code, CONVERT (varchar, Loans.Sanction_Date, 103) AS Sanction_Date, CONVERT (varchar, Loans.Recovery_Date, 103) AS Recovery_Date, Loans.Amount, Loans.Amount_Per_Month, Expenditure.E_Name AS L_Name, Loans.Interest_Rate, Loans.Current_Balance, Loans.Ins_TimePeriod_Month, Loans.Pay_To_Party, Loans.Pay_To_Head, Loans.Load_Type, Loans.Start_Date, DATEDIFF(mm, Loans.Start_Date, Loans.Recovery_Date) / Loans.Ins_TimePeriod_Month AS Total_Installment, Loans.Loan_Id FROM Loans INNER JOIN Expenditure ON Loans.Loan_Code = Expenditure.E_ID WHERE (Loans.Emp_ID = @Emp_ID)"
                                            UpdateCommand="UPDATE [Loans] SET  [Amount] = @Amount, [Amount_Per_Month] = @Amount_Per_Month WHERE [Emp_ID] = @Emp_ID AND [Loan_Code] = @Loan_Code">
                                            <DeleteParameters>
                                                <asp:Parameter Name="Loan_ID" />
                                            </DeleteParameters>
                                            <UpdateParameters>
                                                <asp:Parameter Name="Amount" Type="Double" />
                                                <asp:Parameter Name="Amount_Per_Month" Type="Double" />
                                                <asp:Parameter Name="Emp_ID" Type="Int32" />
                                                <asp:Parameter Name="Loan_Code" Type="Int32" />
                                            </UpdateParameters>
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="Emp_ID" QueryStringField="Employee" Type="Int32" />
                                            </SelectParameters>
                                            <InsertParameters>
                                                <asp:Parameter Name="Emp_ID" Type="Int32" />
                                                <asp:Parameter Name="Loan_Code" Type="Int32" />
                                                <asp:Parameter Name="Sensation_Date" Type="DateTime" />
                                                <asp:Parameter Name="Recovery_Date" Type="DateTime" />
                                                <asp:Parameter Name="Amount" Type="Double" />
                                                <asp:Parameter Name="Amount_Per_Month" Type="Double" />
                                            </InsertParameters>
                                        </asp:SqlDataSource>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <div align="center">
                                    <asp:Button ID="Button4" runat="server" Text="Save" OnClick="Button4_Click1" Visible="False" />
                                    <asp:Button ID="Button_Update" runat="server" Text="Update" OnClick="Button_Update_Click"
                                        Visible="False" /><br />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
    </table>
    <br />
    <script type="text/javascript">
        var cookies = Spry.Utils.Cookie("read", "tabbedpanels_emp1");
        var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1", { defaultTab: cookies ? parseFloat(cookies) : 0 });
        Spry.Utils.addUnLoadListener(function () {
            Spry.Utils.Cookie('create', 'tabbedpanels_emp1', TabbedPanels1.getCurrentTabIndex());
        });
    </script>
</asp:Content>
