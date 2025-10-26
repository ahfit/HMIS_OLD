<%@ page language="VB" autoeventwireup="false" inherits="Calendar, App_Web_04yytuax" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register TagPrefix="uc" TagName="Calendar1" 
    Src="CalendarControls.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <uc:Calendar1 id="Calendar1" 
        runat="server" 
        />

    
    
    </div>
    </form>
</body>
</html>
