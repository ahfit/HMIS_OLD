<%@ Page Title="" Language="C#" MasterPageFile="~/Hacims_MasterPage_Admin_New.master" AutoEventWireup="true" CodeFile="Bankletter.aspx.cs" Inherits="PayRoll_BankLetter" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="inner_content bxmain">
        <h2> Bank Letter</h2>
        <table cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
            <tr>
                <td align="right" width="30%">
                    Institute :
                </td>
                <td  width="70%" >
                    <asp:DropDownList ID="Dropdownlist_company" runat="server" TabIndex="5" Width="202px"
                        DataSourceID="sqlDs_Company" DataTextField="Hospital_Name" DataValueField="Hospital_ID" OnSelectedIndexChanged="Dropdownlist_company_SelectedIndexChanged"

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
                        
                        SelectCommand="select 0 as Dept_ID, '---All---' as Dept_Name union select Dept_ID, Dept_Name FROM Department where Hospital_ID = @HospitalID">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="Dropdownlist_company" Name="HospitalID" PropertyName="SelectedValue"
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
            <asp:SqlDataSource ID="SqlDataSourceBank" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                        
                        SelectCommand="SELECT        Bank.Bank_ID, Bank.Bank_Name  as Bank_Name FROM  Bank INNER JOIN  Bank_Account ON Bank.Bank_ID = Bank_Account.BankId INNER JOIN
                         Expenditure ON Bank_Account.E_Code = Expenditure.E_Code">
                    </asp:SqlDataSource>
             
            </td>
            </tr>
            <tr>
                <td align="right">
                    Account Number :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownListAccountNumber" runat="server" DataSourceID="SqlDataSource_AccountNumber" Width="202px"
                        DataTextField="Account_No" DataValueField="Account_ID">
                    </asp:DropDownList>

                    <asp:SqlDataSource ID="SqlDataSource_AccountNumber" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                        SelectCommand="SELECT Account_ID, Account_No FROM Bank_Account where BankId  =@bankID">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownlist_bank" Name="bankID" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Check No :
                </td>
                <td>
                    <asp:TextBox ID="txtCheckNo" runat="server" Width="202px" required ></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Letter No :
                </td>
                <td>
                    <asp:TextBox ID="txtLetterNo" runat="server" Width="202px" required></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Approve Date :
                </td>
                <td>
                    <asp:TextBox ID="txtApproveDate" runat="server" TextMode="Date" Width="202px" min='<%= DateTime.Now.ToString("yyyy-MM-dd") %>' Visible="false"  required></asp:TextBox>
                    <igsch:WebDateChooser ID="WebDateChooser_Date" runat="server" CssClass="drop_down">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Approve by :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_ApprovedBy" runat="server" DataSourceID="SqlDataSource_Employee" Width="202px"
                        DataTextField="Name" DataValueField="EmpID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Employee" runat="server" ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>"
                        SelectCommand=" SELECT Employee.EmpID,  ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '')+' '+Cast(Employee.EmpID as varchar)+' '+' ('+Cast( Designation.Designation_Name as varchar )+')' AS Name
	                                    FROM  Employee inner join Designation on Employee.DesignationID=Designation.Designation_ID  AND 
	                                        (Employee.ActiveStatus = 1)   order by Name,EmpID"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right">
                    For Year :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_year" runat="server" Width="202px">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    For Month :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_Month" runat="server" Width="202px">
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
                    <asp:Button ID="btnSearch" runat="server"  Text="Search" OnClick="btnSearch_Click"  formnovalidate/>
                   <asp:Button ID="btnCalculate" Visible="false" runat="server" OnClick="btnCalculate_Click" Text="Calculate total Salary" />     
                    
                    
                    <asp:Label ID="lblMsg" runat="server" Font-Bold="True"></asp:Label >
                     
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <br />
                      <h2>Employee's Salary Without Bank Letter..</h2>
                    <div align ="right" >
                        <asp:Button ID="btnGenerateLetter" runat="server" Text="Generate Letter" OnClick="btnGenerateLetter_Click" OnClientClick="return confirm('Are you sure Generate Letter.');" />
                    </div>
                    <asp:UpdatePanel ID="pnl_grdSalary" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="grdSalary" runat="server" ShowFooter="True"
                                AutoGenerateColumns="False" CssClass="grid_dash"
                                DataKeyNames="EmpID"
                                AllowSorting="true"
                                DataSourceID="SqlDataSource_AllEmployeesSalary"
                                Width="100%" OnDataBound="grdSalary_DataBound"
                                EmptyDataText="No Record Found" OnPreRender="grdSalary_PreRender">
                                <Columns>
                                    <asp:BoundField DataField="SrNo" HeaderText="SrNo" ReadOnly="True" SortExpression="SrNo" />
                                    <asp:BoundField DataField="EmpID" HeaderText="EmpID" ReadOnly="True" SortExpression="EmpID" />
                                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                    <asp:BoundField DataField="Designation" HeaderText="Designation" SortExpression="Designation" />
                                    <asp:BoundField DataField="Account_Number" HeaderText="Account_Number" ReadOnly="True" SortExpression="Account_Number" />
                                    <asp:BoundField DataField="Salary_Payable" HeaderText="Salary_Payable" ReadOnly="True" SortExpression="Salary_Payable" Visible="False" />
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
                                            <asp:CheckBox ID="chkApproveSalary" runat="server" AutoPostBack="True" OnCheckedChanged="chk_CheckedChanged" />
                                            <asp:HiddenField ID="HiddenField_EmpId" runat="server" Value='<%# Eval("EmpID") %>' />
                                        </ItemTemplate>
                                        <HeaderTemplate>
                                            <asp:CheckBox ID="chkAll" runat="server" AutoPostBack="True" OnCheckedChanged="chkAll_CheckedChanged" />
                                        </HeaderTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle BackColor="#DADADA" Font-Bold="True" />
                            </asp:GridView>
                            <asp:UpdateProgress ID="upd_bankletter" runat="server">
                                <ProgressTemplate>
                                    <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #ffffff; opacity: 0.7;">
                                        <span style="border-width: 0px; position: fixed; padding: 50px; background-color: #ffffff; font-size: 36px; left: 40%; top: 40%;">
                                            <img src="../../images/progressbarimg.png" width="120px" height="120px" style="background: #ffffff" />
                                        </span>
                                    </div>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <br />
                    <div align ="right" >
                        <asp:Button ID="btnGenerateLetter1" runat="server" Text="Generate Letter" OnClick="btnGenerateLetter_Click" OnClientClick="return confirm('Are you sure Generate Letter.');" />
                    </div>
                    <asp:SqlDataSource ID="SqlDataSource_AllEmployeesSalary" runat="server" ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>"
                        SelectCommand="BankCoverLetterReport" SelectCommandType="StoredProcedure" 
                        CancelSelectOnNullParameter="False" >
                            <SelectParameters>
                                <asp:ControlParameter ControlID="Dropdownlist_Department" Name="DeptId" PropertyName="SelectedValue"  Type="Int32" />
                                <asp:ControlParameter ControlID="DropDownList_year" Name="salaryYear" PropertyName="SelectedValue"  Type="String" />
                                <asp:ControlParameter ControlID="DropDownList_Month" Name="salaryMonth" PropertyName="SelectedValue"  Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                </td>
            </tr>
             <tr>
                <td colspan="2">
                    <br />
                    <h2>
                        Already Generated Letter(s) for this month...
                    </h2>
                    <div align ="right" >
                        <asp:Button ID="btnRollBack" runat="server" Text="RollBack Bank Letter" OnClick="btnRollBack_Click" OnClientClick="return confirm('Are you sure you want RollBack All letters');" />   
                    </div>
                    <asp:UpdatePanel ID="pnl_GridViewBankLetters" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="GridViewBankLetters"
                                runat="server" ShowFooter="True"
                                AutoGenerateColumns="False"
                                CssClass="grid_dash"
                                Width="100%" EmptyDataText="No Record Found"
                                DataSourceID="SDS_BankLetters"
                                OnPreRender="GridViewBankLetters_PreRender"
                                AllowSorting="true">
                                <Columns>
                                    <asp:BoundField DataField="From_Account" HeaderText="Transfer Through" SortExpression="From_Account" />
                                    <asp:BoundField DataField="LetterNo" HeaderText="Letter No." SortExpression="LetterNo" />
                                    <asp:BoundField DataField="Check_No" HeaderText="Check No." SortExpression="Check_No" />
                                    <asp:BoundField DataField="Total_Amount" HeaderText="Total Amount" SortExpression="Total_Amount" />
                                    <asp:TemplateField InsertVisible="False">

                                        <ItemTemplate>
                                            <asp:LinkButton runat="server" ID="lBtn_Show" Text="Rollback letter" OnClick="lBtn_Show_Click" CommandArgument='<%# Eval("SBT_id") %>'
                                                OnClientClick="return confirm('Are you sure you want to roll back this Letter..');"></asp:LinkButton>
                                            <br />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:HyperLinkField DataNavigateUrlFields="SBT_id" DataNavigateUrlFormatString="../BankLetterRpt.aspx?SBTID={0}" Target="_blank" Text="Show letter" />
                                </Columns>
                            </asp:GridView>
                            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                <ProgressTemplate>
                                    <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #ffffff; opacity: 0.7;">
                                        <span style="border-width: 0px; position: fixed; padding: 50px; background-color: #ffffff; font-size: 36px; left: 40%; top: 40%;">
                                            <img src="../../images/progressbarimg.png" width="120px" height="120px" style="background: #ffffff" />
                                        </span>
                                    </div>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <br />
                    <div align ="right" >
                        <asp:Button ID="btnRollBack1" runat="server" Text="RollBack Bank Letter" OnClick="btnRollBack_Click" OnClientClick="return confirm('Are you sure you want RollBack All letters');" formnovalidate />   
                    </div>
                </td>
            </tr>
        </table>
        
                    <asp:SqlDataSource ID="SDS_BankLetters" runat="server" ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>"
                        SelectCommand="SELECT SBT_id, Total_Amount,B.Account_No From_Account, Check_No, Approved_Date, Transfer_Date, Salary_Month, Salary_Year, LetterNo FROM Salary_Bank_Transfer_Main T Inner join  Finance.dbo.Bank_Account B  On T.From_Account= B.Account_ID WHERE (Salary_Month = @Salary_Month) AND (Salary_Year = @Salary_Year);" 
                        CancelSelectOnNullParameter="False" >
                            <SelectParameters>
                                <asp:ControlParameter ControlID="DropDownList_Month" Name="Salary_Month" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="DropDownList_year" Name="Salary_Year" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>

  
    <asp:HiddenField ID="HiddenField_sbtid" runat="server" />
    <asp:HiddenField ID="HiddenField_TotalSalary" runat="server" />
    </div>
    
</asp:Content>
