<%@ page language="VB" autoeventwireup="false" inherits="Pt_AssignRadiology_Tests, App_Web_ppbttiod" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
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
          <td height="73" colspan="2" valign="bottom" bgcolor="#F4F4F4" ><iframe 
      src="tabs.aspx" name="holder" width="957" marginwidth="0" height="215" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
        </tr>
        
        
        <tr>
          <td width="19" height="25" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="938" valign="middle" class="text_lables3" ><span style="font-size: 15pt; font-family: Arial">Lab Test&nbsp;&gt;&gt;&nbsp;Radiology </span></td>
          </tr>
        <tr><div id ="a1" runat ="server">
          <td>&nbsp;</td>
        <tr>
          <td height="277" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
            <!--DWLayoutTable-->
            <tr>
              <td width="20" rowspan="3" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td width="913" height="19" valign="top" style="height: 10px; text-align: center;"><img src="images1/img_spacer2.gif" width="2" height="10" />
                      <asp:Label ID="Label_message" runat="server" ></asp:Label></td>
                  <td width="20" rowspan="3" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td width="4">&nbsp;</td>
              </tr>
            <tr>
              <td height="235" valign="top"><asp:Label ID="Label2" runat="server" Width="399px" CssClass="text_lables_login"></asp:Label>
                <br />
                <table width="100%" border="0" cellpadding="0" cellspacing="0" >
                  <!--DWLayoutTable-->
                  <tr>
                    <td colspan="2" valign="top"><asp:DataList CssClass="link1" ID="DataListRadiology" RepeatDirection="Horizontal" runat="server" Width="800px" DataSourceID="SqlDataSourceRadiologySubGroup">
                      <ItemStyle CssClass="GridAltItem" />                
                    </asp:DataList>
                      &nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="2" valign="top"><asp:CheckBoxList ID="CheckBoxListForRadiologySG" runat="server" DataSourceID="SqlDataSourceRadiologyForEnteries"
                DataTextField="RadiologyName" DataValueField="RID" RepeatColumns="3" Width="808px" > </asp:CheckBoxList></td>
                  </tr>
                  <tr>
                    <td></td>
                    <td></td>
                  </tr>
                  <tr>
                    <td colspan="2" valign="top"><asp:Label CssClass="text_labels" ID="labelGName"
                runat="server" Width="313px"></asp:Label>&nbsp;
                        <asp:SqlDataSource ID="SqlDataSourceRadiologySubGroup" runat="server" ConnectionString="<%$ ConnectionStrings:RadiologyConnectionString %>"
                        SelectCommand="SELECT RadiologySubGroup.* FROM RadiologySubGroup&#13;&#10;where Priority<3"> </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSourceRadiologyForEnteries" runat="server" ConnectionString="<%$ ConnectionStrings:RadiologyConnectionString %>"
                        SelectCommand="SELECT RadiologyName, RID FROM Radiology_Element WHERE (RSGID = @RSGID)">
                          <SelectParameters>
                            <asp:ControlParameter ControlID="DataListRadiology" Name="RSGID" PropertyName="SelectedValue" />
                          </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:HiddenField ID="HiddenFieldRadiologySubGroup" runat="server" />
                        </td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td></td>
                  </tr>
                  <tr>
                    <td colspan="2" valign="top"><asp:Label CssClass="text_labels" ID="Label1" runat="server"></asp:Label>
                      &nbsp;<br />
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      <asp:Button ID="BTNcheckAll" runat="server" Text="Check All" UseSubmitBehavior="False" OnClick="BTNcheckAll_Click" />
                      &nbsp;
                      <asp:Button ID="btnAdd" runat="server" Text="ADD" UseSubmitBehavior="False" />
                      &nbsp;
                      <asp:Button ID="BtnUncheckAll"
                runat="server" Text="UnCheck All" UseSubmitBehavior="False" /></td>
                  </tr>
                </table></td>
                <td>&nbsp;</td>
              </tr>
            <tr>
              <td height="23">&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            
            
            
            
            
              <asp:HiddenField ID="HiddenFieldToolTIp" runat="server" Value="true" /><asp:HiddenField ID="HiddenField1" runat="server" Value="true" />
            
            
            
            </table></td>
          <!-- </div>-->
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