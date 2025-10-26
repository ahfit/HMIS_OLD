<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/hacims_masterpage_admin.master"
    CodeFile="Budget.aspx.cs" Inherits="Budget" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <div class="bxmain inner_content" style="width: 100%;">
            <h2>
                <span>Budget </span>
            </h2>
            <table width="100%" cellpadding="0" cellspacing="0" class="tbl_form">
                <tr>
                    <td>
                        <table width="100%" cellpadding="0" cellspacing="0" class="tbl_form">
                            <tr>
                                <td align="right">
                                    Financial Company:
                                </td>
                                <td width="64%">
                                    <asp:DropDownList ID="DropDownList_FinancialCompany" runat="server" AutoPostBack="True"
                                        DataSourceID="SqlDataSource_FinancialCompany" DataTextField="Financial_Company_Name"
                                        DataValueField="Financial_Company_Id" OnSelectedIndexChanged="DropDownList_FinancialCompany_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <asp:LinkButton ID="lbl_Financial_Company" runat="server" CssClass="add_icon" OnClick="lbl_Financial_Company_Click">Add</asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Company Branches:
                                </td>
                                <td width="64%">
                                    <asp:DropDownList ID="DropDownList_CompanyBranches" runat="server" AutoPostBack="True"
                                        DataSourceID="SqlDataSource_CompanyBranches" DataTextField="Company_Branch_Name"
                                        DataValueField="Company_Branch_Id">
                                    </asp:DropDownList>
                                    <asp:LinkButton ID="lbl_Company_Branch" runat="server" CssClass="add_icon" OnClick="lbl_Company_Branch_Click">Add</asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Date Start :
                                </td>
                                <td width="64%">
                                    <asp:Label ID="Label_start_day" runat="server" Text="1"></asp:Label>&nbsp; - &nbsp;<asp:Label
                                        ID="Label_start_month" runat="server" Text="July"></asp:Label>-&nbsp; &nbsp;
                                    <asp:TextBox ID="TextBox_start_year" runat="server" Width="55px" required ="" SkinID ="intdata" TextMode = "Number" min ="2000" max = "2051" MaxLength ="4"></asp:TextBox>&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Date End :
                                </td>
                                <td>
                                    <asp:Label ID="Label_end_day" runat="server" Text="30"></asp:Label>&nbsp; - &nbsp;<asp:Label
                                        ID="Label_end_month" runat="server" Text="Jun"></asp:Label>- &nbsp;&nbsp;<asp:TextBox
                                            ID="TextBox_end_Year" runat="server" CssClass="input_txt" Width="55px"  required ="" SkinID ="intdata" TextMode = "Number" min ="2001" max = "2050" MaxLength ="4"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Description :&nbsp;
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBox_description" runat="server" TextMode="MultiLine" CssClass="input_txt"
                                        Height="65px" Width="90%"></asp:TextBox>
                                </td>
                            </tr>
                            <tr style="display:none;" >
                                <td align="right">
                                    Opening Balance :
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_OP_balance" SkinID="intdata" TextMode="number" runat="server" min ="0"></asp:TextBox>
                                </td>
                            </tr> 
                           
                            <tr style="display:none;">
                                <td align="right">
                                    Receipt :
                                </td>
                                <td>
                                    <asp:TextBox ID="txtboxReceipt" runat="server" SkinID="intdata" TextMode="number"  min ="0"></asp:TextBox>
                                </td>
                            </tr>
                            <tr style="display:none;">
                                <td align="right">
                                    Other :
                                </td>
                                <td>
                                    <asp:TextBox ID="txtboxOther" runat="server" SkinID="intdata" TextMode="number"  min ="0"></asp:TextBox>
                                </td>
                            </tr>
                             <tr style="visibility:hidden;">
                                <td align="right">
                                    Grant in Aid :
                                </td>
                                <td>
                                    <asp:TextBox ID="TXT_Grant" runat="server" SkinID="intdata" TextMode="number"  min ="0"></asp:TextBox>
                                </td>
                            </tr>



                            <tr>
                                <td align="right">
                                    &nbsp;
                                </td>
                                <td>
                                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Save" />
                                    <asp:Label ID="Label_error" runat="server" Visible="False" ForeColor="Red"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <asp:SqlDataSource ID="SqlDataSource_FinancialCompany" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
            SelectCommand="SELECT     Financial_Company_Id, Financial_Company_Name
                        FROM Group_Financial_Companies"></asp:SqlDataSource>
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
        <asp:HiddenField ID="HiddenField_B_ID" runat="server" />
        <br />
        <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataKeyNames="B_ID"
            DataSourceID="SqlDataSource_Budget" Width="100%" OnSelectedIndexChanged="GridView4_SelectedIndexChanged">
            <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
            <Columns>
                <asp:BoundField DataField="Date_Start" HeaderText="Date Start" SortExpression="Date_Start" />
                <asp:BoundField DataField="Date_End" HeaderText="Date End" SortExpression="Date_End" />
                <asp:BoundField DataField="Entry_Date" HeaderText="Entry Date" SortExpression="Entry_Date" />
                <asp:BoundField DataField="description" HeaderText="Description" SortExpression="description" />
                <asp:BoundField DataField="Financial_Company_Name" HeaderText="Financial Company"
                    SortExpression="Financial_Company_Name" />
                <asp:BoundField DataField="Company_Branch_Name" HeaderText="Company Branch" SortExpression="Company_Branch_Name" />
                <asp:BoundField DataField="Receipt" HeaderText="Receipt" SortExpression="" Visible="False" />
                <asp:BoundField DataField="Other" HeaderText="Other" SortExpression="" Visible="False" />
                <asp:BoundField DataField="Opening_balance" HeaderText="Opening Balance" SortExpression="Opening_balance" Visible="False" />
                <asp:HyperLinkField DataNavigateUrlFields="B_ID,Date_End" DataNavigateUrlFormatString="Budget_Detail.aspx?B_ID={0}&amp;Date_End={1}"
                    HeaderText="Budget Detail" Text="ADD Detail" />
                <asp:HyperLinkField DataNavigateUrlFields="Financial_Company_Id,Company_Branch_Id,Date_End,Date_Start,B_ID"
                    DataNavigateUrlFormatString="Revise_Budget_Detail.aspx?Financial_Company_Id={0}&amp;Company_Branch_Id={1}&amp;Date_End={2}&amp;Date_Start={3}&amp;B_ID={4}"
                    Text="Revise Final Budget " />
                <asp:HyperLinkField DataNavigateUrlFields="Financial_Company_Id,Company_Branch_Id,Date_End,Date_Start,B_ID"
                    DataNavigateUrlFormatString="CurrentYearBudgetPosition.aspx?Financial_Company_Id={0}&amp;Company_Branch_Id={1}&amp;Date_End={2}&amp;Date_Start={3}&amp;B_ID={4}"
                    HeaderText="Add Current Position" Text="Add Position" Visible="false" />
                <asp:HyperLinkField DataNavigateUrlFields="B_ID" DataNavigateUrlFormatString="BudgetDistributionReport.aspx?B_ID={0}"
                    Target="_blank" HeaderText="Distribution Report" Text="Report" />
                <asp:HyperLinkField DataNavigateUrlFields="B_ID,Financial_Company_Id,Company_Branch_Id"
                    DataNavigateUrlFormatString="CReport_Revised_Estimates.aspx?B_ID={0}&amp;Financial_Company_Id={1}&amp;Company_Branch_Id={2}&amp;"
                    HeaderText="Current Position Report" Text="Report" Visible="false" />
                    
                <asp:HyperLinkField DataNavigateUrlFields="B_ID"
                    DataNavigateUrlFormatString="Transfer_Head_Amount.aspx?B_ID={0}"
                    HeaderText="Transfer Budget" Text="Report" />
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
        <asp:SqlDataSource ID="SqlDataSource_Budget_Approve" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
            ProviderName="<%$ ConnectionStrings:Finance_ConnectionString.ProviderName %>"
            UpdateCommand="UPDATE    Budget
