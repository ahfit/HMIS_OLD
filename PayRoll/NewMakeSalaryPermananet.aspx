<%@ page title="" language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="PayRoll_NewMakeSalaryPermananet, App_Web_xk2k0ijz" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7DD5C3163F2CD0CB"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %><asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 7%;
        }
        .style3
        {
            width: 5%;
        }
        .style5
        {
            width: 50px;
        }
        .style6
        {
            width: 657px;
        }
        .hide
        {
            Display :none;   
        }
    </style>
 </asp:Content>
    
   
    

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <div class="bxmain">
            <table cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
                <tr>
                    <td align="right" class="style3">
                        Hospital :
                    </td>
                    <td class="style1">
                        <asp:DropDownList ID="dropdownlist_Hospital" runat="server" DataSourceID="SqlDataSource_Company"
                            DataTextField="Hospital_Name" DataValueField="Hospital_ID" TabIndex="5" Width="202px"
                            AutoPostBack="True">
                        </asp:DropDownList>
                    </td>
                    <td align="right" class="style3">
                        Designation :
                    </td>
                    <td width="25%">
                        <asp:DropDownList ID="DropDownList_desg" runat="server" DataSourceID="SqlDataSource_desg"
                            DataTextField="Designation_Name" DataValueField="Designation_ID" Width="202px"
                            TabIndex="5">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right" class="style3">
                        Department :
                    </td>
                    <td class="style1">
                        <asp:DropDownList ID="Dropdownlistdepartment" runat="server" DataSourceID="SqlDataSourceDepartment"
                            DataTextField="Dept_Name" DataValueField="Dept_ID" TabIndex="5" Width="202px">
                        </asp:DropDownList>
                    </td>
                    <td align="right" class="style3">
                        Employee Name :
                    </td>
                    <td>
                        <asp:TextBox ID="TextBox_Employee_name" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right" class="style3">
                        NTN # :
                    </td>
                    <td class="style1">
                        <asp:TextBox ID="txtNTNnumber" runat="server"></asp:TextBox>
                    </td>
                    <td align="right" class="style3">
                        CNIC # :
                    </td>
                    <td>
                        <igtxt:WebMaskEdit ID="TextBox_CNIC" runat="server" CssClass="input_txt" InputMask="#####-#######-#">
                        </igtxt:WebMaskEdit>
                    </td>
                </tr>
                <tr>
                    <td align="right" class="style3">
                        For Year :
                    </td>
                    <td class="style1">
                        <asp:DropDownList ID="DropDownList_year" runat="server" Width="120px">
                        </asp:DropDownList>
                    </td>
                    <td align="right" class="style3">
                        For Month :
                    </td>
                    <td>
                        <asp:DropDownList ID="DropDownList_Month" runat="server" Width="120px">
                            <asp:ListItem Value="01">January</asp:ListItem>
                            <asp:ListItem Value="02">February</asp:ListItem>
                            <asp:ListItem Value="03">March</asp:ListItem>
                            <asp:ListItem Value="04">April</asp:ListItem>
                            <asp:ListItem Value="05">May</asp:ListItem>
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
                    <td align="right" class="style3">
                        &nbsp;
                    </td>
                    <td class="style1">
                        <asp:Button ID="Button1" runat="server" Text="Search" 
                            />
                    </td>
                    <td align="right" class="style3">
                        &nbsp;
                    </td>
                    <td>
                        <asp:Button ID="Button_MakeSalary" runat="server" Text="Make Salary All" />
                        &nbsp;
                        <asp:Button ID="btnApprove" runat="server" Text="Approve" style="width: 68px" />
                        &nbsp;<asp:Button ID="btn_export" runat="server" Text="Export" />
                        <br />
                        <asp:Label ID="lblMsg" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <br />
        <asp:GridView ID="GridView_Employees" runat="server" AutoGenerateColumns="False"
            CssClass="GridAltItem" DataKeyNames="EmpID" DataSourceID="SqlDataSource_For_Grid"
            Width="100%" AllowPaging="True" PageSize="500">
            <Columns>
            <asp:TemplateField HeaderText="Sr.No">
            
            <ItemTemplate>
            <%#Container.DataitemIndex+1  %>
            </ItemTemplate>
            <ItemStyle Width="8%" />
            </asp:TemplateField>
            
                <asp:BoundField DataField="EmpID" HeaderText="Emp No" ReadOnly="True" SortExpression="EmpID" />
                <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="True" SortExpression="Name" />
                <asp:BoundField DataField="Hospital_Name" HeaderText="Hospital_Name" 
                    SortExpression="Hospital_Name" Visible="False" />
                <asp:BoundField DataField="DesignationID" HeaderText="Designation" SortExpression="DesignationID"
                    Visible="False" />
                <asp:BoundField DataField="DeptID" HeaderText="DeptID" SortExpression="DeptID" Visible="False" />
                <asp:BoundField DataField="Emp_Type" HeaderText="Emp_Type" SortExpression="Emp_Type"
                    Visible="False" />
                <asp:BoundField DataField="Emp_No" HeaderText="Emp_No" SortExpression="Emp_No" Visible="False" />
                <asp:BoundField DataField="Designation" HeaderText="Designation" SortExpression="Designation" />
                <asp:BoundField DataField="Department" HeaderText="Department" SortExpression="Department" />
                <asp:BoundField DataField="Employee_Type_ID" HeaderText="Employee_Type_ID" SortExpression="Employee_Type_ID"
                    Visible="False" />
                <asp:BoundField DataField="PayScale" HeaderText="PayScale" ReadOnly="True" 
                    SortExpression="PayScale" Visible="False" />
                <asp:BoundField DataField="Allowance" HeaderText="Allowance" ReadOnly="True" SortExpression="Allowance"
                    Visible="False" />
                <asp:BoundField DataField="Deduction" HeaderText="Deduction" ReadOnly="True" SortExpression="Deduction"
                    Visible="False" >
                     <ControlStyle 
                    BorderStyle="None" />
                <ItemStyle BackColor="#FFCCFF" BorderColor="#FFCCFF" />
                </asp:BoundField>
                     <asp:TemplateField HeaderText="Gross Salary">
                         <ItemTemplate>
                             <table class="bxmain">
                                 <tr>
                                     <td width="25">
                                         G.S
                                     </td>
                                     <td class="style5">
                                         Inc.</td>
                                     <td class="style6">
                                         Days</td>
                                     <td class="style6">
                                         PayAble Salary</td>
                                 </tr>
                                 <tr>
                                     <td>
                                         <asp:TextBox ID="txtGS" runat="server" Text='<%# Bind("GrossSalary") %>' 
                                             Width="40px"></asp:TextBox>
                                     </td>
                                     <td class="style5">
                                         <asp:TextBox ID="txtInc" runat="server" Text='<%# Bind("Increment") %>' 
                                             Width="25px" ></asp:TextBox>
                                     </td>
                                     <td class="style6">
                                         <asp:TextBox ID="txtSalaryDays" runat="server" 
                                             Text='<%# Bind("Salary_Days") %>' Width="25px" Enabled="false"></asp:TextBox>
                                     </td>
                                     <td class="style6">
                                         <asp:TextBox ID="txtCalculatedSalary" runat="server" 
                                             Text='<%# Bind("PayAble") %>' Width="40px" Enabled="false"></asp:TextBox>
                                     </td>
                                 </tr>
                             </table>
                         </ItemTemplate>
                </asp:TemplateField>
                     <asp:TemplateField HeaderText="Allowances">
                    <ItemTemplate>
                        <table class="bxmain">
                            <tr>
                                <td width="25">
                                    Allow.
                                </td>
                             <td width="25" >
                                    &nbsp;</td>
                               <%-- <td width="25" class = "hide">
                                    E.D.</td>
                                
                                <td width="25" class = "hide">
                                    H.K
                                </td>--%>
                                <td width="25" >
                                    Tot.Allow
                                </td>
                                
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox ID="txtQA" runat="server" Width="25px" 
                                        Text='<%# Bind("Qualification_Allowance") %>'></asp:TextBox>
                                </td>
                                <td  >
                                    &nbsp;<td >
                                    &nbsp;</td>
                               
                           
                                
                                <td>

                                    
                                        <asp:Label ID="lbl_totalAllow" runat="server" Width="25px"
                                        Text='<%# Eval("Total_Allow") %>' Enabled="false"></asp:Label>
                                </td>
                                
                                <td>
                                    &nbsp;</td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:TemplateField>
               
                <asp:TemplateField HeaderText="Arrear">
                    <ItemTemplate>
                    <table class="bxmain">
                    <tr> 
                    <td width="25" >
                    Arr.
                    <asp:TextBox ID="txtArr" runat="server" Width="25px"
                        Text='<%# Bind("ARREAR") %>'></asp:TextBox>
                    </td> 
                    </tr>
                    </table>
                        
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="OverTime">
                    <ItemTemplate>
                    <table class="bxmain">
                    <tr> 
                    <td width="25" >
                    O.Time.
                    <asp:TextBox ID="txtOvertime" runat="server" Width="25px"
                        Text='<%# Bind("OverTime") %>'></asp:TextBox>
                    </td> 
                    </tr>

                    

                    </table>
                        
                    </ItemTemplate>
                </asp:TemplateField>


                   <asp:TemplateField HeaderText="E.Leave">
                    <ItemTemplate>
                    <table class="bxmain">
                    <tr> 
                    <td width="25" >
                    E.Leave
                    <asp:TextBox ID="txtED" runat="server" Width="25px"
                        Text='<%# Bind("EarnLeave") %>'></asp:TextBox>
                    </td> 
                    </tr>

                    </table>
                        
                    </ItemTemplate>
                </asp:TemplateField>

               <asp:TemplateField HeaderText="Bonus">
                    <ItemTemplate>
                    <table class="bxmain">
                    <tr> 
                    <td width="25" >
                    Bonus
                    <asp:TextBox ID="txtBonus" runat="server" Width="25px"
                        Text='<%# Bind("ConveyanceAllowance") %>'></asp:TextBox>
                    </td> 
                    </tr>
                    </table>
                        
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Deductions">
                    <ItemTemplate>
                        <table class="bxmain">
                            <tr>
                                <td width="25">
                                    M.Bill</td>
                                <td width="25">
                                    Cable</td>
                                <td width="25">
                                    IT</td>
                                <td width="25">
                                    EOBI</td>
                                <td width="25">
                                    Adv.</td>
                                <td width="25">
                                    Security</td>
                                <td width="25">
                                    Elec.</td>
                                <td width="25">
                                    Tele.</td>
                                <td width="25">
                                    Mess</td>
                                <td width="25">
                                    Conveyance</td>
                                <td width="25">
                                    H.Leave</td>
                                     <td width="40">
                                         Tot.Dedu</td>

                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox ID="txtMBill" runat="server" Width="25px" 
                                        Text='<%# Bind("Mobilink_Bill") %>'></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtCable" runat="server" Width="25px" 
                                        Text='<%# Bind("CABLE") %>'></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtIT" runat="server" Width="25px" 
                                        Text='<%# Bind("IncomeTaxExpense") %>'></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtEOBI" runat="server" Width="25px" 
                                        Text='<%# Bind("EOBI") %>'></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtAdvToStaff" runat="server" Width="25px" 
                                        Text='<%# Bind("AdvancestoStaff") %>' ></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtSuiGas" runat="server" Width="25px" 
                                        Text='<%# Bind("SUIGAS") %>'></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtElec" runat="server" Width="25px" 
                                        Text='<%# Bind("ELECTRICITY") %>'></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtTel" runat="server" Width="25px" 
                                        Text='<%# Bind("TELEPHONE") %>'></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtMess" runat="server" Width="25px" 
                                        Text='<%# Bind("MESS") %>'></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtStaffMess" runat="server" Text='<%# Bind("StaffMess") %>' 
                                        Width="25px"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtHLeave" runat="server" Text='<%# Bind("HLeave") %>' 
                                        Width="25px"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lbl_TotalDeductions" runat="server" 
                                        Text='<%# Eval("Total_Deduction") %>' Enabled="false"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                    <ControlStyle/>
                </asp:TemplateField>


                <asp:TemplateField HeaderText="Net Payable">
                    <ItemTemplate>
                        <asp:Label ID="Label_Transfer" runat="server" Text='<%# Eval("NetPayAble") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:HyperLinkField DataNavigateUrlFields="EmpID,DesignationID,PayScale,Employee_Type_ID"
                    DataNavigateUrlFormatString="Administration.aspx?Employee={0}&amp;Designation_ID={1}&amp;Pay_Scale={2}&amp;Employee_Type_ID={3}"
                    Text="New" />
                <asp:HyperLinkField DataNavigateUrlFields="EmpID,Emp_Type" DataNavigateUrlFormatString="Salary.aspx?Employee={0}&amp;Emp_Type={1}"
                    Text="Salary" Visible="False" />
                <asp:ButtonField CommandName="Select" Text="Make Salary" SortExpression="EmpID" />
                <asp:HyperLinkField DataNavigateUrlFields="EmpID" DataNavigateUrlFormatString="PreviousSalaries.aspx?Employee={0}"
                    Text="Record" Visible="False" />
                <asp:TemplateField HeaderText="Report" SortExpression="EmpID">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton_Rpt" runat="server" OnClick="LinkButton_Rpt_Click"
                            Visible="false">Report</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>


                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:CheckBox ID="chkApprove" runat="server" />
                        <asp:HiddenField ID="HiddenField2" runat="server" 
                            Value='<%# Eval("EmpID") %>' />
                    </ItemTemplate>
                    <HeaderTemplate>
                        <asp:CheckBox ID="chkApprovedAll" runat="server" AutoPostBack="True" 
                            oncheckedchanged="chkApprovedAll_CheckedChanged" />
                    </HeaderTemplate>
                </asp:TemplateField>
            </Columns>
            <PagerSettings FirstPageText="First" LastPageText="Last" NextPageText="Next" 
                Position="TopAndBottom" PreviousPageText="prev" />
        </asp:GridView>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Width="100%"
            CssClass="Grid_1" DataKeyNames="EmpID" DataSourceID="SqlDataSource_For_Grid"
            PageSize="50" Visible="False">
            <FooterStyle CssClass="GridPager" />
            <RowStyle CssClass="GridItem" />
            <HeaderStyle CssClass="GridHeader" />
            <PagerStyle CssClass="GridPager" HorizontalAlign="Center" />
            <AlternatingRowStyle CssClass="GridAltItem" />
            <Columns>
                <asp:BoundField DataField="EmpID" HeaderText="Emp #" />
                <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="True" SortExpression="Name">
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="DesignationID" HeaderText="Designation" SortExpression="Designation">
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:DynamicField DataField="Department" HeaderText="Department" />
                <asp:DynamicField DataField="Hospital_Name" HeaderText="Hospital_Name" />
                <asp:TemplateField HeaderText="Allowances">
                    <ItemTemplate>
                        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2"
                            ShowHeader="False">
                            <Columns>
                                <asp:BoundField DataField="Head_Name" HeaderText="Head" SortExpression="Head_Name" />
                                <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>"
                            SelectCommand="
