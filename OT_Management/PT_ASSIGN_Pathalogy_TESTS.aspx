<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PT_ASSIGN_Pathalogy_TESTS.aspx.vb" Inherits="PT_ASSIGN_Pathalogy_TESTS" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Lahore General Hospital</title>
<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
</head>

<body>
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
        <td height="97" colspan="2" valign="top"><iframe 
      src="../tabs.aspx" name="holder" width="957" marginwidth="0" height="157" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
        </tr>
      
      
      <tr>
        <td width="19" height="25" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td width="929" valign="middle" class="text_lables3"></td>
        </tr>
      <tr>
        <td height="428" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="mainframe_bg1">
          <!--DWLayoutTable-->
          <tr>
            <td width="20" rowspan="5" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td width="917" height="10" valign="top"><img src="images1/img_spacer2.gif" width="2" height="10" /></td>
                  <td width="20" rowspan="5" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
              </tr>
          <tr>
            <td height="145" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0"  >
                    <!--DWLayoutTable-->
                    <tr>
                      <td width="183" height="10"></td>
                      <td width="151"></td>
                      <td width="165"></td>
                      <td width="418"></td>
                    </tr>
                    <!--DWLayoutTable-->
              <tr>
                <td height="35" colspan="4" align="center" valign="middle">
                    <asp:DataList ID="DataListRadiology" runat="server" CssClass="link1" DataKeyField="RSGID"
                        DataSourceID="SqlDataSourceRadiologySubGroup" RepeatDirection="Horizontal" Width="800px">
                        <ItemTemplate>
                            <span class="text_info1">&nbsp;
                                <asp:Label ID="RSGIDLabel" runat="server" Text='<%# Eval("RSGID") %>' Visible="False"></asp:Label>
                                <asp:Label ID="RSGNameLabel" runat="server" Text='<%# Eval("RSGName") %>' Visible="False"></asp:Label>
                                <br />
                                <asp:LinkButton ID="SelectButton" runat="server" CommandName="Select" Text='<%# Eval("RSGName") %>'></asp:LinkButton>
                                <br />
                            </span>
                        </ItemTemplate>
                        <ItemStyle CssClass="GridAltItem" />
                    </asp:DataList><br />
                </td>
                      </tr>
                <tr>
                    <td align="center" colspan="4" height="35" style="text-align: left" valign="middle">
                        <asp:CheckBoxList ID="CheckBoxListForRadiologySG" runat="server" Css
                            DataSourceID="SqlDataSourceRadiologyForEnteries" DataTextField="RadiologyName"
                            DataValueField="RID" RepeatColumns="3" Width="808px">
                        </asp:CheckBoxList></td>
                </tr>
              
              
                        </table>
                <asp:Button ID="BTNcheckAll" runat="server" Text="Check All" UseSubmitBehavior="False" />
                &nbsp;
                <asp:Button ID="btnAdd" runat="server" Text="ADD" UseSubmitBehavior="False" />
                &nbsp;
                <asp:Button ID="BtnUncheckAll" runat="server" Text="UnCheck All" UseSubmitBehavior="False" /></td>
                </tr>
          <tr>
            <td height="13" align="right" valign="top"><img src="images1/img_shedow.gif" width="249" height="13" /></td>
          </tr>
          <tr>
            <td height="254" valign="top"><span style="height: 390px">&nbsp; &nbsp;&nbsp;
                <asp:SqlDataSource ID="SqlDataSourceRadiologyGroup" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    SelectCommand="SELECT [TGName], [TGID] FROM [TestGroup]"></asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSourceRadiologySubGroup" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    SelectCommand="SELECT     RSGID, RSGName, Fee, RGID&#13;&#10;FROM         RadiologySubGroup">
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSourceRadiologyForEnteries" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    SelectCommand="SELECT RadiologyName, RID FROM Radiology WHERE (RSGID = @RSGID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DataListRadiology" Name="RSGID" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenFieldRadiologySubGroup" runat="server" />
                <asp:SqlDataSource ID="SqlDataSourceforRadiologySG" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    SelectCommand="SELECT [TID], [TestName] FROM [Test] WHERE ([TSGID] = @TSGID)"></asp:SqlDataSource>
            </span>
                <asp:Label ID="Label2" runat="server" CssClass="text_labels" Width="399px"></asp:Label><asp:Label
                    ID="labelGName" runat="server" CssClass="text_labels" Width="313px"></asp:Label><asp:Label
                        ID="Label1" runat="server" CssClass="text_labels"></asp:Label></td>
          </tr>
          <tr>
            <td height="9"></td>
          </tr>
          

          
          
          
          
          
          
          
          
          
          
          
          

          
          
          
          
          
          


          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          

          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          </table></td>
          </tr>
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
    </table></td>
    <td width="33" valign="top" class="right_border" ><img src="images1/img_border_right.gif" width="23" height="15" /></td>
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