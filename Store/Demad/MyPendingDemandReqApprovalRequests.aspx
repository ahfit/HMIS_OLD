<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="MyPendingDemandReqApprovalRequests.aspx.cs" Inherits="Store_MyPendingDemandReqApprovalRequests" %>

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
                DataNavigateUrlFormatString="~/Store/Demad/Approve_Demand_Requisition_Request.aspx?RQ_ID={0}&PID={1}" 
                Text="Approve & Forward" />
            <asp:BoundField DataField="Demand_RQ_ID" HeaderText="Demand_RQ_ID" ReadOnly="True" 
                SortExpression="Demand_RQ_ID" />
            <asp:BoundField DataField="Date_Time" HeaderText="Date_Time" 
                SortExpression="Date_Time" />            
            <asp:BoundField DataField="From_Sub_Dept" HeaderText="From_Sub_Dept" 
                SortExpression="From_Sub_Dept" />
           <asp:BoundField DataField="Qty" HeaderText="Qty" SortExpression="Qty" />
            <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount" SortExpression="TotalAmount" DataFormatString="{0:N2}" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" SelectCommand="uspGetMyPendingDemands" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="" Name="SubDeptId" 
                SessionField="SubDeptID" />
            <asp:SessionParameter DefaultValue="" Name="EmpId" SessionField="Emp_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

