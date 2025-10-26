<%@ Page Language="VB" AutoEventWireup="false" CodeFile="dmcPatientSearch.aspx.vb" Inherits="dmcPatientSearch" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Lahore General Hospital</title>
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
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_top.gif" width="1003" height="24" /></td>
  </tr>
  <tr>
    <td width="23" height="544" valign="top" class="left_border"><strong><img src="images1/img_border_left.gif" width="23" height="15" /></strong></td>
    <td width="957" rowspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
        <td height="97" colspan="2" valign="top"><iframe 
      src="../tabs.aspx" name="holder" width="957" marginwidth="0" height="157" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
          </tr>
      
      
      <tr>
        <td width="19" height="25" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="938" valign="middle" class="text_lables3">
                Old Patient Search</td>
          </tr>
      <tr>
        <td height="363" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="mainframe_bg1">
          <!--DWLayoutTable-->
          <tr>
            <td width="20" rowspan="3" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td width="917" height="10" valign="top" style="height: 10px"><img src="images1/img_spacer2.gif" width="2" height="10" /></td>
                  <td width="20" rowspan="3" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                </tr>
          <tr>
            <td height="157" valign="top"><table width="917" border="0" cellpadding="0" cellspacing="0" class="activecell" style="visibility: visible">
              <!--DWLayoutTable-->
              <tr>
                <th width="207" height="37" align="right" valign="middle"  >
                  Yearly No.  :&nbsp;</th>
                    <th width="214" align="left" ><span style="width: 108px">
                      <asp:TextBox ID="TextBoxYearlyNo" runat="server" Width="175px"   ></asp:TextBox>
                    </span></th>
                    <th width="152" align="right"  ><strong>Registration No . :&nbsp;</strong></th>
                    <th width="342" align="left" ><span style="width: 102px">
                      <asp:TextBox ID="TextBoxRegNO" runat="server" Width="175px"   ></asp:TextBox>
                    </span></th>
                  </tr>
              <tr>
                <th align="right" valign="middle"   style="height: 24px"><span class="text_boxtitle">First Name :&nbsp;</span></th>
                    <td valign="middle" style="height: 24px"><span style="width: 106px">
                      <asp:TextBox ID="TextBoxFName" runat="server" Width="175px"   ></asp:TextBox>
                    </span></td>
                    <td align="right" valign="middle"  style="height: 24px"><span class="text_boxtitle">Last Name :&nbsp;</span></td>
                    <td valign="middle" style="height: 24px"><asp:TextBox ID="TextBoxMName" runat="server" Width="175px"   ></asp:TextBox></td>
                  </tr>
              <tr>
                <th align="right" valign="middle"  scope="row"><strong>Relation&nbsp;</strong>:&nbsp;</th>
                    <td colspan="3" valign="middle"><asp:RadioButtonList ID="RBLrelation" runat="server" 
                        Font-Names="verdana, arial, helvetica, sans-serif" RepeatDirection="Horizontal"
                        TabIndex="9" Width="172px">
                      <asp:ListItem Selected="True">S/O</asp:ListItem>
                      <asp:ListItem>D/O</asp:ListItem>
                      <asp:ListItem>W/O</asp:ListItem>
                    </asp:RadioButtonList></td>
                    </tr>
              <tr>
                <th align="right" valign="middle"  scope="row"><strong>First Name&nbsp;:&nbsp;</strong></th>
                    <td valign="middle"><span style="width: 108px; height: 43px;">
                      <asp:TextBox ID="TextBoxRFName" runat="server"  
                             Width="175px"></asp:TextBox>
                    </span></td>
                    <td align="right" valign="middle" ><span  style="text-align: right"><strong> Last Name :</strong>&nbsp;</span></td>
                    <td valign="middle"><span style="width: 102px; height: 43px;">
                      <asp:TextBox ID="TextBoxRLName" runat="server"  
                             Width="175px"></asp:TextBox>
                    </span></td>
                  </tr>
              <tr>
                <th align="right" valign="middle"  scope="row"><strong>Visit Days Before :&nbsp;</strong></th>
                    <td valign="middle">
                      <asp:TextBox CssClass="d-active" ID="TextBoxDaysbefore" runat="server" Width="175px"   ></asp:TextBox>
                    </td>
                    <td align="right" valign="middle" ><strong>Date:&nbsp;</strong></td>
                    <td valign="middle"><igsch:WebDateChooser id="WebdatechooserByDate" runat="server" width="180px">
                    <CalendarLayout PrevMonthImageUrl="ig_cal_blueP0.gif" NextMonthImageUrl="ig_cal_blueN0.gif" ShowYearDropDown="False" ShowMonthDropDown="False">
                        <TodayDayStyle BackgroundImage="ig_cal_blue1.gif" />
                        <FooterStyle BackgroundImage="ig_cal_blue2.gif" Font-Size="8pt" ForeColor="#505080"
                            Height="16pt" />
                        <SelectedDayStyle BackgroundImage="ig_cal_blue2.gif" ForeColor="White" />
                        <DayStyle BackgroundImage="ig_cal_blue3.gif" BorderColor="SteelBlue" BorderStyle="Solid"
                            BorderWidth="1px" />
                        <NextPrevStyle BackgroundImage="ig_cal_blue1.gif" />
                        <OtherMonthDayStyle ForeColor="SlateGray" />
                        <DayHeaderStyle BackgroundImage="ig_cal_blue2.gif" Font-Bold="True" Font-Size="8pt"
                            ForeColor="#606090" Height="1pt" />
                        <TitleStyle BackColor="#CCDDFF" BackgroundImage="ig_cal_blue1.gif" Font-Bold="True"
                            Font-Size="10pt" ForeColor="#505080" Height="18pt" />
                        <CalendarStyle BorderStyle="Solid" BorderWidth="1px" BorderColor="SteelBlue" BackColor="#CCDDFF" Font-Italic="False" Font-Size="9pt" Font-Names="Verdana" Font-Strikeout="False" Font-Underline="False" Font-Overline="False" Font-Bold="False">                        </CalendarStyle>
                    </CalendarLayout>
                </igsch:WebDateChooser></td>
                  </tr>
              <tr>
                <td height="35" colspan="4" align="center" valign="middle"><span style="width: 50px">
                  <asp:Button ID="BtnSearch" CssClass="bt1upnew" runat="server" Text="Search" />                  
                <igsch:webdatechooser id="WebDateChooserDOB" runat="server" width="180px" visible="False" HideDropDowns="False" Value="">
