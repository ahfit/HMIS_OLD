<%@ Page Title="" Language="vb" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="Cash_Deposit_To_Bank.aspx.vb" Inherits="Patient_Billing_Cash_Deposit_To_Bank" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <script language ="javascript"  type ="text/javascript" >
    function Prompt() {
        if (confirm(" Do You Want To Counter Close Now ?  \n Press OK for continue and Cancel for stop"))
            return true;
        else
            return false;
    }
</script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


    <asp:Label CssClass="err"  ID="Label1" runat="server"></asp:Label>

<div align="right" style="height:30px; border-top:#CCC dotted 1px; width:100%; display:block;line-height:28px; font-weight:bold; color:#000000; font-size:13px;">
  <asp:Button ID = "btn_export" runat = "server" Text ="Export To Excel" />

  </div>
  <%--DataSourceID="SqlDataSourceForGrid"--%>
 <asp:GridView ID="GridView_Counter_Close" runat="server" AutoGenerateColumns="False"
                                 Width="100%" ShowFooter="True" DataKeyNames="CashBook_ID" DataSourceID="SqlDataSourceForGrid">
                                <HeaderStyle CssClass="GridHeader" />
                                <AlternatingRowStyle CssClass="GridAltItem" />
     <FooterStyle CssClass="myfooter" />
     <Columns>
       
         <asp:TemplateField HeaderText="MR #" ItemStyle-Width = "7%">
            
             <ItemTemplate>
             
              <asp:LinkButton ID = "lnkbtnAdv" runat = "server"
                     Text ="View" onclick="lnkbtnAdv_Click" 
                     CommandArgument='<%# Eval("Main_Id") %>'></asp:LinkButton>
                     
               
             </ItemTemplate>

