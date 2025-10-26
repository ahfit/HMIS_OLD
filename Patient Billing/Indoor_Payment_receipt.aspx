<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Omer_Reports_Indoor_Payment_receipt, App_Web_gswfk1g0" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="cr" %>

<%--<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>--%>

<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
 <script type="text/javascript">

     var gAutoPrint = true; // Flag for whether or not to automatically call the print function 
     function printSpecial() {
         if (document.getElementById("btn_print").value = "close") {
             window.close();
         } else {
             document.getElementById("btn_print").value = "close";
         }
         if (document.getElementById != null) {
             var html = '<HTML>\n<HEAD>\n';
             if (document.getElementsByTagName != null) {
                 var headTags = document.getElementsByTagName("head");
                 if (headTags.length > 0) html += headTags[0].innerHTML;
             }
             if (gAutoPrint) {
                 if (navigator.appName == "Microsoft Internet Explorer") {
                     html += '\n</HEAD>\n<'
                     html += 'BODY onLoad="PrintCommandObject.ExecWB(6, -1);">\n';
                 }
                 else {
                     html += '\n</HEAD>\n<BODY>\n';
                 }
             }
             else {
                 html += '\n</HEAD>\n<BODY>\n';
             }

             var printReadyElem = document.getElementById("ctl00_ContentPlaceHolder1_CrystalReportViewer1");
             if (printReadyElem != null) {
                 html += printReadyElem.innerHTML;
             }
             else {
                 alert("Could not find the printReady section in the HTML");
                 return;
             }
             if (gAutoPrint) {
                 if (navigator.appName == "Microsoft Internet Explorer") {
                     html += '<OBJECT ID="PrintCommandObject" WIDTH=0 HEIGHT=0 '
                     html += 'CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT >\n</BODY>\n</HTML>';
                 }
                 else {
                     html += '\n</BODY>\n</HTML>';
                 }
             }
             else {
                 html += '\n</BODY>\n</HTML>';
             }
             var printWin = window.open("", "printSpecial");
             printWin.document.open();
             printWin.document.write(html);
             printWin.setTimeout("window.close()", 9000);
             if (navigator.appName != "Microsoft Internet Explorer") {
                 document.body.innerHTML = originalContents;
             }
             printWin.document.close();
             if (gAutoPrint) {
                 if (navigator.appName != "Microsoft Internet Explorer") {

                     printWin.print();
                 }
             }
         }
         else {
             alert("Sorry, the print ready feature is only available in modern browsers.");
         }
         printWin.close();
     }

     function Set_focus() {
         document.getElementById("btn_print").focus();
     }
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<%--<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">--%>
    <input type="button" value="Print" onclick="printSpecial()" id="btn_print" autofocus="autofocus"
        onload="Set_focus()">
    <div id="PrintDiv">
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true"/>
        <br />
        <br />
        
    </div>

    </asp:Content>
   <%-- </form>
</body>
</html>--%>
