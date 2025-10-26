<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Doctor_Call_Report, App_Web_p0fljamz" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 
  <style type="text/css" media="screen">
 body {font-family:"Segoe UI"; }
.medication_cnt {margin-left:0px; }
.medication_cnt li span {color:#333; padding-left:0px; padding-right:0px;}
.medication_cnt li .span {color:#cccccc; padding-left:10px; padding-right:10px;} 
 </style>
 
 
 
 
 <link href="../css_hacims/print_report.css"   rel="stylesheet"   type="text/css" media="print" />
 <script src="../css_hacims/ck.js" type="text/javascript"></script>

<script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript"></script>

 </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      
      <td style="width:auto;" valign="top">




 <div align="right" id="mprint"><a href="javascript:window.print()" class="print_btn">Print</a></div>

        <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="tbl_form" >
            <tr  >
               
                <td align="center" >
                <ul >
               <li> <asp:Label runat="server" ID="lbl1" Text="ISLAMIC INTERNATIONAL MEDICAL COMPLEX" Font-Bold="True" Font-Size="Large"></asp:Label></li><li style="line-height:18px;">  <asp:Label ID="lbl2" runat="server" Text="Phone No. : 051-35865731-5"></asp:Label> </li>
                 <li style="line-height:18px;">  <asp:Label ID="Label1" runat="server" Text="Doctor Call Report" Font-Bold="True"></asp:Label></li><li style="line-height:18px;">   <asp:Label runat="server" ID="lblDate"></asp:Label>
                 
                 </ul>
                </td>
                 
            </tr>
            </table>
            <br />
            <table cellpadding="0" cellspacing="0" border="0" width="100%" class="Grid_1">
            <tr>
                <td width="16%" align="right"><b> Patient Name :</b></td>
                <td width="16%"> <asp:Label ID="lblPatientName" runat="server"></asp:Label> </td>
                <td width="16%" align="right"> <b> Medical Record # :</b></td>
                <td width="16%"> <asp:Label ID="lblMedicalRecord" runat="server"></asp:Label> </td>
                <td width="16%" align="right"> <b>CNIC :</b></td>
                <td width="16%"> <asp:Label ID="lblCNIC" runat="server"></asp:Label></td>
                
            </tr>
            
            <tr>
                <td align="right"><strong> <asp:Label ID="lblRelation" runat="server"></asp:Label> :</strong></td>
                <td> <asp:Label ID="lblRelationName" runat="server"></asp:Label></td>
                <td align="right"> <b>Room # :</b></td>
                <td> <asp:Label ID="lblRoomNo" runat="server"></asp:Label>
                </td>
                <td align="right"> <b>Gender :</b></td>
                <td > <asp:Label ID="lblSex" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                
                <td align="right">
                    <b>Date Admission :</b></td>
                <td >
                    <asp:Label ID="lblDateAdmission" runat="server"></asp:Label>
                </td>
                 <td align="right">
                    <b>Age :</b></td>
                <td>
                    <asp:Label ID="lblAge" runat="server"></asp:Label>
                </td>
                <td align="right">
                    <b>No. Of Days :</b></td>
                <td>
                    <asp:Label ID="lblNoOfDays" runat="server"></asp:Label>
                </td>
            </tr>
            
            <tr>
                <td align="right">
                    <b>Phone :</b></td>
                <td>
                    <asp:Label ID="lblPhone" runat="server"></asp:Label>
                </td>
                <td align="right">
                    <b>Date Of Discharge :</b></td>
                <td>
                    <asp:Label ID="lblDateOfDischarge" runat="server"></asp:Label>
                </td>
                
                 
                <td align="right">
                    <b>Consultant Name :</b></td>
                <td>
                    <asp:Label ID="lblConsultantName" runat="server"></asp:Label>
                </td>
                
            </tr>
            <tr >
               <td align="right" >
                    <b>Address :</b></td>
                <td colspan="5">
                    <asp:Label ID="lblAddress" runat="server"></asp:Label>
                </td>
                 
            </tr>
             </table>
       
         <h1 class="h1" >
              <span>Doctor Call
              
            ( <asp:Label ID="LabelCallType" runat="server" style=" background-image:none; padding-left:0; color:#000; margin:0;"></asp:Label>
                  )</span></h1>
        
        
          <ul class="medication_cnt" style="margin-top:10px;"  >
                         <li style="border-bottom: #cccccc dotted 1px; border-right: 0; border-left: 0; ">
                            
        <strong class="mname" > Call to : <asp:Label ID="Label_Dept" runat="server"></asp:Label></strong></li><li style="float:right; margin-right:10px;   border-right:0; border-left:0;">  <asp:Label ID="Label_When_Needed" runat="server"></asp:Label><span class="span">|</span>
                Call By :  <asp:Label ID="Label_Call_By" runat="server"></asp:Label><span class="span">|</span>
                Call By Deprtment :  <asp:Label ID="Label_CallBy_Dept" runat="server"></asp:Label></li><li style="border:0;"  >  <asp:Label ID="Label_Opinion_For" runat="server"></asp:Label></li></ul>
       
       
       
     <h1 class="h1" ><span>Report</span></h1>   
         <ul class="medication_cnt" >
      
       <li style="float:right; margin-right:10px; margin-top:-30px; border-right:0; border-left:0;">   <asp:Label ID="Label_ReplyDateTime" runat="server"></asp:Label><span class="span">|</span>
          <asp:Label ID="Label_ReplyBy" runat="server"></asp:Label> </li>
         <li  style="border:0;">   <asp:Label ID="Label_Reply" runat="server"></asp:Label></li></ul>  
          </td></tr></table>
        <asp:Label ID="LabelFooter" runat="server" Text=""></asp:Label>    
                
  </asp:Content>
