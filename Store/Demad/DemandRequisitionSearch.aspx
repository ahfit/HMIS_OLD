<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="DemandRequisitionSearch.aspx.cs" Inherits="Store_DemandRequisitionSearch" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="bxmain inner_content" style="width:100%;">
<h2><span>Search Demand Requisition</span></h2>
<table style="width: 100%;" class="table">
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
                <asp:DropDownList style="width: 14.3em;" ID="ddlDepartment" runat="server" 
                    DataSourceID="sqlDsDepartment" DataTextField="Dept_Name" 
                    DataValueField="Dept_ID" AutoPostBack="True" 
                    onselectedindexchanged="ddlDepartment_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sqlDsDepartment" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" 
                    
                    SelectCommand="SELECT Department.Dept_ID, Department.Dept_Name
FROM Department ORDER BY Department.Dept_Name"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="right">
                Employee :
            </td>
            <td>
                <asp:DropDownList style="width: 14.3em;" ID="ddlEmployee" runat="server" DataSourceID="sqlDs_Employee" 
                    DataTextField="Name" DataValueField="EmpID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sqlDs_Employee" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" SelectCommand="SELECT EmpID, Name, DeptID FROM Employee 
Where DeptID = @DeptID 
ORDER BY Name">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlDepartment" Name="DeptID" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td align="right">
                Pending Work Flow :
            </td>
            <td>
                <asp:CheckBox  ID="chkPendingWorkFlow" runat="server" />
            </td>
        </tr>
        <tr>
            <td align="right">
                From Date :
            </td>
            <td>
                <igsch:WebDateChooser ID="wdcFromDate" runat="server" Width="202px">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:WebDateChooser>
            </td>
            <td align="right">
                To Date :
            </td>
            <td>
                <igsch:WebDateChooser ID="wdcToDate" runat="server" Width="202px">
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
                <asp:Button style="margin-left: -7em;" ID="btnSearchRequisition" runat="server" Text="View Requisition" OnClick="btnSearchRequisition_Click" />
            </td>
            <td>
            </td>
        </tr>
      
    </table>
    </div>
    <br />
    <asp:GridView ID="GridView1" Width="100%" runat="server" AutoGenerateColumns="False"
        DataKeyNames="Demand_RQ_ID" DataSourceID="SqlDataSource1" 
        onrowdatabound="GridView1_RowDataBound">
        <Columns>
            <%--<asp:HyperLinkField DataNavigateUrlFields="IB_ID" DataNavigateUrlFormatString="~/Store/Approve_Requisition.aspx?IB_ID={0}"
                Text="Forward for Approval" />--%>
                <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" OnClientClick='return confirm("Do you want to delete this record?");'
                        Width="16px" ImageUrl="~/images/icon_delete.gif" Text="Delete" 
                        onclick="ImageButton1_Click" CommandArgument='<%# Eval("Demand_RQ_ID") %>' />
                </ItemTemplate>
                <ItemStyle CssClass="elementCenterAlign" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <asp:HyperLink ID="hlnkAction" runat="server" Text="Click Me"></asp:HyperLink>
                    <asp:HiddenField ID="hfld_Workflow_Process" runat="server" Value='<%# Eval("Workflow_Process") %>' />
                    <asp:HiddenField ID="hfld_Demand_RQ_ID" runat="server" Value='<%# Eval("Demand_RQ_ID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Demand_RQ_ID">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkDemandId" runat="server" 
                        Text='<%# Eval("Demand_RQ_ID") %>' 
                        CommandArgument='<%# Eval("Demand_RQ_ID") %>' onclick="lnkDemandId_Click"></asp:LinkButton>
                        <asp:HiddenField ID="hdfCompany_ID" runat="server" 
                        Value='<%# Eval("Company_ID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Demand_RQ_ID" HeaderText="Demand_RQ_ID" ReadOnly="True" SortExpression="Demand_RQ_ID" Visible="false" />
            <asp:BoundField DataField="Date_Time" HeaderText="Date Time" DataFormatString="{0:dd MMMM yyyy hh:mm tt}" SortExpression="Date_Time" />
            <asp:BoundField DataField="From_Sub_Dept" HeaderText="From Sub Department" SortExpression="From_Sub_Dept" />
            <asp:BoundField DataField="Qty" HeaderText="Qty" SortExpression="Qty" />
            <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount" SortExpression="TotalAmount" DataFormatString="{0:N2}" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" CancelSelectOnNullParameter="false" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        SelectCommand="uspGetDemandRequisitionsForWorkFlow" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="Demand_RequisitionNo" Type="String" />
            <asp:Parameter Name="From_Dept_ID" />
            <asp:Parameter Name="Emp_ID"  />
            <asp:Parameter Name="FromDate" Type="DateTime" />
            <asp:Parameter Name="ToDate" Type="DateTime" />
            <asp:Parameter Name="PendingWorkFlow" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

