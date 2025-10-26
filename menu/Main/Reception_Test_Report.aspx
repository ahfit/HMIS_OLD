<%@ page language="VB" autoeventwireup="false" inherits="Reception_Test_Report, App_Web_rbfdm1yf" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>HACIMS { Tele-Medicine Solution }</title>
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

<script language="javascript" type ="text/javascript" >
function InsertValues(a)
{
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
    <td width="23" height="550" valign="top" class="left_border"><img src="images1/img_border_left.gif" width="23" height="15" /></td>
    <td width="957" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
        <td height="97" colspan="2" align="right" valign="middle"><iframe 
      src="tabs.aspx" name="holder" width="957" marginwidth="0" height="97" marginheight="0" 
      scrolling="No" frameborder="0" id="holder" ></iframe></td>
        </tr>
      
      <tr>
        <td width="19" height="25" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td width="929" valign="middle" class="text_lables3" >Pathology</td>
        </tr>
      <tr>
        <td height="428" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
          <!--DWLayoutTable-->
          <tr>
            <td width="20" rowspan="9" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td height="19" colspan="4" align="right" valign="top" style="height: 19px" ><asp:Label ID="Label_Text" runat="server" Width="399px" ></asp:Label></td>
                  <td width="20" rowspan="9" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
              </tr>
          <tr>
            <td height="77" colspan="4" valign="top" ><table border="0" cellpadding="0" cellspacing="0"  style="width: 100%">
              <!--DWLayoutTable-->
              <tr>
                <td height="23" valign="middle" class="text_nameheading" style="width: 280px">&nbsp;&nbsp;
                    <asp:Label ID="labelPName" runat="server" CssClass="text_boxtitle" Width="260px" ></asp:Label></td>
                <td width="149" align="right" valign="middle" >Date of Birth :&nbsp; </td>
                <td width="163" valign="middle" >
                    &nbsp;<asp:Label ID="Labelage" runat="server" CssClass="text_labels" Width="104px"></asp:Label></td>
                <td width="116" align="right" valign="middle"><span >PIN No.  :&nbsp; </span></td>
                <td width="179" valign="middle"><span >
                  <asp:Label ID="LabelRegNo" runat="server" Width="127px"></asp:Label>
                </span></td>
              </tr>
              <tr>
                <td valign="top" class="tabledotted_top" style="width: 280px; height: 25px">&nbsp;&nbsp;
                    <asp:Label ID="LabelRelation" runat="server" CssClass="text_titles_bold" ></asp:Label>
                    <asp:Label ID="LabelRName" runat="server"  ></asp:Label>
                    <span >
                        <br />
                        &nbsp;
                  <asp:Label ID="LabelPSex"
                            runat="server" CssClass="text_boxtitle"></asp:Label>&nbsp;
                  <asp:Label ID="LabelPAge" runat="server" CssClass="text_boxtitle"></asp:Label>
                  </span></td>
                <td align="right" valign="middle" class="tabledotted_top" style="height: 25px"><span >N.I.C No.  :&nbsp;</span></td>
                <td valign="middle" class="tabledotted_top" style="height: 25px"><span >
                  <asp:Label ID="LabelCNIC" runat="server" Width="125px"></asp:Label>
                </span></td>
                <td align="right" valign="middle" class="tabledotted_top" style="height: 25px"><span >&nbsp;</span>&nbsp;</td>
                <td valign="middle" class="tabledotted_top" style="height: 25px">&nbsp;<asp:Label ID="LabelDOB" runat="server" Width="123px"></asp:Label></td>
              </tr>
            </table>
                <asp:Label ID="Labelpulse" runat="server" CssClass="text_labels" Width="50px" Visible="False"></asp:Label><asp:Label
                    ID="Labelbplow" runat="server" CssClass="text_labels" Width="50px" Visible="False"></asp:Label><asp:Label
                        ID="Labelbp" runat="server" CssClass="text_labels" Width="50px" Visible="False"></asp:Label><asp:Label
                            ID="Labeltemp" runat="server" CssClass="text_labels" Width="50px" Visible="False"></asp:Label><asp:Label
                                ID="Labelrr" runat="server" CssClass="text_labels" Width="50px" Visible="False"></asp:Label></td>
            </tr>
          <tr>
            <td width="316" style="height: 27px" >
            </td>
            <td width="9" style="height: 27px" ></td>
            <td width="409" style="height: 27px" ></td>
            <td width="183" style="height: 27px" ></td>
          </tr>
          <tr>
            <td height="178" valign="top" ><span style="width: 97px; height: 181px;">
                    <asp:GridView ID="GVTSGName" runat="server" AutoGenerateColumns="False" DataKeyNames="TGID"
            DataSourceID="ForTestGroup" Height="168px" Width="328px" >
                      <Columns>
                      <asp:CommandField ShowSelectButton="True" />
                      <asp:BoundField DataField="TGName" HeaderText="Test Group Name" SortExpression="TGName" />
                      <asp:BoundField DataField="TGID" HeaderText="TGID" InsertVisible="False" ReadOnly="True"
                    SortExpression="TGID" Visible="False" />
                      </Columns>
                      <RowStyle CssClass="GridItem" />
                      <HeaderStyle CssClass="GridHeader" />                    
                      <AlternatingRowStyle CssClass="GridAltItem" />
                    </asp:GridView>
                  </span></td>
            <td >&nbsp;</td>
            <td valign="top" ><span style="width: 100px; height: 181px;">
                    <asp:RadioButtonList ID="RadioButtonListTestSubgroup" runat="server" AutoPostBack="True"
                            DataSourceID="ForTestSubGroup" DataTextField="TSGName" DataValueField="TSGID"
                            Width="261px" CssClass="text_titles_bold"> </asp:RadioButtonList>
                  </span></td>
                  <td valign="top" ><span style="height: 303px">&nbsp;<br />
                    <br />
                                                                                          </span>
                    <asp:SqlDataSource ID="ForTestGroup" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                        SelectCommand="SELECT [TGName], [TGID] FROM [TestGroup]"></asp:SqlDataSource>
                    <asp:SqlDataSource ID="ForTestSubGroup" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                        SelectCommand="SELECT [TSGName], [TSGID] FROM [TestSubGroup] WHERE ([TGID] = @TGID)">
                      <SelectParameters>
                        <asp:ControlParameter ControlID="HiddenFieldTestSubGroup" Name="TGID" PropertyName="Value"
                                Type="Int32" />
                      </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="ForTest" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                        SelectCommand="SELECT [TestName], [TID] FROM [Test] WHERE ([TGID] = @TGID)">
                      <SelectParameters>
                        <asp:ControlParameter ControlID="HiddenFieldTestSubGroup" Name="TGID" PropertyName="Value"
                      Type="Int32" />
                      </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:HiddenField ID="HiddenFieldTestSubGroup" runat="server" />
                    <asp:SqlDataSource ID="SqlDataSourcefortsetSG" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                SelectCommand="SELECT [TID], [TestName] FROM [Test] WHERE ([TSGID] = @TSGID)">
                      <SelectParameters>
                        <asp:ControlParameter ControlID="RadioButtonListTestSubgroup" Name="TSGID" PropertyName="SelectedValue"
                        Type="Int32" />
                      </SelectParameters>
                    </asp:SqlDataSource></td>
                </tr>
          
          <tr>
            <td height="15" ></td>
            <td ></td>
            <td ></td>
            <td ></td>
          </tr>
          <tr>
            <td height="62" colspan="4" valign="top" dir="ltr" ><span style="width: 97px;">
              <asp:Label  ID="labelGName"
                runat="server" Width="313px"></asp:Label>&nbsp;<br />
              <asp:Label  ID="LabelMessage" runat="server"></asp:Label>                <asp:DataList ID="DataList1" runat="server" DataKeyField="TID" DataSourceID="SqlDataSourceTest" RepeatColumns="3" Width="100%">
                    <ItemTemplate>
                        
                        <table>
                            <tr>
                                <td style="width: 270px">
                                    <asp:Label ID="T1" runat="server" Text='<%# Eval("TID", "{0}") %>' Visible="False"></asp:Label>
                                    <asp:Label ID="T2" runat="server" Text='<%# Eval("TCID", "{0}") %>' Visible="False"></asp:Label>
                                    <asp:Label ID="TestNameLabel" runat="server" Text='<%# Eval("ComponentName", "{0}") %>' CssClass="text_titles_bold"></asp:Label></td>
                                <td style="width: 94px">
                                    <asp:TextBox ID="TextBox1" runat="server" Width="77px"></asp:TextBox></td>
                                <td style="width: 100px">
                                    <asp:Label ID="Label1" runat="server" CssClass="text_titles_bold" Text='<%# Eval("TUnitName", "{0}") %>' ForeColor="Blue"></asp:Label></td>
                            </tr>
                        </table><asp:HiddenField ID="HiddenfieldMax" runat="server" Value='<%# Eval("Expr2", "{0}") %>' />
                        <asp:HiddenField ID="HiddenFieldMin" runat="server" Value='<%# Eval("Expr1", "{0}") %>' />
                        <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="TextBox1"
                            ErrorMessage="RangeValidator" CssClass="text_titles_bold"></asp:RangeValidator>
                    </ItemTemplate>
                </asp:DataList>
            </span></td>
            </tr>
          <tr>
            <td height="2" ></td>
            <td ></td>
            <td ></td>
            <td ></td>
          </tr>
          
          
          
          
          
          <tr>
            <td height="67" colspan="4" align="center" valign="top" >
                &nbsp;&nbsp;
<asp:Button ID="btnAdd" runat="server" Text="ADD" Width="150px" />
&nbsp;&nbsp;<asp:Button ID="Button_Next" runat="server" Text="Move To Treatment" Width="150px" />
                <asp:Button ID="Button_lab_Test" runat="server" Text="Move To Lab. Test" Width="150px" />&nbsp;
<asp:ImageButton ID="ImageButtonhome" ImageUrl="images/image_bt_home.gif" Width="64" Height="30" runat="server" Visible="false" />
<asp:ImageButton ID="ImageButtonback" ImageUrl="images/image_bt_back.gif" Width="66"   Height="30" runat="server" Visible="false" />
<asp:ImageButton ID="ImageButtonlogout" runat="server" ImageUrl="images/image_logout_up.gif" Visible="false" />
&nbsp;            <asp:SqlDataSource ID="SqlDataSourceTest" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    SelectCommand="SELECT DISTINCT &#13;&#10;                      Test.TID, Test.TGID, TestComponent.TCID, TestComponent.ComponentName, MIN(TestReference_values.ValueStart) AS Expr1, &#13;&#10;                      MAX(TestReference_values.ValueEnd) AS Expr2, TestMUnit.TUnitName&#13;&#10;FROM         Test INNER JOIN&#13;&#10;                      TestComponent ON Test.TID = TestComponent.TID INNER JOIN&#13;&#10;                      TestMUnit ON TestComponent.TMUnitID = TestMUnit.TMUnitID FULL OUTER JOIN&#13;&#10;                      TestReference_values ON TestComponent.TCID = TestReference_values.TCID&#13;&#10;WHERE (Test.TSGID = @TSGID)&#13;&#10;GROUP BY Test.TID, Test.TGID, TestComponent.TCID, TestComponent.ComponentName, TestMUnit.TUnitName &#13;&#10;">
  <SelectParameters>
    <asp:ControlParameter ControlID="RadioButtonListTestSubgroup" Name="TSGID" PropertyName="SelectedValue" />
  </SelectParameters>
</asp:SqlDataSource>
                <asp:HiddenField ID="HiddenFieldValues" runat="server" />
                <asp:HiddenField ID="HiddenFieldValueID" runat="server" />
                <asp:HiddenField ID="Hiddenfieldtestvalue" runat="server" />
                <asp:HiddenField ID="Hiddenfieldtestid" runat="server" />
                <asp:HiddenField ID="HiddenFieldComponent" runat="server" />            </td>
            </tr>
          <tr>
            <td height="116" >&nbsp;</td>
            <td >&nbsp;</td>
            <td >&nbsp;</td>
            <td dir="ltr" >&nbsp;</td>
          </tr>
          
          
          
          
          
          
          
          
          
          
              
          

          
          
          
          
          
          
          

          
          
          
          
          
          
          
          
          
          

          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          </table></td>
          </tr>
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
    </table></td>
    <td width="33" valign="top" class="right_border" style="width: 33px"><img src="images1/img_border_right.gif" width="23" height="15" /></td>
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