<ItemStyle Width="10%"></ItemStyle>
         </asp:TemplateField>
         <asp:BoundField DataField="YearlyNo" HeaderText="Visit #" SortExpression="YearlyNo" />
         <asp:TemplateField HeaderText="Receipt No‎">
        
             <ItemTemplate>
                 <asp:Label ID="lbl_reciept" runat="server" Text='<%# Bind("SMP_ID") %>'></asp:Label>
             </ItemTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Patient Name">
             <ItemTemplate>
                 <asp:Label ID="lbl_name" runat="server"></asp:Label>
             </ItemTemplate>
         </asp:TemplateField>
         <asp:BoundField DataField="Room" HeaderText="Room" SortExpression="Room" 
             Visible="False" />
         <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
         <asp:TemplateField HeaderText="Payment Type" SortExpression="Amount_Type">
            
             <ItemTemplate>
                 <asp:Label ID="lbl_payment_type" runat="server" 
                     Text='<%# Bind("Amount_Type") %>'></asp:Label>
             </ItemTemplate>
         </asp:TemplateField>
            <asp:TemplateField HeaderText="Amount" SortExpression="Amount">
         
             <ItemTemplate>
                 <asp:Label ID="lbl_amount" runat="server" Text='<%# Bind("Amount") %>'></asp:Label>
             </ItemTemplate>

             <FooterTemplate>
                 <asp:Label ID="Lbl_Total" runat="server" Width = "100%" Font-Bold="True" Font-Size="Larger" CssClass="AmountAlign"></asp:Label>
             </FooterTemplate>
             <ControlStyle Font-Bold="False" />
             <ItemStyle CssClass="toright red" />
         </asp:TemplateField>
          <asp:TemplateField HeaderText="Panel" SortExpression="Panel">
         
             <ItemTemplate>
                 <asp:Label ID="lbl_PanelAmount" runat="server" Text='<%# Bind("PanelAmount")%>'></asp:Label>
             </ItemTemplate>

           <%--  <FooterTemplate>
                 <asp:Label ID="Lbl_TotalPanelAmount" runat="server" Width = "100%" Font-Bold="True" Font-Size="Larger" CssClass="AmountAlign"></asp:Label>
             </FooterTemplate>--%>
             <ControlStyle Font-Bold="False" />
             <ItemStyle CssClass="toright red" />
         </asp:TemplateField>

          <asp:TemplateField HeaderText="Credit" SortExpression="CreditAmount">
         
             <ItemTemplate>
                 <asp:Label ID="lbl_CreditAmount" runat="server" Text='<%# Bind("CreditAmount")%>'></asp:Label>
             </ItemTemplate>

           <%--  <FooterTemplate>
                 <asp:Label ID="Lbl_TotalCreditAmount" runat="server" Width = "100%" Font-Bold="True" Font-Size="Larger" CssClass="AmountAlign"></asp:Label>
             </FooterTemplate>--%>
             <ControlStyle Font-Bold="False" />
             <ItemStyle CssClass="toright red" />
         </asp:TemplateField>
          <asp:TemplateField HeaderText="Receivable" SortExpression="ReceivableAmount">
         
             <ItemTemplate>
                 <asp:Label ID="lbl_ReceivableAmount" runat="server" Text='<%# Bind("ReceivableAmount")%>'></asp:Label>
             </ItemTemplate>

           <%--  <FooterTemplate>
                 <asp:Label ID="Lbl_TotalReceivableAmount" runat="server" Width = "100%" Font-Bold="True" Font-Size="Larger" CssClass="AmountAlign"></asp:Label>
             </FooterTemplate>--%>
             <ControlStyle Font-Bold="False" />
             <ItemStyle CssClass="toright red" />
         </asp:TemplateField>

          <asp:TemplateField HeaderText="Bank" SortExpression="BankAmount">
         
             <ItemTemplate>
                 <asp:Label ID="lbl_BankAmount" runat="server" Text='<%# Bind("BankAmount")%>'></asp:Label>
             </ItemTemplate>

           <%--  <FooterTemplate>
                 <asp:Label ID="Lbl_TotalReceivableAmount" runat="server" Width = "100%" Font-Bold="True" Font-Size="Larger" CssClass="AmountAlign"></asp:Label>
             </FooterTemplate>--%>
             <ControlStyle Font-Bold="False" />
             <ItemStyle CssClass="toright red" />
         </asp:TemplateField>

         <asp:TemplateField HeaderText="Balance">
          <ItemStyle  CssClass="toright"/>
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
                 <asp:HiddenField ID="HiddenFieldSPM_ID" runat="server" Value='<%# Eval("SMP_ID", "{0}") %>' />
                  <asp:HiddenField ID="HiddenFieldAdv_pay_id" runat="server" Value='<%# Eval("Adv_payment_ID", "{0}") %>' />
                 <asp:HiddenField ID="HiddenFieldDept_ID" runat="server" Value='<%# Bind("Dept_ID", "{0}") %>' />
                 <asp:HiddenField ID="HiddenFieldSubDept_Id" runat="server" Value='<%# Bind("SubDept_ID", "{0}") %>' />
                  <asp:HiddenField ID="HiddenFieldPaymentCategory" runat="server" Value='<%# Bind("PaymentCategory", "{0}") %>' />
                 
             </ItemTemplate>
             <FooterTemplate>
                 <asp:Label ID="Lbl_T_Balance" runat="server" Width = "100%" Font-Bold="True" Font-Size="Larger" CssClass="AmountAlign"></asp:Label>
             </FooterTemplate>
         </asp:TemplateField>
        
     </Columns>
                            </asp:GridView>
   
    <br />
    
    
    <br />

<div style="height:30px; border-top:#CCC dotted 1px; width:100%; display:block; line-height:28px; font-weight:bold; color:#000000; font-size:13px;">

 <asp:Label ID="lbl_Adv" runat="server"   Text="Advance Total :"></asp:Label>
    <asp:Label ID="LabelAdvance" runat="server" style="color:#CC0000;"  ></asp:Label> <span class="splt">|</span>
    <asp:Label ID="lbl_TotalCash" runat="server" Text="Cash :"></asp:Label>
    <asp:Label ID="lblTotalCash" runat="server" style="color:#CC0000;">

    </asp:Label>
    <span class="splt">|</span><asp:Label ID="lbl_Refund"
                runat="server"   Text="Refund Total :"></asp:Label> <asp:Label ID="LabelRefund"  style="color:#CC0000;"
                    runat="server"  ></asp:Label>

<div align="right" style="float:right;"> <strong><asp:Label ID="LabelGtotal" runat="server" Text="Grand Total :"></asp:Label></strong>
   <strong> <asp:Label ID="LabelTotal" runat="server" CssClass="marks" ></asp:Label></strong></div>
