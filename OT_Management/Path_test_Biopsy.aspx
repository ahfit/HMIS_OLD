<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Path_test_Biopsy.aspx.vb" Inherits="Path_test_Biopsy" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Lahore General Hospital Lahore</title>
<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />


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
      src="../tabs.aspx" name="holder" width="957" marginwidth="0" height="97" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
          </tr>
      
      
      <tr>
        <td width="20" height="25" valign="top" style="height: 25px"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="937" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <!--DWLayoutTable-->
              <tr>
                <td width="937" height="25" valign="middle" align="left"><span class="text_lables3">
                  <asp:ScriptManager ID="ScriptManager1" runat="server"> </asp:ScriptManager>
                  <asp:Label ID="Label2" runat="server" Width="399px" ></asp:Label>
                </span></td>
              </tr>
            </table>
            </td>
          </tr>
      <tr>
        <td height="189" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="mainframe_bg15">
          <!--DWLayoutTable-->
          <tr>
            <td width="20" height="191" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
            <td width="917" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <!--DWLayoutTable-->
              <tr>
                <td width="917" valign="top" style="height: 16px"><iframe src="PatientBasicInfo_Iframe.aspx" width="930" name="holder1" scrolling="no" frameborder="0" 
            style="height: 50px; width: 920px;" id="holder1" class="text_lables3" ></iframe>
                </td>
                    </tr>
              <tr>
                <td height="10"></td>
                  </tr>
              <tr>
                <td height="77" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" >
                
                  <tr>
                    <td height="19" colspan="4" valign="top"><asp:Label  ForeColor="Red" ID="Label_Message" runat="server" Width="312px"></asp:Label>
                            <asp:RangeValidator ID="RangeValidator_days" runat="server" ControlToValidate="TextBox_next_Date"
                                CssClass="text_lables_login" Display="Dynamic" ErrorMessage="Enter Correct Days"
                                MaximumValue="100" MinimumValue="0" Type="Integer"></asp:RangeValidator></td>
                            </tr>
                  <tr>
                    <td width="181" height="25" align="right" valign="middle"><span >Sample Number :&nbsp;</span></td>
                        <td width="285" valign="middle"><asp:TextBox CssClass="d-active" ID="TextBox_Sample_number" ReadOnly="True" runat="server" Width="122px" BorderStyle="None"></asp:TextBox></td>
                        <td width="170" valign="top" ><!--DWLayoutEmptyCell-->&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Report Date
                            :&nbsp;
                        </td>
                        <td width="281" valign="middle"><igsch:WebDateChooser ID="WebDateChooser1" runat="server" AllowNull="False" Value="">
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
                                        Font-Size="9pt" Font-Strikeout="False" Font-Underline="False"> </CalendarStyle>
                    </CalendarLayout>
                  </igsch:WebDateChooser></td>
                      </tr>
                  <tr>
                    <td height="25" align="right" valign="middle"><span >Collect Report after&nbsp; :&nbsp;</span></td>
                        <td valign="middle"><asp:TextBox CssClass="d-active" ID="TextBox_next_Date" runat="server" Width="50px">0</asp:TextBox>
                          <asp:DropDownList ID="DropDownList1" runat="server" Width="67px">
                            <asp:ListItem>Hours</asp:ListItem>
                            <asp:ListItem>Days</asp:ListItem>
                          </asp:DropDownList></td>
                        <td align="right" valign="middle" >Description :&nbsp;</td>
                        <td valign="top"><asp:TextBox CssClass="d-active" ID="TextBoxDescription" runat="server" Width="198px"></asp:TextBox></td>
                      </tr>
                    <tr>
                        <td align="right" height="25" valign="middle">
                            <strong><span style="font-size: 8pt; font-family: Verdana">Test Type :&nbsp;</span></strong></td>
                        <td colspan="2" valign="middle">
                            <asp:RadioButtonList ID="RadioButtonList_Type" runat="server" DataSourceID="SqlDataSource_Test_Type"
                                DataTextField="Test_Type" DataValueField="Test_Type_ID" RepeatDirection="Horizontal"
                                Width="339px">
                                <asp:ListItem Selected="True">Routine</asp:ListItem>
                                <asp:ListItem>Start(Now)</asp:ListItem>
                                <asp:ListItem>Urgent(Today)</asp:ListItem>
                            </asp:RadioButtonList></td>
                        <td valign="top">
                        </td>
                    </tr>
                  <tr>
                    <td height="6"></td>
                      <td></td>
                      <td></td>
                      <td></td>
                    </tr>
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  </table></td>
                  </tr>
              <tr>
                <td height="10"></td>
                </tr>
              <tr>
                <td valign="top" style="height: 199px"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                  <!--DWLayoutTable-->
                  <tr>
                    <td width="272" height="199" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <!--DWLayoutTable-->
                      <tr>
                        <td width="275" height="24" valign="top"><span style="width: 93px">
                        </span></td>
                          </tr>
                      <tr>
                        <td height="175" valign="top">
                            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                 DataKeyNames="TSGID" DataSourceID="SqlDataSource_SubGroup" Width="266px">
                                <Columns>
                                    <asp:BoundField DataField="TSGID" HeaderText="TSGID" InsertVisible="False" ReadOnly="True"
                                        SortExpression="TSGID" Visible="False" />
                                    <asp:BoundField DataField="TSGName" HeaderText="TSGName" SortExpression="TSGName" Visible="False" />
                                    <asp:ButtonField CommandName="Select" DataTextField="TSGName" Text="Button" />
                                </Columns>
                                <RowStyle CssClass="GridItem" />
                                <HeaderStyle CssClass="GridHeader" />
                                <AlternatingRowStyle CssClass="GridAltItem" />
                            </asp:GridView>
                        </td>
                      </tr>
                      
                    </table></td>
                        <td width="4">&nbsp;</td>
                        <td width="212" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                          <!--DWLayoutTable-->
                          <tr>
                            <td width="265" height="24" valign="top"><span style="width: 106px">
                              <asp:Label  ID="labelGName"
                runat="server" Width="313px" Font-Size="Medium"></asp:Label>
                            </span></td>
                                  </tr>
                          <tr>
                            <td valign="top" style="height: 175px">
                                <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                     DataSourceID="SqlDataSourceTest" PageSize="7" Width="266px">
                                    <Columns>
                                        <asp:BoundField DataField="TestName" HeaderText="TestName" SortExpression="TestName" />
                                        <asp:BoundField DataField="TID" HeaderText="TID" InsertVisible="False" ReadOnly="True"
                                            SortExpression="TID" />
                                        <asp:TemplateField HeaderText="Select">
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="CheckBox1" runat="server" />
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="CheckBox1" runat="server" />
                                                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("TID", "{0}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Description">
                                            <ItemTemplate>
                                                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <RowStyle CssClass="GridItem" />
                                    <HeaderStyle CssClass="GridHeader" />
                                    <AlternatingRowStyle CssClass="GridAltItem" />
                                </asp:GridView>
                            </td>
                          </tr>
                          
                        </table></td>
                        <td width="10">&nbsp;</td>
                        <td width="100" valign="top"><table width="73%" border="0" cellpadding="0" cellspacing="0">
                          <!--DWLayoutTable-->
                          <tr>
                            <td width="96" height="199" valign="top"><asp:Button ID="BTNcheckAll" runat="server" Text="Check All" Height="22px"  CssClass="bt1upnew" />
                              <asp:Button ID="btnAdd" runat="server" Text="Save" CssClass="bt1upnew" />
                              <asp:Button ID="BtnUncheckAll"
                runat="server" Text="UnCheck All" Height="22px"  CssClass="bt1upnew" />
                              <asp:Button ID="Button_Move_Next" runat="server" Text="Move Next" Visible="False" CssClass="bt1upnew" />
                              <asp:Button ID="Button6" runat="server" Text="View Report" CssClass="bt1upnew" Visible="False" OnClientClick="ViewReport()" /></td>
                                  </tr>
                        </table></td>
                        <td width="10">&nbsp;</td>
                        <td width="309" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                          <!--DWLayoutTable-->
                          <tr>
                            <td height="199" valign="top" style="width: 278px">
                              <asp:TreeView ID="TreeView1" runat="server" Height="197px" > </asp:TreeView>
                           </td>
                            </tr>
                        </table></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td height="28" valign="top">
                    &nbsp;&nbsp;
                  <asp:Label ID="LabelRelation" runat="server" CssClass="text_boxtitle" ></asp:Label>
                  <asp:Label ID="LabelRName" runat="server" CssClass="text_boxtitle" ></asp:Label>
                    <span class="tabletabs" style="height: 32px">
                  <asp:TextBox ID="TextBox_Grand_discount" runat="server" Visible="False" Width="113px">0</asp:TextBox>
                  </span></td>
                </tr>
              <tr>
                <td height="25" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                  <!--DWLayoutTable-->
                  <tr>
                    <td width="269" height="25" valign="top">
                      <asp:Label ID="Label3" runat="server" Width="211px"></asp:Label>
                    <asp:Label CssClass="text_lables3" ID="Label1" runat="server" Visible="False"></asp:Label>
                    </td>
                    <td width="331" valign="top"><span style="width: 279px">
                      <asp:HiddenField ID="HiddenField_Sample_collection" runat="server" />
                      <asp:HiddenField ID="HiddenField_Report_Date" runat="server" />
                      <asp:HiddenField ID="HiddenFieldMain_ID" runat="server" />
                      <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                    ProviderName="<%$ ConnectionStrings:LGHConnectionString12.ProviderName %>" SelectCommand="Select @PFNAME = PFNAME from patient"> </asp:SqlDataSource>
                      <asp:Label ID="LabelCNIC" runat="server" Width="125px" Visible="False"></asp:Label>
                      <asp:Label ID="LabelDOB" runat="server" Width="123px" Visible="False"></asp:Label>
                      <asp:HiddenField ID="HiddenField2" runat="server" />
                        <asp:SqlDataSource ID="SqlDataSource_Test_Type" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                            ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT Test_Type, Test_Type_ID FROM Test_Type">
                        </asp:SqlDataSource>
                    </span></td>
                    <td width="317" valign="top"><span style="width: 251px">&nbsp; &nbsp;&nbsp;
                      <asp:HiddenField ID="HiddenField_for_test" runat="server" />
                        <asp:SqlDataSource ID="SqlDataSourceTest" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                            ProviderName="<%$ ConnectionStrings:Admin_Radiology_ConnStr.ProviderName %>" SelectCommand="SELECT TestName, TID FROM Test WHERE (TSGID = @TSGID)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="GridView1" Name="TSGID" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSource_SubGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                            ProviderName="<%$ ConnectionStrings:Admin_Radiology_ConnStr.ProviderName %>" SelectCommand="Select TSGID,TSGName from testsubgroup where MS_TGID = 13">
                        </asp:SqlDataSource>
                    </span></td>
                  </tr>
                </table>
                </td>
              </tr>
              <tr>
                <td height="15"></td>
              </tr>
              
              
              
            </table></td>
                <td width="20" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
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
<script type="text/javascript" src="images1/flash_01.js"></script>
</form><script type="text/javascript">
<!--
-->
</script>
</body>
</html>
