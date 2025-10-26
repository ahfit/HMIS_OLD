<%@ page title="" language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="Patient_Billing_Cash_Book_TypeWise, App_Web_asx2a3aw" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
    <%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span style="font-size:17px !important">Cash Collection ( Cardiac & General )</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td align="right" width="10%">
                    <strong style="font-size: large; color: Blue;">General-Indoor:&nbsp;&nbsp;</strong>
                </td>
                <td align="left" width="6%">
                    <asp:Label ID="lblOPDTotal" runat="server" Text="" ForeColor="Black" Font-Bold="true"
                        Font-Size="Large"></asp:Label>
                </td>
                <td align="right" width="10%">
                    <strong style="font-size: large; color: Blue;">Cardiac-Indoor:&nbsp;&nbsp;</strong>
                </td>
                <td align="left" width="6%">
                    <asp:Label ID="lblIPDCardic" runat="server" Text="" ForeColor="Black" Font-Bold="true"
                        Font-Size="Large"></asp:Label>
                </td>
                <td align="right" width="6%">
                    <strong style="font-size: large; color: Blue;">Total:&nbsp;&nbsp;</strong>
                </td>
                <td align="left" width="6%">
                    <asp:Label ID="lblTotal" runat="server" Text="" ForeColor="Black" Font-Bold="true"
                        Font-Size="Large"></asp:Label>
                </td>
                <td align="right" width="6%">
                    <strong style="font-size: large; color: Maroon;">Date:&nbsp;&nbsp;</strong>
                </td>
                <td align="left" width="6%">
                    <asp:Label ID="lblDate" runat="server" Text="" ForeColor="Black" Font-Bold="true"
                        Font-Size="Large"></asp:Label>
                </td>
                <td align="right" width="6%">
                    <strong style="font-size: large; color: Green;">Shift:&nbsp;&nbsp;</strong>
                </td>
                <td align="left" width="16%">
                    <asp:Label ID="lblShift" runat="server" Text="" ForeColor="Black" Font-Bold="true"
                        Font-Size="Large"></asp:Label>
                         ( <asp:Label ID="Label1" runat="server" Text="" ForeColor="Maroon" Font-Bold="true"
                        Font-Size="Small"></asp:Label> )
                </td>
            </tr>
        </table>
    </div><hr />
    <div style="width: 100%; margin-top: 10px;">
        <div class="inner_content" style="width: 100%;">
        <h1 class="h1"><span style="font-size:17px !important">General-Indoor</span></h1>
            <asp:GridView ID="GridView_Counter_Close" runat="server" AutoGenerateColumns="False"
                Width="100%" ShowFooter="True" DataKeyNames="CashBook_ID">
                <HeaderStyle CssClass="GridHeader" />
                <AlternatingRowStyle CssClass="GridAltItem" />
                <FooterStyle CssClass="myfooter" />
                <Columns>
                    <asp:TemplateField HeaderText="Mr #" >
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkbtnAdv" runat="server" Text="View" 
                                CommandArgument='<%# Eval("Main_Id") %>' onclick="lnkbtnAdv_Click"></asp:LinkButton>                                                      
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                    </asp:TemplateField> 
                    <asp:TemplateField HeaderText="Change Department" >
                        <ItemTemplate>
                            
                              <asp:LinkButton ID="lnkbtnchangeDeptGeneral" onclick="lnkbtnchangeDeptGeneral_Click"  runat="server" Text="Change"></asp:LinkButton>                            
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                    </asp:TemplateField>                    
                    <asp:BoundField DataField="YearlyNo" HeaderText="Visit #" SortExpression="YearlyNo" />
                     <asp:TemplateField HeaderText="Patient Name">
                        <ItemTemplate>
                            <asp:Label ID="lbl_name" runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>    
                    <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
                    <asp:BoundField DataField="CCTime" HeaderText="Time" SortExpression="CCTime" />
                    <asp:TemplateField HeaderText="Receipt No‎">
                        <ItemTemplate>
                            <asp:Label ID="lbl_reciept" runat="server" Text='<%# Bind("SPM_ID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Assigned Bed">
                        <ItemTemplate>
                            <asp:Label ID="lbl_AssignedBed" runat="server" Text='<%# Bind("AssignedBed") %>' style="color:Blue;"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="Employee" SortExpression="name" Visible = "false">
                        <ItemTemplate>
                            <asp:Label ID="lbl_Empname" runat="server" Text='<%# Bind("name") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                                   
                    <asp:TemplateField HeaderText="Payment" SortExpression="Amount_Type">
                        <ItemTemplate>
                            <asp:Label ID="lbl_payment_type" runat="server" Text='<%# Bind("Amount_Type") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Amount" SortExpression="Amount">
                        <ItemTemplate>
                            <asp:Label ID="lbl_amount"  CssClass='<%# Bind("BillType") %>'  runat="server" Text='<%# Bind("Amount") %>'></asp:Label>
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
                <%--            <asp:HiddenField ID="HiddenFieldRoom" runat="server" Value='<%# Bind("room", "{0}") %>' />--%>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Label ID="Lbl_T_Balance" runat="server" Width="100%" Font-Bold="True" Font-Size="Larger"
                                CssClass="AmountAlign"></asp:Label>
                        </FooterTemplate>
                    </asp:TemplateField>
                    
                </Columns>
            </asp:GridView>
        </div>
    </div><hr />
    <div style="width: 100%; margin-top: 10px;">
        <div class="inner_content" style="width: 100%;">
        <h1 class="h1"><span style="font-size:17px !important">Cardiac-Indoor</span></h1>
            <asp:GridView ID="gvCardicIPD" runat="server" AutoGenerateColumns="False"
                Width="100%" ShowFooter="True" DataKeyNames="CashBook_ID" >
                <HeaderStyle CssClass="GridHeader" />
                <AlternatingRowStyle CssClass="GridAltItem" />
                <FooterStyle CssClass="myfooter" />
                <Columns>
                    <asp:TemplateField HeaderText="Mr #" >
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkbtnAdv" runat="server" Text="View" CommandArgument='<%# Eval("Main_Id") %>'  onclick="lnkbtnAdv_Click"></asp:LinkButton>                            
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Change Department" >
                    <ItemTemplate>                            
                            <asp:LinkButton ID="lnkbtnchangeDeptCardiac"  onclick="lnkbtnchangeDeptCardiac_Click" runat="server" Text="Change"></asp:LinkButton>                            
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                    </asp:TemplateField>
                   
                    <asp:BoundField DataField="YearlyNo" HeaderText="Visit #" SortExpression="YearlyNo" />
                    <asp:TemplateField HeaderText="Patient Name">
                        <ItemTemplate>
                            <asp:Label ID="lbl_name" runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
                    <asp:BoundField DataField="CCTime" HeaderText="Time" SortExpression="CCTime" />
                    <asp:TemplateField HeaderText="Receipt No‎">
                        <ItemTemplate>
                            <asp:Label ID="lbl_reciept" runat="server" Text='<%# Bind("SPM_ID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="Assigned Bed">
                        <ItemTemplate>
                            <asp:Label ID="lbl_AssignedBed" runat="server" Text='<%# Bind("AssignedBed") %>' style="color:Blue;"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Employee" SortExpression="name" Visible = "false">
                        <ItemTemplate>
                            <asp:Label ID="lbl_Empname" runat="server" Text='<%# Bind("name") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>                 
                    <asp:TemplateField HeaderText="Payment" SortExpression="Amount_Type">
                        <ItemTemplate>
                            <asp:Label ID="lbl_payment_type" runat="server" Text='<%# Bind("Amount_Type") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
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
        </div>
    </div><hr />
    <div style="margin-top:20px; width=100%; text-align:right; margin-right: 0px;">
    <strong style="font-size: x-large; color: Blue;">Grand Total:&nbsp;</strong>
        <asp:Label Text="" runat="server" ID="lblGrandTotal" Font-Bold="true" Font-Size="X-Large" ForeColor="Blue"></asp:Label>
    </div><hr />
     <div class="bxmain" style="width: 100%">
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
                         <asp:Button ID="ButtonReport" runat="server" Text="Report" Visible="false" />
                    </td>
                   
                </tr>
            </table>
        </asp:Panel>
    </div><hr />
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
