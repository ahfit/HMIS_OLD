<%@ page title="" language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="Store_IPO_Report"
     CodeFile="IPOrderReport.aspx.vb" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <div  class="rpt_pos" align="center">
        <asp:Panel ID="Pnl_Ath" runat="server" Visible = "false">
            <asp:Button ID="btn_approve" runat="server" Text="Approve" 
                onclientclick='return confirm(Do you want to approve this IPO?);' />
            <asp:Button ID="Btn_Reject" runat="server" Text="Reject"
            onclientclick='return confirm(Do you want to reject this IPO?);' />
        </asp:Panel>
        <br />
        <br />
       
       </div>
        
        <asp:HiddenField ID="HiddenFieldSO_ID" runat="server" />
        <asp:HiddenField ID="HiddenField_Discount" runat="server" />
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" 
    Height="600px">
</rsweb:ReportViewer>
        <asp:HiddenField ID="HiddenField_Tax" runat="server" />
    
        <asp:SqlDataSource ID="SQL_Finalize_IPO" runat="server" 
            ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" 
    UpdateCommand="Approve_Requisition" UpdateCommandType="StoredProcedure">
            <UpdateParameters>
                <asp:SessionParameter Name="Approved_by" SessionField="Emp_id" Type="Int32" />
                <asp:ControlParameter ControlID="HiddenFieldSO_ID" Name="IB_ID" 
                    PropertyName="Value" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    
    <asp:Panel ID="Panel_Remarks" runat="server" CssClass="lightbox" 
                    Visible="False">
                <br />
&nbsp;<strong Style=" font-weight:bold; font-size:13px;">Requisition No. : </strong><asp:Label ID="Lbl_Requisition_No" runat="server" Style="color:#900; font-weight:bold; font-size:13px; padding-bottom:5px;"></asp:Label>
                    <asp:TextBox ID="TextBox_Remarks" runat="server" Width="100%"  Height="250px"
    TextMode="MultiLine"></asp:TextBox>
                    <asp:SqlDataSource ID="Sql_Remarks" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" 
                        SelectCommand="SELECT [Remarks] FROM [Store_Indent_Book_Main]" 
                        
                        
                        UpdateCommand="reject_requisition" UpdateCommandType="StoredProcedure">
                        <UpdateParameters>
                            <asp:ControlParameter ControlID="TextBox_Remarks" Name="Remarks" 
                                PropertyName="Text" />
                            <asp:ControlParameter ControlID="HiddenFieldSO_ID" Name="IB_ID" 
                                PropertyName="Value" />
                            <asp:SessionParameter Name="Approved_by" SessionField="emp_id" Type="Int32" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                  <div align="center" style="margin-top:10px; width:100%;">  
                      <asp:Button ID="btn_Save" runat="server" 
                          Text="Save And Reject" />
                    
                   
                    <asp:Button ID="btn_Cancel" runat="server" 
                        Text="Close" />  </div>
                        <br />
<div align="center"><strong><asp:Label ID="Label" runat="server" Style="color:#CC0000;"></asp:Label></strong></div><br />
                    <asp:HiddenField ID="HF_Re_ID" runat="server" />
                </asp:Panel>

</asp:Content>
