<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Discharge_Summary_Report.aspx.vb"  MasterPageFile="~/hacims_masterpage_admin.master"
    Inherits="Doctor_Call_Report43" %>

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
               <li> <asp:Label runat="server" ID="lbl1" Text="SHAIKH ZAYED HOSPITAL, LAHORE" Font-Bold="True" Font-Size="Large"></asp:Label></li><li style="line-height:18px;">  <asp:Label ID="lbl2" runat="server" Text="Phone No. : 042-35865731-5"></asp:Label> </li>
                 <li style="line-height:18px;">  <asp:Label ID="Label1" runat="server" Text="Discharge Summary Report" Font-Bold="True"></asp:Label></li><li style="line-height:18px;">   <asp:Label runat="server" ID="lblDate"></asp:Label>
                 
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
        
        
          <ul class="medication_cnt" style="margin-top:25px;"  >
       
       
       
     <h1 class="h1" ><span>Final Diagnosis</span></h1>   
                         
                            
        
                             <asp:DataList ID="DataList1" runat="server" DataKeyField="Diagnosis_ID" Width="100%" DataSourceID="SqlDataSource_DataListCurrnentDiagnosis">
                                 <ItemTemplate>
                                     <asp:Label ID="Diagnose_DateLabel" runat="server" Text='<%# Eval("[Diagnose Date]") %>'></asp:Label>
                                     <asp:Label ID="DiseaseNameLabel" runat="server" Text='<%# Eval("DiseaseName") %>'></asp:Label><br />
                                      
                                     
                                 </ItemTemplate>
                             </asp:DataList>
                             
                             <br />

                             <asp:DataList ID="DataList_Discharge_Headings" runat="server" DataSourceID="SqlDataSource_Discharge_Datalist" Width="100%">
                                 <ItemTemplate>
                                      <table  cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                                         <tr>
                                             <td >
                                                <h1 class="h1" > <asp:Label ID="Discharge_HeadingLabel" runat="server" Font-Bold="True" Text='<%# Eval("Discharge_Heading") %>'></asp:Label> </h1>  </td>
                                         </tr>
                                         <tr>
                                             <td >
                                                 <asp:Label ID="DescriptionLabel" runat="server" Style="line-height:18px;" Text='<%# Eval("Description") %>'></asp:Label></td>
                                         </tr>
                                     </table>
                                 </ItemTemplate>
                             </asp:DataList> 
              <h1 class="h1">
                  <span>Operations</span></h1>
              <ul>
              </ul>
              <ul class="medication_cnt" style="margin-top: 25px">
                  <asp:DataList ID="DataList_Procedure" runat="server" DataKeyField="OP_Recommended_Id"
                      DataSourceID="SqlDataSource_Procedure" Width="100%">
                      <ItemTemplate>
                          <ul class="medication_cnt">
                              <li style="border-bottom: #cccccc dotted 1px; border-right: 0; border-left: 0;"><strong
                                  class="mname">
                                  <asp:Label ID="Procedure_NameLabel" runat="server" Style="" Text='<%# Eval("Procedure_Name") %>'></asp:Label>
                              </strong></li>
                              <li>Recommended By :
                                  <asp:Label ID="Recommended_ByLabel" runat="server" Text='<%# Eval("[Recommended By]") %>'>
            </asp:Label><span class="span">|</span> Advice :
                                  <asp:Label ID="AdviceLabel" runat="server" Text='<%# Eval("Advice") %>'></asp:Label><span
                                      class="span">|</span> Expected OpDate :
                                  <asp:Label ID="ExpectedOpDateLabel" runat="server" Text='<%# Eval("ExpectedOpDate") %>'>
            </asp:Label><span class="span">|</span>
                                  <asp:Label ID="AnaesthesiaTypeLabel" runat="server" Text='<%# Eval("AnaesthesiaType") %>'
                                      Visible="False"></asp:Label>&nbsp;
                                  <asp:Label ID="CanDelayForLabel" runat="server" Text='<%# Eval("CanDelayFor") %>'
                                      Visible="False"></asp:Label>ICU Stay :
                                  <asp:Label ID="ICU_StayLabel" runat="server" Text='<%# Eval("ICU_Stay") %>'></asp:Label>
                              </li>
                          </ul>
                      </ItemTemplate>
                  </asp:DataList></ul>
              <ul class="medication_cnt" style="margin-top: 25px">
                  <asp:SqlDataSource ID="SqlDataSource_Procedure" runat="server" ConnectionString="<%$ ConnectionStrings:OperationTheaterConnectionString %>"
                      SelectCommand="Select_Pt_Recomm_Operation" SelectCommandType="StoredProcedure">
                      <SelectParameters>
                          <asp:SessionParameter Name="Reg_No" SessionField="RegistrationNO" Type="String" />
                          <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNO" Type="Decimal" />
                          <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                      </SelectParameters>
                  </asp:SqlDataSource>
                  
             
          
          <asp:SqlDataSource ID="SqlDataSource_DataListCurrnentDiagnosis" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
              ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
              SelectCommand="SELECT DISTINCT pt_Diagnosis.YearlyNo, ISNULL(Employee.Prefix, ' ') + ' ' + ISNULL(Employee.EFName, ' ') + ' ' + ISNULL(Employee.EMName, ' ') + '' + ISNULL(Employee.ELName, ' ') + ' (' + Designation.Designation_Name + ')' AS Doctor, ISNULL(pt_Diagnosis.DiseaseName, '') AS DiseaseName, ISNULL(pt_Diagnosis.dsCode, '') AS [ICD10 Code], CASE WHEN pt_Diagnosis.Provisional = 1 THEN 'Provisional' ELSE '' END AS Provisional, ISNULL(pt_Diagnosis.Final, '0') AS Final, pt_Diagnosis.Diagnosis_ID, CONVERT (varchar, pt_Diagnosis.DiagnoseDate, 103) AS [Diagnose Date] FROM Designation RIGHT OUTER JOIN Employee ON Designation.Designation_ID = Employee.DesignationID RIGHT OUTER JOIN pt_Diagnosis ON Employee.EmpID = pt_Diagnosis.emp_id WHERE (pt_Diagnosis.YearlyNo = @yearlyNo) AND (pt_Diagnosis.RegNo = @regno)">
              <SelectParameters>
                  <asp:SessionParameter Name="yearlyNo" SessionField="yearlyno" />
                  <asp:SessionParameter Name="regno" SessionField="registrationno" />
              </SelectParameters>
          </asp:SqlDataSource>
          
        
          <asp:SqlDataSource ID="SqlDataSource_Discharge_Datalist" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
              InsertCommand="Insert_Patient_Discharge_Info" InsertCommandType="StoredProcedure"
              ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
              SelectCommand="SELECT     Discharge_Heading, Description&#13;&#10;FROM         Patient_Discharge_Info&#13;&#10;WHERE     (Yearly_No = @Yearly_No) AND (Reg_No = @Reg_No)"
              UpdateCommandType="StoredProcedure">
              <SelectParameters>
                  <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" />
                  <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" />
              </SelectParameters>
              <InsertParameters>
                  <asp:ControlParameter ControlID="DropDownList_Discharge_Heading" Name="Discharge_Heading_Id"
                      PropertyName="SelectedValue" Type="Int32" />
                  <asp:ControlParameter ControlID="TextBox_Description" DefaultValue="" Name="Description"
                      PropertyName="Text" Type="String" />
                  <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" Type="Decimal" />
                  <asp:SessionParameter DefaultValue="" Name="Reg_No" SessionField="registrationNo"
                      Type="String" />
                  <asp:ControlParameter ControlID="HiddenField_DischargeHeading" Name="Discharge_Heading"
                      PropertyName="Value" Type="String" />
              </InsertParameters>
          </asp:SqlDataSource>
              </ul>
      </td></tr></table>
        <asp:Label ID="LabelFooter" runat="server" Text=""></asp:Label>    
                
  </asp:Content>
