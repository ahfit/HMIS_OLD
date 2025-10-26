<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="RejectedItemsRecieved" 
     CodeFile="RejectedItemsRecieved.aspx.cs" enableEventValidation="false"  viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                                   
                                     <div style="margin-bottom:15px" align="center">       <asp:Button ID="ButtonApprove" runat="server" Text="Receive Item(s)" 
                                                onclick="ButtonApprove_Click" />
                                         
                                     </div> 
     
     



        <asp:Panel ID="Panel_Remarks" runat="server" Visible="False" CssClass="lightbox" Wrap="False">
        <br /> 
          <div class="bxmain">
               &nbsp;<strong style="font-weight: bold; font-size: 13px;">Requisition No. : </strong>
               
            <asp:Label ID="Lbl_Requisition_No" runat="server" Style="color: #900; font-weight: bold;
            font-size: 13px; padding-bottom: 5px;"></asp:Label>
      <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%"> 
        <tr>
            <td>
                 <asp:TextBox ID="TextBox_Remarks"  runat="server" Width="100%" Height="250px" TextMode="MultiLine"></asp:TextBox>
            </td>
            </tr> 
        <tr>
            
            <td colspan="2" align="center">
               
                 <asp:Button ID="btn_PanelReject" runat="server"  OnClick="btn_PanelReject_Click"    Text="Save And Reject" />
            <asp:Button ID="btn_Cancel" runat="server" OnClick="btn_Cancel_Click" Text="Cancel" />
            </td>
           
        </tr>
          </table>
              </div> 
      
        <br />
        <div align="center">
           
            <strong> <asp:Label ID="Label" runat="server" Style="color: #CC0000;"></asp:Label></strong></div>
        <br />
        <asp:HiddenField ID="HiddenField1" runat="server" />
    </asp:Panel> 




    
<asp:GridView ID="GridView2" runat="server" OnPreRender="GridView2_PreRender" AutoGenerateColumns="False" 
    Width="100%"  DataKeyNames="IB_ID">
                <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />              
                <RowStyle CssClass="GridItem" />
                <HeaderStyle CssClass="GridHeader" />              
                <AlternatingRowStyle CssClass="GridAltItem" />
                <Columns> 
                    <asp:TemplateField HeaderText="Requisition #" SortExpression="IB_ID"> 
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("IB_ID") %>'></asp:Label> 
                            <asp:HiddenField runat="server" ID="hf_itemcode" Value='<%# Bind("Item_Code") %>'  />
                              <asp:HiddenField ID="hf_Consumption" runat="server" Value='<%# Eval("IB_ID") %>'/> 
                              <asp:HiddenField ID="HiddenField2" runat="server" Value='<%# Eval("RejectStatus") %>'/> 
                        </ItemTemplate>
                    </asp:TemplateField> 
                      <asp:BoundField DataField="Item_Name" HeaderText="Item Name" SortExpression="Item_Name"/>
                         <asp:TemplateField HeaderText="Item Qty" SortExpression="IB_ID"> 
                        <ItemTemplate>
                            <asp:Label ID="lbl_ItemQty" runat="server" Text='<%# Bind("Item_Qty") %>'></asp:Label>                           
                        </ItemTemplate>
                    </asp:TemplateField>
             
                       <asp:BoundField DataField="Issued_By" HeaderText="Issued By Employee" 
                        SortExpression="Issued_By" />
                       <asp:BoundField DataField="Issue_Date" HeaderText="Issue Date" ReadOnly="True" SortExpression="Issue_Date" />
                        <asp:BoundField DataField="Issue_To_SubDept_Name" HeaderText="Requested Department " ReadOnly="True" SortExpression="Issue_To_SubDept_Name" />
                         <asp:TemplateField>
                            <ItemTemplate>
                                
                                <asp:CheckBox ID="CheckBox1" runat="server" />
                            </ItemTemplate>
                            <HeaderTemplate>
                                <asp:CheckBox ID="CheckBox3" runat="server"    AutoPostBack="True" OnCheckedChanged="CheckBox3_CheckedChanged" />
                            </HeaderTemplate>
                        </asp:TemplateField> 
                </Columns>
              </asp:GridView> 
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
          
        </rsweb:ReportViewer>
<br />
<asp:HiddenField ID="HiddenFieldStore__issue_id" runat="server" />
    <asp:HiddenField ID="HiddenFieldStore__issue_Main_id" runat="server" />
   
        <asp:SqlDataSource ID="SDS_Approved" runat="server" 
            ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" 
            InsertCommand="Reject_Item_ByRequisition" 
            InsertCommandType="StoredProcedure" 
            ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>">
            <InsertParameters>
                <asp:SessionParameter Name="Receive_Dept_Id" SessionField="dept_id" 
                    Type="Int32" />
                <asp:SessionParameter Name="Receive_Emp_Id" SessionField="emp_id" 
                    Type="Int32" />
                <asp:QueryStringParameter Name="Receive_Sub_dept_Id" QueryStringField="subdeptid" 
                    Type="Int32" />
                <asp:QueryStringParameter Name="Consumption_Id" QueryStringField="C_ID" 
                    Type="Decimal" />
                <asp:QueryStringParameter Name="IB_ID" QueryStringField="IB_ID" Type="String" />
                <asp:SessionParameter Name="Designation_Id" SessionField="designationid" 
                    Type="Int32" />
              
                <asp:Parameter Name="XML_Sub" Type="String" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SDS_Recieve_voucher" runat="server" 
            ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" 
            InsertCommand="JV_InterBranch_Stock_Received" 
            InsertCommandType="StoredProcedure" SelectCommandType="StoredProcedure">
            <InsertParameters>
                <asp:SessionParameter Name="By_Emp_Id" SessionField="emp_id" Type="Int32" />
                <asp:SessionParameter Name="Designation_Id" SessionField="Designation_Id" 
                    Type="Int32" />
                <asp:SessionParameter Name="By_Dept_Id" SessionField="Dept_Id" Type="Int32" />
                <asp:SessionParameter Name="By_SubDept_Id" SessionField="SubDeptId" 
                    Type="Int32" />
                <asp:QueryStringParameter Name="Issue_Main_Id" QueryStringField="Issue_id" 
                    Type="Decimal" />
                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            </InsertParameters>
        </asp:SqlDataSource>
      <asp:SqlDataSource ID="Sql_Remarks" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
            UpdateCommand="ItemRejected_Requisition"
            UpdateCommandType="StoredProcedure">
            <UpdateParameters>
                <asp:ControlParameter ControlID="TextBox_Remarks" Name="Reject_Remarks" PropertyName="Text" />
              <asp:QueryStringParameter Name="Consumption_Id" QueryStringField="C_ID" 
                    Type="Decimal" />
                <asp:SessionParameter Name="Approved_by" SessionField="emp_id" Type="Int32" />
               
             
                <asp:Parameter Name="XML_Sub" Type="String" />
               
            </UpdateParameters>
        </asp:SqlDataSource>
</asp:Content>

