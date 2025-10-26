<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Change_Password, App_Web_tip0c1yj" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="bxmain">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
            <tr>
                <td width="40%" align="right">
                    User Login :
                </td>
                <td width="60%">
                    <asp:Label ID="Label_user_name" runat="server" Style="color: #C00; font-weight: bold;
                        font-size: 13px;"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Old Password :
                </td>
                <td>
                    <asp:TextBox ID="TextBox_old_passward" runat="server" TextMode="Password"></asp:TextBox>
                    <asp:PasswordStrength ID="PasswordStrength2" runat="server" TargetControlID="TextBox_old_passward"
                        RequiresUpperAndLowerCaseCharacters="true" MinimumNumericCharacters="1" MinimumSymbolCharacters="1"
                        MinimumUpperCaseCharacters="1" PreferredPasswordLength="8" DisplayPosition="RightSide"
                        StrengthIndicatorType="BarIndicator" BarBorderCssClass="BarBorder"
                        StrengthStyles="BarIndicatorweak;BarIndicatoraverage;BarIndicatorgood;Strong1;"
                        >
                    </asp:PasswordStrength>
                    <%--<asp:PasswordStrength ID="TextBox_old_passward_PasswordStrength" runat="server" DisplayPosition="RightSide"
                        StrengthIndicatorType="BarIndicator" TargetControlID="TextBox_old_passward" PrefixText="Stength:"
                        Enabled="true" RequiresUpperAndLowerCaseCharacters="true" MinimumLowerCaseCharacters="1"
                        MinimumUpperCaseCharacters="1" MinimumSymbolCharacters="1" MinimumNumericCharacters="1"
                        PreferredPasswordLength="8" TextStrengthDescriptions="VeryPoor; Weak; Average; Strong; Excellent"
                        StrengthStyles="VeryPoor; Weak; Average; Excellent; Strong;" CalculationWeightings="25;25;15;35"
                        BarBorderCssClass="border">
                    </asp:PasswordStrength>--%>
                    <asp:RegularExpressionValidator ID="Regex2" runat="server" ControlToValidate="TextBox_old_passward"
                        ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$"
                        Display="dynamic" ErrorMessage="**" ForeColor="Red" ToolTip="Minimum 8 characters atleast 1 Alphabet, 1 Number and 1 Special Character" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator_old_passward" runat="server"
                        ControlToValidate="TextBox_old_passward" ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td align="right">
                    New Password :
                </td>
                <td>
                    <asp:TextBox ID="TextBox_new_passward" runat="server" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator_new_passward" runat="server"
                        ControlToValidate="TextBox_new_passward" ErrorMessage="*"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox_old_passward"
                        ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$"
                        Display="dynamic" ErrorMessage="**" ForeColor="Red" ToolTip="Minimum 8 characters atleast 1 Alphabet, 1 Number and 1 Special Character" />
                        <asp:PasswordStrength ID="PasswordStrength1" runat="server" TargetControlID="TextBox_new_passward"
                        RequiresUpperAndLowerCaseCharacters="true" MinimumNumericCharacters="1" MinimumSymbolCharacters="1"
                        MinimumUpperCaseCharacters="1" PreferredPasswordLength="8" DisplayPosition="RightSide"
                        StrengthIndicatorType="BarIndicator" BarBorderCssClass="BarBorder"
                        StrengthStyles="BarIndicatorweak;BarIndicatoraverage;BarIndicatorgood;Strong1;"
                        >
                    </asp:PasswordStrength>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Confirm Password:
                </td>
                <td>
                    <asp:TextBox ID="TextBox_confirm_new_passward" runat="server" TextMode="Password"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TextBox_confirm_new_passward"
                        ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$"
                        Display="dynamic" ErrorMessage="**" ForeColor="Red" ToolTip="Minimum 8 characters atleast 1 Alphabet, 1 Number and 1 Special Character" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator_confirm_passward" runat="server"
                        ControlToValidate="TextBox_confirm_new_passward" ErrorMessage="*"></asp:RequiredFieldValidator>
                    <asp:PasswordStrength ID="PasswordStrength3" runat="server" TargetControlID="TextBox_confirm_new_passward"
                        RequiresUpperAndLowerCaseCharacters="true" MinimumNumericCharacters="1" MinimumSymbolCharacters="1"
                        MinimumUpperCaseCharacters="1" PreferredPasswordLength="8" DisplayPosition="RightSide"
                        StrengthIndicatorType="BarIndicator" BarBorderCssClass="BarBorder"
                        StrengthStyles="BarIndicatorweak;BarIndicatoraverage;BarIndicatorgood;Strong1;"
                        >
                    </asp:PasswordStrength>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <asp:Button ID="Button_Change_Password" runat="server" Text="Save" />
                </td>
            </tr>
        </table>
        <asp:Label ID="Label_Note" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label></div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:UsersConnectionString %>"
        DeleteCommand="DELETE FROM [Employee_Basic_info] WHERE [Employee_ID] = @Employee_ID"
        InsertCommand="INSERT INTO [Employee_Basic_info] ([Password]) VALUES (@Password)"
        SelectCommand="SELECT [Employee_ID], [Password] FROM [Employee_Basic_info]" UpdateCommand="UPDATE Login SET  Password = @Password WHERE (EmpID = @EmpID)"
        ProviderName="<%$ ConnectionStrings:UsersConnectionString.ProviderName %>">
        <DeleteParameters>
            <asp:Parameter Name="Employee_ID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenField_NewPass" Name="Password" PropertyName="Value" />
            <asp:SessionParameter Name="EmpID" SessionField="emp_ID" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="Password" />
        </InsertParameters>
    </asp:SqlDataSource>
    <br />
    <asp:HiddenField ID="HiddenField_NewPass" runat="server" />
</asp:Content>
