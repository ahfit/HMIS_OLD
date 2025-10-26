<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="CashSubmittedDateWiseCollective.aspx.cs" Inherits="Patient_CashSubmittedDateWiseCollective" %>
<%--<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>--%>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type ="text/css">

       .lightbox_bg1{
           opacity: 0.9;
       }

   </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class=" inner_content ">
        <h2>
            <span>Cash Submitted Date Wise</span></h2>
        <table class="tbl_form">
            <tr>
                <td   align="right">Select Hospital :
                </td>
                <td  >
                    <asp:DropDownList ID="DDL_Hospital" Enabled="false" runat="server" DataSourceID="SDS_Hospital" Width="220px" CssClass="drop_down"
                        DataTextField="Hospital_Name" DataValueField="Hospital_ID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SDS_Hospital" runat="server"
                        ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                        SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"></asp:SqlDataSource>
                </td>
            
                <td   align="right">Select Shift :</td>
                <td  >
                    <asp:DropDownList ID="DDL_Shift" runat="server" CssClass="drop_down" Width="220px">
                        <asp:ListItem Value="0">All</asp:ListItem>
                        <asp:ListItem Value="1">Morning</asp:ListItem>
                        <asp:ListItem Value="2">Evening</asp:ListItem>
                        <asp:ListItem Value="3">Night</asp:ListItem>
                    </asp:DropDownList>

                </td>
          
                <td   align="right">Counter Type :</td>
                <td  >
                    <asp:DropDownList ID="DDL_CounterType" runat="server"  Width="220px" CssClass="drop_down">
                    </asp:DropDownList>

                </td>
            </tr>
            <tr>
                <td   align="right">Select Employee :</td>
                <td  >
                    <asp:DropDownList ID="DDL_Employee" runat="server" Width="220px" DataSourceID="sds_Emp" DataTextField="name" DataValueField="EmpID" CssClass="drop_down">
                    </asp:DropDownList>

                    <asp:SqlDataSource ID="sds_Emp" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="SELECT 0 EmpID,' --- All ---' name Union All Select a.EmpID ,A.Name From( SELECT  Top(100)    E.EmpID,isnull(E.EFName,'')+' '+isnull(E.EMName,'')+' '+ isnull(E.ELName,'')  as Name from		BasicDataInfo.dbo.Receptionist R Inner Join  Employee E on R.Receptionist_id = E.EmpID Where (@CounterType ='ALL' or R.CounterType = @CounterType) 	order by E.EFName+' '+ E.ELName ) a" CancelSelectOnNullParameter="False">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DDL_CounterType" Name="CounterType" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                </td>
           
                <td   align="right">Select Start Date :
                </td>
                <td  >
                    <igsch:WebDateChooser ID="WebDateChooser_SDate" runat="server"
                        Width="202px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>

                </td>
            
                <td align="right">Select End Date : </td>
                <td >
                    <igsch:WebDateChooser ID="WebDateChooser_EDate" runat="server"
                        Width="202px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>

                </td>
            </tr>
            <tr>
                <td colspan="6" align="center" style="padding-bottom:10px;padding-top:10px">

                    <asp:Button ID="Button1" runat="server" Text="Search" OnClick="Button1_Click" />

                    <asp:Button ID="BTn_Deposit" runat="server" Text="Deposit" Width="100px"
                        OnClick="BTn_Deposit_Click" />
                    <asp:Button ID="Btn_Approve" runat="server" Text="Post" Width="100px" OnClick="Btn_Approve_Click" />
                    <asp:Button ID="BtnReportCashSubmittedDateWise" runat="server" Text="View Report" OnClick="BtnReportCashSubmittedDateWise_Click" />
                    <asp:Label ID="lblMsg" runat="server" CssClass="red"></asp:Label>
                </td>

            </tr>
            <tr>
                <td colspan="6" style="margin-bottom:5px">
                    <div class="inner_content" >
                        <h2>
                            <span></span></h2>
                    </div>
                </td>

            </tr>
            <tr>
                <td colspan="6" align="center">

                    <asp:GridView ID="Gv_Report" runat="server" AutoGenerateColumns="False" Width="100%"
                        DataSourceID="SDS_Report" OnPreRender="Gv_Report_PreRender"
                        ShowFooter="True">
                        <Columns>
                            <asp:TemplateField HeaderText="SrNo.">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1%>
                                </ItemTemplate>
                                <ItemStyle Width="3%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Payment Ticket">
                                <ItemTemplate>
                                    <asp:HyperLink runat="server" Target="_blank" ID="lnkTicket" Text='<%# Bind("Payment_ticket") %>'></asp:HyperLink>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Receipt" HeaderText="Receipt(From - To)" ReadOnly="True"
                                SortExpression="Receipt" Visible="False" />
                            <asp:BoundField DataField="Hospital_Name" HeaderText="Hospital Name"
                                SortExpression="Hospital_Name" />
                            <asp:BoundField DataField="Department" HeaderText="Department" ReadOnly="True"
                                SortExpression="Department" />
                            <asp:BoundField DataField="Shift" HeaderText="Shift" SortExpression="Shift" />
                            <asp:TemplateField HeaderText="Total Amount" SortExpression="TotalAmount">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCash" Text='<%# Bind("TotalAmount") %>'></asp:Label>
                                </ItemTemplate>
                                <%-- <EditItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("Cash") %>'></asp:Label>
                        </EditItemTemplate>--%>
                                <FooterTemplate>
                                    <asp:Label ID="lblTotal_Cash" runat="server" Text="0"></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Credit">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCreditAmount" Text='<%# Bind("CreditAmount") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="lblTotal_CreditAmount" runat="server" Text="0"></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Bank">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblBankAmount" Text='<%# Bind("BankAmount") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="lblTotal_BankAmount" runat="server" Text="0"></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Receivable">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblReceivableAmount" Text='<%# Bind("ReceivableAmount") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="lblTotal_ReceivableAmount" runat="server" Text="0"></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Panel">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblPanelAmount" Text='<%# Bind("PanelAmount") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="lblTotal_PanelAmount" runat="server" Text="0"></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="DateTime" HeaderText="Date" ReadOnly="True"
                                SortExpression="CC_Date" Visible="True" />


                            <asp:BoundField DataField="Closed_By" HeaderText="Closed By"
                                SortExpression="Closed_By" />


                            <asp:BoundField DataField="Shift_ID" HeaderText="Shift_ID"
                                InsertVisible="False" ReadOnly="True" SortExpression="Shift_ID" Visible="false" />
                            <asp:BoundField DataField="SubDept_Id" HeaderText="SubDept_Id"
                                SortExpression="SubDept_Id" Visible="false" />
                            <asp:HyperLinkField Target="_blank" Text="Detail"
                                DataNavigateUrlFields="Hospital_ID,SubDept_ID,Shift_ID,CC_Date,VStatus,emp_id,Entry_Voucher_Trans_ID,Payment_ticket"
                                DataNavigateUrlFormatString="Cash_Deposit_To_Bank.aspx?Hid={0}&amp;SDID={1}&amp;ShID={2}&amp;Dt={3}&amp;VS={4}&amp;EID={5}&amp;VID={6}&amp;PID={7}"
                                HeaderText="Receipt Wise" />
                            <asp:HyperLinkField Target="_blank" Text="Detail"
                                DataNavigateUrlFields="Dept_ID,SubDept_ID,Shift_ID,CC_Date,VStatus,emp_id,Entry_Voucher_Trans_ID,Payment_ticket"
                                DataNavigateUrlFormatString="CC_Deposited_Detail.aspx?Hid={0}&amp;SDID={1}&amp;ShID={2}&amp;Dt={3}&amp;VS={4}&amp;EID={5}&amp;VID={6}&amp;PID={7}"
                                HeaderText="Services Wise"/>
                            <asp:HyperLinkField Target="_blank" Text="Receipt Wise"
                                DataNavigateUrlFields="CC_Date,CC_Date,Hospital_ID,Shift_ID,Payment_ticket"
                                DataNavigateUrlFormatString="NewCashReport.aspx?Sdate={0}&Edate={1}&Hid={2}&SID={3}&PID={4}"
                                HeaderText="Receipt Wise" />

                            <asp:HyperLinkField Target="_blank" Text="print"
                                DataNavigateUrlFields="Dept_ID,SubDept_ID,Shift_ID,CC_Date,VStatus,emp_id,Entry_Voucher_Trans_ID,Payment_ticket,Hospital_id"
                                DataNavigateUrlFormatString="~/Patient Billing/Cash_Book_reportSubmitted.aspx?Hid={8}&amp;SDID={1}&amp;ShID={2}&amp;Dt={3}&amp;VS={4}&amp;EID={5}&amp;VID={6}&amp;EDate={3}&amp;PID={7}&amp;DID={7}"
                                HeaderText="Report" />
                            <asp:TemplateField HeaderText="View Voucher">
                                <HeaderTemplate>
                                    <asp:CheckBox ID="CHK_approve" runat="server" AutoPostBack="True"
                                        Text="Approve " TextAlign="Left"
                                        OnCheckedChanged="CHK_approve_CheckedChanged" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton2" runat="server" OnClick="LinkButton1_Click"
                                        CommandArgument='<%# Eval("Entry_Voucher_Trans_ID") %>' Text='Posted Voucher'
                                        Visible='<%# Eval("LStatus_V_Vis") %>'></asp:LinkButton>
                                    <asp:CheckBox ID="Chk_EV" runat="server" Visible='<%# Eval("Status_V_Vis") %>' />
                                    <br />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="View Bank Voucher">
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click"
                                        Text='Bank Voucher'
                                        CommandArgument='<%# Eval("Voucher_Trans_ID") %>'
                                        Visible='<%# Eval("LStatus_Vis") %>'></asp:LinkButton>
                                    <asp:CheckBox ID="Chk_add" runat="server" Visible='<%# Eval("Status_Vis") %>' />
                                    <asp:HiddenField ID="hf_Shift_ID" runat="server"
                                        Value='<%# Eval("Shift_ID") %>' />
                                    <asp:HiddenField ID="HF_Subdept_id" runat="server"
                                        Value='<%# Eval("SubDept_Id") %>' />
                                    <asp:HiddenField ID="Hf_Hospital" runat="server"
                                        Value='<%# Eval("Hospital_ID") %>' />
                                    <asp:HiddenField ID="HF_Department" runat="server"
                                        Value='<%# Eval("Dept_Id") %>' />
                                    <asp:HiddenField ID="HF_emp_id" runat="server"
                                        Value='<%# Eval("emp_id") %>' />
                                    <asp:HiddenField ID="HF_Ent_Voucher" runat="server"
                                        Value='<%# Eval("Entry_Voucher_Trans_ID") %>' />

                                    <asp:HiddenField ID="HF_Acc_ID" runat="server"
                                        Value='<%# Eval("Payment_ticket") %>' />
                                </ItemTemplate>
                                <HeaderTemplate>
                                    <asp:CheckBox ID="Chk_Head" runat="server" AutoPostBack="True"
                                        OnCheckedChanged="Chk_Head_CheckedChanged" Text="Bank Voucher"
                                        TextAlign="Left" />
                                              <asp:Label runat="server" ID="lblJV" Text='<%# Bind("Entry_Voucher_Trans_ID") %>'></asp:Label>
     

                                </HeaderTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Update Date" HeaderStyle-Width="100px">
                                <ItemTemplate>
                                    <igsch:WebDateChooser ID="WebDateChooser_DischargeDate" runat="server" Width="98%"
                                        Value='<%# Eval("CC_Date") %>' Enabled="false">
                                        <CalendarLayout Culture="English (United Kingdom)">
                                        </CalendarLayout>
                                    </igsch:WebDateChooser>
                                    <br />
                                    <asp:HiddenField ID="HF_DischargeDate" runat="server"
                                        Value='<%# Eval("CC_Date") %>' />
                                </ItemTemplate>

                                <HeaderStyle Width="100px"></HeaderStyle>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkEdit" Text="Edit" runat="server" CommandArgument='<%# Eval("Receiving_Amount_ID") %>'
                                        OnClick="lnkEdit_Click"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Income " SortExpression="Entry_Voucher_Trans_ID">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblJV" Text='<%# Bind("Entry_Voucher_Trans_ID") %>'></asp:Label>
                                </ItemTemplate>
                              
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="Bank " SortExpression="Entry_Voucher_Trans_ID">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblJVBank" Text='<%# Bind("Voucher_Trans_ID") %>'></asp:Label>
                                </ItemTemplate>
                              
                            </asp:TemplateField>
                            
                        </Columns>
                    </asp:GridView>

                    <br />
                   
                    <asp:Button ID="Button4" runat="server" OnClick="Button4_Click" Text="Accumulated Report Group wise" Visible="false" />
                    <asp:Button ID="Button5" runat="server" OnClick="Button5_Click" Text="Accumulated Report" Visible="false" />
                    <asp:Button ID="btnReport" runat="server" OnClick="btnReport_Click" Text="Cash counter Receipt list Report" Visible="false" />

                    <asp:HyperLink ID="lnkCategoryWiseRevenue" Target="_blank" runat="server" Text="Services Category Wise Report" CssClass="btn_hacims" Visible="false"></asp:HyperLink>
                    <asp:HyperLink ID="lnkCategoryWiseDrCR" Target="_blank" runat="server" Text="Finace Report Head Wise" CssClass="btn_hacims" Visible="false"></asp:HyperLink>

                    <asp:Button ID="btnCategoryWise" runat="server" OnClick="btnCategoryWise_Click" Text="Category Wise Report" Visible="false" />


                    <asp:SqlDataSource ID="SDS_Report" runat="server"
                        ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                        SelectCommand="Cash_Submitted_Date_wise"
                        CancelSelectOnNullParameter="False" SelectCommandType="StoredProcedure"
                        UpdateCommand="Cash_Submitted_Bank_Update" UpdateCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:Parameter Name="Date" Type="DateTime" />

                            <asp:Parameter Name="Emp_id" Type="Int32" />

                            <asp:Parameter Name="Hos_ID" Type="Int32" />

                            <asp:Parameter Name="Edate" Type="DateTime" />
                            
                            <asp:Parameter Name="CounterType" Type="String" />


                            <asp:Parameter Name="Shift_id" Type="Int32" />
                           


                        </SelectParameters>
                        <UpdateParameters>
                            <%--<asp:Parameter Name="EntryVoucher_Trans_ID" Type="Int32" />--%>
                            <asp:Parameter Name="Deposit_By" Type="Int32" />
                            <asp:Parameter Name="Subdept_id" Type="Int32" />
                            <asp:Parameter Name="shift_id" Type="Int32" />
                            <asp:Parameter Name="Submitted_Date" Type="DateTime" />
                            <asp:Parameter Name="EntryVoucher_Trans_ID" Type="Int32" />
                            <asp:Parameter Direction="InputOutput" Name="Voucher_Trans_ID" Type="Decimal" />
                            <asp:Parameter Name="Emp_id" Type="Int32" />
                            <asp:Parameter Name="rec_amount_ID" Type="Int32" />
                            <asp:Parameter Name="Submitted_DateEnd" Type="DateTime" />
                        </UpdateParameters>
                    </asp:SqlDataSource>

                </td>

            </tr>
            <tr>
                <td colspan="2" align="center">
                   
                    <asp:Panel ID="Panel1" runat="server" Visible="false" CssClass="lightbox_bg1">
                         <div class="lightbox">
                        <table>
                            <tr>
                                <td colspan="2">
                                     <div class="inner_content"  >
                        <h2>
                            <span>Bank Voucher</span></h2>
                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Total Amount:
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_TotalAmount" runat="server" Enabled="False"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Bank:
                                </td>
                                <td>
                                    <asp:DropDownList ID="DropDownList1" runat="server"
                                        DataSourceID="SqlDataSource_expenditure" DataTextField="E_Name"
                                        DataValueField="E_Code">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>Date:</td>
                                <td>
                                    <asp:TextBox ID="txtDate" runat="server" TextMode="Date"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Ref. #</td>
                                <td>
                                    <asp:TextBox ID="txtRefNo" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td>Description:
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_Description" runat="server" Height="125px"
                                        TextMode="MultiLine" Width="250px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="1">
                                    <asp:Button ID="Button2" runat="server" OnClick="Button2_Click"
                                        Text="Deposit" />
                                    <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="Cancel" />

                                    <asp:Label ID="LBl_Msg" runat="server" ForeColor="#FF0066"></asp:Label>

                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    
                                     <div class="inner_content"  >
                        <h2>
                            <span></span></h2>
                    </div>
                                </td>
                            </tr>
                        </table>
                        <asp:SqlDataSource ID="SDS_Deposit" runat="server"
                            ConnectionString="<%$ ConnectionStrings:FinanceConnectionString1 %>"
                            InsertCommand="JV_Counter_Close_To_Bank" InsertCommandType="StoredProcedure"
                            ProviderName="<%$ ConnectionStrings:FinanceConnectionString1.ProviderName %>"
                            OnInserted="SDS_Deposit_Inserted"
                            UpdateCommand="Cash_Submitted_Bank_Update"
                            UpdateCommandType="StoredProcedure">
                            <InsertParameters>
                                <asp:SessionParameter Name="Emp_id" SessionField="Emp_id" Type="Int32" />
                                <asp:SessionParameter Name="Subdept_id" SessionField="SubDeptid" Type="Int32" />
                                <asp:ControlParameter ControlID="txt_TotalAmount" Name="Total_Amount"
                                    PropertyName="Text" Type="Decimal" />
                                <asp:SessionParameter Name="shift_id" SessionField="ShiftID" Type="Int32" />
                                <asp:ControlParameter ControlID="DropDownList1" Name="BankHead"
                                    PropertyName="SelectedValue" Type="String" />
                                <asp:ControlParameter ControlID="txtDate" Name="Date"
                                    PropertyName="Text" Type="DateTime" />
                                <asp:ControlParameter ControlID="txtRefNo" Name="RefNo"
                                    PropertyName="Text" Type="String" />
                                <asp:ControlParameter ControlID="txt_Description" Name="DepositDescription"
                                    PropertyName="Text" Type="String" />
                                <asp:Parameter Direction="InputOutput" Name="Voucher_Trans_ID" Type="Decimal" />
                                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                            </InsertParameters>
                        </asp:SqlDataSource>
                        <asp:HiddenField ID="HF_Voucher_Trans_ID" runat="server" />
                        <br />
                        <asp:SqlDataSource ID="SqlDataSource_expenditure" runat="server"
                            ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                            DeleteCommand="DELETE FROM [Expenditure] WHERE [E_Code] = @E_Code"
                            InsertCommand="INSERT INTO [Expenditure] ([E_Code], [E_Name], [ESH_Code]) VALUES (@E_Code, @E_Name, @ESH_Code)"
                            ProviderName="<%$ ConnectionStrings:Finance_ConnectionString.ProviderName %>"
                            SelectCommand="Select E_Code,E_Name from Expenditure  where ESH_Code ='3304'"
                            UpdateCommand="UPDATE [Expenditure] SET [E_Name] = @E_Name, [ESH_Code] = @ESH_Code WHERE [E_Code] = @E_Code">
                            <DeleteParameters>
                                <asp:Parameter Name="E_Code" Type="String" />
                            </DeleteParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="E_Name" Type="String" />
                                <asp:Parameter Name="ESH_Code" Type="String" />
                                <asp:Parameter Name="E_Code" Type="String" />
                            </UpdateParameters>
                            <InsertParameters>
                                <asp:ControlParameter ControlID="TextBox_E_Code" Name="E_Code"
                                    PropertyName="Text" Type="String" />
                                <asp:ControlParameter ControlID="TextBox_E_Name" Name="E_Name"
                                    PropertyName="Text" Type="String" />
                                <asp:ControlParameter ControlID="DropDownList_Sub_ESH_name" Name="ESH_Code"
                                    PropertyName="SelectedValue" Type="String" />
                            </InsertParameters>
                        </asp:SqlDataSource>
                    </div>
                             </asp:Panel>
                    


                    <asp:SqlDataSource ID="SDS_Voucher" runat="server"
                        ConnectionString="<%$ ConnectionStrings:FinanceConnectionString1 %>"
                        InsertCommand="JV_PostVoucherFromDrCr" InsertCommandType="StoredProcedure"
                        ProviderName="<%$ ConnectionStrings:FinanceConnectionString1.ProviderName %>"
                        CancelSelectOnNullParameter="False" OnSelecting="SDS_Voucher_Selecting">
                        <InsertParameters>
                            <asp:Parameter Name="Receiving_Amount_ID" Type="Int32" />
                            <asp:SessionParameter Name="SubDept_Id" SessionField="SubDeptid" Type="Int32" />
                            <asp:SessionParameter Name="Dept_Id" SessionField="dept_id" Type="Int32" />
                            <asp:SessionParameter Name="By_Emp_Id" SessionField="emp_id" Type="Int32" />
                            <asp:SessionParameter Name="hospital_id" SessionField="hospitalid" Type="Int32" />
                            <asp:Parameter Name="EmpId" Type="Int32" />
                        </InsertParameters>
                    </asp:SqlDataSource>

                </td>

            </tr>
        </table>

</div>
      <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
           
             <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="500px">
             </rsweb:ReportViewer>
</asp:Content>

