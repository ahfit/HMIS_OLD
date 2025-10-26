<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="Cash_Submitted_Date_Wise.aspx.cs" Inherits="Patient_Billing_Cash_Submitted_Date_Wise" %>
<%--<rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="500px" Visible="false" />
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>--%>
<%@ Register assembly="Microsoft.ReportViewer.WebForms" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="bxmain inner_content " style="width: 100%;">
        <h2>
            <span>Cash Submitted Detail</span></h2>
<table width = "100%">
    <tr>
        <td width = "50%" align = "right">
        Select Hospital :
        </td>
        <td width = "50%" >
            <asp:DropDownList ID="DDL_Hospital" runat="server" DataSourceID="SDS_Hospital" 
                DataTextField="Hospital_Name" DataValueField="Hospital_ID">
            </asp:DropDownList>
            <asp:SqlDataSource ID = "SDS_Hospital" runat = "server" 
                ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>" 
                SelectCommand="SELECT  0 [Hospital_ID], ' All' as [Hospital_Name] Union SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"></asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td width = "50%" align = "right">
            Select Shift :</td>
        <td width = "50%" >
            <asp:DropDownList ID="DDL_Shift" runat="server" >
                <asp:ListItem Value="0">All</asp:ListItem>
                <asp:ListItem Value="1">Morning</asp:ListItem>
                <asp:ListItem Value="2">Evening</asp:ListItem>
                <asp:ListItem Value="3">Night</asp:ListItem>
            </asp:DropDownList>
            
        </td>
    </tr>
    <tr>
        <td width = "50%" align = "right">
            Counter Type :</td>
        <td width = "50%" >
            <asp:DropDownList ID="DDL_CounterType" runat="server">
            </asp:DropDownList>
            
        </td>
    </tr>
    <tr>
        <td width = "50%" align = "right">
            Select Start Date :
        </td>
        <td width = "50%" >
            <igsch:WebDateChooser ID="WebDateChooser_SDate" runat="server" 
                    Width="202px">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:WebDateChooser>

        </td>
    </tr>
    <tr>
        <td width = "50%" align = "right">
            Select End Date : </td>
        <td width = "50%" >
            <igsch:WebDateChooser ID="WebDateChooser_EDate" runat="server" 
                    Width="202px">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:WebDateChooser>

        </td>
    </tr>
    <tr>
        <td colspan = "2" align = "center">
        
            &nbsp;</td>
        
    </tr>
        <tr>
        <td colspan = "2" align = "center">
            
            <asp:Button ID="Button1" runat="server" Text="Search" onclick="Button1_Click" />
            
             <asp:Button ID="BTn_Deposit" runat="server" Text="Deposit" Width="100px" 
                onclick="BTn_Deposit_Click"  Visible="false"/>
            <asp:Button ID="Btn_Approve" runat="server" Text="Post" Width="100px" onclick="Btn_Approve_Click" 
                Visible="false"/>
        </td>
        
    </tr>
            <tr>
        <td colspan = "2" align = "center">
            
        </td>
        
    </tr>
            <tr>
        <td colspan = "2" align = "center">
            
            &nbsp;</td>
        
    </tr>
          <tr>
        <td colspan = "2" align = "center">
            
            <asp:GridView ID="Gv_Report" runat="server" AutoGenerateColumns="False" Width="100%" 
                DataSourceID="SDS_Report" onprerender="Gv_Report_PreRender" 
                ShowFooter="True">
                <Columns>
                <asp:TemplateField HeaderText="SrNo."> 
