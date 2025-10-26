<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="PayRoll_Employee_Allow_Deduction, App_Web_tchaehmk" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%--<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .Allowances
        {
            /*background-color:#e9fba6;*/
            background-color:#e5ff8e;
        }
        .Deduction
        {
            background-color:#fdbc80;
        }
        .NetSalary
        {
            background-color:#e2d673;
            }
        .style1
        {
            width: 100%;
        }
        .style2
        {
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="scriptMangerDeduction" runat="server"></asp:ScriptManager>
    <table class="style1">
        <tr>
            <td class="style2" align="right">
                <strong>Select Hospital :</strong> </td>
            <td>
              <asp:DropDownList ID="DDL_Company" runat="server" 
                  Width="30%" DataSourceID="SDS_Company" DataTextField="Hospital_Name" 
                  DataValueField="Hospital_ID" 
                    onselectedindexchanged="DDL_Company_SelectedIndexChanged" 
                    AutoPostBack="True">
              </asp:DropDownList>


          
          
          <asp:SqlDataSource ID="SDS_Company" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
        SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]">
    </asp:SqlDataSource>


          
          
            </td>
        </tr>
        <tr>
            <td class="style2" align="right">
                <strong>Select Group :</strong></td>
            <td>
                <asp:DropDownList ID="ddl_group" runat="server" 
                  Width="30%" DataSourceID="SDS_group" DataTextField="Group_Name" 
                  DataValueField="Salary_group_id" 
                    onselectedindexchanged="DDL_Company_SelectedIndexChanged" 
                    AutoPostBack="True">
              </asp:DropDownList>
                <br />
                <asp:SqlDataSource ID="SDS_group" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
                    SelectCommand="SELECT [Salary_group_id] ,[Group_Name] FROM [PayRoll].[dbo].[Salary_Group]  where [hospital_id] =@hospital_id">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DDL_Company" Name="hospital_id" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
</td>
        </tr>
        <tr>
            <td class="style2" align="right">
                <strong>Select Department :</strong></td>
            <td>
              <asp:DropDownList ID="DDL_Branch" runat="server" 
                  Width="30%" DataSourceID="SDS_Branch" DataTextField="Dept_Name" 
                  DataValueField="Dept_ID">
              </asp:DropDownList>


          
          
          <asp:SqlDataSource ID="SDS_Branch" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
        SelectCommand="Select 0 as Dept_ID, '---ALL---' as Dept_Name
