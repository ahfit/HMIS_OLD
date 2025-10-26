<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Patient_Registration_PatientFaceSheet, App_Web_tip0c1yj" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 
<style type="text/css" media="screen">
 body {font-family:"Segoe UI"; }
.medication {margin-left:0px; }
.medication li span {color:#333; padding-left:0px; padding-right:0px;}
.medication li .span {color:#cccccc; padding-left:10px; padding-right:10px;} 
 </style>
  
  
   <link href="../css_hacims/print_report.css"   rel="stylesheet"   type="text/css" media="print" />
 <script src="../css_hacims/ck.js" type="text/javascript"></script>

<script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript"></script>

 </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td  valign="top" class="leftnav"> <asp:Label ID="LabelSideMenu" runat="server"></asp:Label></td>
      <td style="width:auto;" valign="top">




 <div align="right" id="mprint"><a href="javascript:window.print()" class="print_btn">Print</a></div>

        <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="tbl_form" >
            <tr  >
               
                <td align="center" >
                <ul >
               <li> <asp:Label runat="server" ID="lbl1" Text="SHAIKH ZAYED HOSPITAL, LAHORE" Font-Bold="True" Font-Size="Large"></asp:Label></li><li style="line-height:18px;">  <asp:Label ID="lbl2" runat="server" Text="Phone No. : 042-35865731-5"></asp:Label> </li>
                 <li style="line-height:18px;">  <asp:Label ID="Label1" runat="server" Text="MEDICAL RECORD FACE SHEET" Font-Bold="True"></asp:Label></li>< style="line-height:18px;">   <asp:Label runat="server" ID="lblDate"></asp:Label>
                 
                 </ul>
                </td>
                 
            </tr>
            </table>
            <br />
            <table cellpadding="0" cellspacing="0" border="0" width="100%" class="Grid_1">
            <tr>
                <td width="16%" align="right"><b> Patient Name :</b></td>
                <td > <asp:Label ID="lblPatientName" runat="server"></asp:Label> </td>
                <td width="16%" align="right"> <b> Medical Record # :</b></td>
                <td width="16%"> <asp:Label ID="lblMedicalRecord" runat="server"></asp:Label> </td>
                <td width="16%" align="right"> <b>CNIC :</b></td>
                <td width="16%"> <asp:Label ID="lblCNIC" runat="server"></asp:Label></td>
                
            </tr>
            
            <tr>
                <td align="right"><strong> <asp:Label ID="lblRelation" runat="server"></asp:Label> :</strong></td>
                <td > <asp:Label ID="lblRelationName" runat="server"></asp:Label></td>
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
                <td  >
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
                <td >
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
             
             <br />
          
          <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Plan_id"
              DataSourceID="SqlDataSource_pt_Treatment_Plan" Width="100%" style="border:#fff solid 1px;">
              <Columns>
                  <asp:TemplateField>
                      <ItemTemplate>
                           
<h1 class="h1"><span ><asp:Label ID="Label1" runat="server" CssClass="small_f" Style="background-image:none; padding:0; margin:0;" Text='<%# Eval("Date", "{0}") %>'></asp:Label> 
<strong>( <asp:Label ID="Label3" runat="server" ForeColor="Red"  Style="background-image:none; padding:0; margin:0;"  Text='<%# Eval("[Physician Name]", "{0}") %>'></asp:Label> )</strong></span><asp:Label ID="Label2" runat="server" Style="background-image:none; padding:0; margin:0; float:right; margin-right:10px;"  Text='<%# Eval("Department") %>'></asp:Label></h1>
 
<div style="display:block; padding-top:5px; padding-bottom:10px; line-height:16px; ">
 <asp:Label ID="Label4" runat="server" ForeColor="Black" Text='<%# Eval("Plan_Detail") %>'></asp:Label></div>
                                      
                          <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("Plan_Detail") %>' />
                      </ItemTemplate>
                      <HeaderStyle CssClass="hide" />
                  </asp:TemplateField>
              </Columns>
          </asp:GridView>
          
          
          
          <asp:SqlDataSource ID="SqlDataSource_pt_Treatment_Plan" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
              ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
              SelectCommand="Physician_Notes" SelectCommandType="StoredProcedure">
              <SelectParameters>
                  <asp:SessionParameter Name="Reg_no" SessionField="RegistrationNo" Type="String" />
                  <asp:SessionParameter Name="Yearly_no" SessionField="YearlyNo" Type="Decimal" />
                  <asp:SessionParameter Name="Dept_ID" SessionField="dept_id" Type="Int32" />
              </SelectParameters>
          </asp:SqlDataSource>
          
                
            </td></tr></table>
        <asp:Label ID="LabelFooter" runat="server" Text="Label"></asp:Label>        
  </asp:Content>
