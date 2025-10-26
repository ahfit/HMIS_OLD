<%@ Page Title="" Language="VB" AutoEventWireup="false" CodeFile="Consumed_Medicine_Report.aspx.vb" Inherits="Pharmacy_Consumed_Medicine_Report" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

   <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>
</title>


<script type ="text/javascript">

    function printDiv(divName) {
        var printContents = document.getElementById(divName).innerHTML;
        var originalContents = document.body.innerHTML;

        document.body.innerHTML = printContents;

        window.print();

        document.body.innerHTML = originalContents;
    }
  
    </script>
   
</head>
<body>
<form runat="server">
  <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
 <input type="button" value="Print" onclick="printDiv('PrintableDiv')" id="btn_print" autofocus="autofocus"
        onload="Set_focus()"/>
    
  
    <div id="PrintableDiv" class="Report_width">
    
    
   <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="98%" ShowToolBar="false" Height="870px" Visible="false" >
         
    </rsweb:ReportViewer>
    
    </div>
    <asp:HiddenField ID="HF_Consumption_ID" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" 
    SelectCommandType="StoredProcedure" SelectCommand="Select_WI_Patient_Slip" 
    CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:QueryStringParameter Name="Consumption_ID" QueryStringField="C_ID" 
                Type="Int32" />
        </SelectParameters>
</asp:SqlDataSource>
</form>
</body>
</html>

