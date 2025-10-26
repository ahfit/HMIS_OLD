<%@ Page Language="VB" AutoEventWireup="false" CodeFile="WardMedicineUseRpt.aspx.vb"  MasterPageFile="~/hacims_masterpage.master"
    Inherits="Patient_Registration_PatientFaceSheet" %>

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




 <div align="right" id="mprint"><a href="javascript:window.print()" class="report">Print</a></div>

        <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="tbl_form" >
            <tr>
               
                <td align="center" >
                <ul >
                     <li> <asp:Label runat="server" ID="lbl1" Text="" Font-Bold="True" Font-Size="Large"></asp:Label></li>
                     <li style="line-height:18px;font-weight:bold;font-size:20px;"><asp:Label ID="Label2" runat="server" Text=""></asp:Label> </li>
                     <li style="line-height:18px;font-size:12px;">  <asp:Label ID="Label3" runat="server" Text=""></asp:Label> </li>
                     <li style="line-height:18px;">Phone No :<asp:Label ID="lbl2" runat="server" Text=""></asp:Label> </li>
                     <li style="line-height:18px;"><asp:Label ID="Label1" runat="server" Text="MEDICAL RECORD FACE SHEET" Font-Bold="True"></asp:Label></li>
                     <li style="line-height:18px;"><asp:Label runat="server" ID="lblDate"></asp:Label></li>
                     <li style="line-height:18px;"><asp:Label runat="server" ID="Label4"></asp:Label></li>
                </ul>
             </td>
                 
            </tr>
            </table>
            <br />
            <table cellpadding="0" cellspacing="0" border="0" width="100%" class="Grid_1">
            <tr>
                <td width="16%" align="right"><b> Patient Name :</b></td>
                <td> <asp:Label ID="lblPatientName" runat="server"></asp:Label> </td>
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
             
             <br />
 <asp:GridView ID="GridView_PMUS" runat="server" AutoGenerateColumns="False"
              SkinID="tbl_medication" Width="100%">
              <RowStyle CssClass="GridItem" />
              <Columns>
                  <asp:TemplateField>
                      <HeaderTemplate>
                          <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" height="100%"
                               width="100%">
                              <tr>
                                  <td align="center" height="100%" width="50%">
                                      <strong>Medicine</strong></td>
                                  <td align="center" width="50%">
                                      <strong>Frequency</strong></td>
                              </tr>
                          </table>
                      </HeaderTemplate>
                      <ItemTemplate>
                          <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" height="100%"
                              width="100%">
                              <tr>
                                  <td height="100%" width="50%">
                                      <strong>
                                          <asp:Label ID="Label_Medicine" runat="server" Text='<%# Eval("MGName") %>'></asp:Label></strong></td>
                                  <td width="50%">
                                      <asp:Label ID="Label_Frequency" runat="server" Text='<%# Eval("Frequency") %>'></asp:Label>
                                  </td>
                              </tr>
                          </table>
                          <asp:HiddenField ID="HF_MedCode" runat="server" Value='<%# Eval("Med_Code") %>' />
                          <asp:HiddenField ID="HF_Prescription_id" runat="server" Value='<%# Eval("priscription_id") %>' />
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField>
                      <HeaderTemplate>
                          <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" 
                              width="100%">
                              <tr>
                                  <td align="center" width="50%">
                                      <strong>
                                      Prescribed Hr. of Administration</strong></td>
                              </tr>
                          </table>
                      </HeaderTemplate>
                      <ItemTemplate>
                          <asp:DataList ID="DataList_Frequency" runat="server" DataSourceID="SqlDataSource_Freq_Det"
                              Width="100%">
                              <ItemTemplate>
                                  <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" 
                                      width="100%">
                                      <tr>
                                          <td align="center" style="border: 0;" width="50%">
                                              <asp:Label ID="FrequencyLabel" runat="server" Text='<%# Eval("Frequency") %>'></asp:Label></td>
                                      </tr>
                                  </table>
                              </ItemTemplate>
                          </asp:DataList><asp:SqlDataSource ID="SqlDataSource_Freq_Det" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                              ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                              SelectCommand="SELECT distinct     Medicine_Frequency_Detail.Frequency, PT_Prescription_Frequency_Detail.Dosage&#13;&#10;FROM         PT_Prescription_Frequency_Detail INNER JOIN&#13;&#10;                      Medicine_Frequency_Detail ON PT_Prescription_Frequency_Detail.Frequency_Sub_Id = Medicine_Frequency_Detail.Frequency_Sub_Id INNER JOIN&#13;&#10;                      Pt_Prescription_Detail ON PT_Prescription_Frequency_Detail.Prescription_Id = Pt_Prescription_Detail.priscription_id LEFT OUTER JOIN&#13;&#10;                      PrescriptedMedicineNotGivenDescritpion ON Pt_Prescription_Detail.priscription_id = PrescriptedMedicineNotGivenDescritpion.Prescription_ID AND &#13;&#10;                      Medicine_Frequency_Detail.Frequency_Sub_Id = PrescriptedMedicineNotGivenDescritpion.Frequency_Sub_Id AND &#13;&#10;                      Pt_Prescription_Detail.Med_Code = PrescriptedMedicineNotGivenDescritpion.MedCode LEFT OUTER JOIN&#13;&#10;                          (SELECT     Medicine_Code, Date_Time, Qty, Route_Id, Date_TimeSpecimen, ID, Frequency_Sub_ID&#13;&#10;                            FROM          Medicine_Usage_By_Patient&#13;&#10;                            WHERE      (CONVERT(varchar, Date_Time, 103) = CONVERT(varchar, CONVERT(datetime, @date), 103)) AND (Registration_No = @Registration_No) AND &#13;&#10;                                                   (Yearly_No = @Yearly_No) AND (Medicine_Code = @Medicine_Code)) AS Medicine_Usage ON &#13;&#10;                      Medicine_Usage.Medicine_Code = Pt_Prescription_Detail.Med_Code&#13;&#10;WHERE     (Pt_Prescription_Detail.Med_Code = @Medicine_Code) AND (PT_Prescription_Frequency_Detail.Prescription_Id = @Prescription_Id)">
                              <SelectParameters>
                                  <asp:ControlParameter ControlID="HiddenField_Date1" Name="date" PropertyName="Value" />
                                  <asp:SessionParameter Name="Registration_No" SessionField="registrationNo" />
                                  <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" />
                                  <asp:ControlParameter ControlID="HF_MedCode" Name="Medicine_Code" PropertyName="Value" />
                                  <asp:ControlParameter ControlID="HF_Prescription_id" Name="Prescription_Id" PropertyName="Value" />
                              </SelectParameters>
                          </asp:SqlDataSource>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField>
                      <HeaderTemplate>
                          <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" 
                              width="100%">
                              <tr>
                                  <td align="center" colspan="2">
                                      <strong>
                                          <asp:Label ID="Label_HeaderDate1" runat="server"></asp:Label></strong></td>
                              </tr>
                              <tr>
                                  <td align="center" width="50%">
                                      Time</td>
                                  <td align="center" width="50%">
                                      Initial</td>
                              </tr>
                          </table>
                      </HeaderTemplate>
                      <ItemTemplate>
                          <asp:DataList ID="DataList_Day1" runat="server" CssClass="bgcol_1" DataSourceID="SqlDataSource_Day1"
                              OnSelectedIndexChanged="DataList_Day1_SelectedIndexChanged" Width="100%">
                              <ItemTemplate>
                                  <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" 
                                      width="100%">
                                      <tr>
                                          <td style="border-right: #d5d2cd 1px solid; border-top: 0px; border-left: 0px; border-bottom: 0px"
                                              width="50%">
                                              <asp:Label ID="Date_TimeLabel" runat="server" Text='<%# Eval("Date_Time") %>'></asp:Label>
                                              <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Select" CssClass="add_icon"
                                                  ToolTip="Add Detail" Visible="False">Reason</asp:LinkButton></td>
                                          <td style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px"
                                              width="50%">
                                              <asp:Label ID="Label_initial" runat="server" CssClass="inicolor" Text='<%# Eval("initial") %>'></asp:Label>
                                              <asp:Label ID="DescriptionLabel" runat="server" CssClass="recolor" Text='<%# Eval("Description") %>'></asp:Label></td>
                                      </tr>
                                  </table>
                                  <asp:HiddenField ID="HF_FrequencyID" runat="server" Value='<%# Eval("Frequency_Id") %>' />
                                  <asp:HiddenField ID="HF_MCode" runat="server" Value='<%# Eval("Medicine_Code") %>' />
                                  <asp:HiddenField ID="HF_Frequency_Sub_Id" runat="server" Value='<%# Eval("Frequency_Sub_Id") %>' />
                              </ItemTemplate>
                          </asp:DataList>
                          <asp:SqlDataSource ID="SqlDataSource_Day1" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                              ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                              SelectCommand="Select_Patient_Medicine_Usage_Summary_Sub" SelectCommandType="StoredProcedure">
                              <SelectParameters>
                                  <asp:ControlParameter ControlID="HiddenField_Date1" Name="date" PropertyName="Value" />
                                  <asp:SessionParameter Name="Registration_No" SessionField="registrationNo" />
                                  <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" />
                                  <asp:ControlParameter ControlID="HF_MedCode" Name="Medicine_Code" PropertyName="Value" />
                                  <asp:ControlParameter ControlID="HF_Prescription_id" Name="Prescription_Id" PropertyName="Value" />
                              </SelectParameters>
                          </asp:SqlDataSource>
                          <asp:HiddenField ID="HiddenField_Date1" runat="server" Value='<%# Eval("date1") %>' />
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField>
                      <HeaderTemplate>
                          <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" 
                              width="100%">
                              <tr>
                                  <td align="center" colspan="2">
                                      <strong>
                                          <asp:Label ID="Label_HeaderDate2" runat="server"></asp:Label></strong></td>
                              </tr>
                              <tr>
                                  <td align="center" width="50%">
                                      Time</td>
                                  <td align="center" width="50%">
                                      Initial</td>
                              </tr>
                          </table>
                      </HeaderTemplate>
                      <ItemTemplate>
                          <asp:DataList ID="DataList_Day2" runat="server" CssClass="bgcol_2" DataSourceID="SqlDataSource_Day2"
                              OnSelectedIndexChanged="DataList_Day2_SelectedIndexChanged" Width="100%">
                              <ItemTemplate>
                                  <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" 
                                      width="100%">
                                      <tr>
                                          <td style="border-right: #d5d2cd 1px solid; border-top: 0px; border-left: 0px; border-bottom: 0px"
                                              width="50%">
                                              <asp:Label ID="Date_TimeLabel" runat="server" Text='<%# Eval("Date_Time") %>'></asp:Label>
                                              <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Select" CssClass="add_icon"
                                                  ToolTip="Add Detail" Visible="False">Reason</asp:LinkButton></td>
                                          <td style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px"
                                              width="50%">
                                              <asp:Label ID="Label_initial" runat="server" CssClass="inicolor" Text='<%# Eval("initial") %>'></asp:Label>
                                              <asp:Label ID="DescriptionLabel" runat="server" CssClass="recolor" Text='<%# Eval("Description") %>'></asp:Label></td>
                                      </tr>
                                  </table>
                                  <asp:HiddenField ID="HF_FrequencyID" runat="server" Value='<%# Eval("Frequency_Id") %>' />
                                  <asp:HiddenField ID="HF_MCode" runat="server" Value='<%# Eval("Med_Code") %>' />
                                  <asp:HiddenField ID="HF_Frequency_Sub_Id" runat="server" Value='<%# Eval("Frequency_Sub_Id") %>' />
                              </ItemTemplate>
                          </asp:DataList>
                          <asp:SqlDataSource ID="SqlDataSource_Day2" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                              ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                              SelectCommand="[Select_Patient_Medicine_Usage_Summary_Sub]" SelectCommandType="StoredProcedure">
                              <SelectParameters>
                                  <asp:ControlParameter ControlID="HiddenField_Date2" Name="date" PropertyName="Value" />
                                  <asp:SessionParameter Name="Registration_No" SessionField="registrationNo" />
                                  <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" />
                                  <asp:ControlParameter ControlID="HF_MedCode" Name="Medicine_Code" PropertyName="Value" />
                                  <asp:ControlParameter ControlID="HF_Prescription_id" Name="Prescription_Id" PropertyName="Value" />
                              </SelectParameters>
                          </asp:SqlDataSource>
                          <asp:HiddenField ID="HiddenField_Date2" runat="server" Value='<%# Eval("date2") %>' />
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField>
                      <HeaderTemplate>
                          <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" 
                              width="100%">
                              <tr>
                                  <td align="center" colspan="2">
                                      <strong>
                                          <asp:Label ID="Label_HeaderDate3" runat="server"></asp:Label></strong></td>
                              </tr>
                              <tr>
                                  <td align="center" width="50%">
                                      Time</td>
                                  <td align="center" width="50%">
                                      Initial</td>
                              </tr>
                          </table>
                      </HeaderTemplate>
                      <ItemTemplate>
                          <asp:DataList ID="DataList_Day3" runat="server" CssClass="bgcol_3" DataSourceID="SqlDataSource_Day3"
                              OnSelectedIndexChanged="DataList_Day3_SelectedIndexChanged" Width="100%">
                              <ItemTemplate>
                                  <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" 
                                      width="100%">
                                      <tr>
                                          <td style="border-right: #d5d2cd 1px solid; border-top: 0px; border-left: 0px; border-bottom: 0px"
                                              width="50%">
                                              <asp:Label ID="Date_TimeLabel" runat="server" Text='<%# Eval("Date_Time") %>'></asp:Label>
                                              <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Select" CssClass="add_icon"
                                                  ToolTip="Add Detail" Visible="False">Reason</asp:LinkButton></td>
                                          <td style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px"
                                              width="50%">
                                              <asp:Label ID="Label_initial" runat="server" CssClass="inicolor" Text='<%# Eval("initial") %>'></asp:Label>
                                              <asp:Label ID="DescriptionLabel" runat="server" CssClass="recolor" Text='<%# Eval("Description") %>'></asp:Label></td>
                                      </tr>
                                  </table>
                                  <asp:HiddenField ID="HF_FrequencyID" runat="server" Value='<%# Eval("Frequency_Id") %>' />
                                  <asp:HiddenField ID="HF_MCode" runat="server" Value='<%# Eval("Med_Code") %>' />
                                  <asp:HiddenField ID="HF_Frequency_Sub_Id" runat="server" Value='<%# Eval("Frequency_Sub_Id") %>' />
                              </ItemTemplate>
                          </asp:DataList>
                          <asp:SqlDataSource ID="SqlDataSource_Day3" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                              ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                              SelectCommand="[Select_Patient_Medicine_Usage_Summary_Sub]" SelectCommandType="StoredProcedure">
                              <SelectParameters>
                                  <asp:ControlParameter ControlID="HiddenField_Date3" Name="date" PropertyName="Value" />
                                  <asp:SessionParameter Name="Registration_No" SessionField="registrationNo" />
                                  <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" />
                                  <asp:ControlParameter ControlID="HF_MedCode" Name="Medicine_Code" PropertyName="Value" />
                                  <asp:ControlParameter ControlID="HF_Prescription_id" Name="Prescription_Id" PropertyName="Value" />
                              </SelectParameters>
                          </asp:SqlDataSource>
                          <asp:HiddenField ID="HiddenField_Date3" runat="server" Value='<%# Eval("date3") %>' />
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField>
                      <HeaderTemplate>
                          <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" 
                              width="100%">
                              <tr>
                                  <td align="center" colspan="2">
                                      <strong>
                                          <asp:Label ID="Label_HeaderDate4" runat="server"></asp:Label></strong></td>
                              </tr>
                              <tr>
                                  <td align="center" width="50%">
                                      Time</td>
                                  <td align="center" width="50">
                                      Initial</td>
                              </tr>
                          </table>
                      </HeaderTemplate>
                      <ItemTemplate>
                          <asp:DataList ID="DataList_Day4" runat="server" CssClass="bgcol_4" DataSourceID="SqlDataSource_Day4"
                              OnSelectedIndexChanged="DataList_Day4_SelectedIndexChanged" Width="100%">
                              <ItemTemplate>
                                  <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" 
                                      width="100%">
                                      <tr>
                                          <td style="border-right: #d5d2cd 1px solid; border-top: 0px; border-left: 0px; border-bottom: 0px"
                                              width="50%">
                                              <asp:Label ID="Date_TimeLabel" runat="server" Text='<%# Eval("Date_Time") %>'></asp:Label>
                                              <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Select" CssClass="add_icon"
                                                  ToolTip="Add Detail" Visible="False">Reason</asp:LinkButton></td>
                                          <td style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px"
                                              width="50%">
                                              <asp:Label ID="Label_initial" runat="server" CssClass="inicolor" Text='<%# Eval("initial") %>'></asp:Label>
                                              <asp:Label ID="DescriptionLabel" runat="server" CssClass="recolor" Text='<%# Eval("Description") %>'></asp:Label></td>
                                      </tr>
                                  </table>
                                  <asp:HiddenField ID="HF_FrequencyID" runat="server" Value='<%# Eval("Frequency_Id") %>' />
                                  <asp:HiddenField ID="HF_MCode" runat="server" Value='<%# Eval("Med_Code") %>' />
                                  <asp:HiddenField ID="HF_Frequency_Sub_Id" runat="server" Value='<%# Eval("Frequency_Sub_Id") %>' />
                              </ItemTemplate>
                          </asp:DataList>
                          <asp:SqlDataSource ID="SqlDataSource_Day4" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                              ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                              SelectCommand="[Select_Patient_Medicine_Usage_Summary_Sub]" SelectCommandType="StoredProcedure">
                              <SelectParameters>
                                  <asp:ControlParameter ControlID="HiddenField_Date4" Name="date" PropertyName="Value" />
                                  <asp:SessionParameter Name="Registration_No" SessionField="registrationNo" />
                                  <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" />
                                  <asp:ControlParameter ControlID="HF_MedCode" Name="Medicine_Code" PropertyName="Value" />
                                  <asp:ControlParameter ControlID="HF_Prescription_id" Name="Prescription_Id" PropertyName="Value" />
                              </SelectParameters>
                          </asp:SqlDataSource>
                          <asp:HiddenField ID="HiddenField_Date4" runat="server" Value='<%# Eval("date4") %>' />
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField>
                      <HeaderTemplate>
                          <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" 
                              width="100%">
                              <tr>
                                  <td align="center" colspan="2">
                                      <strong>
                                          <asp:Label ID="Label_HeaderDate5" runat="server"></asp:Label></strong></td>
                              </tr>
                              <tr>
                                  <td align="center" width="50%">
                                      Time</td>
                                  <td align="center" width="50%">
                                      Initial</td>
                              </tr>
                          </table>
                      </HeaderTemplate>
                      <ItemTemplate>
                          <asp:DataList ID="DataList_Day5" runat="server" CssClass="bgcol_5" DataSourceID="SqlDataSource_Day5"
                              OnSelectedIndexChanged="DataList_Day5_SelectedIndexChanged" Width="100%">
                              <ItemTemplate>
                                  <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                                      <tr>
                                          <td style="border-right: #d5d2cd 1px solid; border-top: 0px; border-left: 0px; border-bottom: 0px"
                                              width="50%">
                                              <asp:Label ID="Date_TimeLabel" runat="server" Text='<%# Eval("Date_Time") %>'></asp:Label>
                                              <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Select" CssClass="add_icon"
                                                  ToolTip="Add Detail" Visible="False">Reason</asp:LinkButton></td>
                                          <td style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px"
                                              width="50%">
                                              <asp:Label ID="Label_initial" runat="server" CssClass="inicolor" Text='<%# Eval("initial") %>'></asp:Label>
                                              <asp:Label ID="DescriptionLabel" runat="server" CssClass="recolor" Text='<%# Eval("Description") %>'></asp:Label></td>
                                      </tr>
                                  </table>
                                  <asp:HiddenField ID="HF_FrequencyID" runat="server" Value='<%# Eval("Frequency_Id") %>' />
                                  <asp:HiddenField ID="HF_MCode" runat="server" Value='<%# Eval("Med_Code") %>' />
                                  <asp:HiddenField ID="HF_Frequency_Sub_Id" runat="server" Value='<%# Eval("Frequency_Sub_Id") %>' />
                              </ItemTemplate>
                          </asp:DataList>
                          <asp:SqlDataSource ID="SqlDataSource_Day5" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                              ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                              SelectCommand="[Select_Patient_Medicine_Usage_Summary_Sub]" SelectCommandType="StoredProcedure">
                              <SelectParameters>
                                  <asp:ControlParameter ControlID="HiddenField_Date5" Name="date" PropertyName="Value" />
                                  <asp:SessionParameter Name="Registration_No" SessionField="registrationNo" />
                                  <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" />
                                  <asp:ControlParameter ControlID="HF_MedCode" Name="Medicine_Code" PropertyName="Value" />
                                  <asp:ControlParameter ControlID="HF_Prescription_id" Name="Prescription_Id" PropertyName="Value" />
                              </SelectParameters>
                          </asp:SqlDataSource>
                          <asp:HiddenField ID="HiddenField_Date5" runat="server" Value='<%# Eval("date5") %>' />
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField>
                      <HeaderTemplate>
                          <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" 
                              width="100%">
                              <tr>
                                  <td align="center" colspan="2">
                                      <strong>
                                          <asp:Label ID="Label_HeaderDate6" runat="server"></asp:Label></strong></td>
                              </tr>
                              <tr>
                                  <td align="center" width="50%">
                                      Time</td>
                                  <td align="center" width="50%">
                                      Initial</td>
                              </tr>
                          </table>
                      </HeaderTemplate>
                      <ItemTemplate>
                          <asp:DataList ID="DataList_Day6" runat="server" CssClass="bgcol_6" DataSourceID="SqlDataSource_Day6"
                              OnSelectedIndexChanged="DataList_Day6_SelectedIndexChanged" Width="100%">
                              <ItemTemplate>
                                  <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                                      <tr>
                                          <td style="border-right: #d5d2cd 1px solid; border-top: 0px; border-left: 0px; border-bottom: 0px"
                                              width="50%">
                                              <asp:Label ID="Date_TimeLabel" runat="server" Text='<%# Eval("Date_Time") %>'></asp:Label>
                                              <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Select" CssClass="add_icon"
                                                  ToolTip="Add Detail" Visible="False">Reason</asp:LinkButton></td>
                                          <td style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px"
                                              width="50%">
                                              <asp:Label ID="Label_initial" runat="server" CssClass="inicolor" Text='<%# Eval("initial") %>'></asp:Label>
                                              <asp:Label ID="DescriptionLabel" runat="server" CssClass="recolor" Text='<%# Eval("Description") %>'></asp:Label></td>
                                      </tr>
                                  </table>
                                  <asp:HiddenField ID="HF_FrequencyID" runat="server" Value='<%# Eval("Frequency_Id") %>' />
                                  <asp:HiddenField ID="HF_MCode" runat="server" Value='<%# Eval("Med_Code") %>' />
                                  <asp:HiddenField ID="HF_Frequency_Sub_Id" runat="server" Value='<%# Eval("Frequency_Sub_Id") %>' />
                              </ItemTemplate>
                          </asp:DataList>
                          <asp:SqlDataSource ID="SqlDataSource_Day6" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                              ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                              SelectCommand="[Select_Patient_Medicine_Usage_Summary_Sub]" SelectCommandType="StoredProcedure">
                              <SelectParameters>
                                  <asp:ControlParameter ControlID="HiddenField_Date6" Name="date" PropertyName="Value" />
                                  <asp:SessionParameter Name="Registration_No" SessionField="registrationNo" />
                                  <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" />
                                  <asp:ControlParameter ControlID="HF_MedCode" Name="Medicine_Code" PropertyName="Value" />
                                  <asp:ControlParameter ControlID="HF_Prescription_id" Name="Prescription_Id" PropertyName="Value" />
                              </SelectParameters>
                          </asp:SqlDataSource>
                          <asp:HiddenField ID="HiddenField_Date6" runat="server" Value='<%# Eval("date6") %>' />
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField>
                      <HeaderTemplate>
                          <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" 
                              width="100%">
                              <tr>
                                  <td align="center" colspan="2">
                                      <strong>
                                          <asp:Label ID="Label_HeaderDate7" runat="server"></asp:Label></strong></td>
                              </tr>
                              <tr>
                                  <td align="center" width="50%">
                                      Time</td>
                                  <td align="center" width="50%">
                                      Initial</td>
                              </tr>
                          </table>
                      </HeaderTemplate>
                      <ItemTemplate>
                          <asp:DataList ID="DataList_Day7" runat="server" CssClass="bgcol_7" DataSourceID="SqlDataSource_Day7"
                              OnSelectedIndexChanged="DataList_Day7_SelectedIndexChanged" Width="100%">
                              <ItemTemplate>
                                  <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                                      <tr>
                                          <td style="border-right: #d5d2cd 1px solid; border-top: 0px; border-left: 0px; border-bottom: 0px"
                                              width="50%">
                                              <asp:Label ID="Date_TimeLabel" runat="server" Text='<%# Eval("Date_Time") %>'></asp:Label>
                                              <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Select" CssClass="add_icon"
                                                  ToolTip="Add Detail" Visible="False">Reason</asp:LinkButton></td>
                                          <td style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px"
                                              width="50%">
                                              <asp:Label ID="Label_initial" runat="server" CssClass="inicolor" Text='<%# Eval("initial") %>'></asp:Label>
                                              <asp:Label ID="DescriptionLabel" runat="server" CssClass="recolor" Text='<%# Eval("Description") %>'></asp:Label></td>
                                      </tr>
                                  </table>
                                  <asp:HiddenField ID="HF_FrequencyID" runat="server" Value='<%# Eval("Frequency_Id") %>' />
                                  <asp:HiddenField ID="HF_MCode" runat="server" Value='<%# Eval("Med_Code") %>' />
                                  <asp:HiddenField ID="HF_Frequency_Sub_Id" runat="server" Value='<%# Eval("Frequency_Sub_Id") %>' />
                              </ItemTemplate>
                          </asp:DataList>
                          <asp:SqlDataSource ID="SqlDataSource_Day7" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                              ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                              SelectCommand="[Select_Patient_Medicine_Usage_Summary_Sub]" SelectCommandType="StoredProcedure">
                              <SelectParameters>
                                  <asp:ControlParameter ControlID="HiddenField_Date7" Name="date" PropertyName="Value" />
                                  <asp:SessionParameter Name="Registration_No" SessionField="registrationNo" />
                                  <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" />
                                  <asp:ControlParameter ControlID="HF_MedCode" Name="Medicine_Code" PropertyName="Value" />
                                  <asp:ControlParameter ControlID="HF_Prescription_id" Name="Prescription_Id" PropertyName="Value" />
                              </SelectParameters>
                          </asp:SqlDataSource>
                          <asp:HiddenField ID="HiddenField_Date7" runat="server" Value='<%# Eval("date7") %>' />
                      </ItemTemplate>
                  </asp:TemplateField>
              </Columns>
              <AlternatingRowStyle CssClass="GridAltItem" />
          </asp:GridView>
          &nbsp;
          
                
            </td></tr></table>
        <asp:Label ID="LabelFooter" runat="server" Text="Label"></asp:Label>        
  </asp:Content>
