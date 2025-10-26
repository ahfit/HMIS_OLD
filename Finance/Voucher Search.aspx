<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="Voucher Search.aspx.vb"
    Inherits="Finace_GeneralLedger" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="bxmain inner_content" style="width:100%;">
        <h2><span>Search Voucher(s)</span></h2>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
            <tr>
                <td width="200px" align="right">
                    Select Company :
                </td>
                <td width="100px">
                    <asp:DropDownList ID="DropDownList_Companyname" runat="server" AutoPostBack="True"
                        DataSourceID="SQL_Companyname" DataTextField="Financial_Company_Name" DataValueField="Financial_Company_Id"
                        Width="198px">
                    </asp:DropDownList>
                </td>
                <td width="50px" align="right">
                    Voucher # :
                </td>
                <td width="300px">
                    <asp:TextBox ID="txtVoucherNo" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Select Branch :
                </td>
                <td >
                    <asp:DropDownList ID="DropDownList_Branchname" runat="server" AutoPostBack="True"
                        DataSourceID="SQL_Branchname" DataTextField="Company_Branch_Name" DataValueField="Company_Branch_Id"
                        Width="198px">
                    </asp:DropDownList>
                </td>
                <td  align="right">
                    From :
                </td>
                <td >
                    <igsch:WebDateChooser ID="WebDateChooserSdate" runat="server" Value="2010-06-18"
                        Width="198px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td  align="right">
                    Select Party :
                </td>
                <td >
                    <asp:DropDownList ID="ddlParty" runat="server" AutoPostBack="True" DataSourceID="dsSQL_Party"
                        DataTextField="Party_Name" DataValueField="Party_Id" Width="198px">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="dsSQL_Party" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="usp_GetAllParties" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                </td>
                <td align="right">
                    To :
                </td>
                <td>
                    <igsch:WebDateChooser ID="WebDateChooserEDate" runat="server" Value="2010-06-18"
                        Width="198px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td align="right">
                    &nbsp;
                </td>
                <td colspan="3" style="text-align:Left;padding-left:150px;">
                    <asp:RadioButtonList ID="DDLVoucher" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Selected="True" Value="2">All</asp:ListItem>
                        <asp:ListItem  Value="1">Posted</asp:ListItem>
                        <asp:ListItem  Value="0">UnPosted</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    &nbsp;
                </td>
                
                <td colspan="3" style="text-align:Left;padding-left:150px;">
                    <asp:Button ID="Button1" runat="server" Text="Search" />
                    <asp:Button ID="Button_Print" runat="server" Text="Print" />
                    <asp:Button ID="btnPost" runat="server" Text="Post" Visible="false" OnClick="btnPost_Click" />
                       <asp:Button ID="btnUnpost" runat="server" Text="UnPost" Visible="false" OnClick="btnUnpost_Click" />
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="SQL_Companyname" runat="server" ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>"
        SelectCommand="SELECT 0 AS Financial_Company_Id, 'ALL' AS Financial_Company_Name UNION SELECT Financial_Company_Id, Financial_Company_Name FROM Group_Financial_Companies WHERE (Financial_Company_Id IN (SELECT Financial_Company_ID FROM Employee_Rights_Company_Wise WHERE (Emp_ID = @Emp_ID)))">
        <SelectParameters>
            <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQL_Branchname" runat="server" ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>"
        SelectCommand="SELECT     0 AS Company_Branch_Id, 'ALL' AS Company_Branch_Name
UNION
SELECT     Company_Branch_Id, Company_Branch_Name
FROM         Group_Company_Branches
WHERE     (Company_Branch_Id IN
                          (SELECT     Company_Branch_ID
                            FROM          Employee_Rights_Company_Wise
                            WHERE      (Emp_ID = @Emp_ID) AND (CONVERT(varchar, Financial_Company_ID) LIKE CASE @Financial_Company_Id WHEN 0 THEN '%' ELSE CONVERT(varchar, 
                                                   @Financial_Company_Id) END)))

