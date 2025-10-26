<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TestGroup.aspx.vb" Inherits="TestGroup" %>


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
        <td colspan="2" valign="bottom" bgcolor="#F4F4F4" style="height: 73px" ><iframe 
      src="tabs.aspx" name="holder" width="957" marginwidth="0" height="157" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
      </tr>
      <tr>
        <td width="20" height="32" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="937" valign="middle" class="text_heading_02">Pathology &gt;&gt; <span class="text_lables3">Test Main Group</span> </td>
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
                        <td width="715" height="39" valign="top"><table border="0" cellpadding="0" cellspacing="0"   style="width: 128%">
                          <!--DWLayoutTable-->
                          <tr>
                            <td width="124" height="37" align="right" valign="middle" ><strong>&nbsp;&nbsp;Group Name :&nbsp; </strong></td>
                            <td width="175" valign="middle"><span style="height: 25px">
                              <asp:TextBox ID="TextBoxGName" runat="server"  Width="146px"  ></asp:TextBox>
                            </span></td>
                            <td width="53" align="right" valign="middle" >Fee :&nbsp;</td>
                            <td width="80" valign="middle"><asp:TextBox ID="TextBoxFee" runat="server"  Width="50px"  ></asp:TextBox></td>
                            <td align="left" valign="middle" style="width: 299px"><span style="vertical-align: top; text-align: left">
                              <asp:Button CssClass="bt1up" ID="Save" runat="server" Text="Save"    />                                                            
                              <asp:SqlDataSource ID="SqlDataSourceTestGroupSave" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                              InsertCommand="INSERT INTO TestGroup(TGName, Fee) VALUES (@TGName, @Fee)" ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>">
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="TextBoxGName" Name="TGName" PropertyName="Text" />
                                    <asp:ControlParameter ControlID="TextBoxFee" Name="Fee" PropertyName="Text" />
                                </InsertParameters>
                              </asp:SqlDataSource>
                                                        </span></td>
                          </tr>
                        </table></td>
                      </tr>
                      <tr>
                        <td height="20" align="right" valign="top"><img src="images1/img_shedow.gif" width="249" height="13" /></td>
                      </tr>
                      <tr>
                        <td height="386" valign="top"><asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="TGID"
                    DataSourceID="SqlDataSource1" Width="100%"  AllowPaging="True">
                          <Columns>
                          <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                          <asp:BoundField DataField="TGID" HeaderText="TGID" InsertVisible="False" ReadOnly="True"
                            SortExpression="TGID" />
                          <asp:BoundField DataField="TGName" HeaderText="TGName" SortExpression="TGName" />
                          <asp:BoundField DataField="Fee" HeaderText="Fee" SortExpression="Fee" />
                          </Columns>
                          <RowStyle CssClass="GridItem" />
                          <HeaderStyle CssClass="GridHeader" />                        
                          <AlternatingRowStyle CssClass="GridAltItem" />
                        </asp:GridView>
                          <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    DeleteCommand="DELETE FROM [TestGroup] WHERE [TGID] = @TGID" InsertCommand="INSERT INTO [TestGroup] ([TGName], [Fee]) VALUES (@TGName, @Fee)"
                    SelectCommand="SELECT * FROM [TestGroup]" UpdateCommand="UPDATE [TestGroup] SET [TGName] = @TGName, [Fee] = @Fee WHERE [TGID] = @TGID">
                            <DeleteParameters>
                              <asp:Parameter Name="TGID" Type="Int32" />
                            </DeleteParameters>
                            <UpdateParameters>
                              <asp:Parameter Name="TGName" Type="String" />
                              <asp:Parameter Name="Fee" Type="Int32" />
                              <asp:Parameter Name="TGID" Type="Int32" />
                            </UpdateParameters>
                            <InsertParameters>
                              <asp:Parameter Name="TGName" Type="String" />
                              <asp:Parameter Name="Fee" Type="Int32" />
                            </InsertParameters>
                          </asp:SqlDataSource>
                          <asp:ImageButton ID="ImageButtonlogout" ImageUrl="images/image_logout_up.gif" Width="71" Height="30" runat="server" Visible="false" /></td>
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
