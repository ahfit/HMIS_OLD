<%@ page language="VB" autoeventwireup="false" inherits="CMOApproval, App_Web_rbfdm1yf" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title> </title>
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
      src="tabs_cmo.aspx" name="holder" width="957" marginwidth="0" height="97" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
      </tr>
      
      <tr>
        <td width="19" height="25" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td width="929" valign="middle" class="text_lables3">CMO Approval for Test &amp; Pharmacy </td>
        </tr>
      <tr>
        <td height="428" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" background="images1/img_bg_04.gif">
          <!--DWLayoutTable-->
          <tr>
            <td width="20" rowspan="5" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td width="917" height="10" valign="top"><img src="images1/img_spacer2.gif" width="2" height="10" /></td>
                  <td width="20" rowspan="5" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
              </tr>
          <tr>
            <td height="39" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0"  >
              <!--DWLayoutTable-->
              <tr>
                <td width="145" height="38" align="right" valign="middle" ><strong>Registration No.   :&nbsp; </strong></td>
                    <td width="284" valign="middle"><asp:TextBox ID="TextBox1" runat="server"  Width="146px"  ></asp:TextBox></td>
                    <td width="486" align="right" valign="middle"><asp:Button ID="Search" runat="server" CssClass="bt1up" Text="Search"    />                    
                      &nbsp;
                      <asp:Button ID="Refresh" runat="server" CssClass="bt1up" Text="Refresh"     />                                            &nbsp;</td>
                    </tr>
              
              
              

              
              
            </table></td>
                </tr>
          <tr>
            <td height="13" align="right" valign="top"><img src="images1/img_shedow.gif" width="249" height="13" /></td>
          </tr>
          <tr>
            <td height="8"></td>
          </tr>
          <tr>
            <td valign="top" style="height: 360px"><asp:GridView ID="GridView1" runat="server" AllowPaging="True"
                    AutoGenerateColumns="False"  DataKeyNames="PayID,RegNo" DataSourceID="SqlDataSourcePatients"
                    Width="100%">
              <FooterStyle CssClass="GridPager" />            
              <Columns>
              <asp:HyperLinkField DataNavigateUrlFields="PayID,RegNo" DataNavigateUrlFormatString="CMOBoth.aspx?payid={0}&amp;regno={1}"
                            Text="Approve" />
              <asp:BoundField DataField="PayID" HeaderText="PayID" InsertVisible="False" ReadOnly="True"
                            SortExpression="PayID" />
              <asp:BoundField DataField="RegNo" HeaderText="RegNo" ReadOnly="True" SortExpression="RegNo" Visible="False" />
              <asp:BoundField DataField="PNAME" HeaderText="Patient Name" ReadOnly="True" SortExpression="PNAME" />
              <asp:BoundField DataField="Relation" HeaderText="Relation" SortExpression="Relation" />
              <asp:BoundField DataField="RNAME" HeaderText="Relative Name" ReadOnly="True" SortExpression="RNAME" />
              </Columns>
              <RowStyle CssClass="GridItem" />
              <HeaderStyle CssClass="GridHeader" />            
              <AlternatingRowStyle CssClass="GridAltItem" />
            </asp:GridView>
              <asp:SqlDataSource ID="SqlDataSourcePatients" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    SelectCommand="SearchEmgDeptPatient" SelectCommandType="StoredProcedure">
                <SelectParameters>
                  <asp:ControlParameter ControlID="HiddenFieldSubDept" DefaultValue="1" Name="SubDeptNo"
                            PropertyName="Value" Type="Int32" />
                  <asp:Parameter DefaultValue="0" Name="status" />
                  <asp:ControlParameter ControlID="TextBox1" DefaultValue="0" Name="YearlyNo" PropertyName="Text"
                            Type="Decimal" />
                  <asp:Parameter DefaultValue="3" Name="request_type_id" Type="Int32" />
                </SelectParameters>
              </asp:SqlDataSource>
              <asp:HiddenField ID="HiddenFieldSubDept" runat="server" />
              <asp:ImageButton ID="ImageButtonhome" ImageUrl="images/image_bt_home.gif" Width="64" Height="30" runat="server" Visible="false" />
              <asp:ImageButton ID="ImageButtonback" ImageUrl="images/image_bt_back.gif" Width="66" Height="30" runat="server" Visible="false" />
              <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="images/image_logout_up.gif" Visible="false" /></td>
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