SELECT     Salary_Allowance_Deduction_Setup.Head_Name, MonthlySalaryDetail.Amount
FROM         MonthlySalaryDetail INNER JOIN
                      Salary_Allowance_Deduction_Setup ON Salary_Allowance_Deduction_Setup.E_ID = MonthlySalaryDetail.E_ID
WHERE     (MonthlySalaryDetail.EmpId = @Empid) AND (MonthlySalaryDetail.SalaryMonth = @SalaryMonth) AND (MonthlySalaryDetail.SalaryYear = @SalaryYear) AND 
                      (Salary_Allowance_Deduction_Setup.Allowance_Deduction LIKE 'Allowance')">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="HiddenField_EmpidAllow" Name="Empid" PropertyName="Value" />
                                <asp:ControlParameter ControlID="DropDownList_Month" Name="SalaryMonth" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="DropDownList_year" Name="SalaryYear" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:HiddenField ID="HiddenField_SalaryMonthAllow" runat="server" />
                        <asp:HiddenField ID="HiddenField_SalaryYearAllow" runat="server" />
                        <asp:HiddenField ID="HiddenField_EmpidAllow" runat="server" />
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Department") %>'></asp:Label>
                        <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("Emp_Type") %>' />
                        <asp:HiddenField ID="HiddenField2" runat="server" Value='<%# Bind("EmpID") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Deductions">
                    <ItemTemplate>
                        <asp:GridView ID="GridView2_Deduction" runat="server" AutoGenerateColumns="False"
                            DataSourceID="SqlDataSource_Deduction" ShowHeader="False">
                            <Columns>
                                <asp:BoundField DataField="Head_Name" HeaderText="Head" SortExpression="Head_Name" />
                                <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource_Deduction" runat="server" ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>"
                            SelectCommand="