SET Status = 'Approved'
WHERE     (B_ID = @B_ID)">
            <UpdateParameters>
                <asp:ControlParameter ControlID="HiddenField_B_ID" Name="B_ID" PropertyName="Value" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />
        <asp:SqlDataSource ID="SqlDataSource_Budget" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
            DeleteCommand="DELETE FROM [Budget_Detail] WHERE [B_ID] = @B_ID
DELETE FROM [Budget] WHERE [B_ID] = @B_ID
" InsertCommand="INSERT INTO Budget(B_ID, Date_Start, Date_End, emp_ID, description,Financial_Company_Id,Company_Branch_Id,Opening_balance,Receipt,Other ) VALUES (@B_ID, @Date_Start, @Date_End, @emp_ID, @description,@Financial_Company_Id,@Company_Branch_Id,@Opening_balance,@Receipt,@Other )"
            SelectCommand="SELECT        TOP (5) CONVERT(varchar, Budget.Date_Start, 103) AS Date_Start, CONVERT(varchar, Budget.Date_End, 103) AS Date_End, CONVERT(varchar, Budget.Entry_Date, 103) AS Entry_Date, Budget.B_ID, 
                         Budget.emp_ID, Budget.description, Budget.Financial_Company_Id, Budget.Company_Branch_Id, Group_Financial_Companies.Financial_Company_Name, 
                         Group_Financial_Companies.Financial_Company_Id AS Expr1, Group_Company_Branches.Company_Branch_Id AS Expr2, Group_Company_Branches.Company_Branch_Name, Budget.Opening_balance, 
                         Budget.Grant_in_Aid,Budget.Receipt,Budget.Other