</div>
    
    
   <br />




   


    <br />

   
    <asp:HiddenField ID="HiddenFieldClosingDate" runat="server" />
    <asp:HiddenField ID="HiddenFieldDept_ID" runat="server" />
    <asp:HiddenField ID="HiddenFieldSubDept_Id" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Shift" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
        SelectCommand="SELECT [ShiftID], [ShiftName] FROM [Admin_Shift]"></asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldIndoorType" runat="server" />
    <br />


    <asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="Cash_Submitted_Detail" SelectCommandType="StoredProcedure" 
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:QueryStringParameter Name="Date" QueryStringField="Dt" Type="DateTime" />
            <asp:QueryStringParameter Name="Hos_ID" QueryStringField="Hid" Type="Int32" />
            <asp:QueryStringParameter Name="shift_ID" QueryStringField="ShID" 
                Type="Int32" />
            <asp:QueryStringParameter Name="subdept_id" QueryStringField="SDID" 
                Type="Int32" />
            <asp:QueryStringParameter Name="emp_id" QueryStringField="EID" Type="Int32" />
             <asp:QueryStringParameter Name="VID" QueryStringField="VID" 
                Type="Int32" />
            <asp:QueryStringParameter Name="rec_amt_id" QueryStringField="PID" 
                Type="Int32" />
            <asp:QueryStringParameter Name="EDate" QueryStringField="DT" Type="DateTime" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>"
        InsertCommand="Counter_Close" 
        InsertCommandType="StoredProcedure" 
        ProviderName="<%$ ConnectionStrings:FinanceConnectionString.ProviderName %>" 
        UpdateCommand="Update Receipt_Disbursement_AccountHeads set Receipt_Disbursement_AccountHeads.Shift_Id=@Shift_ID&#13;&#10;&#13;&#10;where Receipt_Disbursement_AccountHeads.Voucher_Trans_Id In (SELECT     distinct Reciept_Disbursement_Detail.Voucher_Trans_Id&#13;&#10;FROM         BasicDataInfo.dbo.Service_Payment_Main Service_Payment_Main INNER JOIN&#13;&#10;                      BasicDataInfo.dbo.Sub_Counter_Close Sub_Counter_Close ON Service_Payment_Main.Main_ID = Sub_Counter_Close.Main_Id INNER JOIN&#13;&#10;                      Reciept_Disbursement_Detail ON Sub_Counter_Close.YearlyNo = Reciept_Disbursement_Detail.Yearly_No &#13;&#10;where Sub_Counter_Close.Shift is null) &#13;&#10;&#13;&#10;">
        <InsertParameters>
            <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" />
            <asp:ControlParameter ControlID="HiddenField_gAmount" Name="Receive_Amount" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldDept_ID" Name="Dept_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldSubDept_Id" Name="SubDept_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldClosingDate" Name="DateandTime" PropertyName="Value" />
            <asp:Parameter Direction="Output" Name="val" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownListShift" Name="Shift_Id" PropertyName="SelectedValue"
                Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="DropDownListShift" Name="Shift_ID" PropertyName="SelectedValue" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Save_SUb" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        InsertCommand="Counter_Close_Sub_indoor" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
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
            <asp:SessionParameter Name="emp_id" SessionField="emp_id" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldAmount" runat="server" />
    <asp:HiddenField ID="HiddenField_Recieve_Amount_ID" runat="server" />
    <asp:HiddenField ID="HiddenFieldMain_Id" runat="server" />
    <asp:HiddenField ID="HiddenFieldYearlyNo" runat="server" />
    <asp:HiddenField ID="HiddenFieldRegNo" runat="server" />
    <asp:HiddenField ID="HiddenFieldCounterAmount" runat="server" />
    <asp:HiddenField ID="HiddenFieldCash_Book_Id" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourceUpdate_Cash_Book" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" UpdateCommand="UPDATE Sub_Counter_Close SET Status = 1, Shift = @Shift WHERE (CashBook_ID = @CashBook_ID)">
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenFieldCash_Book_Id" Name="CashBook_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="DropDownListShift" Name="Shift" PropertyName="SelectedValue" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Amount_Type" runat="server" />
    <asp:HiddenField ID="HiddenField_gAmount" runat="server" />
</asp:Content>

