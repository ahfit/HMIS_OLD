<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="PayRoll_AllowancesDeductionEntry, App_Web_tchaehmk" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
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
            width: 171px;
        }
        .style2
        {
            width: 239px;
        }
        .heading {
				height:50px;
				width:100%;
				margin-left:0px;
				margin-top:5px;
				border:#d6d6d6 solid 1px;
				background:#f7f7f7;
				-webkit-border-radius: 4px;
				-moz-border-radius: 4px;
				border-radius: 4px;
				padding-top:8px;
				padding-bottom:8px;
				text-align:center;
				}
				h1
				{
					padding:0;
					margin-right: 0;
					margin-top: 0;
					margin-bottom: 0;
					color:Maroon;
					font-weight:bold;
		    	}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain">
    <div class="heading">
			<h1> Allowances / Deduction Yearly Break down</h1>
		</div>
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
                        onselectedindexchanged="DropDownList_Hospital_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Hospital" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="SELECT     0 as Hospital_ID, '--ALL--' as Hospital_Name union SELECT     Hospital_ID, Hospital_Name FROM         BasicDataInfo.dbo.Hospital">
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
                        
                        SelectCommand="select 0 as Dept_ID, '--All--' as Dept_Name union select Dept_ID, Dept_Name from Department where @HospitalId  = 0  or Hospital_ID = @HospitalId">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownList_Hospital" DefaultValue="0" 
                                Name="HospitalId" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>

            <tr>
                <td align="right">
                    Salary Head:
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_SalaryHeads" runat="server" DataSourceID="SqlDataSource_SalaryHead"
                        DataTextField="Head_Name" DataValueField="E_ID" 
                        onselectedindexchanged="DropDownList_SalaryHeads_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_SalaryHead" runat="server" ConnectionString="<%$ ConnectionStrings:PayRollConnectionString %>"
                        SelectCommand="Select Salary_Allowance_Deduction_Setup.E_ID, Salary_Allowance_Deduction_Setup.Head_Name from HeadPermission
inner join Salary_Allowance_Deduction_Setup on Salary_Allowance_Deduction_Setup.E_ID = HeadPermission.HeadID
where HeadPermission.Empid = @Empid and Salary_Allowance_Deduction_Setup.IsVariable = 1
and Salary_Allowance_Deduction_Setup.E_ID not in (1665,1675)">
                        <SelectParameters>
                            <asp:SessionParameter Name="Empid" SessionField="emp_id" />
                        </SelectParameters>
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
                            <asp:ListItem Value="2">Single</asp:ListItem>
                            <asp:ListItem Value="1">List</asp:ListItem>
                        </asp:RadioButtonList>

                    </td>
                </tr>
        </table>
    </div>
    <asp:GridView ID="GridView1" runat="server" ShowHeader="False" Width="100%" AutoGenerateColumns="False"
        DataSourceID="SqlDataSource1">
        <Columns>
         <asp:TemplateField HeaderText="SrNo."> 
<ItemTemplate> <%#Container.DataItemIndex+1%> 
</ItemTemplate>
<ItemStyle Width="8%" /> 
</asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <table class="diagnosis_list">
                        <tr>
                            <td class="header" align="right">
                                Employee ID:
                            </td>
                            <td class="style2">
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
                            <td class="style2">
                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("JoinDate") %>' Font-Size="15px"></asp:Label>
                            </td>
                            <td class="header" align="right">
                                Designation:
                            </td>
                            <td>
                                <asp:Label ID="Label5" runat="server" Text='<%# Eval("Designation_Name") %>' Font-Size="15px"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="header" align="right">
                                Department:
                            </td>
                            <td class="style2">
                                <asp:Label ID="Label4" runat="server" Font-Size="15px" Text='<%# Eval("Dept_Name") %>'></asp:Label>
                            </td>
                            <td class="header" align="right">
                                Amount:
                            </td>
                            <td>
                                <asp:TextBox ID="txtAllDedAmount" runat="server" Text='<%# Eval("Amount") %>' Font-Size="15px"></asp:TextBox>
                                <asp:HiddenField ID="HiddenField1" runat="server" 
                                    Value='<%# Eval("EmpID") %>' />
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
        ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>" 
        SelectCommand="usp_SearchData" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_Empid" Name="Empid" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Name" Name="Name" PropertyName="Value" />
            <asp:ControlParameter ControlID="DropDownList_Department" Name="DeptID" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList_Hospital" Name="HospitalId" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList_SalaryHeads" Name="E_ID" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList_SalaryMonth" Name="Month" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList_SalaryYear" Name="Year" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Empid" runat="server" />
    <asp:HiddenField ID="HiddenField_Name" runat="server" />
    <div align="center">
        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
        &nbsp;
     <%--   <asp:Button ID="btnViewReport" runat="server" Text="Export Excel" 
            onclick="btnViewReport_Click"  />--%>
        <br />
        <br />
    </div>
    
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="id"
        DataSourceID="SqlDataSource2" CssClass="Grid_1" Width="100%" 
        onprerender="GridView2_PreRender" ShowFooter="True">
        <Columns>
       <asp:TemplateField HeaderText="SrNo."> 
