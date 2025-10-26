<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Additional_Info_edit, App_Web_ybbpntbq" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<table width="100%" border="0" cellspacing="0" cellpadding="0" >
<tr>
<td class="leftnav" valign="top" >
<asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
<asp:Panel ID="Panel1" runat="server" Visible="False"></asp:Panel>
</td>
<td  style="width:auto;" valign="top" >
     
     


 <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False"
      CssClass="Grid_1" DataKeyNames="Employee_ID" DataSourceID="SqlDataSource1"
      Width="100%">
      <Fields>
          <asp:TemplateField HeaderText="Objective" SortExpression="Objective">
              <EditItemTemplate>
                  <asp:TextBox ID="TextBox1" runat="server" Height="56px" Text='<%# Bind("Objective") %>'
                      TextMode="MultiLine" Width="211px"></asp:TextBox>
              </EditItemTemplate>
              <InsertItemTemplate>
                  <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Objective") %>'></asp:TextBox>
              </InsertItemTemplate>
              <ItemTemplate>
                  <asp:Label ID="Label1" runat="server" Text='<%# Bind("Objective") %>'></asp:Label>
              </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Language" SortExpression="Language">
              <EditItemTemplate>
                  <asp:TextBox ID="TextBox2" runat="server" Height="75px" Text='<%# Bind("Language") %>'
                      TextMode="MultiLine" Width="215px"></asp:TextBox>
              </EditItemTemplate>
              <InsertItemTemplate>
                  <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Language") %>'></asp:TextBox>
              </InsertItemTemplate>
              <ItemTemplate>
                  <asp:Label ID="Label2" runat="server" Text='<%# Bind("Language") %>'></asp:Label>
              </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Strengths" SortExpression="Strengths">
              <EditItemTemplate>
                  <asp:TextBox ID="TextBox3" runat="server" Height="66px" Text='<%# Bind("Strengths") %>'
                      TextMode="MultiLine" Width="218px"></asp:TextBox>
              </EditItemTemplate>
              <InsertItemTemplate>
                  <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Strengths") %>'></asp:TextBox>
              </InsertItemTemplate>
              <ItemTemplate>
                  <asp:Label ID="Label3" runat="server" Text='<%# Bind("Strengths") %>'></asp:Label>
              </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Awards" SortExpression="Awards">
              <EditItemTemplate>
                  <asp:TextBox ID="TextBox4" runat="server" Height="67px" Text='<%# Bind("Awards") %>'
                      TextMode="MultiLine" Width="217px"></asp:TextBox>
              </EditItemTemplate>
              <InsertItemTemplate>
                  <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Awards") %>'></asp:TextBox>
              </InsertItemTemplate>
              <ItemTemplate>
                  <asp:Label ID="Label4" runat="server" Text='<%# Bind("Awards") %>'></asp:Label>
              </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Hobbies" SortExpression="Hobbies">
              <EditItemTemplate>
                  <asp:TextBox ID="TextBox5" runat="server" Height="77px" Text='<%# Bind("Hobbies") %>'
                      TextMode="MultiLine" Width="218px"></asp:TextBox>
              </EditItemTemplate>
              <InsertItemTemplate>
                  <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("Hobbies") %>'></asp:TextBox>
              </InsertItemTemplate>
              <ItemTemplate>
                  <asp:Label ID="Label5" runat="server" Text='<%# Bind("Hobbies") %>'></asp:Label>
              </ItemTemplate>
          </asp:TemplateField>
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
      <AlternatingRowStyle CssClass="GridAltItem" />
  </asp:DetailsView>
      <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
          DeleteCommand="DELETE FROM [Additional_Info] WHERE [Employee_ID] = @Employee_ID"
          InsertCommand="INSERT INTO [Additional_Info] ([Employee_ID], [Objective], [Language], [Strengths], [Awards], [Hobbies], [Expected_Salary]) VALUES (@Employee_ID, @Objective, @Language, @Strengths, @Awards, @Hobbies)"
          SelectCommand="SELECT [Employee_ID], [Objective], [Language], [Strengths], [Awards], [Hobbies] FROM [Additional_Info] WHERE ([Employee_ID] = @Employee_ID)"
          UpdateCommand="UPDATE [Additional_Info] SET [Objective] = @Objective, [Language] = @Language, [Strengths] = @Strengths, [Awards] = @Awards, [Hobbies] = @Hobbies WHERE [Employee_ID] = @Employee_ID">
          <DeleteParameters>
              <asp:Parameter Name="Employee_ID" Type="Int32" />
          </DeleteParameters>
          <UpdateParameters>
              <asp:Parameter Name="Objective" Type="String" />
              <asp:Parameter Name="Language" Type="String" />
              <asp:Parameter Name="Strengths" Type="String" />
              <asp:Parameter Name="Awards" Type="String" />
              <asp:Parameter Name="Hobbies" Type="String" />
              <asp:Parameter Name="Employee_ID" Type="Int32" />
          </UpdateParameters>
          <InsertParameters>
              <asp:Parameter Name="Employee_ID" Type="Int32" />
              <asp:Parameter Name="Objective" Type="String" />
              <asp:Parameter Name="Language" Type="String" />
              <asp:Parameter Name="Strengths" Type="String" />
              <asp:Parameter Name="Awards" Type="String" />
              <asp:Parameter Name="Hobbies" Type="String" />
          </InsertParameters>
          <SelectParameters>
              <asp:SessionParameter Name="Employee_ID" SessionField="Enter_emp_ID" Type="Int32" />
          </SelectParameters>
      </asp:SqlDataSource>
           
</td>
</tr>
</table><asp:Label ID="LabelFooter" runat="server" Text="Label"></asp:Label>
      
       </asp:Content>
          