<%@ Page Language="VB" AutoEventWireup="false" CodeFile="WardIntakeOutputSheetRpt.aspx.vb"  MasterPageFile="~/hacims_masterpage.master"
    Inherits="WardIntakeOutputSheetRpt" %>

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



<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td  valign="top" class="leftnav"> <asp:Label ID="LabelSideMenu" runat="server"></asp:Label></td>
      <td style="width:auto;" valign="top">




 <div align="right" id="mprint"><a href="javascript:window.print()">Print</a></div>

        <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="tbl_form" >
            <tr  >
               
                <td align="center" >
                <ul >
               <li> 
                   <asp:Label ID="Label_Hospital" runat="server" Font-Bold="True" Font-Size="Large"></asp:Label></li>
                    <li>
                        <asp:Label ID="Label_Address" runat="server" Font-Bold="True" Text="Teaching Hospital for IIMC-T"></asp:Label></li>
                    <li>
                        <asp:Label ID="Label_Hosp_Ph" runat="server" Text="Phone No. : 042-35865731-5"></asp:Label></li>
                    <li style="line-height:18px;">  &nbsp;</li>
                 <li style="line-height:18px;">  <asp:Label ID="Label1" runat="server" Text="MEDICAL RECORD INTAKE OUTPU SHEET" Font-Bold="True"></asp:Label></li><li style="line-height:18px;" />   <asp:Label runat="server" ID="lblDate"></asp:Label>
                 
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
          &nbsp;
          <asp:GridView ID="GridView_Intake" runat="server" AutoGenerateColumns="False" OnPreRender="GridView_Intake_PreRender"
              ShowFooter="True" Width="100%">
              <Columns>
                  <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
                  <asp:BoundField DataField="Time" HeaderText="Time Period" SortExpression="Time" />
                  <asp:TemplateField HeaderText="Intake">
                      <EditItemTemplate>
                          <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>
                      </EditItemTemplate>
                      <FooterTemplate>
                          <table width="100%">
                              <tr>
                                  <td align="center" width="16.6%">
                                      <asp:Label ID="Label_Total_Oral" runat="server"></asp:Label></td>
                                  <td align="center" width="16.6%">
                                      <asp:Label ID="Label_CvpLine" runat="server"></asp:Label></td>
                                  <td align="center" width="16.6%">
                                      <asp:Label ID="Label_Total_IV" runat="server"></asp:Label></td>
                                  <td align="center" width="16.6%">
                                      <asp:Label ID="Label_Total_NG" runat="server"></asp:Label></td>
                                  <td align="center" width="16.6%">
                                      <asp:Label ID="Label_Other" runat="server"></asp:Label></td>
                                  <td align="center" width="16.6%">
                                      <asp:Label ID="Label_G_Total" runat="server"></asp:Label></td>
                              </tr>
                          </table>
                      </FooterTemplate>
                      <HeaderTemplate>
                          <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                              <tr>
                                  <td align="center" colspan="9">
                                      <strong style="color: #03C;">Intake</strong></td>
                              </tr>
                              <tr>
                                  <td align="center" width="16.6%">
                                      <strong>Oral</strong></td>
                                  <td align="center" width="16.6%">
                                      <strong>CVP Line</strong></td>
                                  <td align="center" width="16.6%">
                                      <strong>Parenteral</strong></td>
                                  <td align="center" width="16.6%">
                                      <strong>N/G</strong></td>
                                  <td align="center" width="16.6%">
                                      <strong>Other</strong></td>
                                  <td align="center" width="16.6%">
                                      <strong>Total Intake</strong></td>
                              </tr>
                          </table>
                      </HeaderTemplate>
                      <ItemTemplate>
                          <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                              <tr>
                                  <td align="center" width="16.6%">
                                      <asp:Label ID="Label_O_Qty" runat="server" Text='<%# Eval("Oral") %>'></asp:Label></td>
                                  <td align="center" width="16.6%">
                                      <asp:Label ID="Label_CVPLine" runat="server" Text='<%# Eval("Cvp_Line") %>'></asp:Label></td>
                                  <td align="center" width="16.6%">
                                      <asp:Label ID="Label_Parenteral_Qty" runat="server" Text='<%# Eval("PARENTERAL") %>'></asp:Label></td>
                                  <td align="center" width="16.6%">
                                      <asp:Label ID="Label_N_Qty" runat="server" Text='<%# Eval("N/G") %>'></asp:Label></td>
                                  <td align="center" width="16.6%">
                                      <asp:Label ID="Label_InOther" runat="server" Text='<%# Eval("In_Other") %>'></asp:Label></td>
                                  <td align="center" width="16.6%">
                                      <strong style="color: #03C;">
                                          <asp:Label ID="Label_IN_Total" runat="server"></asp:Label></strong></td>
                              </tr>
                          </table>
                      </ItemTemplate>
                      <ControlStyle Width="50px" />
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Output">
                      <EditItemTemplate>
                          <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox>
                      </EditItemTemplate>
                      <FooterTemplate>
                          <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                              <tr>
                                  <td align="center" width="12.5%">
                                      <asp:Label ID="Label_Tot_Drainage" runat="server"></asp:Label></td>
                                  <td align="center" width="12.5%">
                                      <asp:Label ID="Label_Tot_NGAspiration" runat="server"></asp:Label></td>
                                  <td align="center" width="12.5%">
                                      <asp:Label ID="Label_Tot_Vomit" runat="server"></asp:Label></td>
                                  <td align="center" width="12.5%">
                                  </td>
                                  <td align="center" width="12.5%">
                                      <asp:Label ID="Label_Tot_Stool" runat="server"></asp:Label></td>
                                  <td align="center" width="12.5%">
                                      <asp:Label ID="Label_Tot_Urine" runat="server"></asp:Label></td>
                                  <td align="center" width="12.5%">
                                      <asp:Label ID="Label_Tot_Out_Other" runat="server"></asp:Label></td>
                                  <td align="center" width="12.5%">
                                      <asp:Label ID="Label_G_Out_Total" runat="server"></asp:Label></td>
                              </tr>
                          </table>
                      </FooterTemplate>
                      <HeaderTemplate>
                          <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                              <tr>
                                  <td align="center" colspan="8">
                                      <strong style="color: #C30;">Output</strong></td>
                              </tr>
                              <tr>
                                  <td align="center" width="12.5%">
                                      <strong>Drainage</strong></td>
                                  <td align="center" width="12.5%">
                                      <strong>NG Aspiration</strong></td>
                                  <td align="center" width="12.5%">
                                      <strong>Vomit</strong></td>
                                  <td align="center" width="12.5%">
                                      <strong>Vomit Color</strong></td>
                                  <td align="center" width="12.5%">
                                      <strong>Stool</strong></td>
                                  <td align="center" width="12.5%">
                                      <strong>Urine</strong></td>
                                  <td align="center" width="12.5%">
                                      <strong>Other</strong></td>
                                  <td align="center" width="12.5%">
                                      <strong>Total</strong></td>
                              </tr>
                              <tr>
                              </tr>
                          </table>
                      </HeaderTemplate>
                      <ItemTemplate>
                          <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                              <tr>
                                  <td align="center" width="12.5%">
                                      <asp:Label ID="Label_Drainage" runat="server" Text='<%# Eval("Drainage") %>'></asp:Label></td>
                                  <td align="center" width="12.5%">
                                      <asp:Label ID="Label_NG_Aspiration" runat="server" Text='<%# Eval("NG_Aspiration") %>'></asp:Label></td>
                                  <td align="center" width="12.5%">
                                      <asp:Label ID="Label_Vomit" runat="server" Text='<%# Eval("Vomitus") %>'></asp:Label></td>
                                  <td align="center" width="12.5%">
                                      <asp:Label ID="Label_VomitColor" runat="server" Text='<%# Eval("VomitColor") %>'></asp:Label></td>
                                  <td align="center" width="12.5%">
                                      <asp:Label ID="Label_Stool" runat="server" Text='<%# Eval("Stool") %>'></asp:Label></td>
                                  <td align="center" width="12.5%">
                                      <asp:Label ID="Label_Urine" runat="server" Text='<%# Eval("Urine") %>'></asp:Label></td>
                                  <td align="center" width="12.5%">
                                      <asp:Label ID="Label_Out_Other" runat="server" Text='<%# Eval("Out_Other") %>'></asp:Label></td>
                                  <td align="center" width="12.5%">
                                      <strong style="color: #C33;">
                                          <asp:Label ID="Label_Out_Total" runat="server"></asp:Label></strong></td>
                              </tr>
                          </table>
                      </ItemTemplate>
                      <ControlStyle Width="55px" />
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Urine">
                      <HeaderTemplate>
                          <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                              <tr>
                                  <td align="center" colspan="5">
                                      <strong style="color: #960;">Urine Dip Stick</strong></td>
                              </tr>
                              <tr>
                                  <td align="center" width="20%">
                                      <strong>PH</strong></td>
                                  <td align="center" width="20%">
                                      <strong>Bld</strong></td>
                                  <td align="center" width="20%">
                                      <strong>Sug</strong></td>
                                  <td align="center" width="20%">
                                      <strong>Ket</strong></td>
                                  <td align="center" width="20%">
                                      <strong>ALB</strong></td>
                              </tr>
                          </table>
                      </HeaderTemplate>
                      <ItemTemplate>
                          <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                              <tr>
                                  <td align="center" width="20%">
                                      <asp:Label ID="Label_PH" runat="server" Text='<%# Eval("PH") %>'></asp:Label></td>
                                  <td align="center" width="20%">
                                      <asp:Label ID="Label_Bld" runat="server" Text='<%# Eval("Bld") %>'></asp:Label></td>
                                  <td align="center" width="20%">
                                      <asp:Label ID="Label_Sug" runat="server" Text='<%# Eval("Sug") %>'></asp:Label></td>
                                  <td align="center" width="20%">
                                      <asp:Label ID="Label_Ket" runat="server" Text='<%# Eval("Ket") %>'></asp:Label></td>
                                  <td align="center" width="20%">
                                      <asp:Label ID="Label_ALB" runat="server" Text='<%# Eval("ALB") %>'></asp:Label></td>
                              </tr>
                          </table>
                      </ItemTemplate>
                      <ControlStyle Width="30px" />
                      <FooterTemplate>
                          <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                              <tr>
                                  <td align="center" width="20%">
                                      <asp:Label ID="Label_Tot_PH" runat="server"></asp:Label></td>
                                  <td align="center" width="20%">
                                      <asp:Label ID="Label_Tot_Bld" runat="server"></asp:Label></td>
                                  <td align="center" width="20%">
                                      <asp:Label ID="Label_Tot_Sug" runat="server"></asp:Label></td>
                                  <td align="center" width="20%">
                                      <asp:Label ID="Label_Tot_Ket" runat="server"></asp:Label></td>
                                  <td align="center" width="20%">
                                      <asp:Label ID="Label_Tot_ALB" runat="server"></asp:Label></td>
                              </tr>
                          </table>
                      </FooterTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Initial" SortExpression="Initial">
                      <EditItemTemplate>
                          <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Initial") %>'></asp:TextBox>
                      </EditItemTemplate>
                      <HeaderTemplate>
                          <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                              <tr>
                                  <td align="center" colspan="5">
                                      <strong style="color: #960;"></strong>
                                  </td>
                              </tr>
                              <tr>
                                  <td align="center" width="20%">
                                      <strong>INITIAL</strong></td>
                              </tr>
                          </table>
                      </HeaderTemplate>
                      <ItemTemplate>
                          <asp:Label ID="Label1" runat="server" Text='<%# Bind("Initial") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
              </Columns>
              <RowStyle CssClass="GridItem" />
              <FooterStyle CssClass="GridPager" />
              <SelectedRowStyle CssClass="gridselect" />
              <HeaderStyle CssClass="GridHeader" />
              <EditRowStyle CssClass="gridedit" />
              <AlternatingRowStyle CssClass="GridAltItem" />
          </asp:GridView>
          
                
            </td></tr></table>
        <asp:Label ID="LabelFooter" runat="server" Text="Label"></asp:Label>        
  </asp:Content>
