<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" Inherits="Store_MyPendingApprovalRequests"
    CodeFile="MyPendingApprovalRequests.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%;">
    <h2><span>My Pending Approval Requests</span></h2>
        <asp:GridView ID="GridView1" Width="100%" runat="server" AutoGenerateColumns="False"
            EmptyDataText="No Record Found" DataKeyNames="IB_ID" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:HyperLinkField DataNavigateUrlFields="IB_ID,Approval_Request_Id" DataNavigateUrlFormatString="~/Store/Approve_Requisition_Request.aspx?IB_ID={0}&PID={1}"
                    Text="Approve & Forward" />
                    <asp:TemplateField HeaderText="IB ID">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkDemandId" runat="server" Text='<%# Eval("IB_ID") %>'
                        CommandArgument='<%# Eval("IB_ID") %>' OnClick="lnkDemandId_Click"></asp:LinkButton>
                    <asp:HiddenField ID="hdfCompany_ID" runat="server" Value='<%# Eval("Company_ID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
                <%--<asp:BoundField DataField="IB_ID" HeaderText="PO#" ReadOnly="True" SortExpression="IB_ID" />--%>
                <asp:BoundField DataField="Date_Time" HeaderText="Date" SortExpression="Date_Time" />
                <asp:BoundField DataField="FromSubDept" HeaderText="From Dept." ReadOnly="True" SortExpression="FromSubDept" />
                <asp:BoundField DataField="toSubDept" HeaderText="To Dept." ReadOnly="True" SortExpression="toSubDept" />
                <asp:BoundField DataField="Level1" HeaderText="Level 1" SortExpression="Level1" />
                <asp:BoundField DataField="Level2" HeaderText="Level 2" SortExpression="Level2" />
                <asp:BoundField DataField="Qty" HeaderText="Quantity" SortExpression="Qty" />
                <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" Visible="false" />

                
            </Columns>
        </asp:GridView>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        SelectCommand="usp_Get_Pending_Approval_Request" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="" Name="SubDeptId" SessionField="SubDeptID" />
            <asp:SessionParameter DefaultValue="" Name="EmpId" SessionField="Emp_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
