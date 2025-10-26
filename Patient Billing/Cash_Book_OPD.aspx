<%@ page title="" language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="Patient_Billing_Cash_Book_TypeWise, App_Web_gswfk1g0" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <asp:Label ID="lblHeading" runat="server" Text=""></asp:Label></h2>
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td id="opd1" runat="server" align="right" width="9%">
                    <asp:Label ID="lblOPD" runat="server" Font-Size="Large" Font-Bold="true" ForeColor="Blue" Text="Outdoor:  "></asp:Label>
                    <%--<strong style="font-size: large; color: Blue;">Outdoor:&nbsp;&nbsp;</strong>--%>
                </td>
                <td id="opd11" runat="server" align="left" width="9%">
                    <asp:Label ID="lblOPDTotal" runat="server" Text="0" ForeColor="Black" Font-Bold="True"
                        Font-Size="Large"></asp:Label>
                </td>
                <td id="bas1" runat="server" align="right" width="9%">
                    <strong style="font-size: large; color: Blue;">Basment:</strong></td>
                <td id="bas2" runat="server" align="left" width="9%">
                    <asp:Label ID="lblBasment" runat="server" Font-Bold="True" Font-Size="Large" 
                        ForeColor="Black" Text="0"></asp:Label>
                </td>
                <td align="right" width="9%">
                    <strong style="font-size: large; color: Blue;">Total:</strong></td>
                <td align="left" width="9%">
                    <asp:Label ID="lblTotal" runat="server" Font-Bold="True" Font-Size="Large" 
                        ForeColor="Black" Text="0"></asp:Label>
                </td>
                <td align="right" width="9%">
                    <strong style="font-size: large; color: Maroon;">Date:&nbsp;&nbsp;</strong>
                </td>
                <td align="left" width="9%">
                    <asp:Label ID="lblDate" runat="server" Text="" ForeColor="Black" Font-Bold="true"
                        Font-Size="Large"></asp:Label>
                </td>
                <td align="right" width="9%">
                    <strong style="font-size: large; color: Green;">Shift:&nbsp;&nbsp;</strong>
                </td>
                <td align="left" width="19%">
                    <asp:Label ID="lblShift" runat="server" Text="" ForeColor="Black" Font-Bold="true"
                        Font-Size="Large"></asp:Label> ( <asp:Label ID="Label1" runat="server" Text="" ForeColor="Maroon" Font-Bold="true"
                        Font-Size="Small"></asp:Label> )
                </td>
               
            </tr>
           <%-- <tr>
                 <td align="right" width="10%">
                    <strong style="font-size: large; color: Green;">Name:&nbsp;&nbsp;</strong>
                </td>
                <td align="left" width="10%">
                    <asp:Label ID="lblName" runat="server" Text="" ForeColor="Black" Font-Bold="true"
                        Font-Size="Large"></asp:Label>
                </td>
            </tr>--%>
        </table>
    </div><hr />
    <div id="divOPD" runat="server" class="bxmain inner_content" style="width: 100%; margin-top: 10px;">
        <h1 class ="h1"><span  style="font-size:20px !important"> Outdoor Cash: <asp:Label ID="lblOpdEmp" runat="server" Visible="false"></asp:Label>
            <asp:Label ID="lbl_OD_OPDTB" runat="server" Text="0" ForeColor="Black" Font-Bold="True"
                        Font-Size="Large"></asp:Label>
                        </span></h1>

        <asp:GridView ID="GridView_Counter_Close" runat="server" AutoGenerateColumns="False"
            Width="100%" ShowFooter="True" DataKeyNames="CashBook_ID">
            <HeaderStyle CssClass="GridHeader" />
            <AlternatingRowStyle CssClass="GridAltItem" />
            <FooterStyle CssClass="myfooter" />
            <Columns>
            <asp:BoundField DataField="Serial_No" HeaderText="Recipt #" SortExpression="Serial_No" />
                <asp:TemplateField HeaderText="MR #" ItemStyle-Width="7%">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkbtnAdv" runat="server" Text="View" CommandArgument='<%# Eval("Main_Id") %>'
                            OnClick="lnkbtnAdv_Click"></asp:LinkButton>
                            <asp:HiddenField ID="hdfEmpName" runat="server" Value='<%# Eval("Name") %>' />
                        <%-- <asp:Label ID="Label1" runat="server" Text='<%# Bind("Reg_No") %>'></asp:Label>--%>
                    </ItemTemplate>
                    <ItemStyle Width="10%"></ItemStyle>
                </asp:TemplateField>
                <asp:BoundField DataField="YearlyNo" HeaderText="Visit #" SortExpression="YearlyNo" Visible="false" />
                <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
                <asp:BoundField DataField="CCTime" HeaderText="Time" SortExpression="CCTime" />
                <asp:TemplateField HeaderText="Receipt No‎" Visible="false">
                    <ItemTemplate>
                        <asp:Label ID="lbl_reciept" runat="server" Text='<%# Bind("SPM_ID") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Patient Name">
                    <ItemTemplate>
                        <asp:Label ID="lbl_name" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <%--<asp:BoundField DataField="Room" HeaderText="OPD/IPD" SortExpression="Room" />--%>
                <asp:TemplateField HeaderText="Payment" SortExpression="Amount_Type"  Visible="false">
                    <ItemTemplate>
                        <asp:Label ID="lbl_payment_type" runat="server" Text='<%# Bind("Amount_Type") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="S_Name" HeaderText="Services" SortExpression="S_Name" />
                
                <asp:BoundField DataField="Name" HeaderText="Employee" SortExpression="Name" Visible="false" />
                <asp:TemplateField HeaderText="Amount" SortExpression="Amount">
                    <ItemTemplate>
                        <asp:Label ID="lbl_amount" CssClass='<%# Bind("BillType") %>' runat="server" Text='<%# Bind("Amount") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="Lbl_Total" runat="server" Width="100%" Font-Bold="True" Font-Size="Larger"
                            CssClass="AmountAlign"></asp:Label>
                    </FooterTemplate>                    
                    <ItemStyle CssClass="toright" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Balance">
                    <ItemStyle CssClass="toright" />
                    <ItemTemplate>
                        <asp:Label ID="LabelBAmount" CssClass='<%# Bind("BillType") %>' runat="server" Text="Label">
                        </asp:Label>
                        <asp:HiddenField ID="hdfName" runat="server" Value='<%# Eval("Name", "{0}") %>' />
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
                        <%--<asp:HiddenField ID="HiddenFieldRoom" runat="server" Value='<%# Bind("room", "{0}") %>' />--%>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="Lbl_T_Balance" runat="server" Width="100%" Font-Bold="True" Font-Size="Larger"
                            CssClass="AmountAlign"></asp:Label>
                    </FooterTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div><hr />
      <div id="divBasment" runat="server" class="bxmain inner_content" style="width: 100%; margin-top: 10px;">
        <h1 class ="h1"><span  style="font-size:20px !important"> Basement Cash:
            <asp:Label ID="lbl_BOPD_TB" runat="server" Text="0" ForeColor="Black" Font-Bold="True"
                        Font-Size="Large"></asp:Label>
                        </span></h1>

        <asp:GridView ID="GridViewBasment" runat="server" AutoGenerateColumns="False"
            Width="100%" ShowFooter="True" DataKeyNames="CashBook_ID">
            <HeaderStyle CssClass="GridHeader" />
            <AlternatingRowStyle CssClass="GridAltItem" />
            <FooterStyle CssClass="myfooter" />
            <Columns>
                
                <asp:TemplateField HeaderText="MR #" ItemStyle-Width="7%" >
                    
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkbtnAdv" runat="server" Text="View" CommandArgument='<%# Eval("Main_Id") %>'
                            OnClick="lnkbtnAdv_Click"></asp:LinkButton>
                        <%-- <asp:Label ID="Label1" runat="server" Text='<%# Bind("Reg_No") %>'></asp:Label>--%>
                    </ItemTemplate>
                    <ItemStyle Width="10%" ></ItemStyle>
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
                        <asp:Label ID="lbl_name" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <%--<asp:BoundField DataField="Room" HeaderText="OPD/IPD" SortExpression="Room" />--%>
                <asp:TemplateField HeaderText="Payment" SortExpression="Amount_Type" Visible="false">
                    <ItemTemplate>
                        <asp:Label ID="lbl_payment_type" runat="server" Text='<%# Bind("Amount_Type") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="S_Name" HeaderText="Services" SortExpression="S_Name" />
                <asp:BoundField DataField="Name" HeaderText="Employee" SortExpression="Name" />
                <asp:TemplateField HeaderText="Amount" SortExpression="Amount">
                    <ItemTemplate>
                        <asp:Label ID="lbl_amount" CssClass='<%# Bind("BillType") %>' runat="server" Text='<%# Bind("Amount") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="Lbl_Total" runat="server" Width="100%" Font-Bold="True" Font-Size="Larger"
                            CssClass="AmountAlign"></asp:Label>
                    </FooterTemplate>
                    
                    <ItemStyle CssClass="toright" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Balance">
                    <ItemStyle CssClass="toright" />
                    <ItemTemplate>
                        <asp:Label ID="LabelBAmount" CssClass='<%# Bind("BillType") %>' runat="server" Text="Label">
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
                        <%--<asp:HiddenField ID="HiddenFieldRoom" runat="server" Value='<%# Bind("room", "{0}") %>' />--%>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="Lbl_T_Balance" runat="server" Width="100%" Font-Bold="True" Font-Size="Larger"
                            CssClass="AmountAlign"></asp:Label>
                    </FooterTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div><hr />
    <div style="margin-top: 20px; width=100%; text-align: right; margin-right: 0px;" >
        <strong style="font-size: x-large; color: Blue;">Grand Total:&nbsp;</strong>
        <asp:Label Text="" runat="server" ID="lblGrandTotal" Font-Bold="true" Font-Size="X-Large"
            ForeColor="Blue"></asp:Label>
    </div><hr />

    <div class="bxmain" style="width: 100%;">
        <asp:Panel ID="Pnl_Close" runat="server" Visible="true">
            <table cellpadding="0" cellspacing="0" border="0" class="tbl_form" width="100%">
                <tr>
                    <td align="right" width="40%" style="height: 18px">
                        <asp:Label ID="LabelShift" runat="server" Text="Shift Name :"></asp:Label>
                    </td>
                    <td width="60%" style="height: 18px">
                        <asp:DropDownList ID="DropDownListShift" runat="server" Width="202px" CssClass="dropbox"
                            DataSourceID="SqlDataSource_Shift" DataTextField="ShiftName" DataValueField="ShiftID">
                            <asp:ListItem Value="1">Morning</asp:ListItem>
                            <asp:ListItem Value="2">Evening</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource_Shift" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                            SelectCommand="SELECT [ShiftID], [ShiftName] FROM [Admin_Shift]"></asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="Label2" runat="server" Text="Date :"></asp:Label>
                    </td>
                    <td align="left">
                        <igsch:WebDateChooser ID="WebDateChooser_CounterDate" runat="server">
                        </igsch:WebDateChooser>
                        <asp:HiddenField ID="HiddenFieldWebChooser" runat="server"    />
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="2">
                        <asp:Button ID="Button1" runat="server" Text="Counter Close" />
                         <asp:Button ID="ButtonReport" runat="server" Text="Report" Visible="false" OnClick="ButtonReport_Click" />
                    </td>
                   
                </tr>
            </table>
        </asp:Panel>
    </div>

    <asp:SqlDataSource ID="SqlDataSource_Counter_Close" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
        InsertCommand="sp_Finace_Counter_Close" InsertCommandType="StoredProcedure" 
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" >
        <InsertParameters>
            <asp:SessionParameter Name="emp_id" SessionField="emp_id" Type="Int32" />
            <asp:SessionParameter Name="dept_ID" SessionField="dept_id" Type="Int32" />
            <asp:SessionParameter Name="subdept_id" SessionField="subdeptid" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownListShift" Name="shift" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenFieldWebChooser" DbType="Date" 
                Name="Date" PropertyName="Value" />
        </InsertParameters>
    </asp:SqlDataSource>
</asp:Content>
