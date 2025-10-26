<%@ page language="VB" autoeventwireup="false" inherits="Administrator_PatientXRay, App_Web_rbfdm1yf" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

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
        <td height="97" colspan="3" align="right" valign="middle"><iframe 
      src="tabs.aspx" name="holder2" width="957" marginwidth="0" height="215" marginheight="0" 
      scrolling="No" frameborder="0" id="holder2" ></iframe></td>
        </tr>
      
      <tr>
        <td width="19" valign="top" style="height: 25px"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td colspan="2" valign="middle" class="text_lables3" style="height: 25px" >X-Ray</td>
        </tr>
      <tr>
        <td height="428">&nbsp;</td>
        <td width="922" valign="top"><table>
          <!--DWLayoutTable-->
            <tr>
                <td colspan="4" style="text-align: center">
                    <asp:Label ID="Label_message" runat="server" ></asp:Label></td>
            </tr>
          <tr>
            <td colspan="2" style="width: 100px"><table width="181%" border="0" cellpadding="0" cellspacing="0" class="myborder" style="width: 50%">
                <!--DWLayoutTable-->
                <tr>
                  <td align="right" class="myborder2" height="25" valign="middle" width="74"><span >Name :&nbsp;</span></td>
                  <td class="myborder3" style="width: 373px" valign="middle">&nbsp;
                      <asp:Label ID="labelPName" runat="server" CssClass="text_boxtitle" Width="350px"></asp:Label>                  </td>
                </tr>
                <tr>
                  <td align="right" class="myborder2" height="25" valign="middle"><span >S/o :&nbsp;</span></td>
                  <td class="myborder3" style="width: 373px" valign="middle"><strong><span style="font-size: 8pt; font-family: Verdana">&nbsp; </span></strong>
                      <asp:Label ID="LabelRName" runat="server" CssClass="text_boxtitle" Width="300px"></asp:Label>
                    <strong><span
                                              style="font-size: 8pt; font-family: Verdana"> <br />
                      </span></strong>
                      <asp:Label ID="LabelRelation" runat="server" CssClass="text_labels_two" Visible="false"
                                              Width="25px"></asp:Label>
                    <span style="font-size: 8pt; font-family: Verdana"><strong> </strong></span> </td>
                </tr>
                <tr style="font-weight: bold; font-size: 8pt; font-family: Verdana">
                  <td align="right" class="myborder2" style="height: 35px" valign="middle"><span class="text_labels_two"><span  > Doctor </span>:&nbsp;</span></td>
                  <td class="myborder3" style="font-size: 8pt; width: 373px; font-family: Verdana;
                                          height: 35px" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                </tr>
            </table></td>
            <td colspan="2" style="font-size: 8pt; width: 511px; font-family: Verdana"><table border="0" cellpadding="0" cellspacing="0" class="myborder" width="100%">
                <!--DWLayoutTable-->
                <tr>
                  <td align="right" class="myborder2" height="26" valign="middle" width="118"><span ><span> Age :&nbsp;</span> </span> </td>
                  <td class="myborder2" valign="middle" width="290"><span class="text_labels_two">&nbsp;</span>
                      <asp:Label ID="LabelPAge" runat="server" CssClass="text_boxtitle"></asp:Label>
                      <asp:Label ID="LabelAge" runat="server" CssClass="text_boxtitle"></asp:Label>
                    <strong><span
                                              style="font-size: 8pt; font-family: Verdana"> </span></strong>
                      <asp:Label ID="LabelPType" runat="server" CssClass="text_boxtitle" Visible="False"></asp:Label>                  </td>
                  <td align="right" class="myborder2" valign="middle" style="width: 93px"><span >Reg No</span></td>
                  <td class="myborder3" valign="middle" width="264"><span class="text_labels_two">
                    <asp:Label ID="LabelRegNo" runat="server" Text="Label" Width="81px"></asp:Label>
                    &nbsp;</span> </td>
                </tr>
                <tr>
                  <td align="right" class="myborder2" height="25" valign="middle"><span >Pulse :&nbsp;</span></td>
                  <td class="myborder2" valign="middle"><span class="text_labels_two">&nbsp;</span>
                      <asp:Label ID="LabelPulse" runat="server" CssClass="text_boxtitle"></asp:Label>
                      <asp:Label ID="Label2" runat="server" CssClass="text_info2" Text="bpm"></asp:Label>                  </td>
                  <td align="right" class="myborder2" valign="middle" style="width: 93px"><span >RR :&nbsp;</span></td>
                  <td class="myborder3" valign="middle"><span class="text_labels_two">&nbsp;</span>
                      <asp:Label ID="LabelRR" runat="server" CssClass="text_boxtitle"></asp:Label>
                      <asp:Label ID="Label3" runat="server" CssClass="text_info2" Text="per min."></asp:Label>                  </td>
                </tr>
                <tr>
                  <td align="right" class="myborder2" height="25" valign="middle"><span >Temp :&nbsp;</span></td>
                  <td class="myborder2" valign="middle"><span class="text_labels_two">&nbsp;</span>
                      <asp:Label ID="LabelTemp" runat="server" CssClass="text_boxtitle"></asp:Label>
                      <asp:Label ID="Label4" runat="server" CssClass="text_info2" Text="F"></asp:Label>                  </td>
                  <td align="right" class="myborder2" valign="middle" style="font-size: 8pt; width: 93px"><strong>BP :</strong>&nbsp;</td>
                  <td class="myborder3" valign="middle" style="font-size: 8pt"><asp:Label ID="LabelBP" runat="server" CssClass="text_boxtitle"></asp:Label>
                    /
                      <asp:Label ID="LabelBPLow" runat="server" CssClass="text_boxtitle"></asp:Label>
                    <asp:Label ID="Label1" runat="server" CssClass="text_info2" Text="mmHg"></asp:Label>
                    &nbsp;</td>
                </tr>
                <tr style="font-size: 8pt">
                  <td height="0"></td>
                  <td></td>
                  <td style="width: 93px"></td>
                  <td></td>
                </tr>
            </table></td>
          </tr>
          <tr>
            <td width="6" height="14"></td>
            <td width="409"></td>
            <td width="499"></td>
            <td width="4"></td>
          </tr>
          <tr>
            <td height="189"></td>
            <td colspan="2" valign="top"><span style="height: 390px"><br />
                <br />
                <asp:Label ID="LabelAttach" runat="server" Width="828px"></asp:Label>
                <br />
                <span style="height: 30px">
                <asp:ImageButton ID="ImageButtonback" ImageUrl="images/image_bt_back.gif" Width="66" Height="30" Visible="false" runat="server" />                                </span><span style="height: 30px">
                <asp:ImageButton ID="ImageButtonlogout" runat="server" ImageUrl="images/image_logout_up.gif" Visible="false" />                
                </span>                <span style="height: 30px">
                <asp:ImageButton ID="ImageButtonhome" ImageUrl="images/image_bt_home.gif" Width="64" Height="30" Visible="false" runat="server" />                
                </span>
                <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceXray"
                     Width="870px" DataKeyNames="Expr1" >
                  <Columns>
                  <asp:BoundField DataField="Expr1" HeaderText="Part Id" SortExpression="Expr1" />
                  <asp:BoundField DataField="Rd_body_part" HeaderText="Body Part" SortExpression="Rd_body_part" />
                  <asp:BoundField DataField="Projection" HeaderText="Projection" SortExpression="Projection" />
                  <asp:BoundField DataField="Reg_No" HeaderText="Reg_No" SortExpression="Reg_No" Visible="False" />
                  <asp:BoundField DataField="Yearly_No" HeaderText="Yearly_No" SortExpression="Yearly_No"
                            Visible="False" />
                  <asp:BoundField DataField="Time_Stamp" HeaderText="Time_Stamp" SortExpression="Date Time" />
                  <asp:CommandField SelectText="Attach" ShowSelectButton="True" />
                  <asp:BoundField DataField="XID" HeaderText="XID" InsertVisible="False" ReadOnly="True"
                            SortExpression="XID" Visible="False" />
                  </Columns>
                  <RowStyle CssClass="GridItem" />
                  <HeaderStyle CssClass="GridHeader" />                
                  <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSourceXray" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    SelectCommand="SELECT Pt_Xray.ID as XID ,Pt_Xray.XRay_ID AS Expr1, Rd_xray_projections.Projections AS Projection, Pt_Xray.Reg_No, Pt_Xray.Yearly_No, Pt_Xray.Time_Stamp, Rd_body_part.Rd_body_part FROM Pt_Xray INNER JOIN Rd_xray_projections ON Pt_Xray.XRay_ID = Rd_xray_projections.Projection_ID INNER JOIN Rd_body_part ON Rd_xray_projections.Rd_Body_part_Id = Rd_body_part.Rd_body_part_id WHERE (Pt_Xray.Reg_No = @regno) AND (Pt_Xray.Yearly_No = @yearlyno)">
                  <SelectParameters>
                    <asp:ControlParameter ControlID="HiddenField_RegNo" Name="regno" PropertyName="Value" />
                    <asp:ControlParameter ControlID="HiddenField_PayID" Name="yearlyno" PropertyName="Value" />
                  </SelectParameters>
                </asp:SqlDataSource>
                <br />
                <asp:HiddenField ID="HiddenField_PayID" runat="server" />
&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
<asp:HiddenField ID="HiddenField_RegNo" runat="server" />
<asp:HiddenField ID="HiddenFieldSubDept" runat="server" />
            </span></td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td height="113"></td>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
          </tr>
        </table></td>
        <td width="16">&nbsp;</td>
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