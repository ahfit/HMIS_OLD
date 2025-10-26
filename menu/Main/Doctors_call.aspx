<%@ page language="VB" autoeventwireup="false" inherits="Doctors_call, App_Web_ppbttiod" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
 <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<link href="../images/lgh_001.css" rel="stylesheet" type="text/css">
<link href="../images/lgh_003.css" rel="stylesheet" type="text/css">
</head>

<body>

<form id="form1" runat = "server" >

<table width="960" border="0" align="center" cellpadding="0" cellspacing="0" background="../images/image_bg_01.gif">
  <!--DWLayoutTable-->
  <tr>
    <td width="14" rowspan="3" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
    <td width="932" height="7" valign="top"><img src="../images/image_line_01.gif" width="932" height="7"></td>
  <td width="14" rowspan="3" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
  </tr>
  <tr>
    <td height="32" valign="top"><iframe src="../tabs.aspx" name="holder" width="957" marginwidth="0" height="215" marginheight="0" 
      scrolling="No" frameborder="0" id="holder" style="height: 113px"></iframe>
    </td>
    </tr>
  
  <tr>
    <td height="560" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" background="../images/image_bg_05.gif">
      <!--DWLayoutTable-->
      <tr>
        <td colspan="3" valign="top" style="height: 13px"><table width="100%" border="0" cellpadding="0" cellspacing="0" background="../images/image_title_50.gif" style="height: 25px">
          <!--DWLayoutTable-->
          <tr>
            <td width="731" valign="middle" style="height: 30px"><span class="text_header_new_2">Doctor's
                Call</span></td>
                  <td width="64" valign="top" style="height: 30px">
                      <asp:ImageButton ID="ImageButtonHome" runat="server" ImageUrl="../images/image_bt_home.gif" Visible="False" /></td>
                  <td width="66" valign="top" style="height: 30px">
                      <asp:ImageButton ID="ImageButtonBack" runat="server" ImageUrl="../images/image_bt_back.gif" Visible="False" /></td>
                  <td width="71" valign="top" style="height: 30px">
                      <asp:ImageButton ID="ImageButtonLogOut" runat="server" ImageUrl="../images/image_logout_up.gif" Visible="False" /></td>
              </tr>
          
          </table></td>
          </tr>
      <tr>
        <td style="width: 919px; height: 441px; vertical-align: top; text-align: center;">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                DataSourceID="SqlDataSourceForGrid" Width="683px">
                <Columns>
                    <asp:TemplateField HeaderText="Call BY" SortExpression="Call_BY">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Call_BY") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Call_BY") %>'></asp:Label>
                            <asp:HiddenField ID="HiddenFieldID" runat="server" Value='<%# Bind("CTD_ID", "{0}") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Subject" HeaderText="Subject" SortExpression="Subject" />
                    <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                    <asp:BoundField DataField="Needed" HeaderText="Needed In Time" ReadOnly="True" SortExpression="Needed" />
                    <asp:BoundField DataField="Call_Date" HeaderText="Call Date" ReadOnly="True" SortExpression="Call_Date" />
                    <asp:BoundField DataField="Call_Time" HeaderText="Call Time" ReadOnly="True" SortExpression="Call_Time" />
                    <asp:BoundField DataField="RegNo" HeaderText="RegNo" SortExpression="RegNo" />
                    <asp:BoundField DataField="YearlyNo" HeaderText="YearlyNo" SortExpression="YearlyNo" />
                </Columns>
                <RowStyle CssClass="GridItem" />
                <HeaderStyle CssClass="GridHeader" />
                <AlternatingRowStyle CssClass="GridAltItem" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="Select_Doctors_Call"
                SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter Name="Emp_ID" SessionField="Emp_id" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            &nbsp;
            &nbsp; &nbsp;&nbsp;</td>
        <td valign="top" style="height: 441px"><!--DWLayoutEmptyCell-->&nbsp;</td>
        <td style="height: 441px">&nbsp;</td>
      </tr>
      <tr>
        <td height="24" style="width: 919px">&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      
      
      
          </table></td>
    </tr>
</table>

</form>
</body>
</html>
