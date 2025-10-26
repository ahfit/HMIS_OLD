<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MRI_Test_Medicine.aspx.vb" Inherits="MRI_Test_Medicine" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">

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
      src="tabs.aspx" name="holder" width="957" marginwidth="0" height="157" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
        </tr>
      
      
      <tr>
        <td width="19" height="25" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td width="929" valign="middle" class="text_lables3">
              Assign Medicines
          </td>
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
            <td valign="top" style="height: 145px"><table width="100%" border="0" cellpadding="0" cellspacing="0"  >
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
                    <br />
                </td>
                      </tr>
                <tr>
                    <td align="center" colspan="4" height="35" style="text-align: left" valign="middle">
                        <asp:CheckBoxList ID="CheckBoxListForRadiologySG" runat="server" CssClass="text_titles_bold"
                            DataSourceID="SqlDataSourceRadiologyForEnteries" DataTextField="Med_Name"
                            DataValueField="Med_Code" RepeatColumns="3" Width="808px">                        </asp:CheckBoxList></td>
                </tr>
              
              
                        </table>
                <br />
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                <asp:Button ID="BTNcheckAll" runat="server" Text="Check All" UseSubmitBehavior="False" />
                &nbsp;
                <asp:Button ID="btnAdd" runat="server" Text="ADD" UseSubmitBehavior="False" />
                &nbsp;
                <asp:Button ID="BtnUncheckAll" runat="server" Text="UnCheck All" UseSubmitBehavior="False" /></td>
                </tr>
          <tr>
            <td height="13" align="right" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
          </tr>
          <tr>
            <td height="254" valign="top"><span style="height: 390px">&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
                <asp:SqlDataSource ID="SqlDataSourceRadiologyForEnteries" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    SelectCommand="SELECT Med_Name, Med_Code FROM Medicines">
                </asp:SqlDataSource>
                &nbsp;&nbsp;
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