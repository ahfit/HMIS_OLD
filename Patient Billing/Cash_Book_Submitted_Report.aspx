<%@ Page Language="VB" AutoEventWireup="false" CodeFile="~/Patient Billing/Cash_Book_Submitted_Report.aspx.vb"  MasterPageFile="~/hacims_masterpage_admin.master" Inherits="Cash_Book_S_report" %>

<%@ Register assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="cr" %>

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

      <div class="rpt_pos"> 
      <table width = "100%">
            <tr>
            <td align = "right">
                Employee Name:
            </td>
            <td>
            <asp:DropDownList ID="DDL_Employee" runat="server" DataSourceID="SDS_Employee" 
                DataTextField="NAME" DataValueField="EmpID" AutoPostBack="True" >
            </asp:DropDownList>
                
            <asp:SqlDataSource ID="SDS_Employee" runat="server" 
                ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>" 
                SelectCommand=" SELECT isnull(EFName,'')+ ' '+ISnull(EMName,'')+' '+IsNULL( ELName,'') AS NAME , EmpID FROM eMployee WHERE empid in (select Receptionist_id from Receptionist)
 AND (ActiveStatus = 1)">
            </asp:SqlDataSource>
                <br />
                <asp:SqlDataSource ID="SDS_report" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
                    ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>" 
                    SelectCommand="Cash_Submitted_Report" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="Date" QueryStringField="DT" Type="DateTime" />
                        <asp:QueryStringParameter Name="Hos_ID" QueryStringField="Hid" Type="Int32" />
                        <asp:QueryStringParameter Name="shift_ID" QueryStringField="ShID" 
                            Type="Int32" />
                        <asp:QueryStringParameter Name="subdept_id" QueryStringField="SDID" 
                            Type="Int32" />
                        <asp:QueryStringParameter Name="emp_id" QueryStringField="EID" Type="Int32" />
                        <asp:QueryStringParameter DefaultValue="0" Name="vid" QueryStringField="VID" 
                            Type="Int32" />
                        <asp:Parameter Name="Edate" Type="DateTime" />
                        <asp:QueryStringParameter Name="rec_amt_ID" QueryStringField="PID" 
                            Type="Int32" />
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
<div id="PrintDiv">
<cr:crystalreportviewer id="CrystalReportViewer1" runat="server" autodatabind="true" 
           DisplayGroupTree="False" HasCrystalLogo="False" HasSearchButton="False" 
           HasToggleGroupTreeButton="False" HasViewList="False" HasZoomFactorList="False" 
           PrintMode="ActiveX" ShowAllPageIds="True" EnableDatabaseLogonPrompt="False" 
            EnableParameterPrompt="False" DisplayToolbar="true" 
            ></cr:crystalreportviewer>
           </div>
    
     </asp:Content>