">
        <SelectParameters>
            <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" />
            <asp:ControlParameter ControlID="DropDownList_Companyname" Name="Financial_Company_Id"
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <asp:HiddenField ID="HiddenFieldEdate" runat="server" />
    <asp:HiddenField ID="HiddenFieldSdate" runat="server" />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceforGrid"
        Visible="False" Width="100%" EmptyDataText="No Record(s) Found." 
        DataKeyNames="Voucher_Trans_Id" ShowFooter="True">
        <Columns>
            <%--<asp:BoundField DataField="Description" HeaderText="Description" />--%>
            <asp:TemplateField ShowHeader="False" >
                <ItemTemplate>
                    <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" OnClientClick = 'return confirm("Do you want to delete this Voucher ?");'
                        CommandName="Delete" ImageUrl="~/images/deletebtn.png" Text="Delete" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField >
                <ItemTemplate>
                    <asp:LinkButton ID="lnkEditVoucherDetail" OnClick="lnkEditVoucherDetail_Click" runat="server" CommandArgument='<%#Eval("Voucher_Trans_Id") %>' Text='Edit'
                    Visible='<%# Eval("Approval_Status") = "0"%>'></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:HyperLinkField DataNavigateUrlFields="Voucher_Trans_Id" DataNavigateUrlFormatString="Edit_Disbursement_voucher.aspx?VTI={0}"
                Text="Edit" Visible="False"  />
            <asp:TemplateField HeaderText="SR No." ItemStyle-CssClass = "AmountAlign">
                <ItemTemplate>
                    <asp:Label ID="Label_Sr_No" runat="server">0</asp:Label>
                </ItemTemplate>

<ItemStyle CssClass="AmountAlign"></ItemStyle>
            </asp:TemplateField>
            <asp:BoundField DataField="Voucher_Trans_Id" HeaderText="Transaction ID" />
            <asp:BoundField DataField="Voucher_No" HeaderText="Voucher No" SortExpression="Voucher_No" />
            <asp:BoundField DataField="Account_Title" HeaderText="Party Name" SortExpression="Account_Title" />
            <asp:BoundField DataField="Voucher_Date" HeaderText="Voucher Date" ReadOnly="True"
                SortExpression="Voucher_Date" />
            <asp:BoundField DataField="Voucher_Type" HeaderText="Voucher Type" SortExpression="Voucher_Type" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description") %>'></asp:Label>
                    <asp:HiddenField ID="Cr" runat="server" runat = "server" 
                        Value = '<%# Bind("Total_Cr") %>' />
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Total_Cr","{0:#,##.00}") %>'></asp:Label>
                    <asp:HiddenField ID="Dr" runat="server" runat = "server" 
                        Value = '<%# Bind("Total_Dr") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <%--<asp:BoundField DataField="CR_DR_Total" HeaderText="CR DR Total" 
                SortExpression="CR_DR_Total" />--%>
            <asp:BoundField DataField="Total_Cr" HeaderText="Total Cr"  ItemStyle-CssClass = "AmountAlign"
                SortExpression="Total_Cr" DataFormatString="{0:#,##}" >
<ItemStyle CssClass="AmountAlign"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="Total_Dr" HeaderText="Total Dr"  ItemStyle-CssClass = "AmountAlign"
                SortExpression="Total_Dr"  DataFormatString="{0:#,##}">
<ItemStyle CssClass="AmountAlign"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="Voucher_Trans_Id" InsertVisible="False" ReadOnly="True"
                SortExpression="Voucher_Trans_Id" Visible="False" />
           <asp:HyperLinkField DataNavigateUrlFields="Voucher_Trans_Id" DataNavigateUrlFormatString="AddViewVoucherAttachements.aspx?VTI={0}"
                Text="Add \ View Attachment" />
            <asp:ButtonField CommandName="Select" Text="Print Voucher" />
             <asp:TemplateField >
                 <HeaderTemplate>
                        <asp:CheckBox ID="chkApprovedAll" runat="server" AutoPostBack="True" 
                          OnCheckedChanged="chkApprovedAll_CheckedChanged"/>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox runat="server" ID="chkBoxSelect" ToolTip='<%#Bind("Voucher_Trans_Id") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
           

        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSourceforGrid" runat="server" ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>"
        CancelSelectOnNullParameter="False" SelectCommand="SEARCH_VOUCHER" ProviderName="<%$ ConnectionStrings:FinanceConnectionString.ProviderName %>"
        DeleteCommand="deletevoucher" DeleteCommandType="StoredProcedure" 
    SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenFieldEdate" Name="EDate" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldSdate" Name="SDate" PropertyName="Value" />
            <asp:ControlParameter ControlID="DDLVoucher" Name="vouchertype" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownList_Companyname" Name="Financial_Company_Id"
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownList_Branchname" Name="Company_Branch_Id"
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ddlParty" Name="PartyId" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="txtVoucherNo" Name="voucherNo" PropertyName="Text" />
            <asp:SessionParameter DefaultValue="" Name="DeptID" SessionField="Dept_Id" 
                Type="Int32" />
            <asp:SessionParameter DefaultValue="" Name="EmpID" SessionField="Emp_id" 
                Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="GridView1" Name="Voucher_Trans_Id" PropertyName="SelectedValue"
                Type="Decimal" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
    </rsweb:ReportViewer>
    <br />
    <br />
    <br />
</asp:Content>
