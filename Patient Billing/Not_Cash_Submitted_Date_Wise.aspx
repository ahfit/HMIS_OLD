<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Patient_Billing_Not_Cash_Submitted_Date_Wise, App_Web_okqm0ubs" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div width = "100%">
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
            
            <asp:Button ID="Button1" runat="server" Text="Search Un Poted Voucher" onclick="Button1_Click" />
            
        </td>
        
    </tr>
            <tr>
        <td colspan = "2" align = "center">
            
        </td>
        
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
                        HeaderText="Services Wise" Visible="False" />
                    <asp:HyperLinkField Target="_blank" Text="print" 
                        DataNavigateUrlFields="Dept_ID,SubDept_ID,Shift_ID,CC_Date,VStatus,emp_id,Entry_Voucher_Trans_ID,Payment_ticket,Hospital_id" 
                        DataNavigateUrlFormatString="~/Patient Billing/Cash_Book_Submitted_Report.aspx?Hid={8}&amp;SDID={1}&amp;ShID={2}&amp;Dt={3}&amp;VS={4}&amp;EID={5}&amp;VID={6}&amp;EDate={3}&amp;PID={7}&amp;DID={7}" 
                        HeaderText="Report" />
                    
                  
                </Columns>
            </asp:GridView>
              <asp:SqlDataSource ID = "SDS_Report" runat = "server" 
                ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>" 
                SelectCommand="NotCashSubmittedDatewise" 
                CancelSelectOnNullParameter="False" SelectCommandType="StoredProcedure" UpdateCommandType="StoredProcedure" 
                >
                  <SelectParameters>
                      <asp:Parameter Name="Date" Type="String" />
                      
                      <asp:Parameter Name="Emp_id" Type="Int32" />
                      
                                <asp:Parameter Name="Hos_ID" Type="Int32" />
                      
                      <asp:Parameter Name="Edate" Type="DateTime" />
                      <asp:Parameter Name="shift_id" Type="Int32" />
                      
                  </SelectParameters>
            </asp:SqlDataSource>
        
        </td>
        
    </tr>
          <tr>
        <td colspan = "2" align = "center">
            
            
        


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

