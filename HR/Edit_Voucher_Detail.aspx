<%@ page title="" language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="Finance_Edit_Voucher_Detail, App_Web_2qu1gl2y" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div>
    <asp:HyperLink ID="hlnkVoucherSearch" CssClass="backlink" runat="server" NavigateUrl="~/Finance/Voucher Search.aspx" Text="Voucher Search"></asp:HyperLink>
        
</div>
<div style="padding-bottom:20px;">
    <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
        <tr>
            <td width="50%" align="right"><strong>Company :</strong></td>
            <td width="50%" align="left">
                    <asp:DropDownList ID="DropDownList_Companyname" runat="server" AutoPostBack="True"
                        DataSourceID="SQL_Companyname" DataTextField="Financial_Company_Name" DataValueField="Financial_Company_Id"
                        Width="198px" Enabled="False">
                    </asp:DropDownList>
    <asp:SqlDataSource ID="SQL_Companyname" runat="server" ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>"
        SelectCommand="
SELECT Financial_Company_Id, Financial_Company_Name FROM Group_Financial_Companies 
WHERE (Financial_Company_Id IN (SELECT Financial_Company_ID 
FROM Employee_Rights_Company_Wise WHERE (Emp_ID = @Emp_ID)))">
        <SelectParameters>
            <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" />
        </SelectParameters>
    </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td width="50%" align="right"><strong>Branch :</strong></td>
            <td width="50%" align="left">
                    <asp:DropDownList ID="DropDownList_Branchname" runat="server" AutoPostBack="True"
                        DataSourceID="SQL_Branchname" DataTextField="Company_Branch_Name" DataValueField="Company_Branch_Id"
                        Width="198px" Enabled="False">
                    </asp:DropDownList>
    <asp:SqlDataSource ID="SQL_Branchname" runat="server" ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>"
        SelectCommand="SELECT     Company_Branch_Id, Company_Branch_Name
FROM         Group_Company_Branches
WHERE     (Company_Branch_Id IN
                          (SELECT     Company_Branch_ID
                            FROM          Employee_Rights_Company_Wise
                            WHERE      (Emp_ID = @Emp_ID) 

and (Employee_Rights_Company_Wise.Financial_Company_ID=@Financial_Company_Id) 
))

">
        <SelectParameters>
            <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" />
            <asp:ControlParameter ControlID="DropDownList_Companyname" Name="Financial_Company_Id"
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td width="50%" align="right"><span style="font-size: medium; font-weight: bold">Date : </span></td>
            <td width="50%" align="left"><igsch:WebDateChooser ID="wdc_For_Date" runat="server" 
                        Width="200px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser></td>
        </tr>
        <tr>
            <td align="center" colspan="2">
                <asp:Label ID="lblMsg" runat="server" ForeColor="Red" Font-Bold="true" Text="Debit and Credit amounts are not equal" Visible="false"></asp:Label>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="sds_For_Date" runat="server"
        ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>" 
        SelectCommand="SELECT     CONVERT(Varchar, For_Date, 103) AS For_Date, Financial_Company_Id, Company_Branch_Id FROM   Receipt_Disbursement_AccountHeads WHERE Voucher_Trans_Id=@Voucher_Trans_Id" 
        UpdateCommand="UPDATE    Receipt_Disbursement_AccountHeads
