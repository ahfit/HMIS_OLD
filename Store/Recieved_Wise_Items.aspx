<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Recieved_Wise_Items" 
     CodeFile="Recieved_Wise_Items.aspx.cs" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                                   
                                     <div align="center">       <asp:Button ID="ButtonApprove" runat="server" Text="Receive Item(s)" 
                                                onclick="ButtonApprove_Click" /> </div>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
          
        </rsweb:ReportViewer>
<br />
<asp:HiddenField ID="HiddenFieldStore__issue_id" runat="server" />
    <asp:HiddenField ID="HiddenFieldStore__issue_Main_id" runat="server" />
   
        <asp:SqlDataSource ID="SDS_Approved" runat="server" 
            ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" 
            InsertCommand="Insert_Store_Item_Receive_ByRequisition" 
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
</asp:Content>

