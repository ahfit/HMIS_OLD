<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage.master" inherits="MedicationSheet, App_Web_gswfk1g0" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 
 <style type="text/css" media="screen">
 body {font-family:"Segoe UI"; }
.medication {margin-left:0px;  }
.medication li span {color:#333; padding-left:0px; padding-right:0px;}
.medication li .span {color:#cccccc; padding-left:10px; padding-right:10px;} 
 </style>
 
 
 
 
 <link href="../css_hacims/print_report.css"   rel="stylesheet"   type="text/css" media="print" />
<script src="../css_hacims/ck.js" type="text/javascript"></script>
<script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript">function H1_1_onclick() {
                                                                                 }

</script>

 </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td  valign="top" class="leftnav"> <asp:Label ID="LabelSideMenu" runat="server"></asp:Label></td>
      <td style="width:auto;" valign="top">




 <div align="right" id="mprint"><a href="javascript:window.print()" class="print_btn">Print</a></div>

        <table width="100%" border="0" cellspacing="0" cellpadding="0"     >
            <tr  >
               
                <td align="center" >
                <ul style="list-style:none; margin-top:0px;" >
               <li> <asp:Label runat="server" ID="lbl1" Font-Bold="True" Font-Size="Large"></asp:Label></li><li style="line-height:18px;">  <asp:Label ID="lbl2" runat="server" Text="Phone No. : 042-35865731-5"></asp:Label> </li>
                 <li style="line-height:18px;">  <asp:Label ID="Label1" runat="server" Text="MEDICATION SHEET" Font-Bold="True"></asp:Label></li><li style="line-height:18px;">   <asp:Label runat="server" ID="lblDate"></asp:Label>
                 
                 </ul>
                </td>
                 
            </tr>
            <tr  >
              <td  valign="top" style="height: 166px" >
              
 
              
              
              
              <table cellpadding="0" cellspacing="0" border="0" width="100%" class="Grid_1" style="margin-top:8px;">
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
             </table></td>
             
             </tr>
             
             <td valign="top">
                 &nbsp; &nbsp;<br />
         
        
        
        
 <h1 class="h1" >
        <span>Vitals and Medication</span></h1>
        
         <ul class="medication" style="border-bottom:0px; border-right:0px; border-left:0px;"   >
              </ul>
                 <ul class="medication" style="border-right: 0px; border-left: 0px; border-bottom: 0px">
                     <h1 class="h1" style="background-image:none; box-shadow:none; width:90%; margin-left:15px;  " >
                         <span style="background-image:none; padding-left:0;">Vitals</span></h1>
              <li style="border-right:0px; border-left:0px;" >
          <asp:DataList ID="DataList_Vitals" runat="server" DataSourceID="ObjectDataSource_Vitals" Width="97%"  RepeatDirection="Horizontal" RepeatLayout="Flow">
              <ItemTemplate>
              
             
               
                <strong><asp:Label ID="VitalNameLabel" runat="server" Text='<%# Eval("VitalName") %>'></asp:Label>&nbsp;
                </strong>
                 <asp:Label ID="ResultLabel" runat="server" Text='<%# Eval("Result") %>'></asp:Label><span class="span">|</span>
                 
                
                
              </ItemTemplate>
          </asp:DataList>
           </li>    
                 </ul>
                
          
          
          
          <asp:ObjectDataSource ID="ObjectDataSource_Vitals" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="XMLGeneratationTableAdapters.VitalsTableAdapter">
              <SelectParameters>
                  <asp:SessionParameter Name="RegNO" SessionField="RegistrationNo" Type="String" />
                  <asp:SessionParameter Name="Yearlyno" SessionField="YearlyNO" Type="Decimal" />
              </SelectParameters>
          </asp:ObjectDataSource> &nbsp; &nbsp;<br />
    
    
            

          
   <h1 class="h1" style="background-image:none; box-shadow:none; width:90%; margin-left:15px;  " ><span style="background-image:none; padding-left:0;">Medication</span></h1>  
   
  
  
          <asp:DataList ID="DataList_ConfirmedPrescriptions" runat="server" DataKeyField="priscription_id"
              DataSourceID="SqlDataSource_Confirmed_Prescriptions" Width="90%" style="margin-left:15px;">
              <ItemTemplate>
                  <ul class="medication">
                      <li style="border-bottom: #cccccc dotted 1px; border-right: 0; border-left: 0;">
                      <strong class="mname">
                          <%# Eval("[Medicine Name]") %>
                      </strong> 
                          <%#Eval("Para")%>
                          
                      </li>
                      <li style="text-align :right;">
                       <%#Eval("para_Urdu")%>
                      </l
                  </ul> <asp:HiddenField ID="HiddenField_PrescriptionID" runat="server" Value='<%# Eval("priscription_id") %>' />
              </ItemTemplate>
          </asp:DataList>
          
          
          
          <asp:SqlDataSource ID="SqlDataSource_Confirmed_Prescriptions" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
              DeleteCommand="DELETE FROM Pt_Prescription_Detail WHERE (priscription_id = @priscription_id)"
              SelectCommand="Select_Med_Presc_Urdu" SelectCommandType="StoredProcedure">
              <SelectParameters>
                  <asp:SessionParameter Name="RegNo" SessionField="registrationno" Type="String" />
                  <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
              </SelectParameters>
              <DeleteParameters>
                  <asp:ControlParameter ControlID="HiddenField_Prescription_Id" Name="priscription_id"
                      PropertyName="Value" />
              </DeleteParameters>
          </asp:SqlDataSource>
                 &nbsp;&nbsp;
     </td>           
            
            
         
       
         
            
          
            <asp:SqlDataSource ID="SqlDataSource_Physician_Order_Main" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                SelectCommand="SELECT   distinct CONVERT(varchar, Start_Data_Time, 103) AS St_Date&#13;&#10;FROM         Pt_Physician_Order&#13;&#10;WHERE     (Registration_No = @Registration_No) AND (Yearly_No = @Yearly_No)&#13;&#10;ORDER BY CONVERT(varchar, Start_Data_Time, 103)">
                <SelectParameters>
                    <asp:SessionParameter Name="Registration_No" SessionField="RegistrationNO" />
                    <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" />
                </SelectParameters>
            </asp:SqlDataSource>
        <asp:Label ID="LabelFooter" runat="server" Text="Label"></asp:Label><%--</tr>
            </table>--%></tr>
            </table>
                
  </asp:Content>
