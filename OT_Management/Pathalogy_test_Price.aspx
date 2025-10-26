<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Pathalogy_test_Price.aspx.vb" Inherits="Pathalogy_test_Price" %>

<%@ Register Assembly="Infragistics2.WebUI.WebHtmlEditor.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebHtmlEditor" TagPrefix="ighedit" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Lahore General Hospital</title>
<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
<script language ="javascript" type ="text/javascript" >
function Checks()
{
    var Next_Date;
    var Grand_Discount;
    var Description;
    Next_Date = document.getElementById("Textbox_next_Date").value;
    Grand_Discount = document.getElementById("Textbox_Grand_Discount").value;
    Description = document.getElementById("TextboxDescription").value;
        if ((Next_Date.length==0) || (Next_Date-0 != Next_Date))
        {
        alert("Enter Correct Days(Only Integers)");
        document.getElementById("Textbox_next_Date").focus();
        document.getElementById("Textbox_next_Date").select();
        return false;
        }
       if ((Grand_Discount.length==0) || (Grand_Discount-0 != Grand_Discount))
        {
        alert("Enter Correct Discount(Only Integers)");
        document.getElementById("Textbox_Grand_Discount").focus();
        document.getElementById("Textbox_Grand_Discount").select();
        return false;
        }
        if (Description.length==0)
        {
        alert("Enter Description");
        document.getElementById("TextboxDescription").focus();
        document.getElementById("TextboxDescription").select();
        return false;
        }
        alert("End All");
        return true;
}
function NewWindow()
{
window.open("TestFeeReport.aspx","_blank");
}
</script>
        <style type="text/css">
            .d-active
            {
                text-align: center;
            }
        </style>
</head>

