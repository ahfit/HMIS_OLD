<%@ Page Language="VB" AutoEventWireup="false" CodeFile="~/Patient Billing/Cash_Book.aspx.vb"  MasterPageFile="~/hacims_masterpage_admin.master" Inherits="Patient_Billing_Cash_Book" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">



    <script language="javascript" type="text/javascript">
        function Prompt() {
            if (confirm(" Do You Want To Counter Close Now ?  \n Press OK for continue and Cancel for stop"))
                return true;
            else
                return false;
        }
        function confirmationSave() {
            if (confirm('Are you sure you want to Counter Close ?')) {
                return true;
            } else {
                return false;
            }
        }

    </script>



</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



    <asp:Label CssClass="err" ID="Label1" runat="server"></asp:Label>

    <div class="rpt_pos">
        <table width="100%">


            <tr>
                <td align="right">
                    <asp:Label ID="Lblselctemp" runat="server" Text="<b>Select Employee : </b>"></asp:Label>
                </td>

                <td align="center"> <asp:Label ID="lblEmployee" runat="server" Text="" Visible="true"></asp:Label></td>

                <td>
                    
                    <asp:DropDownList ID="DDL_Employee" runat="server" DataSourceID="SDS_Employee" DataTextField="NAME" DataValueField="EmpID" AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:Button ID="btn_Export" runat="server" Text="Export to Excel" />

                    <asp:SqlDataSource ID="SDS_Employee" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>" SelectCommand="SELECT ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS NAME, Employee.EmpID, Receptionist.Receptionist_id 
