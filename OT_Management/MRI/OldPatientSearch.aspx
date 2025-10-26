<%@ Page Language="VB" AutoEventWireup="false" CodeFile="OldPatientSearch.aspx.vb" Inherits="OldPatientSearch" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
<script type ="text/javascript" >
function resetform() {document.form1.reset(); document.form1.TextBoxYearlyNo.focus(); }
function enablelist(a)
{
if(a.checked==true)
{
document.getElementById ("dropdownlistDiagnosis").disabled =false;
}
else
{

document.getElementById ("dropdownlistDiagnosis").disabled =true;
}

}
</script>
</head>
<body>
<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_top.gif" width="1003" height="24" alt="" /></td>
  </tr>
  <tr>
    <td width="23" height="550" valign="top" class="left_border"><img src="images1/img_border_left.gif" width="23" height="15"  alt="" /></td>
    <td width="957" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
        <td colspan="2" valign="top" style="height: 84px"><iframe 
      src="tabs.aspx" name="holder" width="957" marginwidth="0" height="157" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe>
	  </td>
      </tr>
      
      
      <tr>
        <td width="20" height="25" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td width="937" valign="middle" class="text_lables3">Old Patient Search </td>
        </tr>
      <tr>
        <td height="428" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="mainframe_bg1">
          <!--DWLayoutTable-->
          <tr>
            <td width="20" rowspan="6" valign="top"><img src="images1/img_spacer.gif" width="20" height="2"  alt="" /></td>
                  <td width="915" height="10" valign="top" style="width: 887px"><img src="images1/img_spacer2.gif" width="2" height="10"  alt="" /></td>
                  <td width="22" rowspan="6" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
          </tr>
          <tr>
            <td height="135" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0"   >
              <!--DWLayoutTable-->
              <tr>
                <td width="915" height="130" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                        <!--DWLayoutTable-->
                        <tr>
                          <td width="175" height="5"></td>
                          <td width="250"></td>
                          <td width="175"></td>
                          <td width="315"></td>
                        </tr>
                        <tr>
                          <td height="25" align="right" valign="middle"><strong >First Name :&nbsp;</strong></td>
                          <td valign="middle"><span style="width: 137px">
                            <asp:TextBox ID="TextBoxFName" runat="server" Width="146px"    TabIndex="1"></asp:TextBox>
                          </span></td>
                          <td align="right" valign="middle"><strong >Yearly No.  :&nbsp;</strong></td>
                          <td valign="middle"><span style="width: 160px">
                            <asp:TextBox ID="TextBoxYearlyNo" runat="server" Width="146px"    TabIndex="6"></asp:TextBox>
                          </span></td>
                        </tr>
                        <tr>
                          <td height="25" align="right" valign="middle"><strong >Last Name :&nbsp;</strong></td>
                          <td valign="middle"><asp:TextBox ID="TextBoxMName" runat="server" Width="146px"    TabIndex="2"></asp:TextBox></td>
                          <td align="right" valign="middle"><strong >Registration No.  :&nbsp;</strong></td>
                          <td valign="middle"><span style="width: 158px">
                            <asp:TextBox ID="TextBoxRegNO" runat="server" Width="146px"    TabIndex="7"></asp:TextBox>
                          </span></td>
                        </tr>
                        <tr>
                          <td height="25" align="right" valign="middle"><strong >Relation :&nbsp;</strong></td>
                          <td valign="middle"><strong>
                            <asp:RadioButtonList CssClass="text_titles_bold" ID="RadioButtonList_Relation" runat="server" RepeatDirection="Horizontal" TabIndex="3">
                              <asp:ListItem>S/O</asp:ListItem>
                              <asp:ListItem>D/O</asp:ListItem>
                              <asp:ListItem>W/O</asp:ListItem>
                            </asp:RadioButtonList>
                          </strong></td>
                          <td align="right" valign="middle"><strong >Date of Birth   :&nbsp;</strong></td>
                          <td valign="middle"><igsch:webdatechooser id="WebDateChooserDOB" runat="server" width="150px" HideDropDowns="False" TabIndex="9">
