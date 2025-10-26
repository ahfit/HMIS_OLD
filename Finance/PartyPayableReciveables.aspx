<%@ page language="VB" autoeventwireup="false" inherits="PayableReciveable, App_Web_se3xxsm3" masterpagefile="~/hacims_masterpage_admin.master" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form">
        <tr>
            <td width="40%" align="right">
                Select Company :
            </td>
            <td width="60%">
                <asp:DropDownList ID="DropDownList_Companyname" runat="server" AutoPostBack="True"
                    DataSourceID="SQL_Companyname" DataTextField="Financial_Company_Name" DataValueField="Financial_Company_Id"  Width="196px">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td align="right">
                Select Branch :
            </td>
            <td>
                <asp:DropDownList ID="DropDownList_Branchname" runat="server" AutoPostBack="True"
                    DataSourceID="SQL_Branchname" DataTextField="Company_Branch_Name" DataValueField="Company_Branch_Id" Width="196px">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td align="right">
                From Date :
            </td>
            <td>
                <igsch:WebDateChooser ID="WebDateChooser_date_From" runat="server" Width="196px">
                </igsch:WebDateChooser>
            </td>
        </tr>
        <tr>
            <td align="right">
                To Date :
            </td>
            <td>
                <igsch:WebDateChooser ID="WebDateChooser_Date_To" runat="server" Width="196px">
                </igsch:WebDateChooser>
            </td>
        </tr>
        <tr>
            <td align="right" width="40%">
                Party name:
            </td>
            <td width="60%">
                <asp:TextBox ID="txtPartyName" runat="server" CssClass="input_txt" Width="193px"></asp:TextBox>
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
                        <asp:ListItem  Value="0">Not Posted</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
        <tr>
            <td align="right" width="40%">
            </td>
            <td width="60%">
                <asp:Button ID="btnSearch" runat="server" Style="margin-bottom: 3px !important;"
                    Text="Search" />
                <asp:HiddenField ID="HiddenField_PartyName" runat="server" />
                <asp:SqlDataSource ID="SQL_Companyname" runat="server" ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>"
                    SelectCommand="SELECT Financial_Company_Id, Financial_Company_Name FROM Group_Financial_Companies WHERE (Financial_Company_Id IN (SELECT Financial_Company_ID FROM Employee_Rights_Company_Wise WHERE (Emp_ID = @Emp_id)))">
                    <SelectParameters>
                        <asp:SessionParameter Name="Emp_id" SessionField="emp_id" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SQL_Branchname" runat="server" ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>"
                    SelectCommand=" SELECT Company_Branch_Id, Company_Branch_Name FROM Group_Company_Branches WHERE (Company_Branch_Id IN (SELECT Company_Branch_ID FROM Employee_Rights_Company_Wise WHERE (Emp_ID = @Emp_id) AND (CONVERT (varchar, Financial_Company_ID) LIKE CASE @Financial_Company_Id WHEN 0 THEN '%' ELSE CONVERT (varchar , @Financial_Company_Id) END)))">
                    <SelectParameters>
                        <asp:SessionParameter Name="Emp_id" SessionField="emp_id" />
                        <asp:ControlParameter ControlID="DropDownList_Companyname" Name="Financial_Company_Id"
                            PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="50%" valign="top">
                <div class="bxmain inner_content" style="width: 98%;">
                    <h2>
                        <span>Party Reciveables</span></h2>
                    <asp:GridView ID="GridviewReceiveable" runat="server" AutoGenerateColumns="False"
                        DataSourceID="SqlDataSourceRecievables" Width="97%" Style="margin-left: 8px;"
                        ShowFooter="True" EnableModelValidation="True">
                        <Columns>
                            <asp:TemplateField HeaderText="Party Name" ShowHeader="False" SortExpression="E_Name">
                                <FooterTemplate>
                                    <strong>Total</strong>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" CommandName="Select"
                                        Text='<%# Eval("E_Name") %>'></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Recievable" SortExpression="Recievable">
                                <EditItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Recievable") %>'></asp:Label>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="lbl_Total_Reciveables" CssClass="boldt" runat="server" Text="0"></asp:Label>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbl_totalRec" runat="server" Text='<%# Bind("Recievable","{0:#,###.##}") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle CssClass="AmountAlign" />
                                <FooterStyle CssClass="AmountAlign" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="Party_ID" HeaderText="Party_ID" SortExpression="Party_ID" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSourceRecievables" runat="server" ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>"
                        SelectCommand="[PartyReceiveableByCompanyBranch]" ProviderName="<%$ ConnectionStrings:FinanceConnectionString.ProviderName %>"
                        SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:SessionParameter Name="SubDept_Id" SessionField="subdeptId" Type="Int32" />
                            <asp:SessionParameter Name="Dept_ID" SessionField="dept_id" Type="Int32" />
                            <asp:SessionParameter Name="Emp_id" SessionField="emp_id" Type="Int32" />
                             <asp:ControlParameter ControlID="DDLVoucher" Name="vpost"
                                PropertyName="SelectedValue" Type="Int32" />
                            <asp:ControlParameter ControlID="HiddenField_PartyName" DefaultValue="%" Name="ename"
                                PropertyName="Value" Type="String" />
                            <asp:ControlParameter ControlID="DropDownList_Companyname" DefaultValue="0" Name="financial_company_id"
                                PropertyName="SelectedValue" Type="String" />
                            <asp:ControlParameter ControlID="DropDownList_Branchname" DefaultValue="0" Name="BranchID"
                                PropertyName="SelectedValue" Type="String" />
                            <asp:Parameter Name="From_date" Type="DateTime" />
                            <asp:Parameter Name="To_date" Type="DateTime" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
            </td>
            <td width="50%" valign="top">
                <div class="bxmain inner_content" style="width:98%;">
                    <h2>
                        <span>Party Payables</span></h2>
                    <asp:GridView ID="GridviewPayable" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourcePayables"
                        Width="96%" ShowFooter="True" Style="margin-left: 8px;" EnableModelValidation="True">
                        <Columns>
                            <asp:TemplateField HeaderText="Party Name" ShowHeader="False" SortExpression="E_Name">
                                <FooterTemplate>
                                    <strong>Total</strong>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" CommandName="Select"
                                        Text='<%# Eval("E_Name") %>'></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Payable" SortExpression="Payable">
                                <EditItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Payable") %>'></asp:Label>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="lbl_totalPay" runat="server" CssClass="boldt" Text="0"></asp:Label>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <%--<asp:Label ID="lbl_Payable" runat="server" Text='<%# Bind("Payable")%>'></asp:Label>--%>
                                    <asp:Label ID="lbl_Payable" runat="server" Text='<%# Bind("Payable", "{0:#,###.##}")%>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle CssClass="AmountAlign" />
                                <FooterStyle CssClass="AmountAlign" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="Party_ID" HeaderText="Party_ID" SortExpression="Party_ID" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSourcePayables" runat="server" ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:FinanceConnectionString.ProviderName %>"
                        SelectCommand="[PartyPayableByCompanyBranch]" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:SessionParameter Name="SubDept_Id" SessionField="subdeptid" Type="Int32" />
                            <asp:SessionParameter Name="Dept_ID" SessionField="dept_id" Type="Int32" />
                            <asp:SessionParameter Name="Emp_id" SessionField="emp_id" Type="Int32" />
                            <asp:ControlParameter ControlID="HiddenField_PartyName" DefaultValue="%" Name="ename"
                                PropertyName="Value" Type="String" />
                             <asp:ControlParameter ControlID="DDLVoucher" Name="vpost"
                                PropertyName="SelectedValue" Type="Int32" />
                            <asp:ControlParameter ControlID="DropDownList_Companyname" DefaultValue="0" Name="financial_company_id"
                                PropertyName="SelectedValue" Type="String" />
                            <asp:ControlParameter ControlID="DropDownList_Branchname" DefaultValue="0" Name="BranchID"
                                PropertyName="SelectedValue" Type="String" />
                            <asp:Parameter Name="From_date" Type="DateTime" />
                            <asp:Parameter Name="To_date" Type="DateTime" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <br />
    <br />
</asp:Content>
