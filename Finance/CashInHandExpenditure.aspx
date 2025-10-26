<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Finance_CashInHandExpenditure, App_Web_se3xxsm3" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../css/AppMessage.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager runat="server"></asp:ScriptManager>
    <asp:Panel ID="pnlMsg" runat="server">
        <asp:Label ID="lblMessage" runat="server" CssClass="lblErrorSpan" Text=""></asp:Label>
    </asp:Panel>
    <div class="bxmain">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
            <tr>
                <td align="right" width="40%">
                    Select Company :
                </td>
                <td width="60%">
                    <asp:DropDownList ID="DropDownList_Companyname" runat="server" AutoPostBack="True"
                        DataSourceID="SQL_Companyname" DataTextField="Financial_Company_Name" DataValueField="Financial_Company_Id">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" width="40%">
                    Select Branch :
                </td>
                <td width="60%">
                    <asp:DropDownList ID="DropDownList_Branchname" runat="server" AutoPostBack="True"
                        DataSourceID="SQL_Branchname" DataTextField="Company_Branch_Name" DataValueField="Company_Branch_Id">
                    </asp:DropDownList>
                </td>
            </tr>
           <tr>
                <td align="right" width="40%">
                    Mode Of Payment :
                </td>
                <td width="60%">
                    <asp:DropDownList ID="ddlModeOfPayment" runat="server">
                    <asp:ListItem Text="Cash" Value="3205001"></asp:ListItem>
                    <asp:ListItem Text="Bank" Value="3204001"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    From :
                </td>
                <td>
                    <igsch:WebDateChooser ID="WebDateChooserSdate" runat="server" Value="2010-06-18"
                        Width="181px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td align="right">
                    To :
                </td>
                <td>
                    <igsch:WebDateChooser ID="WebDateChooserEDate" runat="server" Value="2010-06-18"
                        Width="181px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td align="right">
                </td>
                <td>
                    <asp:Button ID="Button1" runat="server" Text="Search" />                    
                    <asp:Label ID="Lbl_mg" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
    </rsweb:ReportViewer>
    <br />
    
    <asp:SqlDataSource ID="SQL_Companyname" runat="server" ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>"
        SelectCommand="SELECT 0 AS Financial_Company_Id, 'ALL' AS Financial_Company_Name UNION SELECT Financial_Company_Id, Financial_Company_Name FROM Group_Financial_Companies WHERE (Financial_Company_Id IN (SELECT Financial_Company_ID FROM Employee_Rights_Company_Wise WHERE (Emp_ID = @Emp_ID)))">
        <SelectParameters>
            <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <br />
    <asp:SqlDataSource ID="SQL_Branchname" runat="server" ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>"
        SelectCommand="SELECT 0 AS Company_Branch_Id, 'ALL' AS Company_Branch_Name UNION SELECT Company_Branch_Id, Company_Branch_Name FROM Group_Company_Branches WHERE (Company_Branch_Id IN (SELECT Company_Branch_ID FROM Employee_Rights_Company_Wise WHERE (Emp_ID = @Emp_ID))) AND (CONVERT (varchar, Financial_Company_Id) LIKE CASE @Financial_Company_Id WHEN 0 THEN '%' ELSE CONVERT (varchar , @Financial_Company_Id) END)">
        <SelectParameters>
            <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" />
            <asp:ControlParameter ControlID="DropDownList_Companyname" Name="Financial_Company_Id"
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    
    <asp:HiddenField ID="HiddenFieldEdate" runat="server" />
    <asp:HiddenField ID="HiddenFieldSdate" runat="server" />
    <br />
   
        
    <asp:SqlDataSource ID="SqlDataSourceforGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
        SelectCommand="CashInHandExpenditure" ProviderName="<%$ ConnectionStrings:Finance_ConnectionString.ProviderName %>"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenFieldSdate" Name="S_Date" PropertyName="Value"
                Type="DateTime" />
            <asp:ControlParameter ControlID="HiddenFieldEdate" Name="E_Date" PropertyName="Value"
                Type="DateTime" />            
            <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList_Companyname" Name="Financial_Company_Id"
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList_Branchname" Name="Company_Branch_ID"
                PropertyName="SelectedValue" Type="Int32" />            
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    
</asp:Content>