<CalendarLayout NextMonthImageUrl="images/ig_cal_blueN0.gif" PrevMonthImageUrl="images/ig_cal_blueP0.gif" ShowMonthDropDown="False" ShowYearDropDown="False" TitleFormat="Month">
<CalendarStyle BackColor="#CCDDFF" BorderColor="SteelBlue" BorderWidth="1px" BorderStyle="Solid" Font-Bold="False" Font-Italic="False" Font-Names="Verdana" Font-Overline="False" Font-Size="9pt" Font-Strikeout="False" Font-Underline="False"></CalendarStyle>

<DayHeaderStyle BackgroundImage="images/ig_cal_blue2.gif" Font-Bold="True" Font-Size="8pt" ForeColor="#606090" Height="1pt"></DayHeaderStyle>

<DayStyle BackgroundImage="images/ig_cal_blue3.gif" BorderColor="SteelBlue" BorderWidth="1px" BorderStyle="Solid"></DayStyle>

<NextPrevStyle BackgroundImage="images/ig_cal_blue1.gif"></NextPrevStyle>

<OtherMonthDayStyle ForeColor="SlateGray"></OtherMonthDayStyle>

<SelectedDayStyle BackgroundImage="images/ig_cal_blue2.gif" ForeColor="White"></SelectedDayStyle>

<TitleStyle BackgroundImage="images/ig_cal_blue1.gif" BackColor="#CCDDFF" Font-Bold="True" Font-Size="10pt" ForeColor="#505080" Height="18pt"></TitleStyle>

<TodayDayStyle BackgroundImage="images/ig_cal_blue1.gif"></TodayDayStyle>

<FooterStyle BackgroundImage="images/ig_cal_blue2.gif" Font-Size="8pt" ForeColor="#505080" Height="16pt"></FooterStyle>
</CalendarLayout>
</igsch:webdatechooser></td>
                        </tr>
                        <tr>
                          <td align="right" valign="middle" style="height: 23px"><strong >First Name :&nbsp;</strong></td>
                          <td valign="middle" style="height: 23px">
                            <asp:TextBox ID="TextBoxRFName" runat="server"  
                             Width="146px" TabIndex="4"></asp:TextBox>
                          </td>
                          <td align="right" valign="middle" style="height: 23px"><strong >Visit Days Before   :&nbsp;</strong></td>
                          <td valign="middle" style="height: 23px"><span style="height: 41px">
                            <asp:TextBox ID="TextBoxDaysbefore" runat="server" Width="146px"    TabIndex="9"></asp:TextBox>
                          </span></td>
                        </tr>
                        <tr>
                          <td height="25" align="right" valign="middle"><strong >Last Name :&nbsp;</strong></td>
                          <td valign="middle"><span style="width: 158px; height: 41px">
                            <asp:TextBox ID="TextBoxRLName" runat="server"  
                             Width="146px" TabIndex="5"></asp:TextBox>
                          </span></td>
                          <td align="right" valign="middle"><strong >Date   :&nbsp;</strong></td>
                          <td valign="middle"><igsch:WebDateChooser id="WebdatechooserByDate" runat="server" width="150px" Value="" TabIndex="10">
<CalendarLayout NextMonthImageUrl="images/ig_cal_blueN0.gif" PrevMonthImageUrl="images/ig_cal_blueP0.gif" ShowMonthDropDown="False" ShowYearDropDown="False" TitleFormat="Month">
<CalendarStyle BackColor="#CCDDFF" BorderColor="SteelBlue" BorderWidth="1px" BorderStyle="Solid" Font-Bold="False" Font-Italic="False" Font-Names="Verdana" Font-Overline="False" Font-Size="9pt" Font-Strikeout="False" Font-Underline="False"></CalendarStyle>

