<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Admin_RadiologyMain.aspx.cs" Inherits="Administrator_RadiologyMain" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link href="../../images/sheet_blue.css" rel="stylesheet" type="text/css" />
<link href="../../images/sheet_form.css" rel="stylesheet" type="text/css" />
<script src="../../images/highlight.js" type="text/javascript"></script>
<style type="text/css">
body {
	background-image:none;
	margin-top:0px;
}
html {
	background-image:none;
}
</style>

</head>

<body>
<form id ="form1" runat ="server">
 <div id="forms_items" class="forms_items"> 
<table width="100%" border="0" cellpadding="0" cellspacing="0">
          <!--DWLayoutTable-->
          <tr>
            <td width="118" height="131" valign="middle" style="height: 131px"><a href="patientreport.aspx">
              <asp:ImageButton ID="ImageButtonDailyreport" runat="server" ImageUrl="images/bt_0039.gif" OnClick="ImageButtonDailyreport_Click" />              
              </a></td>
                  <td width="24" style="height: 131px">&nbsp;</td>
                  <td width="118" valign="top" style="height: 131px">
                    <asp:ImageButton ID="ImageButtonTestSubGroup" runat="server" ImageUrl="images/bt_0040.gif" OnClick="ImageButtonTestSubGroup_Click" />                                        
                  <a href="subdept.aspx"></a></td>
                  <td width="24" style="height: 131px">&nbsp;</td>
                  <td width="118" valign="top" style="height: 131px"><asp:ImageButton ID="ImageButtonTest" runat="server" ImageUrl="images/bt_0041.gif" OnClick="ImageButtonTest_Click" /></td>
                <td width="23" style="height: 131px">&nbsp;</td>
                <td width="118" valign="top" style="height: 131px">
                  <asp:ImageButton ID="ImageButtonRDMainGroup" runat="server" PostBackUrl="~/Administrator/Admin_Radiology_MainGroup.aspx" ImageUrl="images/img_01.gif" OnClick="ImageButtonRDMainGroup_Click" /></td>
                <td width="18" style="height: 131px">&nbsp;</td>
                <td width="118" valign="top" style="height: 131px">
                  <asp:ImageButton ID="ImageButtonRDSubGroup" runat="server" PostBackUrl="~/Administrator/Admin_Radiology_Exam_Element.aspx" ImageUrl="images/img_02.gif" /></td>
                <td width="10">&nbsp;</td>
                <td width="118" valign="top" style="height: 131px"><asp:ImageButton ID="ImageButtonElementValues" runat="server" PostBackUrl="~/Administrator/Admin_Radiology_Exam_Element_Values.aspx" ImageUrl="images/img_03.gif" /></td>
                <td width="2">&nbsp;</td>
          </tr>
          
          
          
          
        </table><br />
<table width="100%" border="0" cellpadding="0" cellspacing="0">
          <!--DWLayoutTable-->
          <tr>
            <td width="118" height="127" valign="top"><a href="../Radiology/RadiologyGroup.aspx"><img src="images/rd_group_entries.gif" width="118" height="127" border="0" /></a></td>
              <td width="25">&nbsp;</td>
              <td width="115" valign="top"><a href="../Radiology/RadiologySubGroup.aspx"><img src="images/rd_sub-group_entries.gif" width="118" height="127" border="0" /></a></td>
              <td width="25">&nbsp;</td>
              <td width="117" valign="top"><a href="../Radiology/RadiologyEnteries.aspx"><img src="images/rd_entries.gif" width="118" height="127" border="0" /></a></td>
              <td width="353">&nbsp;&nbsp;
                <asp:ImageButton ID="ImageButtonRadiologyRelation" runat="server" PostBackUrl="~/Administrator/Admin_Radiology_Examtype_Relation.aspx" ImageUrl="images/img_bt_rd.gif" /></td>
          </tr>
          
        </table><asp:ImageButton ID="ImageButtonlogout" ImageUrl="images/image_logout_up.gif" Width="71" Height="30" runat="server" />


</div>
</form>
</body>
</html>
