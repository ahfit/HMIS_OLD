<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Patient_Result_Report.aspx.vb" Inherits="Patient_Result_Report" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
 
 
<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
<link href="css/css_reset.css" 	  rel="stylesheet" type="text/css" media="screen, projection"/>
<link href="css/css_elements.css" rel="stylesheet" type="text/css" media="screen, projection"/>
<!--[if IE]><link rel="stylesheet" href="css/css_ie.css" type="text/css" media="screen, projection"><![endif]-->
<link href="css/dropdown/dropdown.css" media="all" rel="stylesheet" type="text/css" />
<link href="css/dropdown/default.advanced.css" media="all" rel="stylesheet" type="text/css" />

<!--[if lt IE 7]>
<script type="text/javascript" src="css/js/jquery/jquery.js"></script>
<script type="text/javascript" src="css/js/jquery/jquery.dropdown.js"></script>
<![endif]-->
    
    
    
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div style="text-align: left">
        <table>
            <tr>
                <td colspan="3" style="width: 562px; height: 34px">
                
                
                
                
                </td>
            </tr>
        </table>
        <br />
        <cr:crystalreportviewer id="CrystalReportViewer1" runat="server" autodatabind="true" ToolPanelView="None" HasCrystalLogo="False" HasDrillUpButton="False" HasExportButton="False" HasGotoPageButton="False" HasSearchButton="False" HasToggleGroupTreeButton="False"  HasZoomFactorList="False" PrintMode="ActiveX"></cr:crystalreportviewer>
    
    </div>
    </form>
</body>
</html>
