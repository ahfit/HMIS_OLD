<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true"
    CodeFile="SearchIPO_Approved.aspx.cs" Inherits="Store_SearchIPO_Approved" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span>Search Requistions</span></h2>
        <table style="width: 100%;">
            <tr>
                <td align="right">
                    Requisition # :
                </td>
                <td>
                    <asp:TextBox ID="txtRequisitionNo" runat="server"></asp:TextBox>
                </td>
                <td align="right">
                    Department :
                </td>
                <td>
                    <asp:DropDownList ID="ddlDepartment" runat="server" DataSourceID="sqlDsDepartment"
                        DataTextField="Dept_Name" DataValueField="Dept_ID" AutoPostBack="True" OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sqlDsDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                        SelectCommand="SELECT Department.Dept_ID, Department.Dept_Name
FROM Department ORDER BY Department.Dept_Name"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Employee :
                </td>
                <td>
                    <asp:DropDownList ID="ddlEmployee" runat="server" DataSourceID="sqlDs_Employee" DataTextField="Name"
                        DataValueField="EmpID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sqlDs_Employee" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                        SelectCommand="SELECT EmpID, Name, DeptID FROM Employee 
Where DeptID = @DeptID
ORDER BY Name">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlDepartment" Name="DeptID" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
                <td align="right">
                    Pending Work Flow :
                </td>
                <td>
                    <asp:CheckBox ID="chkPendingWorkFlow" runat="server" />
                </td>
            </tr>
            <tr>
                <td align="right">
                    From Date :
                </td>
                <td>
                    <igsch:WebDateChooser ID="wdcFromDate" runat="server">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
                <td align="right">
                    To Date :
                </td>
                <td>
                    <igsch:WebDateChooser ID="wdcToDate" runat="server">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                </td>
                <td>
                    <asp:Button ID="btnSearchRequisition" runat="server" Text="View Requisition" OnClick="btnSearchRequisition_Click" />
                </td>
                <td>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <asp:GridView ID="GridView1" Width="100%" runat="server" AutoGenerateColumns="False"
        DataKeyNames="IB_ID" DataSourceID="SqlDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%--<asp:HyperLinkField DataNavigateUrlFields="IB_ID" DataNavigateUrlFormatString="~/Store/Approve_Requisition.aspx?IB_ID={0}"
                Text="Forward for Approval" />--%>
            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <asp:HyperLink ID="hlnkAction" runat="server" Text="Click Me"></asp:HyperLink>
                    <asp:HiddenField ID="hfld_Workflow_Process" runat="server" Value='<%# Eval("Workflow_Process") %>' />
                    <asp:HiddenField ID="hfld_IB_ID" runat="server" Value='<%# Eval("IB_ID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="IB ID">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkDemandId" runat="server" Text='<%# Eval("IB_ID") %>'
                        CommandArgument='<%# Eval("IB_ID") %>' OnClick="lnkDemandId_Click"></asp:LinkButton>
                    <asp:HiddenField ID="hdfCompany_ID" runat="server" Value='<%# Eval("Company_ID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="IB_ID" HeaderText="IB ID" ReadOnly="True"
                SortExpression="IB_ID" Visible="false" />
            <asp:BoundField DataField="Date_Time" HeaderText="Date Time" DataFormatString="{0:dd MMMM yyyy hh:mm tt}"
                SortExpression="Date_Time" />
            <asp:BoundField DataField="Customer_Name" HeaderText="Reseller" SortExpression="Customer_Name" />
            <%--<asp:BoundField DataField="End_User" HeaderText="End User" SortExpression="End_User" />--%>
            <%--<asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" DataFormatString="{0: #,###.##}" />--%>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" CancelSelectOnNullParameter="false" runat="server"
        ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" SelectCommand="uspGetIPOForWorkFlow"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="Demand_RequisitionNo" Type="String" />
            <asp:Parameter Name="From_Dept_ID" />
            <asp:Parameter Name="Emp_ID" />
            <asp:Parameter Name="FromDate" Type="DateTime" />
            <asp:Parameter Name="ToDate" Type="DateTime" />
            <asp:Parameter Name="PendingWorkFlow" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
