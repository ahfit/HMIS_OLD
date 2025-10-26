<%@ page language="VB" autoeventwireup="false" inherits="Path_ShowTestResults, App_Web_rbfdm1yf" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
 <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title></title>
<link href="images/lgh_001.css" rel="stylesheet" type="text/css">
<link href="images/lgh_003.css" rel="stylesheet" type="text/css">

<style type="text/css">
<!--
body {
	background-color: #FFFFFF;
}
-->
</style></head>

<body style="text-align: center"><form id="form1" runat = server>
<table width="789" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="30" colspan="2" valign="middle"><span class="text_header_new_2">&nbsp;&nbsp;Patient Test Results</span><a href="javascript:history.go(-1)"></a></td>
  </tr>
  <tr>
    <td width="9" height="172">&nbsp;</td>
    <td valign="top" style="width: 955px"><span style="width: 876px"><br />
        <asp:Label ID="Label_message" runat="server" ></asp:Label><br />
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
                                <asp:Label ID="labelPName" runat="server" CssClass="text_boxtitle" Width="350px"></asp:Label><span
                                    style="font-size: 8pt"> </span>
                            </td>
                        </tr>
                        <tr style="font-size: 8pt; font-family: Times New Roman">
                            <td align="right" class="myborder2" height="25" valign="middle">
                                <span class="text_labels_two">S/o :&nbsp;</span></td>
                            <td class="myborder3" style="width: 373px; font-family: Times New Roman" valign="middle">
                                <strong><span style="font-size: 12pt">&nbsp; </span></strong>
                                <asp:Label ID="LabelRName" runat="server" CssClass="text_boxtitle" Width="300px"></asp:Label><strong><span
                                    style="font-family: Verdana">
                                    <br />
                                </span></strong>
                                <asp:Label ID="LabelRelation" runat="server" CssClass="text_labels_two" Visible="false"
                                    Width="25px"></asp:Label><span style="font-family: Verdana"><strong> </strong></span>
                            </td>
                        </tr>
                        <tr style="font-weight: bold; font-size: 8pt; font-family: Verdana">
                            <td align="right" class="myborder2" style="height: 27px" valign="middle">
                                <span class="text_labels_two"><span style="font-size: 12pt">Doctor </span>:&nbsp;</span></td>
                            <td class="myborder3" style="font-size: 8pt; width: 373px; font-family: Verdana;
                                height: 27px" valign="top">
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
                                <span class="text_labels_two"><span style="font-size: 12pt">Age :&nbsp;</span> </span>
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
                            <td align="right" class="myborder2" valign="middle" style="height: 26px">
                                <span class="text_labels_two">Temp :&nbsp;</span></td>
                            <td class="myborder2" valign="middle" style="height: 26px">
                                <span class="text_labels_two">&nbsp;</span>
                                <asp:Label ID="LabelTemp" runat="server" CssClass="text_boxtitle"></asp:Label>
                                <asp:Label ID="Label4" runat="server" CssClass="text_info2" Text="F"></asp:Label>
                            </td>
                            <td align="right" class="myborder2" valign="middle" style="height: 26px">
                                <!--DWLayoutEmptyCell-->
                                &nbsp;</td>
                            <td class="myborder3" valign="middle" style="height: 26px">
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
        <br />
        <asp:GridView ID="GridView_TestResult" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceTestResults"
                Width="837px" >
          <Columns>
          <asp:BoundField DataField="RegNo" HeaderText="RegNo" SortExpression="RegNo" Visible="False" />
          <asp:BoundField DataField="YearlyNo" HeaderText="YearlyNo" SortExpression="YearlyNo"
                        Visible="False" />
          <asp:BoundField DataField="TGName" HeaderText="Pathology Group Name" SortExpression="TGName" />
          <asp:BoundField DataField="TSGName" HeaderText="Test Gruop" SortExpression="TSGName" />
          <asp:BoundField DataField="TestName" HeaderText="Test Name" SortExpression="TestName">
            <ItemStyle Font-Bold="True" />                  </asp:BoundField>
          <asp:BoundField DataField="TCValue" HeaderText="Value" SortExpression="TCValue" />
          <asp:BoundField DataField="TGID" HeaderText="TGID" SortExpression="TGID" Visible="False" />
          <asp:BoundField DataField="TUnitName" HeaderText="Unit Name" SortExpression="TUnitName" />
          <asp:BoundField DataField="trDate" HeaderText="Date" ReadOnly="True" SortExpression="trDate" />
          </Columns>
          <RowStyle CssClass="GridItem" />
          <HeaderStyle CssClass="GridHeader" />        
            <AlternatingRowStyle CssClass="GridAltItem" />
</asp:GridView>
        <br />
        <br />
        <asp:SqlDataSource ID="SqlDataSourceTestResults" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                SelectCommand="Path_Test_Results" SelectCommandType="StoredProcedure">
          <SelectParameters>
            <asp:SessionParameter DefaultValue="LGH/011220060020" Name="Reg_No" SessionField="registrationNo"
                        Type="String" />
            <asp:SessionParameter DefaultValue="197006" Name="Yearly_No" SessionField="YearlyNo"
                        Type="Decimal" />
            <asp:Parameter DefaultValue="0" Name="TGroup" Type="Int32" />
          </SelectParameters>
        </asp:SqlDataSource>
    </span></td>
  </tr>
  <tr>
    <td height="398"></td>
    <td style="width: 955px"></td>
  </tr>
</table></form>
</body>
</html>
