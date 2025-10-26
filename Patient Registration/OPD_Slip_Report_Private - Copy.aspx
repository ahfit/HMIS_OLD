<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Patient_Registration_OPD_Slip_Report_Private, App_Web_3d5bytc0" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 
     <style type="text/css" media="screen">
.medication {margin-left:0px; }
.medication li span {color:#333; padding-left:0px; padding-right:0px;}
.medication li .span {color:#cccccc; padding-left:10px; padding-right:10px;}
fieldset {display:naone;}
 </style>
 <style type="text/css" media="print">
 body {font-size:11px; }
 ul li {list-style:none; font-family:Calibri;   }
 .h1 {font-size:12px; font-family:Calibri; background-color:#ccc; height:22px; display:block; line-height:20px; padding-left:10px; }
 #footer {display:none;}
 #navigation {display:none;}
 #header {display:none;}
 .leftnav {display:none; }
 #p_info {display:none;}
 .Grid_1 { font-family:Calibri; font-size:10px; }
  .Grid_1 td { font-family:Calibri; font-size:10px; height:16px; padding-right:3px; }
 .fieldset {display:block;}
 #mprint {display:none;}
 
 .medication { margin-left:-40px; margin-top:5px; margin-bottom:5px; }
.liness { min-height:50px;  }
 </style>
 <script src="../css_hacims/ck.js" type="text/javascript"></script>

<script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript"></script>

 </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager id="scriptManager1" runat="server">
    </asp:ScriptManager>

    <div style="height:30px;">
        <asp:HyperLink ID="hlnkPrintReceipt" runat="server" Visible="False" 
            Text="Print Receipt" />
        <asp:Label ID="Label1" runat="server"></asp:Label>
    </div>
    
    <rsweb:ReportViewer ID="ReportViewer1" Width="100%" runat="server"
  
            ShowPrintButton="true" ShowRefreshButton="False">
    </rsweb:ReportViewer>

<table width="100%" border="0" style="display:none;" cellspacing="0" cellpadding="0">
    <tr>
      
      <td style="width:auto;" valign="top">




 <div align="right" id="mprint"><a href="javascript:window.print()" class="print_btn">Print</a></div>

        <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="tbl_form" >
            <tr  >
               
                <td align="center" >
                <ul >
               <li> <asp:Label runat="server" ID="Label_Hospital" Text="RAILWAY GENERAL HOSPITAL, RAWALPINDI" Font-Bold="True" Font-Size="Large"></asp:Label></li><li style="line-height:18px;">  &nbsp;<asp:Label ID="Label_Address" runat="server" Text="Teaching Hospital for IIMC-T" Font-Bold="True"></asp:Label></li><li>
                        <asp:Label ID="Label_Hosp_Ph" runat="server" Text="Ph : 051-9278414-15"></asp:Label></li><li style="line-height:18px;">   <asp:Label runat="server" ID="lblDate" Visible="False"></asp:Label>
                            <li>
                                <asp:Label ID="Label_DeptName" runat="server"></asp:Label></li></ul>
                </td>
                 
            </tr>
            </table>
            <br />
            <table cellpadding="0" cellspacing="0" border="0" width="100%" class="Grid_1">
            <tr>
                <td width="16%" align="right" style="height: 22px"><b> Date &amp; Time :&nbsp;</b></td>
                <td width="16%" style="height: 22px"> 
                    <asp:Label ID="lbl_Date" runat="server"></asp:Label>&nbsp;
                    <asp:Label ID="lbl_Time" runat="server"></asp:Label></td>
                <td width="16%" align="right" style="height: 22px"> <b> Medical Record # :</b></td>
                <td width="16%" style="height: 22px"> <asp:Label ID="lblMedicalRecord" runat="server"></asp:Label> </td>
                <td align="right" style="height: 22px; width: 189px;"> 
                  <asp:Label ID="lblDescText" runat="server"></asp:Label>  </td>
                <td width="16%" style="height: 22px">&nbsp;<strong>Rs. :</strong><asp:Label Font-Bold="true" ID="lbl_RS" runat="server"></asp:Label></td>
                
            </tr>
                <tr>
                    <td align="right" style="height: 22px" width="16%">
                        <strong>Name :&nbsp;</strong></td>
                    <td style="height: 22px" width="16%">
                        <asp:Label ID="lblPatientName" runat="server"></asp:Label></td>
                    <td align="right" style="height: 22px" width="16%">
                        <strong>Age :</strong></td>
                    <td style="height: 22px" width="16%">
                    <asp:Label ID="lblAge" runat="server"></asp:Label></td>
                    <td align="right" style="width: 189px"><b>Gender :</b></td>
                    <td style="height: 22px" width="16%">
                        <asp:Label ID="lblSex" runat="server"></asp:Label></td>
                </tr>
            
            <tr>
                <td align="right"><strong> <asp:Label ID="lblRelation" runat="server"></asp:Label> :</strong></td>
                <td> <asp:Label ID="lblRelationName" runat="server"></asp:Label></td>
                <td align="right"> <b>Referred By :</b></td>
                <td> <asp:Label ID="lblRefer" runat="server"></asp:Label>
                </td>
                <td align="right" style="width: 189px"> 
                    <strong></strong></td>
                <td >&nbsp; </td>
            </tr>
            <tr>
                
                <td align="right" style="height: 12px"><b>Department :</b></td>
                <td style="height: 12px" >
                    <asp:Label ID="lbl_Department" runat="server"></asp:Label></td>
                 <td align="right" style="height: 12px">
                    <b>Sub- Department :</b></td>
                <td style="height: 12px">&nbsp;<asp:Label ID="lbl_SubDepartment" runat="server" Font-Bold="False"></asp:Label></td>
                <td align="right" style="height: 12px; width: 189px;">
                    <b>Consultant :</b></td>
                <td style="height: 12px">&nbsp;
                    <asp:Label ID="lblConsultant" runat="server"></asp:Label></td>
            </tr>
             </table>
        
        
          </td></tr></table> <asp:Label ID="lblDepartment" runat="server" Visible="false"></asp:Label>
        <asp:Label ID="LabelFooter" runat="server" Text=""></asp:Label>    
                
  </asp:Content>
