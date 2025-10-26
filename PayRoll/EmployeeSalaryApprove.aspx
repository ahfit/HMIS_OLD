<%@ page title="" language="C#" masterpagefile="~/Hacims_MasterPage_Admin_New.master" autoeventwireup="true" inherits="PayRoll_EmployeeSalaryApprove, App_Web_uyhcueiz" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain">
        <table cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
            <tr>
                <td align="right">
                    Hospital :
                </td>
                <td>
                    <asp:DropDownList ID="Dropdownlist_company" runat="server" TabIndex="5" Width="202px"
                        DataSourceID="sqlDs_Company" DataTextField="Hospital_Name" DataValueField="Hospital_ID"
                        AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sqlDs_Company" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                        SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Department :
                </td>
                <td>
                    <asp:DropDownList ID="Dropdownlist_Department" runat="server" DataSourceID="SqlDataSourceDepartment"
                        DataTextField="Dept_Name" DataValueField="Dept_ID" TabIndex="5" Width="202px"
                        AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                        
                        SelectCommand="select 0 as Dept_ID, '---All---' as Dept_Name union select Dept_ID, Dept_Name FROM Department where Hospital_ID = 1">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="Dropdownlist_company" Name="HospitalId" PropertyName="SelectedValue"
                                DefaultValue="0" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
            <td align="right">
            Bank :
            </td>
            <td>
            <asp:DropDownList ID="DropDownlist_bank" runat="server" DataSourceID="SqlDataSourceBank"
            DataTextField="Bank_Name" DataValueField="Bank_ID" TabIndex="6" Width="202px" AutoPostBack="true"></asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSourceBank" runat="server" ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>"
                        
                        SelectCommand="select Bank_ID, Bank_Name FROM Bank">
                        <%--<SelectParameters>
                            <asp:ControlParameter ControlID="DropDownlist_bank" Name="HospitalId" PropertyName="SelectedValue"
                                DefaultValue="0" />
                        </SelectParameters>--%>
                    </asp:SqlDataSource>
             
            </td>
            </tr>
            <tr>
                <td align="right">
                    Account Number :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownListAccountNumber" runat="server" DataSourceID="SqlDataSource_AccountNumber"
                        DataTextField="Account_No" DataValueField="Account_ID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_AccountNumber" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                        SelectCommand="SELECT     Account_ID, Account_No, Branch_Id,  Compnay_id, Financial_Company_Branch_ID, Account_Access FROM         Bank_Account">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Check No :
                </td>
                <td>
                    <asp:TextBox ID="txtCheckNo" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Letter No :
                </td>
                <td>
                    <asp:TextBox ID="txtLetterNo" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Approve Date :
                </td>
                <td>
                    <asp:TextBox ID="txtApproveDate" runat="server" SkinID="datepicker"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Approve by :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_ApprovedBy" runat="server" DataSourceID="SqlDataSource_Employee"
                        DataTextField="Name" DataValueField="EmpID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Employee" runat="server" ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>"
                        SelectCommand="SELECT EmpID, Name FROM employee"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right">
                    For Year :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_year" runat="server" Width="120px">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    For Month :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_Month" runat="server" Width="120px">
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
                <td>
                </td>
                <td>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                    &nbsp;&nbsp;<asp:Button ID="btnCalculate" runat="server" OnClick="btnCalculate_Click"
                        Text="Calculate total Salary" />
                    &nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnGenerateLetter" runat="server" Text="Generate Letter" OnClick="btnGenerateLetter_Click" />
                    <asp:Label ID="lblMsg" runat="server" Font-Bold="True"></asp:Label>
                     <asp:Button ID="btnRollBack" runat="server" Text="RollBack Bank Letter" OnClick="btnRollBack_Click" />
                </td>
            </tr>
        </table>
    </div>
    <asp:GridView ID="grdSalary" runat="server" ShowFooter="True" AutoGenerateColumns="False"
        CssClass="grid_dash" DataKeyNames="EmpID" DataSourceID="SqlDataSource_AllEmployeesSalary"
        Width="100%" OnDataBound="grdSalary_DataBound" 
        EmptyDataText="No Record Found">
        <Columns>
            <asp:BoundField DataField="SrNo" HeaderText="SrNo" ReadOnly="True" SortExpression="SrNo" />
            <asp:BoundField DataField="EmpID" HeaderText="EmpID" ReadOnly="True" SortExpression="EmpID" />
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
            <asp:BoundField DataField="Designation" HeaderText="Designation" SortExpression="Designation" />
            <asp:BoundField DataField="Account_Number" HeaderText="Account_Number" ReadOnly="True"
                SortExpression="Account_Number" />
            <asp:BoundField DataField="Salary_Payable" HeaderText="Salary_Payable" ReadOnly="True"
                SortExpression="Salary_Payable" Visible="False" />
            <asp:TemplateField HeaderText="Salary">
                <ItemTemplate>
                    <asp:Label ID="lblIndividualSalary" runat="server" Text='<%# Eval("Salary_Payable") %>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lblSum" runat="server"></asp:Label>
                </FooterTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:CheckBox ID="chkApproveSalary" runat="server" />
                    <asp:HiddenField ID="HiddenField_EmpId" runat="server" Value='<%# Eval("EmpID") %>' />
                </ItemTemplate>
                <HeaderTemplate>
                    <asp:CheckBox ID="chkAll" runat="server" AutoPostBack="True" OnCheckedChanged="chkAll_CheckedChanged" />
                </HeaderTemplate>
            </asp:TemplateField>
        </Columns>
        <FooterStyle BackColor="#DADADA" Font-Bold="True" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource_AllEmployeesSalary" runat="server" ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>"
        SelectCommand="BankCoverLetterReport" SelectCommandType="StoredProcedure" 
        CancelSelectOnNullParameter="False" >
            <SelectParameters>
        <asp:ControlParameter ControlID="Dropdownlist_Department" Name="DeptId" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList_year" Name="salaryYear" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="DropDownList_Month" Name="salaryMonth" PropertyName="SelectedValue"
                Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_sbtid" runat="server" />
    <br />
    <asp:HiddenField ID="HiddenField_TotalSalary" runat="server" />
</asp:Content>
