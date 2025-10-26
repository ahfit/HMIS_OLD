<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage.master" inherits="Patient_Registration_PatientFaceSheet, App_Web_iao5qmh5" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

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
                 <li style="line-height:18px;">  <asp:Label ID="Label1" runat="server" Text="MEDICAL RECORD FACE SHEET" Font-Bold="True"></asp:Label></li><li style="line-height:18px;">   <asp:Label runat="server" ID="lblDate"></asp:Label>
                 
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
             
             <br />

          <asp:GridView ID="GridView_Notes" runat="server" AutoGenerateColumns="False" DataKeyNames="Nurse_Record_ID"
              DataSourceID="SqlDataSourceForGridDatalist" Width="100%" SkinId="grid_nolines">
              <Columns>
                  <asp:TemplateField>
                      <ItemTemplate>
                      
    <table  cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
  <tr>
    <td style="background-color:#d3d3d3; border:#999999 solid 1px; height:22px; padding:3px;"><strong><asp:Label ID="Label3" runat="server" style="color:#000;"  Text='<%# Eval("Date", "{0}") %>'></asp:Label></strong>
    <div style="float:right;"><asp:LinkButton ID="LinkButton1" runat="server" CommandName="Select" Text='<%# Eval("Nurse", "{0}") %>'></asp:LinkButton>&nbsp;&nbsp;|&nbsp;&nbsp; 
    <asp:Label ID="Label2" runat="server" Text='<%# Eval("Type", "{0}") %>'></asp:Label>
    </div> 
        <asp:Label ID="Label4" runat="server" Font-Bold="True" ForeColor="Red" Text='<%# Eval("Critical") %>'></asp:Label></td>
  </tr>
  <tr>
    <td valign="top" style="padding-top:5px;">
    
    <div style="padding-bottom:10px; line-height:17px;"><strong>Treatment :</strong> <asp:Label ID="Label_Treatment" runat="server" Text='<%# Eval("Treatment") %>'></asp:Label></div>
    

     <div style="padding-bottom:10px; line-height:17px;">                                           
	<strong>Observation : </strong><asp:Label ID="Label_Observation" runat="server" Text='<%# Eval("Clinical_Observation") %>'></asp:Label> 
   </div>

    </td>
  </tr>
</table>
                    
 
                                      

                                      

                                     


                                      
                               
                          <asp:HiddenField ID="HiddenField_Type" runat="server" Value='<%# Eval("Type") %>' />
                          <asp:HiddenField ID="HiddenField_Clinical_Observation" runat="server" Value='<%# Eval("Clinical_Observation") %>' />
                          <asp:HiddenField ID="HiddenField_Treatment" runat="server" Value='<%# Eval("Treatment") %>' />
                          <asp:HiddenField ID="HiddenField_Status" runat="server" Value='<%# Eval("Critical_Reading") %>' />
                          <asp:HiddenField ID="HiddenField_Date" runat="server" Value='<%# Eval("Date") %>' />
                      </ItemTemplate>
                      <HeaderStyle CssClass="hide" />
                  </asp:TemplateField>
              </Columns>
          </asp:GridView>
          
          
          <asp:SqlDataSource ID="SqlDataSourceForGridDatalist" runat="server" ConnectionString="<%$ ConnectionStrings:NurseConnectionString %>"
              ProviderName="<%$ ConnectionStrings:NurseConnectionString.ProviderName %>" SelectCommand="SELECT     Nurse_Record.Date_Time AS Date, Nurse_Record.Clinical_Observation, Nurse_Record.Treatment, &#13;&#10;                      Employee.Prefix + ' ' + Employee.EFName + ' ' + ISNULL(Employee.EMName, ' ') + ' ' + ISNULL(Employee.ELName, ' ') AS Nurse, Nurse_Record.Type, &#13;&#10;                      Nurse_Record.Nurse_Record_ID, Nurse_Record.Critical_Reading, CASE when Nurse_Record.Critical_Reading=1 THEN ('(Critical)') ELSE '' END AS Critical  &#13;&#10;FROM         Nurse_Record INNER JOIN&#13;&#10;                      Employee ON Nurse_Record.Emp_Id = Employee.EmpID&#13;&#10;WHERE     (Nurse_Record.YearlyNo = @YearlyNo) AND (Nurse_Record.RegNo = @RegNo)&#13;&#10;ORDER BY Date DESC">
              <SelectParameters>
                  <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                  <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
              </SelectParameters>
          </asp:SqlDataSource>
          
                
            </td></tr></table>
        <asp:Label ID="LabelFooter" runat="server" Text="Label"></asp:Label>        
  </asp:Content>
