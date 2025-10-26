<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="MyPendingQuotationReqApprovalRequests.aspx.cs" Inherits="Store_MyPendingQuotationReqApprovalRequests" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="bxmain inner_content" style="width:100%;">
    <h2><span>My Pending Approval Requests</span></h2>
</div>
<br />
<asp:GridView ID="GridView1" Width="100%" runat="server" 
        AutoGenerateColumns="False" EmptyDataText="No Record Found" DataKeyNames="Demand_RQ_ID" DataSourceID="SqlDataSource1">
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="Demand_RQ_ID,Approval_Request_Id" 
                DataNavigateUrlFormatString="~/Store/Demad/Qutation_Report.aspx?RQ_ID={0}" 
                Text="Approve & Forward" />
            <asp:BoundField DataField="Demand_RQ_ID" HeaderText="Demand #" ReadOnly="True" 
                SortExpression="Demand_RQ_ID" />
            <asp:BoundField DataField="Date_Time" HeaderText="Date Time" 
                SortExpression="Date_Time" />            
            <asp:BoundField DataField="From_Sub_Dept" HeaderText="From Department" 
                SortExpression="From_Sub_Dept" />
           <asp:BoundField DataField="Qty" HeaderText="Demand Qty" SortExpression="Qty" />
            <asp:BoundField DataField="TotalAmount" HeaderText="Estimated Amount" SortExpression="TotalAmount" DataFormatString="{0:N2}" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" SelectCommand="uspGetMyPendingQuotations" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="" Name="SubDeptId" 
                SessionField="SubDeptID" />
            <asp:SessionParameter DefaultValue="" Name="EmpId" SessionField="Emp_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

