<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Patient_Resechadule.aspx.vb" Inherits="Patient_Resechadule" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
<link href="SpryAssets/SpryCollapsiblePanel.css" rel="stylesheet" type="text/css" />

<style type="text/css">
<!--
.style2 {
	font: 18px "Trebuchet MS";
	color: #CC6666;
	font-weight: bold;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 14px;
}
-->
</style>
</head>

<body>
<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_top.gif" width="1003" height="24" /></td>
  </tr>
  <tr>
    <td width="23" rowspan="2" valign="top" class="left_border"><img src="images1/img_border_left.gif" width="23" height="15" /></td>
    <td width="957" height="312" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
        <td colspan="2" valign="top" style="height: 98px"><iframe 
      src="tabs.aspx" name="holder" width="957" marginwidth="0" height="97" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
          </tr>
      
      
      <tr>
        <td width="20" height="25" valign="top" style="height: 25px"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="937" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <!--DWLayoutTable-->
              <tr>
                <td width="937" valign="middle" align="left" style="height: 21px"><span class="text_lables3" style="height: 25px">
                    Patient Re-Schedule</span></td>
              </tr>
            </table>
            </td>
          </tr>
      <tr>
        <td height="189" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="mainframe_bg15">
          <!--DWLayoutTable-->
          <tr>
            <td width="20" rowspan="5" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
            <td align="center" valign="middle" style="height: 25px"><span style="height: 11px">
                <table>
                    <tr>
                        <td style="width: 100px; height: 33px">
                            Select Date :</td>
                        <td style="width: 172px; height: 33px">
                            <igsch:webdatechooser id="WebDateChooser1" runat="server" AllowNull="False" Value="" Width="168px">
                                <CalendarLayout NextMonthImageUrl="ig_cal_blueN0.gif" PrevMonthImageUrl="ig_cal_blueP0.gif"
                                    ShowMonthDropDown="False" ShowYearDropDown="False" TitleFormat="Month">
                                    <CalendarStyle BackColor="#CCDDFF" BorderColor="SteelBlue" BorderStyle="Solid" BorderWidth="1px"
                                        Font-Bold="False" Font-Italic="False" Font-Names="Verdana" Font-Overline="False"
                                        Font-Size="9pt" Font-Strikeout="False" Font-Underline="False">
                                    </CalendarStyle>
                                    <DayHeaderStyle BackgroundImage="ig_cal_blue2.gif" Font-Bold="True" Font-Size="8pt"
                                        ForeColor="#606090" Height="1pt" />
                                    <DayStyle BackgroundImage="ig_cal_blue3.gif" BorderColor="SteelBlue" BorderStyle="Solid"
                                        BorderWidth="1px" />
                                    <NextPrevStyle BackgroundImage="ig_cal_blue1.gif" />
                                    <OtherMonthDayStyle ForeColor="SlateGray" />
                                    <SelectedDayStyle BackgroundImage="ig_cal_blue2.gif" ForeColor="White" />
                                    <TitleStyle BackColor="#CCDDFF" BackgroundImage="ig_cal_blue1.gif" Font-Bold="True"
                                        Font-Size="10pt" ForeColor="#505080" Height="18pt" />
                                    <TodayDayStyle BackgroundImage="ig_cal_blue1.gif" />
                                    <FooterStyle BackgroundImage="ig_cal_blue2.gif" Font-Size="8pt" ForeColor="#505080"
                                        Height="16pt" />
                                </CalendarLayout>
                            </igsch:webdatechooser>
                        </td>
                    </tr>
                </table>
                &nbsp;&nbsp;</span></td>
                  <td width="28" rowspan="5" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                </tr>
          <tr>
            <td style="height: 10px"></td>
                </tr>
          <tr>
            <td valign="top" style="height: 25px; text-align: center;">
                &nbsp;<asp:GridView ID="GridView_Patient_resch" runat="server" AllowPaging="True"
                    AutoGenerateColumns="False"  DataSourceID="SqlDataSource_For_Grid"
                    PageSize="25" Width="908px">
                    <RowStyle CssClass="GridItem" />
                    <Columns>
                        <asp:BoundField DataField="Reg_No" HeaderText="Reg No." SortExpression="Reg_No" />
                        <asp:BoundField DataField="Payid" HeaderText="Visit No." SortExpression="Payid" />
                        <asp:BoundField DataField="patient_name" HeaderText="Patient Name" ReadOnly="True"
                            SortExpression="patient_name" />
                        <asp:BoundField DataField="Relation_Name" HeaderText="Relation Name" ReadOnly="True"
                            SortExpression="Relation_Name" />
                        <asp:BoundField DataField="Old_Date" HeaderText="Old App Date" SortExpression="Old_Date" />
                    </Columns>
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource_For_Grid" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT patient_resechedule_mri_Temp.Reg_No, patient_resechedule_mri_Temp.Payid, ISNULL(Patient.Prefix, '') + ' ' + ISNULL(Patient.PFName, ' ') + '  ' + ISNULL(Patient.PMName, ' ') AS patient_name, ISNULL(Patient.Relation, ' ') + ' ' + ISNULL(Patient.RFName, ' ') + ' ' + ISNULL(Patient.RMName, ' ') AS Relation_Name, CONVERT (varchar, patient_resechedule_mri_Temp.Old_Date, 107) AS Old_Date FROM patient_resechedule_mri_Temp INNER JOIN Patient ON patient_resechedule_mri_Temp.Reg_No = Patient.RegNo INNER JOIN Payment ON Patient.RegNo = Payment.RegNo AND patient_resechedule_mri_Temp.Payid = Payment.PayID" UpdateCommand="UPDATE MRI_Save_Patient_Next_App SET Next_App_Date = @Next_App_Date WHERE (Reg_no = @Reg_no) AND (Yearly_No = @Yearly_No)">
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="HiddenField_Select_Date" Name="Next_App_Date" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenField_Reg_No" Name="Reg_no" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenField_Yearly_No" Name="Yearly_No" PropertyName="Value" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenField_Reg_No" runat="server" />
                <asp:HiddenField ID="HiddenField_Yearly_No" runat="server" />
                <asp:HiddenField ID="HiddenField_Select_Date" runat="server" />
                <br />
              </td>
                </tr>
          <tr>
            <td style="height: 12px; text-align: center">
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                <asp:Button ID="Button_Update" runat="server" Text="Update Schedule" /></td>
                </tr>
          <tr>
            <td valign="top" style="height: 36px">
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            </td>
                </tr>
         </table></td>
          </tr>
   
    </table></td>
    <td width="33" rowspan="2" valign="top" class="right_border" style="width: 33px"><img src="images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  <tr>
    <td height="0"></td>
  </tr>
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_bottom.gif" width="1003" height="24" /> </td>
  </tr>
</table>
</form>

</body>
</html>
