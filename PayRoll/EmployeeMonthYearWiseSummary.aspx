<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="PayRoll_EmployeeMonthYearWiseSummary, App_Web_tchaehmk" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" namespace="Infragistics.WebUI.WebSchedule" tagprefix="igsch" %>
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
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="scriptMangerDeduction" runat="server">
    </asp:ScriptManager>
    <table class="style1">
        <tr>
            <td class="style2" align="right">
                <strong>Start Date :</strong>
            </td>
            <td>
                        <igsch:WebDateChooser Width="180px" runat="server" ID="startdate">
                                    </igsch:WebDateChooser>
            </td>
        </tr>
        <tr>
            <td class="style2" align="right">
                <strong>End Date :</strong>
            </td>
            <td>
                        <igsch:WebDateChooser Width="180px" runat="server" ID="Enddate">
                                    </igsch:WebDateChooser>
            </td>
        </tr>
          <tr>
            <td class="style3" align="right" >
                Deductions :</td>
            <td>
                <asp:DropDownList ID="DropDownList1" runat="server" Width="150px" 
                    DataSourceID="SqlDataSource1" DataTextField="Head_Name" DataValueField="E_ID">
                    
                </asp:DropDownList>
                 <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Finance_ConnectionString.ProviderName %>"
                        SelectCommand="select 0 as E_ID, 'All' as Head_Name union select E_ID,Head_Name from Salary_Allowance_Deduction_Setup where Allowance_Deduction='Deduction' order by E_ID asc

">
                    </asp:SqlDataSource>
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
</asp:Content>