<DayHeaderStyle BackgroundImage="images/ig_cal_blue2.gif" Font-Bold="True" Font-Size="8pt" ForeColor="#606090" Height="1pt"></DayHeaderStyle>

<DayStyle BackgroundImage="images/ig_cal_blue3.gif" BorderColor="SteelBlue" BorderWidth="1px" BorderStyle="Solid"></DayStyle>

<NextPrevStyle BackgroundImage="images/ig_cal_blue1.gif"></NextPrevStyle>

<OtherMonthDayStyle ForeColor="SlateGray"></OtherMonthDayStyle>

<SelectedDayStyle BackgroundImage="images/ig_cal_blue2.gif" ForeColor="White"></SelectedDayStyle>

<TitleStyle BackgroundImage="images/ig_cal_blue1.gif" BackColor="#CCDDFF" Font-Bold="True" Font-Size="10pt" ForeColor="#505080" Height="18pt"></TitleStyle>

<TodayDayStyle BackgroundImage="images/ig_cal_blue1.gif"></TodayDayStyle>

<FooterStyle BackgroundImage="images/ig_cal_blue2.gif" Font-Size="8pt" ForeColor="#505080" Height="16pt"></FooterStyle>
</CalendarLayout>
</igsch:WebDateChooser></td>
                        </tr>
                  
                  
                                </table></td>
                      </tr>
              <tr>
                <td height="5"></td>
                </tr>
              
            </table></td>
            </tr>
          <tr>
            <td height="13" align="right" valign="top"><span style="width: 887px"><img src="images1/img_shedow.gif" width="249" height="13" alt="" /></span></td>
          </tr>
          <tr>
            <td height="30" align="center"><asp:Button ID="BtnSearch" runat="server" Text="Search" Width="150px" TabIndex="11" /></td>
          </tr>
          
          <tr>
            <td height="239" valign="top"><span style="width: 887px">
              <asp:Label CssClass="text_lables"  ID="Label1" runat="server" ></asp:Label>
              <br />
              <asp:GridView ID="GridViewSearch" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                 Width="100%" PageSize="25"  >
                <RowStyle CssClass="GridItem" />
                <HeaderStyle CssClass="GridHeader" />              
                <AlternatingRowStyle CssClass="GridAltItem" />
                <Columns>
                <asp:HyperLinkField DataNavigateUrlFields="PIN No.,Record ID" DataNavigateUrlFormatString="PT_ASSIGN_RADIOLOGY_TESTS.aspx?regno={0}&amp;payid={1}"
                        Text="View" Visible="False" />
                <asp:ButtonField CommandName="Select" Text="Forward" />
                </Columns>
              </asp:GridView>
              <asp:SqlDataSource ID="SqlDataSourcePatient" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString1 %>"
                InsertCommand="PatientRegistrationNextVisit" InsertCommandType="StoredProcedure"
                ProviderName="<%$ ConnectionStrings:LGHConnectionString1.ProviderName %>" SelectCommand="SELECT     Payment.datetime,ISNULL(Patient.Prefix, ' ') + ' ' + ISNULL(Patient.PFName, ' ') + ' ' + ISNULL(Patient.PMName, ' ') + ' ' + ISNULL(Patient.PLName, ' ') +
                      ISNULL(Patient.Relation, '') + ISNULL(Patient.RFName, ' ') + ' ' + ISNULL(Patient.RMName, ' ') + ' ' + ISNULL(Patient.RLName, ' ') AS Name, 
                      CONVERT(varchar, ISNULL(Patient.Age, ' ')) + ' ' + ISNULL(Patient.AgeType, ' ') AS Age, Patient.RegNo, Patient.RegDateTime, 
                     'H.No.'+ ISNULL(Patient.House_No, ' ') + ' St.No.'
