<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Change_Password1, App_Web_2qu1gl2y" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="bxmain">
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td width="40%" align="right">User Login :</td>
    <td width="60%"><asp:Label  ID="Label_user_name" runat="server"  ></asp:Label></td>
  </tr>
  <tr>
    <td align="right">Old Password :</td>
    <td><asp:TextBox ID="TextBox_old_passward" runat="server"    TextMode="Password"></asp:TextBox>
      <asp:RequiredFieldValidator ID="RequiredFieldValidator_old_passward" runat="server"
          ControlToValidate="TextBox_old_passward" ErrorMessage="*"></asp:RequiredFieldValidator></td>
  </tr>
  <tr>
    <td align="right">New Password :</td>
    <td><asp:TextBox ID="TextBox_new_passward" runat="server"     TextMode="Password"></asp:TextBox>
      <asp:RequiredFieldValidator ID="RequiredFieldValidator_new_passward" runat="server"
        ControlToValidate="TextBox_new_passward" ErrorMessage="*"></asp:RequiredFieldValidator></td>
  </tr>
  <tr>
    <td align="right">Confirm Password:</td>
    <td><asp:TextBox ID="TextBox_confirm_new_passward" runat="server"     TextMode="Password"></asp:TextBox>
      <asp:RequiredFieldValidator ID="RequiredFieldValidator_confirm_passward" runat="server"
        ControlToValidate="TextBox_confirm_new_passward" ErrorMessage="*"></asp:RequiredFieldValidator></td>
  </tr>
  <tr>
    <td></td>
    <td><asp:Button   ID="Button_Change_Password" runat="server" Text="Save"  /></td>
  </tr>
</table></div>

             
              <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
            DeleteCommand="DELETE FROM [Employee_Basic_info] WHERE [Employee_ID] = @Employee_ID"
            InsertCommand="INSERT INTO [Employee_Basic_info] ([Password]) VALUES (@Password)"
            SelectCommand="SELECT [Employee_ID], [Password] FROM [Employee_Basic_info]" UpdateCommand="UPDATE [Employee_Basic_info] SET [Password] = @Password WHERE [Employee_ID] = @Employee_ID">
                <DeleteParameters>
                  <asp:Parameter Name="Employee_ID" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                  <asp:SessionParameter Name="Employee_ID" SessionField="emp_ID" Type="Int32" />
                    <asp:ControlParameter ControlID="TextBox_new_passward" Name="Password" PropertyName="Text" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:Parameter Name="Password" />
                </InsertParameters>
              </asp:SqlDataSource>
          

          
          
          
          
          

        
 </asp:Content>