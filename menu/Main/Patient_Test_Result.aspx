<%@ page language="VB" autoeventwireup="false" inherits="Patient_Test_Result, App_Web_rbfdm1yf" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>HACIMS { Tele-Medicine Solution }</title>
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

<script language="javascript" type ="text/javascript" >
function InsertValues(a)
{
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
        <td height="97" colspan="2" align="right" valign="middle"><iframe 
      src="tabs.aspx" name="holder" width="957" marginwidth="0" height="97" marginheight="0" 
      scrolling="No" frameborder="0" id="holder" ></iframe></td>
        </tr>
      
      <tr>
        <td width="19" height="25" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td width="929" valign="middle" class="text_lables3" >Pathology</td>
        </tr>
      <tr>
        <td height="428" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
          <!--DWLayoutTable-->
          <tr>
            <td rowspan="9" valign="top" style="width: 20px"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td height="19" colspan="4" align="right" valign="top" style="height: 19px" ><asp:Label ID="Label_Text" runat="server" Width="399px" ></asp:Label></td>
                  <td width="20" rowspan="9" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
              </tr>
          <tr>
            <td height="77" colspan="4" valign="top" ><table border="0" cellpadding="0" cellspacing="0"  style="width: 100%">
              <!--DWLayoutTable-->
              <tr>
                <td height="23" valign="middle" class="text_nameheading" style="width: 280px">&nbsp;&nbsp;
                    <asp:Label ID="labelPName" runat="server" CssClass="text_boxtitle" Width="260px" ></asp:Label></td>
                <td width="149" align="right" valign="middle" >Date of Birth :&nbsp; </td>
                <td width="163" valign="middle" >
                    &nbsp;<asp:Label ID="Labelage" runat="server" CssClass="text_labels" Width="104px"></asp:Label></td>
                <td width="116" align="right" valign="middle"><span >PIN No.  :&nbsp; </span></td>
                <td width="179" valign="middle"><span >
                  <asp:Label ID="LabelRegNo" runat="server" Width="127px"></asp:Label>
                </span></td>
              </tr>
              <tr>
                <td valign="top" class="tabledotted_top" style="width: 280px; height: 25px">&nbsp;&nbsp;
                    <asp:Label ID="LabelRelation" runat="server" CssClass="text_titles_bold" ></asp:Label>
                    <asp:Label ID="LabelRName" runat="server"  ></asp:Label>
                    <span >
                        <br />
                        &nbsp;
                  <asp:Label ID="LabelPSex"
                            runat="server" CssClass="text_boxtitle"></asp:Label>&nbsp;
                  <asp:Label ID="LabelPAge" runat="server" CssClass="text_boxtitle"></asp:Label>
                  </span></td>
                <td align="right" valign="middle" class="tabledotted_top" style="height: 25px"><span >N.I.C No.  :&nbsp;</span></td>
                <td valign="middle" class="tabledotted_top" style="height: 25px"><span >
                  <asp:Label ID="LabelCNIC" runat="server" Width="125px"></asp:Label>
                </span></td>
                <td align="right" valign="middle" class="tabledotted_top" style="height: 25px"><span >&nbsp;</span>&nbsp;</td>
                <td valign="middle" class="tabledotted_top" style="height: 25px">&nbsp;<asp:Label ID="LabelDOB" runat="server" Width="123px"></asp:Label></td>
              </tr>
            </table>
                </td>
            </tr>
          <tr>
            <td width="316" style="height: 27px" >
                </td>
            <td width="9" style="height: 27px" ></td>
            <td width="409" style="height: 27px" class="text_lables3" >
                <asp:LinkButton ID="LinkButton_Pathalogy" runat="server" Width="87px">Pathalogy</asp:LinkButton>
                <asp:LinkButton ID="LinkButton_MRI" runat="server" Width="51px">MRI</asp:LinkButton>
                <asp:LinkButton ID="LinkButton_CTScan" runat="server" Width="75px">CT Scan</asp:LinkButton>
                <asp:LinkButton ID="LinkButton_Xray" runat="server" Width="77px">XRay</asp:LinkButton></td>
            <td width="183" style="height: 27px" ></td>
          </tr>
          <tr>
            <td height="178" valign="top" colspan="4" style="text-align: center" ><span style="height: 303px" class="text_lables3">&nbsp;
                <br />
                <asp:Label ID="Label_Pathalogy" runat="server" Text="Pathalogy" Visible="False"></asp:Label><br />
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False"  DataSourceID="SqlDataSource_pathalogy" Width="625px">
                    <Columns>
                        <asp:BoundField DataField="RegNo" HeaderText="Registration No." SortExpression="RegNo" />
                        <asp:BoundField DataField="YearlyNo" HeaderText="Yearly No." SortExpression="YearlyNo" />
                        <asp:BoundField DataField="TGName" HeaderText="Test Group " SortExpression="TGName" />
                        <asp:BoundField DataField="TestName" HeaderText="Test Name" SortExpression="TestName" />
                        <asp:BoundField DataField="ComponentName" HeaderText="Component Name" SortExpression="ComponentName" />
                        <asp:BoundField DataField="TCValue" HeaderText="Component Value" SortExpression="TCValue" />
                    </Columns>
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource_pathalogy" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    DeleteCommand="DELETE FROM Pt_MRI_Images WHERE (Table_ID = @Table_ID)" ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>"
                    SelectCommand="SELECT     Path_PatientTestResult_Main.RegNo, Path_PatientTestResult_Main.YearlyNo, TestGroup.TGName, Test.TestName, TestComponent.ComponentName, &#13;&#10;                      path_PatientTestResult.TCValue&#13;&#10;FROM         Path_PatientTestResult_Main INNER JOIN&#13;&#10;                      path_PatientTestResult ON Path_PatientTestResult_Main.trmId = path_PatientTestResult.trmID INNER JOIN&#13;&#10;                      Test ON path_PatientTestResult.TId = Test.TID INNER JOIN&#13;&#10;                      TestComponent ON path_PatientTestResult.TCId = TestComponent.TCID INNER JOIN&#13;&#10;                      TestGroup ON Test.TGID = TestGroup.TGID&#13;&#10;WHERE     (Path_PatientTestResult_Main.RegNo = @RegNo) AND (Path_PatientTestResult_Main.YearlyNo = @YearlyNo)">
                    <DeleteParameters>
                        <asp:ControlParameter ControlID="GridView4" Name="Table_ID" PropertyName="SelectedValue" />
                    </DeleteParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />
                <asp:Label ID="Label_MRI" runat="server" Text="MRI" Visible="False"></asp:Label><asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" 
                    DataKeyNames="Table_ID" DataSourceID="SqlDataSource1" Width="625px">
                    <Columns>
                        <asp:BoundField DataField="Table_ID" HeaderText="Table_ID" InsertVisible="False"
                            ReadOnly="True" SortExpression="Table_ID" Visible="False" />
                        <asp:BoundField DataField="RegNo" HeaderText="Registration No." SortExpression="RegNo" />
                        <asp:BoundField DataField="YearlyNo" HeaderText="Yearly No." SortExpression="YearlyNo" />
                        <asp:BoundField DataField="RadiologyName" HeaderText="Area of Scan" SortExpression="RadiologyName" />
                        <asp:BoundField DataField="RID" HeaderText="RID" InsertVisible="False" ReadOnly="True"
                            SortExpression="RID" Visible="False" />
                        <asp:HyperLinkField DataNavigateUrlFields="rid,YearlyNo,RegNo" DataNavigateUrlFormatString="~/Dicom/DicomeViewer.aspx?RID={0}&amp;Payid={1}&amp;RegNo={2}  "
                            Text="Dicom Viewer" />
                    </Columns>
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    DeleteCommand="DELETE FROM Pt_MRI_Images WHERE (Table_ID = @Table_ID)" ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>"
                    SelectCommand="SELECT Pt_MRI_Images.Table_ID, Pt_MRI_Images.RegNo, Pt_MRI_Images.YearlyNo, Radiology.RadiologyName, Radiology.RID, Pt_MRI_Images.Pt_test_Id FROM Pt_MRI_Images INNER JOIN Radiology ON Pt_MRI_Images.Pt_test_Id = Radiology.RID WHERE (Pt_MRI_Images.RegNo = @RegNo) AND (Pt_MRI_Images.YearlyNo = @YearlyNo) ">
                    <DeleteParameters>
                        <asp:ControlParameter ControlID="GridView4" Name="Table_ID" PropertyName="SelectedValue" />
                    </DeleteParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />
                <asp:Label ID="Label_CTScan" runat="server" Text="CT Scan" Visible="False"></asp:Label><asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    DataKeyNames="Table_ID" DataSourceID="SqlDataSource1" Width="625px">
                    <Columns>
                        <asp:BoundField DataField="Table_ID" HeaderText="Table_ID" InsertVisible="False"
                            ReadOnly="True" SortExpression="Table_ID" Visible="False" />
                        <asp:BoundField DataField="RegNo" HeaderText="Registration No." SortExpression="RegNo" />
                        <asp:BoundField DataField="YearlyNo" HeaderText="Yearly No." SortExpression="YearlyNo" />
                        <asp:BoundField DataField="RadiologyName" HeaderText="Area of Scan" SortExpression="RadiologyName" />
                        <asp:BoundField DataField="RID" HeaderText="RID" InsertVisible="False" ReadOnly="True"
                            SortExpression="RID" Visible="False" />
                        <asp:HyperLinkField DataNavigateUrlFields="rid,YearlyNo,RegNo" DataNavigateUrlFormatString="~/Dicom/DicomeViewer.aspx?RID={0}&amp;Payid={1}&amp;RegNo={2}  "
                            Text="Dicom Viewer" />
                    </Columns>
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
                <br />
                <asp:Label ID="Label_XRay" runat="server" Text="XRAY" Visible="False"></asp:Label><asp:GridView ID="GridViewXrayView" runat="server" AutoGenerateColumns="False" 
                    DataKeyNames="XRay_ID" DataSourceID="SqlDataSourceXrayView" Width="627px">
                    <Columns>
                        <asp:BoundField DataField="Expr1" HeaderText="Part Id" SortExpression="Expr1" Visible="False" />
                        <asp:BoundField DataField="Rd_body_part" HeaderText="Body Part" SortExpression="Rd_body_part" />
                        <asp:BoundField DataField="Projection" HeaderText="Projection" SortExpression="Projection" />
                        <asp:BoundField DataField="Reg_No" HeaderText="Reg_No" SortExpression="Reg_No" Visible="False" />
                        <asp:BoundField DataField="Yearly_No" HeaderText="Yearly_No" SortExpression="Yearly_No"
                            Visible="False" />
                        <asp:BoundField DataField="Time_Stamp" HeaderText="Time" SortExpression="Date Time" />
                        <asp:CommandField SelectText="View" ShowSelectButton="True" Visible="False" />
                        <asp:HyperLinkField DataNavigateUrlFields="XRay_ID,Yearly_No,Reg_No" DataNavigateUrlFormatString="Ptxrayview1.aspx?Xray_ID={0}&amp;payId={1}&amp;rig_no={2}"
                            HeaderText="Xray" ShowHeader="False" Target="_blank" Text="Show" />
                        <asp:CommandField SelectText="View" ShowSelectButton="True" Visible="False" />
                        <asp:HyperLinkField DataNavigateUrlFields="XRay_ID,Reg_No,Yearly_No" DataNavigateUrlFormatString="XrayFindings.aspx?XRay_ID={0}&amp;Reg_No={1}&amp;Yearly_No={2}"
                            Text="Add Findings" Visible="False" />
                        <asp:BoundField DataField="XRay_ID" HeaderText="XRay_ID" SortExpression="XRay_ID"
                            Visible="False" />
                    </Columns>
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSourceXrayView" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT     Rd_xray_projections.Projections AS Projection, Pt_Xray.Reg_No, Pt_Xray.Yearly_No, Pt_Xray.Time_Stamp, Rd_body_part.Rd_body_part, &#13;&#10;                      Pt_Xray.XRay_ID, pt_Xray_Images.Xray_ID AS Expr1&#13;&#10;FROM         Pt_Xray INNER JOIN&#13;&#10;                      Rd_xray_projections ON Pt_Xray.XRay_ID = Rd_xray_projections.Projection_ID INNER JOIN&#13;&#10;                      Rd_body_part ON Rd_xray_projections.Rd_Body_part_Id = Rd_body_part.Rd_body_part_id INNER JOIN&#13;&#10;                      pt_Xray_Images ON Pt_Xray.XRay_ID = pt_Xray_Images.Xray_ID&#13;&#10;WHERE     (Pt_Xray.Reg_No=@regno) AND (Pt_Xray.Yearly_No = @yearlyno)">
                    <SelectParameters>
                        <asp:SessionParameter Name="regno" SessionField="registrationNo" />
                        <asp:SessionParameter Name="yearlyno" SessionField="YearlyNo" />
                    </SelectParameters>
                </asp:SqlDataSource>
                                                                                          </span>
                    </td>
                </tr>
          
          <tr>
            <td height="15" ></td>
            <td ></td>
            <td ></td>
            <td ></td>
          </tr>
          <tr>
            <td height="62" colspan="4" valign="top" dir="ltr" ><span style="width: 97px;">
                <asp:Menu ID="Menu1" runat="server" Orientation="Horizontal" Width="277px" Visible="False">
                    <Items>
                        <asp:MenuItem NavigateUrl="~/Reception_Test_Report.aspx" Text="Pathalogy" Value="Pathalogy">
                        </asp:MenuItem>
                        <asp:MenuItem NavigateUrl="~/PT_ASSIGN_RADIOLOGY_TESTS.aspx" Text="MRI" Value="MRI">
                        </asp:MenuItem>
                        <asp:MenuItem NavigateUrl="~/PT_ASSIGN_RADIOLOGY_TESTS.aspx" Text="CT Scan" Value="CT Scan">
                        </asp:MenuItem>
                        <asp:MenuItem Text="Xray" Value="Xray" NavigateUrl="~/xray.aspx"></asp:MenuItem>
                    </Items>
                </asp:Menu>
            </span></td>
            </tr>
          <tr>
            <td height="2" ></td>
            <td ></td>
            <td ></td>
            <td ></td>
          </tr>
          
          
          
          
          
          <tr>
            <td height="67" colspan="4" align="center" valign="top" >
                &nbsp;&nbsp;
&nbsp;&nbsp;<asp:Button ID="Button_Next" runat="server" Text="Move To Treatment" Width="150px" />
                &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</td>
            </tr>
          <tr>
            <td height="116" >&nbsp;</td>
            <td >&nbsp;</td>
            <td >&nbsp;</td>
            <td dir="ltr" >&nbsp;</td>
          </tr>
          
          
          
          
          
          
          
          
          
          
              
          

          
          
          
          
          
          
          

          
          
          
          
          
          
          
          
          
          

          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          </table></td>
          </tr>
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
    </table></td>
    <td width="33" valign="top" class="right_border" style="width: 33px"><img src="images1/img_border_right.gif" width="23" height="15" /></td>
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