<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="skills_edit, App_Web_ah1wcbj4" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>



 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


          <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataSourceID="SqlDataSource1"
            Width="100%" DataKeyNames="Employee_ID" CssClass="Grid_1">
            <Fields>
              <asp:BoundField DataField="Languages" HeaderText="Languages" SortExpression="Languages" />
              <asp:BoundField DataField="Databases" HeaderText="Databases" SortExpression="Databases" />
              <asp:BoundField DataField="Tools" HeaderText="Tools" SortExpression="Tools" />
              <asp:BoundField DataField="Networking" HeaderText="Networking" SortExpression="Networking" />
              <asp:BoundField DataField="Operating_Systems" HeaderText="Operating_Systems" SortExpression="Operating_Systems" />
                <asp:TemplateField>
                    <EditItemTemplate>
                        <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images/icon_ok.gif" />&nbsp;<asp:ImageButton
                            ID="ImageButton4" runat="server" CommandName="Cancel" ImageUrl="~/images/icon_err.gif" />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/images/icon_edit.gif"
                            OnClientClick="return confirmation_edit(this)" />&nbsp;<asp:ImageButton ID="ImageButton2"
                                runat="server" CommandName="Delete" ImageUrl="~/images/icon_delete.gif" OnClientClick="return confirmation(this)" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Fields>
          </asp:DetailsView>
 
          <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
            DeleteCommand="DELETE FROM [Skills] WHERE [Employee_ID] = @Employee_ID" InsertCommand="INSERT INTO [Skills] ([Employee_ID], [Languages], [Databases], [Tools], [Networking], [Operating_Systems]) VALUES (@Employee_ID, @Languages, @Databases, @Tools, @Networking, @Operating_Systems)"
            SelectCommand="SELECT [Employee_ID], [Languages], [Databases], [Tools], [Networking], [Operating_Systems] FROM [Skills]"
            UpdateCommand="UPDATE [Skills] SET [Languages] = @Languages, [Databases] = @Databases, [Tools] = @Tools, [Networking] = @Networking, [Operating_Systems] = @Operating_Systems WHERE [Employee_ID] = @Employee_ID">
            <DeleteParameters>
              <asp:Parameter Name="Employee_ID" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
              <asp:Parameter Name="Languages" Type="String" />
              <asp:Parameter Name="Databases" Type="String" />
              <asp:Parameter Name="Tools" Type="String" />
              <asp:Parameter Name="Networking" Type="String" />
              <asp:Parameter Name="Operating_Systems" Type="String" />
              <asp:Parameter Name="Employee_ID" Type="Int32" />
            </UpdateParameters>
            <InsertParameters>
              <asp:Parameter Name="Employee_ID" Type="Int32" />
              <asp:Parameter Name="Languages" Type="String" />
              <asp:Parameter Name="Databases" Type="String" />
              <asp:Parameter Name="Tools" Type="String" />
              <asp:Parameter Name="Networking" Type="String" />
              <asp:Parameter Name="Operating_Systems" Type="String" />
            </InsertParameters>
          </asp:SqlDataSource> 
          
          
           </asp:Content>
