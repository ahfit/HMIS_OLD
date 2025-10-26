<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master"
    AutoEventWireup="true" CodeFile="BudgetSearch.aspx.cs" Inherits="Finance_BudgetSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span>Search Budget</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td align="right" width="50%">
                    Financial Company :
                </td>
                <td align="left" width="50%">
                    <asp:DropDownList ID="DropDownList_FinancialCompany" runat="server" AutoPostBack="True"
                        DataSourceID="SqlDataSource_FinancialCompany" DataTextField="Financial_Company_Name"
                        DataValueField="Financial_Company_Id" OnSelectedIndexChanged="DropDownList_FinancialCompany_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_FinancialCompany" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                        SelectCommand="SELECT     Financial_Company_Id, Financial_Company_Name
                        FROM Group_Financial_Companies"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right" width="50%">
                    Company Branches :
                </td>
                <td align="left" width="50%">
                    <asp:DropDownList ID="DropDownList_CompanyBranches" runat="server" AutoPostBack="True"
                        DataSourceID="SqlDataSource_CompanyBranches" DataTextField="Company_Branch_Name"
                        DataValueField="Company_Branch_Id">
                    </asp:DropDownList>
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
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" 
                        onclick="btnSearch_Click" />
                </td>
            </tr>
        </table>
    </div>
    <div style="margin-top:10px; width:100%;">
        <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataKeyNames="B_ID"
            DataSourceID="SqlDataSource_Budget" Width="100%">
            <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
            <Columns>
                <asp:BoundField DataField="Date_Start" HeaderText="Date Start" SortExpression="Date_Start" />
                <asp:BoundField DataField="Date_End" HeaderText="Date End" SortExpression="Date_End" />
                <asp:BoundField DataField="Entry_Date" HeaderText="Entry Date" SortExpression="Entry_Date" />
                <asp:BoundField DataField="description" HeaderText="Description" SortExpression="description" />
                <asp:BoundField DataField="Financial_Company_Name" HeaderText="Financial Company" SortExpression="Financial_Company_Name" />
                <asp:BoundField DataField="Company_Branch_Name" HeaderText="Company Branch" SortExpression="Company_Branch_Name" />
                <asp:BoundField DataField="Grant_in_Aid" HeaderText="Grant in Aid" SortExpression="Grant_in_Aid" />
                <asp:BoundField DataField="Opening_balance" HeaderText="Opening Balance" SortExpression="Opening_balance" />
                <asp:HyperLinkField DataNavigateUrlFields="B_ID,Date_End" DataNavigateUrlFormatString="Budget_Detail.aspx?B_ID={0}&amp;Date_End={1}"
                    HeaderText="Budget Detail" Text="ADD Detail" Target="_blank" />
                <asp:HyperLinkField DataNavigateUrlFields="Financial_Company_Id,Company_Branch_Id,Date_End,Date_Start,B_ID" DataNavigateUrlFormatString="Revise_Budget_Detail.aspx?Financial_Company_Id={0}&amp;Company_Branch_Id={1}&amp;Date_End={2}&amp;Date_Start={3}&amp;B_ID={4}"
                    Text="Revise Final Budget " Target="_blank"  />
                <asp:HyperLinkField DataNavigateUrlFields="Financial_Company_Id,Company_Branch_Id,Date_End,Date_Start,B_ID" DataNavigateUrlFormatString="CurrentYearBudgetPosition.aspx?Financial_Company_Id={0}&amp;Company_Branch_Id={1}&amp;Date_End={2}&amp;Date_Start={3}&amp;B_ID={4}"
                    HeaderText="Add Current Position" Text="Add Position" Visible="false" />
                    <asp:HyperLinkField DataNavigateUrlFields="B_ID" DataNavigateUrlFormatString="BudgetDistributionReport.aspx?B_ID={0}" Target ="_blank"
                    HeaderText="Distribution Report" Text="Report" />
              
                <asp:HyperLinkField DataNavigateUrlFields="B_ID,Financial_Company_Id,Company_Branch_Id" DataNavigateUrlFormatString="CReport_Revised_Estimates.aspx?B_ID={0}&amp;Financial_Company_Id={1}&amp;Company_Branch_Id={2}&amp;"
                    HeaderText="Current Position Report" Text="Report" Visible = "false" Target="_blank"  />
                <asp:ButtonField CommandName="Select" Text="Approved" Visible="False" />
                <asp:TemplateField ShowHeader="False" Visible="False">
                    <ItemTemplate>
                        <asp:ImageButton ID="ImageButton2" runat="server" CommandName="Delete" Width="10px"
                            Height="11px" ImageUrl="~/images/deletebtn.png" OnClientClick="return confirmation(this)" />
                        <script src="../Validate.js" type="text/javascript"></script>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle CssClass="GridItem" />
            <HeaderStyle CssClass="GridHeader" />
            <AlternatingRowStyle CssClass="GridAltItem" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource_Budget" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
            SelectCommand="SELECT CONVERT (varchar, Budget.Date_Start, 103) AS Date_Start, CONVERT (varchar, Budget.Date_End, 103) AS Date_End, CONVERT (varchar, Budget.Entry_Date, 103) AS Entry_Date, Budget.B_ID, Budget.emp_ID, Budget.description, Budget.Financial_Company_Id, Budget.Company_Branch_Id, Group_Financial_Companies.Financial_Company_Name, Group_Financial_Companies.Financial_Company_Id AS Expr1, Group_Company_Branches.Company_Branch_Id AS Expr2, Group_Company_Branches.Company_Branch_Name, Budget.Opening_balance, Budget.Grant_in_Aid FROM Budget INNER JOIN Group_Financial_Companies ON Budget.Financial_Company_Id = Group_Financial_Companies.Financial_Company_Id INNER JOIN Group_Company_Branches ON Budget.Company_Branch_Id = Group_Company_Branches.Company_Branch_Id WHERE (Budget.Status = 'New') AND (Budget.Financial_Company_Id = @Financial_Company_Id) AND (Budget.Company_Branch_Id = @Company_Branch_Id)" UpdateCommand="UPDATE [Budget] SET [Date_Start] = @Date_Start, [Date_End] = @Date_End, [Entry_Date] = @Entry_Date, [emp_ID] = @emp_ID WHERE [B_ID] = @B_ID">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList_FinancialCompany" 
                    Name="Financial_Company_Id" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="DropDownList_CompanyBranches" 
                    Name="Company_Branch_Id" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
