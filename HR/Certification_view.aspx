<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Certification_view, App_Web_2qu1gl2y" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

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
     
     

      <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CssClass="Grid_1"
          DataSourceID="SqlDataSource1"  Width="100%">
          <Fields>
              <asp:BoundField DataField="Certification_No" HeaderText="Certification No" SortExpression="Certification_No" />
              <asp:BoundField DataField="Certification" HeaderText="Certification" SortExpression="Certification" />
              <asp:BoundField DataField="Institution" HeaderText="Institution Name" SortExpression="Institution" />
              <asp:TemplateField HeaderText="Date From" SortExpression="Date_From">
                  <EditItemTemplate>
                      <asp:TextBox ID="TextBox1" runat="server" Text='<%# Eval("Date_From") %>'></asp:TextBox>
                  </EditItemTemplate>
                  <InsertItemTemplate>
                      <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Date_From") %>'></asp:TextBox>
                  </InsertItemTemplate>
                  <ItemTemplate>
                      <asp:Label ID="Label1" runat="server" Text='<%# Bind("Date_From") %>'></asp:Label>
                  </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Date To" SortExpression="Date_To">
                  <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Eval("Date_To") %>'></asp:TextBox>
                  </EditItemTemplate>
                  <InsertItemTemplate>
                      <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Date_To") %>'></asp:TextBox>
                  </InsertItemTemplate>
                  <ItemTemplate>
                      <asp:Label ID="Label2" runat="server" Text='<%# Bind("Date_To") %>'></asp:Label>
                  </ItemTemplate>
              </asp:TemplateField>
              <asp:BoundField DataField="Detail" HeaderText="Detail" SortExpression="Detail" />
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
          <HeaderStyle CssClass="GridHeader" />
          <AlternatingRowStyle CssClass="GridAltItem" />
      </asp:DetailsView>
  
  
  

      <asp:HiddenField ID="HiddenField_fromDate" runat="server" />
      <asp:HiddenField ID="HiddenField_todate" runat="server" />
 

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
            DeleteCommand="DELETE FROM [Certification] WHERE [Employee_ID] = @Employee_ID AND [Certification_ID] = @Certification_ID"
            SelectCommand="SELECT Employee_ID, Certification_ID, Certification, CONVERT (varchar, Date_From, 103) AS Date_From, CONVERT (varchar, Date_To, 103) AS Date_To, Institution, Detail, Certification_No, validity FROM Certification WHERE (Employee_ID = @emp) AND (Certification_ID = @Certification_ID)"
            UpdateCommand="UPDATE [Certification] SET [Certification] = @Certification, [Date_From] = @Date_From, [Date_To] = @Date_To, [Institution] = @Institution, [Detail] = @Detail,[Certification_No]=@Certification_No,[validity]=@validity WHERE [Employee_ID] = @Employee_ID AND [Certification_ID] = @Certification_ID">
      <DeleteParameters>
        <asp:Parameter Name="Employee_ID" Type="Int32" />
        <asp:Parameter Name="Certification_ID" Type="Int32" />
      </DeleteParameters>
      <UpdateParameters>
        <asp:Parameter Name="Certification" />
          <asp:ControlParameter ControlID="HiddenField_fromDate" Name="Date_From" PropertyName="Value" />
          <asp:ControlParameter ControlID="HiddenField_todate" Name="Date_To" PropertyName="Value" />
        <asp:Parameter Name="Institution" />
        <asp:Parameter Name="Detail" />
          <asp:QueryStringParameter Name="Employee_ID" QueryStringField="Employee_ID" />
          <asp:QueryStringParameter Name="Certification_ID" QueryStringField="Certification_ID" />
          <asp:Parameter Name="Certification_No" />
          <asp:Parameter Name="validity" />
      </UpdateParameters>
      <SelectParameters>
          <asp:QueryStringParameter Name="emp" QueryStringField="Employee_ID" />
          <asp:QueryStringParameter Name="Certification_ID" QueryStringField="Certification_ID" />
      </SelectParameters>
    </asp:SqlDataSource>

     
</td>
</tr>
</table>

  </asp:Content>