+ ISNULL(Patient.StreetAddress, '') + ' '+
ISNULL(Patient.Colony, '') + ' Tehsil '+ISNULL(Tehsil.TehsilName, '')+ ' District '+ 
                       ISNULL(DISTRICT.DistrictName, '') +  ' Province'+
ISNULL(Province.ProvinceName, '')+ ' '+
 ISNULL(Country.CountryName, '') AS Address, Patient.Zipcode, 
                      PatientSex.SexDescription, Patient.OtherProvince, Patient.OtherDistrict, Patient.OtherTehsil, Patient.HomePhone, Patient.MobilePhone, Patient.CNIC, 
                      payment.diagonosis
FROM         Patient INNER JOIN
                      Payment ON Patient.RegNo = Payment.RegNo LEFT OUTER JOIN
                      Tehsil ON Patient.TehsilCode = Tehsil.TehsilCode LEFT OUTER JOIN
                      PatientSex ON Patient.SexID = PatientSex.SexID LEFT OUTER JOIN
                      Province ON Patient.ProvinceCode = Province.ProvinceCode LEFT OUTER JOIN
                      DISTRICT ON Patient.DistrictCode = DISTRICT.DistrictCode LEFT OUTER JOIN
                      Country ON Patient.CountryCode = Country.CountryCode
WHERE (Patient.RegNo = @RegNo)">
                <SelectParameters>
                  <asp:QueryStringParameter Name="RegNo" QueryStringField="regno" />
                </SelectParameters>
                <InsertParameters>
                  <asp:Parameter DefaultValue="18" Name="DeptID" Type="Int32" />
                  <asp:Parameter DefaultValue="DMC" Name="Status" Type="String" />
                  <asp:SessionParameter DefaultValue="" Name="EmpID" SessionField="emp_id" Type="Int32" />
                  <asp:Parameter DefaultValue="Diabetes" Name="Diagonosis" Type="String" />
                  <asp:Parameter DefaultValue="DMC" Name="PatientType" Type="String" />
                  <asp:Parameter DefaultValue="" Name="ReferFrom" Type="String" />
                  <asp:Parameter Direction="InputOutput" Name="paymentid" Type="Decimal" DefaultValue="" />
                  <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" Type="String" />
                </InsertParameters>
              </asp:SqlDataSource>
              <asp:HiddenField ID="HiddenFieldregno" runat="server" />
              <asp:SqlDataSource ID="SqlDataSourceSearch" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"> </asp:SqlDataSource>
              <asp:SqlDataSource ID="SqlDataSourceDiagnosis" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                SelectCommand="SELECT [Diagnosis] FROM [Diagnosis]"></asp:SqlDataSource>
              <asp:ImageButton ID="ImageButtonrefresh" ImageUrl="images/image_bt_refresh.gif" Width="79" Height="30" runat="server"  Visible="false"/>              
              <asp:ImageButton ID="ImageButtonhome" ImageUrl="images/image_bt_home.gif" Width="64" Height="30" runat="server" Visible="false" />              
              <asp:ImageButton ID="ImageButtonlogin" ImageUrl="images/image_logout_up.gif" Width="71" Height="30" runat="server" Visible="false" />              
</span>
              <asp:TextBox ID="TextBox_HomePhone" runat="server"  Width="100px"   Visible="False"></asp:TextBox></td>
            </tr>
          <tr>
            <td height="15"></td>
          </tr>
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          

          
          
          </table></td>
          </tr>
      
    </table></td>
    <td width="33" valign="top" class="right_border" ><img src="images1/img_border_right.gif" width="23" height="15" alt="" /></td>
  </tr>
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_bottom.gif" width="1003" height="24" alt="" /></td>
  </tr>
  
  <tr>
    <td height="1"></td>
    <td></td>
    <td></td>
  </tr>
</table>
<script type="text/javascript" src="images1/flash_01.js"></script></form>
</body>
</html>