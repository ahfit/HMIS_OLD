<%@ page language="VB" autoeventwireup="false" inherits="Patient_Registration_PatientFaceSheet, App_Web_uj03ztnp" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<html>
<head>

 <!--Styles -->
<link href="css_hacims/class_reset.css"   rel="stylesheet"   type="text/css" media="screen, projection" />
<link href="css_hacims/class_content.css" rel="stylesheet"   type="text/css" media="screen, projection" />
<!--[if IE]><link rel="stylesheet" href="css_hacims/content_ie.css" type="text/css" media="screen, projection"/><![endif]-->

<link href="css_hacims/print_report.css"   rel="stylesheet"   type="text/css" media="print" />
 
 <style type="text/css" media="all">
 body {font-family:"Segoe UI";  background-color:#fff; background:none; background-image:none; }
.medication {margin-left:0px; font-size:12px; margin-bottom:5px;   }
.medication li span {color:#333; padding-left:0px; padding-right:0px;}
.medication li .span {color:#cccccc; padding-left:10px; padding-right:10px;} 
 </style>
</head>

<body>

<form runat="server">




<table width="96%" border="0" cellspacing="0" cellpadding="0" style="margin-left:25px;">
    <tr>
      <td style="width:auto;" valign="top">




 <div align="right" id="mprint"><a href="javascript:window.print()" class="print_btn">Print</a></div>

        <table width="100%" border="0" cellspacing="0" cellpadding="0"     >
            <tr  >
               
                <td align="center" >
                <ul style="list-style:none; margin-top:0px;" >
               <%--<li> 
               <asp:Label runat="server" ID="lbl1" Font-Bold="True" Font-Size="Large"></asp:Label>
               </li>--%>
               <li style="line-height:18px;">
               <table width = "100%">
               <tr>
               <td width = "20%" align = "Left" valign = "top">
               <asp:Image ID = "Logo1" runat = "server" 
                        Height="66px" 
                       ImageUrl="~\images_hacims\red.png" w="" Width="55px" />

               </td>
               <td width = "60%" align = "Center">
               <asp:Image ID = "Logo2" runat = "server" 
                        Height="66px" 
                       ImageUrl="~\images_hacims\red.png" w="" Width="47px" />

                   <br />
               <strong><asp:Label ID = "lbl"  runat = "Server"  
                       Text = "" Font-Bold="True"  Font-Names="Arial">
               </asp:Label>
                   <br />
               <asp:Label ID = "Label2" runat = "Server"  Text ="ALKHIDMAT Alrazi Hospital Rawalpindi"   Font-Names="Arial"></asp:Label>
                   <br />
               <asp:Label ID = "Label3"  runat = "Server" Text = ""   Font-Names="Arial"></asp:Label>
                   <br />
                   <br /> </strong>
                      <br />
                  <asp:Label ID = "Label5"  runat = "Server" Font-Bold="True"   Text = " " Font-Size = "Small"   Font-Names="Arial"></asp:Label>
               
               <asp:Label ID = "Label4"  runat = "Server" Font-Bold="True"   Text = "" Font-Size = "Small"   Font-Names="Arial"></asp:Label>
               </td>
               <td width = "20%" align = "right" valign = "top">
                   <asp:Image ID="Logo3" runat="server" Height="66px" 
                       ImageUrl="~\images_hacims\blue.png" w="" Width="55px" />
                   </td>
               </tr></table>  
               </li>
                    <li style="line-height:18px;">  
               </li>
                 <li style="line-height:18px;">  <asp:Label ID="Label1" runat="server" Text="MEDICAL RECORD FACE SHEET" Font-Bold="True"></asp:Label></li>
                 <li style="line-height:18px;">   
                 <asp:Label runat="server" ID="lblDate"></asp:Label>
                 </li>
                 </ul>
                </td>
                 
            </tr>
            <tr  >
              <td  valign="top" >
              
 
              
              
              
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

    <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" CssClass="Grid_1" style="display:none;"
        DataSourceID="SqlDataSourceDiagnosis" Width="100%">
        <RowStyle CssClass="GridItem" />
        <Columns>
            <asp:BoundField DataField="ICD Name" HeaderText="Disease Name" SortExpression="ICD Name" />
            <asp:BoundField DataField="ICD Code" HeaderText="ICD10 Code" SortExpression="ICD Code" />
            <asp:BoundField DataField="Past" HeaderText="Past" SortExpression="Past" />
            <asp:BoundField DataField="Provisional" HeaderText="Provisional" SortExpression="Provisional" />
            <asp:BoundField DataField="Final" HeaderText="Final" SortExpression="Final" />
        </Columns>
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSourceDiagnosis" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
        SelectCommand="Pro_Select_pt_treatment" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
            <asp:SessionParameter Name="emp_id" SessionField="emp_id" Type="Decimal" />
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
        </SelectParameters>
    </asp:SqlDataSource>
    </td></table>
    
    
    
    
     <h1 class="h1" ><span>Presenting Complaints</span></h1> 
      
     
<asp:DataList ID="dtlPresentingComplaintsMain" RepeatLayout="flow" runat="server" DataSourceID="dsPrestingComplaintsMain" Width="100%" RepeatColumns="1" RepeatDirection="Horizontal" >
                      <ItemTemplate>
                      
 <div style="display:block; height:auto; border:#ccc solid 1px; border-radius:4px; padding:5px;" >
  <asp:Label ID="Label_Date" runat="server" Text='<%# Eval("Date") %>' Visible="False"></asp:Label>
<div> 
 <div style="margin-top:0; font-size:12px; display:block; font-weight:bold; border-bottom:#ccc dotted 1px; height:22px; line-height:22px;" >  <asp:Label ID="Complaint_NameLabel" style="color:#C00;" runat="server" Text='<%# Eval("heading") %>'></asp:Label></div>  
<asp:Label ID="Label_Description" style="font-size:11px;" runat="server" Text='<%# Eval("Description") %>'></asp:Label>
</div> 
<asp:DataList ID="DataList_Presenting_Complaint" runat="server" 
DataSourceID="SqlDS_Presenting_Complaint" OnPreRender="DataList_Presenting_Complaint_PreRender" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                  <ItemTemplate>
                                  
 <div style="margin-top:4; font-size:11px; display:inline-block; height:auto;" >                                 
<strong><asp:Label ID="Sub_TypeLabel" runat="server" Text='<%# Eval("Sub_Type") %>'></asp:Label> :</strong>   
<asp:Label ID="ComponentNameLabel" runat="server" Text='<%# Eval("ComponentName") %>'></asp:Label>  
<asp:Label ID="datetimeLabel" runat="server" Text='<%# Eval("datetime") %>' Visible="False"></asp:Label>  <span style="padding-left:5px; padding-right:5px; color:#ccc;">|</span>
 </div>

 </ItemTemplate>

</asp:DataList>  
</div>   
                              
                              
                          <asp:SqlDataSource ID="SqlDS_Presenting_Complaint" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                              ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                              SelectCommand="SELECT Admin_Complaint_Element.Sub_Type, pt_Save_Presenting_Complaints.ComponentName, pt_Save_Presenting_Complaints.datetime&#13;&#10;FROM         pt_Save_Presenting_Complaints INNER JOIN&#13;&#10;                      Admin_Complaint_Element ON pt_Save_Presenting_Complaints.Sub_Type_ID = Admin_Complaint_Element.Sub_Type_ID&#13;&#10;WHERE     (pt_Save_Presenting_Complaints.YearlyNo = @YearlyNo) and (pt_Save_Presenting_Complaints.RegNo = @RegNo) and (pt_Save_Presenting_Complaints.Complaint_ID = @Complaint_ID)">
                              <SelectParameters>
                                  <asp:ControlParameter ControlID="HF_PayID" Name="YearlyNo" PropertyName="Value" />
                                  <asp:ControlParameter ControlID="HF_RegNo" Name="RegNo" PropertyName="Value" />
                                  <asp:ControlParameter ControlID="HF_Presenting_Complaint_ID" Name="Complaint_ID"
                                      PropertyName="Value" />
                              </SelectParameters>
                          </asp:SqlDataSource>
                          <asp:HiddenField ID="HF_Presenting_Complaint_ID" runat="server" Value='<%# Eval("Complaint_ID") %>' />
                          <asp:HiddenField ID="HF_PayID" runat="server" Value='<%# Eval("YearlyNo") %>' />
                          <asp:HiddenField ID="HF_RegNo" runat="server" Value='<%# Eval("RegNo") %>' />
                      </ItemTemplate>
                  </asp:DataList>
                  
               
          <asp:SqlDataSource ID="dsPrestingComplaintsMain" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                      SelectCommand="SELECT CONVERT (varchar, Pt_Presenting_Complaint_saveRecord.Date, 103) AS Date, Admin_Complaint_MainGroup.Complaint_Name + ' ' + CONVERT (varchar, Pt_Presenting_Complaint_saveRecord.Duration) + ' ' + Pt_Presenting_Complaint_saveRecord.Duration_Time AS heading, Pt_Presenting_Complaint_saveRecord.Description, Pt_Presenting_Complaint_saveRecord.Complaint_ID, Pt_Presenting_Complaint_saveRecord.YearlyNo, Pt_Presenting_Complaint_saveRecord.RegNo FROM Pt_Presenting_Complaint_saveRecord INNER JOIN Admin_Complaint_MainGroup ON Pt_Presenting_Complaint_saveRecord.Complaint_ID = Admin_Complaint_MainGroup.Complaint_ID WHERE (Pt_Presenting_Complaint_saveRecord.YearlyNo = @YearlyNo) AND (Pt_Presenting_Complaint_saveRecord.RegNo = @RegNo) ORDER BY Date">
                      <SelectParameters>
                          <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                          <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                      </SelectParameters>
                  </asp:SqlDataSource>
                  
          <asp:ObjectDataSource ID="ObjectDataSource_PT_PresentingComplaint" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="XMLGeneratationTableAdapters.pt_Presenting_complaintTableAdapter">
              <SelectParameters>
                  <asp:SessionParameter Name="Yearlyno" SessionField="YearlyNO" Type="Decimal" />
                  <asp:SessionParameter Name="RegNO" SessionField="RegistrationNo" Type="String" />
              </SelectParameters>
          </asp:ObjectDataSource>
          
          <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="ReportsTableAdapters.HistoryExamination_kihTableAdapter">
              <SelectParameters>
                  <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
                  <asp:SessionParameter DefaultValue="" Name="RegNo" SessionField="RegistrationNo"
                      Type="String" />
              </SelectParameters>
          </asp:ObjectDataSource>
          
          <asp:ObjectDataSource ID="ObjectDataSource_History" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="ReportsTableAdapters.HistoryExamination_kihTableAdapter">
              <SelectParameters>
                  <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
                  <asp:SessionParameter DefaultValue="" Name="RegNo" SessionField="RegistrationNo"
                      Type="String" />
              </SelectParameters>
          </asp:ObjectDataSource>
          
          
          
        <h1 class="h1" ><span>History</span></h1>   
        
        
          <asp:DataList ID="DataList_His" runat="server"  DataSourceID="SqlDataSource_Hist_MG" Width="100%" RepeatLayout="Flow" >
              <ItemTemplate>
            
      
  <div style="display:block; height:auto; border:#ccc solid 1px; border-radius:4px; padding:5px;" >
  
<div> 
 <div style="margin-top:0; font-size:12px; display:block; font-weight:bold; border-bottom:#ccc dotted 1px; height:22px; line-height:22px;" >  <asp:Label ID="MG_NameLabel" style="color:Red;" runat="server" Text='<%# Eval("MH_Heading") %>'></asp:Label></div>  
<asp:Label ID="RemarksLabel" style="font-size:11px;" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label> 
</div>     
      
      
      
                      <asp:DataList ID="DataList_His_Sub" runat="server" DataKeyField="ID" DataSourceID="SqlDS_His_Sub" Width="100%" RepeatDirection="Horizontal" RepeatLayout="Flow">
                          <ItemTemplate>
                          
     <div style="margin-top:4; font-size:11px; display:inline-block; height:auto;" >   
      <asp:Label ID="MH_HeadingLabel" runat="server" Text='<%# Eval("MH_Heading") %>' Visible="False"></asp:Label>                              
 <strong>  <asp:Label ID="MG_NameLabel" Visible="false" runat="server" Text='<%# Eval("MG_Name") %>'></asp:Label> </strong>  
 <asp:Label ID="e_NameLabel" runat="server" style="color:#333;" Text='<%# Eval("e_Name") %>'></asp:Label> :  
<asp:Label ID="ev_CodeLabel" style="color:#006699;" runat="server" Text='<%# Eval("ev_Code") %>'></asp:Label>  <asp:Label ID="DateTmeLabel" runat="server" Text='<%# Eval("DateTme") %>' Visible="False"></asp:Label><span style="padding-left:5px; padding-right:5px; color:#ccc;">|</span>
 </div>                      
                          
 
                          </ItemTemplate>
                      </asp:DataList> 
                   
</div>


                      
                  <asp:SqlDataSource ID="SqlDS_His_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>"
                      SelectCommand="SELECT     Pt_history_SaveRecord.MG_Code, Pt_history_SaveRecord.e_Code, Pt_history_SaveRecord.ev_Code, Pt_history_SaveRecord.YearlyNo, &#13;&#10;                      Pt_history_SaveRecord.RegNo, Pt_history_SaveRecord.DateTme, Pt_history_SaveRecord.Emp_ID, Pt_history_SaveRecord.Ele_Status, Pt_history_SaveRecord.ID, &#13;&#10;                       admin_History_MainGroup.MG_Name, &#13;&#10;                      Admin_History_Main_Heading.MH_Heading, admin_History_Elements.e_Name, Admin_History_MainHeading_Group.MH_Code&#13;&#10;FROM         Admin_History_MainHeading_Group INNER JOIN&#13;&#10;                      admin_History_MainGroup ON Admin_History_MainHeading_Group.Mg_Code = admin_History_MainGroup.MG_Code INNER JOIN&#13;&#10;                      Pt_history_SaveRecord ON admin_History_MainGroup.MG_Code = Pt_history_SaveRecord.MG_Code INNER JOIN&#13;&#10;                      Admin_History_Main_Heading ON Admin_History_MainHeading_Group.MH_Code = Admin_History_Main_Heading.MH_Code INNER JOIN&#13;&#10;                      admin_History_Elements ON Pt_history_SaveRecord.e_Code = admin_History_Elements.e_Code AND &#13;&#10;                      Pt_history_SaveRecord.MG_Code = admin_History_Elements.MG_Code&#13;&#10;WHERE     (Pt_history_SaveRecord.RegNo = @RegNo) AND (Pt_history_SaveRecord.YearlyNo = @YearlyNo) AND &#13;&#10;                      (Admin_History_MainHeading_Group.MH_Code = @MH_Code)&#13;&#10;">
                      <SelectParameters>
                          <asp:ControlParameter ControlID="HF_RegNo" Name="RegNo" PropertyName="Value" />
                          <asp:ControlParameter ControlID="HF_YearlyNo" Name="YearlyNo" PropertyName="Value" />
                          <asp:ControlParameter ControlID="HF_MH_Code" Name="MH_Code" PropertyName="Value" />
                      </SelectParameters>
                  </asp:SqlDataSource>
                  <asp:HiddenField ID="HF_RegNo" runat="server" Value='<%# Eval("Reg_No") %>' />
                  <asp:HiddenField ID="HF_YearlyNo" runat="server" Value='<%# Eval("Yearly_No") %>' />
                  <asp:HiddenField ID="HF_MH_Code" runat="server" Value='<%# Eval("MH_Code") %>' />
                  
              </ItemTemplate>
          </asp:DataList>
          
          
        

          
          <asp:SqlDataSource ID="SqlDataSource_Hist_MG" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
              ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
              SelectCommand="SELECT 'History' AS [Main Group], OPD_Encounter_Form_Remarks.Remarks, OPD_Encounter_Form_Remarks.MH_Code, Admin_History_Main_Heading.MH_Heading, OPD_Encounter_Form_Remarks.Reg_No, OPD_Encounter_Form_Remarks.Yearly_No, OPD_Encounter_Form_Remarks.Type_val FROM OPD_Encounter_Form_Remarks INNER JOIN Admin_History_Main_Heading ON OPD_Encounter_Form_Remarks.MH_Code = Admin_History_Main_Heading.MH_Code WHERE (OPD_Encounter_Form_Remarks.Yearly_No = @YearlyNo) AND (OPD_Encounter_Form_Remarks.Reg_No = @RegNo) AND (OPD_Encounter_Form_Remarks.Type_val = 'HIS') ORDER BY Admin_History_Main_Heading.Priority">
              <SelectParameters>
                  <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                  <asp:SessionParameter Name="RegNo" SessionField="RegistrationNO" />
              </SelectParameters>
          </asp:SqlDataSource>
         
        
        
        
 <h1 class="h1" >
        <span>Examination</span></h1>
        
         
          <asp:DataList ID="DataList_Vitals" runat="server" DataSourceID="ObjectDataSource_Vitals" Width="100%"  RepeatDirection="Horizontal" RepeatLayout="Flow">
              <ItemTemplate>
              
             
 
              

  <div style="display:block; height:auto; border:#ccc solid 1px; border-radius:4px; padding:5px;" >
  
<div> 
 <div style="margin-top:0; font-size:12px; display:block; font-weight:bold; border-bottom:#ccc dotted 1px; height:22px; line-height:22px;" >    <asp:Label ID="VitalNameLabel" runat="server" Text='<%# Eval("VitalName") %>'></asp:Label> </div>  
<asp:Label ID="ResultLabel" runat="server" Text='<%# Eval("Result") %>'></asp:Label><span class="span">|</span>
</div>                   
 
 </div>               
                
              </ItemTemplate>
          </asp:DataList>
            
                
          
 
          <asp:ObjectDataSource ID="ObjectDataSource_Vitals" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="XMLGeneratationTableAdapters.VitalsTableAdapter">
              <SelectParameters>
                  <asp:SessionParameter Name="RegNO" SessionField="RegistrationNo" Type="String" />
                  <asp:SessionParameter Name="Yearlyno" SessionField="YearlyNO" Type="Decimal" />
              </SelectParameters>
          </asp:ObjectDataSource> 
            
        
        
        
<asp:DataList ID="DataList_Examination" runat="server" DataSourceID="SqlDataSource_Examination" Width="100%" >
              <ItemTemplate>
 
 <div style="display:block; height:auto; border:#ccc solid 1px; border-radius:4px; padding:5px;" >
  
<div> 
 <div style="margin-top:0; font-size:12px; display:block; font-weight:bold; border-bottom:#ccc dotted 1px; height:22px; line-height:22px;" >         
<strong class="mname" ><asp:Label ID="MH_HeadingLabel" runat="server" Text='<%# Eval("MH_Heading") %>'> </asp:Label> </strong></div>
            
<asp:Label ID="RemarksLabel" runat="server" style="font-size:11px;"   Text='<%# Eval("Remarks") %>'></asp:Label>
<asp:Label ID="Label_MHeadingCode" Visible="false" runat="server" Text='<%# Eval("MH_Code") %>'></asp:Label>
 </div> </div>               
                
                
                  <asp:DataList ID="DataList_ExaminationGroups" runat="server" DataKeyField="MG_Code"
                      DataSourceID="SqlDataSource_ExaminationGroup">
                      <ItemTemplate>
                          <asp:Label ID="MG_CodeLabel" runat="server" Text='<%# Eval("MG_Code") %>'></asp:Label> 
                        <asp:Label ID="MG_NameLabel" runat="server" Text='<%# Eval("MG_Name") %>'></asp:Label> 
                        
                      </ItemTemplate>
                  </asp:DataList><asp:SqlDataSource ID="SqlDataSource_ExaminationDetail" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                   ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                   SelectCommand="SELECT DISTINCT &#13;&#10;                      admin_Phy_Exam_MainGroup.MG_Code, admin_Phy_Exam_MainGroup.MG_Name, Pt_physical_exam_saveRecord.Exam_Result, &#13;&#10;                      admin_Phy_Exam_Elements.e_Name&#13;&#10;FROM         admin_Phy_Exam_MainGroup INNER JOIN&#13;&#10;                      admin_Phy_Exam_Elements ON admin_Phy_Exam_MainGroup.MG_Code = admin_Phy_Exam_Elements.MG_Code INNER JOIN&#13;&#10;                      Pt_physical_exam_saveRecord ON admin_Phy_Exam_Elements.e_Code = Pt_physical_exam_saveRecord.E_ID INNER JOIN&#13;&#10;                      Admin_Exam_MainHeading_Group ON admin_Phy_Exam_MainGroup.MG_Code = Admin_Exam_MainHeading_Group.Mg_Code&#13;&#10;WHERE     (Pt_physical_exam_saveRecord.RegNo = @RegNo) AND (Pt_physical_exam_saveRecord.YearlyNo = @YearlyNo) AND &#13;&#10;                      (Admin_Exam_MainHeading_Group.MH_Code = @MH_Code)">
                   <SelectParameters>
                       <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                       <asp:SessionParameter Name="RegNo" SessionField="RegistrationNO" />
                       <asp:ControlParameter ControlID="Label_MHeadingCode" Name="MH_Code" PropertyName="Text" />
                   </SelectParameters>
               </asp:SqlDataSource>
               
               
                 <ul class="medication" style="border-bottom:0px; border-right:0px; border-left:0px;"   >
              <li style="border-right:0px; border-left:0px;" >
<asp:DataList ID="DataList_ExaminationDetail" runat="server" DataSourceID="SqlDataSource_ExaminationDetail" Width="100%"
                  RepeatDirection="Horizontal"  RepeatLayout="Flow" >
                   <ItemTemplate>
                      
                     <strong>  <asp:Label ID="e_NameLabel" runat="server" Text='<%# Eval("e_Name") %>'></asp:Label></strong> :
                      
                       <asp:Label ID="Exam_ResultLabel" runat="server" Text='<%# Eval("Exam_Result") %>'></asp:Label> <span class="span">|</span>
                      
                   </ItemTemplate>
               </asp:DataList>  
               
               </li>    </ul> 
                
                  <asp:SqlDataSource ID="SqlDataSource_ExaminationGroup" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                      SelectCommand="SELECT DISTINCT admin_Phy_Exam_MainGroup.MG_Code, admin_Phy_Exam_MainGroup.MG_Name FROM Admin_History_MainHeading_Group INNER JOIN admin_Phy_Exam_MainGroup ON Admin_History_MainHeading_Group.MH_Code = admin_Phy_Exam_MainGroup.MG_Code INNER JOIN admin_Phy_Exam_Elements ON admin_Phy_Exam_MainGroup.MG_Code = admin_Phy_Exam_Elements.MG_Code INNER JOIN Pt_physical_exam_saveRecord ON admin_Phy_Exam_Elements.e_Code = Pt_physical_exam_saveRecord.E_ID &#13;&#10;WHERE (Pt_physical_exam_saveRecord.RegNo = @RegNo) AND (Pt_physical_exam_saveRecord.YearlyNo = @YearlyNo) &#13;&#10;AND (Admin_History_MainHeading_Group.MH_Code = @MH_Code)">
                      <SelectParameters>
                          <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                          <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                          <asp:ControlParameter ControlID="Label_MHeadingCode" Name="MH_Code" PropertyName="Text" />
                      </SelectParameters>
                  </asp:SqlDataSource>
            
              
              </ItemTemplate>
          </asp:DataList>
          
          <asp:SqlDataSource ID="SqlDataSource_Examination" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
              ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>"
              SelectCommand="SELECT Admin_Exam_Main_Heading.MH_Heading, OPD_Encounter_Form_Remarks.Remarks, Admin_Exam_Main_Heading.MH_Code, OPD_Encounter_Form_Remarks.Type_val FROM Admin_Exam_Main_Heading INNER JOIN OPD_Encounter_Form_Remarks ON Admin_Exam_Main_Heading.MH_Code = OPD_Encounter_Form_Remarks.MH_Code WHERE (OPD_Encounter_Form_Remarks.Yearly_No = @YearlyNo) AND (OPD_Encounter_Form_Remarks.Reg_No = @RegNo) AND (OPD_Encounter_Form_Remarks.Type_val = 'PHY')">
              <SelectParameters>
                  <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                  <asp:SessionParameter Name="RegNo" SessionField="RegistrationNO" />
              </SelectParameters>
          </asp:SqlDataSource>
 
 
 
             
    <h1 class="h1"><span>Previous Investigations</span></h1>
                 
                 <strong style="border:#CCCCCC solid 1px;  padding:3px; width:99%; display:inline-block; font-size:12px;">Pathology</strong>
                 <br />

                 <asp:DataList ID="DataList_Pathology"   runat="server" DataSourceID="SqlDataSource_Pathology" Width="100%">
                     <ItemTemplate>
                          <table  cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                             <tr>
                                 <td >
                                     <asp:Label ID="Discharge_HeadingLabel" runat="server" Font-Bold="True" Text='<%# Eval("TGName") %>'></asp:Label></td>
                             </tr>
                             <tr>
                                 <td  >
                                     <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Eval("Description") %>'></asp:Label></td>
                             </tr>
                         </table>
                     </ItemTemplate>
                 </asp:DataList><br />
                 
                 
                 
                 <strong style="border:#CCCCCC solid 1px;  padding:3px; display:inline-block; width:99%; font-size:12px; ">Radiology</strong>
                 <br />
                 <asp:DataList ID="DataList2" runat="server" DataSourceID="SqlDataSource_Radiology" Width="100%">
                     <ItemTemplate>
                       <table  cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                             <tr>
                                 <td  >
                                     <asp:Label ID="Discharge_HeadingLabel" runat="server" Font-Bold="True" Text='<%# Eval("TGName") %>'></asp:Label></td>
                             </tr>
                             <tr>
                                 <td  >
                                     <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Eval("Description") %>'></asp:Label></td>
                             </tr>
                         </table>
                     </ItemTemplate>
                 </asp:DataList>
                 <asp:SqlDataSource ID="SqlDataSource_Radiology" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                     ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                     SelectCommand="SELECT   View_TG.TGName,  Previous_Investigation.Description&#13;&#10;FROM         Previous_Investigation INNER JOIN&#13;&#10;                          (SELECT     TGName, TGID&#13;&#10;                            FROM          Admin_Radiology.dbo.TestGroup) AS View_TG ON View_TG.TGID = Previous_Investigation.Test_Group_ID&#13;&#10;WHERE     (Previous_Investigation.Test_Type = 'Radiology') AND (Previous_Investigation.Yearly_No = @Yearly_No) AND (Previous_Investigation.Reg_No = @Reg_No)"
                     UpdateCommand="UPDATE Payment SET DischargeStatus = @DischargeStatus WHERE (RegNo = @RegNo) AND (PayID = @PayID)">
                     <UpdateParameters>
                         <asp:ControlParameter ControlID="RadioButtonList_Category" Name="DischargeStatus"
                             PropertyName="SelectedValue" />
                         <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                         <asp:SessionParameter Name="PayID" SessionField="YearlyNo" />
                     </UpdateParameters>
                     <SelectParameters>
                         <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" />
                         <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" />
                     </SelectParameters>
                     <UpdateParameters>
                         <asp:ControlParameter ControlID="RadioButtonList_Category" Name="DischargeStatus"
                             PropertyName="SelectedValue" />
                         <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                         <asp:SessionParameter Name="PayID" SessionField="YearlyNo" />
                     </UpdateParameters>
                 </asp:SqlDataSource>
                 <asp:SqlDataSource ID="SqlDataSource_Pathology" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                     ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                     SelectCommand="SELECT   View_TG.TGName,  Previous_Investigation.Description&#13;&#10;FROM         Previous_Investigation INNER JOIN&#13;&#10;                          (SELECT DISTINCT TestGroup.TGID, TestGroup.TGName, Admin_Dept_Services.Dept_ID, TestGroup.TGID as MG_ID &#13;&#10;FROM Pathology2.dbo.Test_Booking LEFT OUTER JOIN Pathology2.dbo.Admin_Dept_Services ON Test_Booking.S_Id = Admin_Dept_Services.S_ID &#13;&#10;LEFT OUTER JOIN Pathology2.dbo.TestGroup ON Test_Booking.MG_ID = TestGroup.TGID WHERE (Admin_Dept_Services.Dept_ID = 10) &#13;&#10;) AS View_TG ON View_TG.TGID = Previous_Investigation.Test_Group_ID&#13;&#10;WHERE     (Previous_Investigation.Test_Type = 'Pathology') AND (Previous_Investigation.Yearly_No = @Yearly_No) AND (Previous_Investigation.Reg_No = @Reg_No)"
                     UpdateCommand="UPDATE Payment SET DischargeStatus = @DischargeStatus WHERE (RegNo = @RegNo) AND (PayID = @PayID)">
                     <SelectParameters>
                         <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" />
                         <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" />
                     </SelectParameters>
                 </asp:SqlDataSource>
                 
                 
                 
                 <h1 class="h1">
                     <span>Procedure</span></h1> 
   
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_Procedure" Width="100%" style="display:none;">
        <Columns>
            <asp:BoundField DataField="Operation Day" HeaderText="Operation Day" SortExpression="Operation Day" />
            <asp:BoundField DataField="ExpectedOpDate" HeaderText="Operation Date" SortExpression="ExpectedOpDate" />
            <asp:BoundField DataField="Procedure_Name" HeaderText="Procedures" SortExpression="Procedure_Name" />
            <asp:BoundField DataField="AnaesthesiaType" HeaderText="Anaesthesia" SortExpression="AnaesthesiaType" />
            <asp:BoundField DataField="CanDelayFor" HeaderText="Can Delay For" SortExpression="CanDelayFor" />
            <asp:BoundField DataField="ICU_Stay" HeaderText="ICU Stay" SortExpression="ICU_Stay" />
        </Columns>
    </asp:GridView> 
    <asp:DataList ID="DataList_Procedure" runat="server" DataKeyField="OP_Recommended_Id" Width="100%"
        DataSourceID="SqlDataSource_Procedure">
        <ItemTemplate>
        <ul class="medication"  >
        
        <li style="border-bottom: #cccccc dotted 1px; border-right: 0; border-left: 0; ">
        <strong class="mname" >
                    
      <asp:Label ID="Procedure_NameLabel" runat="server" style="" Text='<%# Eval("Procedure_Name") %>'></asp:Label>
                </strong></li>
        
             <li>Recommended By :
            <asp:Label ID="Recommended_ByLabel" runat="server" Text='<%# Eval("[Recommended By]") %>'>
            </asp:Label><span class="span">|</span>
             Advice :
            <asp:Label ID="AdviceLabel" runat="server" Text='<%# Eval("Advice") %>'></asp:Label><span class="span">|</span>
            
             Expected OpDate :
            <asp:Label ID="ExpectedOpDateLabel" runat="server" Text='<%# Eval("ExpectedOpDate") %>'>
            </asp:Label><span class="span">|</span>
            
            <asp:Label ID="AnaesthesiaTypeLabel" runat="server" Text='<%# Eval("AnaesthesiaType") %>' Visible="False"></asp:Label>&nbsp;
            <asp:Label ID="CanDelayForLabel" runat="server" Text='<%# Eval("CanDelayFor") %>' Visible="False"></asp:Label>ICU Stay :
            <asp:Label ID="ICU_StayLabel" runat="server" Text='<%# Eval("ICU_Stay") %>'></asp:Label> </li>
            
          </ul>  
          
            
        </ItemTemplate>
    </asp:DataList>
    
 
  
    <h1 class="h1" ><span>Dignosis/Assesment</span></h1>  
 
    <asp:DataList ID="DataList_Diagnosis" runat="server" DataKeyField="Diagnosis_ID" Width="100%" DataSourceID="SqlDataSourceDiagnosis">
        <ItemTemplate>
        <ul class="medication" >           
         <li style="border-bottom: #cccccc dotted 1px; border-right: 0; border-left: 0; margin-top:-3; ">
         <strong><asp:Label ID="ICD_NameLabel" runat="server" Text='<%# Eval("[ICD Name]") %>'></asp:Label></strong> &nbsp; ( <asp:Label style="color:#003399;" ID="ICD_CodeLabel" runat="server" Text='<%# Eval("[ICD Code]") %>'></asp:Label> )<asp:Label ID="ProvisionalLabel" runat="server" Style="font-size: 10px" Text='<%# Eval("Provisional_Val") %>'
                 ToolTip="Provisional"></asp:Label></li>
            </ul>

        </ItemTemplate>
    </asp:DataList>
    <asp:SqlDataSource ID="SqlDataSource_Procedure" runat="server" ConnectionString="<%$ ConnectionStrings:OperationTheaterConnectionString %>"
        SelectCommand="Select_Pt_Recomm_Operation" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="Reg_No" SessionField="RegistrationNO" Type="String" />
            <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNO" Type="Decimal" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
          
    <asp:SqlDataSource ID="SqlDataSourceTest" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT CONVERT(varchar, Date_Time, 103) AS TestDate&#13;&#10;FROM         Investigation_Order_Main&#13;&#10;WHERE     (YearlyNo = @PayID) and (RegNo = @RegNo)">
        <SelectParameters>
            <asp:SessionParameter Name="PayID" SessionField="YearlyNO" Type="Int32" />
            <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    
     
 
 
 
    <h1 class="h1" ><span>Physician Order/Plan</span></h1>  
 
 
 
   <h1 class="h1" style="background-image:none; box-shadow:none; margin-left:15px; width:90%;" >
    <span style="background-image:none; padding-left:0;">Lab Investigations</span>
   </h1>  
    
    <asp:DataList ID="DataList_Test" runat="server" DataSourceID="SqlDataSourceTest" Width="90%" style="margin-left:15px;">
        <ItemTemplate>
        <ul class="medication" > 
        
         <li style="border-bottom: #cccccc dotted 1px; border-right: 0; border-left: 0;"> 
            
            <strong class="mname"   >   <asp:Label ID="Label_TestDate" runat="server" Text='<%# Eval("TestDate") %>'></asp:Label></strong></li>
             
             
             
             <asp:DataList ID="DataList_Test_Sub" runat="server" DataSourceID="SqlDataSource_Test_Sub">
                <ItemTemplate>
<li style="height:auto; padding-bottom:4px; font-size:11px; padding-right:5px;"><strong ><asp:Label ID="TGNameLabel" runat="server" Text='<%# Eval("TGName") %>'></asp:Label></strong> :
<asp:Label ID="TB_NameLabel" runat="server" Text='<%# Eval("TBName") %>'></asp:Label> 
</li>
</ItemTemplate>
</asp:DataList>
          </ul>
            <asp:SqlDataSource ID="SqlDataSource_Test_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                SelectCommand="SELECT DISTINCT TestGroup.TGName,dbo.[Pathology_TB_Name_1](Investigation_Order_Main.YearlyNo,Investigation_Order_Main.RegNo,TestGroup.TGID) as TBName&#13;&#10;FROM         Test_Booking INNER JOIN&#13;&#10;                      TestGroup ON Test_Booking.MG_ID = TestGroup.TGID INNER JOIN&#13;&#10;                      Investigation_Order_Sub INNER JOIN&#13;&#10;                      Investigation_Order_Main ON Investigation_Order_Sub.Investigation_Order_ID = Investigation_Order_Main.Investigation_Order_ID ON &#13;&#10;                      Test_Booking.TB_ID = Investigation_Order_Sub.TB_ID&#13;&#10;WHERE     (Investigation_Order_Main.YearlyNo = @YearlyNo) AND (Investigation_Order_Main.RegNo = @RegNo) and (CONVERT(varchar,Investigation_Order_Main.Date_Time, 103) = @Date)&#13;&#10;">
                <SelectParameters>
                    <asp:Parameter Name="YearlyNo" />
                    <asp:Parameter Name="RegNo" />
                    <asp:Parameter Name="Date" />
                </SelectParameters>
            </asp:SqlDataSource>
        </ItemTemplate>
    </asp:DataList>
    
 
 
   <h1 class="h1" style="background-image:none; box-shadow:none; width:90%; margin-left:15px;  " ><span style="background-image:none; padding-left:0;">Diagnostic Investigations</span></h1>  
    
    <asp:DataList ID="DataList_Radiology" runat="server" DataSourceID="SqlDataSourceRadiology" Width="90%"  style="margin-left:15px;">
        <ItemTemplate>
        
          <ul class="medication">  
       
       <li style="border-bottom: #cccccc dotted 1px; border-right: 0; border-left: 0;">
        <strong class="mname" > 
       <asp:Label ID="Label_Date" runat="server" Text='<%# Eval("DateTime") %>'></asp:Label></strong></li> 
            <asp:DataList ID="DataList_Radiology_Sub" runat="server" DataSourceID="SqlDataSource_Radiology_Sub">
                <ItemTemplate>
              <li style="border:0; height:auto; font-size:11px; padding-right:5px; ">    <strong> <asp:Label ID="RIDLabel" runat="server" Text='<%# Eval("TGName") %>'></asp:Label></strong> :
                    <asp:Label ID="RadiologyNameLabel" runat="server" Text='<%# Eval("tbname") %>'></asp:Label></li> 
                    
                </ItemTemplate>
            </asp:DataList> </ul>
            <asp:SqlDataSource ID="SqlDataSource_Radiology_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                SelectCommand="SELECT DISTINCT Radiology.dbo.TestGroup.TGName, dbo.Radiology_TB_Name_1(Radiology_Order_Main.YearlyNo, Radiology_Order_Main.RegNo, &#13;&#10;                      Radiology.dbo.TestGroup.TGID) AS tbname&#13;&#10;FROM         Radiology_Order_Sub INNER JOIN&#13;&#10;                      Radiology_Order_Main ON Radiology_Order_Sub.Order_ID = Radiology_Order_Main.Order_ID INNER JOIN&#13;&#10;                      Radiology.dbo.Test_Booking ON Radiology_Order_Sub.TB_ID = Radiology.dbo.Test_Booking.TB_ID INNER JOIN&#13;&#10;                      Radiology.dbo.TestGroup ON Radiology.dbo.Test_Booking.MG_ID = Radiology.dbo.TestGroup.TGID&#13;&#10;WHERE  (Radiology_Order_Main.YearlyNo = @YearlyNo) AND (Radiology_Order_Main.RegNo =@RegNo) AND (CONVERT(varchar, Radiology_Order_Main.Date_Time, 103) &#13;&#10;                      = @Date)">
                <SelectParameters>
                    <asp:Parameter Name="YearlyNo" />
                    <asp:Parameter Name="RegNo" />
                    <asp:Parameter Name="Date" />
                </SelectParameters>
            </asp:SqlDataSource>
        </ItemTemplate>
    </asp:DataList>
    
    
            

          
   <h1 class="h1" style="background-image:none; box-shadow:none; width:90%; margin-left:15px;  " ><span style="background-image:none; padding-left:0;">Medication</span></h1>  
   
  
  
          <asp:DataList ID="DataList_ConfirmedPrescriptions" runat="server" DataKeyField="priscription_id"
              DataSourceID="SqlDataSource_Confirmed_Prescriptions" Width="90%" style="margin-left:15px;">
              <ItemTemplate>
                  <ul class="medication">
                      <li style="border-bottom: #cccccc dotted 1px; border-right: 0; border-left: 0;"><strong
                          class="mname">
                          <%# Eval("[Medicine Name]") %>
                      </strong> 
                          <%#Eval("Para")%>
                          
                      </li>
                  </ul> <asp:HiddenField ID="HiddenField_PrescriptionID" runat="server" Value='<%# Eval("priscription_id") %>' />
              </ItemTemplate>
          </asp:DataList>
          
          
          
          <asp:SqlDataSource ID="SqlDataSource_Confirmed_Prescriptions" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
              DeleteCommand="DELETE FROM Pt_Prescription_Detail WHERE (priscription_id = @priscription_id)"
              SelectCommand="SELECT     ISNULL(Medicine.Category, '') + ' ' + ISNULL(Medicine.MGName, '') + ' ' + ISNULL(Medicine.Potency, '') + ' ' + ISNULL(Medicine.Unit, '') AS [Medicine Name], &#13;&#10;                      ISNULL(Pt_Prescription_Detail.Meal, '') AS Meal, Pt_Prescription_Detail.Dosage AS Qty, Medicine_Frequency.Name AS Doze, CONVERT(varchar, &#13;&#10;                      Pt_Prescription_Detail.StartDate, 103) AS [Start Date], Pt_Prescription_Detail.days, CONVERT(varchar, Pt_Prescription_Detail.EndDate, 103) AS [End Date], &#13;&#10;                      ISNULL(Pt_Prescription_Detail.Dose, '') AS Dosage, Medicine_Frequency.Occasion, ISNULL(Pt_Prescription_Detail.CT, '') AS CT, &#13;&#10;                      Pt_Prescription_Detail.priscription_id, Medicine_Frequency.Name +  ' ' + [dbo].[fx_Prescription_Frequency](Pt_Prescription_Detail.priscription_id) + ' ' + ISNULL(Medicine.Category, '') + ' for ' + convert(varchar,Pt_Prescription_Detail.days) +' Days from ' + CONVERT(varchar,Pt_Prescription_Detail.StartDate, 103) + ' to ' + CONVERT(varchar, Pt_Prescription_Detail.EndDate, 103) as Para&#13;&#10;FROM         Pt_Prescription_Detail INNER JOIN&#13;&#10;                      Medicine ON Pt_Prescription_Detail.Med_Code = Medicine.MedCode LEFT OUTER JOIN&#13;&#10;                      Medicine_Frequency ON Pt_Prescription_Detail.Frequency_ID = Medicine_Frequency.id&#13;&#10;WHERE (Pt_Prescription_Detail.Registration_NO = @RegNo) AND (Pt_Prescription_Detail.Yearly_NO = @YearlyNo) AND (NOT (Pt_Prescription_Detail.ConfirmedBy IS NULL)) AND (NOT (Pt_Prescription_Detail.ConfirmedDate IS NULL)) ">
              <SelectParameters>
                  <asp:SessionParameter Name="RegNo" SessionField="registrationno" Type="String" />
                  <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
              </SelectParameters>
              <DeleteParameters>
                  <asp:ControlParameter ControlID="HiddenField_Prescription_Id" Name="priscription_id"
                      PropertyName="Value" />
              </DeleteParameters>
          </asp:SqlDataSource>
         
    
    
    <asp:SqlDataSource ID="SqlDataSourceRadiology" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
        SelectCommand="SELECT DISTINCT CONVERT(varchar, Date_Time, 103) AS DateTime&#13;&#10;FROM         Radiology_Order_Main&#13;&#10;WHERE     (YearlyNo = @PayID) and (RegNo = @RegNo)&#13;&#10;">
        <SelectParameters>
            <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" Type="String" />
            <asp:SessionParameter Name="PayID" SessionField="YearlyNo" Type="Decimal" />
        </SelectParameters>
    </asp:SqlDataSource> 
    
    
   <h1 class="h1" style="background-image:none; box-shadow:none; width:90%; margin-left:15px;"  ><span style="background-image:none; padding-left:0;">General Order</span></h1>  
   


  <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource_Physician_Order_Main" Width="90%" style="margin-left:15px;">
                <ItemTemplate>
                
               <ul class="medication" > 
        
         <li style="border-bottom:#cccccc dotted 1px; border-right: 0; border-left: 0;"> 
            
            <strong class="mname" >     
                
                
                     <asp:Label ID="St_DateLabel" runat="server" Text='<%# Eval("St_Date") %>'></asp:Label> </strong></li>
                   
                    <asp:DataList ID="DataList_Physician_Order_Sub" runat="server" DataSourceID="SqlDataSource_Physician_Order_Sub" Width="100%">
                        <ItemTemplate>
                          <li style="border:0;">  <asp:Label ID="Label_Instruction" runat="server" Text='<%# Eval("Instruction") %>'></asp:Label> 
                            <asp:Label ID="Label_OrderBy" runat="server" Visible="false" Text='<%# Eval("[Order By]") %>'></asp:Label></li>
                        </ItemTemplate>
                    </asp:DataList> 
            </ul>        
                    
                    
                    <asp:SqlDataSource ID="SqlDataSource_Physician_Order_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                        SelectCommand="SELECT     Admin_Physician_Order.Phy_Ord_Name, ISNULL(Employee.Prefix, '') + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') &#13;&#10;                      + ' ' + ISNULL(Employee.ELName, '') + ' (' + Designation.Designation_Name + ')' AS [Order By], Pt_Physician_Order.For_Every, &#13;&#10;                      ISNULL(Pt_Physician_Order.Instruction, '') AS Instruction, convert(varchar,Pt_Physician_Order.Start_Data_Time,103) as St_Date, Pt_Physician_Order.End_Date_Time&#13;&#10;FROM         Admin_Physician_Order INNER JOIN&#13;&#10;                      Pt_Physician_Order ON Admin_Physician_Order.Phy_Ord_id = Pt_Physician_Order.Phy_Ord_id INNER JOIN&#13;&#10;                      Employee ON Pt_Physician_Order.Emp_Id = Employee.EmpID INNER JOIN&#13;&#10;                      Designation ON Employee.DesignationID = Designation.Designation_ID&#13;&#10;WHERE     (Pt_Physician_Order.Registration_No = @Registration_No) AND (Pt_Physician_Order.Yearly_No = @Yearly_No) and (convert(varchar,Pt_Physician_Order.Start_Data_Time,103) = @date)&#13;&#10;">
                        <SelectParameters>
                            <asp:SessionParameter Name="Registration_No" SessionField="RegistrationNO" />
                            <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" />
                            <asp:ControlParameter ControlID="St_DateLabel" Name="date" PropertyName="Text" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </ItemTemplate>
            </asp:DataList>

     </td>           
            
            
         
       
         
            
          
            <asp:SqlDataSource ID="SqlDataSource_Physician_Order_Main" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                SelectCommand="SELECT   distinct CONVERT(varchar, Start_Data_Time, 103) AS St_Date&#13;&#10;FROM         Pt_Physician_Order&#13;&#10;WHERE     (Registration_No = @Registration_No) AND (Yearly_No = @Yearly_No)&#13;&#10;ORDER BY CONVERT(varchar, Start_Data_Time, 103)">
                <SelectParameters>
                    <asp:SessionParameter Name="Registration_No" SessionField="RegistrationNO" />
                    <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" />
                </SelectParameters>
            </asp:SqlDataSource>
        <asp:Label ID="LabelFooter" runat="server" Text=""></asp:Label><%--</tr>
            </table>--%></tr>
     
            </table>
   
</form>
</body>

</html>
