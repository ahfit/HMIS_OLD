<%@ page language="VB" autoeventwireup="false" inherits="Doctor_Portal, App_Web_rbfdm1yf" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table style="width: 921px; height: 116px">
            <tr>
                <td style="width: 100px">
                    <asp:Xml ID="Xml_Duty_Roster" runat="server" DocumentSource="~/XMLFile/DutyRoster.xml"
                        TransformSource="~/XSLFile/DutyRoster.xsl"></asp:Xml></td>
                <td style="width: 100px">
                    <asp:Xml ID="Xml1" runat="server" DocumentSource="~/XMLFile/DoctorCall.xml" TransformSource="~/XSLFile/DoctorCall.xsl"></asp:Xml></td>
                <td style="width: 100px">
                    <asp:Xml ID="Xml2" runat="server" DocumentSource="~/XMLFile/RadiologyOrder.xml" TransformSource="~/XSLFile/RadiologyOrder.xsl"></asp:Xml></td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
