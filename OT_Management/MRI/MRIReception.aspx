<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MRIReception.aspx.vb" Inherits="MRIReception" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<link href="../../images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
</head>

<body>
<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="../../images1/img_border_top.gif" width="1003" height="24" alt=""/></td>
  </tr>
  <tr>
    <td width="23" height="669" valign="top" class="left_border"><img src="../../images1/img_border_left.gif" width="23" height="15" alt=""/></td>
    <td width="957" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
        <td height="97" colspan="2" valign="top"><iframe 
      src="../../tabs.aspx" name="holder" width="957" marginwidth="0" height="92" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
          </tr>    
      
      <tr>
        <td width="19" height="25" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="938" valign="middle" class="text_lables3">
                Result and Report Section</td>
          </tr>
      <tr>
        <td height="487" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="mainframe_bg1">
          <!--DWLayoutTable-->
          <tr>
            <td width="20" rowspan="6" valign="top"><img src="../../images1/img_spacer.gif" width="20" height="2" alt=""/></td>
                  <td width="914" height="19" valign="top" style="width: 907px">
                  <asp:ScriptManager ID="ScriptManager1" runat="server"> 
                  </asp:ScriptManager></td>
                  <td width="23" rowspan="6" valign="top"><img src="../../images1/img_spacer.gif" width="20" height="2" alt=""/></td>
                </tr>
          <tr>
            <td height="114" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0"  >
                <!--DWLayoutTable-->
                <tr>
                  <td width="175" height="5"></td>
                  <td width="250"></td>
                  <td width="175"></td>
                  <td width="314"></td>
                </tr>
                <tr>
                  <td height="25" align="right" valign="middle" ><span >Yearly No.  :&nbsp;</span></td>
                  <td valign="middle">
                  <asp:TextBox ID="TextBox1" runat="server" Width="160px" class="boxborderdeactive" onactivate="this.className='boxborderactive';" ondeactivate="this.className='boxborderdeactive';" TabIndex="1">
                  </asp:TextBox></td>
                  <td align="right" valign="middle" ><strong>Patient Relation :&nbsp;</strong></td>
                  <td valign="middle"><span style="height: 45px">
                    <asp:RadioButtonList ID="RadioButtonList_Relation" runat="server" Height="1px" RepeatDirection="Horizontal"
                        Width="153px" CssClass="text_titles_bold" TabIndex="5">
                      <asp:ListItem>S/O</asp:ListItem>
                      <asp:ListItem>D/O</asp:ListItem>
                      <asp:ListItem>W/O</asp:ListItem>
                    </asp:RadioButtonList>
                  </span></td>
                </tr>
                <tr>
                  <td height="25" align="right" valign="middle" ><strong>Registration No . :&nbsp;</strong></td>
                  <td valign="middle">
                  <asp:TextBox ID="TextBoxRegNo" runat="server" class="boxborderdeactive" onactivate="this.className='boxborderactive';"
                        ondeactivate="this.className='boxborderdeactive';" Width="160px" TabIndex="2">
                  </asp:TextBox></td>
                  <td align="right" valign="middle" ><span  style="text-align: right"><strong>Relation First Name :</strong>&nbsp;</span></td>
                  <td valign="middle">
                  <asp:TextBox ID="TextBoxRFName" runat="server" class="boxborderdeactive" onactivate="this.className='boxborderactive';"
                        ondeactivate="this.className='boxborderdeactive';" Width="160px" TabIndex="6">
                  </asp:TextBox></td>
                </tr>
                <tr>
                  <td height="25" align="right" valign="middle" ><span class="text_boxtitle">Patient First Name :&nbsp;</span></td>
                  <td valign="middle">
                  <asp:TextBox ID="TextBoxPFname" runat="server" class="boxborderdeactive" onactivate="this.className='boxborderactive';"
                        ondeactivate="this.className='boxborderdeactive';" Width="160px" TabIndex="3">
                  </asp:TextBox></td>
                  <td align="right" valign="middle" ><strong>Relation Last Name :&nbsp;</strong></td>
                  <td valign="middle">
                  <asp:TextBox ID="TextBoxRMName" runat="server" class="boxborderdeactive" onactivate="this.className='boxborderactive';"
                        ondeactivate="this.className='boxborderdeactive';" Width="160px" TabIndex="7">
                  </asp:TextBox></td>
                </tr>
                <tr>
                  <td height="25" align="right" valign="middle" ><span class="text_boxtitle">Patient Last Name :&nbsp;</span></td>
                  <td valign="middle"><span style="height: 24px">
                    <asp:TextBox ID="TextBoxPMName" runat="server" class="boxborderdeactive" onactivate="this.className='boxborderactive';"
                        ondeactivate="this.className='boxborderdeactive';" Width="160px" TabIndex="4">
                  </asp:TextBox>
                  </span></td>
                  <td align="right" valign="middle" ><strong>Patient Age :&nbsp;</strong></td>
                  <td valign="middle">
                  <asp:TextBox ID="TextBoxAge" runat="server" class="boxborderdeactive" onactivate="this.className='boxborderactive';"
                        ondeactivate="this.className='boxborderdeactive';" Width="160px" TabIndex="9">
                  </asp:TextBox></td>
                </tr>
                <tr>
                  <td height="9"></td>
                  <td></td>
                  <td></td>
                  <td></td>
                </tr>
              
                        </table></td>
          </tr>
          <tr>
            <td height="13" align="right" valign="top"><span style="width: 895px"><img src="../../images1/img_shedow.gif" width="249" height="13"  alt="" /></span></td>
            </tr>
          <tr>
            <td height="30" align="center" valign="middle">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
              <ContentTemplate>
                <table>
                  <tr>
                    <td >
                    <asp:Button ID="Search" runat="server" Text="Search"  CssClass="bt2up" TabIndex="10" /></td>
                    <td >
                    <asp:Button ID="Refresh" runat="server" Text="Refresh" CssClass="bt2up" TabIndex="11"/></td>
                  </tr>
                </table>
              </ContentTemplate>
            </asp:UpdatePanel></td>
            </tr>
          <tr>
            <td height="13"></td>
          </tr>
          <tr>
            <td height="307" valign="top" style="width: 907px"><span style="height: 390px">
              <asp:GridView ID="GridView1" runat="server" AllowPaging="True"
                    AutoGenerateColumns="False"  DataKeyNames="PayID,RegNo" DataSourceID="SqlDataSourcePatients"
                    Width="100%" Visible="False">
                <FooterStyle CssClass="GridPager" />              
                <Columns>
                <asp:HyperLinkField DataNavigateUrlFields="payid,Regno" DataNavigateUrlFormatString="patientxray.aspx?PayId={0}&amp;RegNo={1}"
                            Text="Add Results" />
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
              <asp:SqlDataSource ID="SqlDataSourcePatients" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString2 %>"
                    SelectCommand="SearchEmgDeptPatient" SelectCommandType="StoredProcedure">
                <SelectParameters>
                  <asp:ControlParameter ControlID="HiddenFieldSubDept" DefaultValue="23" Name="SubDeptNo"
                            PropertyName="Value" Type="Int32" />
                  <asp:Parameter DefaultValue="0" Name="status" />
                  <asp:ControlParameter ControlID="TextBox1" DefaultValue="0" Name="YearlyNo" PropertyName="Text"
                            Type="Decimal" />
                  <asp:Parameter DefaultValue="12" Name="request_type_id" Type="Int32" />
                </SelectParameters>
              </asp:SqlDataSource>
              <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                  <asp:GridView ID="GridView2" runat="server" Width="100%" EmptyDataText="no"  >
                    <Columns>
                    <asp:HyperLinkField DataNavigateUrlFields="payid,Regno" DataNavigateUrlFormatString="patientMRI.aspx?PayId={0}&amp;RegNo={1}"
                            Text="Add Results" />
                    </Columns>
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader" />              
                    <AlternatingRowStyle CssClass="GridAltItem" />
                  </asp:GridView>
                </ContentTemplate>
              </asp:UpdatePanel>
