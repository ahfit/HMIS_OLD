<%@ page language="VB" autoeventwireup="false" inherits="PtxrayView1, App_Web_rbfdm1yf" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="Paragma" content="no-cache"/>

<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />

</head>

<body onload="MM_preloadImages('images1/img_btn_over.gif')" dir="ltr">
<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_top.gif" alt="" width="1003" height="24" /></td>
  </tr>
  
  
  <tr>
    <td width="23" height="478" valign="top" class="left_border"><img src="images1/img_border_left.gif" alt="" width="23" height="15" /></td>
    <td width="957" valign="top">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <!--DWLayoutTable-->
        <tr>
          <td width="957" height="40" valign="bottom" bgcolor="#F4F4F4" ><img src="images1/img_services.jpg" width="957" height="40"  alt="" /></td>
        </tr>
        <tr>
          <td height="23" valign="middle" class="text_lables3" ><!--DWLayoutEmptyCell-->&nbsp;</td>
          </tr>
        <tr>
          <td height="289" valign="top" ><table width="100%" border="0" cellpadding="0" cellspacing="0">
            <!--DWLayoutTable-->
            <tr>
              <td width="16" height="16"></td>
                <td style="text-align: center" colspan="4">
                    <asp:Label ID="Label_message" runat="server" Width="600px"></asp:Label></td>
                <td width="22"></td>
              </tr>
            <tr>
              <td height="109">&nbsp;</td>
                <td colspan="2" valign="top"><table border="0" cellpadding="0" cellspacing="0" class="myborder" style="width: 50%">
                    <!--DWLayoutTable-->
                    <tr>
                      <td align="right" class="myborder2" height="25" valign="middle" width="74"><span class="text_labels_two" style="font-size: 8pt; font-family: Verdana"><strong>Name
                        :&nbsp;</strong></span></td>
                      <td class="myborder3" style="font-weight: bold; font-size: 8pt; width: 373px; font-family: Verdana"
                                    valign="middle">&nbsp;
                          <asp:Label ID="labelPName" runat="server" CssClass="text_boxtitle" Width="350px"></asp:Label>
                        <span> </span> </td>
                      <td width="9"></td>
                    </tr>
                    <tr style="font-size: 8pt; font-family: Times New Roman">
                      <td align="right" class="myborder2" height="25" valign="middle"><span >S/o :&nbsp;</span></td>
                      <td class="myborder3" style="width: 373px; font-family: Times New Roman" valign="middle"><span style="font-size: 12pt">&nbsp; </span>
                          <asp:Label ID="LabelRName" runat="server" CssClass="text_boxtitle" Width="300px"></asp:Label>
                          <asp:Label ID="LabelRelation" runat="server" CssClass="text_labels_two" Visible="false"
                                        Width="25px"></asp:Label>
                        <span style="font-family: Verdana"> </span> </td>
                      <td></td>
                    </tr>
                    <tr style="font-weight: bold; font-size: 8pt; font-family: Verdana">
                      <td align="right" class="myborder2" style="height: 35px" valign="middle"><span class="text_labels_two"><span>Doctor </span>:&nbsp;</span></td>
                      <td class="myborder3" style="font-size: 8pt; width: 373px; font-family: Verdana;
                                    height: 35px" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td></td>
                    </tr>
                  <tr>
                    <td height="11"></td>
                      <td></td>
                      <td></td>
                    </tr>
                            </table></td>
                <td>&nbsp;</td>
                <td valign="top"><table border="0" cellpadding="0" cellspacing="0" class="myborder" width="100%">
                    <!--DWLayoutTable-->
                    <tr>
                      <td align="right" class="myborder2" height="26" valign="middle" width="118"><span ><span>Age :&nbsp;</span> </span> </td>
                      <td class="myborder2" style="font-weight: bold; font-size: 8pt" valign="middle" width="290"><span class="text_labels_two">&nbsp;</span>
                          <asp:Label ID="LabelPAge" runat="server" CssClass="text_boxtitle"></asp:Label>
                          <asp:Label ID="LabelAge" runat="server" CssClass="text_boxtitle"></asp:Label>
                        <span
                                        style="font-family: Verdana"> </span>
                          <asp:Label ID="LabelPType" runat="server" CssClass="text_boxtitle" Visible="False"></asp:Label>                  </td>
                      <td align="right" class="myborder2" style="font-size: 8pt" valign="middle" width="72"><span >BP :&nbsp;</span></td>
                      <td class="myborder3" style="font-size: 8pt" valign="middle" width="264"><span class="text_labels_two">&nbsp;</span>
                          <asp:Label ID="LabelBP" runat="server" CssClass="text_boxtitle"></asp:Label>
                        /
                        <asp:Label ID="LabelBPLow" runat="server" CssClass="text_boxtitle"></asp:Label>
                        <asp:Label ID="Label1" runat="server" CssClass="text_info2" Text="mm/gh"></asp:Label>                  </td>
                    </tr>
                    <tr style="font-size: 8pt">
                      <td align="right" class="myborder2" height="25" valign="middle"><span >Pulse :&nbsp;</span></td>
                      <td class="myborder2" valign="middle"><span class="text_labels_two">&nbsp;</span>
                          <asp:Label ID="LabelPulse" runat="server" CssClass="text_boxtitle"></asp:Label>
                          <asp:Label ID="Label2" runat="server" CssClass="text_info2" Text="bpm"></asp:Label>                  </td>
                      <td align="right" class="myborder2" valign="middle"><span >RR :&nbsp;</span></td>
                      <td class="myborder3" valign="middle"><span class="text_labels_two">&nbsp;</span>
                          <asp:Label ID="LabelRR" runat="server" CssClass="text_boxtitle"></asp:Label>
                          <asp:Label ID="Label3" runat="server" CssClass="text_info2" Text="per min."></asp:Label>                  </td>
                    </tr>
                    <tr style="font-size: 8pt">
                      <td align="right" class="myborder2" height="25" valign="middle"><span >Temp :&nbsp;</span></td>
                      <td class="myborder2" valign="middle"><span class="text_labels_two">&nbsp;</span>
                          <asp:Label ID="LabelTemp" runat="server" CssClass="text_boxtitle"></asp:Label>
                          <asp:Label ID="Label4" runat="server" CssClass="text_info2" Text="F"></asp:Label>                  </td>
                      <td align="right" class="myborder2" valign="middle"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td class="myborder3" valign="middle"><!--DWLayoutEmptyCell-->&nbsp;</td>
                    </tr>
                    <tr style="font-size: 8pt">
                      <td height="31"></td>
                      <td></td>
                      <td></td>
                      <td></td>
                    </tr>
                            </table></td>
                <td>&nbsp;</td>
              </tr>
            <tr>
              <td height="18"></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
              </tr>
            <tr>
              <td height="55"></td>
              <td colspan="4" align="center" valign="top"><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT [Image] FROM [pt_Xray_Images] where xray_id = @Xray_ID and RegNo = @RegNo and YearlyNo=@YearlyNo ">
                <SelectParameters>
                  <asp:QueryStringParameter Name="Xray_ID" QueryStringField="Xray_id" />
                  <asp:QueryStringParameter Name="RegNo" QueryStringField="rig_no" />
                  <asp:QueryStringParameter Name="YearlyNo" QueryStringField="payid" />
                </SelectParameters>
              </asp:SqlDataSource>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
                  <Columns>
                  <asp:TemplateField>
                    <ItemTemplate>
                      <asp:Image ID="Image1" runat="server" />                    </ItemTemplate>
                  </asp:TemplateField>
                  </Columns>
                </asp:GridView>
&nbsp;</td>
                <td></td>
            </tr>
            <tr>
              <td height="10"></td>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
            </tr>
            <tr>
              <td height="26"></td>
              <td align="right" valign="middle"><span  style="width: 202px; height: 224px">Xray Description :&nbsp; </span></td>
              <td colspan="3" rowspan="2" valign="top"><span style="width: 390px; height: 224px">
                <asp:TextBox ID="TextBoxXrayDescription" runat="server" Height="214px" Rows="10"
                            TextMode="MultiLine" Width="406px"></asp:TextBox>
              </span></td>
              <td></td>
            </tr>
            <tr>
              <td height="55"></td>
              <td>&nbsp;</td>
              <td></td>
            </tr>
            
            
            
          </table></td>
          </tr>
        <tr>
          <td height="42" >&nbsp;</td>
        </tr>
        </table></td>
    <td width="33" valign="top" class="right_border" style="width: 33px"><img src="images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_bottom.gif" alt="" width="1003" height="24" /></td>
  </tr>
</table>



</form>
     
          
       
      
      
      
      
      
      
      
      
      
      
      
      
      
   
    
</body>
</html>