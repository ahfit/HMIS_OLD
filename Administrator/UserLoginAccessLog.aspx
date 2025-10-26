<%@ Page Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="false" 
    CodeFile="UserLoginAccessLog.aspx.vb" Inherits="Administrator_UserLoginAccessLog" title="Untitled Page" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="bxmain inner_content" ><span><h2>User Login  Detail</h2></span>
    <table width="100%">
    
         <tr>
            <td style="text-align:right">Department</td>
            <td>:</td>
            <td>
                 <asp:DropDownList runat="server" AutoPostBack="true" OnSelectedIndexChanged="DDL_SubDept_SelectedIndexChanged"
                      ID="DDL_SubDept" DataTextField="SubDept_Name" DataSourceID="sdsDepartment" CssClass="drop_down" DataValueField="SubDept_Id" Width="230px">
                    </asp:DropDownList>
                
     <asp:SqlDataSource ID="sdsDepartment" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
        
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="select SubDept_Id,SubDept_Name from SubDepartment ">        
    </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="right">Employee</td>
            <td>:</td>
            <td style="width:50%">
                <asp:DropDownList ID="DropDownList_Employee" runat="server" 
                    DataSourceID="SDS_Employee" DataTextField="DisplayText" 
                    DataValueField="EmpID" Width="200px">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td align="right">From Date</td>
            <td>:</td>
            <td>
                <igsch:WebDateChooser ID="WebDateChooser_FromDate" runat="server" Width="200px">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:WebDateChooser>
            </td>
        </tr>
        <tr>
            <td align="right">To Date</td>
            <td>:</td>
            <td>
                <igsch:WebDateChooser ID="WebDateChooser_ToDate" runat="server" Width="200px">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:WebDateChooser>
            </td>
        </tr>
        <tr>
            <td colspan="2">
            </td>
            <td>
                 <asp:Button ID="btn_export" runat="server" OnClick="btn_export_Click" Text="Export" />
                <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="Server" Text="Search" />
            </td>
        </tr>
    </table>
         <div style="padding-top:10px;"  class="bxmain inner_content" ><span><h2> Detail</h2></span>
    <asp:GridView ID="grdUserLoginAccessLog" 
        runat="server"
        Width="100%"
        AutoGenerateColumns="false"
        DataSourceID="sqlDs_UserLoginAccessLog" AllowPaging="True" PageSize="20"  >
        <Columns>
        <asp:TemplateField HeaderText="SrNo."> 
<ItemTemplate> <%#Container.DataItemIndex+1%> 
</ItemTemplate>
<ItemStyle Width="8%" /> 
</asp:TemplateField>
            <asp:BoundField DataField="UserName" HeaderText="Employee Name" />
            <asp:BoundField DataField="Usage_Datetime" DataFormatString="{0:dd-MM-yyyy hh:mm:ss tt}" HeaderText="Login DateTime" />
            <asp:BoundField DataField="RH_ID" HeaderText="Successful Login" />
            <asp:BoundField DataField="User_IP" HeaderText="System IP" />
        </Columns>
    </asp:GridView>
             </div>
    <asp:SqlDataSource ID="sqlDs_UserLoginAccessLog" 
        runat="server"
        CancelSelectOnNullParameter="False"
        ConnectionString="<%$ ConnectionStrings:UsersConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:UsersConnectionString.ProviderName %>" 
        SelectCommand="usp_GetUserLoginAccess"
        SelectCommandType="StoredProcedure"
        >
    
        <SelectParameters>
            
            <asp:Parameter Name="UseDateFrom" DefaultValue="2013-01-01" />        
            <asp:Parameter Name="UseDateTo" DefaultValue="2013-01-31" /> 
            <asp:Parameter Name="EmpId"  DefaultValue="0" />       
        </SelectParameters>
        
        
    </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
        
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand=" 
SELECT     EmpID, isnull(EFName,' ') +' '+ isnull(EMName,' ') +' '+ isnull(ELName,' ') AS DisplayText, (EmpID) AS OrderBy
FROM         Employee
WHERE     SubDeptId=@Parm
ORDER BY OrderBy DESC">
        <SelectParameters>
            <asp:ControlParameter  ControlID="DDL_SubDept"  Name="Parm" 
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
<asp:SqlDataSource ID="SDS_Employee" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
        
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand=" 
SELECT     EmpID, isnull(EFName,' ') +' '+ isnull(EMName,' ') +' '+ isnull(ELName,' ') AS DisplayText, (EmpID) AS OrderBy
FROM         Employee
WHERE     SubDeptId=@Parm
ORDER BY OrderBy DESC">
        <SelectParameters>
            <asp:ControlParameter  ControlID="DDL_SubDept"  Name="Parm" 
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>

                                <asp:SqlDataSource ID="SDS_Find_PO_No" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
                                    SelectCommand="SELECT     0 AS EmpID, ' --- Select --- ' AS DisplayText, 9999999999 AS OrderBy
UNION ALL
SELECT     EmpID, isnull(EFName,' ') +' '+ isnull(ELName,' ') AS DisplayText, (EmpID) AS OrderBy
FROM         Employee
WHERE     (EFName LIKE '%' + @Param+ '%')
ORDER BY OrderBy DESC" 
        
        
        ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="%" Name="Param" />
                                    </SelectParameters>
                                    </asp:SqlDataSource>

                               
                            </asp:Content>