<ItemTemplate> <%#Container.DataItemIndex+1%> 
</ItemTemplate>
<ItemStyle Width="8%" /> 
</asp:TemplateField>
                    <asp:BoundField DataField="Payment_ticket" HeaderText="Payment Ticket" 
                        SortExpression="Payment_ticket" />
                    <asp:BoundField DataField="Receipt" HeaderText="Receipt(From - To)" ReadOnly="True" 
                        SortExpression="Receipt" Visible="False" />
                        <asp:BoundField DataField="Hospital_Name" HeaderText="Hospital Name" 
                        SortExpression="Hospital_Name" />
                    <asp:BoundField DataField="Department" HeaderText="Department" ReadOnly="True" 
                        SortExpression="Department" />
                    <asp:BoundField DataField="Shift" HeaderText="Shift" SortExpression="Shift" />
                    <asp:TemplateField HeaderText="Total Amount" SortExpression="TotalAmount">
                        <ItemTemplate>
                            <asp:Label ID="lbl_Amount" runat="server" Text='<%# Bind("TotalAmount") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("TotalAmount") %>'></asp:Label>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:Label ID="lbl_total" runat="server" Text="0"></asp:Label>
                        </FooterTemplate>
                    </asp:TemplateField>
                    
                    <asp:BoundField DataField="CC_Date" HeaderText="Date" ReadOnly="True" 
                        SortExpression="CC_Date" Visible="True" />

                    
                    <asp:BoundField DataField="Closed_By" HeaderText="Closed By" 
                        SortExpression="Closed_By" />

                    
                    <asp:BoundField DataField="Shift_ID" HeaderText="Shift_ID" 
                        InsertVisible="False" ReadOnly="True" SortExpression="Shift_ID" Visible="false"/>
                    <asp:BoundField DataField="SubDept_Id" HeaderText="SubDept_Id" 
                        SortExpression="SubDept_Id" Visible="false" />
                    <asp:HyperLinkField Target="_blank" Text="Detail" 
                        DataNavigateUrlFields="Hospital_ID,SubDept_ID,Shift_ID,CC_Date,VStatus,emp_id,Entry_Voucher_Trans_ID,Payment_ticket" 
                        
                        
                        DataNavigateUrlFormatString="Cash_Deposit_To_Bank.aspx?Hid={0}&amp;SDID={1}&amp;ShID={2}&amp;Dt={3}&amp;VS={4}&amp;EID={5}&amp;VID={6}&amp;PID={7}" 
                        HeaderText="Receipt Wise" />
                    <asp:HyperLinkField Target="_blank" Text="Detail" 
                        DataNavigateUrlFields="Dept_ID,SubDept_ID,Shift_ID,CC_Date,VStatus,emp_id,Entry_Voucher_Trans_ID,Payment_ticket" 
                        
                        
                        DataNavigateUrlFormatString="CC_Deposited_Detail.aspx?Hid={0}&amp;SDID={1}&amp;ShID={2}&amp;Dt={3}&amp;VS={4}&amp;EID={5}&amp;VID={6}&amp;PID={7}" 
                        HeaderText="Services Wise" />
                    <asp:HyperLinkField Target="_blank" Text="Receipt Wise" 
                        DataNavigateUrlFields="CC_Date,CC_Date,Hospital_ID,Shift_ID,Payment_ticket" 
                        
                        DataNavigateUrlFormatString="NewCashReport.aspx?Sdate={0}&Edate={1}&Hid={2}&SID={3}&PID={4}" 
                        HeaderText="Receipt Wise" />

                      <asp:HyperLinkField Target="_blank" Text="print" 
                        DataNavigateUrlFields="Dept_ID,SubDept_ID,Shift_ID,CC_Date,VStatus,emp_id,Entry_Voucher_Trans_ID,Payment_ticket,Hospital_id" 
                        DataNavigateUrlFormatString="~/Patient Billing/Cash_Book_report.aspx?Hid={8}&amp;SDID={1}&amp;ShID={2}&amp;Dt={3}&amp;VS={4}&amp;EID={5}&amp;VID={6}&amp;EDate={3}&amp;PID={7}&amp;DID={7}" 
                        HeaderText="Report" />
                </Columns>
            </asp:GridView>
            <asp:Button ID="btnExport" runat="server" Text="Export to Excel" OnClick="btnExport_Click" />

            
              <asp:Button ID="Button4" runat="server" onclick="Button4_Click" 
                Text="Accumulated Report Group wise" Visible="false" />
              <asp:Button ID="Button5" runat="server" onclick="Button5_Click" 
                Text="Accumulated Report" Visible="false"  />
 <asp:Button ID="btnReport" runat="server" onclick="btnReport_Click" 
                Text="Cash counter Receipt list Report" Visible="false"  />
            <asp:Button ID="btnCategoryWise" runat="server" onclick="btnCategoryWise_Click" 
                Text="Cash Counter Category Wise" Visible="false"  />

              <asp:SqlDataSource ID = "SDS_Report" runat = "server" 
                ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>" 
                SelectCommand="Cash_Submitted_Date_wise" 
                CancelSelectOnNullParameter="False" SelectCommandType="StoredProcedure" 
                UpdateCommand="Cash_Submitted_Bank_Update" UpdateCommandType="StoredProcedure" 
                >
                  <SelectParameters>
                      <asp:Parameter Name="Date" Type="String" />
                      
                      <asp:Parameter Name="Emp_id" Type="Int32" />
                      
                                <asp:Parameter Name="Hos_ID" Type="Int32" />
                      
                      <asp:Parameter Name="Edate" Type="DateTime" />
                      <asp:Parameter Name="shift_id" Type="Int32" />
                       <asp:Parameter Name="CounterType" Type="String" />
                      
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
                  </UpdateParameters>
            </asp:SqlDataSource>
        
        </td>
        
    </tr>
          <tr>
        <td colspan = "2" align = "center">
            
            <asp:Panel ID="Panel1" runat="server" Visible="false" CssClass="lightbox"  >
                 <%----%>
                <table>
                    <tr>
                        <td>
                            Total Amount:
                        </td>
                        <td>
                            <asp:TextBox ID="txt_TotalAmount" runat="server" Enabled="False"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Bank:
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownList1" runat="server" 
                                DataSourceID="SqlDataSource_expenditure" DataTextField="E_Name" 
                                DataValueField="E_Code">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Description:
                        </td>
                        <td>
                            <asp:TextBox ID="txt_Description" runat="server" Height="125px" 
                                TextMode="MultiLine" Width="250px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2">
                            <asp:Button ID="Button2" runat="server" onclick="Button2_Click" 
                                Text="Deposit" />
                            <asp:Button ID="Button3" runat="server" onclick="Button3_Click" Text="Cancel" />

                            <asp:Label ID="LBl_Msg" runat="server" ForeColor="#FF0066"></asp:Label>

                        </td>
                    </tr>
                </table>
                <asp:SqlDataSource ID="SDS_Deposit" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:FinanceConnectionString1 %>" 
                    InsertCommand="JV_Counter_Close_To_Bank" InsertCommandType="StoredProcedure" 
                    
                     ProviderName="<%$ ConnectionStrings:FinanceConnectionString1.ProviderName %>" 
                     oninserted="SDS_Deposit_Inserted" 
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
                    SelectCommand="SELECT     Expenditure.E_Code, Expenditure.E_Name, SUM(CASE WHEN Reciept_Disbursement_Detail.Cr_Dr_Action_Id = 1 THEN Amount ELSE 0 END) 
                      - SUM(CASE WHEN Reciept_Disbursement_Detail.Cr_Dr_Action_Id = 2 THEN Amount ELSE 0 END) AS Balance