FROM Employee INNER JOIN Receptionist 
ON Employee.EmpID = Receptionist.Receptionist_id 
WHERE (Employee.ActiveStatus = 1) 
ORDER BY  ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') asc">
                    </asp:SqlDataSource>
                   
                </td>
                
            </tr>
           


        </table>
    </div>

    <br>
    <asp:GridView ID="GridView_Counter_Close" runat="server" AutoGenerateColumns="False" Width="100%" ShowFooter="True" DataKeyNames="CashBook_ID">
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
        <FooterStyle CssClass="myfooter" />
        <Columns>

            <asp:TemplateField HeaderText="MR #" ItemStyle-Width="7%">

                <ItemTemplate>

                    <asp:LinkButton ID="lnkbtnAdv" runat="server" Text='<%# Eval("Reg_No") %>' onclick="lnkbtnAdv_Click" CommandArgument='<%# Eval("Main_Id") %>'></asp:LinkButton>

                    <%--<asp:Label ID="Label1" runat="server" Text='<%# Bind("Reg_No") %>'></asp:Label>--%>
                </ItemTemplate>

                <ItemStyle Width="10%"></ItemStyle>
            </asp:TemplateField>
            <asp:BoundField DataField="YearlyNo" HeaderText="Visit #" SortExpression="YearlyNo" />
            <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
            <asp:BoundField DataField="CCTime" HeaderText="Time" SortExpression="CCTime" />
            <asp:TemplateField HeaderText="Receipt No‎">

                <ItemTemplate>
                    <asp:Label ID="lbl_reciept" runat="server" Text='<%# Bind("SPM_ID") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Patient Name">
                <ItemTemplate>
                    <asp:Label ID="lbl_name" runat="server" Text='<%# Eval("PatientName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Room" HeaderText="OPD/IPD" SortExpression="Room" />

            <asp:TemplateField HeaderText="Payment" SortExpression="Amount_Type">

                <ItemTemplate>
                    <asp:Label ID="lbl_payment_type" Visible="false" runat="server" Text='<%# Bind("Amount_Type") %>'></asp:Label>
                    <asp:LinkButton ID="lnkDetail" runat="server" Text='<%# Bind("Amount_Type") %>' OnClick="lnkDetail_Click" CommandArgument='<%# Eval("Main_Id") %>'></asp:LinkButton>

                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Amount" SortExpression="Amount">


                <ItemTemplate>
                    <asp:Label ID="lbl_amount" runat="server" Text='<%# Bind("Amount") %>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="Lbl_Total" runat="server" Width="100%" Font-Bold="True" Font-Size="Larger" CssClass="AmountAlign"></asp:Label>
                </FooterTemplate>
                <ControlStyle Font-Bold="False" />
                <ItemStyle CssClass="toright red" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Balance">
                <ItemStyle CssClass="toright" />
                <ItemTemplate>


                    <asp:Label ID="LabelBAmount" runat="server" Text="Label">
                    </asp:Label>

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

                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="Lbl_T_Balance" runat="server" Width="100%" Font-Bold="True" Font-Size="Larger" CssClass="AmountAlign"></asp:Label>
                </FooterTemplate>
            </asp:TemplateField>
            <%-- <asp:TemplateField HeaderText="Discount" >
             <ItemTemplate>
                 <asp:Label ID="lblDiscountPer" runat="server" Text='<%# Eval("Discount")%>'></asp:Label>
            </ItemTemplate>

            </asp:TemplateField>--%>
            <asp:TemplateField HeaderText="Panel">
                <ItemTemplate>
                    <asp:Label ID="lblPanel" runat="server" Text='<%# Eval("PanelAmount")%>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lblTPAMount" runat="server" Width="100%" Font-Bold="True" Font-Size="Larger" CssClass="AmountAlign"></asp:Label>
                </FooterTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Credit">
                <ItemTemplate>
                    <asp:Label ID="lblCreditAmount" runat="server" Text='<%# Eval("CreditAmount")%>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lblTCAMount" runat="server" Width="100%" Font-Bold="True" Font-Size="Larger" CssClass="AmountAlign"></asp:Label>
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Receivable">
                <ItemTemplate>
                    <asp:Label ID="lblReceivableAmount" runat="server" Text='<%# Eval("ReceivableAmount")%>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lblTRAMount" runat="server" Width="100%" Font-Bold="True" Font-Size="Larger" CssClass="AmountAlign"></asp:Label>
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Bank">
                <ItemTemplate>
                    <asp:Label ID="lblBankAmount" runat="server" Text='<%# Eval("BankAmount")%>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lblTBAMount" runat="server" Width="100%" Font-Bold="True" Font-Size="Larger" CssClass="AmountAlign"></asp:Label>
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate >
                    <asp:CheckBox ID="chkbox" runat="server" />
                </ItemTemplate>
                <HeaderTemplate>
                    <asp:CheckBox ID="chkboxAll" runat="server" AutoPostBack="true" OnCheckedChanged="chkboxAll_CheckedChanged" Checked="true"  />
                </HeaderTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <br />
    <div id="grdvisiblefalse" runat="server">
            <div  style="height:30px; border-top:#CCC dotted 1px; width:100%; display:block; line-height:28px; font-weight:bold; color:#000000; font-size:13px;">

        <asp:Label ID="lbl_Adv" runat="server" Text="Advance Total :"></asp:Label>
        <asp:Label ID="LabelAdvance" runat="server" style="color:#CC0000;"></asp:Label> <span class="splt">|</span>
        <asp:Label ID="lbl_Bill" runat="server" Text="Bill Total :"></asp:Label>
        <asp:Label ID="LabelBill" runat="server" style="color:#CC0000;"></asp:Label><span class="splt">|</span>
        <asp:Label ID="lbl_Refund" runat="server" Text="Refund Total :"></asp:Label>
        <asp:Label ID="LabelRefund" style="color:#CC0000;" runat="server"></asp:Label><span class="splt">|</span>
        <asp:Label ID="lblPanelTotal" runat="server" Text="Panel Total :"></asp:Label>
        <asp:Label ID="lblTotalPanelAmount" runat="server" style="color:#CC0000;"></asp:Label> <span class="splt">|</span>
        <asp:Label ID="lblCreditTotal" runat="server" Text="Credit Card Total :"></asp:Label>
        <asp:Label ID="lblTotalCreditAmount" runat="server" style="color:#CC0000;"></asp:Label><span class="splt">|</span>
        <asp:Label ID="lblReceivableTotal" runat="server" Text="Receiveable Total :"></asp:Label>
        <asp:Label ID="lblTotalReceiveableAmount" style="color:#CC0000;" runat="server"></asp:Label><span class="splt">|</span>
        <asp:Label ID="lblBankTotal" runat="server" Text="Bank Total :"></asp:Label>
        <asp:Label ID="lblTotalBankAmount" style="color:#CC0000;" runat="server"></asp:Label>
        <div align="right" style="float:right;"> <strong>
                <asp:Label ID="LabelGtotal" runat="server" Text="Grand Total :"></asp:Label>
            </strong>
            <strong>
                <asp:Label ID="LabelTotal" runat="server" CssClass="marks"></asp:Label>
            </strong></div>
    </div>


    <br />






    <div class="bxmain">
        <table cellpadding="0" cellspacing="0" border="0" class="tbl_form" width="100%">
            <tr>
                <td width="50%" align="right">
                    Counter Type :</td>
                <td width="50%">
                    <asp:DropDownList ID="DDL_CounterType" runat="server" Width="202px">
                    </asp:DropDownList>

                </td>
            </tr>
            <tr>
                <td align="right" width="40%" style="height: 18px">
                    <asp:Label ID="LabelShift" runat="server" Text="Shift Name :"></asp:Label>
                </td>
                <td width="60%" style="height: 18px">
                    <asp:DropDownList ID="DropDownListShift" runat="server" Width="202px" CssClass="dropbox" DataSourceID="SqlDataSource_Shift" DataTextField="ShiftName" DataValueField="ShiftID">
                        <asp:ListItem Value="1">Morning</asp:ListItem>
                        <asp:ListItem Value="2">Evening</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Label ID="Label2" runat="server" Text="Date :"></asp:Label>
                </td>
                <td align="left">
                    <igsch:webdatechooser id="WebDateChooser1" runat="server" Enabled="true"></igsch:webdatechooser>
                </td>
            </tr>

        </table>
    </div>
    <br />

    <div align="center">

        <asp:Button ID="Button1" runat="server" Text="Counter Close" OnClientClick="return confirmationSave()" />
        <asp:Button ID="ButtonReport" runat="server" Text="Report" />
    </div>
    <asp:HiddenField ID="HiddenFieldClosingDate" runat="server" />
    <br />
    <asp:HiddenField ID="HiddenFieldWebChooser" runat="server" />
    <asp:HiddenField ID="HiddenFieldDept_ID" runat="server" />
    <asp:HiddenField ID="HiddenFieldSubDept_Id" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Shift" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" SelectCommand="SELECT [ShiftID], [ShiftName] FROM [Admin_Shift]"></asp:SqlDataSource>
    <br />
    <asp:SqlDataSource ID="SqlDataSource_Discount_Adjustment" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" InsertCommand="INSERT INTO [PatientBillling].[dbo].[Discount_Main]
            ([DiscountDate]
           ,[Discount_Type]
           ,[emp_ID]
           ,[Total_Amount]
          
           ,[RegNo]
           ,[YearlyNo]
           ,[Payment_Status]
           ,[Discount_By]
           ,[Approved]
           ,[SPM_ID])
   