SELECT     Salary_Allowance_Deduction_Setup.Head_Name, MonthlySalaryDetail.Amount
FROM         MonthlySalaryDetail INNER JOIN
                      Salary_Allowance_Deduction_Setup ON Salary_Allowance_Deduction_Setup.E_ID = MonthlySalaryDetail.E_ID
WHERE     (MonthlySalaryDetail.EmpId = @Empid) AND (MonthlySalaryDetail.SalaryMonth = @SalaryMonth) AND (MonthlySalaryDetail.SalaryYear = @SalaryYear) AND 
                      (Salary_Allowance_Deduction_Setup.Allowance_Deduction LIKE 'Deduction')">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="HiddenField_EmployeeIDDed" Name="Empid" PropertyName="Value" />
                                <asp:ControlParameter ControlID="DropDownList_Month" Name="SalaryMonth" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="DropDownList_year" Name="SalaryYear" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:HiddenField ID="HiddenField_EmployeeIDDed" runat="server" />
                        <asp:HiddenField ID="HiddenField_SalaryYearDed" runat="server" />
                        <asp:HiddenField ID="HiddenField_SalaryMonthDed" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Transfer">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label_Transfer" runat="server">0</asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:HyperLinkField DataNavigateUrlFields="EmpID,DesignationID,PayScale,Employee_Type_ID"
                    DataNavigateUrlFormatString="Administration.aspx?Employee={0}&amp;Designation_ID={1}&amp;Pay_Scale={2}&amp;Employee_Type_ID={3}"
                    Text="New" />
                <asp:HyperLinkField DataNavigateUrlFields="EmpID,Emp_Type" DataNavigateUrlFormatString="Salary.aspx?Employee={0}&amp;Emp_Type={1}"
                    Text="Salary" Visible="False" />
                <asp:ButtonField CommandName="Select" Text="Make Salary" SortExpression="EmpID" />
                <asp:HyperLinkField DataNavigateUrlFields="EmpID" DataNavigateUrlFormatString="PreviousSalaries.aspx?Employee={0}"
                    Text="Record" Visible="False" />
                <asp:TemplateField HeaderText="Report" SortExpression="EmpID">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton_Rpt" runat="server" OnClick="LinkButton_Rpt_Click"
                            Visible="False">Report</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:HiddenField ID="HiddenField_ET" runat="server" />
        <asp:HiddenField ID="HiddenField_EID" runat="server" />
        <asp:SqlDataSource ID="SqlDataSource_Company" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
            SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"></asp:SqlDataSource>
        <br />
        <asp:SqlDataSource ID="SqlDataSource_desg" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            SelectCommand="select 0 as [Designation_ID], 'All' as [Designation_Name]
