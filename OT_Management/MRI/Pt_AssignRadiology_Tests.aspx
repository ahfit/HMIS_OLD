<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Pt_AssignRadiology_Tests.aspx.vb" Inherits="Pt_AssignRadiology_Tests" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
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
    <td width="932" height="7" valign="top"><img src="images/image_line_01.gif" width="932" height="7"></td>
  <td width="14" rowspan="3" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
  </tr>
  <tr>
    <td height="32" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" background="images/image_title_40.gif">
      <!--DWLayoutTable-->
      <tr>
        <td width="932" height="32" valign="middle" class="text_header"><div align="center"></div></td>
          </tr>
    </table></td>
    </tr>
  
  <tr>
    <td height="575" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" background="images/image_bg_05.gif">
      <!--DWLayoutTable-->
      <tr>
        <td height="30" colspan="4" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" background="images/image_title_50.gif">
          <!--DWLayoutTable-->
          <tr>
            <td width="730" height="30" valign="middle">&nbsp;&nbsp;&nbsp;&nbsp;<span class="text_header_new_2">Lab Test&nbsp;&gt;&gt;&nbsp;Radiology    </span></td>
                  <td width="66" valign="top"><asp:ImageButton ID="ImageButtonhome" ImageUrl="images/image_bt_home.gif" Width="64" Height="30" runat="server" Visible="true" /></td>
                  <td width="64" valign="top"><asp:ImageButton ID="ImageButtonback" ImageUrl="images/image_bt_back.gif" Width="66" Height="30" runat="server" Visible="true" /></td>
                  <td width="71" align="left" valign="top"><asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="images/image_logout_up.gif" Visible="true" /></td>
                </tr>
          
          </table></td>
          </tr>
      <tr>
        <td height="30" colspan="4" valign="top"><div id="tabs" style="width:932px;">
          <p>
              &nbsp;</p>
                
            </div></td>
          </tr>
      <tr>
        <td height="30" colspan="4" valign="top"><div id="tabs" style="width:932px;">
          <p >
              &nbsp;</p>
               
            </div></td>
        </tr>
      <tr>
        <td width="23" height="22">&nbsp;</td>
          <td width="284">&nbsp;</td>
          <td width="596" valign="middle"><asp:Label ID="Label2" runat="server" Width="399px" CssClass="text_labels"></asp:Label></td>
          <td width="29">&nbsp;</td>
        </tr>
      <tr>
        <td height="68">&nbsp;</td>
          <td colspan="2" valign="top"><asp:DataList CssClass="link1"
            DataKeyField="RSGID" ID="DataListRadiology" RepeatDirection="Horizontal" runat="server" Width="800px" DataSourceID="SqlDataSourceRadiologySubGroup">
            <ItemTemplate>
                <span class="text_info1">&nbsp;
                <asp:Label ID="RSGIDLabel" runat="server" Text='<%# Eval("RSGID") %>' Visible="False"></asp:Label>
                <asp:Label ID="RSGNameLabel" runat="server" Text='<%# Eval("RSGName") %>' Visible="False"></asp:Label>
                <br />
                <asp:LinkButton id="SelectButton" CommandName ="Select" runat="server" Text='<%# Eval("RSGName") %>'/>                 
                <br />
                </span></ItemTemplate>
        <ItemStyle CssClass="GridAltItem" />
        
        </asp:DataList>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
      <tr>
        <td height="19">&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td height="32">&nbsp;</td>
        <td colspan="2" valign="top"><asp:CheckBoxList ID="CheckBoxListForRadiologySG" runat="server" DataSourceID="SqlDataSourceRadiologyForEnteries"
                DataTextField="RadiologyName" DataValueField="RID" RepeatColumns="3" Width="808px" Css> </asp:CheckBoxList></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td height="18"></td>
        <td></td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td height="30"></td>
        <td colspan="2" valign="top"><asp:Label CssClass="text_labels" ID="labelGName"
                runat="server" Width="313px"></asp:Label>
          <asp:SqlDataSource ID="SqlDataSourceRadiologyGroup" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                        SelectCommand="SELECT [TGName], [TGID] FROM [TestGroup]"></asp:SqlDataSource>
          <asp:SqlDataSource ID="SqlDataSourceRadiologySubGroup" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                        SelectCommand="SELECT     RSGID, RSGName, Fee, RGID&#13;&#10;FROM         RadiologySubGroup"> </asp:SqlDataSource>
          <asp:SqlDataSource ID="SqlDataSourceRadiologyForEnteries" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                        SelectCommand="SELECT RadiologyName, RID FROM Radiology WHERE (RSGID = @RSGID)">
            <SelectParameters>
              <asp:ControlParameter ControlID="DataListRadiology" Name="RSGID" PropertyName="SelectedValue" />
            </SelectParameters>
          </asp:SqlDataSource>
          <asp:HiddenField ID="HiddenFieldRadiologySubGroup" runat="server" />
          <asp:SqlDataSource ID="SqlDataSourceforRadiologySG" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                SelectCommand="SELECT [TID], [TestName] FROM [Test] WHERE ([TSGID] = @TSGID)"> </asp:SqlDataSource></td>
        <td></td>
      </tr>
      <tr>
        <td height="20"></td>
        <td>&nbsp;</td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td height="48"></td>
        <td colspan="2" valign="top"><asp:Label CssClass="text_labels" ID="Label1" runat="server"></asp:Label>
&nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<asp:Button ID="BTNcheckAll" runat="server" Text="Check All" UseSubmitBehavior="False" />
&nbsp;
<asp:Button ID="btnAdd" runat="server" Text="ADD" UseSubmitBehavior="False" />
&nbsp;
<asp:Button ID="BtnUncheckAll"
                runat="server" Text="UnCheck All" UseSubmitBehavior="False" /></td>
        <td></td>
      </tr>
      <tr>
        <td height="228"></td>
        <td>&nbsp;</td>
        <td></td>
        <td></td>
      </tr>
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      

      
      
      
      
      
      

      
      
      
      
      
      
      
      

      
      
      
      
      
      

      
      
      
      
      
      
      
      
      
      
      
      
      

      
      

    </table></td>
    </tr>
</table>
<script type="text/javascript" src="images/lgh_01.js"></script>
</form>
</body>
</html>
