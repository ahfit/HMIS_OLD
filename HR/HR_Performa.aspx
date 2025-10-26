<%@ page language="C#" autoeventwireup="true" inherits="HR_HR_Performa, App_Web_5t2nflla" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
    <%@ Register assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="CR" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
 <script type="text/javascript">

     var gAutoPrint = true; // Flag for whether or not to automatically call the print function 
     function printSpecial() {
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

             var printReadyElem = document.getElementById("PrintDiv");
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
             document.body.innerHTML = originaldocument;
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

</head>

<body>
 
    <form id="form1" runat="server">
<input type="button" value="Print" onclick="printSpecial()" id="btn_print" autofocus="autofocus"
        onload="Set_focus()"><asp:CheckBox ID="CheckBox1" runat="server" 
        AutoPostBack="True" Text="Export" 
        oncheckedchanged="CheckBox1_CheckedChanged" />   
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
      
      <div id="PrintDiv">
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" 
            ShowToolBar="False" Height="1200px">
        </rsweb:ReportViewer></div>
        <br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>" 
            SelectCommand="usp_Employee_ACR" CancelSelectOnNullParameter="False" 
            SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:QueryStringParameter Name="EmpID" QueryStringField="empid" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    
    </form>
    
</body>
</html>
