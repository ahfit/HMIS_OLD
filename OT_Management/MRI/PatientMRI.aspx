<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PatientMRI.aspx.vb" Inherits="PatientMRI" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
</head>

<body>
<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_top.gif" width="1003" height="24" alt=""/></td>
  </tr>
  <tr>
    <td width="23" rowspan="2" valign="top" class="left_border"><img src="images1/img_border_left.gif" width="23" height="15" alt=""/></td>
    <td width="957" height="336" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
        <td height="97" colspan="2" valign="top"><iframe 
      src="tabs.aspx" name="holder" width="957" marginwidth="0" height="97" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
          </tr>
      
      
      <tr>
        <td width="19" height="25" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="938" valign="middle" class="text_lables3">
                Add Result</td>
          </tr>
      <tr>
        <td height="211" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="mainframe_bg1">
          <!--DWLayoutTable-->
          <tr>
            <td width="20" rowspan="4" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" alt=""/></td>
                  <td width="917" height="10" valign="top" style="width: 905px"><img src="images1/img_spacer2.gif" width="2" height="10" alt=""/></td>
                  <td width="20" rowspan="4" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" alt=""/></td>
                </tr>
          <tr>
            <td height="65" valign="top" >
              
              
              
              <iframe 
      src="PatientBasicInfo_Iframe.aspx" name="holder" width="917" marginwidth="0" height="65" marginheight="0" 
      scrolling="No" frameborder="0" id="Iframe1"></iframe>            </td>
                </tr>
          <tr>
            <td height="18"></td>
                </tr>
          <tr>
            <td height="118" valign="top" style="width: 905px" dir="ltr"><span style="height: 390px">
              <asp:Label CssClass="text_lables_login" ID="LabelAttach" runat="server" Width="828px"></asp:Label>
              <br />
              <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceXray"
                     Width="100%" DataKeyNames="RID" ><Columns>
                <asp:BoundField DataField="RegNo" SortExpression="RegNo" HeaderText="Registration No"></asp:BoundField>
                <asp:BoundField DataField="PayID" SortExpression="PayID" HeaderText="Yearly No "></asp:BoundField>
                <asp:BoundField DataField="RadiologyName" SortExpression="RadiologyName" HeaderText="Area of Scan"></asp:BoundField>
                <asp:BoundField DataField="RSGName" SortExpression="RSGName" HeaderText="Group Name" Visible="False"></asp:BoundField>
                <asp:BoundField ReadOnly="True" DataField="PRadiologyID" InsertVisible="False" SortExpression="PRadiologyID" HeaderText="No." Visible="False"></asp:BoundField>
                <asp:HyperLinkField DataNavigateUrlFields="RID,payId,regno,PRadiologyID" DataNavigateUrlFormatString="Patient_Attach_result_File.aspx?RID={0}&amp;PayID={1}&amp;RegNo={2}&amp;Radiology_Id={3}"
                             Text="Attach File" />
                <asp:HyperLinkField DataNavigateUrlFields="rid,Payid,RegNo" DataNavigateUrlFormatString="~/Dicom/DicomeViewer.aspx?RID={0}&amp;Payid={1}&amp;RegNo={2}"
                             Text="Dicom Viewer" />
                </Columns>
                
                <RowStyle CssClass="GridItem"></RowStyle>
                
                <HeaderStyle CssClass="GridHeader"></HeaderStyle>
                
                <AlternatingRowStyle CssClass="GridAltItem"></AlternatingRowStyle>
                </asp:GridView>
              <asp:SqlDataSource ID="SqlDataSourceXray" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    SelectCommand="SELECT     Pt_Radiology_LabTest.PayID, Pt_Radiology_LabTest.RegNo, Radiology.RadiologyName, RadiologySubGroup.RSGName, &#13;&#10;                      Pt_Radiology_LabTest.PRadiologyID, Pt_Radiology_LabTest.RID&#13;&#10;FROM RadiologySubGroup INNER JOIN Radiology ON RadiologySubGroup.RSGID = Radiology.RSGID INNER JOIN Pt_Radiology_LabTest &#13;&#10;ON Radiology.RID = Pt_Radiology_LabTest.RID AND Radiology.RSGID = Pt_Radiology_LabTest.RSGID &#13;&#10;WHERE (Pt_Radiology_LabTest.RSGID = 37) AND (Pt_Radiology_LabTest.RegNo = @RegNo) AND (Pt_Radiology_LabTest.PayID = @YearlyNo)&#13;&#10;and Pt_Radiology_LabTest.rid not in (Select Pt_test_id from Pt_mri_images where  RegNo = @RegNo and payid = @YearlyNo)"><SelectParameters>
                <asp:ControlParameter PropertyName="Value" Name="RegNo" ControlID="HiddenField_RegNo"></asp:ControlParameter>
                <asp:ControlParameter PropertyName="Value" Name="YearlyNo" ControlID="HiddenField_PayID"></asp:ControlParameter>
                </SelectParameters>
                </asp:SqlDataSource>
              <br />
              <asp:HiddenField ID="HiddenField_PayID" runat="server" />
              <asp:HiddenField ID="HiddenField_RegNo" runat="server" />
              <asp:HiddenField ID="HiddenFieldSubDept" runat="server" />
              &nbsp;</span><span style="height: 30px"> </span><span style="height: 30px">&nbsp;</span><span style="height: 30px">
                <asp:Label ID="LabelPulse" runat="server" CssClass="text_boxtitle" Visible="False"></asp:Label><asp:Label ID="Label2" runat="server"  Text="bpm" Visible="False"></asp:Label><asp:Label ID="LabelBP" runat="server" CssClass="text_boxtitle" Visible="False"></asp:Label><asp:Label ID="LabelBPLow" runat="server" CssClass="text_boxtitle" Visible="False"></asp:Label><asp:Label ID="Label1" runat="server"  Text="mm/gh" Visible="False"></asp:Label><asp:Label ID="LabelRR" runat="server" CssClass="text_titles_bold" Visible="False"></asp:Label><asp:Label ID="Label3" runat="server"  Text="per min." Visible="False"></asp:Label><asp:Label ID="LabelTemp" runat="server" CssClass="text_titles_bold" Visible="False"></asp:Label>
                <asp:Label ID="Label4" runat="server"  Text="F" Visible="False"></asp:Label>
                </span></td>
                </tr>
          
          

          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
            </table></td>
          </tr>
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
    </table></td>
    <td width="32" rowspan="2" valign="top" class="right_border" ><img src="images1/img_border_right.gif" width="23" height="15" alt=""/></td>
  </tr>
  <tr>
    <td height="0"></td>
  </tr>
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_bottom.gif" width="1003" height="24" alt=""/></td>
  </tr>
</table>
<script type="text/javascript" src="images1/flash_01.js"></script>
</form>
</body>
</html>