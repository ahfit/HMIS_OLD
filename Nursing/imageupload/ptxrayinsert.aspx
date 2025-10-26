<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage.master" inherits="Administrator_ptxrayinsert, App_Web_vc5enb21" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<link href="images/lgh_001.css" rel="stylesheet" type="text/css">
<link href="images/lgh_003.css" rel="stylesheet" type="text/css">

</head>

<body>

<form id="form1" runat = server>

<table width="960" border="0" align="center" cellpadding="0" cellspacing="0" background="images/image_bg_01.gif">
  <!--DWLayoutTable-->
  <tr>
    <td width="14" rowspan="3" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
    <td width="932" height="7" valign="top" style="width: 932px"><img src="images/image_line_01.gif" width="932" height="7"></td>
  <td width="14" rowspan="3" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
  </tr>
  <tr>
    <td height="32" valign="top" style="width: 932px"><table width="100%" border="0" cellpadding="0" cellspacing="0" background="images/image_title_40.gif">
      <!--DWLayoutTable-->
      <tr>
        <td width="932" height="32" valign="middle" class="text_header"><div align="center"></div></td>
          </tr>
    </table></td>
    </tr>
  
  <tr>
    <td height="543" valign="top" style="width: 932px"><table width="100%" border="0" cellpadding="0" cellspacing="0" background="images/image_bg_05.gif">
      <!--DWLayoutTable-->
      <tr>
        <td height="30" colspan="3" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" background="images/image_title_50.gif">
          <!--DWLayoutTable-->
          <tr>
            <td width="731" align="left" valign="middle" style="height: 30px">&nbsp;&nbsp;&nbsp;<span class="text_header_new_2">
              Load Xray </span></td>
                  <td width="64" valign="top" style="height: 30px"><asp:ImageButton ID="ImageButtonhome" ImageUrl="images/image_bt_home.gif" Width="64" Height="30" runat="server" /></td>
