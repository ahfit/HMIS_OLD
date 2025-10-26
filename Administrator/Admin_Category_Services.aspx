<%@ Page Language="VB" AutoEventWireup="false"   MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="Admin_Category_Services.aspx.vb" Inherits="Administrator_Admin_Services" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">




<script type="text/javascript" src="../../Validate.js"></script>
 

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


<div class="bxmain">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td align="right" width="40%"> Category Name : </td>
    <td width="60%"><asp:TextBox ID="TextBox_Cat_Name" runat="server" ></asp:TextBox>&nbsp;<asp:Button ID="Button_Save" runat="server" Text="Save"  />
    <asp:Label ID="LabelSave" runat="server" Text="Label"></asp:Label></td>
  </tr>
</table></div>

<br />



   <asp:SqlDataSource ID="SqlDataSource_Save_Info" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                InsertCommand="Insert_New_Category" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="TextBox_Cat_Name" Name="Asc_Name" PropertyName="Text"
                                        Type="String" />
                                </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT     Asc_id, Asc_Name, Main_Category&#13;&#10;FROM         Admin_Service_Category&#13;&#10;" DeleteCommand="DELETE FROM Admin_Service_Category WHERE (Asc_id = @Asc_id)">
        <DeleteParameters>
            <asp:ControlParameter ControlID="HiddenField_Asc_id" Name="Asc_id" PropertyName="Value" />
        </DeleteParameters>
    </asp:SqlDataSource>
        
    
    


<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
        CssClass="Grid_1" DataKeyNames="Asc_id" DataSourceID="SqlDataSource1" Width="100%">
        <Columns>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                  <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Delete" ImageUrl="~/images_hacims/icon_delete.gif"   ToolTip="Delete"
                        OnClientClick="return confirmation(this)" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Asc_id" HeaderText="Asc_id" SortExpression="Asc_id" />
            <asp:BoundField DataField="Asc_Name" HeaderText="Asc_Name" SortExpression="Asc_Name" />
            <asp:BoundField DataField="Main_Category" HeaderText="Main_Category" SortExpression="Main_Category" />
        </Columns> <RowStyle CssClass="GridItem" />
<AlternatingRowStyle CssClass="GridAltItem" />
<PagerStyle CssClass="GridPager" />

    </asp:GridView>
 
    <asp:HiddenField ID="HiddenField_Asc_id" runat="server" />
<br />
        <br />
  </asp:Content>