SELECT     Service_Payment_Main.Date_Time, 'IPD WARD' AS Expr1, Service_Payment_Main.Emp_ID, Payment_Detail.Discount, Service_Payment_Main.RegNo, 
                      Service_Payment_Main.YearlyNo, 1 AS Expr2, Service_Payment_Main.Emp_ID AS Expr3, 1 AS Expr4, Service_Payment_Main.SPM_ID
FROM         Payment_Detail INNER JOIN
                      Service_Payment_Main ON Payment_Detail.SPM_ID = Service_Payment_Main.SPM_ID LEFT OUTER JOIN
                      Discount_Main ON Payment_Detail.SPM_ID = Discount_Main.SPM_ID
WHERE     (Payment_Detail.Discount > 0) AND (Discount_Main.Discount_ID IS NULL)">
    </asp:SqlDataSource>




    <asp:HiddenField ID="HiddenFieldIndoorType" runat="server" />
    <asp:HiddenField ID="HiddenFieldAdv" runat="server" />




    <asp:SqlDataSource ID="SqlDataSource_PatientValueAdjustment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" UpdateCommand="UPDATE    Service_Payment_Sub
SET              Amount =Patient_Services.Amount
FROM         Patient_Services INNER JOIN
                      Service_Payment_Sub ON Patient_Services.ID = Service_Payment_Sub.P_SID AND Patient_Services.Amount &lt;&gt; Service_Payment_Sub.Amount">
    </asp:SqlDataSource>

    <br />


    <asp:SqlDataSource ID="SqlDataSource_Counter_Close" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" InsertCommand="sp_Insert_Counter_Close" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:SessionParameter Name="emp_id" SessionField="emp_id" Type="Int32" />
            <asp:SessionParameter Name="dept_ID" SessionField="dept_id" Type="Int32" />
            <asp:SessionParameter Name="subdept_id" SessionField="subdeptid" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownListShift" Name="shift" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenFieldWebChooser" DbType="Date" Name="Date" PropertyName="Value" />
            <asp:Parameter Name="CashBook_ID" />
            <asp:ControlParameter ControlID="DDL_CounterType" Name="CounterType" PropertyName="SelectedValue" Type="String" />
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
        </div>

</asp:Content>
