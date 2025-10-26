<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Select_Test_Ad.aspx.vb" Inherits="Select_Test_Advance" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
 <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="Paragma" content="no-cache"/>
<title>Lahore General Hospital&gt;&gt; Main Area Diabetics Clinic &gt;&gt; Medicine Shortage</title>
<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
<script type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

//-->
</script>
<script language ="javascript"  type="text/JavaScript">
function ViewReport()
{
//alert("sdfsd");Div_DataList1
  window.open("PatalogyTestReport.aspx","MyWindow","");
 return false;
}
function check(a)
{    
    //alert();
    //alert(window.status=event.clientX );
    document.getElementById("Div_Element11").style.visibility="visible";
    document.getElementById("Div_Element11").style.left=window.status=event.clientX+10;
    document.getElementById("Div_Element11").style.top=window.status=event.clientY+10;
    //return false; Back
}

function Uncheck()
{
    //alert("abc");
    //document.getElementById("Div_Element11").style.visibility="Hidden";
    //return false;
}
function Check_View_Test()
{
  document.getElementById("Div_DataList1").style.visibility="Hidden";
  document.getElementById("Div_View_Test").style.visibility="visible";
  document.getElementById("Table_Save").style.visibility="Hidden";
  document.getElementById("Div_View_Test").style.left=200;//window.status=event.clientX+10;
  document.getElementById("Div_View_Test").style.top=300;//window.status=event.clientY+10;
  return false;
}