<body>
<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_top.gif" width="1003" height="24" /></td>
  </tr>
  <tr>
    <td width="23" height="450" valign="top" class="left_border"><img src="images1/img_border_left.gif" width="23" height="15" /></td>
    <td width="973" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <tr>
        <td height="97" colspan="2" valign="top"><iframe 
      src="../tabs.aspx" name="holder" width="957" marginwidth="0" height="97" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
          </tr>
      
      
      <tr>
        <td width="20" height="25" valign="top">&nbsp;</td>
            <td width="953" valign="middle" class="text_lables3" style="text-align: left">
                Recieve Amount</td>
          </tr>
      <tr>
        <td height="268" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="mainframe_bg1">
          <tr>
            <td width="20" rowspan="4" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td width="933" valign="top" style="width: 933px; height: 10px;"><img src="images1/img_spacer2.gif" width="2" height="10" /></td>
                </tr>
          <tr align ="center" ><td><iframe src="PatientBasicInfo_Iframe.aspx" width="930" name="holder1" scrolling="no" frameborder="0" 
            style="height: 50px; width: 920px;" id="holder1" class="text_lables3" ></iframe></td>
             
          <tr>
            <td align="right" valign="top" style="text-align: center; width: 933px; height: 75px;">
                        <asp:Label ID="Label_Message" runat="server" ForeColor="Red" Width="416px"></asp:Label><br />
                <br />
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="PTestID"
                    DataSourceID="SqlDataSourceForGrid" Width="920px" >
                    <Columns>
                        <asp:BoundField DataField="RegNo" HeaderText="Registration No" SortExpression="RegNo" />
                        <asp:BoundField DataField="PayID" HeaderText="Yearly No" SortExpression="PayID" />
                        <asp:BoundField DataField="Date" HeaderText="Date" ReadOnly="True" SortExpression="Date" />
                        <asp:BoundField DataField="Time" HeaderText="Time" ReadOnly="True" SortExpression="Time" />
                        <asp:BoundField DataField="TGName" HeaderText="Test Group Name" SortExpression="TGName" />
                        <asp:BoundField DataField="TestName" HeaderText="Test Name" SortExpression="TestName" />
                        <asp:BoundField DataField="Fee" HeaderText="Fee" SortExpression="Fee" />
                        <asp:BoundField DataField="PTestID" HeaderText="PTestID" InsertVisible="False" ReadOnly="True"
                            SortExpression="PTestID" Visible="False" />
                        <asp:BoundField DataField="TID" HeaderText="TID" SortExpression="TID" Visible="False" />
                        <asp:TemplateField Visible="False">
                            <ItemTemplate>
                      Rs. <asp:TextBox id="TextBox_Discount" runat="server" Width="36px" >0</asp:TextBox>
                                &nbsp;&nbsp;
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:HiddenField ID="HiddenFieldPrice" runat="server" Value='<%# Bind("Fee", "{0}") %>' />
                                <asp:HiddenField ID="HiddenField_RID" runat="server" Value='<%# Bind("TID", "{0}") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
                &nbsp;<br />
                <table >
                    <asp:Label ID="Label_Total" runat="server"></asp:Label></table>
                <span  >Total Price :                 
                <asp:TextBox ID="TextBox_Total_Price" runat="server" ReadOnly="true" 
                    BorderStyle="None" BorderWidth="0px" Font-Size="Large" ></asp:TextBox>
                &nbsp; Grand Discount : <asp:TextBox AutoPostBack="True" ID="TextBox_Grand_discount" runat ="server" Width="113px" >0</asp:TextBox>
                    <asp:DropDownList ID="DropDownList_Discount_Type" runat="server" AutoPostBack="True">
                        <asp:ListItem>Rs.</asp:ListItem>
                        <asp:ListItem>%age</asp:ListItem>
                    </asp:DropDownList>&nbsp;&nbsp; 
                Payment : </span>
              <asp:TextBox CssClass="d-active" ID="TextBox_Grand_total" ReadOnly="True" 
                    runat="server" Width="113px" BorderStyle="None" BorderWidth="0px" 
                    Font-Size="Large"></asp:TextBox>
              <asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT PatientsLabTest.RegNo, PatientsLabTest.PayID, PatientsLabTest.TID, Test.TestName, CONVERT (varchar, PatientsLabTest.DateTime, 107) AS Date, CONVERT (varchar, PatientsLabTest.DateTime, 108) AS Time, Test.Fee, PatientsLabTest.PTestID, TestGroup.TGName FROM Test INNER JOIN PatientsLabTest ON Test.TID = PatientsLabTest.TID INNER JOIN TestGroup ON Test.TGID = TestGroup.TGID WHERE (PatientsLabTest.PayID = @YearlyNo) AND (PatientsLabTest.RegNo = @RegNo) AND (PatientsLabTest.Status = 'Not Done')" insertcommand="INSERT INTO Pt_Pathology_Test_Amount(Reg_No, Yearly_No, RID, total_fee, Discount, fee_paid, Main_ID) VALUES (@Reg_No, @Yearly_No, @RID, @total_fee, @Discount, @fee_paid, @main_id)" DeleteCommand="DELETE FROM PatientsLabTest WHERE (PTestID = @PTestID)"><SelectParameters>
                <asp:SessionParameter SessionField="YearlyNo" Name="YearlyNo"></asp:SessionParameter>
                <asp:SessionParameter SessionField="RegistrationNo" Name="RegNo"></asp:SessionParameter>
                </SelectParameters>
                <InsertParameters>
                  <asp:SessionParameter SessionField="RegistrationNo" Name="Reg_No"></asp:SessionParameter>
                  <asp:SessionParameter SessionField="YearlyNo" Name="Yearly_No"></asp:SessionParameter>
                  <asp:ControlParameter PropertyName="Value" Name="RID" ControlID="HiddenField_Radiology_ID"></asp:ControlParameter>
                  <asp:ControlParameter PropertyName="Value" Name="total_fee" ControlID="HiddenField_Total_Fee"></asp:ControlParameter>
                  <asp:ControlParameter PropertyName="Value" Name="Discount" ControlID="HiddenField_Discount"></asp:ControlParameter>
                  <asp:ControlParameter PropertyName="Value" Name="fee_paid" ControlID="HiddenField_Fee_Paid"></asp:ControlParameter>
                  <asp:ControlParameter ControlID="HiddenFieldMain_ID" Name="main_id" PropertyName="Value" />
                  </InsertParameters>
                <DeleteParameters>
                  <asp:ControlParameter ControlID="GridView5" Name="PTestID" PropertyName="SelectedValue" />
                  </DeleteParameters>
                </asp:SqlDataSource>
              <asp:HiddenField ID="HiddenField_Appointment_Date" runat="server" />
              <asp:HiddenField ID="HiddenFieldAppointment_Time" runat="server" />
              <asp:HiddenField ID="HiddenField_Report_Date" runat="server" />
              <asp:HiddenField ID="HiddenField_Radiology_ID" runat="server" />
              <asp:HiddenField ID="HiddenField_Total_Fee" runat="server" />
              <asp:HiddenField ID="HiddenField_Discount" runat="server" />
              <asp:HiddenField ID="HiddenField_Fee_Paid" runat="server" /><asp:HiddenField ID="HiddenFieldMain_ID" runat="server" />
              <asp:HiddenField ID="HiddenField1" runat="server" />
              <asp:HiddenField ID="HiddenField3" runat="server" />
              <asp:HiddenField ID="HiddenField2" runat="server" />
              <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                    InsertCommand="INSERT INTO Pathology_Test_Total_Amount(Main_ID, TOtal_Discount, Total_Paid, Total_AMount) VALUES (@Main_ID, @TOtal_Discount, @Total_Paid, @Total_AMount)"
                    ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="&#13;&#10;">
                <InsertParameters>
                  <asp:ControlParameter ControlID="HiddenFieldMain_ID" Name="Main_ID" PropertyName="Value" />
                  <asp:ControlParameter ControlID="HiddenField2" Name="TOtal_Discount" PropertyName="Value" />
                  <asp:ControlParameter ControlID="HiddenField3" Name="Total_Paid" PropertyName="Value" />
                  <asp:ControlParameter ControlID="HiddenField1" Name="Total_AMount" PropertyName="Value" />
                  </InsertParameters>
                </asp:SqlDataSource>
              <asp:SqlDataSource ID="SqlDataSource_aPPONTMENT" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString12 %>"
                    InsertCommand="INSERT INTO MRI_Save_Patient_Next_App(Reg_no, Yearly_No, Next_App_Date, Next_App_Time, Report_Deliverd) VALUES (@Reg_no, @Yearly_No, @Next_App_Date, @Next_App_Time, @Report_Deliverd)"
                    ProviderName="<%$ ConnectionStrings:LGHConnectionString12.ProviderName %>" SelectCommand="&#13;&#10;">
                <InsertParameters>
                  <asp:SessionParameter SessionField="RegistrationNo" Name="Reg_no"></asp:SessionParameter>
                  <asp:SessionParameter SessionField="YearlyNo" Name="Yearly_No"></asp:SessionParameter>
                  <asp:ControlParameter PropertyName="Value" Name="Next_App_Date" ControlID="HiddenField_Appointment_Date"></asp:ControlParameter>
                  <asp:ControlParameter PropertyName="Value" Name="Next_App_Time" ControlID="HiddenFieldAppointment_Time"></asp:ControlParameter>
                  <asp:ControlParameter PropertyName="Value" Name="Report_Deliverd" ControlID="HiddenField_Report_Date"></asp:ControlParameter>
                  </InsertParameters>
                </asp:SqlDataSource>            
                <asp:HiddenField ID="HiddenFieldDiscount" runat="server" />
            </td>
                </tr>
          <tr>
            <td height="71" valign="top" style="width: 933px"><span style="height: 390px">&nbsp; &nbsp;&nbsp; &nbsp; 
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              <asp:Button ID="ButtonSave" runat="server" Text="Save" UseSubmitBehavior="False" cssclass="bt1upnew" width="76px" />
              <table width="100%" border="0" cellpadding="0" cellspacing="0"   style="visibility: hidden" id="TABLE1" onclick="return TABLE1_onclick()">
                <tr>
                  <td style="height: 22px" width="183">                    </td>
                        <td colspan="2" style="height: 22px; text-align: left">
                        </td>
                        <td style="height: 22px; text-align: left; font-weight: bold; font-size: 8pt; font-family: Verdana;" width="418">                    </td>
                      </tr>
                <tr style="font-weight: bold; font-size: 8pt; font-family: Verdana">
                  <td width="183" style="height: 23px"><span ><span style="font-size: 12pt; font-family: Times New Roman">
                      Appoint</span>ment Date&nbsp; : </span>&nbsp;</td>
                        <td width="151" style="height: 23px; text-align: left;">
                          <igsch:WebDateChooser ID="WebDateChooser_Select_Date" runat="server" Value="">
                            <CalendarLayout NextMonthImageUrl="ig_cal_blueN0.gif" PrevMonthImageUrl="ig_cal_blueP0.gif"
                                  ShowMonthDropDown="False" ShowYearDropDown="False" TitleFormat="Month">
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
                              <CalendarStyle BackColor="#CCDDFF" BorderColor="SteelBlue" BorderStyle="Solid" BorderWidth="1px"
                                      Font-Bold="False" Font-Italic="False" Font-Names="Verdana" Font-Overline="False"
                                      Font-Size="9pt" Font-Strikeout="False" Font-Underline="False">                                  </CalendarStyle>
                              </CalendarLayout>
                          </igsch:WebDateChooser>                          </td>
                        <td width="165"  style="height: 23px">
                          Appointment Time :&nbsp;                      </td>
                        <td width="418" style="height: 23px; text-align: left;">
                          <igtxt:webdatetimeedit id="WebDateTimeEdit1" runat="server" DataMode="EditModeText" DisplayModeFormat="t" Nullable="False" EditModeFormat="t"></igtxt:webdatetimeedit>                      </td>
                      </tr>
                <!--DWLayoutTable-->
                <tr>
                  <td width="183"  style="height: 23px">
                    Report After Test&nbsp; :&nbsp;                    </td>
                        <td style="height: 23px; text-align: left" width="151">
                        <asp:TextBox ID="TextBox_next_Date" runat="server" Width="113px">0</asp:TextBox>Days</td>
                        <td width="165"  style="height: 23px">
                        Grand Discount :&nbsp;                    </td>
                        <td style="height: 23px; text-align: left" width="418">
                            &nbsp;Rs.</td>
                      </tr>
                <tr>
                  <td width="183"  style="height: 26px">
                    Description :&nbsp;</td>
                        <td style="height: 26px; text-align: left" width="151">
                        <asp:TextBox ID="TextBoxDescription" runat="server" Width="138px"></asp:TextBox></td>
                        <td style="height: 26px" width="165">&nbsp;                        </td>
                        <td style="height: 26px; text-align: left" width="418">                    </td>
                      </tr>
                <tr>
                  <td align="center" colspan="4" style="text-align: left; height: 19px;" valign="middle">
                    <asp:RangeValidator ControlToValidate="TextBox_next_Date" CssClass="text_lables_login"
                            Display="Dynamic" ErrorMessage="Enter Correct Days" ID="RangeValidator_days" MaximumValue="100" MinimumValue="0" runat="server"
                            Type="Integer"></asp:RangeValidator>&nbsp;</td>
                      </tr>
                </table>
                  </span>                </td>
                </tr>
          </table></td>
          </tr>
      </table></td>
    <td width="33" valign="top" class="right_border" style="width: 33px" ><img src="images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_bottom.gif" width="1003" height="24" /></td>
  </tr>
</table>
</form>
</body>
</html>