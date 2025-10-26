<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Reception.aspx.vb" Inherits="Test_Results_Reception" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
 <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Lahore General Hospital</title>
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
      src="../tabs.aspx" name="holder" width="957" marginwidth="0" height="157" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
        </tr>
      
      
      <tr>
        <td width="19" height="25" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td width="929" valign="middle" class="text_lables3">
              Doctor Section
          </td>
        </tr>
      <tr>
        <td height="428" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="mainframe_bg1">
          <!--DWLayoutTable-->
          <tr>
            <td width="20" rowspan="5" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td height="10" valign="top" style="width: 909px"><img src="images1/img_spacer2.gif" width="2" height="10" /></td>
                  <td width="20" rowspan="5" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
              </tr>
          <tr>
            <td height="145" valign="top" style="width: 909px"><table width="100%" border="0" cellpadding="0" cellspacing="0"  >
                    <!--DWLayoutTable-->
                    <tr>
                      <td width="1" height="10"></td>
                      <td width="3"></td>
                      <td width="217"></td>
                      <td width="211"></td>
                      <td width="173"></td>
                      <td width="309"></td>
                    </tr>
                    <!--DWLayoutTable-->
                    <tr>
                      <td colspan="2" rowspan="5" align="right" valign="middle"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td height="25" align="right" valign="middle"><span  style="width: 181px">YearlyNo. :&nbsp;</span></td>
                      <td valign="middle"><span style="height: 25px; width: 285px;">
                        <asp:TextBox ID="TextBox1" runat="server"   Width="189px"  ></asp:TextBox>
                      </span></td>
                      <td align="right" valign="middle"><span  style="width: 181px">Registration No. :&nbsp;</span></td>
                      <td valign="middle"><span style="height: 25px; width: 285px;">
                        <asp:TextBox ID="TextBoxRegNo" runat="server"   Width="189px"  ></asp:TextBox>
                      </span></td>
                    </tr>
                    <tr>
                      <td height="25" align="right" valign="middle"><span  style="width: 181px">First Name :&nbsp;</span></td>
                      <td valign="middle"><span style="width: 285px; height: 25px;">
                        <asp:TextBox ID="TextBoxPFname" runat="server"   Width="189px"  ></asp:TextBox>
                      </span></td>
                      <td align="right" valign="middle"><span  style="width: 181px">Last Name :&nbsp;</span></td>
                      <td valign="middle"><asp:TextBox ID="TextBoxPMName" runat="server"  Width="189px"  ></asp:TextBox></td>
                    </tr>
                    <tr>
                      <td height="25" align="right" valign="middle"><span  style="width: 181px">Relation  :&nbsp;</span></td>
                      <td colspan="3" valign="middle"><span style="width: 163px; height: 22px">
                        <asp:RadioButtonList ID="RBLrelation" runat="server" 
                        Font-Names="verdana, arial, helvetica, sans-serif" RepeatDirection="Horizontal"
                        TabIndex="9" Width="172px">
                          <asp:ListItem Selected="True">S/O</asp:ListItem>
                          <asp:ListItem>D/O</asp:ListItem>
                          <asp:ListItem>W/O</asp:ListItem>
                        </asp:RadioButtonList>
                      </span></td>
                      </tr>
                    <tr>
                      <td height="25" align="right" valign="middle"><span  style="width: 181px">First Name :&nbsp;</span></td>
                      <td valign="middle"><asp:TextBox ID="TextBoxRFName" runat="server"  Width="189px"  ></asp:TextBox></td>
                      <td align="right" valign="middle"><span  style="width: 181px">Last Name :&nbsp;</span></td>
                      <td valign="middle"><asp:TextBox ID="TextBoxRMName" runat="server"  Width="189px"  ></asp:TextBox></td>
                    </tr>
                    <tr>
                      <td height="25" align="right" valign="middle"><span  style="width: 181px">Visit Days Before :&nbsp;</span></td>
                      <td valign="middle"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td align="right" valign="middle"><span  style="width: 181px">Referral Dept. :&nbsp;</span></td>
                      <td valign="middle"><!--DWLayoutEmptyCell-->&nbsp;</td>
                    </tr>
                    
              <tr>
                <td height="35" colspan="6" align="center" valign="middle"><asp:Button ID="Search" runat="server" CssClass="bt1upnew" Text="Search"  />
                  <asp:Button ID="Refresh" runat="server" Text="Refresh" CssClass="bt1upnew" />
