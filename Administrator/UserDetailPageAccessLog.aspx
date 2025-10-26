<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="false" CodeFile="UserDetailPageAccessLog.aspx.vb" Inherits="Administrator_UserDetailPageAccessLog" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="bxmain inner_content" ><span><h2>User Pages Access Detail</h2></span>
<table width="100%" >
        <tr style="display:none;">
            <td>User Name</td>
           
            <td>
                <asp:TextBox ID="txtUserName" runat="Server" Width="200px"></asp:TextBox>
                                <asp:ImageButton 
                                    ID="btnFilterPO" 
                                    runat="server" 
                                    ImageUrl="~/Images/icon_filter_1.png" 
                                    Width="27px"
                                    Height="27px"
                                    Text="Filter PO" 
                                     />
            </td>
        </tr>
    <tr>
            <td style="text-align:right">Department</td>
            <td>:</td>
            <td>
                 <asp:DropDownList runat="server" AutoPostBack="true" OnSelectedIndexChanged="DDL_SubDept_SelectedIndexChanged"
                      ID="DDL_SubDept" DataTextField="SubDept_Name" DataSourceID="sdsDepartment" CssClass="drop_down" DataValueField="SubDept_Id" Width="230px">
                    </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td style="text-align:right">Employee</td>
            <td>:</td>
            <td>
                <asp:DropDownList ID="DropDownList_Employee" runat="server"  
                    DataSourceID="SDS_Employee" DataTextField="DisplayText" 
                    DataValueField="EmpID" Width="230">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td style="text-align:right">From Date</td>
            <td>:</td>
            <td>
                <asp:TextBox ID="WebDateChooser_FromDate" runat="server" TextMode="Date" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align:right">To Date</td>
            <td>:</td>
            <td>
                <asp:TextBox ID="WebDateChooser_ToDate" runat="server" TextMode="Date"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="2">
            </td>
            <td>
                <asp:Button ID="btnSearch"  runat="Server" Text="Search" />
                                 <asp:Button ID="btn_export" runat="server" OnClick="btn_export_Click" Text="Export" />
                
            </td>
        </tr>
    </table>
    </div>
    <div style="padding-top:10px;">
    <asp:GridView ID="grdUserPageAccessLog" 
        runat="server"
        Width="100%"
        AutoGenerateColumns="False"
        DataSourceID="sqlDs_UserPageAccessLog" AllowPaging="True" PageSize="20"
        >
        <Columns>
        <asp:TemplateField HeaderText="SrNo."> 
<ItemTemplate> <%#Container.DataItemIndex+1%> 
</ItemTemplate>
<ItemStyle Width="8%" /> 
</asp:TemplateField>
            <asp:BoundField DataField="Access_DateTime" DataFormatString="{0:dd-MM-yyyy hh:mm:ss tt}" HeaderText="Login DateTime" />
            <asp:BoundField DataField="Page_Name" HeaderText="User Accessed Page" />
            <asp:BoundField DataField="UserName" HeaderText="User Name" />
            <asp:BoundField DataField="User_IP" HeaderText="User IP" />
        </Columns>
    </asp:GridView>
    </div>
    <asp:SqlDataSource ID="sqlDs_UserPageAccessLog" 
        runat="server"
        CancelSelectOnNullParameter="False"
        ConnectionString="<%$ ConnectionStrings:UsersConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:UsersConnectionString.ProviderName %>" 
        SelectCommand="usp_GetUserPageAccess"
        SelectCommandType="StoredProcedure"
        >
    
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_Employee" DefaultValue="%" Name="UserName"  />
            <asp:ControlParameter ControlID="WebDateChooser_FromDate" DefaultValue="2013-01-01" Name="UseDateFrom" PropertyName="Text" />
            <asp:ControlParameter ControlID="WebDateChooser_ToDate" DefaultValue="2020-01-31" Name="UseDateTo" PropertyName="Text" />
            
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

     <asp:SqlDataSource ID="sdsDepartment" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
        
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="select SubDept_Id,SubDept_Name from SubDepartment ">        
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

