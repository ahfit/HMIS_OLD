<%@ page language="VB" autoeventwireup="false" inherits="ptXrayView, App_Web_rbfdm1yf" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
</head>
<body >
    <form id="form1" runat="server">
    <div>
        <asp:Label ID="Label_message" runat="server" ></asp:Label>
        <asp:Image ID="ImageXray" runat="server" />&nbsp;</div>
        <table>
            <tr>
                <td style="width: 202px; height: 224px;">
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Xray Description :
                </td>
                <td style="width: 390px; height: 224px;">
                    <asp:TextBox ID="TextBoxXrayDescription" runat="server" Height="214px" Rows="10" TextMode="MultiLine"
                        Width="406px"></asp:TextBox></td>
            </tr>
        </table>
        &nbsp; &nbsp;
    </form>
</body>
</html>