function Back()
{
  document.getElementById("Div_DataList1").style.visibility="visible";
  document.getElementById("Div_View_Test").style.visibility="Hidden";
  document.getElementById("Table_Save").style.visibility="visible";
  //document.getElementById("Div_View_Test").style.left=200;//window.status=event.clientX+10;Table_Save
  //document.getElementById("Div_View_Test").style.top=300;//window.status=event.clientY+10;
  return false;
}
</script>
</head>
<body onload="MM_preloadImages('images1/img_btn_over.gif')">
<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_top.gif" width="1003" height="24" /></td>
  </tr>
  <tr>
    <td width="23" valign="top" class="left_border" style="height: 1098px"><img src="images1/img_border_left.gif" width="23" height="15" /></td>
    <td width="957" valign="top" style="height: 1098px"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
        <td height="97" colspan="2" valign="top"><iframe 
      src="../tabs.aspx" name="holder" width="957" marginwidth="0" height="157" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
      </tr>
      
      
      <tr>
        <td width="19" height="25" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td width="929" valign="middle" class="text_lables3" >
              Assign Test&nbsp;
              <asp:ScriptManager ID="ScriptManager1" runat="server">
              </asp:ScriptManager>
              &nbsp;&nbsp;
                      </td>
        </tr>
      <tr>
        <td height="428" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
          <!--DWLayoutTable-->
          <tr>
            <td width="20" rowspan="8" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td height="19" colspan="4" align="right" valign="top" ><asp:Label ID="Label2" runat="server" Width="399px" ></asp:Label></td>
                  <td width="20" rowspan="8" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
              </tr>
          <tr>
            <td height="51" colspan="4" valign="top" style="height: 51px" ><table width="916" border="0" cellpadding="0" cellspacing="0" >
              <!--DWLayoutTable-->
              <tr>
                <td height="23" valign="middle" class="text_nameheading" >&nbsp;&nbsp;
                    <asp:Label ID="labelPName" runat="server" CssClass="text_boxtitle" Width="260px" ></asp:Label></td>
                <td  align="right" valign="middle" >
                    Yearly No. :&nbsp; </td>
                <td  valign="middle" >
                    <asp:Label ID="Label_YearlyNo" runat="server" Width="150px"></asp:Label></td>
                <td  align="right" valign="middle"><span >Registration No.  :&nbsp; </span></td>
                <td  valign="middle"><span >
                  <asp:Label ID="LabelRegNo" runat="server" Width="127px"></asp:Label>
                </span></td>
              </tr>
              <tr>
                <td valign="top" class="tabledotted_top" ><span >
                  &nbsp;
                  <asp:Label ID="LabelPSex"
                            runat="server" CssClass="text_boxtitle"></asp:Label>
                  ,
                  <asp:Label ID="LabelPAge" runat="server" CssClass="text_boxtitle"></asp:Label>
                  year </span></td>
                <td align="right" valign="middle" class="tabledotted_top" ><span >Referral Department :&nbsp;</span></td>
                <td valign="middle" class="tabledotted_top" style="height: 25px"><span >&nbsp;<asp:Label ID="labelWardReferal" runat="server"
                        Width="145px"></asp:Label></span></td>
                <td align="right" valign="middle" class="tabledotted_top" ><span >&nbsp;</span></td>
                <td valign="middle" class="tabledotted_top" ><span > 
                    <asp:LinkButton ID="LinkButton_View_Test" runat="server">View Assign Test</asp:LinkButton></span></td>
              </tr>
            </table></td>
            </tr>
          <tr>
            <td colspan="3" valign="top" style="text-align: center; height: 269px;" >  <div id="Div_View_Test" style="z-index: 102; left: 76px; visibility: hidden; width: 100px;
                        position: absolute; top: 687px; height: 100px">
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                    <asp:DataList ID="DataList_For_View" runat="server" DataSourceID="SqlDataSource_for_View">
                        <ItemTemplate>
                            <table style="width: 818px">
                                <tr>
                                    <td style="width: 100px; height: 25px">
                                        <asp:Label ID="TGNameLabel" runat="server" CssClass="text_lables3" Text='<%# Eval("TGName") %>'></asp:Label></td>
                                    <td style="width: 104px; height: 25px">                                    </td>
                                    <td style="width: 114px; height: 25px">                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 100px">                                    </td>
                                    <td style="width: 104px">
                                        <asp:Label ID="TSGNameLabel" runat="server" CssClass="text_boxtitle" Font-Bold="True"
                                            Text='<%# Eval("TSGName") %>'></asp:Label>&nbsp;                                    </td>
                                    <td style="width: 114px">
                                        <asp:Label ID="Label_Test" runat="server" Width="506px"></asp:Label></td>
                                </tr>
                            </table>
                            <asp:HiddenField ID="HiddenField4" runat="server" Value='<%# Eval("TSGID", "{0}") %>' />
                        </ItemTemplate>
                    </asp:DataList><a href="" onclick="return Back()">Back</a>                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                 
                <div id="Div_DataList1" style="z-index: 106; left: 67px; width: 882px; position: absolute; top: 349px; height: 100px">
              <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                <ContentTemplate> 
                <asp:DataList ID="DataList1" runat="server" DataKeyField="TGID" DataSourceID="ForTestGroup"
                    RepeatColumns="2" RepeatDirection="Horizontal">
                    <ItemTemplate>
                        <table style="width: 418px; text-align: left;">
                            <tr>
                                <td style="width: 165px; background-color: #ffcc33; height: 21px;">
                                    <asp:Label ID="TGNameLabel" runat="server" Text='<%# Eval("TGName") %>' Width="418px"></asp:Label></td>
                            </tr>
                            <tr>
                                <td style="width: 165px">
                                    <asp:DataList ID="DataList2" runat="server" DataSourceID="SqlDataSource_SubGroup"
                                        RepeatColumns="2">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="CheckBox1" runat="server" AutoPostBack="True" OnCheckedChanged="CheckBox1_CheckedChanged"
                                                Text='<%# Eval("TSGName") %>' ValidationGroup='<%# Eval("TSGID") %>' Width="222px" /><asp:HiddenField
                                                    ID="HiddenField5" runat="server" Value='<%# Eval("TSGID") %>' />
                                        </ItemTemplate>
                                    </asp:DataList><asp:SqlDataSource ID="SqlDataSource_SubGroup" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>" SelectCommand="SELECT [TSGName], [TSGID] FROM [TestSubGroup] WHERE ([TGID] = @TGID)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="HiddenField1" Name="TGID" PropertyName="Value" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("TGID", "{0}") %>' />                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>&nbsp;
                <asp:TreeView ID="TreeView1" runat="server">
                </asp:TreeView>
                    <table >
                      <tr>
                        <td ><asp:Button ID="BTNcheckAll" runat="server" Text="Check All" Height="22px"  CssClass="bt1upnew" Visible="False" /></td>
                        <td ><asp:Button ID="BtnUncheckAll"
                runat="server" Text="UnCheck All" Height="22px"  CssClass="bt1upnew" Visible="False" /></td>
                      </tr>
                    </table>
