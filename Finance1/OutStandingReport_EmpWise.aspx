<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Finance_OutStandingReport_EmpWise, App_Web_ymbcbbcj" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<%@ Register assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" namespace="Infragistics.WebUI.WebSchedule" tagprefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
    <table style="width: 100%; table-layout: auto">
        <tr>
        <td style="width: 48%; text-align :right font-weight: bold;" align="right">Select 
            Financial Company</td>
        <td style="width: 2%; text-align :center; font-weight: bold;">:</td>
        <td style="width: 48%; text-align :left">
            <asp:DropDownList ID="DDL_FC" runat="server" AutoPostBack="True" 
                DataSourceID="SDS_FC" DataTextField="Financial_Company_Name" 
                DataValueField="Financial_Company_ID"  
                onselectedindexchanged="DropDownList1_SelectedIndexChanged">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SDS_FC" runat="server" 
                ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>" 
                SelectCommand="Select 0 as Financial_Company_ID, '   --- All ---'  Financial_Company_Name
Union
SELECT distinct  Employee_Rights_Company_Wise.Financial_Company_ID, Group_Financial_Companies.Financial_Company_Name FROM Group_Financial_Companies INNER JOIN Employee_Rights_Company_Wise ON Group_Financial_Companies.Financial_Company_Id = Employee_Rights_Company_Wise.Financial_Company_ID WHERE (Employee_Rights_Company_Wise.Emp_ID = @Emp_ID)">
                <SelectParameters>
                    <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" />
                </SelectParameters>
            </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
        <td style="width: 48%; text-align :right" align="right">Select&nbsp; Branch</td>
        <td style="width: 2%; text-align :center; font-weight: bold;">:</td>
        <td style="width: 48%; text-align :left">
            <asp:DropDownList ID="DDL_BC" runat="server" 
                DataSourceID="SQS_CB" DataTextField="Company_Branch_Name" 
                DataValueField="Company_Branch_Id">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SQS_CB" runat="server" 
                ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>" 
                SelectCommand="Select 0 as Company_Branch_Id, '  --- All ---' as Company_Branch_Name 
union

SELECT Distinct Group_Company_Branches.Company_Branch_Id, Group_Company_Branches.Company_Branch_Name FROM Group_Company_Branches INNER JOIN Employee_Rights_Company_Wise ON Group_Company_Branches.Company_Branch_Id = Employee_Rights_Company_Wise.Company_Branch_ID WHERE ( @Financial_Company_ID = 0 or Employee_Rights_Company_Wise.Financial_Company_ID = @Financial_Company_ID) AND (Employee_Rights_Company_Wise.Emp_ID = @Emp_ID)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DDL_FC" Name="Financial_Company_ID" 
                        PropertyName="SelectedValue" />
                    <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" />
                </SelectParameters>
            </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
        <td style="width: 48%; text-align :right" align="right"></td>
        <td style="width: 2%; text-align :center; font-weight: bold;">&nbsp;</td>
        <td style="width: 48%; text-align :left"></td>
        </tr>
        <tr>
            <td align="center" colspan="3">
                <asp:Button ID="Btn_Search" runat="server" onclick="Btn_Search_Click" 
                    Text="Search" />
            </td>
        </tr>
        <tr>
            <td align="right" style="width: 48%; text-align :right">
                &nbsp;</td>
            <td style="width: 2%; text-align :center; font-weight: bold;">
                &nbsp;</td>
            <td style="width: 48%; text-align :left">
                &nbsp;</td>
        </tr>
    </table>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="1000px" >
    </rsweb:ReportViewer>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
    ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>" 
                    SelectCommand="Parties_Outstanding_EmpWise"
                    SelectCommandType="StoredProcedure"
    >
    
        <SelectParameters>
           
            <asp:SessionParameter  Name="emp_id" SessionField="emp_id" 
                Type="Int32" />
        </SelectParameters>
    
    </asp:SqlDataSource>
    </ContentTemplate>
    </asp:UpdatePanel>
    
</asp:Content>

