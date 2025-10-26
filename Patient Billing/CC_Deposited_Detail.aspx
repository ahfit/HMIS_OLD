<%@ page title="" language="vb" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="CC_Deposited_Detail, App_Web_asx2a3aw" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
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

 <asp:GridView ID="GridView_Counter_Close" runat="server" AutoGenerateColumns="False"
                                 Width="100%" ShowFooter="True" 
        DataKeyNames="CashBook_ID" DataSourceID="SqlDataSourceForGrid">
                                <HeaderStyle CssClass="GridHeader" />
                                <AlternatingRowStyle CssClass="GridAltItem" />
     <FooterStyle CssClass="myfooter" />
     <Columns>
         <asp:TemplateField HeaderText="SrNo."> 
<ItemTemplate> <%#Container.DataItemIndex+1%> 
</ItemTemplate>
<ItemStyle Width="5%" /> 
</asp:TemplateField>
         <asp:TemplateField HeaderText="Registration No." SortExpression="Registration #">
             <EditItemTemplate>
                 <asp:TextBox ID="Txtq" runat="server" Text='<%# Bind("Reg_No") %>'></asp:TextBox>
             </EditItemTemplate>
             <ItemTemplate>
                 <asp:Label ID="lbl_reg" runat="server" Text='<%# Bind("Reg_No") %>'></asp:Label>
             </ItemTemplate>
         </asp:TemplateField>
         <asp:BoundField DataField="reciept_No" HeaderText="Reciept No." 
             SortExpression="reciept_No" />
         <asp:TemplateField HeaderText="Patient Name" SortExpression="PFName">
             <ItemTemplate>
             
                 <asp:Label ID="LBL_Patient_Name" runat="server"></asp:Label>
                 <asp:HiddenField ID="HF_F_Name" runat="server" Value='<%# Eval("PFName") %>' />
                 <asp:HiddenField ID="HF_M_Name" runat="server" Value='<%# Eval("PMName") %>' />
                 <asp:HiddenField ID="HF_L_Name" runat="server" Value='<%# Eval("PLName") %>' />
                 <asp:HiddenField ID="Hf_Cat" runat="server" Value='<%# Eval("Amount_Type") %>' />
             </ItemTemplate>
             <EditItemTemplate>
                 <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("PFName") %>'></asp:TextBox>
             </EditItemTemplate>
         </asp:TemplateField>
        
         <asp:BoundField DataField="YearlyNo" HeaderText="YearlyNo" 
             SortExpression="YearlyNo" />
         <asp:BoundField DataField="Department" HeaderText="Department" 
             SortExpression="Department" />
         <asp:BoundField DataField="Amount_Type" HeaderText="Category" 
             SortExpression="Amount_Type" />
              <asp:BoundField DataField="DoctorName" HeaderText="Doctor Name" 
             SortExpression="DoctorName" />
         <asp:BoundField DataField="Detail" HeaderText="Avail Services" 
             SortExpression="Detail" />
          <asp:BoundField DataField="Patient_Type" HeaderText="Patient Type" 
             SortExpression="Patient_Type" />
          <asp:BoundField DataField="Party_Name" HeaderText="Corporate Company" 
             SortExpression="Party_Name" />
         
         <asp:TemplateField HeaderText="Amount" SortExpression="Amount">
             <FooterTemplate>
                 <strong>Total Balance :</strong>
             </FooterTemplate>
             
             <ItemTemplate>
                 <asp:Label ID="LBL_Amount" runat="server" Text='<%# Bind("Amount") %>'></asp:Label>
                 <asp:HiddenField id = "hf_amount" runat = "server"  value='<%# Bind("Amount") %>' />
             </ItemTemplate>
             <EditItemTemplate>
                 <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Amount") %>'></asp:TextBox>
             </EditItemTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Balance">
             <ItemTemplate>
                 <asp:Label ID="lbl_Balance" runat="server" Text="0"></asp:Label>
             </ItemTemplate>
              <FooterTemplate>
                 <asp:Label ID = "total_Remain" runat="server" Text="0" ForeColor ="RED" Font-Size ="Larger" Font-Bold = "true"></asp:Label>
             </FooterTemplate>
         </asp:TemplateField>
     </Columns>
                           </asp:GridView>
   
    <br />
    
    
    <br />

<div style="height:30px; border-top:#CCC dotted 1px; width:100%; display:block; line-height:28px; font-weight:bold; color:#000000; font-size:13px;">

 <asp:Label ID="lbl_Adv" runat="server"   Text="Advance Total :"></asp:Label>
    <asp:Label ID="LabelAdvance" runat="server" style="color:#CC0000;"  ></asp:Label> <span class="splt">|</span>
    <asp:Label   ID="lbl_Bill" runat="server"   Text="Adjusted Advance Total :"></asp:Label> <asp:Label
            ID="LabelBill" runat="server"  style="color:#CC0000;" ></asp:Label><span class="splt">|</span><asp:Label ID="lbl_Refund"
                runat="server"   Text="Bill Total :"></asp:Label> <asp:Label ID="LabelRefund"  style="color:#CC0000;"
                    runat="server"  ></asp:Label>
                    <span class="splt">|</span><asp:Label ID="Label2"
                runat="server"   Text="Discount Total :"></asp:Label> <asp:Label ID="LabelDiscount"  style="color:#CC0000;"
                    runat="server" text="0"  ></asp:Label>

<div align="right" style="float:right;"> <strong><asp:Label ID="LabelGtotal" 
        runat="server" Text="Cash Balance :"></asp:Label></strong>
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
    <asp:HiddenField ID="hf_date" runat="server" />
    <br />


    <asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="rpt_CC_detail" SelectCommandType="StoredProcedure" 
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:ControlParameter ControlID="hf_date" Name="CCDAte" PropertyName="Value" 
                Type="String" />
            <asp:QueryStringParameter Name="Dept_Id" QueryStringField="Hid" Type="Int32" />
            <asp:QueryStringParameter Name="shift_id" QueryStringField="ShID" 
                Type="Int32" />
            <asp:QueryStringParameter Name="SubDept_Id" QueryStringField="SDID" 
                Type="Int32" />
            <asp:QueryStringParameter Name="CC_Emp_Id" QueryStringField="EID" Type="Int32" />
             <asp:QueryStringParameter Name="Entry_Voucher_Trans_ID" QueryStringField="VID" 
                Type="Int32" />
           
            <asp:QueryStringParameter Name="rec_amount_id" QueryStringField="PID" 
                Type="Int32" />
           
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

