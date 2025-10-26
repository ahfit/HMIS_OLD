<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PatientVitalSign_Rpt.aspx.vb" MasterPageFile="~/hacims_masterpage_admin.master"
    Inherits="Patient_Registration_PatientFaceSheet" %>

<%@ Register Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

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




 <div align="right" id="mprint">
     <asp:Button ID="btnShowRpt" runat="server" Text="Show Report" />
     <a href="javascript:window.print()" class="report">Print</a></div>

        <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="tbl_form" >
            <tr  >
               
                <td align="center" >
                <ul >
               <li> <asp:Label runat="server" ID="Label2" Text="" Font-Bold="True" Font-Size="Large"></asp:Label></li>
               <li style="line-height:18px;"><asp:Label ID="Label3" runat="server" Text="" ></asp:Label></li>
               <li style="line-height:18px;">Phone No :<asp:Label ID="lbl2" runat="server" Text="" ></asp:Label></li>
              
               
               <li style="line-height:18px;"><asp:Label ID="Label1" runat="server" Text="NURSES NOTE SHEET(Vital Sign)" Font-Bold="True"></asp:Label></li>
               <li style="line-height:18px;"/><asp:Label runat="server" ID="lblDate"></asp:Label>
                 
                 </ul>
                </td>
                 
            </tr>
            </table>
            <br />
            <table cellpadding="0" cellspacing="0" border="0" width="100%" class="Grid_1">
            <tr>
                <td width="16%" align="right"><b> Patient Name :</b></td>
                <td style="width: 162px"> <asp:Label ID="lblPatientName" runat="server"></asp:Label> </td>
                <td width="16%" align="right"> <b> Medical Record # :</b></td>
                <td width="16%"> <asp:Label ID="lblMedicalRecord" runat="server"></asp:Label> </td>
                <td width="16%" align="right"> <b>CNIC :</b></td>
                <td width="16%"> <asp:Label ID="lblCNIC" runat="server"></asp:Label></td>
                
            </tr>
            
            <tr>
                <td align="right"><strong> <asp:Label ID="lblRelation" runat="server"></asp:Label> :</strong></td>
                <td style="width: 162px"> <asp:Label ID="lblRelationName" runat="server"></asp:Label></td>
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
                <td style="width: 162px" >
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
                <td style="width: 162px">
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
         <br/>

          <asp:GridView ID="GridViewVitals" runat="server" AutoGenerateColumns="False"   
              Width="100%">
              <RowStyle CssClass="GridItem" />
              <Columns>
                  <asp:BoundField DataField="Date" HeaderText="Date" />
                  <asp:BoundField DataField="Time" HeaderText="Time" />
                  <asp:BoundField DataField="Pluse" HeaderText="Pluse" />
                  <asp:TemplateField HeaderText="B.P">
                      <EditItemTemplate>
                          <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("[B.P]") %>'></asp:TextBox>
                      </EditItemTemplate>
                      <ItemTemplate>
                          <asp:Label ID="Label1" runat="server" Text='<%# Bind("BPHigh") %>'></asp:Label><asp:Label
                              ID="lblSlash" runat="server" Text="/"></asp:Label>
                          <asp:Label ID="lblBPLow" runat="server" Text='<%# Bind("BPLow") %>'>></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:BoundField DataField="RR" HeaderText="RR" />
                  <asp:BoundField DataField="Temp_F" HeaderText="Temp(F)" />
                  <asp:BoundField DataField="CVP" HeaderText="CVP" />
              </Columns>
              
          </asp:GridView>
                 <asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>
                    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
                    </rsweb:ReportViewer>
            </td>
                 
            
            
            </tr>
            <tr>
                <td></td>
                <td>
                   
                </td>
            </tr>
    
            
            </table>
            
        <asp:Label ID="LabelFooter" runat="server" Text=""></asp:Label>        
  </asp:Content>
