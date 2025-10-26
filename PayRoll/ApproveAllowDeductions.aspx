<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="PayRoll_ApproveAllowDeductions, App_Web_tchaehmk" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
   
    <style type="text/css">
        .style1
        {
            width: 9%;
        }
        .style2
        {
            width: 10%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="">
    </div>
    <div class="bxmain">
        <table cellpadding="0" cellspacing="0" class="tbl_form">
            <tr>
                <td align="right" class="style1">
                    Hospital :
                </td>
                <td class="style2">
                    <asp:DropDownList ID="dropdownlist_Hospital" runat="server" DataSourceID="SqlDataSource_Company"
                        DataTextField="Hospital_Name" DataValueField="Hospital_ID" TabIndex="5" Width="202px"
                        AutoPostBack="True" OnSelectedIndexChanged="dropdownlist_Hospital_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Company" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                        SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"></asp:SqlDataSource>
                </td>
                <div hight = 50px>
                <td class="style2">
                    &nbsp;</td>
                    <td rowspan="6">
                        <asp:GridView ID="GridView_ApprovedList" runat="server" Width="372px" AutoGenerateColumns="False"
                            DataKeyNames="id" DataSourceID="SqlDataSource_PApproved" 
                            AllowPaging="True" PageSize="5">
                            <Columns>
                                <asp:BoundField DataField="SrNo" HeaderText="SrNo" ReadOnly="True" SortExpression="SrNo" />
                                <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True"
                                    SortExpression="id" Visible="False" />
                                <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="True" SortExpression="Name" />
                                <asp:BoundField DataField="Approve_Date" HeaderText="Approve_Date" SortExpression="Approve_Date" />
                                <asp:BoundField DataField="TotalAmount" HeaderText="TotalAmount" SortExpression="TotalAmount" />
                                <asp:TemplateField HeaderText="Report">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkReport" runat="server" CommandArgument='<%# Eval("id") %>'
                                            OnClick="lnkReport_Click">Report</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </div>
            </tr>
            <td align="right" class="style1">
                Department :
            </td>
            <td class="style2">
                <asp:DropDownList ID="Dropdownlistdepartment" runat="server" DataSourceID="SqlDataSourceDepartment"
                    DataTextField="Dept_Name" DataValueField="Dept_ID" TabIndex="5" Width="202px"
                    AutoPostBack="True" OnSelectedIndexChanged="Dropdownlistdepartment_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                    SelectCommand="Select '---All---' as Dept_Name, 0 as Dept_ID
union
SELECT Dept_Name, Dept_ID FROM Department where Hospital_ID = @Hospital ORDER BY Dept_Name">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="dropdownlist_Hospital" Name="Hospital" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td class="style2">
                &nbsp;</td>
            <tr>
                <td align="right" class="style1">
                    SalaryHead:
                </td>
                <td class="style2">
                    <asp:DropDownList ID="DropDownList_SalaryHeads" runat="server" DataSourceID="SqlDataSource_SalaryHead"
                        DataTextField="Head_Name" DataValueField="E_ID" AutoPostBack="True" OnSelectedIndexChanged="DropDownList_SalaryHeads_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_SalaryHead" runat="server" ConnectionString="<%$ ConnectionStrings:PayRollConnectionString %>"
                        SelectCommand="Select Salary_Allowance_Deduction_Setup.E_ID, Salary_Allowance_Deduction_Setup.Head_Name from HeadPermission
inner join Salary_Allowance_Deduction_Setup on Salary_Allowance_Deduction_Setup.E_ID = HeadPermission.HeadID
where HeadPermission.Empid = @Empid and Salary_Allowance_Deduction_Setup.IsVariable = 1  ">
                        <SelectParameters>
                            <asp:SessionParameter Name="Empid" SessionField="emp_id" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
                <td class="style2">
                    &nbsp;</td>
            </tr>
            <td align="right" class="style1">
                Salary Month :
            </td>
            <td class="style2">
                <asp:DropDownList ID="DropDownList_SalaryMonth" runat="server" AutoPostBack="True"
                    OnSelectedIndexChanged="DropDownList_SalaryMonth_SelectedIndexChanged">
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
            <td class="style2">
                &nbsp;</td>
            <tr>
                <td align="right" class="style1">
                    Salary Year:
                </td>
                <td class="style2">
                    <asp:DropDownList ID="DropDownList_SalaryYear" runat="server" AutoPostBack="True"
                        OnSelectedIndexChanged="DropDownList_SalaryYear_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:Label ID="lblMsg" runat="server" Text="Label"></asp:Label>
                </td>
                <td class="style2">
                    &nbsp;</td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    Remarks :
                </td>
                <td class="style2">
                    <asp:TextBox ID="txtRemarks" runat="server" Height="56px" TextMode="MultiLine" Width="209px"></asp:TextBox>
                </td>
                <td class="style2">
                    &nbsp;</td>
            </tr>
        </table>
    </div>
    <div align="center">
        &nbsp;
        <asp:Button ID="btnApprove" runat="server" OnClick="btnShowReport_Click" Text="Approve" />
        <br />
        <br />
    </div>
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="id"
        ShowFooter="True" DataSourceID="SqlDataSource2" CssClass="Grid_1" 
        Width="100%" onprerender="GridView2_PreRender">
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
            <asp:TemplateField HeaderText="Amount">
                <FooterTemplate>
                    <asp:Label ID="LBL_T_Amount" runat="server"></asp:Label>
                </FooterTemplate>
                <ItemTemplate>
                    <asp:Label ID="LBL_Amount" runat="server" Text='<%# Eval("Amount") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Approve" ItemStyle-Width="5px">
                <HeaderTemplate>
                    <asp:CheckBox ID="chk" runat="server" AutoPostBack="True" OnCheckedChanged="chk_CheckedChanged" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="chkApprove" Width="5px" runat="server" />
                    <asp:HiddenField ID="HiddenField_Empid" runat="server" Value='<%# Eval("EmpId") %>' />
                </ItemTemplate>
                <ItemStyle Width="5px"></ItemStyle>
            </asp:TemplateField>
        </Columns>
        <FooterStyle BackColor="#DADADA" Font-Bold="True" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:PayRollConnectionString %>"
        SelectCommand="usp_SearchForApprove" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_SalaryHeads" Name="E_ID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownList_SalaryMonth" Name="SalaryMonth" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownList_SalaryYear" Name="SalaryYear" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="DeptID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="dropdownlist_Hospital" Name="hospitalId" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_PApproved" runat="server" ConnectionString="<%$ ConnectionStrings:PayRollConnectionString %>"
        SelectCommand="select ROW_NUMBER()OVER (ORDER BY Employee.Name) AS [SrNo],  Approved_AllowDeduction.id, Employee.Name, Approved_AllowDeduction.Approve_Date, Approved_AllowDeduction.TotalAmount
 from Approved_AllowDeduction 
		inner join Employee on Employee.EmpID = Approved_AllowDeduction.approve_by
		where Approved_AllowDeduction.id in (
			select ApprovedId from MonthlySalaryDetail where E_ID = @E_ID and SalaryMonth = @SalaryMonth and SalaryYear = @SalaryYear and ApprovedId is not null
		)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_SalaryHeads" Name="E_ID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownList_SalaryMonth" Name="SalaryMonth" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownList_SalaryYear" Name="SalaryYear" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
</asp:Content>
