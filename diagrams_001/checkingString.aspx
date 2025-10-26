<%@ page language="VB" autoeventwireup="false" inherits="diagrams_001_checkingString, App_Web_lvdmlbh5" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:TextBox ID="txt_Input" runat="server" Height="92px" Width="368px"></asp:TextBox>
        <br />
        <asp:Button ID="btn_Pass_To_Grid" runat="server" Text="Pass" /><br />
        <asp:GridView ID="Grd_PAramaeter" runat="server">
        </asp:GridView>
    
    </div>
    </form>
</body>
</html>
