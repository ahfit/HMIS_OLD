<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_billing.master" AutoEventWireup="false" CodeFile="ApprovedRefundPayment.aspx.vb" Inherits="Patient_Billing_Refund_Approval" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server" >
    <table class="diagnosis_list">
        <tr>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td colspan="2">
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:GridView ID="GridView_Record" runat="server" DataSourceID="SDS_Record" 
                    Width="100%" EmptyDataText="No record Found.." AutoGenerateColumns="False">
                    <Columns>
                        <asp:HyperLinkField DataNavigateUrlFields="RegNo,YearlyNo" DataNavigateUrlFormatString= "~/Patient Billing/Approved_refund.aspx?RegNo={0}&PayID={1}"
               Text="Refund" HeaderText="Refund"  HeaderStyle-Width="50px" />
                        <asp:TemplateField HeaderText="Registration #" HeaderStyle-Width="110px">
                            <ItemTemplate>
                                <asp:HiddenField ID="hf_reg" runat="server"  Value='<%# Eval("RegNo") %>'/>
                                <asp:HiddenField ID="hf_yearlyNo" runat="server"  Value='<%# Eval("YearlyNo") %>'/>
                                <asp:Label ID="lbl_reg" runat="server" ></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Patient Name">
                          <ItemTemplate>
                                <asp:HiddenField ID="hf_prefix" runat="server" Value='<%# Eval("Prefix") %>' />
                                 <asp:HiddenField ID="hf_EFName" runat="server" Value='<%# Eval("PFName") %>' />
                                  <asp:HiddenField ID="hf_EMName" runat="server" 
                                    Value='<%# Eval("PMName") %>' />
                                   <asp:HiddenField ID="HF_ELName" runat="server" 
                                    Value='<%# Eval("PLName") %>' />
                                <asp:Label ID="lbl_Name" runat="server" ></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                       
                        <asp:TemplateField HeaderText="Receipt #" SortExpression="SPM_ID">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click" 
                                    Text='<%# Eval("SPM_ID") %>'></asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("SPM_ID") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                       
                        <asp:BoundField DataField="Patient_type" HeaderText="Patient Type" 
                            SortExpression="Patient_type" />
                            <asp:BoundField DataField="Request_by" HeaderText="Request by" 
                            SortExpression="Request_by" />
                       
                        <asp:BoundField DataField="Requested_Date" HeaderText="Request Date" 
                            SortExpression="Requested_Date" HeaderStyle-Width="100px"/>
                        <asp:BoundField DataField="Amount" HeaderText="Service Amount" 
                            SortExpression="Amount" />
                        <asp:BoundField DataField="Discount" HeaderText="Discount Given on Service" 
                            SortExpression="Discount" HeaderStyle-Width="100px" />
                        <asp:TemplateField HeaderText="Total Refund Amount" 
                            SortExpression="Total_Refund" HeaderStyle-Width="100px">
                            <ItemTemplate>
                                <asp:Label ID="lbl_Total" runat="server" Text='<%# Bind("Total_Refund") %>'></asp:Label>
                            </ItemTemplate>
                           
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status" 
                            SortExpression="Requested_status" HeaderStyle-Width="100px">
                            <ItemTemplate>
                                <asp:Label ID="lbl_Requested_status" runat="server" Text='<%# Bind("Requested_status")%>'></asp:Label>
                            </ItemTemplate>
                           
                        </asp:TemplateField>
                       
                         
                    </Columns>
                    <EmptyDataRowStyle BackColor="#666699" ForeColor="#33CCCC" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="SDS_Record" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" 
                    SelectCommand="Get_AfterApproved_Refund" SelectCommandType="StoredProcedure" 
                    InsertCommand="Refund_Approval_RejectionOLD" InsertCommandType="StoredProcedure">
                    
                    <InsertParameters>
                        <asp:ControlParameter Name="request_ID" Type="Int32" ControlID="hf_refund_id" 
                            PropertyName="Value" />
                        <asp:ControlParameter ControlID="hf_status" Name="New_Status" 
                            PropertyName="Value" Type="String" />
                        <asp:ControlParameter ControlID="txt_Remarks" Name="Remarks" 
                            PropertyName="Text" Type="String" />
                        <asp:SessionParameter Name="emp_id" SessionField="emp_id" Type="Int32" />
                        <asp:ControlParameter ControlID="hfok" Name="statusRe" 
                            PropertyName="Value" Type="String" />
                            <asp:SessionParameter Name="Dept_Id" SessionField="Dept_id" Type="Int32" />
                            <asp:SessionParameter Name="SubDept_Id" SessionField="SubDeptID" Type="Int32" />
                            <asp:SessionParameter Name="Shift" SessionField="ShiftId" Type="Int32" />
                       
                       <asp:ControlParameter ControlID="hf_receveableamount" Name="recamount" 
                            PropertyName="Value" Type="String" />  
                            <asp:ControlParameter ControlID="HiddenFieldrno" Name="rno"  PropertyName="Value" Type="String" />   
                            <asp:ControlParameter ControlID="HiddenFieldsmpid" Name="SMPid"  PropertyName="Value" Type="String" />  
                    </InsertParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td colspan="2">
            <asp:Panel ID ="pnl_input" runat = "server" Visible = "false" CssClass = "lightbox_bg">
                <table class="ui-accordion">
                     <tr>
                        <td  colspan="2"   align = "center">
                        <h1><asp:Label ID = "txt_heading" ForeColor="Blue" Font-Bold="true"  runat = "server"></asp:Label> </h1>
                        </td>
                       </tr>
                     <tr>
                        <td  colspan="2" align = "center">
                            </td>
                       </tr>
                    <tr>
                        <td  colspan="2" align = "center">
                        <asp:TextBox TextMode ="MultiLine" runat = "server" ID = "txt_Remarks" 
                                Height="163px" style="margin-top:15px" Width="70%"></asp:TextBox>
                            <br />
                            <asp:HiddenField ID="hf_status" runat="server" />
                             <asp:HiddenField ID="hf_refund_id" runat="server" />
                              <asp:HiddenField ID="hf_receveableamount" runat="server" />
                              <asp:HiddenField ID="hfok" runat="server" />
                               <asp:HiddenField ID="HiddenFieldrno" runat="server" />
                              <asp:HiddenField ID="HiddenFieldsmpid" runat="server" />
                               
                          </td>
                           
                    </tr>
                    <tr>
                    <td align="right" Width ="70%">
                       
                        <asp:Label ID= "lblnotice" runat="server" style="width:100%;font-style:inherit;" ></asp:Label>
                        <asp:Label ID= "Labb" runat="server" Font-Bold="true" ForeColor="Green"  style="width:100%;font-style:inherit;" ></asp:Label>
                        <asp:CheckBox ID="cbok" Visible="false"  runat="server" />
                        </td>
              <%--      <td>
                        <asp:Button ID="Button2" runat="server" Text="Cancel" />
                        </td>--%>
                    
                    </tr>
                    <tr>
                    <td align="right" Width ="50%">
                        <asp:Button ID="Btn_Approve" runat="server" Text="OK" />
                  
                        </td>
                    <td>
                        <asp:Button ID="Btn_Cancel" runat="server" Text="Cancel" />
                              <asp:Label ID= "lbl_MSG" runat="server"  ></asp:Label>
                        </td>
                    
                    </tr>
                </table>
            </asp:Panel>
            
            </td>
        </tr>
    </table>
&nbsp;&nbsp;&nbsp; 
</asp:Content>

