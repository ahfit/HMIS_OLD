<%@ page title="" language="C#" masterpagefile="~/Hacims_MasterPage_Admin_New.master" autoeventwireup="true" inherits="CreateLogin, App_Web_m54ycrm1" enableeventvalidation="false" theme="theme_hacims" viewstateencryptionmode="Never" maintainscrollpositiononpostback="true" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        
        .lightbox
        {
            background: #F0F8FF;
            border: 2px solid #696969;
            font-weight: bold;
            margin-left: -76%;
        }
        .add_link
        {
            color: #333333;
            line-height: 32px;
            text-decoration: none;
            text-shadow: 1px 1px 1px #FFFFFF;
        }
    </style>
    <style type="text/css">
        .VeryPoor
        {
            background-color: red;
        }
        
        .Weak
        {
            background-color: orange;
        }
        
        .Average
        {
            background-color: #A52A2A;
        }
        .Excellent
        {
            background-color: yellow;
        }
        .Strong
        {
            background-color: green;
        }
        .border
        {
            border: medium solid #800000;
            width: 250px;
        }
        .BarIndicatorweak
        {
            color: Red;
            background-color: Red;
        }
        .BarIndicatoraverage
        {
            color: Blue;
            background-color: Blue;
        }
        .BarIndicatorgood
        {
            color: Green;
            background-color: Green;
        }
        .Strong1
        {
            background-color: green;
        }
        .BarBorder
        {
            border-style: solid;
            border-width: 1px;
            width: 220px;
            vertical-align: middle;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="upnlAddCompany" runat="server">
        <ContentTemplate>
            <div class="bxmain">
                <table align="center" class="style1">
                    <tr>
                        <td align="right">
                            Department:
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlDepartment" runat="server" DataSourceID="SqlDataSourceDept"
                                DataTextField="Dept_Name" DataValueField="Dept_ID" AutoPostBack="True">
                            </asp:DropDownList>
                            <asp:LinkButton ID="lnkBtnAddPanelDept" runat="server" CausesValidation="false" OnClick="lnkBtnAddPanelDept_Click"
                                Visible="false">Add</asp:LinkButton>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Sub Department:
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlSubDepartment" runat="server" DataSourceID="SqlDataSourceSubDept"
                                DataTextField="SubDept_Name" DataValueField="SubDept_Id" AutoPostBack="True">
                            </asp:DropDownList>
                            <asp:LinkButton ID="lnkBtnAddPanelSubDept" runat="server" CausesValidation="false"
                                OnClick="lnkBtnAddPanelSubDept_Click" Visible="false">Add</asp:LinkButton>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Employee:
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlEmployee" runat="server" DataSourceID="SqlDataSourceEmployee"
                                DataTextField="Name" DataValueField="EmpID" AutoPostBack="True">
                            </asp:DropDownList>
                            <asp:LinkButton ID="lnkBtnAddPanelEmployee" runat="server" CausesValidation="false"
                                OnClick="lnkBtnAddPanelEmployee_Click" Visible="false">Add</asp:LinkButton>
                            <a href="../UserManagement/employee.aspx" target="_blank">Add</a>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Select Main page:
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlSelectMainPage" runat="server" DataSourceID="SqlDataSourceSelectMainPage"
                                DataTextField="MainPage" DataValueField="MainPage_ID">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvMainPage1" runat="server" ControlToValidate="ddlSelectMainPage"
                                ErrorMessage="Please select main page" ToolTip="Required"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Branch Access:
                        </td>
                        <td>
                            <asp:CheckBox ID="chkBranchAccess" runat="server" AutoPostBack="True" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            User name:
                        </td>
                        <td>
                            <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUsername"
                                Display="Dynamic" ErrorMessage="*" SetFocusOnError="True" ToolTip="Required"></asp:RequiredFieldValidator>
                            <asp:Label ID="lblUserfind" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Create a password
                        </td>
                        <td>
                            <asp:TextBox ID="txtCreatePasword" TextMode="Password" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtCreatePasword"
                                Display="Dynamic" ErrorMessage="*" ToolTip="Required"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtConfirmPasword"
                                ControlToValidate="txtCreatePasword" ErrorMessage="*" ToolTip="Does't match with Confirm Password"></asp:CompareValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtCreatePasword"
                                ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$"
                                Display="dynamic" ErrorMessage="*" ForeColor="Red" ToolTip="Minimum 8 characters atleast 1 Alphabet, 1 Number and 1 Special Character" />
                            <asp:PasswordStrength ID="PasswordStrength1" runat="server" TargetControlID="txtCreatePasword"
                                RequiresUpperAndLowerCaseCharacters="true" MinimumNumericCharacters="1" MinimumSymbolCharacters="1"
                                MinimumUpperCaseCharacters="1" PreferredPasswordLength="8" DisplayPosition="RightSide"
                                StrengthIndicatorType="BarIndicator" BarBorderCssClass="BarBorder" StrengthStyles="BarIndicatorweak;BarIndicatoraverage;BarIndicatorgood;Strong1;">
                            </asp:PasswordStrength>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Confirm your password&nbsp;
                        </td>
                        <td>
                            <asp:TextBox ID="txtConfirmPasword" TextMode="Password" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtConfirmPasword"
                                Display="Dynamic" ErrorMessage="*" ToolTip="Required"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToCompare="txtCreatePasword"
                                ControlToValidate="txtConfirmPasword" Display="Dynamic" ErrorMessage="*" ToolTip="Does't match with password"></asp:CompareValidator>
                            <asp:HiddenField ID="hiddenfieldpassword" runat="server" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtConfirmPasword"
                                ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$"
                                Display="dynamic" ErrorMessage="*" ForeColor="Red" ToolTip="Minimum 8 characters atleast 1 Alphabet, 1 Number and 1 Special Character" />
                            <asp:PasswordStrength ID="PasswordStrength2" runat="server" TargetControlID="txtConfirmPasword"
                                RequiresUpperAndLowerCaseCharacters="true" MinimumNumericCharacters="1" MinimumSymbolCharacters="1"
                                MinimumUpperCaseCharacters="1" PreferredPasswordLength="8" DisplayPosition="RightSide"
                                StrengthIndicatorType="BarIndicator" BarBorderCssClass="BarBorder" StrengthStyles="BarIndicatorweak;BarIndicatoraverage;BarIndicatorgood;Strong1;">
                            </asp:PasswordStrength>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            &nbsp;
                        </td>
                        <td>
                            <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                            <asp:SqlDataSource ID="SqlDataSourceSaveLogin" runat="server" ConnectionString="<%$ ConnectionStrings:UsersConnectionString %>"
                                InsertCommand="INSERT INTO Login(UserName, Password, EmpID, MainPage_Id, ShiftID, Branch_Access) VALUES (@UserName, @Password, @EmpID, @MainPage_Id, 1, @Branch_Access)"
                                ProviderName="<%$ ConnectionStrings:UsersConnectionString.ProviderName %>">
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="txtUsername" Name="UserName" PropertyName="Text" />
                                    <asp:ControlParameter ControlID="HiddenFieldPassword" Name="Password" PropertyName="Value" />
                                    <asp:ControlParameter ControlID="ddlEmployee" Name="EmpID" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="ddlSelectMainPage" Name="MainPage_Id" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="chkBranchAccess" Name="Branch_Access" PropertyName="Checked" />
                                </InsertParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:SqlDataSource ID="SqlDataSourceEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                                SelectCommand="sp_CreateLogin" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="ddlDepartment" Name="DeptID" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="ddlSubDepartment" Name="SubDeptId" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSourceSelectMainPage" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                                SelectCommand="SELECT MainPage_ID, MainPage FROM MainPages"></asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSourceSubDept" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                                SelectCommand="SELECT SubDept_Id, SubDept_Name FROM dbo.SubDepartment 
                                    WHERE Dept_Id = @deptid ORDER BY SubDept_Name">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="ddlDepartment" Name="deptid" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSourceDept" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                                SelectCommand="

                                    SELECT Dept_ID, Dept_Name FROM Department  order by Dept_Name "></asp:SqlDataSource>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
                <asp:Panel ID="PnlAddDept" runat="server" class="lightbox">
                    <table class="style1">
                        <tr>
                            <td align="right">
                                Enter Department:
                            </td>
                            <td>
                                <asp:TextBox ID="txtEnterDepartment" ValidationGroup="AddDept" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ToolTip="Required"
                                    Display="Dynamic" ValidationGroup="AddDept" ControlToValidate="txtEnterDepartment">fill that</asp:RequiredFieldValidator>
                                <asp:Label ID="lblCheckEnterDept" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                &nbsp;
                            </td>
                            <td>
                                <asp:SqlDataSource ID="SqlDataSourceEnterDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                    InsertCommand="sp_addDepartment" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
                                    <InsertParameters>
                                        <asp:ControlParameter ControlID="txtEnterDepartment" Name="Dept_Name" PropertyName="Text"
                                            Type="String" />
                                    </InsertParameters>
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:GridView ID="rgdAddDept" runat="server">
                                </asp:GridView>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                                <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
                            </td>
                            <td>
                                <asp:Button ID="btnSaveNewDept" ValidationGroup="AddDept" runat="server" Text="Save"
                                    OnClick="btnSaveNewDept_Click" />
                                <asp:Button ID="btncloseDept" runat="server" CausesValidation="false" Text="Close" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <asp:Panel ID="pnlAddSubDept" runat="server" class="lightbox">
                    <table class="style1">
                        <tr>
                            <td align="right">
                                Select Company
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlSelectCompany" runat="server" DataSourceID="SqlDataSourceSelectCompany"
                                    ValidationGroup="vgSubDept" DataTextField="Financial_Company_Name" DataValueField="Financial_Company_Id">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ControlToValidate="ddlSelectCompany"
                                    runat="server" ErrorMessage="*" ValidationGroup="vgSubDept" ToolTip="Required"
                                    Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:SqlDataSource ID="SqlDataSourceSelectCompany" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                                    SelectCommand="SELECT Financial_Company_Id, Financial_Company_Name FROM Group_Financial_Companies">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Select Baranch
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlSelectBranch" runat="server" ValidationGroup="vgSubDept"
                                    DataSourceID="SqlDataSourceSelectBranch" DataTextField="Company_Branch_Name"
                                    DataValueField="Company_Branch_Id">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ControlToValidate="ddlSelectBranch"
                                    runat="server" ErrorMessage="*" ValidationGroup="vgSubDept" ToolTip="Required"
                                    Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:SqlDataSource ID="SqlDataSourceSelectBranch" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                                    SelectCommand="SELECT Company_Branch_Id, Company_Branch_Name FROM Group_Company_Branches">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Enter Sub Department Name
                            </td>
                            <td>
                                <asp:TextBox ID="txtEnterSubDepartmentName" runat="server" ValidationGroup="vgSubDept"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtEnterSubDepartmentName"
                                    Display="Dynamic" ErrorMessage="*" ToolTip="Required" ValidationGroup="vgSubDept"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                &nbsp;
                            </td>
                            <td>
                                <asp:SqlDataSource ID="SqlDataSourceSubDepartment" runat="server"></asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <asp:Button ID="btnSavesubDept" runat="server" ValidationGroup="vgSubDept" Text="Save"
                                    OnClick="btnSavesubDept_Click" />
                                <asp:Button ID="btnCloselsubDept" runat="server" Text="Close" CausesValidation="false"
                                    OnClick="btnCloselsubDept_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="grdSubDept" runat="server" EnableModelValidation="True">
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <asp:Panel ID="pnlAddEmployee" runat="server" class="lightbox">
                    <table class="style1">
                        <tr>
                            <td>
                                Enter Employee Name
                            </td>
                            <td>
                                <asp:TextBox ID="txtEnterEmployeeName" ValidationGroup="vgEmp" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ValidationGroup="vgEmp" ID="RequiredFieldValidator6"
                                    runat="server" ErrorMessage="*" ControlToValidate="txtEnterEmployeeName" Display="Dynamic"
                                    ToolTip="Required"></asp:RequiredFieldValidator>
                                <asp:HiddenField ID="HiddenField_Ename" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Designation
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlDesignation" ValidationGroup="vgEmp" runat="server" AutoPostBack="True"
                                    DataSourceID="SqlDataSourceDesignation" DataTextField="Designation_Name" DataValueField="Designation_ID">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSourceDesignation" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                                    SelectCommand="SELECT Designation_Name, Designation_ID FROM Designation"></asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <asp:Button ID="btnSaveEmployee" runat="server" Text="Save" ValidationGroup="vgEmp"
                                    OnClick="btnSaveEmployee_Click" />
                                <asp:Button ID="btnCloseEmployee" runat="server" Text="Close" CausesValidation="false"
                                    OnClick="btnCloseEmployee_Click" />
                                <asp:Label ID="lblStatus" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                                <asp:SqlDataSource ID="SqlDataSource_SaveNewEmployeeInfo" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                                    SelectCommand="sp_AddNewEmployee" SelectCommandType="StoredProcedure" InsertCommand="sp_AddNewEmployee"
                                    InsertCommandType="StoredProcedure">
                                    <InsertParameters>
                                        <asp:ControlParameter ControlID="ddlDepartment" Name="deptid" PropertyName="SelectedValue"
                                            Type="Int32" />
                                        <asp:ControlParameter ControlID="ddlSubDepartment" Name="subdeptid" PropertyName="SelectedValue"
                                            Type="Int32" />
                                        <asp:ControlParameter ControlID="ddlDesignation" Name="DesignationID" PropertyName="SelectedValue"
                                            Type="Int32" />
                                        <asp:ControlParameter ControlID="txtEnterEmployeeName" Name="EFName" PropertyName="Text"
                                            Type="String" />
                                    </InsertParameters>
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="ddlDepartment" Name="deptid" PropertyName="SelectedValue"
                                            Type="Int32" />
                                        <asp:ControlParameter ControlID="ddlSubDepartment" Name="subdeptid" PropertyName="SelectedValue"
                                            Type="Int32" />
                                        <asp:ControlParameter ControlID="HiddenField_Ename" Name="EMName" PropertyName="Value"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="ddlDesignation" Name="DesignationID" PropertyName="SelectedValue"
                                            Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:GridView ID="grdEmployee" runat="server">
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
