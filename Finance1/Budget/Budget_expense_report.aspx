<%@ Page Title="" Language="VB" MasterPageFile="~/Hacims_MasterPage_Admin_New.master" AutoEventWireup="false" CodeFile="Budget_expense_report.aspx.vb" Inherits="Finance_Budget_expense_report" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script type="text/javascript">
    function ClientItemSelected(sender, e) {
        $get("<%=HFD_F_Head.ClientID %>").value = e.get_value();
    }
 
    </script>
    <style type="text/css">
        .RowRight
        {

        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <table class="diagnosis_list">
        <tr>
            <td align="right" width="50%">Financial Company : </td>
            <td>
                <asp:DropDownList ID="DropDownList_FinancialCompany" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_FinancialCompany" DataTextField="Financial_Company_Name" DataValueField="Financial_Company_Id" onselectedindexchanged="DropDownList_FinancialCompany_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td align="right" width="50%">Company Branches : </td>
            <td>
                <asp:DropDownList ID="DropDownList_CompanyBranches" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_CompanyBranches" DataTextField="Company_Branch_Name" DataValueField="Company_Branch_Id">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td align="right" width="50%">Start Date : </td>
            <td>
                <asp:TextBox ID="Txt_S_date" runat="server" TextMode="Date"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right" width="50%">
    
                End Date :</td>
            <td>
                <asp:TextBox ID="Txt_E_date" runat="server" TextMode="Date"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right" width="50%">
    
                Financial
    
                Head :</td>
            <td>
                <asp:TextBox ID="TXT_Financial_Head" runat="server" BackColor="LightPink" 
                    Height="21px" MaxLength="10"></asp:TextBox>
               
                <asp:AutoCompleteExtender ID="Auto_Head_Find" runat="server" 
                    CompletionInterval="100" CompletionSetCount="10" FirstRowSelected="true" 
                    MinimumPrefixLength="1" OnClientItemSelected="ClientItemSelected" 
                    ServiceMethod="SearchFinacial_Head" TargetControlID="TXT_Financial_Head">
                </asp:AutoCompleteExtender>
                <asp:HiddenField ID="HFD_F_Head" runat="server" Value="" />
            </td>
        </tr>
        <tr>
            <td align="center" colspan="2" >&nbsp;</td>
        </tr>
        <tr>
            <td align="center" colspan="2" >
                <asp:Button ID="Btn_view" runat="server" Text="View" />
            </td>
        </tr>
        <tr>
            <td align="center" colspan="2" >&nbsp;</td>
        </tr>
        <tr>
            <td align="center" colspan="2" ><rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%"></rsweb:ReportViewer></td>
        </tr>
        <tr>
            <td align="center" colspan="2" >&nbsp;</td>
        </tr>
        <tr>
            <td align="center" colspan="2" >&nbsp;</td>
        </tr>
        <tr>
            <td align="center" colspan="2" >
        <asp:SqlDataSource ID="SqlDataSource_FinancialCompany" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
            SelectCommand="SELECT     Financial_Company_Id, Financial_Company_Name
FROM         Group_Financial_Companies"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_CompanyBranches" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
            SelectCommand="SELECT     Group_Company_Branches.Company_Branch_Id, Group_Company_Branches.Company_Branch_Name, Group_Company_Branches.Financial_Company_Id
FROM         Group_Company_Branches INNER JOIN
                      Group_Financial_Companies ON Group_Company_Branches.Financial_Company_Id = Group_Financial_Companies.Financial_Company_Id
WHERE Group_Company_Branches.Financial_Company_Id=@Financial_Company_Id">
<SelectParameters>
    <asp:ControlParameter ControlID="DropDownList_FinancialCompany" Name="Financial_Company_Id"
                    PropertyName="SelectedValue" />
</SelectParameters>

</asp:SqlDataSource>
        
                <br />
        
        
            </td>
        </tr>
        </table>
    <asp:SqlDataSource ID="SDS_Report"  ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
         
        ProviderName="<%$ ConnectionStrings:Finance_ConnectionString.ProviderName %>" 
        SelectCommandType ="StoredProcedure" SelectCommand ="Budget_Expense_detail" 
        runat="server" CancelSelectOnNullParameter="False">
             <SelectParameters>
                 <asp:ControlParameter ControlID="Txt_S_date" Name="S_date" PropertyName="Text" Type="DateTime" />
                 <asp:ControlParameter ControlID="Txt_E_date" Name="E_date" PropertyName="Text" Type="DateTime" />
                 <asp:ControlParameter ControlID="DropDownList_CompanyBranches" Name="company_branch_ID" PropertyName="SelectedValue" Type="Int32" />
              <asp:ControlParameter ControlID="HFD_F_Head" Name="HeadCode" PropertyName="Value" Type="String" />
            </SelectParameters>


    </asp:SqlDataSource>
</asp:Content>

