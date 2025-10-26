<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Professional_Courses_view, App_Web_ah1wcbj4" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>


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
          CssClass="Grid_1" DataKeyNames="Professional_Course_ID" DataSourceID="SqlDataSource1"
           Width="100%">
          <RowStyle CssClass="GridItem" />
          <Fields>
              <asp:BoundField DataField="Professional_Course" HeaderText="Professional Course"
                  SortExpression="Professional_Course" />
              <asp:BoundField DataField="Institute" HeaderText="Institute" SortExpression="Institute" />
              <asp:BoundField DataField="Awarding_Body" HeaderText="Awarding Body" SortExpression="Awarding_Body" />
              <asp:BoundField DataField="Duration" HeaderText="Duration" SortExpression="Duration" />
              <asp:BoundField DataField="Passing_Year" HeaderText="Passing Year" SortExpression="Passing_Year" />
              <asp:TemplateField HeaderText="Detail" SortExpression="Detail">
                  <EditItemTemplate>
                      <asp:TextBox ID="TextBox1" runat="server" Height="56px" Text='<%# Bind("Detail") %>'
                          TextMode="MultiLine" Width="213px"></asp:TextBox>
                  </EditItemTemplate>
                  <InsertItemTemplate>
                      <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Detail") %>'></asp:TextBox>
                  </InsertItemTemplate>
                  <ItemTemplate>
                      <asp:Label ID="Label1" runat="server" Text='<%# Bind("Detail") %>'></asp:Label>
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
            DeleteCommand="DELETE FROM [Professional_Courses] WHERE [Employee_ID] = @Employee_ID AND [Professional_Course_ID] = @Professional_Course_ID"
            InsertCommand="INSERT INTO [Professional_Courses] ([Employee_ID], [Professional_Course], [Institute], [Awarding_Body], [Duration], [Passing_Year],[Detail]) VALUES (@Employee_ID, @Professional_Course, @Institute, @Awarding_Body, @Duration, @Passing_Year,@Detail)"
            SelectCommand="SELECT [Employee_ID], [Professional_Course_ID], [Professional_Course], [Institute], [Awarding_Body], [Duration], [Passing_Year],[Detail] FROM [Professional_Courses] where Employee_ID=@emp and Professional_Course_ID = @Professional_Course_ID"
            UpdateCommand="UPDATE [Professional_Courses] SET [Professional_Course] = @Professional_Course, [Institute] = @Institute, [Awarding_Body] = @Awarding_Body, [Duration] = @Duration, [Passing_Year] = @Passing_Year,[Detail]=@Detail WHERE [Professional_Course_ID] = @Professional_Course_ID">
            <DeleteParameters>
              <asp:Parameter Name="Employee_ID" Type="Int32" />
              <asp:Parameter Name="Professional_Course_ID" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
              <asp:Parameter Name="Professional_Course" Type="String" />
              <asp:Parameter Name="Institute" Type="String" />
              <asp:Parameter Name="Awarding_Body" Type="String" />
              <asp:Parameter Name="Duration" Type="String" />
              <asp:Parameter Name="Passing_Year" Type="String" />
                <asp:Parameter Name="Detail" />
              <asp:Parameter Name="Professional_Course_ID" Type="Int32" />
            </UpdateParameters>
            <SelectParameters>
                <asp:QueryStringParameter Name="emp" QueryStringField="Employee_ID" />
                <asp:QueryStringParameter Name="Professional_Course_ID" QueryStringField="Professional_Course_ID" />
            </SelectParameters>
            <InsertParameters>
              <asp:SessionParameter Name="Employee_ID" SessionField="Enter_emp_ID" Type="Int32" />
              <asp:ControlParameter ControlID="TextBox_Professional_Course" Name="Professional_Course"
                    PropertyName="Text" Type="String" />
              <asp:ControlParameter ControlID="TextBox_Institute" Name="Institute" PropertyName="Text"
                    Type="String" />
              <asp:ControlParameter ControlID="TextBox_Awarding_Body" Name="Awarding_Body" PropertyName="Text"
                    Type="String" />
              <asp:ControlParameter ControlID="TextBox_Duration" Name="Duration" PropertyName="Text"
                    Type="String" />
              <asp:ControlParameter ControlID="TextBox_Passing_Year" Name="Passing_Year" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_Detail" Name="Detail" PropertyName="Text" />
            </InsertParameters>
          </asp:SqlDataSource>
          
               
     
</td>
</tr>
</table>

          
  </asp:Content>