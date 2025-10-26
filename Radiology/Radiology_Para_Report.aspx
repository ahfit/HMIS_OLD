<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Radiology_Radiology_Para_Report, App_Web_hx1j4vz4" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebHtmlEditor.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebHtmlEditor" TagPrefix="ighedit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../css_hacims/class_reset.css" rel="stylesheet" type="text/css" media="screen, projection" />
    <link href="../css_hacims/class_content.css" rel="stylesheet" type="text/css" media="screen, projection" />
    <!--[if IE]><link rel="stylesheet" href="css_hacims/content_ie.css" type="text/css" media="screen, projection"/><![endif]-->
    <link href="../css_hacims/print_report.css" rel="stylesheet" type="text/css" media="print" />
    <style type="text/css" media="all">
        body
        {
            font-family: "Segoe UI";
            background-color: #fff;
            background: none;
            background-image: none;
            position:relative;
        }
        .medication
        {
            margin-left: 0px;
            font-size: 12px;
            margin-bottom: 5px;
        }
        .medication li span
        {
            color: #333;
            padding-left: 0px;
            padding-right: 0px;
        }
        .medication li .span
        {
            color: #cccccc;
            padding-left: 10px;
            padding-right: 10px;
        }
 .report_wrap { overflow:hidden;}
.report_wrap span { display:block; font-weight:300; font-size:12px;  }
.report_wrap span b { font-weight:bold;  display:block;}
.report_wrap table tr td { vertical-align:top; }
.report_wrap span b.first { margin-top:7px;
            height: 13px;
        }
