<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="hacims_masterpage_admin.master"   CodeFile="CChangePassword.aspx.vb" Inherits="ChangePassword" %>
 
 
 
 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"> 
 </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 
 
 
 
    <asp:Label CssClass="err" ID="Label1" runat="server" ForeColor="Red"></asp:Label>
    <div class="bxmain">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form" >
        <tr>
          <td align="right" width="40%" >User Name :</td>
          <td   ><asp:Label ID="Label_user_name" runat="server" style="color:red;"></asp:Label></td>
        </tr>
       
        <tr>
          <td align="right"  >Password :</td>
          <td ><asp:TextBox ID="TextBoxOldPass" runat="server" TextMode="Password"></asp:TextBox>
          <asp:RequiredFieldValidator ControlToValidate="TextBoxPassword" 
                            Display="Dynamic" ErrorMessage="Enter Password" ID="RequiredFieldValidatorPassword" runat="server"></asp:RequiredFieldValidator></td>
        </tr>
        <tr>
          <td align="right"  >New Password :</td>
          <td ><asp:TextBox ID="TextBoxPassword" runat="server" TextMode="Password"  ></asp:TextBox>
          <asp:CompareValidator ControlToCompare="TextBoxPassword"
                            ControlToValidate="TextBoxRePassword"  Display="Dynamic" ErrorMessage="Password And Re-Enter Feilds are Not Same" ID="CompareValidatorCheckPassword" runat="server"
                           ></asp:CompareValidator></td>
        </tr>
        <tr>
          <td align="right"  >Re_Enter Password :</td>
          <td ><asp:TextBox ID="TextBoxRePassword" runat="server" TextMode="Password"></asp:TextBox>
          <asp:RequiredFieldValidator
                            ControlToValidate="TextBoxRePassword"  Display="Dynamic" ErrorMessage="Re-Enter Password" ID="RequiredFieldValidatorRePassword" runat="server"></asp:RequiredFieldValidator></td>
        </tr>
        <tr>
          <td align="right"  >&nbsp;</td>
          <td ><asp:Button ID="ButtonSave" runat="server" Text="Save"  /></td>
        </tr>
      
      
      </table>
      
    </div>
    <br />
 

 
</asp:Content>