<!--                  <td width="66" valign="top" style="height: 30px"><a href="PatientXRay.aspx"><img src="images/image_bt_back.gif" width="66" height="30" border="0" /></a></td> -->
                  <td width="71" valign="top" style="height: 30px"><asp:ImageButton ID="ImageButtonBack" runat="server" ImageUrl="images/image_bt_back.gif" /></td>
                  <td width="71" valign="top" style="height: 30px"><asp:ImageButton ID="ImageButtonLogOut" runat="server" ImageUrl="images/image_logout_up.gif" /></td>
                </tr>
          
          </table></td>
          </tr>
      <tr>
        <td style="height: 65px; width: 33px;">&nbsp;            </td>
            <td width="870" style="height: 65px">
                <table>
                    <tr>
                        <td style="width: 100px">
                            <table border="0" cellpadding="0" cellspacing="0" class="myborder" style="width: 50%">
                                <!--DWLayoutTable-->
                                <tr>
                                    <td align="right" class="myborder2" height="25" valign="middle" width="74">
                                        <span class="text_labels_two">Name :&nbsp;</span></td>
                                    <td class="myborder3" style="width: 373px" valign="middle">
                                        &nbsp;
                                        <asp:Label ID="labelPName" runat="server" CssClass="text_boxtitle" Width="350px"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" class="myborder2" height="25" valign="middle">
                                        <span class="text_labels_two">S/o :&nbsp;</span></td>
                                    <td class="myborder3" style="width: 373px" valign="middle">
                                        <strong><span style="font-size: 8pt; font-family: Verdana">&nbsp; </span></strong>
                                        <asp:Label ID="LabelRName" runat="server" CssClass="text_boxtitle" Width="300px"></asp:Label><strong><span
                                            style="font-size: 8pt; font-family: Verdana">
                                            <br />
                                        </span></strong>
                                        <asp:Label ID="LabelRelation" runat="server" CssClass="text_labels_two" Visible="false"
                                            Width="25px"></asp:Label><span style="font-size: 8pt; font-family: Verdana"><strong>
                                            </strong></span>
                                    </td>
                                </tr>
                                <tr style="font-weight: bold; font-size: 8pt; font-family: Verdana">
                                    <td align="right" class="myborder2" style="height: 35px" valign="middle">
                                        <span class="text_labels_two"><span style="font-size: 12pt; font-family: Times New Roman">
                                            Doctor </span>:&nbsp;</span></td>
                                    <td class="myborder3" style="font-size: 8pt; width: 373px; font-family: Verdana;
                                        height: 35px" valign="top">
                                        <!--DWLayoutEmptyCell-->
                                        &nbsp;</td>
                                </tr>
                            </table>
                        </td>
                        <td style="font-size: 8pt; width: 511px; font-family: Verdana">
                            <table border="0" cellpadding="0" cellspacing="0" class="myborder" width="100%">
                                <!--DWLayoutTable-->
                                <tr>
                                    <td align="right" class="myborder2" height="26" valign="middle" width="118">
                                        <span class="text_labels_two"><span style="font-size: 12pt; font-family: Times New Roman">
                                            Age :&nbsp;</span> </span>
                                    </td>
                                    <td class="myborder2" valign="middle" width="290">
                                        <span class="text_labels_two">&nbsp;</span>
                                        <asp:Label ID="LabelPAge" runat="server" CssClass="text_boxtitle"></asp:Label>
                                        <asp:Label ID="LabelAge" runat="server" CssClass="text_boxtitle"></asp:Label><strong><span
                                            style="font-size: 8pt; font-family: Verdana"> </span></strong>
                                        <asp:Label ID="LabelPType" runat="server" CssClass="text_boxtitle" Visible="False"></asp:Label>
                                    </td>
                                    <td align="right" class="myborder2" valign="middle" width="72">
                                        <span class="text_labels_two">BP :&nbsp;</span></td>
                                    <td class="myborder3" valign="middle" width="264">
                                        <span class="text_labels_two">&nbsp;</span>
                                        <asp:Label ID="LabelBP" runat="server" CssClass="text_boxtitle"></asp:Label>
                                        /
                                        <asp:Label ID="LabelBPLow" runat="server" CssClass="text_boxtitle"></asp:Label>
                                        <asp:Label ID="Label1" runat="server" CssClass="text_info2" Text="mm/gh"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" class="myborder2" height="25" valign="middle">
                                        <span class="text_labels_two">Pulse :&nbsp;</span></td>
                                    <td class="myborder2" valign="middle">
                                        <span class="text_labels_two">&nbsp;</span>
                                        <asp:Label ID="LabelPulse" runat="server" CssClass="text_boxtitle"></asp:Label>
                                        <asp:Label ID="Label2" runat="server" CssClass="text_info2" Text="bpm"></asp:Label>
                                    </td>
                                    <td align="right" class="myborder2" valign="middle">
                                        <span class="text_labels_two">RR :&nbsp;</span></td>
                                    <td class="myborder3" valign="middle">
                                        <span class="text_labels_two">&nbsp;</span>
                                        <asp:Label ID="LabelRR" runat="server" CssClass="text_boxtitle"></asp:Label>
                                        <asp:Label ID="Label3" runat="server" CssClass="text_info2" Text="per min."></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" class="myborder2" height="25" valign="middle">
                                        <span class="text_labels_two">Temp :&nbsp;</span></td>
                                    <td class="myborder2" valign="middle">
                                        <span class="text_labels_two">&nbsp;</span>
                                        <asp:Label ID="LabelTemp" runat="server" CssClass="text_boxtitle"></asp:Label>
                                        <asp:Label ID="Label4" runat="server" CssClass="text_info2" Text="F"></asp:Label>
                                    </td>
                                    <td align="right" class="myborder2" valign="middle">
                                        <!--DWLayoutEmptyCell-->
                                        &nbsp;</td>
                                    <td class="myborder3" valign="middle">
                                        <!--DWLayoutEmptyCell-->
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td height="0">
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="29" style="height: 65px">&nbsp;</td>
        </tr>
      <tr>
        <td height="494" style="width: 33px">&nbsp;</td>
          <td valign="top" style="height: 414px"><table width="100%" border="0" cellpadding="0" cellspacing="0">
            <!--DWLayoutTable-->
            <tr>
              <td width="870" align="center" valign="middle" style="height: 27px">
                  <br />
                  <asp:Label ID="Bodypart" runat="server" Text="Body Part" Width="340px"></asp:Label>
                <asp:Label ID="LabelXray" runat="server" Width="264px"></asp:Label><br />
                <asp:Label ID="projec" runat="server" Text="Projection" Width="329px"></asp:Label>&nbsp;
                <asp:Label ID="labelpro" runat="server" Width="253px"></asp:Label><br />
                  <asp:FileUpload ID="FileUploadXray" runat="server" EnableViewState="False" />                &nbsp;&nbsp;&nbsp;&nbsp;<br />
                <br />
                  <asp:SqlDataSource ID="SqlDataSourceXray" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                      InsertCommand="Rd_insert_Xray_description"
                      ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" InsertCommandType="StoredProcedure" UpdateCommand="UPDATE Rd_Xray_Report SET Xray_Description = @Xray_Description&#13;&#10;Where ((YearlyNo = @YearlyNo) and (RegNo = @RegNo) and (Xray_ID = @XRay_ID))">
                      <InsertParameters>
                          <asp:QueryStringParameter Name="Xray_ID" QueryStringField="XRay_ID" />
                          <asp:QueryStringParameter Name="RegNo" QueryStringField="reg_no" />
                          <asp:QueryStringParameter Name="YearlyNo" QueryStringField="PayID" />
                          <asp:ControlParameter ControlID="TextBoxXrayReport" Name="Xray_Description" PropertyName="Text" />
                      </InsertParameters>
                      <UpdateParameters>
                          <asp:ControlParameter ControlID="TextBoxXrayReport" Name="Xray_Description" PropertyName="Text" />
                          <asp:QueryStringParameter Name="YearlyNo" QueryStringField="payId" />
                          <asp:QueryStringParameter Name="RegNo" QueryStringField="reg_no" />
                          <asp:QueryStringParameter Name="XRay_ID" QueryStringField="Xray_ID" />
                      </UpdateParameters>
                  </asp:SqlDataSource>
                  &nbsp;&nbsp;</td>
              </tr>
              <tr>
                  <td align="center" height="38" valign="middle" width="870" style="vertical-align: middle; text-align: center">
                      <table>
                          <tr>
                              <td style="width: 143px">
                      Report for the Xray :</td>
                              <td style="width: 100px">
                      <asp:TextBox ID="TextBoxXrayReport" runat="server" Height="160px" Rows="10" TextMode="MultiLine"
                          Width="378px"></asp:TextBox></td>
                          </tr>
                      </table>
                      &nbsp;
                      <br />
                <asp:Button ID="btnSave" runat="server" Text="Save" Width="107px" />
                      <asp:Button ID="ButtonUpdate" runat="server" Text="Update Report" Width="122px" Visible="False" /><br />
                      <asp:SqlDataSource ID="SqlDataSourceUpdate" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                          ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" UpdateCommand="UPDATE Rd_Xray_Report SET Xray_Description = @Xray_Description&#13;&#10;Where ((YearlyNo = @YearlyNo) and (RegNo = @RegNo) and (Xray_ID = @XRay_ID))">
                                 <UpdateParameters>
                          <asp:ControlParameter ControlID="HiddenFieldDiscription" Name="Xray_Description" PropertyName="Value" />
                          <asp:QueryStringParameter Name="YearlyNo" QueryStringField="payId" />
                          <asp:QueryStringParameter Name="RegNo" QueryStringField="reg_no" />
                          <asp:QueryStringParameter Name="XRay_ID" QueryStringField="Xray_ID" />
                      </UpdateParameters>
                          
                          </asp:SqlDataSource>
                      <asp:HiddenField ID="HiddenFieldDiscription" runat="server" />
                          
                  </td>
              </tr>
            <tr>
              <td height="456"></td>
            </tr>
            
            
            
            </table></td>
          <td>&nbsp;</td>
        </tr>
      
      
      
      

      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      

      
      
      
      
      
      
      
      
      
      
      
      
      

      
      

      
      
    </table></td>
    </tr>
</table>
<script type="text/javascript" src="images/lgh_01.js"></script>
</form>
</body>
</html>
