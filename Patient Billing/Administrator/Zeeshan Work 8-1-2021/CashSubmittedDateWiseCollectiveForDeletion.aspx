<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="CashSubmittedDateWiseCollectiveForDeletion.aspx.cs" Inherits="Patient_Billing_CashSubmittedDateWiseCollectiveForDeletion" %>
<%--<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>--%>
<%--<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>--%>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type ="text/css">

       .lightbox_bg1{
           opacity: 0.9;
       }

   </style>
    <script type="text/javascript">
        function confirmationDelete() {
            if (confirm('Are you sure you want to delete Closed Counter ?')) {
                return true;
            } else {
                return false;
            }
        }
   </script>
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


                            <asp:BoundField  DataField="Closed_By"  HeaderText="Closed By"
                                SortExpression="Closed_By" />
                            <asp:TemplateField HeaderText="Delete Counter Close">
                                <ItemTemplate>
                                    <asp:HiddenField runat="server" ID="hfd_empid" Value='<%# Eval("Closeby_Empid") %>'/>
                                    <asp:Button ID="btnDelete" runat="server" ToolTip='<%# Eval("Closeby_Empid") %>' Text="Delete" OnClientClick="return confirmationDelete()" CommandName="Delete" CommandArgument='<%# Eval("Payment_ticket") %>' OnClick="btnDeleteCounterClose_Click"/>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                    </asp:GridView>

                    <br />
                   
                    
                    


                    <asp:SqlDataSource ID="SDS_Report" runat="server"
                        ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                        SelectCommand="Cash_Submitted_Date_wise"
                       SelectCommandType="StoredProcedure"
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
            </table>

</div>
      
</asp:Content>

