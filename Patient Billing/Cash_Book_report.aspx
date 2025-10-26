<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Cash_Book_report.aspx.vb"  MasterPageFile="~/hacims_masterpage_admin.master" Inherits="Omer_Reports_Cash_Book_report" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <script type ="text/javascript">

       var gAutoPrint = true; // Flag for whether or not to automatically call the print function 
       function printSpecial() {
           if (document.getElementById != null) {
//               if (document.getElementById("btn_print").value = "close") {
//                   window.close();
//               } else {
//                   document.getElementById("btn_print").value = "close";
//               }

               var html = '<HTML>\n<HEAD>\n';
               if (document.getElementsByTagName != null) {                   var headTags = document.getElementsByTagName("head");
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
               
//               printWin.setTimeout("window.close()", 1000);
//               if (navigator.appName != "Microsoft Internet Explorer") {
                   document.body.innerHTML = originalContents;
//               }
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
      
    
      <div class="rpt_pos"  > 
      <table width = "100%">
            <tr>
            <td align="right">
                    <asp:Label ID="Lblselctemp" runat="server" Text="<b>Select Employee : </b>"></asp:Label>
                </td>

                <td align="center"> <asp:Label ID="lblEmployee" runat="server" Text="" ></asp:Label></td>

            <td>
            <asp:DropDownList ID="DDL_Employee" runat="server" DataSourceID="SDS_Employee" 
                DataTextField="NAME" DataValueField="EmpID" AutoPostBack="True" >
            </asp:DropDownList>
                
            <asp:SqlDataSource ID="SDS_Employee" runat="server" 
                ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>" 
                SelectCommand="SELECT     ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS NAME, Employee.EmpID
FROM         Employee INNER JOIN
                      Receptionist ON Employee.EmpID = Receptionist.Receptionist_id
WHERE     (Employee.ActiveStatus = 1)
order by NAME ">
                <SelectParameters>
                  
                </SelectParameters>
            </asp:SqlDataSource>
            </td>
            </tr>

            <tr>
            <td align = "right">
                &nbsp;</td>
            <td>
                &nbsp;</td>
            </tr>

            <tr>
            <td align = "right">
                &nbsp;</td>
            <td>
                &nbsp;</td>
            </tr>

      </table>
       </div>

      <div class="rpt_pos" id="grdvisiblefalse" runat="server">
   
         <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" ShowToolBar="true" Height="650px">
</rsweb:ReportViewer>
         </div>
     </asp:Content>