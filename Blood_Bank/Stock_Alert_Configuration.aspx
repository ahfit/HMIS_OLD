<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage_admin.master" inherits="Blood_Bank_Stock_Configuration, App_Web_ob4gay25" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

 
 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <div class="bxmain">
 <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="tbl_form">
  <tr>
    <td width="40%" align="right">Blood Group : </td>
    <td width="60%"><asp:DropDownList ID="DropDownList_BG" runat="server" AutoPostBack="True" Width="100px"
            datasourceid="SqlDataSource_BG" DataTextField="BG" DataValueField="Blood_Group_Id"
            OnSelectedIndexChanged="DropDownList_BG_SelectedIndexChanged"> </asp:DropDownList></td>
  </tr>
  <tr>
    <td align="right">Product Formation : </td>
    <td><asp:DropDownList ID="DropDownList_PF" runat="server" AutoPostBack="True" Width="100px"
            datasourceid="SqlDataSource_PF" DataTextField="Component_Name" DataValueField="Component_id"> </asp:DropDownList></td>
  </tr>
  <tr>
    <td align="right">Warning Level : </td>
    <td><asp:TextBox ID="TextBox_WL" runat="server"></asp:TextBox>
Hours</td>
  </tr>
  <tr>
    <td align="right">Critical Level :</td>
    <td><asp:TextBox ID="TextBox_CL" runat="server"></asp:TextBox>
Hours</td>
  </tr>
  <tr>
    <td align="right">&nbsp;</td>
    <td><asp:Button ID="Button_Save" runat="server" OnClick="Button_Save_Click" Text="Save" /></td>
  </tr>
</table></div>
<br />
 
        <asp:SqlDataSource ID="SqlDataSource_BG" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
            SelectCommand="SELECT ISNULL(Group_Name, '') + ' ' + ISNULL(Rh_Factor, '') AS BG, Blood_Group_Id FROM Blood_Group">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_PF" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
            SelectCommand="SELECT Component_id, Component_Name FROM Blood_Component"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_Save" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
            DeleteCommand="DELETE FROM Stock_Configuration WHERE (Stock_Configuration_Id = @Stock_Configuration_Id)"
            InsertCommand="Insert_Stock_Configuration" InsertCommandType="StoredProcedure"
            SelectCommand="SELECT Stock_Configuration.Warning_Level, Stock_Configuration.Critical_Level, ISNULL(Blood_Group.Group_Name, '') + ' ' + ISNULL(Blood_Group.Rh_Factor, '') AS BG, Blood_Component.Component_Name, Stock_Configuration.Stock_Configuration_Id, Blood_Component.Component_id FROM Stock_Configuration INNER JOIN Blood_Group ON Stock_Configuration.Blood_Group_Id = Blood_Group.Blood_Group_Id INNER JOIN Blood_Component ON Stock_Configuration.Blood_Product_Id = Blood_Component.Component_id ORDER BY BG"
            UpdateCommand="UPDATE Stock_Configuration SET Warning_Level = @Warning_Level, Critical_Level = @Critical_Level WHERE (Stock_Configuration_Id = @Stock_Configuration_Id)">
            <DeleteParameters>
                <asp:ControlParameter ControlID="GridView_Display" Name="Stock_Configuration_Id"
                    PropertyName="SelectedValue" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="Warning_Level" />
                <asp:Parameter Name="Critical_Level" />
                <asp:ControlParameter ControlID="GridView_Display" Name="Stock_Configuration_Id"
                    PropertyName="SelectedValue" />
            </UpdateParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="TextBox_WL" Name="Warning_Level" PropertyName="Text" />
                <asp:ControlParameter ControlID="TextBox_CL" Name="Critical_Level" PropertyName="Text" />
                <asp:ControlParameter ControlID="DropDownList_BG" Name="Blood_Group_Id" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="DropDownList_PF" Name="Blood_Product_Id" PropertyName="SelectedValue" />
            </InsertParameters>
        </asp:SqlDataSource>
    
 
     
     
        <asp:GridView ID="GridView_Display" runat="server" Width="100%" AutoGenerateColumns="False" DataKeyNames="Stock_Configuration_Id"
            DataSourceID="SqlDataSource_Save">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                <asp:BoundField DataField="BG" HeaderText="Blood Group" ReadOnly="True" SortExpression="BG" />
                <asp:TemplateField HeaderText="Component Name" SortExpression="Component_Name">
                    <EditItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("Component_Name") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("Component_Name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Warning Level" SortExpression="Warning_Level">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Warning_Level") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Warning_Level") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Critical Level" SortExpression="Critical_Level">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Critical_Level") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Critical_Level") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
 
 
  </asp:Content>
 
 
 
 
 
 
 
 
 
 
 