&nbsp;                </td>
                      </tr>
              
              
                  </table></td>
                </tr>
          <tr>
            <td height="13" align="right" valign="top" style="width: 909px"><img src="images1/img_shedow.gif" width="249" height="13" /></td>
          </tr>
          <tr>
            <td height="254" valign="top" style="width: 909px"><span style="height: 390px">              <br />
              <asp:HiddenField ID="HiddenFieldSubDept" runat="server" />
              <asp:GridView ID="GridView2" runat="server" Width="100%" AllowPaging="false"  EmptyDataText="No data" >
                <Columns>
                <asp:HyperLinkField DataNavigateUrlFields="PayID,RegNo" DataNavigateUrlFormatString="historyexamination.aspx?PayId={0}&amp;?RegNo={1}&amp;cmo=&quot;cmo&quot;"
                            Text="View Patient" Visible="False" />
                </Columns>
                <RowStyle CssClass="GridItem" />
                <HeaderStyle CssClass="GridHeader" />              
                <AlternatingRowStyle CssClass="GridAltItem" />
              </asp:GridView>
              <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="[Search_Emg_Dept_Patient]"
                    SelectCommandType="StoredProcedure">
                <SelectParameters>
                  <asp:Parameter DefaultValue="2" Name="SubDeptNo" Type="Int32" />
                  <asp:Parameter DefaultValue="false" Name="Status" Type="Boolean" />
                  <asp:ControlParameter ControlID="TextBox1" DefaultValue="" Name="YearlyNo" PropertyName="Text"
                            Type="Decimal" />
                  <asp:Parameter DefaultValue="1" Name="request_type_id" Type="Int32" />
                  <asp:ControlParameter ControlID="TextBoxPFname" DefaultValue="%%" Name="PFName" PropertyName="Text"
                            Type="String" />
                </SelectParameters>
              </asp:SqlDataSource>
              <asp:HiddenField ID="HiddenFieldpfname" runat="server" />
                &nbsp;&nbsp;
                <asp:SqlDataSource ID="SqlDataSourceUpdate" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" UpdateCommand="UPDATE Forward_To_Sub_Dept SET dumypointer = @Pointer WHERE (Reg_No = @RegNO) AND (yearly_no = @yearlyNo) AND (status = 0) AND (request_type_id = 1)">
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="HiddenFieldEMpID" Name="Pointer" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenFieldRegNo" Name="RegNO" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenFieldYearlyNo" Name="yearlyNo" PropertyName="Value" />
                    </UpdateParameters>
                </asp:SqlDataSource>
              <asp:HiddenField ID="HiddenFieldYearlyNo" runat="server" />
              <asp:HiddenField ID="HiddenFieldPMName" runat="server" />
              <asp:HiddenField ID="HiddenFieldRelationFirstName" runat="server" />
              <asp:HiddenField ID="HiddenFieldRelation" runat="server" />
              <asp:HiddenField ID="HiddenFieldRMName" runat="server" />
              <asp:HiddenField ID="HiddenFieldRegNo" runat="server" />
              <asp:HiddenField ID="HiddenFieldAge" runat="server" /><asp:HiddenField ID="HiddenFieldEMpID" runat="server" />
              <span style="height: 25px; width: 285px;">
              <asp:TextBox ID="TextBoxAge" runat="server"   Width="189px"   Visible="false"></asp:TextBox>
              <span style="width: 285px; height: 25px;">
              <asp:TextBox ID="TextBoxRelation" runat="server"   Width="189px"   Visible="false"></asp:TextBox>
              </span></span></span></td>
          </tr>
          <tr>
            <td height="9" style="width: 909px"></td>
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