FROM            Budget INNER JOIN
                         Group_Financial_Companies ON Budget.Financial_Company_Id = Group_Financial_Companies.Financial_Company_Id INNER JOIN
                         Group_Company_Branches ON Budget.Company_Branch_Id = Group_Company_Branches.Company_Branch_Id
WHERE        (Budget.Status = 'New')
Order By Budget.B_ID Desc" UpdateCommand="UPDATE [Budget] SET [Date_Start] = @Date_Start, [Date_End] = @Date_End, [Entry_Date] = @Entry_Date, [emp_ID] = @emp_ID WHERE [B_ID] = @B_ID">
            <DeleteParameters>
                <asp:ControlParameter ControlID="GridView4" Name="B_ID" PropertyName="SelectedValue"
                    Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="Date_Start" Type="DateTime" />
                <asp:Parameter Name="Date_End" Type="DateTime" />
                <asp:Parameter Name="Entry_Date" Type="DateTime" />
                <asp:Parameter Name="emp_ID" Type="Int32" />
                <asp:Parameter Name="B_ID" Type="Int32" />
            </UpdateParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="HiddenField_B_ID" Name="B_ID" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_start_Date" Name="Date_Start" PropertyName="Value"
                    Type="DateTime" />
                <asp:ControlParameter ControlID="HiddenField_end_date" Name="Date_End" PropertyName="Value"
                    Type="DateTime" />
                <asp:SessionParameter Name="emp_ID" SessionField="emp_ID" Type="Int32" />
                <asp:ControlParameter ControlID="TextBox_description" Name="description" PropertyName="Text" />
                <asp:ControlParameter ControlID="DropDownList_FinancialCompany" Name="Financial_Company_Id"
                    PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="DropDownList_CompanyBranches" Name="Company_Branch_Id"
                    PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="txt_OP_balance" Name="Opening_balance" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtboxReceipt" Name="Receipt" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtboxOther" Name="Other" PropertyName="Text" />
                <asp:ControlParameter ControlID="TXT_Grant" Name="Grant_in_Aid" PropertyName="Text" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenField_start_Date" runat="server" />
        <asp:HiddenField ID="HiddenField_end_date" runat="server" />
        <asp:HiddenField ID="HiddenField_year" runat="server" />
        <br />
        <br />
    </div>
</asp:Content>
