<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PatientXRay.aspx.vb" Inherits="Administrator_PatientXRay" %>

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
              Patient X-Ray</span></td>
                  <td width="64" valign="top" style="height: 30px"><asp:ImageButton ID="ImageButtonhome" ImageUrl="images/image_bt_home.gif" Width="64" Height="30" runat="server" /></td>
                  <td width="66" valign="top" style="height: 30px"><asp:ImageButton ID="ImageButtonback" ImageUrl="images/image_bt_back.gif" Width="66" Height="30" runat="server" /></td>
                  <td width="71" valign="top" style="height: 30px"><asp:ImageButton ID="ImageButtonlogout" runat="server" ImageUrl="images/image_logout_up.gif" /></td>
                </tr>
          
          </table></td>
          </tr>
      <tr>
        <td height="494">&nbsp;</td>
          <td valign="top" style="height: 414px"><table width="100%" border="0" cellpadding="0" cellspacing="0">
            <!--DWLayoutTable-->
            <tr>
              <td width="870" height="494" align="center" valign="top" style="height: 390px">
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
                  <br />
                  <br />
                  <asp:Label ID="LabelAttach" runat="server" Width="828px"></asp:Label><br />
                  <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceXray"
                     Width="870px" DataKeyNames="XID">
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
<asp:HiddenField ID="HiddenFieldSubDept" runat="server" /></td>
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