<CalendarLayout PrevMonthImageUrl="ig_cal_blueP0.gif" NextMonthImageUrl="ig_cal_blueN0.gif" ShowYearDropDown="False" ShowMonthDropDown="False">
<TodayDayStyle BackgroundImage="ig_cal_blue1.gif"></TodayDayStyle>

<FooterStyle BackgroundImage="ig_cal_blue2.gif" ForeColor="#505080" Height="16pt" Font-Size="8pt"></FooterStyle>

<SelectedDayStyle BackgroundImage="ig_cal_blue2.gif" ForeColor="White"></SelectedDayStyle>

<DayStyle BackgroundImage="ig_cal_blue3.gif" BorderStyle="Solid" BorderWidth="1px" BorderColor="SteelBlue"></DayStyle>

<NextPrevStyle BackgroundImage="ig_cal_blue1.gif"></NextPrevStyle>

<OtherMonthDayStyle ForeColor="SlateGray"></OtherMonthDayStyle>

<DayHeaderStyle BackgroundImage="ig_cal_blue2.gif" ForeColor="#606090" Height="1pt" Font-Size="8pt" Font-Bold="True"></DayHeaderStyle>

<TitleStyle BackgroundImage="ig_cal_blue1.gif" ForeColor="#505080" BackColor="#CCDDFF" Height="18pt" Font-Size="10pt" Font-Bold="True"></TitleStyle>

<CalendarStyle BorderStyle="Solid" BorderWidth="1px" BorderColor="SteelBlue" BackColor="#CCDDFF" Font-Italic="False" Font-Size="9pt" Font-Names="Verdana" Font-Strikeout="False" Font-Underline="False" Font-Overline="False" Font-Bold="False"></CalendarStyle>
</CalendarLayout>
</igsch:webdatechooser></span></td>
                  </tr>
              </table></td>
                </tr>
          <tr>
            <td height="132" valign="top"><span style="height: 119px">
              <asp:Label   ID="Label1" runat="server" Width="294px"></asp:Label>
            </span><span style="width: 887px">
            <asp:GridView ID="GridViewSearch" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                 Width="100%" PageSize="25"  >
              <RowStyle CssClass="GridItem" />
              <HeaderStyle CssClass="GridHeader" />            
              <AlternatingRowStyle CssClass="GridAltItem" />
              <Columns>
              <asp:HyperLinkField DataNavigateUrlFields="PIN No.,Record ID" DataNavigateUrlFormatString="PT_ASSIGN_RADIOLOGY_TESTS.aspx?regno={0}&amp;payid={1}"
                        Text="View" Visible="False" />
              <asp:ButtonField CommandName="Select" Text="Forward" Visible="False" />
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
                <asp:Parameter DefaultValue="10" Name="DeptID" Type="Int32" />
                <asp:Parameter DefaultValue="DMC" Name="Status" Type="String" />
                <asp:SessionParameter DefaultValue="" Name="EmpID" SessionField="emp_id" Type="Int32" />
                <asp:Parameter DefaultValue="Diabetes" Name="Diagonosis" Type="String" />
                <asp:Parameter DefaultValue="DMC" Name="PatientType" Type="String" />
                <asp:Parameter DefaultValue="" Name="ReferFrom" Type="String" />
                <asp:Parameter Direction="InputOutput" Name="paymentid" Type="Decimal" />
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
            <span style="height: 43px">
            <asp:TextBox ID="TextBox_HomePhone" runat="server"  Width="175px"   Visible="false"></asp:TextBox>
            <br />
            </span></span></td>
                </tr>
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          </table></td>
          </tr>
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
    </table></td>
    <td width="32" valign="top" class="right_border" ><img src="images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  <tr>
    <td height="1"></td>
    <td ></td>
  </tr>
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_bottom.gif" width="1003" height="24" /></td>
  </tr>
</table>
<script type="text/javascript" src="images1/flash_01.js"></script>
</form>
</body>
</html>