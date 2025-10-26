<%@ page language="VB" autoeventwireup="false" inherits="Admin_TestComponent, App_Web_rbfdm1yf" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../Validate.js"></script>

</head>

<body onload="MM_preloadImages('images1/img_bthover2.gif','images1/img_btup2.gif')">

<form id="form1" runat = "server">

<table style="width:1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td  style="height:24" colspan="3" valign="top"><img src="images1/img_border_top.gif" alt="" style="width: 1003" height="24" /></td>
  </tr>
  
  
  <tr>
    <td style="width:23 ;height:550" valign="top" class="left_border"><img src="images1/img_border_left.gif" alt="" style="width: 23" height="15" /></td>
    <td style="width: 957" valign="top">
    <table style="width: 100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
        <td style="height:73" colspan="2" valign="bottom" bgcolor="#F4F4F4" ><iframe 
      src="tabs.aspx" name="holder" width="957" marginwidth="0" height="157" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
      </tr>
      <tr>
        <td style="width: 20 ; height:32" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td style="width: 937" valign="middle" class="text_heading_02">Pathology &gt;&gt; <span class="text_lables3">Test</span></td>
          </tr>
      
      
      
      
      
          <tr>
            <td style="height:453" colspan="2" valign="top"><table style="width: 100%" border="0" cellpadding="0" cellspacing="0">
                <!--DWLayoutTable-->
                <tr>
                  <td style="width:20" rowspan="2" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" alt=""/></td>
                  <td style="height:21px; text-align: center;" colspan="2" valign="top"><img src="images1/img_spacer2.gif" width="2" height="10" alt=""/>
                      <asp:Label ID="Label_message" runat="server" ></asp:Label></td>
                  <td style="width:20" rowspan="2" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" alt=""/></td>
                </tr>
                <tr>
                <td style="width: 17" align="left" valign="middle" class="tabledottedleft"><!--DWLayoutEmptyCell-->&nbsp;</td>
                  <td style="width: 715" valign="top"><table style="width: 100%" border="0" cellpadding="0" cellspacing="0">
                      <!--DWLayoutTable-->
                      <tr>
                        <td style="width: 715 ;height: 95px" valign="top" ><table border="0" cellpadding="0" cellspacing="0"   style="width: 917px">
                          <!--DWLayoutTable-->
                          <tr>
                            <td style="width: 140 ; height:37" align="right" valign="middle" ><strong>&nbsp;&nbsp;Group Name :&nbsp; </strong></td>
                              <td style="width: 188" valign="middle"><span style="height: 28px">
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
                            <td style="height:25" align="right" valign="middle"><span >Test Name  :&nbsp;</span></td>
                              <td colspan="2" valign="middle"><span style="height: 25px">&nbsp;<asp:DropDownList ID="DropDownListTest" runat="server"
                                      AutoPostBack="True"  DataSourceID="SqlDataSourceTest"
                                      DataTextField="TestName" DataValueField="TID" Width="178px">
                                  </asp:DropDownList><asp:SqlDataSource ID="SqlDataSourceTest" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                                      ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT TestName, TID FROM Test WHERE (TSGID = @tsgid) and tgid = @tgid">
                                      <SelectParameters>
                                          <asp:ControlParameter ControlID="DropDownListSGName" Name="tsgid" PropertyName="SelectedValue" />
                                          <asp:ControlParameter ControlID="DropDownListGName" Name="tgid" PropertyName="SelectedValue" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>
                              </span></td>
                              <td style="width: 119" align="right" valign="middle"><span >&nbsp;</span></td>
                              <td colspan="2" valign="middle"></td>
                            </tr>
                          <tr>
                            <td style="height:25" align="right" valign="middle"><span >Component Name :&nbsp;</span></td>
                              <td colspan="2" valign="middle"><asp:TextBox ID="TextBoxComponent" runat="server"  Width="146px"  ></asp:TextBox></td>
                              <td align="right" valign="middle"><span >Unit :&nbsp;</span></td>
                              <td style="width: 157" valign="middle"><asp:DropDownList AutoPostBack="True" 
                            DataTextField="TUnitName" DataValueField="TMUnitID" ID="DropDownListUnit" runat="server" Width="185px" DataSourceID="SqlDataSourceUnit">
                              </asp:DropDownList><asp:SqlDataSource ID="SqlDataSourceUnit" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                                  SelectCommand="SELECT [TMUnitID], [TUnitName] FROM [TestMUnit]"></asp:SqlDataSource>
                              </td>
                              <td style="width: 104" align="center" valign="middle"><asp:Button CssClass="bt1up" ID="SAVE" runat="server" Text="Save"   /></td>
                            </tr>
                          <tr>
                            <td style="height:6"></td>
                              <td></td>
                              <td style="width: 16"></td>
                              <td></td>
                              <td></td>
                              <td></td>
                          </tr>
                          
                        </table></td>
                      </tr>
                      <tr>
                        <td style="height:13" align="right" valign="top"><img src="images1/img_shedow.gif" width="249" height="13" alt=""/></td>
                      </tr>
                      <tr>
                        <td style="height:338" valign="top"><span style="text-align: center">
                          <asp:SqlDataSource ID="SqlDataSourceGNameSave" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                        InsertCommand="INSERT INTO TestComponent(TID, ComponentName, TMUnitID, TGID) VALUES (@TID, @ComponentName, @TMUnitID, @TGID)"
                        ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>">
                            <InsertParameters>
                                <asp:ControlParameter ControlID="DropDownListTest" Name="TID" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="TextBoxComponent" Name="ComponentName" PropertyName="Text" />
                                <asp:ControlParameter ControlID="DropDownListUnit" Name="TMUnitID" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="DropDownListGName" Name="TGID" PropertyName="SelectedValue" />
                            </InsertParameters>
                          </asp:SqlDataSource>
                            &nbsp;
                            <asp:SqlDataSource ID="SqlDataSourceSGName" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT [TSGID], [TSGName] FROM [TestSubGroup] WHERE ([TGID] = @TGID)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropDownListGName" Name="TGID" PropertyName="SelectedValue"
                                        Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceGName" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                        SelectCommand="SELECT [TGName], [TGID] FROM [TestGroup]"></asp:SqlDataSource>
                          <asp:HiddenField ID="HiddenFieldGroupName" runat="server" />
                          <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="TCID"
                    DataSourceID="SqlDataSourceGrid" AllowPaging="True"  Width="100%">
                            <Columns>
                                <asp:TemplateField>
                                    <EditItemTemplate>
                                        <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images/icon_ok.gif" />&nbsp;<asp:ImageButton
                                            ID="ImageButton4" runat="server" CommandName="Cancel" ImageUrl="~/images/icon_err.gif" />
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/images/icon_edit.gif"
                                            OnClientClick="return confirmation_edit(this)" />&nbsp;<asp:ImageButton ID="ImageButton2"
                                                runat="server" CommandName="Delete" ImageUrl="~/images/icon_delete.gif" OnClientClick="return confirmation(this)" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="TGName" HeaderText="TGName" ReadOnly="True" SortExpression="TGName" />
                                <asp:BoundField DataField="TSGName" HeaderText="TSGName" ReadOnly="True" SortExpression="TSGName" />
                                <asp:BoundField DataField="TestName" HeaderText="TestName" ReadOnly="True" SortExpression="TestName" />
                                <asp:TemplateField HeaderText="ComponentName" SortExpression="ComponentName">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ComponentName") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("ComponentName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="TCID" HeaderText="TCID" InsertVisible="False" ReadOnly="True"
                                    SortExpression="TCID" Visible="False" />
                                <asp:TemplateField HeaderText="Unit" SortExpression="TMUnitID">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSourceUnit"
                                            DataTextField="TUnitName" DataValueField="TMUnitID" Width="143px">
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("TMUnitID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <RowStyle CssClass="GridItem" />
                            <HeaderStyle CssClass="GridHeader" />                          
                            <AlternatingRowStyle CssClass="GridAltItem" />
                          </asp:GridView>
                            <asp:HiddenField ID="HiddenFieldCompName" runat="server" />
                            <asp:HiddenField ID="HiddenFieldUnit" runat="server" />
                          <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    SelectCommand="SELECT TestGroup.TGName, TestSubGroup.TSGName, Test.TestName, TestComponent.ComponentName, TestComponent.TCID, TestComponent.TMUnitID FROM Test INNER JOIN TestGroup ON Test.TGID = TestGroup.TGID INNER JOIN TestSubGroup ON Test.TSGID = TestSubGroup.TSGID AND TestGroup.TGID = TestSubGroup.TGID INNER JOIN TestComponent ON Test.TID = TestComponent.TID WHERE (Test.TGID = @TGID) AND (Test.TSGID = @TSGID)" ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" DeleteCommand="DELETE FROM TestComponent WHERE (TCID = @tcid)" UpdateCommand="UPDATE TestComponent SET ComponentName = @ComponentName, TMUnitID = @TMUnitID WHERE (TCID = @TCID)">
                            <SelectParameters>
                              <asp:ControlParameter ControlID="DropDownListGName" Name="TGID" PropertyName="SelectedValue" />
                              <asp:ControlParameter ControlID="DropDownListSGName" Name="TSGID" PropertyName="SelectedValue" />
                            </SelectParameters>
                              <DeleteParameters>
                                  <asp:ControlParameter ControlID="GridView1" Name="tcid" PropertyName="SelectedValue" />
                              </DeleteParameters>
                              <UpdateParameters>
                                  <asp:ControlParameter ControlID="HiddenFieldCompName" Name="ComponentName" PropertyName="Value" />
                                  <asp:ControlParameter ControlID="HiddenFieldUnit" Name="TMUnitID" PropertyName="Value" />
                                  <asp:ControlParameter ControlID="GridView1" Name="TCID" PropertyName="SelectedValue" />
                              </UpdateParameters>
                          </asp:SqlDataSource>
</span><span style="height: 30px">
<%--<asp:ImageButton ID="ImageButtonhome" ImageUrl="images/image_bt_home.gif" Width="64" Height="30" runat="server" Visible="false" />
</span><span style="height: 30px">
<asp:ImageButton ID="ImageButtonback" ImageUrl="images/image_bt_back.gif" Width="66" Height="30" runat="server" Visible="false" />
</span><span style="height: 30px">
<asp:ImageButton ID="ImageButtonlogout" ImageUrl="images/image_logout_up.gif" Width="71" Height="30" runat="server" Visible="false" />
--%></span></td>
                      </tr>
                      
                      
                      
                      
                      
                      
                      

                      
                      
                      
                      
                      
                      

                      
                      
                  </table></td>
                </tr>
                
                
                
                

                
                
                
                
                
                
                
                

          
          
          
          
          
          
            </table></td>
          </tr>
      
      
      
      
      
      
      
      
      
      
            
    </table></td>
    <td style="width: 32" valign="top" class="right_border" ><img src="images1/img_border_right.gif" width="23" height="15" alt=""/></td>
  </tr>
  
  <tr>
    <td style="height:24" colspan="3" valign="top"><img src="images1/img_border_bottom.gif" width="1003" height="24" alt=""/></td>
  </tr>
</table>
<script type="text/javascript" src="images1/flash_01.js"></script>
</form>
</body>
</html>
