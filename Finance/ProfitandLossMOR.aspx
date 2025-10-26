<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="false" CodeFile="ProfitandLossMOR.aspx.vb" Inherits="Finance_ProfitandLossMOR" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>

    <div class="bxmain inner_content" style="width: 100%;">
        <h2><span>Profit and Loss Monthly Operating Report</span></h2>
        <table cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
            <tr>
                <td align="right">Select Company:</td>
                <td>
                    <asp:DropDownList ID="DropDownList_Companyname" runat="server"
                        AutoPostBack="True" DataSourceID="SQL_Companyname"
                        DataTextField="Financial_Company_Name" DataValueField="Financial_Company_Id"
                        Width="196px">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SQL_Companyname" runat="server"
                        ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>"
                        SelectCommand="SELECT [Financial_Company_Id], [Financial_Company_Name] FROM [Group_Financial_Companies]"></asp:SqlDataSource>
                    <asp:SqlDataSource ID="SQL_Branchname" runat="server"
                        ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>" SelectCommand="SELECT     Company_Branch_Id, Company_Branch_Name
FROM         Group_Company_Branches
WHERE    Financial_Company_Id=@Financial_Company_Id
 

">
                        <SelectParameters>

                            <asp:ControlParameter ControlID="DropDownList_Companyname"
                                Name="Financial_Company_Id" PropertyName="SelectedValue" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                </td>

                <td align="right">Select Branch:</td>
                <td>
                    <asp:DropDownList ID="DropDownList_Branchname" runat="server"
                        AutoPostBack="False" DataSourceID="SQL_Branchname"
                        DataTextField="Company_Branch_Name" DataValueField="Company_Branch_Id"
                        Width="198px">
                    </asp:DropDownList>

                </td>
                <td align="right">Cost Center :</td>
                <td>
                    <asp:DropDownList ID="ddlCostCenter" runat="server" DataTextField="CostCenterName" DataValueField="CostCenterID">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="4">
                    <div style="color: maroon; font-weight: bold; background-color: antiquewhite; width: 50%; width: 60%; line-height: 25px;">
                        Current
                    </div>
                </td>

                <td align="center" colspan="4">
                    <div style="color: maroon; font-weight: bold; background-color: antiquewhite; width: 50%; width: 60%; line-height: 25px;">
                        Previous
                    </div>
                </td>
            </tr>
            <tr >
                <td align="right">From Date :</td>
                <td>
                    <asp:TextBox ID="txtFromDate1" runat="server" TextMode="Date"></asp:TextBox>

                </td>

                <td align="right">To Date :</td>
                <td>
                    <asp:TextBox ID="txtToDate1" runat="server" TextMode="Date"></asp:TextBox>
                </td>

                <td align="right">From Date :</td>
                <td >
                    <asp:TextBox ID="txtFromDate2" runat="server" TextMode="Date"></asp:TextBox>

                </td>

                <td align="right">To Date :</td>
                <td >
                    <asp:TextBox ID="txtToDate2" runat="server" TextMode="Date"></asp:TextBox>
                </td>

            </tr>
            <tr>
                <td align="center" colspan="8">
                    <asp:Button ID="Button1" runat="server" Text="View Report" />
                </td>
            </tr>
        </table>
    </div>

    <rsweb:ReportViewer ID="ReportViewer1" Width="100%" Height="100%" runat="server">
    </rsweb:ReportViewer>

</asp:Content>

