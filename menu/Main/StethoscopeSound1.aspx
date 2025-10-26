<%@ page language="VB" autoeventwireup="false" inherits="StethoscopeSound1, App_Web_rbfdm1yf" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="Paragma" content="no-cache"/>

<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
<script type="text/JavaScript">

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
function doit(a)
{
a.className="GridAltItem";
}

</script>
</head>

<body onload="MM_preloadImages('images1/img_btn_over.gif')" dir="ltr">
<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_top.gif" alt="" width="1003" height="24" /></td>
  </tr>
  
  
  <tr>
    <td width="23" valign="top" class="left_border" style="height: 626px"><img src="images1/img_border_left.gif" alt="" width="23" height="15" /></td>
    <td width="957" valign="top" style="height: 626px">
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
                Stethoscope</td>
          </tr>
        <tr><td></td>
        <tr>
          <td height="277" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
            <!--DWLayoutTable-->
            <tr>
              <td width="20" rowspan="5" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td width="913" height="19" valign="top" style="height: 10px"><img src="images1/img_spacer2.gif" width="2" height="10" /></td>
                  <td width="20" rowspan="5" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td width="4">&nbsp;</td>
              </tr>
            <tr>
              <td height="30" valign="top"><asp:SqlDataSource ID="SqlDataSource_patinet_Detail" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                SelectCommand="SELECT Prefix, PFName, PMName, PLName, Relation, RFName, Age, AgeType, RegNo FROM Patient WHERE (RegNo = @RegNo)">
                <SelectParameters>
                    <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
                </SelectParameters>
              </asp:SqlDataSource>
                <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSource_patinet_Detail"
                Width="811px">
                  <EditItemTemplate> Prefix:
                    <asp:TextBox ID="PrefixTextBox" runat="server" Text='<%# Bind("Prefix") %>'> </asp:TextBox>
                    <br />
                    PFName:
                    <asp:TextBox ID="PFNameTextBox" runat="server" Text='<%# Bind("PFName") %>'> </asp:TextBox>
                    <br />
                    PMName:
                    <asp:TextBox ID="PMNameTextBox" runat="server" Text='<%# Bind("PMName") %>'> </asp:TextBox>
                    <br />
                    PLName:
                    <asp:TextBox ID="PLNameTextBox" runat="server" Text='<%# Bind("PLName") %>'> </asp:TextBox>
                    <br />
                    Relation:
                    <asp:TextBox ID="RelationTextBox" runat="server" Text='<%# Bind("Relation") %>'> </asp:TextBox>
                    <br />
                    RFName:
                    <asp:TextBox ID="RFNameTextBox" runat="server" Text='<%# Bind("RFName") %>'> </asp:TextBox>
                    <br />
                    Age:
                    <asp:TextBox ID="AgeTextBox" runat="server" Text='<%# Bind("Age") %>'> </asp:TextBox>
                    <br />
                    AgeType:
                    <asp:TextBox ID="AgeTypeTextBox" runat="server" Text='<%# Bind("AgeType") %>'> </asp:TextBox>
                    <br />
                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                        Text="Update"> </asp:LinkButton>
                    <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                        Text="Cancel"> </asp:LinkButton>
                  </EditItemTemplate>
                  <InsertItemTemplate> Prefix:
                    <asp:TextBox ID="PrefixTextBox" runat="server" Text='<%# Bind("Prefix") %>'> </asp:TextBox>
                    <br />
                    PFName:
                    <asp:TextBox ID="PFNameTextBox" runat="server" Text='<%# Bind("PFName") %>'> </asp:TextBox>
                    <br />
                    PMName:
                    <asp:TextBox ID="PMNameTextBox" runat="server" Text='<%# Bind("PMName") %>'> </asp:TextBox>
                    <br />
                    PLName:
                    <asp:TextBox ID="PLNameTextBox" runat="server" Text='<%# Bind("PLName") %>'> </asp:TextBox>
                    <br />
                    Relation:
                    <asp:TextBox ID="RelationTextBox" runat="server" Text='<%# Bind("Relation") %>'> </asp:TextBox>
                    <br />
                    RFName:
                    <asp:TextBox ID="RFNameTextBox" runat="server" Text='<%# Bind("RFName") %>'> </asp:TextBox>
                    <br />
                    Age:
                    <asp:TextBox ID="AgeTextBox" runat="server" Text='<%# Bind("Age") %>'> </asp:TextBox>
                    <br />
                    AgeType:
                    <asp:TextBox ID="AgeTypeTextBox" runat="server" Text='<%# Bind("AgeType") %>'> </asp:TextBox>
                    <br />
                    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                        Text="Insert"> </asp:LinkButton>
                    <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                        Text="Cancel"> </asp:LinkButton>
                  </InsertItemTemplate>
                  <ItemTemplate> &nbsp;
                      <asp:Label ID="PrefixLabel" runat="server" Font-Bold="True" Font-Names="Tahoma"
                        Font-Size="Smaller" Text='<%# Bind("Prefix") %>'></asp:Label>
                    <asp:Label ID="PFNameLabel"
                            runat="server" Font-Bold="True" Font-Names="Tahoma" Font-Size="Smaller" Text='<%# Bind("PFName") %>'></asp:Label>
                      <asp:Label ID="PMNameLabel" runat="server" Font-Bold="True" Font-Names="Tahoma" Font-Size="Smaller"
                        Text='<%# Bind("PMName") %>'></asp:Label>
                      <asp:Label ID="PLNameLabel" runat="server" Font-Bold="True" Font-Names="Tahoma" Font-Size="Smaller"
                        Text='<%# Bind("PLName") %>'></asp:Label>
                      <asp:Label ID="RelationLabel" runat="server" Font-Bold="True" Font-Names="Tahoma"
                        Font-Size="Smaller" ForeColor="#0000C0" Text='<%# Bind("Relation") %>'></asp:Label>
                      <asp:Label ID="RFNameLabel" runat="server" Font-Bold="True" Font-Names="Tahoma" Font-Size="Smaller"
                        Text='<%# Bind("RFName") %>'></asp:Label>
                      <asp:Label ID="AgeLabel" runat="server" Font-Bold="True" Font-Names="Tahoma" Font-Size="Smaller"
                        Text='<%# Bind("Age") %>'></asp:Label>
                      <asp:Label ID="AgeTypeLabel" runat="server" Font-Bold="True" Font-Names="Tahoma"
                        Font-Size="Smaller" Text='<%# Bind("AgeType") %>'></asp:Label>
                    &nbsp;<br />
                      <strong style="font-family: Tahoma, Smaller">Registration No:
                        <asp:Label ID="LabelRegistrationNo"
                        runat="server" Font-Names="Tahoma" Font-Size="Smaller" Text='<%# Bind("RegNo") %>'></asp:Label>
                      </strong> </ItemTemplate>
                </asp:FormView></td>
              <td>&nbsp;</td>
            </tr>
              <tr>
                  <td height="30" valign="top">
                  </td>
                  <td>
                  </td>
              </tr>
            <tr>
              <td height="151" valign="top" align="center">
                  <asp:SqlDataSource ID="SqlDataSourceDataList" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT category, ISNULL(Description, '') , pic_path FROM Pt_Pic_SaveRecord WHERE (RegNo = @RegNo) AND (YearlyNo = @YearlyNo) ">
                      <SelectParameters>
                          <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                          <asp:SessionParameter DefaultValue="" Name="YearlyNo" SessionField="YearlyNo" />
                      </SelectParameters>
                  </asp:SqlDataSource>
                  <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
                      DataSourceID="SqlDataSourceDataList" Width="23px" AllowPaging="True" PageSize="5">
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
                  <asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>"></asp:SqlDataSource>
                  <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceDataList"
                      Width="23px" Visible="False">
                      <Columns>
                          <asp:TemplateField ShowHeader="False">
                              <ItemTemplate>
                                  <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" CommandName="Select"
                                      Text='<%# Eval("pic_path") %>'></asp:LinkButton><br />
                                  <asp:HiddenField ID="HiddenField2" runat="server" Value='<%# Bind("pic_path", "{0}") %>' />
                              </ItemTemplate>
                          </asp:TemplateField>
                      </Columns>
                  </asp:GridView>
              </td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td height="65" valign="top"><span style="height: 476px; width: 790px;">&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
<br />
              </span></td>
              <td>&nbsp;</td>
            </tr>
             <asp:HiddenField ID="HiddenFieldToolTIp" runat="server" Value="true" /><asp:HiddenField ID="HiddenField1" runat="server" Value="true" />
         </table></td>
          <!-- </div>-->
          </tr>
          </table></td>
    <td width="33" valign="top" class="right_border" style="width: 33px; height: 626px;"><img src="images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_bottom.gif" alt="" width="1003" height="24" /></td>
  </tr>
</table>
</form>
</body>
</html>
