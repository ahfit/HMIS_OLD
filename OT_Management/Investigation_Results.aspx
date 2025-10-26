<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Investigation_Results.aspx.vb" Inherits="Investigation_Results" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="Paragma" content="no-cache"/>
<title></title>
<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
<script type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

//-->
</script>
<script language ="javascript"  type="text/JavaScript">
function ViewReport()
{
//alert("sdfsd");
  window.open("PatalogyTestReport.aspx","MyWindow","");
 return false;
}

</script>
</head>
<body onload="MM_preloadImages('images1/img_btn_over.gif')">
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
          <td width="929" valign="middle" class="text_lables3" >
              Assign Test 
              <asp:ScriptManager ID="ScriptManager1" runat="server">
              </asp:ScriptManager>&nbsp;
                      </td>
        </tr>
      <tr>
        <td height="428" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
          <!--DWLayoutTable-->
          <tr>
            <td width="20" rowspan="4" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td height="19" colspan="4" align="right" valign="top" ><asp:Label ID="Label2" runat="server" Width="399px" ></asp:Label></td>
                  <td width="20" rowspan="4" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
              </tr>
          <tr>
            <td colspan="4" valign="top" style="height: 51px" ><table width="916" border="0" cellpadding="0" cellspacing="0" >
              <!--DWLayoutTable-->
              <tr>
                <td height="23" valign="middle" class="text_nameheading" >&nbsp;&nbsp;
                    <asp:Label ID="labelPName" runat="server" CssClass="text_boxtitle" Width="260px" ></asp:Label></td>
                <td  align="right" valign="middle" >
                    Yearly No. :&nbsp; </td>
                <td  valign="middle" >
                    <asp:Label ID="Label_YearlyNo" runat="server" Width="150px"></asp:Label></td>
                <td  align="right" valign="middle"><span >Registration No.  :&nbsp; </span></td>
                <td  valign="middle"><span >
                  <asp:Label ID="LabelRegNo" runat="server" Width="127px"></asp:Label>
                </span></td>
              </tr>
              <tr>
                <td valign="top" class="tabledotted_top"><span >
                  &nbsp;
                  <asp:Label ID="LabelPSex"
                            runat="server" CssClass="text_boxtitle"></asp:Label>
                  ,
                  <asp:Label ID="LabelPAge" runat="server" CssClass="text_boxtitle"></asp:Label>
                  year </span></td>
                <td align="right" valign="middle" class="tabledotted_top" ><span >Referral Department :&nbsp;</span></td>
                <td valign="middle" class="tabledotted_top" style="height: 25px"><span >&nbsp;<asp:Label ID="labelWardReferal" runat="server"
                        Width="145px"></asp:Label></span></td>
                <td align="right" valign="middle" class="tabledotted_top" ><span >&nbsp;</span></td>
                <td valign="middle" class="tabledotted_top" style="text-align: right" ><span > <span style="color: #0088e8"><a href="Select_Test_Ad.aspx" class="login_link">
                        Advance Option</a><strong>&nbsp; </strong></span></span></td>
              </tr>
            </table></td>
            </tr>
          <tr>
            <td colspan="4" style="height: 36px" >
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                  <ContentTemplate>
                      <table style="width: 766px">
                          <tr>
                              <td style="width: 93px; height: 42px;">
                                  <table>
                                      <tr>
                                          <td  style="width: 93px">
                                              Test Search :</td>
                                          <td style="width: 118px">
                                              <asp:TextBox ID="TextBox_Search_Test" runat="server" Width="107px"></asp:TextBox></td>
                                          <td style="width: 78px">
                                  <asp:Button ID="Button_Search_Test" runat="server" Text="Search" CssClass="bt1upnew" OnClick="Button_Search_Test_Click" /></td>
                                      </tr>
                                  </table>
                              </td>
                              <td style="width: 50px; height: 42px;">
                  </td>
                              <td style="width: 100px; height: 42px;">
                  <asp:Label  ID="labelGName"
                runat="server" Width="313px" Font-Size="Medium"></asp:Label></td>
                          </tr>
                          <tr>
                              <td style="width: 93px; vertical-align: top; text-align: center; height: 192px;">
                                  <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="TSGID"
                                      DataSourceID="SqlDataSource_For_Grid" Width="322px" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                                      <Columns>
                                          <asp:ButtonField CommandName="Select" DataTextField="TSGName" HeaderText="Sub Group Name "
                                              Text="Button" />
                                          <asp:BoundField DataField="TSGID" HeaderText="Code" InsertVisible="False" ReadOnly="True"
                                              SortExpression="TSGID" />
                                          <asp:BoundField DataField="Assign Date" HeaderText="Assign Date" ReadOnly="True"
                                              SortExpression="Assign Date" />
                                      </Columns>
                                  </asp:GridView>
                                  <asp:SqlDataSource ID="SqlDataSource_For_Grid" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                                      ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="Search_Assign_Test"
                                      SelectCommandType="StoredProcedure">
                                      <SelectParameters>
                                          <asp:ControlParameter ControlID="TextBox_Search_Test" Name="TestName" PropertyName="Text"
                                              Type="String" />
                                          <asp:SessionParameter Name="payID" SessionField="YearlyNo" Type="Decimal" />
                                          <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" Type="String" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>
                                  <asp:HiddenField ID="HiddenField_Main_ID" runat="server" />
                                  <asp:Label ID="Label1" runat="server" Text="Label" Width="294px" Visible="False"></asp:Label></td>
                              <td style="width: 50px; overflow: auto; height: 192px;">
                                  <div style="overflow: auto; width: 80px; position: static; height: 207px">
                                  </div>
                              </td>
                              <td style="width: 100px; overflow: auto; height: 192px;">
                                  <div id="DIV1" style="width: 406px; position: static; height: 212px; overflow: auto; text-align: center;">
                                      <asp:GridView ID="GridView_For_Results" runat="server" AutoGenerateColumns="False"
                                          DataKeyNames="TSGID" DataSourceID="SqlDataSource_For_Test_Result" Width="398px">
                                          <Columns>
                                              <asp:BoundField DataField="TestName" HeaderText="Test Details" SortExpression="TestName" />
                                              <asp:BoundField DataField="TCValue" HeaderText="Results" SortExpression="TCValue" />
                                              <asp:BoundField DataField="TSGID" HeaderText="TSGID" InsertVisible="False" ReadOnly="True"
                                                  SortExpression="TSGID" Visible="False" />
                                              <asp:BoundField DataField="TC_Range_Unit" HeaderText="Normal Range" SortExpression="TC_Range_Unit" />
                                              <asp:BoundField DataField="Date_Time" HeaderText="Result Date" ReadOnly="True" SortExpression="Date_Time" />
                                          </Columns>
                                      </asp:GridView><asp:HiddenField ID="HiddenField_YearlyNo" runat="server" />
                                      <asp:HiddenField ID="HiddenField_RegNo" runat="server" /></div>
                              </td>
                          </tr>
                      </table>
                                  <asp:SqlDataSource ID="SqlDataSource_For_Test_Result" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                                      ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="Select_Test_Result_For_Sub_Group"
                                      SelectCommandType="StoredProcedure">
                                      <SelectParameters>
                                          <asp:ControlParameter ControlID="HiddenField_RegNo" Name="RegNo" PropertyName="Value"
                                              Type="String" />
                                          <asp:ControlParameter ControlID="HiddenField_YearlyNo" Name="YearlyNo" PropertyName="Value"
                                              Type="Decimal" />
                                          <asp:ControlParameter ControlID="HiddenField_Main_ID" Name="TSGID" PropertyName="Value"
                                              Type="Int32" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:UpdatePanel>            
            </td>
          </tr>
          
          
          
          <tr>
            <td colspan="4" align="center" valign="top" style="height: 8px" >
                &nbsp; &nbsp; &nbsp;            &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;
                &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp;
                <asp:Label ID="LabelCNIC" runat="server" Visible="False" Width="125px"></asp:Label><asp:Label
                    ID="LabelDOB" runat="server" Visible="False" Width="123px"></asp:Label>
                &nbsp; &nbsp;
                    <asp:Label ID="LabelRelation" runat="server" CssClass="text_boxtitle" ></asp:Label>
                    <asp:Label ID="LabelRName" runat="server" CssClass="text_boxtitle" ></asp:Label><span class="tabletabs" style="height: 32px"></span></td>
            </tr>
          
          
          
          
          
          
          
          
          
          
          
              
          

          
          
          
          
          
          
          

          
          
          
          
          
          
          
          
          
          

          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          </table></td>
          </tr>
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
    </table></td>
    <td width="33" valign="top" class="right_border" ><img src="images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  <tr>
    <td colspan="3" valign="top" style="height: 23px"><img src="images1/img_border_bottom.gif" width="1003" height="24" /></td>
  </tr>
</table>
<script type="text/javascript" src="images1/flash_01.js"></script>
</form>
</body>
</html>