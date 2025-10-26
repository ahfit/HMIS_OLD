<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/hacims_masterpage_admin.master"
    CodeFile="GeneralLedgerExpenditureByHeadReport.aspx.vb" Inherits="Finance_GeneralLedgerExpenditureByHeadReport" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
     function ClientItemSelected2(sender, e) {
         $get("<%=hfE_Code.ClientID %>").value = e.get_value();
        }
    </script>
    <link href="../css/AppMessage.css" rel="stylesheet" type="text/css" />
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <asp:Panel ID="pnlMsg" runat="server">
        <asp:Label ID="lblMessage" runat="server" CssClass="lblErrorSpan" Text=""></asp:Label>
    </asp:Panel>
    <div class="bxmain inner_content" style="width: 100%">
        <h2>
            <span>Party Ledger by Head</span></h2>
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
                <td align="right">
                    Select Cost Centre :</td>
                <td>
                    <asp:DropDownList ID="DropDownList_CostCentre" runat="server"
                        DataSourceID="SQL_CostCentre" DataTextField="CostCenterName" DataValueField="CostCenterID"  Width="213px">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SQL_CostCentre" runat="server" ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>"
        SelectCommand="SELECT  0 CostCenterID, '   --- All --- 'CostCenterName
Union
SELECT  CostCenterID, CostCenterName   FROM CostCenter">
    </asp:SqlDataSource>
                </td>
            </tr>

             <tr>
                <td align="right">
                    Select Head :</td>
                <td>
         <asp:TextBox ID="txtHeadName" runat="server" AutoPostBack="true"></asp:TextBox>
                                    <asp:AutoCompleteExtender ID="Auto_Names_Extender" runat="server" ServiceMethod="SearchHead" OnClientItemSelected="ClientItemSelected2"
                        MinimumPrefixLength="2" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                        TargetControlID="txtHeadName" FirstRowSelected="true" ></asp:AutoCompleteExtender>
                    <asp:HiddenField ID="hfE_Code" runat="server" />
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
                    &nbsp;
                </td>
                <td colspan="3" style="text-align:Left;padding-left:10px;">
                    <asp:RadioButtonList ID="DDLVoucher" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Selected="True" Value="2">All</asp:ListItem>
                        <asp:ListItem  Value="1">Posted</asp:ListItem>
                        <asp:ListItem  Value="0">UnPosted</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td align="right">
                </td>
                <td>
                    <asp:Button ID="Btn_Print" runat="server" Text="Print Report"  />
                </td>
            </tr>
        </table>
    </div>
    <div>
       
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
    </rsweb:ReportViewer>
    </div>
    <br />
    
    <asp:SqlDataSource ID="SQL_Companyname" runat="server" ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>"
        SelectCommand="SELECT 0 AS Financial_Company_Id, 'ALL' AS Financial_Company_Name UNION SELECT Financial_Company_Id, Financial_Company_Name FROM Group_Financial_Companies WHERE (Financial_Company_Id IN (SELECT Financial_Company_ID FROM Employee_Rights_Company_Wise WHERE (Emp_ID = @Emp_ID)))">
        <SelectParameters>
            <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQL_Branchname" runat="server" ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>"
        SelectCommand="SELECT 0 AS Company_Branch_Id, 'ALL' AS Company_Branch_Name UNION SELECT Company_Branch_Id, Company_Branch_Name FROM Group_Company_Branches WHERE (Company_Branch_Id IN (SELECT Company_Branch_ID FROM Employee_Rights_Company_Wise WHERE (Emp_ID = @Emp_ID))) AND (CONVERT (varchar, Financial_Company_Id) LIKE CASE @Financial_Company_Id WHEN 0 THEN '%' ELSE CONVERT (varchar , @Financial_Company_Id) END)">
        <SelectParameters>
            <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" />
            <asp:ControlParameter ControlID="DropDownList_Companyname" Name="Financial_Company_Id"
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
   
    <asp:SqlDataSource ID="SqlDataSource_EH" runat="server" ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>"
        DeleteCommand="DELETE FROM [Expenditure_Heading] WHERE [EH_Code] = @EH_Code"
        InsertCommand="INSERT INTO [Expenditure_Heading] ([EH_Code], [EH_Name]) VALUES (@EH_Code, @EH_Name)"
        SelectCommand="SELECT [EH_Code], [EH_Name] FROM [Expenditure_Heading]" UpdateCommand="UPDATE [Expenditure_Heading] SET [EH_Name] = @EH_Name WHERE [EH_Code] = @EH_Code"
        ProviderName="<%$ ConnectionStrings:FinanceConnectionString.ProviderName %>">
        <DeleteParameters>
            <asp:Parameter Name="EH_Code" Type="String" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="EH_Name" Type="String" />
            <asp:Parameter Name="EH_Code" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="EH_Code" Type="String" />
            <asp:Parameter Name="EH_Name" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldEdate" runat="server" />
    <asp:HiddenField ID="HiddenFieldSdate" runat="server" />
    
    <br />
    
</asp:Content>