.report_wrap hr { border:1px solid #eeeeee; margin:10px 0;}
.report-footer {
	position:fixed;
	bottom:0;
	max-width: 100%;
	min-width: 100%;
	width: 210mm;
		
}
@page, @page table {
  size:8.27in 11.69in; 
margin:.5in .5in .5in .5in; 
mso-header-margin:.5in; 
mso-footer-margin:.5in; 
mso-paper-source:0;
}
@media print {
  html, body {
   
  }
  /* ... the rest of the rules ... */

        .style1
        {
            font-weight: bold;
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="96%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <div align="right" id="mprint">
                <a href="javascript:window.print()" class="print_btn">Print</a></div>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td align="left">
                                    <img src="../images_hacims/Alkhidmat.jpg" width="120px" height="120px" />
                                </td>
                                <td align="center">
                                    <ul style="list-style: none; margin-top: 0px;">
                                        <li>
                                            &nbsp;<span style="font-family:Arial;color:#000000;font-size:20pt;font-weight:700;font-style:normal;text-decoration:none;">AL-KHIDMAT RAZI HOSPITAL RAWALPINDI
                                            <br />
                                            </span>
                                        </li>
                                        <li style="line-height: 18px;">
                                            <span style="font-family:Arial;color:#000000;font-size:14pt;font-weight:400;font-style:normal;text-decoration:none;">
                                            Satellite Town Opp, Utility Markit Chandni Chok Rawalpindi</span></li>
                                        
                                         <li style="line-height: 18px;">
                                             <span style="font-family:Arial;color:#000000;font-size:9pt;font-weight:400;font-style:normal;text-decoration:none;">
                                             <br />
                                             </span>
                                        </li>
                                       
                                    </ul>
                                </td>
                                <td align="right">
                                    <img src="../images_hacims/Megaplus.jpg" width="120px" height="100px" />
                                </td>
                            </tr>
                        </table>
                </tr>
                <tr>
                        <td valign="top">
                            <table cellpadding="0" cellspacing="0" border="1" width="100%" class="Grid_1" style="margin-top: 8px;">
                                <tr>
                                    <td width="16%" align="left">
                                        <b>Patient Name :</b>
                                    </td>
                                    <td width="16%">
                                           
                                           <asp:Label ID="lblPatientName" runat="server" Text=""></asp:Label>
                                         
                                    </td>
                                    <td width="16%" align="left">
                                        <b>Medical Record # :</b>
                                    </td>
                                    <td width="16%">
                                        <asp:Label ID="lblMedicalRecordNo" runat="server"></asp:Label>
                                    </td>
                                    <td width="16%" align="left">
                                        <b>Patient Type :</b>
                                    </td>
                                    <td width="16%">
                                      
                                                <asp:Label ID="lblPatientType" runat="server" Text=""></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <b>Age / Gender : </b>
                                    </td>
                                    <td>
                                     <asp:Label ID="lblAge" runat="server" Text=""></asp:Label><span style="font-weight:bold;"> / </span>
                                      <asp:Label ID="lblGneder" runat="server" Text=""></asp:Label>         
                                         
                                    </td>
                                    <td align="left">
                                        <b>Hospital Visit # :</b>
                                    </td>
                                    <td>
                                    
                                                <asp:Label ID="lblHospitalVisitNo" runat="server" Text=""></asp:Label>
                                                     
                                    </td>
                                    <td align="left">
                                        <b>Order Date :</b>
                                    </td>
                                    <td>
                        
                                                <asp:Label ID="lblOrderDate" runat="server" Text=""></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <b>Contact # :</b>
                                    </td>
                                    <td>
                                    <asp:Label ID="lblContactNo" runat="server" Text=""></asp:Label>
                                        
                                    </td>
                                    <td align="left">
                                        <b>Lab Order # : </b>
                                    </td>
                                    <td>
                                       <asp:Label ID="lblOrderNo" runat="server" Text=""></asp:Label>
                                           
                                    </td>
                                    <td align="left">
                                        <b>Sample Received :</b>
                                    </td>
                                    <td>
                                       <asp:Label ID="lblSampleReceived" runat="server" Text=""></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <b>&nbsp;</b>
                                    </td>
                                    <td>
                                        
                                    </td>
                                    <td align="right">
                                        <b>&nbsp;</b>
                                    </td>
                                    <td>
                                    </td>
                                    <td align="left">
                                        <b>Reporting Date :</b>
                                    </td>
                                    <td>
                                    <asp:Label ID="lblReportingDate" runat="server" Text=""></asp:Label>
                                    </td>
                                </tr>
                               
                            </table>
                        </td>
                    </tr>
                <tr>
                    <td style="width: auto;" valign="top">
                        <div style="width: 100%; text-align: center;">
                            <br />
                            <asp:Label ID="lblTestBookingName" runat="server" Font-Bold="true" Font-Underline="true"
                                Font-Size="Large"></asp:Label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="width: auto;" valign="top">
                        <br />
                        <asp:Label ID="lblReport" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
<div class="report-footer" style="width:100%;">
	<table cellpadding="0" cellspacing="0" border="0" style="max-width: 100%; min-width: 100%; width:100%; width: 180mm;" class="report_wrap">
	<tr>
    	<td align="center">
        	&nbsp;</td>
    </tr>
    <tr height="2"><td><hr></td></tr>
    <tr>
        <td>
        	<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
            	<tr>
                	<td style="min-width:25%; width: 55mm;">
                    	<span>
                        	<b>Dr. Hamid Majeed</b></span><span class="style1"> 
                            MCPS, FCPS, FRCR, 2A (UK)<br/>
                            Associate Professor & Head</b><br />
                        </span><b class="first">
                        <br />
                        <br />
                        Dr. Aisha Mumtaz</b><span class="style1"> PGR (FCPS)
                        </span>                        
                    </td>
                    
                    
                    
                    
                    <td style="min-width:25%; width: 55mm;">
                    	<span>
                            <b>Dr. Muhammad Fiaz</b></span><span class="style1">
                            FRCR-II, MCPS, FCPS </b>
                            VIR Fellowship from Singapore </b>
                            Interventional Radiologist</b></span> <b class="first">
                        <br />
                        Dr. Beenish Naz</b><span class="style1"> PGR (FCPS)</span></td>
                    <td style="min-width:25%; width: 45mm;">
                    	<span>
                            <b>Dr. Aneeza Qayum</b></span><span class="style1"> 
                            Medical officer </br>
                        </span>

                        <br />
                        <br />
                        <b>
                        <br />
                        Dr. Haseeb Manzoor</b></span><span class="style1">
                        PGR (FCPS)</br>
                        </span>

                    </td>
                    <td style="min-width:25%; width: 45mm;">
                    	<span>
                            <b>Dr. Asma Usman</b></span><span class="style1">
                            PGR (FCPS) FRCR 1</b></span>

                            <b class="first">
                        <br />
                        <br />
                        <br />
                        Dr. Kamran Ashraf</b>
                        <span class="style1">
                           PGR (FCPS)</b>
                        </span>

                    </td>
                    <td style="min-width:25%; width: 45mm;">
                    	<span>
                            <b>Dr. Faiza Afzal</b></span><span class="style1"> 
                            PGR (FCPS) FRCR 1</br>
                        </span>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr height="2"><td><hr></td></tr>
</table>
</div>
                    </td>
                </tr>
            </table>
            
</asp:Content>
