<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="DemandReqMinimumAuthorityLevel.aspx.cs" Inherits="Store_DemandReqMinimumAuthorityLevel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="bxmain inner_content" style="width:100%;">
<h2><span>Minimum Approval Authority for Demand Requisition</span></h2>
<table width="100%">
    <tr>
        <td align="right" width="40%">
            Sub Department :
        </td>
        <td>
            <asp:DropDownList ID="ddlSubDepartment" runat="server" 
                DataSourceID="SqlDataSource2" DataTextField="SubDept_Name" 
                DataValueField="SubDept_Id" AppendDataBoundItems="true">
                <asp:ListItem Text=" --- Select --- " Value="0"></asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>" 
                SelectCommand="SELECT SubDepartment.SubDept_Id, SubDepartment.SubDept_Name FROM         SubDepartment ORDER BY SubDept_Name "></asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td align="right">
            Level
        </td>
        <td>
            <asp:DropDownList ID="ddlAuthLevel" runat="server">
                <asp:ListItem Text=" --- Select --- " Value="0"></asp:ListItem>
                <asp:ListItem Text="1" Value="1"></asp:ListItem>
                <asp:ListItem Text="2" Value="2"></asp:ListItem>
                <asp:ListItem Text="3" Value="3"></asp:ListItem>
                <asp:ListItem Text="4" Value="4"></asp:ListItem>
                <asp:ListItem Text="5" Value="5"></asp:ListItem>
                <asp:ListItem Text="6" Value="6"></asp:ListItem>
                <asp:ListItem Text="7" Value="7"></asp:ListItem>
                <asp:ListItem Text="8" Value="8"></asp:ListItem>
                <asp:ListItem Text="9" Value="9"></asp:ListItem>
                <asp:ListItem Text="10" Value="10"></asp:ListItem>
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td>
        
        </td>
        <td>
            <asp:Button id="btnSave" Text="Save" runat="server" onclick="btnSave_Click" />       
        </td>
    </tr>
   
</table>
</div>
<br />

<asp:GridView ID="gvApprovalAuthorities" runat="server" AutoGenerateColumns="False" 
      Width="100%"  DataKeyNames="Min_Approval_Auth_Id" DataSourceID="sqlDs_MinApprovalAuthorities">
    <Columns>
        <asp:TemplateField>
            <ItemTemplate>
                <asp:ImageButton ID="imgDelete" OnClientClick="return confirm('Do you want to delete this record?');" runat="server" CommandArgument='<%#Eval("Min_Approval_Auth_Id")%>' ToolTip="Delete" OnClick="imgDelete_Click"
                   ImageUrl="~/Images/delete.png" Width="16" />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="Min_Approval_Auth_Id" 
            HeaderText="Min_Approval_Auth_Id" InsertVisible="False" ReadOnly="True" Visible="false"
            SortExpression="Min_Approval_Auth_Id" />
        <asp:BoundField DataField="SubDept_Id" HeaderText="SubDept_Id" Visible="false"
            SortExpression="SubDept_Id" />
        <asp:BoundField DataField="Auth_Level" HeaderText="Authentication Level" 
            SortExpression="Auth_Level" />
        <asp:BoundField DataField="SubDept_Name" HeaderText="Sub Department Name" 
            SortExpression="SubDept_Name" />
    </Columns>
</asp:GridView>

<asp:SqlDataSource ID="sqlDs_MinApprovalAuthorities" runat="server" 
        ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
         SelectCommand="SELECT Min_Authority_Level_Demand.Min_Approval_Auth_Id,	Min_Authority_Level_Demand.SubDept_Id,
	Min_Authority_Level_Demand.Auth_Level,SubDepartment.SubDept_Name FROM Min_Authority_Level_Demand
INNER JOIN SubDepartment ON Min_Authority_Level_Demand.SubDept_Id = SubDepartment.SubDept_Id" 
        DeleteCommand="Delete From Min_Authority_Level_Demand Where Min_Approval_Auth_Id = @Min_Approval_Auth_Id" 
        UpdateCommand="usp_SaveMinDemandApprovalAuthority" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Min_Approval_Auth_Id" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="ddlSubDepartment" Name="SubdeptId" 
                PropertyName="SelectedValue" Type="Int32" />         
            <asp:ControlParameter ControlID="ddlAuthLevel" Name="AuthLevel" 
                PropertyName="SelectedValue" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

</asp:Content>

