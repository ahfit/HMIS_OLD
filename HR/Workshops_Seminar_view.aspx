<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Workshops_Seminar_view, App_Web_ah1wcbj4" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

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
      DataSourceID="SqlDataSource1" Width="100%" CssClass="Grid_1" DataKeyNames="Employee_ID,Workshop_Seminar_ID">
      <Fields>
          <asp:BoundField DataField="Workshop_Seminar" HeaderText="Workshop Seminar" SortExpression="Workshop_Seminar" />
          <asp:BoundField DataField="Venue" HeaderText="Venue" SortExpression="Venue" />
          <asp:TemplateField HeaderText="Date" SortExpression="Date">
              <EditItemTemplate>
                  <asp:TextBox ID="TextBox2" runat="server" Text='<%# Eval("Date") %>'></asp:TextBox>
              </EditItemTemplate>
              <InsertItemTemplate>
                  <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Date") %>'></asp:TextBox>
              </InsertItemTemplate>
              <ItemTemplate>
                  <asp:Label ID="Label2" runat="server" Text='<%# Bind("Date") %>'></asp:Label>
              </ItemTemplate>
          </asp:TemplateField>
          <asp:BoundField DataField="Duration_in_Days" HeaderText="Duration in Days" SortExpression="Duration_in_Days" />
          <asp:BoundField DataField="Organized_By" HeaderText="Organized By" SortExpression="Organized_By" />
          <asp:TemplateField HeaderText="Detail" SortExpression="Description">
              <EditItemTemplate>
                  <asp:TextBox ID="TextBox1" runat="server" Height="96px" Text='<%# Bind("Description") %>'
                      TextMode="MultiLine" Width="238px"></asp:TextBox>
              </EditItemTemplate>
              <InsertItemTemplate>
                  <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Description") %>'></asp:TextBox>
              </InsertItemTemplate>
              <ItemTemplate>
                  <asp:Label ID="Label1" runat="server" Text='<%# Bind("Description") %>'></asp:Label>
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
    <RowStyle CssClass="GridItem" />
    <AlternatingRowStyle CssClass="GridAltItem" />
  </asp:DetailsView>
   
      <asp:HiddenField ID="HiddenField_date" runat="server" />
              <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
            DeleteCommand="DELETE FROM [Workshops_Seminar] WHERE [Employee_ID] = @Employee_ID AND [Workshop_Seminar_ID] = @Workshop_Seminar_ID"
            InsertCommand="INSERT INTO [Workshops_Seminar] ([Employee_ID],  [Workshop_Seminar], [Venue], [Date], [Duration_in_Days], [Organized_By], [Description]) VALUES (@Employee_ID,  @Workshop_Seminar, @Venue, @Date, @Duration_in_Days, @Organized_By, @Description)"
            SelectCommand="SELECT [Employee_ID], [Workshop_Seminar_ID], [Workshop_Seminar], [Venue],convert(varchar, [Date],103) as [Date], [Duration_in_Days], [Organized_By], [Description] FROM [Workshops_Seminar] where Employee_ID=@emp and Workshop_Seminar_ID=@Workshop_Seminar_ID"
            UpdateCommand="UPDATE [Workshops_Seminar] SET [Workshop_Seminar] = @Workshop_Seminar, [Venue] = @Venue, [Date] = @Date, [Duration_in_Days] = @Duration_in_Days, [Organized_By] = @Organized_By, [Description] = @Description WHERE [Employee_ID] = @Employee_ID AND [Workshop_Seminar_ID] = @Workshop_Seminar_ID">
            <DeleteParameters>
              <asp:Parameter Name="Employee_ID" Type="Int32" />
              <asp:Parameter Name="Workshop_Seminar_ID" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
              <asp:Parameter Name="Workshop_Seminar" Type="String" />
              <asp:Parameter Name="Venue" Type="String" />
                <asp:ControlParameter ControlID="HiddenField_date" Name="Date" PropertyName="Value"
                    Type="DateTime" />
              <asp:Parameter Name="Duration_in_Days" Type="Int32" />
              <asp:Parameter Name="Organized_By" Type="String" />
              <asp:Parameter Name="Description" Type="String" />
              <asp:Parameter Name="Employee_ID" Type="Int32" />
              <asp:Parameter Name="Workshop_Seminar_ID" Type="Int32" />
            </UpdateParameters>
            <SelectParameters>
              <asp:SessionParameter Name="emp" SessionField="Enter_emp_ID" />
                <asp:QueryStringParameter Name="Workshop_Seminar_ID" QueryStringField="Workshop_Seminar_ID" />
            </SelectParameters>
            <InsertParameters>
              <asp:SessionParameter Name="Employee_ID" SessionField="Enter_emp_ID" Type="Int32" />
              <asp:ControlParameter ControlID="TextBox_workshop_Seminar" Name="Workshop_Seminar"
                    PropertyName="Text" Type="String" />
              <asp:ControlParameter ControlID="TextBox_venue" Name="Venue" PropertyName="Text"
                    Type="String" />
              <asp:ControlParameter ControlID="HiddenField_date" Name="Date" PropertyName="Value"
                    Type="DateTime" />
              <asp:ControlParameter ControlID="TextBox_duration_in_days" Name="Duration_in_Days"
                    PropertyName="Text" Type="Int32" />
              <asp:ControlParameter ControlID="TextBox_organized_BY" Name="Organized_By" PropertyName="Text"
                    Type="String" />
              <asp:ControlParameter ControlID="TextBox_Description" Name="Description" PropertyName="Text"
                    Type="String" />
            </InsertParameters>
          </asp:SqlDataSource>
     
     
</td>
</tr>
</table>

  </asp:Content>