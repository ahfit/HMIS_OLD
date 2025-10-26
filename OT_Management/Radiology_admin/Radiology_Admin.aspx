<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Radiology_Admin.aspx.vb" Inherits="Administrator_Radiology_Admin" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="Paragma" content="no-cache"/>

<link href="../../images/sheet_blue.css" rel="stylesheet" type="text/css" />
<link href="../../images/sheet_form.css" rel="stylesheet" type="text/css" />
<script src="../../images/highlight.js" type="text/javascript"></script>
<style type="text/css">
body {
	background-image:none;
	margin-top:0px;
}
html {
	background-image:none;
}
</style>

</head>

<body >

<form id="form1" runat = "server">
  <div id="forms_items" class="forms_items"> 
<table width="100%" border="0" cellpadding="0" cellspacing="0">
              <!--DWLayoutTable-->
              <tr>
                <td width="917" height="153" valign="top"><fieldset class="field">
                  <legend class="text_heading_01">&nbsp;&nbsp;Radiology Administration&nbsp;&nbsp;</legend>
    <asp:Button ID="Button1" runat="server" Text="Main Group" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'"/>
                  
                  <asp:Button ID="Button2" runat="server" Text="Element" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'"/>
                  
                  <asp:Button ID="Button3" runat="server" Text="Element Values" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="87px"/>
                    &nbsp;<asp:Button ID="Button8" runat="server" Text="Relation" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="87px"/>&nbsp;
                    <asp:Button ID="Button6" runat="server" Text="Radiology Group" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="102px"/>
                    <asp:Button ID="Button7" runat="server" Text="Radiology Sub Group" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="122px"/>
                    &nbsp;
                    <asp:Button ID="Button4" runat="server" Text="Radiology Test" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="87px"/>&nbsp;<asp:Button ID="Button5" runat="server" Text="Xray Body Part" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="87px"/>
                    <asp:Button ID="Button9" runat="server" Text="Xray Entry" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="87px"/>
                    <asp:Button ID="Button10" runat="server" Text="Xray Projection" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="87px"/><br />
                    &nbsp;<asp:Button ID="Button11" runat="server" Text="Element Values" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="87px"/></fieldset>                        <br/></td>
                      </tr>
              
              </table>
</div>
</form>
</body>
</html>

