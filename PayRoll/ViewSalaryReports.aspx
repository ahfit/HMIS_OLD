<%@ page title="" language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="PayRoll_ViewSalaryReports, App_Web_xk2k0ijz" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%--<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div style="width: 100%;">
        <table style="width: 50%; margin: auto;">
            <tr>
                <td>
                    Hospital
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_Hospital" runat="server" DataSourceID="SqlDataSource_Hospital"
                        AppendDataBoundItems="True" DataTextField="Hospital_Name" 
                        DataValueField="Hospital_ID" AutoPostBack="True">
                       </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Hospital" CancelSelectOnNullParameter="false" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]" 
                        runat="server"></asp:SqlDataSource>
                </td>
                <td>
                    Allowances And Deductions 
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_AllowncesDeductions" runat="server"
                        AppendDataBoundItems="True" AutoPostBack="True">
                        
                        <asp:ListItem Value="0">Both</asp:ListItem>
                        
                        <asp:ListItem Value="2">Allowance</asp:ListItem>
                        <asp:ListItem Value="1">Deduction</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    Department
                </td>
                <td>
                    <asp:DropDownList ID="ddlDepartment" runat="server" 
                        DataSourceID="sqlDs_Department" DataTextField="Dept_Name" 
                        DataValueField="Dept_ID">
                        <asp:ListItem Text=" --- All --- " Value="0"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sqlDs_Department" CancelSelectOnNullParameter="false" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="select 0 as Dept_ID ,'---ALL---' as Dept_Name Union SELECT     Dept_ID, Dept_Name
FROM         Department
where Hospital_ID = @HospitalID
ORDER BY Dept_Name" runat="server">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownList_Hospital" Name="HospitalID" 
                                PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
                <td>
                    Account Head</td>
                <td>
                    <asp:DropDownList ID="ddlAccountHead" runat="server" DataSourceID="sqlDs_AccountHead"
                        AppendDataBoundItems="false" DataTextField="E_Name" DataValueField="E_ID">
                                            </asp:DropDownList>
                    <asp:SqlDataSource ID="sqlDs_AccountHead" CancelSelectOnNullParameter="false" ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>"
                        
                        SelectCommand="

    Select 0 as E_ID, 1 as Sort_Order, '--- ALL ---' as Allowance_Deduction, 0 as E_Code, '--- ALL ---' as E_Name
union

SELECT Salary_Allowance_Deduction_Setup.E_ID, Salary_Allowance_Deduction_Setup.Sort_Order, Salary_Allowance_Deduction_Setup.Allowance_Deduction, Cast(Salary_Allowance_Deduction_Setup.E_ID as varchar) E_Code, Salary_Allowance_Deduction_Setup.Head_Name E_Name FROM          Salary_Allowance_Deduction_Setup 
where (Salary_Allowance_Deduction_Setup.Allowance_Deduction Is Not Null) " 
                        runat="server">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownList_AllowncesDeductions" 
                                Name="AllowanceDeduction" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td>
                    Designation</td>
                <td>
                    <asp:DropDownList ID="ddlDesign" runat="server" DataSourceID="sqlDs_Design" DataTextField="Designation_Name"
                        AppendDataBoundItems="true" DataValueField="Designation_ID">
                        <asp:ListItem Text=" --- All --- " Value="0"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sqlDs_Design" CancelSelectOnNullParameter="false"  ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="
SELECT     Designation_ID, Designation_Name
FROM         Designation
ORDER BY Designation_Name" runat="server"></asp:SqlDataSource>
                </td>
                <td>
                    Employee
                </td>
                <td>
                    <asp:DropDownList ID="ddlEmployee" runat="server" DataSourceID="sqlDs_Employee" DataTextField="Employee_Name"
                        AppendDataBoundItems="true" DataValueField="EmpID">
                        <asp:ListItem Text=" --- All --- " Value="0"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sqlDs_Employee" CancelSelectOnNullParameter="false" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="SELECT [EmpID]      ,IsNull([Prefix],'') + ' ' + isNull(EFName,'') + ' ' + isnull(EMName,'') + ' ' +		ISNULL(elname,'') Employee_Name  FROM [Employee]  where Len(EFName) > 0 order by EFName"
                        runat="server"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td>
                    Year
                </td>
                <td>
                    <asp:DropDownList ID="ddlYear" runat="server">
                    </asp:DropDownList>
                </td>
                <td>
                    Month
                </td>
                <td>
                    <asp:DropDownList ID="ddlMonth" runat="server" DataSourceID="sqlDsMonth" DataTextField="Month_Name"
                        DataValueField="Month_No">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sqlDsMonth" CancelSelectOnNullParameter="false" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="SELECT     Month_No, Month_Name, Month_Abb
FROM         Year_Months
ORDER BY Month_No" runat="server"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
                <td>
                    Emp No</td>
                <td>
                    <asp:TextBox ID="txtbox_EmpNo" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <div style="width: 200px; margin: auto;">
                        <asp:Button ID="btnViewReport" runat="server" Text="View  Report" />
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <rsweb:ReportViewer ID="ReportViewer1" Width="98%" Height="600px" ProcessingMode="local"
        runat="server">
    </rsweb:ReportViewer>
    <asp:SqlDataSource ID="sqlDsSalaryReport" CancelSelectOnNullParameter="false" runat="server" ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>"
        SelectCommand="usp_GetEmployeeSalaryDetailData" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="Year" Type="Int32" />
            <asp:Parameter Name="Month" Type="Int32" />
            <asp:Parameter Name="E_ID" Type="Int32" />
            <asp:Parameter Name="DesignationID" Type="Int32" />
            <asp:Parameter Name="Dept_Id" Type="Int32" />
            <asp:Parameter Name="Emp_Id" Type="Int32" />
            <asp:Parameter Name="AllowanceDeduction" Type="String" />
            <asp:Parameter Name="hospitalID" Type="Int32" />
            <asp:Parameter Name="Emp_No" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDsSalaryYearlyReport" CancelSelectOnNullParameter="false"
     runat="server" ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>"
        SelectCommand="usp_GetEmployeeSalaryYearlyData" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="Year" Type="Int32" />
            <asp:Parameter Name="E_ID" Type="Int32" />
            <asp:Parameter Name="DesignationID" Type="Int32" />
            <asp:Parameter Name="Dept_Id" Type="Int32" />
            <asp:Parameter Name="Emp_Id" Type="Int32" />
            <asp:Parameter Name="AllowanceDeduction" Type="String" />
            <asp:Parameter Name="hospitalID" Type="Int32" />
             <asp:Parameter Name="Emp_No" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDsSalaryAllowDeductionReports" CancelSelectOnNullParameter="false" runat="server" ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>"
        SelectCommand="usp_GetEmployeePayableSalary" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="Year" Type="Int32" />
            <asp:Parameter Name="Month" Type="Int32" />
            <asp:Parameter Name="E_ID" Type="Int32" />
            <asp:Parameter Name="DesignationID" Type="Int32" />
            <asp:Parameter Name="Dept_Id" Type="Int32" />
            <asp:Parameter Name="Emp_Id" Type="Int32" />
            <asp:Parameter Name="AllowanceDeduction" Type="String" />
            <asp:Parameter Name="hospitalID" Type="Int32" />
             <asp:Parameter Name="Emp_No" Type="String" />

        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