SET              For_Date = @For_Date, Financial_Company_Id =@Financial_Company_Id, Company_Branch_Id =@Company_Branch_Id
WHERE     (Voucher_Trans_Id = @Voucher_Trans_Id) "
    >
        <SelectParameters>
            <asp:Parameter Name="Voucher_Trans_Id" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="For_Date" />
            <asp:QueryStringParameter Name="Voucher_Trans_Id" 
                QueryStringField="Voucher_Trans_Id" />
            <asp:ControlParameter ControlID="DropDownList_Companyname" 
                Name="Financial_Company_Id" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownList_Branchname" 
                Name="Company_Branch_Id" PropertyName="SelectedValue" />
        </UpdateParameters>
    </asp:SqlDataSource>
    </div>
    <asp:GridView ID="gvVoucherDetail" Width="100%" runat="server" ShowFooter="True"
        DataSourceID="sqlDs_VoucherDetail" AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField HeaderText="Account Code" DataField="Account_Head_id" />
            <asp:TemplateField HeaderText="Party">
                <ItemTemplate>
                    <asp:TextBox ID="txtParty" runat="server" Enabled="false" Text='<%#Eval("Party_Name") %>' Visible="false"></asp:TextBox>
                    <asp:DropDownList ID="ddlParty" DataSourceID="sqlDs_Party"  Enabled="False"
                        AppendDataBoundItems="True" DataTextField="Party_Name" 
                        DataValueField="Party_Id" runat="server" 
                        SelectedValue='<%# Bind("Party_ID") %>'>
                        <asp:ListItem Value="0" Text=""></asp:ListItem>
                    </asp:DropDownList>                    
                    <asp:HiddenField ID="hfldPartyId" runat="server" Value='<%#Eval("Party_ID") %>' />
                    
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Account Head">
                <ItemTemplate>
                    <asp:DropDownList ID="ddlAccountHead" DataSourceID="sqlDs_AccountHeads" AppendDataBoundItems="true" DataTextField="E_Name" DataValueField="E_Code" runat="server">
                        <asp:ListItem Value="0" Text=""></asp:ListItem>
                    </asp:DropDownList>
                    <asp:HiddenField ID="hfldVoucherDetailId" runat="server" Value='<%#Eval("Reciept_Disbursement_Detail_Id") %>' />
                    <asp:HiddenField ID="hfldAccountHeadId" runat="server" Value='<%#Eval("Account_Head_id") %>' />
                     <asp:HiddenField ID="hdfCrDrActionID" runat="server" Value='<%#Eval("Cr_Dr_Action_Id") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Description">
                <ItemTemplate>
                    <asp:TextBox ID="txtDescription" runat="server" Width="500px" TextMode="MultiLine" Rows="3" Text='<%#Eval("Description") %>'></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Debit">
                <ItemTemplate>
                <asp:TextBox ID="txtDebit" runat="server" Text='<%#Eval("Debit","{0:#,#}") %>' 
                        Width="75px" ontextchanged="txtDebit_TextChanged" AutoPostBack="true"></asp:TextBox>
                    
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lblTotalDebit" runat="server" Font-Bold="true" Text=""></asp:Label>
                </FooterTemplate>
                <ItemStyle CssClass="AmountAlign" />
                <FooterStyle CssClass="AmountAlign" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Credit">
                <ItemTemplate>
                 <asp:TextBox ID="txtCredit" runat="server" Text='<%#Eval("Credit","{0:#,#}") %>' 
                        Width="75px" ontextchanged="txtCredit_TextChanged" AutoPostBack="true"></asp:TextBox>
                    
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lblTotalCredit" Font-Bold="true" runat="server" Text=""></asp:Label>
                </FooterTemplate>
                <ItemStyle CssClass="AmountAlign" />
                <FooterStyle CssClass="AmountAlign" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Change Company">
                <ItemTemplate>
                    <asp:LinkButton ID="btnChangeCompany" runat="server" Text="Update Company" 
                        CommandArgument='<%# Eval("Reciept_Disbursement_Detail_Id") %>' 
                        onclick="btnChangeCompany_Click"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <div style="margin-top:20px;float:right;">
        <asp:Button ID="btnSave" runat="server" Text="Save Voucher Detail" />
        <asp:Button ID="btnFinalizeVoucher" runat="server" Text="Finalize & Lock Voucher" />
    </div>

    <asp:SqlDataSource ID="sqlDs_VoucherDetail" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>" 
        SelectCommand="usp_GetVoucherDetailByVoucherId" UpdateCommand="uspUpdateVoucherDetail"  UpdateCommandType="StoredProcedure"
        SelectCommandType="StoredProcedure" >
        <SelectParameters>
            <asp:Parameter Name="Voucher_Trans_Id" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Reciept_Disbursement_Detail_Id" Type="Int64" />
            <asp:Parameter Name="Account_Head_id" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="Amount" Type="Decimal" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDs_AccountHeads" runat="server" 
        ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>" 
        SelectCommand="Select E_Code,E_Name From Expenditure Order BY E_Name"></asp:SqlDataSource>

        <asp:SqlDataSource ID="sqlDs_FinalizeVoucher" runat="server" 
        ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>" 
        UpdateCommand="Update Receipt_Disbursement_AccountHeads SET Approval_Status = 1 Where Voucher_Trans_Id = @Voucher_Trans_Id And IsNull(Approval_Status,0) = 0">
            <UpdateParameters>
                <asp:Parameter Name="Voucher_Trans_Id" Type="Int64" />
            </UpdateParameters>        
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="sqlDs_Party" runat="server" 
        ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>" 
        SelectCommand="SELECT 0 Party_Id,'' Party_Name union
Select EmpID Party_Id,EFName+' '+ISNULL(EMName,'')+' '+ISNULL(ELName,'') Party_Name From BasicDataInfo.dbo.Employee --Where Is_Deleted=0
union
SELECT Party_Id,Party_Name From Parties Where ISNULL(Party_Name,'') <>'' order by Party_Name"
        UpdateCommand="UPDATE    Reciept_Disbursement_Detail
SET              Party_ID =@Party_ID 
where     Reciept_Disbursement_Detail_Id=@Reciept_Disbursement_Detail_Id"
        >
            <UpdateParameters>
                <asp:Parameter Name="Party_ID" />
                <asp:Parameter Name="Reciept_Disbursement_Detail_Id" />
            </UpdateParameters>
    </asp:SqlDataSource>        
       
</asp:Content>

