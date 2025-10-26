<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" Inherits="Store_PendingPurchaseOrder"
    CodeFile="~/Store/Purchase/PendingPurchaseOrder.cs" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
      <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
      <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            
            <span><asp:Label runat="server" ID="lblHeader" Text="Pending Purchase Orders"></asp:Label> </span></h2>
        <table style="width: 100%;">
 
            <tr style="height:5px">
                 
                <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                </tr>
          <%--  <tr>
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
            </tr>--%>
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
             <tr style="height:5px">
                 
                <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                </tr>
             <tr    >
              
                    
                <%--<td align="right">
                    PO # :
                </td>
                <td>
                    <asp:TextBox ID="txtRequisitionNo" runat="server"></asp:TextBox>
                </td>--%>
                 
             
                       
                
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
<%--    <div class="bxmain inner_content" style="width: 100%;">
    <h2><span>Pending Requests</span></h2>
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
           <%--     <asp:BoundField DataField="Date_Time" HeaderText="Date" SortExpression="Date_Time" />
                <asp:BoundField DataField="FromSubDept" HeaderText="From Dept." ReadOnly="True" SortExpression="FromSubDept" />
                <asp:BoundField DataField="toSubDept" HeaderText="To Dept." ReadOnly="True" SortExpression="toSubDept" />
                <asp:BoundField DataField="Level1" HeaderText="Level 1" SortExpression="Level1" />
                <asp:BoundField DataField="Level2" HeaderText="Level 2" SortExpression="Level2" />
                <asp:BoundField DataField="Qty" HeaderText="Quantity" SortExpression="Qty" />
                <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" Visible="false" />--%>

                
      <%--      </Columns>
        </asp:GridView>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        SelectCommand="usp_Get_Pending_Approval_Request" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="" Name="SubDeptId" SessionField="SubDeptID" />
            <asp:SessionParameter DefaultValue="" Name="EmpId" SessionField="Emp_ID" />
        </SelectParameters>
    </asp:SqlDataSource> --%>
    <div>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="90%">
        </rsweb:ReportViewer>
    </div>
</asp:Content>
