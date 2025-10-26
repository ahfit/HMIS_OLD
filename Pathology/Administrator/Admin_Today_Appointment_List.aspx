<%@ page language="VB" autoeventwireup="false" inherits="Reports_Admin_Today_Appointment_List, App_Web_zvadaqir" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
 <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Lahore General Hospital</title>
<link href="../images1/st_sheet_01.css" rel="stylesheet" type="text/css" />



</head>

<body  dir="ltr">

<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="../images1/img_border_top.gif" width="1003" height="24" /></td>
  </tr>
  <tr>
    <td width="23" height="550" valign="top" class="left_border"><img src="../images1/img_border_left.gif" width="23" height="15" /></td>
    <td width="957" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
        <td height="40" colspan="2" valign="top"><img src="../images1/top_header.jpg" width="957" height="100" /></td>
      </tr>
      <tr>
        <td height="25" colspan="2" align="right" valign="middle" class="lnks_bg"><a href="../loginnew.aspx" class="login_link">Home</a><span class="link_spliter">&nbsp;|&nbsp;</span><span class="link_spliter"><a href="../hacims.aspx" class="login_link">About Hacims</a>&nbsp;|&nbsp;<a href="../helphacims.aspx" class="login_link">Help</a>&nbsp;|&nbsp;</span><a href="../login.aspx" class="login_link2">Logout</a>&nbsp;&nbsp;</td>
          </tr>
      <tr>
        <td width="20" height="32" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="937" valign="middle" class="text_heading_02"> <span class="text_lables3">
                Today Appointments </span></td>
          </tr>
      
      
      
      
      
          <tr>
            <td height="453" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                <!--DWLayoutTable-->
                <tr>
                  <td width="20" rowspan="2" valign="top"><img src="../images1/img_spacer.gif" width="20" height="2" /></td>
                  <td width="917" height="10" valign="top"><img src="../images1/img_spacer2.gif" width="2" height="10" /></td>
                  <td width="20" rowspan="2" valign="top"><img src="../images1/img_spacer.gif" width="20" height="2" /></td>
                </tr>
                <tr>
                  <td height="449" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <!--DWLayoutTable-->
                      <tr>
                        <td width="1" style="height: 51px"></td>
                        <td width="916" valign="top" dir="ltr" style="height: 51px"><table width="100%" border="0" cellpadding="0" cellspacing="0"  >
                          <!--DWLayoutTable-->
                          <tr>
                            <td align="right" valign="middle"  style="text-align: right; width: 329px; height: 21px;"><strong> </strong></td>
                              <td valign="middle" style="width: 251px; height: 21px;">
                                  </td>
                              <td colspan="2" align="right" valign="middle" style="height: 21px"><strong  style="width: 125px"></strong></td>
                              <td valign="middle" style="width: 217px; height: 21px;"></td>
                          </tr>
                          <tr>
                            <td align="right" valign="middle"  style="width: 329px; height: 13px;">
                                Total Number of Appointments For Today are&nbsp; &nbsp;</td>
                              <td colspan="2" valign="middle" style="height: 13px">
                                  <asp:Label ID="Label_Count_Appointments" runat="server" CssClass="text_titles_bold"
                                      Font-Size="Large" ForeColor="Blue"></asp:Label></td>
                              <td colspan="2" valign="middle" dir="ltr" style="height: 13px"><span style="height: 34px">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                              </span></td>
                            </tr>
                          
                          
                          
                          
                          
                          
                          
                        </table></td>
                      </tr>
                      <tr>
                        <td height="13" colspan="2" align="right" valign="top"><img src="../images1/img_shedow.gif" width="249" height="13" /></td>
                      </tr>
                      <tr>
                        <td colspan="2" valign="top" dir="ltr" style="height: 22px">
                            &nbsp;
                        </td>
                      </tr>
                      <tr>
                        <td colspan="2" valign="top" dir="ltr" style="height: 344px"><span style="text-align: center">
                          <asp:GridView ID="GridViewElementValues" runat="server" AutoGenerateColumns="False"
                        Width="100%"  DataSourceID="SqlDataSourceForGrid" EmptyDataText="Sorry No Appointment For Today">
                            <FooterStyle CssClass="GridPager" />                          
                            <RowStyle CssClass="GridItem" />
                            <HeaderStyle CssClass="GridHeader" />                          
                            <AlternatingRowStyle CssClass="GridAltItem" />
                              <Columns>
                                  <asp:BoundField DataField="Patient Name" HeaderText="Patient Name" ReadOnly="True"
                                      SortExpression="Patient Name" />
                                  <asp:BoundField DataField="Father's Name" HeaderText="Father's Name" ReadOnly="True"
                                      SortExpression="Father's Name" />
                                  <asp:BoundField DataField="SexDescription" HeaderText="Gender" SortExpression="SexDescription" />
                                  <asp:BoundField DataField="Date of Birth" HeaderText="Date of Birth" ReadOnly="True"
                                      SortExpression="Date of Birth" />
                              </Columns>
                              <EmptyDataRowStyle BackColor="Fuchsia" Font-Bold="True" Font-Names="Arial" Font-Size="Large"
                                  ForeColor="White"  />
                          </asp:GridView>
                          <asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT     ISNULL(Patient.Prefix, ' ') + ' ' + ISNULL(Patient.PFName, ' ') + ' ' + ISNULL(Patient.PMName, ' ') + ' ' + ISNULL(Patient.PLName, ' ') AS [Patient Name], &#13;&#10;                      ISNULL(Patient.RFName, ' ') + ' ' + ISNULL(Patient.RMName, ' ') + ' ' + ISNULL(Patient.RLName, ' ') AS [Father's Name], PatientSex.SexDescription, &#13;&#10;                      CONVERT(varchar, Patient.DateOfBirth, 107) AS [Date of Birth]&#13;&#10;FROM         Patient_Discharge INNER JOIN&#13;&#10;                      Patient ON Patient_Discharge.Reg_No = Patient.RegNo INNER JOIN&#13;&#10;                      PatientSex ON Patient.SexID = PatientSex.SexID&#13;&#10;WHERE     (convert(varchar,Patient_Discharge.next_Visit_Date,107) = Convert(varchar,getdate(),107))">
                          </asp:SqlDataSource>
                            &nbsp;
                        </span>
                        </td>
                      </tr>
                      
                      
                      
                      
                      
                      
                      

                      
                      
                      

                      
                      
                      
                      
                      
                      
                      

                      
                  </table></td>
                </tr>
                
                
                
                

                
                
                
                
                
                
                
                

          
          
          
          
          
          
            </table></td>
          </tr>
      
      
      
      
      
      
      
      
      
      
            
    </table></td>
    <td width="32" valign="top" class="right_border" ><img src="../images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  
  <tr>
    <td height="24" colspan="3" valign="top"><img src="../images1/img_border_bottom.gif" width="1003" height="24" /></td>
  </tr>
</table>
<script type="text/javascript" src="../images1/flash_01.js"></script>
</form>
</body>
</html>
