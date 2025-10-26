<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Patient_Result_Report.aspx.vb" Inherits="Pathology_Patient_Result_Report_HTML" %>

<%--<%@ Register assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="cr" %>--%>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="cr" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">

        var gAutoPrint = true; // Flag for whether or not to automatically call the print function 
        function printSpecial() {
//            alert("Start");
            if (document.getElementById != null) {
                if (document.getElementById("btn_print").value = "close") {
                    window.close();
                } else {
                    document.getElementById("btn_print").value = "close";
                }

                var html = '<HTML>\n<HEAD>\n';
                if (document.getElementsByTagName != null) {
                    var headTags = document.getElementsByTagName("head");
                    if (headTags.length > 0) html += headTags[0].innerHTML;

                }

//                alert(html); 
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
                //printWin.setTimeout("window.close()", 20000);
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
            else
             {
                alert("Sorry, the print ready feature is only available in modern browsers.");
            }

            printWin.close();
        }

        function Set_focus() {
            document.getElementById("btn_print").focus();
        }
    </script>
     <script type="text/javascript">
         function PrintReport() {
             var dvReport = document.getElementById("PrintDiv");
             var frame1 = dvReport.getElementsByTagName("iframe")[0];
             if (navigator.appName.indexOf("Internet Explorer") != -1) {
                 frame1.name = frame1.id;
                 window.frames[frame1.id].focus();
                 window.frames[frame1.id].print();
             }
             else {
                 var frameDoc = frame1.contentWindow ? frame1.contentWindow : frame1.contentDocument.document ? frame1.contentDocument.document : frame1.contentDocument;
                 frameDoc.print();
             }
         }
</script>
</head>
<body>
    <form id="form1" runat="server">
      <div style="text-align:center;padding:5px;">
           <input type="button" class="btn_hacims" value="Print" onclick="PrintReport()" id="btn_print" autofocus="autofocus"
        onload="Set_focus()" />
          </div>

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
  
    <br />
    <div>
     <table style="width: 924px">
           <tr>
               <td style="width: 100px">
                   &nbsp;</td>
               <td style="width: 114px">
                   <asp:DropDownList ID="DropDownList_Report_Type" runat="server" AutoPostBack="True"
                       Width="140px" Visible="false">
                       <asp:ListItem>Original</asp:ListItem>
                       <asp:ListItem>Duplicate</asp:ListItem>
                   </asp:DropDownList></td>
               <td style="width: 71px" align="right">
                   
                   <asp:Label ID="Label_TB" runat="server" Text="Test /Profiles" Width="168px" ></asp:Label>&nbsp; </td>
               <td style="width: 89px">
                   <asp:DropDownList ID="DropDownList_TB_ID" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_TB_ID" OnSelectedIndexChanged="DropDownList_TB_ID_SelectedIndexChanged"
                       DataTextField="TB_Name" DataValueField="TB_ID" Width="178px"  >
                   </asp:DropDownList>
                   <asp:SqlDataSource ID="SqlDataSource_TB_ID" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
                       SelectCommand="SELECT DISTINCT Test_Booking.TB_Name, Test_Booking.TB_ID FROM Test_Booking_Services INNER JOIN Test_Booking ON Test_Booking_Services.TB_ID = Test_Booking.TB_ID INNER JOIN Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID WHERE (Path_Result_Delivery.Reg_no = @RegNo) AND (Path_Result_Delivery.Yearly_No = @YearlyNo) AND (Path_Result_Delivery.Main_ID = @Main_ID) AND (Test_Booking_Services.Status = @Status)">
                       <SelectParameters>
                           <asp:QueryStringParameter Name="RegNo" QueryStringField="RegNo" />
                           <asp:QueryStringParameter Name="YearlyNo" QueryStringField="YearlyNo" />
                           <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" />
                           <asp:QueryStringParameter Name="Status" QueryStringField="Status" />
                       </SelectParameters>
                   </asp:SqlDataSource>
               </td>
           </tr>
           <tr>
               <td style="width: 100px">
               </td>
               <td style="width: 114px">
               </td>
               <td style="width: 71px" align="right">
                   <asp:Label ID="Label_TB0" runat="server" Text="Report Grouping :" Width="168px" ></asp:Label>
                   <br />
               </td>
               <td style="width: 89px">
                   <asp:RadioButtonList ID="RBL_group" runat="server" AutoPostBack="True" 
                       RepeatDirection="Horizontal" >
                       <asp:ListItem Value="1"  >Group</asp:ListItem>
                       <asp:ListItem Value="0" Selected="True" >Single</asp:ListItem>
                   </asp:RadioButtonList>
               </td>
           </tr>
           <tr>
               <td style="width: 100px">
                   &nbsp;</td>
               <td style="width: 114px">
                   &nbsp;</td>
               <td style="width: 71px">
                   &nbsp;</td>
               <td style="width: 89px">
                   &nbsp;</td>
           </tr>
       </table>
       &nbsp;<asp:DropDownList ID="DropDownList_rpt_type" runat="server" AutoPostBack="True" Width="192px" Visible="False">
                       <asp:ListItem>Group Wise</asp:ListItem>
                       <asp:ListItem>Sub Group Wise</asp:ListItem>
                       <asp:ListItem>Service Wise</asp:ListItem>
                       <asp:ListItem Value="SGSW">Sub Group Service Wise</asp:ListItem>
                       <asp:ListItem Value="All Services">All Services</asp:ListItem>
                   </asp:DropDownList><br />
       <asp:Label ID="Label_error" runat="server"></asp:Label>
    <div id="PrintDiv">
<cr:crystalreportviewer id="CrystalReportViewer1" runat="server" autodatabind="true"
            ></cr:crystalreportviewer>
           </div>
    </div>
         <div style="width: 100%; margin-top:20px;">
       
       <rsweb:ReportViewer ID="ReportViewer1"  runat="server" Width="100%"  >
        </rsweb:ReportViewer>
    </div>
         <asp:HiddenField ID="hdnTGId" runat="server" Value="0" />
    </form>
</body>
</html>
