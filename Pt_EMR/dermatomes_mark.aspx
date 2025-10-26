<%@ Page Language="C#" AutoEventWireup="true" CodeFile="dermatoms_mark.aspx.cs" Inherits="dermatoms_mark" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <link href="../css_hacims/class_reset.css" rel="stylesheet" type="text/css" media="screen, projection" />
    <link href="../css_hacims/class_content.css" rel="stylesheet" type="text/css" media="screen, projection" />
    <!--[if IE]><link rel="stylesheet" href="css_hacims/content_ie.css" type="text/css" media="screen, projection"/><![endif]-->
    <link href="../css_hacims/print_report.css" rel="stylesheet" type="text/css" media="print" />
</head>

<body >


<form id="form1" runat = "server">
 <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td align="center">
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td align="left">
                            <img src="../images_hacims/uol_logo.png" />
                        </td>
                        <td align="center">
                            <ul style="list-style: none; margin-top: 0px;">
                                <li>
                                    <img src="../images_hacims/Logo Teaching Hospital.png" />
                                </li>
                                <li><strong>1-km, Defence Road, off Raiwind Road (Bhoptian Chowk) Lahor, Pakistan</strong></li>
                                <li></li>
                                <li style="line-height: 18px;"></li>
                                <li style="line-height: 18px;">
                                    <asp:Label ID="Label2" runat="server" Text="UAN : +92-42-111-865865"></asp:Label>
                                </li>
                            </ul>
                        </td>
                       <%-- <td align="right">
                            <img src="../images_hacims/SMDC_Dental.jpg" width="120px" height="120px" />
                        </td>--%>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <div style="overflow: hidden; margin-bottom: 15px; width: 100%;">
        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="Grid_1" style="margin-top: 8px;">
            <tr>
                <td width="16%" align="right">
                    <b>Patient Name :</b>
                </td>
                <td width="16%">
                    <asp:Label ID="lblPatientName" runat="server"></asp:Label>
                </td>
                <td width="16%" align="right">
                    <b>Medical Record # :</b>
                </td>
                <td width="16%">
                    <asp:Label ID="lblMedicalRecord" runat="server"></asp:Label>
                </td>
                <td width="16%" align="right">
                    <b>Date of Admission :</b>
                </td>
                <td width="16%">
                    <asp:Label ID="lblDateAdmission" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <strong>
                        <asp:Label ID="lblRelation" runat="server"></asp:Label>
                        :</strong>
                </td>
                <td>
                    <asp:Label ID="lblRelationName" runat="server"></asp:Label>
                </td>
                <td align="right">
                    <b>Visit # :</b>
                </td>
                <td>
                    <asp:Label ID="lblVisitNo" runat="server"></asp:Label>
                    <asp:Label ID="lblRoomNo" runat="server" Visible="false"></asp:Label>
                </td>
                <td align="right">
                    <b>Date of Discharge :</b>
                </td>
                <td>
                    <asp:Label ID="lblDateOfDischarge" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <b>Age/Gender :</b>
                </td>
                <td>
                    <asp:Label ID="lblAge" runat="server"></asp:Label><strong style="font-weight: bold;">
                        Year / </strong>
                    <asp:Label ID="lblSex" runat="server"></asp:Label>
                </td>
                <td align="right">
                    <b>Department : </b>
                </td>
                <td>
                    <asp:Label ID="lblDeptName" runat="server"></asp:Label>
                </td>
                <td align="right">
                    <b>Consultant :</b>
                </td>
                <td>
                    <asp:Label ID="lblConsultantName" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <b>Phone :</b>
                </td>
                <td>
                    <asp:Label ID="lblPhone" runat="server"></asp:Label>
                </td>
                <td align="right">
                    <b>&nbsp;</b>
                </td>
                <td>
                </td>
                <td align="right">
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <b>Address :</b>
                </td>
                <td colspan="5">
                    <asp:Label ID="lblAddress" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
<div align="center">
<asp:SqlDataSource ID="SqlDataSource_select_dermatomes" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>" SelectCommand="dermatomes_select"
        SelectCommandType="StoredProcedure">
                      <SelectParameters>
                        <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" Type="Int32" />
                        <asp:SessionParameter Name="registration_No" SessionField="registrationNo" Type="String" />
                          <asp:Parameter DefaultValue="0" Name="Diagram_ID" Type="Int32" />
                      </SelectParameters>
                                    </asp:SqlDataSource>
                    <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource_select_dermatomes" Visible="False"> </asp:GridView> 
   
         
              <asp:Label ID="Label_flash" runat="server" Text="Label"></asp:Label>
         
</div>          
   </form>
   </body></html>      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
 