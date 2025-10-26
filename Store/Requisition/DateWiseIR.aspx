<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true"
    CodeFile="DateWiseIR.aspx.cs" Inherits="Store_DateWiseIR" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script language="javascript" type="text/javascript">
        function CheckRequirment() {
            if (document.getElementById("TextBox_specificMedicine").value.length == 0) {

            }
        }
        function ClientItemSelected2(sender, e) {
            $get("<%=hfItemCode.ClientID %>").value = e.get_value();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
      <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            
            <span><asp:Label runat="server" ID="lblHeader" Text="Search DateWise Requistions"></asp:Label> </span></h2>
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
                        DataTextField="Dept_Name" DataValueField="Dept_ID"   >
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sqlDsDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                        SelectCommand="SELECT 0 as Dept_ID, '--All--' as  Dept_Name UNION SELECT Department.Dept_ID, Department.Dept_Name
FROM Department ORDER BY  Dept_Name"></asp:SqlDataSource>
                </td>
            </tr>
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
                 <td id="ItemDiv" runat="server"  visible="false" colspan="2">
                     <table style="width:100%">
                         <tr>
                              <td align="right" style="width: 231px;">
                    Items :
                </td>
                <td>
                     <asp:TextBox ID="TextBox_specificMedicine" Width="242px" runat="server" CssClass="input_txt"
                                     ></asp:TextBox>
                                     <asp:AutoCompleteExtender ID="aceItems" runat="server" ServiceMethod="SearchItems"
                                        MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                                        TargetControlID="TextBox_specificMedicine" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected2">
                                    </asp:AutoCompleteExtender>
                            <asp:HiddenField ID="hfItemCode" runat="server" />
                      <%--<asp:DropDownList ID="DDLItemWise" runat="server" DataSourceID="sqlDsItems"
                        DataTextField="Item_Name" DataValueField="Item_Code"   >
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sqlDsItems" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                        SelectCommand="SELECT '0' as Item_Code, '--All--' as  Item_Name UNION SELECT Item_Code,Item_Name
FROM Store_Items ORDER BY  Item_Name"></asp:SqlDataSource>--%>
                </td>
                         </tr>
                     </table>
                     </td>
              
                 
                <td id="category" runat="server"  visible="false" colspan="2">
                   <table style="width:100%">
                       <tr>
                           <td  align="right"  style="width: 221px;">
                                Category :
                           </td>
                           <td>
                               <asp:DropDownList ID="DDLCategory" runat="server" DataSourceID="sqlDsCategory"
                        DataTextField="Item_Type" DataValueField="Item_Type_Id"   >
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sqlDsCategory" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                        SelectCommand="SELECT '0' as Item_Type_Id, '--All--' as  Item_Type UNION SELECT Item_Type_Id,Item_Type
FROM Store_Item_Types ORDER BY  Item_Type
"></asp:SqlDataSource>
                           </td>
                       </tr>
                   </table>
                    
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
       <div>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="90%">
        </rsweb:ReportViewer>
    </div>
 
    <%--<asp:SqlDataSource ID="SqlDataSource1" CancelSelectOnNullParameter="false" runat="server"
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
    </asp:SqlDataSource>--%>
</asp:Content>
