<%@ page language="VB" autoeventwireup="false" inherits="Pt_Picture, App_Web_rbfdm1yf" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

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
            <td width="938" valign="middle" class="text_lables3" >
                Image</td>
          </tr>
        <tr><div id ="a1" runat ="server">
          <td>&nbsp;</td>
        <tr>
          <td colspan="2" valign="top" style="height: 269px" align="center"><table width="100%" border="0" cellpadding="0" cellspacing="0">
            <!--DWLayoutTable-->
            <tr>
              <td width="20" rowspan="4" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                <td  style="height: 35px" colspan="2">
                    <asp:Label ID="Label_message" runat="server" ></asp:Label>
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp;</td>
                  <td rowspan="4" valign="top" style="width: 19px"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
              </tr>
              <tr>
                  <td align="right"  style="width: 336px; height: 48px;">
                      <strong>
                          Category:&nbsp; </strong></td>
                  <td align="left" style="height: 48px" width="913">
                      <asp:DropDownList ID="DropDownListCategory" runat="server" Width="234px">
                          <asp:ListItem>Chest</asp:ListItem>
                          <asp:ListItem>Lung</asp:ListItem>
                          <asp:ListItem>Back</asp:ListItem>
                      </asp:DropDownList></td>
              </tr>
              <tr>
                  <td align="right"  style="width: 336px">
                      <strong> Picture Path:&nbsp; </strong>
                  </td>
                  <td align="left" style="height: 35px" width="913">
                      <asp:ListBox ID="ListBox1" runat="server" Width="234px" Visible="False"></asp:ListBox>&nbsp;
                      <asp:CheckBoxList ID="CheckBoxList1" runat="server" RepeatColumns="3" RepeatDirection="Horizontal"
                          Width="788px">
                      </asp:CheckBoxList></td>
              </tr>
              <tr>
                  <td align="right"  style="width: 336px">
                      <strong>Description:&nbsp; </strong>
                  </td>
                  <td align="left" style="height: 35px" width="913">
                      <asp:TextBox ID="TextBox_Description" runat="server" Width="228px"></asp:TextBox></td>
              </tr>
              <tr>
                  <td rowspan="1" valign="top" width="20" style="height: 35px">
                  </td>
                  <td  rowspan="1" style="width: 336px; height: 35px" valign="top">
                  </td>
                  <td align="left"  style="width: 335px; height: 35px">

                <asp:Button ID="Button_Save" runat="server" Text="Save" Width="100px" CssClass="bt2up" />
                      <asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="#FF8080"></asp:Label></td>
                  <td rowspan="1" style="width: 19px; height: 35px;" valign="top">
                  </td>
              </tr>
             </table>
              <asp:SqlDataSource ID="SqlDataSourceDataList" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                  ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT category, ISNULL(Description, '') , pic_path FROM Pt_Pic_SaveRecord WHERE (RegNo = @RegNo) AND (YearlyNo = @YearlyNo) ">
                  <SelectParameters>
                      <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                      <asp:SessionParameter DefaultValue="" Name="YearlyNo" SessionField="YearlyNo" />
                  </SelectParameters>
              </asp:SqlDataSource>
              <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceDataList"
                  Width="23px" >
                  <Columns>
                      <asp:BoundField DataField="category" HeaderText="Category" SortExpression="category" />
                      <asp:BoundField DataField="Column1" HeaderText="Description" SortExpression="Column1" />
                      <asp:TemplateField ShowHeader="False" Visible="False">
                          <ItemTemplate>
                              <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" CommandName="Select"
                                  Text='<%# Eval("pic_path") %>'></asp:LinkButton><br />
                              <asp:HiddenField ID="HiddenField2" runat="server" Value='<%# Bind("pic_path", "{0}") %>' />
                          </ItemTemplate>
                      </asp:TemplateField>
                      <asp:HyperLinkField DataNavigateUrlFields="pic_path" DataNavigateUrlFormatString="View_Audio_Vedio.aspx?pic_path={0}"
                          Text="View" />
                      <asp:BoundField DataField="pic_path" HeaderText="pic_path" SortExpression="pic_path"
                          Visible="False" />
                  </Columns>
                  <RowStyle CssClass="GridItem" />
                  <HeaderStyle CssClass="GridHeader" />
                  <AlternatingRowStyle CssClass="GridAltItem" />
              </asp:GridView>
              &nbsp;
              &nbsp; &nbsp;
              <asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                  ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>">
              </asp:SqlDataSource>
              <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                  InsertCommand="INSERT INTO Pt_Pic_SaveRecord(YearlyNo, RegNo, category, pic_path, Description) VALUES (@YearlyNo, @RegNo, @category, @pic_path, @Description)"
                  ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>">
                  <InsertParameters>
                      <asp:SessionParameter DefaultValue="" Name="YearlyNo" SessionField="YearlyNo" />
                      <asp:SessionParameter DefaultValue="" Name="RegNo" SessionField="registrationNo" />
                      <asp:ControlParameter ControlID="DropDownListCategory" Name="category" PropertyName="SelectedValue" />
                      <asp:ControlParameter ControlID="HiddenFieldfileupload" Name="pic_path" PropertyName="Value" />
                      <asp:ControlParameter ControlID="TextBox_Description" Name="Description" PropertyName="Text" />
                  </InsertParameters>
              </asp:SqlDataSource>
              <asp:HiddenField ID="HiddenFieldfileupload" runat="server" />
          </td>
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