<ItemTemplate> <%#Container.DataItemIndex+1%> 
</ItemTemplate>
<ItemStyle Width="8%" /> 
</asp:TemplateField>


            <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True"
                SortExpression="id" Visible="False" />
            <asp:BoundField DataField="EmpId" HeaderText="EmpId" SortExpression="EmpId" />
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
            <asp:BoundField DataField="Head_Name" HeaderText="Head Name" SortExpression="Head_Name" />
            <asp:BoundField DataField="Designation" HeaderText="Designation" SortExpression="Designation" />
            <asp:BoundField DataField="Department" HeaderText="Department" SortExpression="Department" />
            <asp:BoundField DataField="Month_Name" HeaderText="Month" SortExpression="Month_Name" />
            <asp:BoundField DataField="SalaryYear" HeaderText="SalaryYear" SortExpression="SalaryYear" />
            <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" 
                Visible="False" />
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
                    <asp:CheckBox ID="chk" runat="server" AutoPostBack="True" OnCheckedChanged="chk_CheckedChanged" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="chkApprove" Width="5px" runat="server" />
                    <asp:HiddenField ID="HiddenField_Empid" runat="server" Value='<%# Eval("EmpId") %>' />
                </ItemTemplate>
                <ItemStyle Width="5px"></ItemStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Amount">
                <ItemTemplate>
                    <asp:Label ID="LBL_Amount" runat="server" Text='<%# Eval("Amount") %>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="LBL_T_Amount" runat="server" Text="Label" Font-Bold="True"></asp:Label>
                </FooterTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:PayRollConnectionString %>"
        
        SelectCommand="SELECT     MonthlySalaryDetail.id, MonthlySalaryDetail.EmpId, Employee.Name, Salary_Allowance_Deduction_Setup.Head_Name, Employee.Designation, 
                      Employee.Department, Year_Months.Month_Name, MonthlySalaryDetail.SalaryYear, MonthlySalaryDetail.Amount, MonthlySalaryDetail.EntryBy, 
                      MonthlySalaryDetail.ApproveBy, MonthlySalaryDetail.Remarks, MonthlySalaryDetail.EntryDate, MonthlySalaryDetail.ApproveStatus, Department.Hospital_ID
FROM         MonthlySalaryDetail INNER JOIN
                      Employee ON MonthlySalaryDetail.EmpId = Employee.EmpID INNER JOIN
                      Salary_Allowance_Deduction_Setup ON MonthlySalaryDetail.E_ID = Salary_Allowance_Deduction_Setup.E_ID INNER JOIN
                      Year_Months ON Year_Months.Month_No = MonthlySalaryDetail.SalaryMonth INNER JOIN
                      Department ON Employee.Dept_ID = Department.Dept_ID

WHERE     (MonthlySalaryDetail.ApproveStatus = 0) and (MonthlySalaryDetail.E_ID = @E_ID) AND 
(MonthlySalaryDetail.SalaryMonth = @SalaryMonth) AND (MonthlySalaryDetail.SalaryYear = @SalaryYear)
And (Employee.Dept_ID = @Dept_ID Or @Dept_ID = 0)
and   (Department.Hospital_ID = @Hospital_ID or @Hospital_ID =0)
Order by Hospital_ID,MonthlySalaryDetail.EntryDate desc,  Employee.EmpID, Employee.Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_SalaryHeads" Name="E_ID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownList_SalaryMonth" Name="SalaryMonth" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownList_SalaryYear" Name="SalaryYear" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownList_Department" Name="Dept_ID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownList_Hospital" Name="Hospital_ID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    
</asp:Content>
