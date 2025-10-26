<%@ Page Language="VB" AutoEventWireup="false" CodeFile="GroupName.aspx.vb" Inherits="GroupName" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title></title>
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
      src="../tabs.aspx" name="holder" width="957" marginwidth="0" height="157" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
      </tr>
      <tr>
        <td width="20" height="32" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="937" valign="middle" class="text_heading_02">Pathology &gt;&gt; <span class="text_lables3">Test</span></td>
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
                        <td width="715" height="95" valign="top"><table border="0" cellpadding="0" cellspacing="0"   style="width: 917px">
                          <!--DWLayoutTable-->
                          <tr>
                            <td width="140" height="37" align="right" valign="middle" ><strong>&nbsp;&nbsp;Group Name :&nbsp; </strong></td>
                              <td width="188" valign="middle"><span style="height: 28px">
                                <asp:DropDownList AutoPostBack="True" 
                              DataTextField="TGName" DataValueField="TGID" ID="DropDownListGName" runat="server" Width="152px" DataSourceID="SqlDataSourceGName"> </asp:DropDownList>
                              </span></td>
                              <td colspan="2" align="right" valign="middle"><strong >&nbsp;Sub-Group Name :&nbsp; </strong></td>
                              <td colspan="2" align="left" valign="middle"><span style="height: 25px">
                                <asp:DropDownList AutoPostBack="True" 
                            DataTextField="TSGName" DataValueField="TSGID" ID="DropDownListSGName" runat="server" Width="185px" DataSourceID="SqlDataSourceSGName"> </asp:DropDownList>
                              </span></td>
                            </tr>
                          <tr>
                            <td height="25" align="right" valign="middle"><span >Test Name  :&nbsp;</span></td>
                              <td colspan="2" valign="middle"><span style="height: 25px">
                                <asp:TextBox ID="TextBoxTName" runat="server"  Width="146px"  ></asp:TextBox>
                              </span></td>
                              <td width="119" align="right" valign="middle"><span >Medical Name  :&nbsp;</span></td>
                              <td colspan="2" valign="middle"><asp:TextBox ID="TextBoxMName" runat="server"  Width="146px"  ></asp:TextBox></td>
                            </tr>
                          <tr>
                            <td height="25" align="right" valign="middle"><span >Standard Name  :&nbsp;</span></td>
                              <td colspan="2" valign="middle"><asp:TextBox ID="TextBoxSName" runat="server"  Width="146px"  ></asp:TextBox></td>
                              <td align="right" valign="middle"><span >Fee  :&nbsp;</span></td>
                              <td width="157" valign="middle"><asp:TextBox ID="TextBoxFee" runat="server"  Width="50px"  ></asp:TextBox></td>
                              <td width="104" align="center" valign="middle"><asp:Button CssClass="bt1up" ID="SAVE" runat="server" Text="Save"   /></td>
                            </tr>
                          <tr>
                            <td height="6"></td>
                              <td></td>
                              <td width="16"></td>
                              <td></td>
                              <td></td>
                              <td></td>
                          </tr>
                          
                        </table></td>
                      </tr>
                      <tr>
                        <td height="13" align="right" valign="top"><img src="images1/img_shedow.gif" width="249" height="13" /></td>
                      </tr>
                      <tr>
                        <td valign="top" style="height: 338px"><span style="text-align: center">
                          <asp:SqlDataSource ID="SqlDataSourceGNameSave" runat="server" ConnectionString="Data Source=server;Initial Catalog=Pathalogy;User ID=sa;Password=123"
                        InsertCommand="INSERT INTO Test(TGID, TestName, Fee, TSGID, MedicalName, StandardName) 
