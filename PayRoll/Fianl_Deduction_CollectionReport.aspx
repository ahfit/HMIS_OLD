<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="PayRoll_Fianl_Deduction_CollectionReport, App_Web_tchaehmk" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register namespace="Infragistics.WebUI.WebSchedule" tagprefix="WebSchedule" %>
<%--<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
--%>
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
            width:50%;
        }
        .style3
        {
            font-weight: bold;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="scriptMangerDeduction" runat="server">
    </asp:ScriptManager>
    <div class="bxmain inner_content" style="width:100%; margin-bottom:10px;">
    <h2><span>Final Deduction Report</span></h2>
    <table class="style1">
        <tr>
            <td class="style2" align="right">
                <strong>Select Month :</strong>
                </td>
                <td>                
                <asp:DropDownList ID="ddlMonth" runat="server" Width="250px" AutoPostBack="true" 
                        onselectedindexchanged="ddlMonth_SelectedIndexChanged">
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
                <asp:DropDownList ID="ddlYear" runat="server" Width="250px" 
                    onselectedindexchanged="ddlYear_SelectedIndexChanged" AutoPostBack="true">
                </asp:DropDownList>
            </td>
        </tr>
        <%--<tr>
            <td class="style3" align="right">
                Employee Type :</td>
            <td>
                <asp:DropDownList ID="ddlEmployeeTypeWise" runat="server" Width="150px" 
                    DataSourceID="SDS_EmployeeTypeWise" DataTextField="Type" 
                    DataValueField="employee_Type_ID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SDS_EmployeeTypeWise" runat="server" ConnectionString="<%$ ConnectionStrings:PayRollConnectionString %>"
                    SelectCommand="select 0 as employee_Type_ID, '---All---' as Type from Employee_Type
union 
select * from Employee_Type"
                    
                    ProviderName="<%$ ConnectionStrings:PayRollConnectionString.ProviderName %>">
                    
                </asp:SqlDataSource>
            </td>
        </tr>--%>
        <tr>
            <td class="style3" align="right" >
                Deductions :</td>
            <td>
                <asp:DropDownList ID="DropDownList1" runat="server" Width="250px" 
                    DataSourceID="SqlDataSource1" DataTextField="Head_Name" DataValueField="E_ID">
                    
                </asp:DropDownList>
                 <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Finance_ConnectionString.ProviderName %>"
                        SelectCommand="SELECT   Distinct     Salary_Allowance_Deduction_Setup.E_ID, Salary_Allowance_Deduction_Setup.Head_Name
FROM            Salary_Allowance_Deduction_Setup INNER JOIN
                         Employee_Salary ON Salary_Allowance_Deduction_Setup.E_ID = Employee_Salary.E_ID
WHERE        (Salary_Allowance_Deduction_Setup.Allowance_Deduction='Deduction') and Employee_Salary.Salary_Month=@Salary_Month and Employee_Salary.Salary_Year=@Salary_Year
ORDER BY Salary_Allowance_Deduction_Setup.Head_Name">
                     <SelectParameters>
                         <asp:ControlParameter ControlID="ddlMonth" Name="Salary_Month" 
                             PropertyName="SelectedValue" />
                         <asp:ControlParameter ControlID="ddlYear" Name="Salary_Year" 
                             PropertyName="SelectedValue" />
                     </SelectParameters>
                    </asp:SqlDataSource>
            </td>
        </tr>
         <tr>
            <td class="style3" align="right" >
                Job Type :</td>
            <td>
                <asp:DropDownList ID="DropDownList_JobType" runat="server" Width="250px">
                            <asp:ListItem Selected="True" Value="">ALL</asp:ListItem>
                            <asp:ListItem Value="Gazzeted">Gazzeted</asp:ListItem>
                            <asp:ListItem Value="Non Gazzeted">Non Gazzeted</asp:ListItem>
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
       
    </table>
    </div>
     <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="98%" Height="700px">
                </rsweb:ReportViewer>
</asp:Content>
