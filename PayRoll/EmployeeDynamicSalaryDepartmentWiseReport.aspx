<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Payroll_EmployeeDynamicSalaryDepartmentWiseReport, App_Web_tchaehmk" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .Allowances
        {
            /*background-color:#e9fba6;*/
            background-color: #e5ff8e;
        }
        .Deduction
        {
            background-color: #fdbc80;
        }
        .NetSalary
        {
            background-color: #e2d673;
        }
        .style1
        {
            width: 100%;
        }
        .style2
        {
        }
        .style3
        {
            font-weight: bold;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span>Employee Salary Report</span></h2>
    <asp:ScriptManager ID="scriptMangerDeduction" runat="server">
    </asp:ScriptManager>
    <table class="style1">
        <tr>
            <td class="style2" align="right">
                <strong>Hospital :</strong></td>
            <td>
                        <asp:DropDownList ID="dropdownlist_Hospital" runat="server" DataSourceID="SqlDataSource_Company"
                            DataTextField="Hospital_Name" DataValueField="Hospital_ID" TabIndex="5" Width="30%"
                            AutoPostBack="True">
                        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource_Company" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
            SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="style2" align="right">
                <strong>Select Department :</strong>
            </td>
            <td>
                <asp:DropDownList ID="DDL_Dept" runat="server" Width="30%" DataSourceID="SDS_Branch" AutoPostBack="True"
                    DataTextField="Dept_Name" DataValueField="Dept_ID" OnSelectedIndexChanged="DDL_Dept_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SDS_Branch" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    SelectCommand="Select 0 as Dept_ID, '---ALL---' as Dept_Name
union
SELECT     Dept_ID, Dept_Name
FROM         Department
WHERE     (Hospital_ID = @Hospital_ID)
ORDER BY Dept_Name">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="dropdownlist_Hospital" Name="Hospital_ID" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="style2" align="right">
                <strong>Select Employee :</strong>
            </td>
            <td>
                <asp:DropDownList ID="DDL_Emp" runat="server" Width="30%" DataSourceID="SDS_Employee"
                    DataTextField="Name" DataValueField="EmpID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SDS_Employee" runat="server" ConnectionString="<%$ ConnectionStrings:PayRollConnectionString %>"
                    SelectCommand="SELECT 0 AS EmpID, ' ---ALL---' AS Name UNION SELECT EmpID, Name FROM Employee where len(Name) > 0 and Employee.Dept_ID=@Dept_ID  ORDER BY Name"
                    ProviderName="<%$ ConnectionStrings:PayRollConnectionString.ProviderName %>">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DDL_Dept" Name="Dept_ID" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="style2" align="right">
                <strong>Select Month :</strong>
                </td>
                <td>                
                <asp:DropDownList ID="ddlMonth" runat="server" Width="30%">
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
                <strong>Select Year :</strong>
            </td>
            <td>
                <asp:DropDownList ID="ddlYear" runat="server" Width="30%">
                </asp:DropDownList>
            </td>
        </tr>
        
        <tr>
            <td class="style2">
                &nbsp;
            </td>
            <td>
                <asp:Button ID="btn_Report" runat="server" Text="View Report" OnClick="btn_Report_Click" />
            </td>
        </tr>
        <tr>
            <td class="style2">
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td class="style2" colspan="2">
            </td>
        </tr>
        <tr>
            <td class="style2" colspan="2">
              
                <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="98%" Height="700px">
                </rsweb:ReportViewer>
            </td>
        </tr>
    </table>
       </div> 
</asp:Content>