FROM         Bank_Account_BranchWise INNER JOIN
                      Bank_Account ON Bank_Account_BranchWise.Account_ID = Bank_Account.Account_ID RIGHT OUTER JOIN
                      Expenditure ON Bank_Account.E_Code = Expenditure.E_Code LEFT OUTER JOIN
                      Reciept_Disbursement_Detail ON Expenditure.E_Code = Reciept_Disbursement_Detail.Account_Head_id
WHERE     (Expenditure.ESH_Code = '3204')
GROUP BY Expenditure.E_Code, Expenditure.E_Name" 
                    
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
            </asp:Panel>
        


    <asp:SqlDataSource ID="SDS_Voucher" runat="server" 
        ConnectionString="<%$ ConnectionStrings:FinanceConnectionString1 %>" 
        InsertCommand="JV_Counter_Close_Advance" InsertCommandType="StoredProcedure" 
        
        ProviderName="<%$ ConnectionStrings:FinanceConnectionString1.ProviderName %>" 
        CancelSelectOnNullParameter="False">
        <InsertParameters>
            <asp:SessionParameter Name="By_Emp_Id" SessionField="emp_id" Type="Int32" />
            <asp:Parameter Name="Dept_Id" Type="Int32" />
            <asp:Parameter Name="SubDept_Id" Type="Int32" />
            <asp:Parameter Name="shift_id" Type="Int32" />
            <asp:Parameter  Name="CCdate" Type="String" />
            <asp:Parameter DefaultValue="0" Name="Receiving_Amount_ID" Type="Int32" />
            <asp:Parameter DefaultValue="" Name="CC_Emp_Id" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
        
        </td>
        
    </tr>
</table>


</div>

</asp:Content>