union
SELECT [Designation_ID], [Designation_Name] FROM [Designation]"></asp:SqlDataSource>
        <asp:HiddenField ID="HiddenField_CNICNumber" runat="server" />
        <asp:HiddenField ID="HiddenField_NTN" runat="server" />
        <asp:HiddenField ID="HiddenField_Name" runat="server" />
        <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
            SelectCommand="Select '  ALL' as Dept_Name, 0 as Dept_ID
union
SELECT Dept_Name, Dept_ID FROM Department where Hospital_ID = @Hospital ORDER BY  Dept_Name">
            <SelectParameters>
                <asp:ControlParameter ControlID="dropdownlist_Hospital" Name="Hospital" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenField_CNIC" runat="server" />
        <asp:HiddenField ID="HiddenField_Dept_ID" runat="server" />
        <asp:HiddenField ID="HiddenField_Emp_ID" runat="server" />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>"
            ProviderName="<%$ ConnectionStrings:PayRoll_ConnectionString.ProviderName %>">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_For_Grid" runat="server" CancelSelectOnNullParameter="False"
            ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>" SelectCommand="usp_AllSalariedEmployee"
            SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="Dropdownlistdepartment" DefaultValue="0" Name="DeptID"
                    PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="dropdownlist_Hospital" DefaultValue="0" Name="hospitalID"
                    PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="HiddenField_NTN" DefaultValue="" Name="NTN" PropertyName="Value"
                    Type="String" />
                <asp:ControlParameter ControlID="DropDownList_desg" DefaultValue="0" Name="designationID"
                    PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="HiddenField_CNICNumber" DefaultValue="" Name="CNIC"
                    PropertyName="Value" Type="String" />
                <asp:ControlParameter ControlID="HiddenField_Name" Name="name" PropertyName="Value"
                    Type="String" />
                <asp:ControlParameter ControlID="DropDownList_Month" DefaultValue="" 
                    Name="SalaryMonth" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="DropDownList_year" Name="SalaryYear" 
                    PropertyName="SelectedValue" Type="Int32" />
                <asp:SessionParameter Name="Admin_ID" SessionField="emp_id" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <br />
        <asp:SqlDataSource ID="SqlDataSource_FinalSalary" runat="server" 
            ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>" 
            SelectCommand="Select * from employee_salary" UpdateCommand="usp_FinalSalary" 
            UpdateCommandType="StoredProcedure">
            <UpdateParameters>
                <asp:ControlParameter ControlID="HiddenField_EmpidsFinalSalary" Name="Empid" 
                    PropertyName="Value" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenField_EmpidsFinalSalary" runat="server" />
    </div>
</asp:Content>