VALUES (@TGID, @TestName, @Fee, @TSGID, @MedicalName, @StandardName)"
                        ProviderName="System.Data.SqlClient">
                            <InsertParameters>
                              <asp:SessionParameter Name="TGID" SessionField="TestTGID" />
                              <asp:FormParameter FormField="textboxtname" Name="TestName" />
                              <asp:FormParameter FormField="textboxfee" Name="Fee" />
                              <asp:SessionParameter Name="TSGID" SessionField="testTSGID" />
                              <asp:FormParameter FormField="textboxmname" Name="MedicalName" />
                              <asp:FormParameter FormField="textboxsname" Name="StandardName" />
                            </InsertParameters>
                          </asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceSGName" runat="server" ConnectionString="Data Source=server;Initial Catalog=Pathalogy;User ID=sa;Password=123"
                        SelectCommand="SELECT [TSGName], [TSGID] FROM [TestSubGroup] WHERE ([TGID] = @TGID)" ProviderName="System.Data.SqlClient">
                            <SelectParameters>
                              <asp:ControlParameter ControlID="DropDownListGName" Name="TGID" PropertyName="SelectedValue"
                                Type="Int32" />
                            </SelectParameters>
                          </asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceGName" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                        SelectCommand="SELECT [TGName], [TGID] FROM [TestGroup]"></asp:SqlDataSource>
                          <asp:HiddenField ID="HiddenFieldGroupName" runat="server" />
                          <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="TSGID,TGID1,TID"
                    DataSourceID="SqlDataSourceGrid" AllowPaging="True"  Width="100%">
                            <Columns>
                            <asp:BoundField DataField="TGName" HeaderText="Group Name" SortExpression="TGName" />
                            <asp:BoundField DataField="TSGName" HeaderText="Sub Group Name" SortExpression="TSGName" />
                            <asp:BoundField DataField="TestName" HeaderText="Test Name" SortExpression="TestName" />
                            <asp:BoundField DataField="Fee" HeaderText="Fee" SortExpression="Fee" />
                            <asp:BoundField DataField="MedicalName" HeaderText="MedicalName" SortExpression="MedicalName" />
                            <asp:BoundField DataField="StandardName" HeaderText="StandardName" SortExpression="StandardName" />
                            <asp:BoundField DataField="TSGID" HeaderText="TSGID" InsertVisible="False" ReadOnly="True"
                            SortExpression="TSGID" Visible="False" />
                            <asp:BoundField DataField="TGID" HeaderText="TGID" SortExpression="TGID" Visible="False" />
                            <asp:BoundField DataField="Expr1" HeaderText="Expr1" SortExpression="Expr1" Visible="False" />
                            <asp:BoundField DataField="TGID1" HeaderText="TGID1" InsertVisible="False" ReadOnly="True"
                            SortExpression="TGID1" Visible="False" />
                            <asp:BoundField DataField="Fee1" HeaderText="Fee1" SortExpression="Fee1" Visible="False" />
                            <asp:BoundField DataField="TID" HeaderText="TID" InsertVisible="False" ReadOnly="True"
                            SortExpression="TID" Visible="False" />
                            <asp:BoundField DataField="TGID2" HeaderText="TGID2" SortExpression="TGID2" Visible="False" />
                            <asp:BoundField DataField="Fee2" HeaderText="Fee2" SortExpression="Fee2" Visible="False" />
                            <asp:BoundField DataField="TSGID1" HeaderText="TSGID1" SortExpression="TSGID1" Visible="False" />
                            </Columns>
                            <RowStyle CssClass="GridItem" />
                            <HeaderStyle CssClass="GridHeader" />                          
                            <AlternatingRowStyle CssClass="GridAltItem" />
                          </asp:GridView>
                          <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" ConnectionString="Data Source=server;Initial Catalog=Pathalogy;User ID=sa;Password=123"
                    SelectCommand="SELECT     TestSubGroup.*, Test.TestName AS Expr1, TestGroup.*, Test.*
FROM         Test INNER JOIN
                      TestGroup ON Test.TGID = TestGroup.TGID INNER JOIN
                      TestSubGroup ON Test.TSGID = TestSubGroup.TSGID AND TestGroup.TGID = TestSubGroup.TGID
where (test.TGID = @TGID) and (Test.TSGID = @TSGID)" ProviderName="System.Data.SqlClient">
                            <SelectParameters>
                              <asp:ControlParameter ControlID="DropDownListGName" Name="TGID" PropertyName="SelectedValue" />
                              <asp:ControlParameter ControlID="DropDownListSGName" Name="TSGID" PropertyName="SelectedValue" />
                            </SelectParameters>
                          </asp:SqlDataSource>
</span><span style="height: 30px">
<asp:ImageButton ID="ImageButtonhome" ImageUrl="images/image_bt_home.gif" Width="64" Height="30" runat="server" Visible="false" />
</span><span style="height: 30px">
<asp:ImageButton ID="ImageButtonback" ImageUrl="images/image_bt_back.gif" Width="66" Height="30" runat="server" Visible="false" />
</span><span style="height: 30px">
<asp:ImageButton ID="ImageButtonlogout" ImageUrl="images/image_logout_up.gif" Width="71" Height="30" runat="server" Visible="false" />
</span></td>
                      </tr>
                      
                      
                      
                      
                      
                      
                      

                      
                      
                      
                      
                      
                      

                      
                      
                  </table></td>
                </tr>
                
                
                
                

                
                
                
                
                
                
                
                

          
          
          
          
          
          
            </table></td>
          </tr>
      
      
      
      
      
      
      
      
      
      
            
    </table></td>
    <td valign="top" class="right_border" style="width: 45px" ><img src="images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_bottom.gif" width="1003" height="24" /></td>
  </tr>
</table>
<script type="text/javascript" src="images1/flash_01.js"></script>
</form>
</body>
</html>