<asp:Label CssClass="text_lables3" ID="Label1" runat="server"></asp:Label>
                    <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>&nbsp;
                     <br />
                    &nbsp;<asp:SqlDataSource ID="SqlDataSource_for_View" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="Select_Main_Group_For_Assign_Test" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:SessionParameter Name="payID" SessionField="YearlyNo" />
                            <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </ContentTemplate>
              </asp:UpdatePanel>
                </div>
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                 
                <asp:HiddenField ID="HiddenField3" runat="server" />
&nbsp;            </td>
            <td width="4" style="height: 269px" ></td>
          </tr>
          <tr>
            <td width="323" height="183" >&nbsp;</td>
            <td width="227" ></td>
            <td width="368" ></td>
            <td ></td>
          </tr>
          <tr>
            <td height="67" colspan="4" valign="top" ><table width="921" border="0" cellpadding="0" cellspacing="0"  
                     id="Table_Save" >
              <!--DWLayoutTable-->
              <tr>
                <td width="174" height="19">                        </td>
                        <td colspan="3" valign="top" >                        
                        <asp:Label ID="Label_Message" runat="server" ForeColor="Red" Width="312px"></asp:Label></td>
                        <td width="4"></td>
                      </tr>
              <tr >
                <td align="right"  >Sample Number :&nbsp;</td>
                        <td width="284" ><asp:TextBox CssClass="d-active" ID="TextBox_Sample_number" ReadOnly="True" runat="server" Width="122px"></asp:TextBox></td>
                        <td width="221" align="right"  >Sample Collection &nbsp;Date&nbsp;:&nbsp;</td>
                        <td width="236" valign="middle" >  <igsch:WebDateChooser ID="WebDateChooser1" runat="server" AllowNull="False" Value="">
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
                                        Font-Size="9pt" Font-Strikeout="False" Font-Underline="False">                                    </CalendarStyle>
                            </CalendarLayout>
                        </igsch:WebDateChooser>                        </td>
                        <td></td>
                      </tr>
              <tr >
                <td align="right" ><span >Collect Report after&nbsp; :&nbsp;</span></td>
                        <td ><asp:TextBox CssClass="d-active" ID="TextBox_next_Date" runat="server" Width="50px">0</asp:TextBox>
                          <asp:DropDownList ID="DropDownList1" runat="server" Width="67px">
                            <asp:ListItem>Hours</asp:ListItem>
                            <asp:ListItem>Days</asp:ListItem>
                        </asp:DropDownList></td>
                        <td  >
                            <div align="right">Description :&nbsp;</div></td>
                        <td ><asp:TextBox CssClass="d-active" ID="TextBoxDescription" runat="server" Width="198px"></asp:TextBox></td>
                        <td></td>
                      </tr>
                <tr>
                    <td align="right">
                    </td>
                    <td>
                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                  <ContentTemplate>
                    <table >
                      <tr>
                        <td ></td>
                            <td >
                            <asp:Button ID="btnAdd" runat="server" Text="Save" CssClass="bt1upnew" /></td>
                            <td ><asp:Button ID="Button_Move_Next" runat="server" Text="Move Next" Visible="False" CssClass="bt1upnew" /></td>
                            <td ><asp:Button ID="Button6" runat="server" Text="View Report" CssClass="bt1upnew" Visible="False" OnClientClick="ViewReport()" /></td>
                            <td ></td>
                          </tr>
                      </table>
                        <asp:Label ID="Label4" runat="server" Text="" Visible=false ></asp:Label>
                    </ContentTemplate>
                </asp:UpdatePanel>
                    </td>
                    <td >
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
              <!--DWLayoutTable-->
              
            </table></td>
            </tr>
          <tr>
            <td height="3" ></td>
            <td ></td>
            <td ></td>
            <td ></td>
          </tr>
          
          
          
          
          
          
          <tr>
            <td height="19" colspan="4" align="center" valign="top" >
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;            &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <span class="tabletabs" style="height: 32px">
                        &nbsp; &nbsp;
                  </span></td>
            </tr>
          
          
          <tr>
            <td height="36" valign="top" style="width: 308px" >&nbsp;
              <asp:HiddenField ID="HiddenField_Sample_collection" runat="server" />
                <asp:HiddenField ID="HiddenField_Report_Date" runat="server" />
                <asp:HiddenField ID="HiddenFieldMain_ID" runat="server" />
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString12 %>"
                    ProviderName="<%$ ConnectionStrings:LGHConnectionString12.ProviderName %>" SelectCommand="Select @PFNAME = PFNAME from patient">                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenField2" runat="server" />                <asp:HiddenField ID="HiddenField_Test" runat="server" /><asp:HiddenField ID="HiddenField_TGID" runat="server" /></td>
            <td valign="top" style="width: 227px" >&nbsp;
                <div id="Div_Element11" style="z-index: 110; left: 26px; width: 93px; position: absolute; top: 899px; height: 98px">
                  &nbsp;<asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                      <asp:Panel ID="Panel1" runat="server" Height="112px" Width="320px" BackColor="#FF8000">
                        <asp:CheckBoxList ID="CheckBoxList2" runat="server" DataSourceID="SqlDataSource2"
                                    DataTextField="TestName" DataValueField="TID" Width="320px" RepeatColumns="3" RepeatDirection="Horizontal">                                </asp:CheckBoxList><br />
                        <asp:Button ID="Button_Element_Save" runat="server" Text="Save" Width="59px" />
                        <asp:Button ID="Button_Check_ALL" runat="server" Text="Check All" Width="73px" OnClick="Button_Check_ALL_Click" />
                        <asp:Button ID="Button_Element_Cancel" runat="server" Text="Cancel" Width="59px" />
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                        SelectCommand="SELECT TestName, TID FROM Test WHERE (TSGID = @TSGID)">
                          <SelectParameters>
                            <asp:ControlParameter ControlID="HiddenField_Test" Name="TSGID" PropertyName="Value" />
                            </SelectParameters>
                          </asp:SqlDataSource>
                        </asp:Panel>
                      </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                </asp:UpdatePanel>
            </td>
            <td valign="top" style="width: 368px" >
                &nbsp;
                <asp:SqlDataSource ID="ForTestGroup" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                        SelectCommand="Select_Test_Group" SelectCommandType="StoredProcedure">
                  <SelectParameters>
                    <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                    <asp:SqlDataSource ID="ForTestSubGroup" runat="server" ConnectionString="Data Source=SERVER;Initial Catalog=Pathalogy;User ID=sa;Password=123"
                        SelectCommand="SELECT isnull(TestSubGroup.TSGName,'') as TSGName, TestSubGroup.TSGID, isnull(TestGroup.TGName,'') as TGName FROM TestSubGroup INNER JOIN TestGroup ON TestSubGroup.TGID = TestGroup.TGID " ProviderName="System.Data.SqlClient">                                                                                </asp:SqlDataSource>
                    <asp:HiddenField ID="HiddenFieldTestSubGroup" runat="server" />
                    <asp:HiddenField ID="HiddenField_for_test" runat="server" />
                    <asp:Label ID="LabelCNIC" runat="server" Visible="False"></asp:Label>
                    <asp:Label ID="LabelDOB" runat="server" Visible="False"></asp:Label></td>
            <td >&nbsp;</td>
          </tr>
          
          
          
          
          
          
          
          
          
          
          
              
          

          
          
          
          
          
          
          

          
          
          
          
          
          
          
          
          
          

          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          </table></td>
          </tr>
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
    </table></td>
    <td width="33" valign="top" class="right_border" style="height: 1098px" ><img src="images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_bottom.gif" width="1003" height="24" /></td>
  </tr>
  
  <tr>
    <td height="1"></td>
    <td></td>
    <td></td>
  </tr>
</table>
<script type="text/javascript" src="images1/flash_01.js"></script>
</form>
</body>
</html>