<%@ Page Language="C#" MasterPageFile="~/Hacims_MasterPage_Admin_New.master" AutoEventWireup="true" CodeFile="EmployeeClearanceRequests.aspx.cs" Inherits="HR_EmployeeClearanceRequests" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div class="bxmain inner_content" style="width: 100%; margin-bottom: 10px;">
        <h2><span>Pending Employee Clearance Requests</span></h2>

        

        
            <asp:GridView ID="gvdClearance" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceClearance"
                 CssClass="Grid_1" Width="100%">
                <Columns>
                    <asp:TemplateField HeaderText="Sr#">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                   
                    <asp:BoundField DataField="SubDept_Name" HeaderText="Department" SortExpression="SubDept_Name" />
                    <asp:BoundField DataField="EmpId" HeaderText="EmpId" SortExpression="EmpId" />
                    <asp:BoundField DataField="Employee" HeaderText="Employee" SortExpression="Employee" />
                    <asp:BoundField DataField="Designation_Name" HeaderText="Designation" SortExpression="Designation_Name" />
                    <asp:BoundField DataField="JoiningDate" HeaderText="Joining Date" SortExpression="JoiningDate" />
                    <asp:BoundField DataField="InitiateDate" HeaderText="Initiate Date" SortExpression="InitiateDate" />
                    <asp:BoundField DataField="IsCleared" HeaderText="Cleared Status" SortExpression="IsCleared" />
                    
                    <asp:HyperLinkField DataNavigateUrlFormatString="~/hr/ApproveEmployeeClearance.aspx?empid={0}&clearanceid={1}"
                        HeaderText="Approve" Target="_blank" Text="Approve"
                        DataNavigateUrlFields="EmpID,ClearanceId" />

                </Columns>
                <HeaderStyle CssClass="GridHeader" />
                <AlternatingRowStyle CssClass="GridAltItem" />
            </asp:GridView>

        </div>

       

        <asp:SqlDataSource ID="SqlDataSourceClearance" runat="server" ConnectionString="<%$ ConnectionStrings:HRConnectionString %>"
        SelectCommand="usp_GetEmployeeClearancePendingRequest" SelectCommandType="StoredProcedure">
            <SelectParameters>
                            <asp:SessionParameter Name="SubDeptId" SessionField="SubDeptID"/>
                <asp:SessionParameter Name="DesignationId" SessionField="DesignationID"/>
                        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>

