<%@ page title="" language="C#" masterpagefile="~/Hacims_MasterPage_Admin_New.master" autoeventwireup="true" inherits="EmployeeWiseUpdateRights, App_Web_m54ycrm1" enableeventvalidation="false" theme="theme_hacims" viewstateencryptionmode="Never" maintainscrollpositiononpostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .tblWidth
        {
            width: 100%;
            /*border: 1px solid #800000;*/
        }
        
        .aligntext
        {
            text-align:right;
            font-weight:bold;
            
         }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain">
    <table class="tblWidth">
        <tr>
            <td class="aligntext">
                Rights Form&nbsp; Employee:
            </td>
            <td>
                
                 <asp:DropDownList ID="ddlRightforEmp" runat="server" 
                     DataSourceID="sdsForEmployee" DataTextField="EFName" 
                     DataValueField="EmpID" 
                     onselectedindexchanged="ddlRightforEmp_SelectedIndexChanged" 
                     AutoPostBack="True">
            </asp:DropDownList>
                 <asp:SqlDataSource ID="sdsForEmployee" runat="server" 
                     ConnectionString="<%$ ConnectionStrings:Users_ConnectionString %>" 
                     SelectCommand="SELECT     Login.EmpID,ISNULL(Employee.EFName,'') +' '+ ISNULL(Employee.EMName,'')+' '+ISNULL(Employee.ELName,'') as EFName
                        FROM         Login INNER JOIN
                         Employee ON Login.EmpID = Employee.EmpID ">
                 </asp:SqlDataSource>
                 <asp:Label ID="lblRightFromEmploy" runat="server" Text=""></asp:Label>
            </td>
           
        </tr>
        <tr>
            <td class="aligntext">
                Rights to Employee:
            </td>
            <td>
                
                <asp:DropDownList ID="ddlRightToEmp" runat="server" 
                    DataSourceID="sdsRightToEmployee" DataTextField="EFName" 
                    DataValueField="EmpID" AutoPostBack="True" 
                    onselectedindexchanged="ddlRightToEmp_SelectedIndexChanged">
            </asp:DropDownList>
                <asp:SqlDataSource ID="sdsRightToEmployee" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:Users_ConnectionString %>" 
                    SelectCommand="SELECT     Login.EmpID,ISNULL(Employee.EFName,'') +' '+ ISNULL(Employee.EMName,'')+' '+ISNULL(Employee.ELName,'') as EFName
FROM         Login INNER JOIN
                      Employee ON Login.EmpID = Employee.EmpID">
                </asp:SqlDataSource>
                <asp:Label ID="lblRightToEmployee" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
               
            </td>
            <td>
               <asp:Button ID ="btnAssignPages" runat ="server" Text ="Assign Pages" 
                    onclick="btnAssignPages_Click" />
               <asp:SqlDataSource ID="sdsAssignPages" runat ="server" 
                    ConnectionString="<%$ ConnectionStrings:Users_ConnectionString %>" 
                    InsertCommand="usp_Update_Rights" InsertCommandType="StoredProcedure" 
                    ProviderName="<%$ ConnectionStrings:Users_ConnectionString.ProviderName %>">
                   <InsertParameters>
                       <asp:ControlParameter ControlID="ddlRightToEmp" Name="To_Emp_ID" 
                           PropertyName="SelectedValue" Type="Int32" />
                       <asp:ControlParameter ControlID="ddlRightforEmp" Name="From_Emp_id" 
                           PropertyName="SelectedValue" Type="Int32" />
                   </InsertParameters>
                </asp:SqlDataSource>

                <asp:Label ID="lblNoteForAssignRights" runat="server" Text=""></asp:Label>

             </td>
            
            
        </tr>
    </table>
    </div><!--end bamain-->
</asp:Content>
