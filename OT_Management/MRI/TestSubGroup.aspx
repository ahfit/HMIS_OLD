<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TestSubGroup.aspx.vb" Inherits="TestSubGroup" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />


</head>

<body onload="MM_preloadImages('images1/img_bthover2.gif','images1/img_btup2.gif')">

<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_top.gif" alt="" width="1003" height="24" /></td>
  </tr>
  
  
  <tr>
    <td width="23" height="550" valign="top" class="left_border"><img src="images1/img_border_left.gif" alt="" width="23" height="15" /></td>
    <td width="957" valign="top">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
        <td height="73" colspan="2" valign="bottom" bgcolor="#F4F4F4" ><iframe 
      src="tabs.aspx" name="holder" width="957" marginwidth="0" height="157" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
      </tr>
      <tr>
        <td width="20" height="32" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="937" valign="middle" class="text_heading_02">Pathology &gt;&gt; <span class="text_lables3">Test Sub Group</span> </td>
          </tr>
      
      
      
      
      
          <tr>
            <td height="453" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                <!--DWLayoutTable-->
                <tr>
                  <td width="20" rowspan="2" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td height="10" colspan="2" valign="top"><img src="images1/img_spacer2.gif" width="2" height="10" /></td>
                  <td width="20" rowspan="2" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                </tr>
                <tr>
                <td width="17" align="left" valign="middle" class="tabledottedleft"><!--DWLayoutEmptyCell-->&nbsp;</td>
                  <td width="715" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <!--DWLayoutTable-->
                      <tr>
                        <td width="715" height="70" valign="top"><table border="0" cellpadding="0" cellspacing="0"   style="width: 128%">
                          <!--DWLayoutTable-->
                          <tr>
                            <td width="143" height="37" align="right" valign="middle" ><strong>&nbsp;&nbsp;Group Name :&nbsp; </strong></td>
                              <td colspan="2" valign="middle"><asp:DropDownList  DataTextField="TGName"
                              DataValueField="TGID" ID="GName" runat="server" Width="200px" DataSourceID="SqlDataSourceGName"> </asp:DropDownList></td>
                              <td colspan="2" align="right" valign="middle"><strong >&nbsp;Sub-Group Name :&nbsp; </strong></td>
                              <td width="261" align="left" valign="middle">
                                  &nbsp;<asp:TextBox ID="TxtSGName" runat="server"  Width="146px"  ></asp:TextBox></td>
                            </tr>
                          <tr>
                            <td height="25" align="right" valign="middle"><span >Fee :&nbsp;</span></td>
                              <td width="74" valign="middle"><asp:TextBox ID="txtFee" runat="server"  Width="50px"  ></asp:TextBox></td>
                              <td colspan="2" valign="middle"><span style="height: 120px">
                                <asp:Button CssClass="bt1up" ID="update" runat="server" Text="Save"   />                                
                              </span></td>
                              <td colspan="2" valign="middle"><span style="width: 516px">
                                <asp:Label  ForeColor="White" ID="Label1" runat="server"></asp:Label>
                              </span></td>
                            </tr>
                          <tr>
                            <td height="6"></td>
                              <td></td>
                              <td width="79"></td>
                              <td width="68"></td>
                              <td width="78"></td>
                              <td></td>
                          </tr>
                        </table></td>
                      </tr>
                      <tr>
                        <td height="13" align="right" valign="top"><img src="images1/img_shedow.gif" width="249" height="13" /></td>
                      </tr>
                      <tr>
                        <td height="362" valign="top"><span style="height: 120px">
                          <asp:SqlDataSource ID="SqlDataSourceGName" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                              SelectCommand="SELECT [TGName], [TGID] FROM [TestGroup]"></asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceTSGName" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString1 %>"
                              InsertCommand="INSERT INTO TestSubGroup(TSGName, Fee, TGID) VALUES (@TSGName, @Fee, @TGID)"
                              ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT TestSubGroup.TSGID, TestSubGroup.TSGName, TestSubGroup.Fee, TestGroup.TGName FROM TestSubGroup LEFT OUTER JOIN TestGroup ON TestSubGroup.TGID = TestGroup.TGID" DeleteCommand="DELETE FROM TestSubGroup WHERE (TSGID = @TSGID)" UpdateCommand="UPDATE TestSubGroup SET TSGName = @TSGName, Fee = @Fee, TGID = @TGID WHERE (TSGID = @TSGID)">
                            <InsertParameters>
                              <asp:FormParameter FormField="txtSGName" Name="TSGName" />
                              <asp:FormParameter FormField="txtFee" Name="Fee" />
                              <asp:SessionParameter Name="TGID" SessionField="TGID" />
                            </InsertParameters>
                            <DeleteParameters>
                              <asp:SessionParameter Name="TSGID" SessionField="TSGID" />
                            </DeleteParameters>
                            <UpdateParameters>
                              <asp:FormParameter FormField="txtSGName" Name="TSGName" />
                              <asp:FormParameter FormField="txtfee" Name="Fee" />
                              <asp:FormParameter FormField="GName" Name="TGID" />
                              <asp:SessionParameter Name="TSGID" SessionField="TSGID" />
                            </UpdateParameters>
                          </asp:SqlDataSource>
                          <span style="width: 516px">
                          <asp:GridView ID="GridViewTestSubGroup" runat="server" AutoGenerateColumns="False" DataKeyNames="TSGID"
                    DataSourceID="SqlDataSourceTestSubGroup" Width="100%"  AllowPaging="True">
                            <Columns>
                            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                            <asp:BoundField DataField="TSGID" HeaderText="TSGID" InsertVisible="False" ReadOnly="True"
                            SortExpression="TSGID" />
                            <asp:BoundField DataField="TSGName" HeaderText="TSGName" SortExpression="TSGName" />
                            <asp:BoundField DataField="Fee" HeaderText="Fee" SortExpression="Fee" />
                            <asp:BoundField DataField="TGID" HeaderText="TGID" SortExpression="TGID" />
                            </Columns>
                            <RowStyle CssClass="GridItem" />
                            <HeaderStyle CssClass="GridHeader" />                          
                            <AlternatingRowStyle CssClass="GridAltItem" />
                          </asp:GridView>
                          <asp:SqlDataSource ID="SqlDataSourceTestSubGroup" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    DeleteCommand="DELETE FROM [TestSubGroup] WHERE [TSGID] = @TSGID" InsertCommand="INSERT INTO [TestSubGroup] ([TSGName], [Fee], [TGID]) VALUES (@TSGName, @Fee, @TGID)"
                    SelectCommand="SELECT * FROM [TestSubGroup]" UpdateCommand="UPDATE [TestSubGroup] SET [TSGName] = @TSGName, [Fee] = @Fee, [TGID] = @TGID WHERE [TSGID] = @TSGID">
                            <DeleteParameters>
                              <asp:Parameter Name="TSGID" Type="Int32" />
                            </DeleteParameters>
                            <UpdateParameters>
                              <asp:Parameter Name="TSGName" Type="String" />
                              <asp:Parameter Name="Fee" Type="Int32" />
                              <asp:Parameter Name="TGID" Type="Int32" />
                              <asp:Parameter Name="TSGID" Type="Int32" />
                            </UpdateParameters>
                            <InsertParameters>
                              <asp:Parameter Name="TSGName" Type="String" />
                              <asp:Parameter Name="Fee" Type="Int32" />
                              <asp:Parameter Name="TGID" Type="Int32" />
                            </InsertParameters>
                          </asp:SqlDataSource>
                          </span></span>
                        <asp:ImageButton ID="ImageButtonhome" ImageUrl="images/image_bt_home.gif" Width="64" Height="30" runat="server" Visible="false" />
                        <asp:ImageButton ID="ImageButtonback" ImageUrl="images/image_bt_back.gif" Width="66" Height="30" runat="server"  Visible="false"/>
                        <asp:ImageButton ID="ImageButtonlogout" ImageUrl="images/image_logout_up.gif" Width="71" Height="30" runat="server"  Visible="false"/></td>
                      </tr>
                      
                      
                      
                      
                      
                      

                      
                      
                      
                      

                      
                      
                      

                  </table></td>
                </tr>
                
                
                
                

                
                
                
                
                
                
                
                

          
          
          
          
          
          
            </table></td>
          </tr>
      
      
      
      
      
      
      
      
      
      
            
    </table></td>
    <td width="32" valign="top" class="right_border" ><img src="images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_bottom.gif" width="1003" height="24" /></td>
  </tr>
</table>
<script type="text/javascript" src="images1/flash_01.js"></script>
</form>
</body>
</html>