union
SELECT     Dept_ID, Dept_Name
FROM         Department
WHERE     (Hospital_ID = 4)
ORDER BY Dept_Name" >
              <SelectParameters>
                  <asp:ControlParameter ControlID="DDL_Company" Name="HospitalID" 
                      PropertyName="SelectedValue" />
                      <asp:ControlParameter ControlID="ddl_group" Name="Salary_Group_No" 
                      PropertyName="SelectedValue" />
              </SelectParameters>
    </asp:SqlDataSource>


          
          
            </td>
        </tr>
        <tr>
            <td class="style2" align="right">
                <strong>Select Month :</strong></td>
            <td>
                <asp:DropDownList ID="ddlMonth" runat="server" 
                    Width="150px">
                    
                    <asp:ListItem Value="1">Jan</asp:ListItem>
                    <asp:ListItem Value="2">Feb</asp:ListItem>
                    <asp:ListItem Value="3">Mar</asp:ListItem>
                    <asp:ListItem Value="4">Apr</asp:ListItem>
                    <asp:ListItem Value="5">May</asp:ListItem>
                    <asp:ListItem Value="6">Jun</asp:ListItem>
                    <asp:ListItem Value="7">Jul</asp:ListItem>
                    <asp:ListItem Value="8">Aug</asp:ListItem>
                    <asp:ListItem Value="9">Sep</asp:ListItem>
                    <asp:ListItem Value="10">Oct</asp:ListItem>
                    <asp:ListItem Value="11">Nov</asp:ListItem>
                    <asp:ListItem Value="12">Dec</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="style2" align="right">
                <strong>Select Year :</strong></td>
            <td>
                <asp:DropDownList ID="ddlYear" runat="server" Width="150px">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="style2" align="right">
                <strong>Select Employee :</strong></td>
            <td>
              <asp:DropDownList ID="DDL_Sold_By" runat="server" 
                  Width="30%" DataSourceID="SDS_Employee" DataTextField="Name" 
                  DataValueField="EmpID">
              </asp:DropDownList>


          
          
          <asp:SqlDataSource ID="SDS_Employee" runat="server" 
        ConnectionString="<%$ ConnectionStrings:PayRollConnectionString %>" 
        SelectCommand="SELECT 0 AS EmpID, ' ---ALL---' AS Name UNION SELECT EmpID, Name FROM Employee where len(Name) > 0 ORDER BY Name" 
                    
                    
                    ProviderName="<%$ ConnectionStrings:PayRollConnectionString.ProviderName %>">
    </asp:SqlDataSource>


          
          
            </td>
        </tr>
        <tr>
            <td class="style2">
                &nbsp;</td>
            <td>
                <asp:Button ID="btn_search" runat="server" Text="Search" 
                    onclick="btn_search_Click" />
                <asp:Button ID="btn_Report" runat="server" Text="View Report" 
                    onclick="btn_Report_Click" />
            </td>
        </tr>
        <tr>
            <td class="style2">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style2" colspan="2">
                <asp:GridView ID="GV_Employee_Allowance_Deduction" runat="server" 
                    AutoGenerateColumns="False" DataSourceID="SDS_Employee_All_Deduction" 
                    onselectedindexchanged="GV_Employee_Allowance_Deduction_SelectedIndexChanged" 
                    Width="100%" DataKeyNames="EmpID" AllowPaging="True" PageSize="50">
                    <Columns>
                        <asp:BoundField DataField="Emp_No" HeaderText="Emp_No" 
                            SortExpression="Emp_No" Visible="False" />
                        <asp:BoundField DataField="EmpID" HeaderText="EmpID" ReadOnly="True" 
                            SortExpression="EmpID" />
                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                        <asp:BoundField DataField="Designation" HeaderText="Designation" 
                            SortExpression="Designation" />
                        <asp:BoundField DataField="SubDept_Name" HeaderText="SubDept_Name" 
                            ReadOnly="True" SortExpression="SubDept_Name" Visible="False" />
                        <asp:BoundField DataField="Department" HeaderText="Department" 
                            SortExpression="Department" />
                        <asp:BoundField DataField="PayScale" HeaderText="PayScale" ReadOnly="True" 
                            SortExpression="PayScale" Visible="False" />
                        <asp:BoundField DataField="Basic_Pay" HeaderText="B.P" ReadOnly="True" 
                            SortExpression="Basic_Pay" />
                        <asp:BoundField DataField="Increment" HeaderText="Inc." ReadOnly="True" 
                            SortExpression="Increment" />
                        <asp:BoundField DataField="ARREAR" HeaderText="ARR." 
                            ReadOnly="True" SortExpression="ARREAR" ConvertEmptyStringToNull="False" />
                        <asp:BoundField DataField="Conveyance_Allowance" HeaderText="Con. Allowance" ReadOnly="True" 
                            SortExpression="Conveyance_Allowance" />
                        <asp:BoundField DataField="Charge_Extra_Duty" HeaderText="Extra_Duty" 
                            ReadOnly="True" SortExpression="Charge_Extra_Duty" />
                        <asp:BoundField DataField="HouseKeeping" HeaderText="H.K" ReadOnly="True" 
                            SortExpression="HouseKeeping" />
                        <asp:BoundField DataField="Salary_Payable" HeaderText="S. Payable" 
                            ReadOnly="True" SortExpression="Salary_Payable" />
                        <asp:BoundField DataField="IT" HeaderText="IT" ReadOnly="True" 
                            SortExpression="IT" />
                        <asp:BoundField DataField="ELECTRICITY" HeaderText="ELEC." ReadOnly="True" 
                            SortExpression="ELECTRICITY" />
                        <asp:BoundField DataField="EOBI" HeaderText="EOBI" ReadOnly="True" 
                            SortExpression="EOBI" />
                        <asp:BoundField DataField="SUI_GAS" HeaderText="SUI_GAS" 
                            ReadOnly="True" SortExpression="SUI_GAS" />
                        <asp:BoundField DataField="MESS" HeaderText="MESS" ReadOnly="True" 
                            SortExpression="MESS" />
                        <asp:BoundField DataField="Advances_to_Staff" HeaderText="Adv.To Staff" 
                            ReadOnly="True" SortExpression="Advances_to_Staff" />
                        <asp:BoundField DataField="TELEPHONE" HeaderText="TELEP" ReadOnly="True" 
                            SortExpression="TELEPHONE" />
                        <asp:BoundField DataField="Mobilink_Bill" HeaderText="M. Bill" ReadOnly="True" 
                            SortExpression="Mobilink_Bill" />
                        <asp:BoundField DataField="CABLE" HeaderText="CABLE" ReadOnly="True" 
                            SortExpression="CABLE" />
                        <asp:BoundField DataField="StaffMess" HeaderText="StaffMess" ReadOnly="True" 
                            SortExpression="StaffMess" />
                    </Columns>
                    <HeaderStyle BackColor="Silver" />
                </asp:GridView>

          
          <asp:SqlDataSource ID="SDS_Employee_All_Deduction" runat="server" 
        ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>" 
        SelectCommand="Employee_AllowanceDeduction_rpt" 
                    SelectCommandType="StoredProcedure">
              <SelectParameters>
                  <asp:ControlParameter ControlID="ddlMonth" Name="SalaryMonth" 
                      PropertyName="SelectedValue" Type="Int16" />
                  <asp:ControlParameter ControlID="ddlYear" Name="SalaryYear" 
                      PropertyName="SelectedValue" Type="Int16" />
                  <asp:ControlParameter ControlID="DDL_Sold_By" Name="Emp_ID" 
                      PropertyName="SelectedValue" Type="Int32" />
                  <asp:ControlParameter ControlID="DDL_Branch" Name="Dept_Id" 
                      PropertyName="SelectedValue" Type="Int32" />
                  <asp:ControlParameter ControlID="DDL_Company" Name="Hospital_Id" 
                      PropertyName="SelectedValue" Type="Int32" />
              </SelectParameters>
    </asp:SqlDataSource>



 
 
 
 
 
            
          
          
            </td>
        </tr>
        <tr>
            <td class="style2" colspan="2">
                <%--<rsweb:ReportViewer ID="ReportViewer1" width="100%" runat="server">
                </rsweb:ReportViewer>--%>
                <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="98%" 
                    Height="700px">
                </rsweb:ReportViewer>
            </td>
        </tr>
    </table>
</asp:Content>