&nbsp;
<asp:HiddenField ID="HiddenFieldpfname" runat="server" />
<asp:SqlDataSource ID="SqlDataSource_Patients" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="Search_Emg_Dept_Patient"
                    SelectCommandType="StoredProcedure">
  <SelectParameters>
    <asp:ControlParameter ControlID="HiddenFieldSubDept" Name="SubDeptNo" PropertyName="Value"
                            Type="Int32" />
    <asp:Parameter DefaultValue="false" Name="Status" Type="Boolean" />
    <asp:ControlParameter ControlID="TextBox1" DefaultValue="0" Name="YearlyNo" PropertyName="Text"
                            Type="Decimal" />
    <asp:Parameter DefaultValue="12" Name="request_type_id" Type="Int32" />
    <asp:ControlParameter ControlID="TextBoxPFname" DefaultValue="%" Name="PFName" PropertyName="Text"
                            Type="String" />
    <asp:ControlParameter ControlID="TextBoxPMName" DefaultValue="%" Name="PMName" PropertyName="Text"
                            Type="String" />
  </SelectParameters>
</asp:SqlDataSource>
<asp:HiddenField ID="HiddenFieldSubDept" runat="server" />
&nbsp;
<asp:HiddenField ID="HiddenFieldYearlyNo" runat="server" />
<asp:HiddenField ID="HiddenFieldPMName" runat="server" />
<asp:HiddenField ID="HiddenFieldRelationFirstName" runat="server" />
<asp:HiddenField ID="HiddenFieldRelation" runat="server" />
<asp:HiddenField ID="HiddenFieldRMName" runat="server" />
<asp:HiddenField ID="HiddenFieldRegNo" runat="server" />
<asp:HiddenField ID="HiddenFieldAge" runat="server" />
&nbsp;</span><span style="height: 30px"> </span><span style="height: 30px">&nbsp;</span><span style="height: 30px"></span></td>
                </tr>
          
          </table></td>
          </tr>
    </table></td>
    <td width="32" valign="top" class="right_border" ><img src="../../images1/img_border_right.gif" width="23" height="15" alt=""/></td>
  </tr>
  <tr>
    <td height="24" colspan="3" valign="top"><img src="../../images1/img_border_bottom.gif" width="1003" height="24" alt=""/></td>
  </tr>
</table>
<script type="text/javascript" src="../../images1/flash_01.js"></script>
</form>
</body>
</html>