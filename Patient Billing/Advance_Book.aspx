<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Patient_Registration_advance_Book, App_Web_gswfk1g0" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script language="javascript" type="text/javascript">
        function Prompt() {
            if (confirm(" Do You Want To Counter Close Now ?  \n Press OK for continue and Cancel for stop"))
                return true;
            else
                return false;
        }
    </script>
    <style type="text/css">
        .style1
        {
            height: 13px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label CssClass="err" ID="Label1" runat="server"></asp:Label>
    <div class="rpt_pos">
        <table width="100%">
            <tr>
                <td align="right">
                    From Date :
                </td>
                <td>
                    <igsch:WebDateChooser ID="WebDateChooserSdate" runat="server" Value="2010-06-18"
                        Width="198px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td align="right">
                    To Date :
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
                    Select Employee :
                </td>
                <td>
                    <asp:DropDownList ID="DDL_Employee" runat="server" DataSourceID="SDS_Employee" DataTextField="NAME"
                        DataValueField="EmpID" AutoPostBack="false">
                    </asp:DropDownList>
                    <br />
                    <asp:SqlDataSource ID="SDS_Employee" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                        SelectCommand="Select  0 as EmpID, '  All ' as NAME Union 
Select Distinct Employee.EmpID, isnull(EFName,'')+ ' '+ISnull(EMName,'')+' '+IsNULL( ELName,'') AS NAME from Employee inner join Sub_Counter_Close On Employee.EmpID = Sub_Counter_Close.emp_id 
where Sub_Counter_Close.Amount_Type = 'Advance'"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
            <td></td>
                <td  align="left">
                    <asp:RadioButtonList ID="RadioButtonListAdjusted" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Selected="True" Value="1" Text="Adjusted" />
                        <asp:ListItem Value="0" Text="Unadjusted" />
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                </td>
                <td class="style1">
                    <asp:Button Text="Search" ID="btnSearch" OnClick="btnSearch_Click" runat="server" />
                    <asp:Button ID="btn_Export" runat="server" Text="Export to Excel" />
                </td>
            </tr>
            <tr>
                <td align="right">
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
    </div>
    <asp:GridView ID="GridView_Counter_Close" runat="server" AutoGenerateColumns="False"
        Width="100%" ShowFooter="True" DataKeyNames="CashBook_ID" DataSourceID="SqlDataSourceForGrid">
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
        <FooterStyle CssClass="myfooter" />
        <Columns>
            <asp:TemplateField HeaderText="Sr #."> 
<ItemTemplate> <%#Container.DataItemIndex+1%> 
</ItemTemplate>
<ItemStyle Width="8%" /> 
</asp:TemplateField>
            <asp:TemplateField HeaderText="MR #" ItemStyle-Width="7%">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkbtnAdv" runat="server" Text="View" OnClick="lnkbtnAdv_Click"
                        CommandArgument='<%# Eval("Main_Id") %>'></asp:LinkButton>
                    <%-- <asp:Label ID="Label1" runat="server" Text='<%# Bind("Reg_No") %>'></asp:Label>--%>
                </ItemTemplate>
                <ItemStyle Width="10%"></ItemStyle>
            </asp:TemplateField>
            <asp:BoundField DataField="YearlyNo" HeaderText="Visit #" SortExpression="YearlyNo" />
            <asp:BoundField DataField="name" HeaderText="Reciept By" SortExpression="name" />
            <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
            <asp:BoundField DataField="CCTime" HeaderText="Time" SortExpression="CCTime" />
            <asp:TemplateField HeaderText="Receipt No‎">
                <ItemTemplate>
                    <asp:Label ID="lbl_reciept" runat="server" Text='<%# Bind("SPM_ID") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Patient Name">
                <ItemTemplate>
                    <asp:Label ID="lbl_name" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Payment" SortExpression="Amount_Type">
                <ItemTemplate>
                    <asp:Label ID="lbl_payment_type" runat="server" Text='<%# Bind("Amount_Type") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Amount" SortExpression="Amount">
                <ItemTemplate>
                    <asp:Label ID="lbl_amount" runat="server" Text='<%# Bind("Amount") %>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="Lbl_Total" runat="server" Width="100%" Font-Bold="True" Font-Size="Larger"
                        CssClass="AmountAlign"></asp:Label>
                </FooterTemplate>
                <ControlStyle Font-Bold="False" />
                <ItemStyle CssClass="toright red" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Balance">
                <ItemStyle CssClass="toright" />
                <ItemTemplate>
                    <asp:Label ID="LabelBAmount" runat="server" Text="Label">
                    </asp:Label>
                    <asp:HiddenField ID="HiddenFieldPrefix" runat="server" Value='<%# Eval("Prefix", "{0}") %>' />
                    <asp:HiddenField ID="HiddenFieldFName" runat="server" Value='<%# Eval("PFName", "{0}") %>' />
                    <asp:HiddenField ID="HiddenFieldMName" runat="server" Value='<%# Eval("PMName", "{0}") %>' />
                    <asp:HiddenField ID="HiddenFieldLName" runat="server" Value='<%# Eval("PLName", "{0}") %>' />
                    <asp:HiddenField ID="HiddenFieldreturn_id" runat="server" Value='<%# Eval("return_payment_id", "{0}") %>' />
                    <asp:HiddenField ID="HiddenFieldMain_Id" runat="server" Value='<%# Eval("Main_Id", "{0}") %>' />
                    <asp:HiddenField ID="HiddenFieldYearlyNo" runat="server" Value='<%# Eval("YearlyNo", "{0}") %>' />
                    <asp:HiddenField ID="HiddenFieldRegNo" runat="server" Value='<%# Eval("Reg_No", "{0}") %>' />
                    <asp:HiddenField ID="HiddenField_Amount" runat="server" Value='<%# Eval("Amount", "{0}") %>' />
                    <asp:HiddenField ID="HiddenFieldCashBook_Id" runat="server" Value='<%# Eval("CashBook_ID", "{0}") %>' />
                    <asp:HiddenField ID="HiddenFieldType" runat="server" Value='<%# Eval("Amount_Type", "{0}") %>' />
                    <asp:HiddenField ID="HiddenFieldSPM_ID" runat="server" Value='<%# Eval("SPM_ID", "{0}") %>' />
                    <asp:HiddenField ID="HiddenFieldAdv_pay_id" runat="server" Value='<%# Eval("Adv_payment_ID", "{0}") %>' />
                    <asp:HiddenField ID="HiddenFieldDept_ID" runat="server" Value='<%# Bind("Dept_ID", "{0}") %>' />
                    <asp:HiddenField ID="HiddenFieldSubDept_Id" runat="server" Value='<%# Bind("SubDept_ID", "{0}") %>' />
                    <asp:HiddenField ID="HiddenFieldDate" runat="server" Value='<%# Bind("Date", "{0}") %>' />
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="Lbl_T_Balance" runat="server" Width="100%" Font-Bold="True" Font-Size="Larger"
                        CssClass="AmountAlign"></asp:Label>
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Type">
                <ItemTemplate>
                    <asp:Label Text='<%#Bind("adjustType") %>' ID="lblAdjustType" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <br />
    <asp:GridView ID="GridView_Cardiac_Cash_Book" runat="server" AutoGenerateColumns="False"
        Width="100%" ShowFooter="True" DataKeyNames="CashBook_ID">
        <FooterStyle CssClass="footer" />
        <Columns>
            <asp:TemplateField HeaderText="Sr #."> 
<ItemTemplate> <%#Container.DataItemIndex+1%> 
</ItemTemplate>
<ItemStyle Width="8%" /> 
</asp:TemplateField>
            <asp:BoundField DataField="YearlyNo" HeaderText="File No." SortExpression="YearlyNo" />
            <asp:BoundField DataField="Main_Id" HeaderText="Main_Id" SortExpression="Main_Id"
                Visible="False" />
            <asp:BoundField DataField="Prefix" HeaderText="Prefix" SortExpression="Prefix" />
            <asp:BoundField DataField="PFName" HeaderText="PFName" SortExpression="PFName" />
            <asp:BoundField DataField="PMName" HeaderText="PMName" SortExpression="PMName" />
            <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
            <asp:BoundField DataField="Amount_Type" HeaderText="Payment Type" SortExpression="Amount_Type" />
            <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount">
                <ControlStyle Font-Bold="False" />
                <ItemStyle Font-Bold="True" Font-Size="13px" ForeColor="#990000" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Balance">
                <ItemTemplate>
                    <asp:Label ID="LabelAmount" runat="server" Text="Label"></asp:Label>
                    <br />
                    <asp:HiddenField ID="HiddenFieldAdv_pay_id" runat="server" Value='<%# Eval("Adv_payment_ID", "{0}") %>' />
                    <asp:HiddenField ID="HiddenFieldSPM_ID" runat="server" Value='<%# Eval("SPM_ID", "{0}") %>' />
                    <asp:HiddenField ID="HiddenFieldMain_Id" runat="server" Value='<%# Eval("Main_Id", "{0}") %>' />
                    <asp:HiddenField ID="HiddenFieldYearlyNo" runat="server" Value='<%# Eval("YearlyNo", "{0}") %>' />
                    <asp:HiddenField ID="HiddenFieldRegNo" runat="server" Value='<%# Eval("Reg_No", "{0}") %>' />
                    <asp:HiddenField ID="HiddenField_Amount" runat="server" Value='<%# Eval("Amount", "{0}") %>' />
                    <asp:HiddenField ID="HiddenFieldCashBook_Id" runat="server" Value='<%# Eval("CashBook_ID", "{0}") %>' />
                    <asp:HiddenField ID="HiddenFieldType" runat="server" Value='<%# Eval("Amount_Type", "{0}") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="CashBook_ID" HeaderText="CashBook_ID" InsertVisible="False"
                SortExpression="CashBook_ID" Visible="False" />
        </Columns>
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
    <br />
    <div style="height: 30px; border-top: #CCC dotted 1px; width: 100%; display: block;
        line-height: 28px; font-weight: bold; color: #000000; font-size: 13px;">
        <asp:Label ID="lbl_Adv" runat="server" Text="Advance Total :"></asp:Label>
        <asp:Label ID="LabelAdvance" runat="server" Style="color: #CC0000;"></asp:Label>
        <span class="splt">|</span>
        <div style="display: none">
            <asp:Label ID="lbl_Bill" runat="server" Text="Bill Total :"></asp:Label>
            <asp:Label ID="LabelBill" runat="server" Style="color: #CC0000;"></asp:Label><span
                class="splt">|</span><asp:Label ID="lbl_Refund" runat="server" Text="Refund Total :"></asp:Label>
            <asp:Label ID="LabelRefund" Style="color: #CC0000;" runat="server"></asp:Label>
        </div>
        <div align="right" style="float: right;">
            <strong>
                <asp:Label ID="LabelGtotal" runat="server" Text="Grand Total :"></asp:Label></strong>
            <strong>
                <asp:Label ID="LabelTotal" runat="server" CssClass="marks"></asp:Label></strong></div>
    </div>
    <br />
    <div class="bxmain">
    </div>
    <br />
    <asp:HiddenField ID="HiddenFieldDept_ID" runat="server" />
    <asp:HiddenField ID="HiddenFieldSubDept_Id" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Shift" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
        SelectCommand="SELECT [ShiftID], [ShiftName] FROM [Admin_Shift]"></asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldIndoorType" runat="server" />
    <asp:HiddenField ID="HiddenFieldAdv" runat="server" />
    <br />
    <asp:SqlDataSource ID="SDS_Voucher" runat="server" ConnectionString="<%$ ConnectionStrings:FinanceConnectionString1 %>"
        InsertCommand="JV_Counter_Close_Advance" InsertCommandType="StoredProcedure"
        ProviderName="<%$ ConnectionStrings:FinanceConnectionString1.ProviderName %>"
        CancelSelectOnNullParameter="False">
        <InsertParameters>
            <asp:SessionParameter Name="By_Emp_Id" SessionField="emp_id" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_Recieve_Amount_ID" Name="Receiving_Amount_ID"
                PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenFieldDept_ID" Name="Dept_Id" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="HiddenFieldSubDept_Id" Name="SubDept_Id" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="DropDownListShift" Name="shift_id" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:Parameter DefaultValue="'20140507'" Name="CCdate" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="usp_GetPatientAdvanceAdjustment" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDL_Employee" Name="EmpID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="WebDateChooserSdate" Name="DateFrom" PropertyName="Value" />
            <asp:ControlParameter ControlID="WebDateChooserEDate" Name="DateTo" PropertyName="Value" />
             <asp:ControlParameter ControlID="RadioButtonListAdjusted" Name="Type" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>"
        InsertCommand="Counter_Close" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:FinanceConnectionString.ProviderName %>"
        UpdateCommand="Update Receipt_Disbursement_AccountHeads set Receipt_Disbursement_AccountHeads.Shift_Id=@Shift_ID&#13;&#10;&#13;&#10;where Receipt_Disbursement_AccountHeads.Voucher_Trans_Id In (SELECT     distinct Reciept_Disbursement_Detail.Voucher_Trans_Id&#13;&#10;FROM         BasicDataInfo.dbo.Service_Payment_Main Service_Payment_Main INNER JOIN&#13;&#10;                      BasicDataInfo.dbo.Sub_Counter_Close Sub_Counter_Close ON Service_Payment_Main.Main_ID = Sub_Counter_Close.Main_Id INNER JOIN&#13;&#10;                      Reciept_Disbursement_Detail ON Sub_Counter_Close.YearlyNo = Reciept_Disbursement_Detail.Yearly_No &#13;&#10;where Sub_Counter_Close.Shift is null) &#13;&#10;&#13;&#10;">
        <InsertParameters>
            <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" />
            <asp:ControlParameter ControlID="HiddenField_gAmount" Name="Receive_Amount" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldDept_ID" Name="Dept_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldSubDept_Id" Name="SubDept_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldClosingDate" Name="DateandTime" PropertyName="Value" />
            <asp:Parameter Direction="InputOutput" Name="Identity" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="DropDownListShift" Name="Shift_ID" PropertyName="SelectedValue" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Save_SUb" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        InsertCommand="Counter_Close_Sub_indoor" InsertCommandType="StoredProcedure"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenField_Recieve_Amount_ID" Name="Receiving_Amount_ID"
                PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenFieldMain_Id" Name="Main_ID" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="DropDownListShift" DefaultValue="" Name="Shift_ID"
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenFieldDept_ID" Name="Dept_ID" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="HiddenFieldSubDept_Id" Name="SubDept_Id" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="HiddenFieldCounterAmount" Name="Amount" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="HiddenFieldRegNo" Name="Reg_No" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="HiddenFieldYearlyNo" Name="YearlyNo" PropertyName="Value"
                Type="Decimal" />
            <asp:ControlParameter ControlID="HiddenField_Amount_Type" Name="Type" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="HiddenFieldClosingDate" Name="DateTime" PropertyName="Value"
                Type="DateTime" />
            <asp:ControlParameter ControlID="HiddenFieldIndoorType" Name="IndoorType" PropertyName="Value"
                Type="String" />
            <asp:Parameter Name="SPM_ID" Type="Decimal" />
            <asp:Parameter Name="Adv_payment_ID" Type="Int32" />
            <asp:SessionParameter Name="emp_id" SessionField="emp_id" Type="Int32" />
            <asp:Parameter Name="return_payment_id" Type="Decimal" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldAmount" runat="server" />
    <asp:HiddenField ID="HiddenField_Recieve_Amount_ID" runat="server" />
    <asp:HiddenField ID="HiddenFieldMain_Id" runat="server" />
    <asp:HiddenField ID="HiddenFieldYearlyNo" runat="server" />
    <asp:HiddenField ID="HiddenFieldRegNo" runat="server" />
    <asp:HiddenField ID="HiddenFieldCounterAmount" runat="server" />
    <asp:HiddenField ID="HiddenFieldCash_Book_Id" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourceUpdate_Cash_Book" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        UpdateCommand="UPDATE Sub_Counter_Close SET Status = 1, Shift = @Shift WHERE (CashBook_ID = @CashBook_ID)">
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenFieldCash_Book_Id" Name="CashBook_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="DropDownListShift" Name="Shift" PropertyName="SelectedValue" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Amount_Type" runat="server" />
    <asp:HiddenField ID="HiddenField_gAmount" runat="server" />
</asp:Content>
