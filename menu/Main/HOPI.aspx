<%@ page language="VB" autoeventwireup="false" inherits="HOPI, App_Web_rbfdm1yf" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="Pragma" content="no-cache"/>
<title>HACIMS { Tele-Medicine Solution }</title>
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
            <td width="938" valign="middle" class="text_lables3" >History</td>
          </tr>
        <tr><div id ="a1" runat ="server">
          <td>&nbsp;</td>
        <tr>
          <td height="277" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
            <!--DWLayoutTable-->
            <tr>
              <td width="20" rowspan="2" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td width="913" style="height: 21px; text-align: center">&nbsp;<asp:Label ID="Label_message" runat="server" ></asp:Label></td>
                  <td width="20" rowspan="2" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td width="4" style="height: 21px"></td>
              </tr>
            <tr>
              <td height="258" valign="top"><asp:DataList ID="DataListtemplate" runat="server" DataKeyField="Template_id" DataSourceID="SqlDataSourceTemplate"
            RepeatColumns="5" RepeatDirection="Horizontal" Style="position: static" Width="896px">
            <ItemTemplate>
                <asp:LinkButton ID="SelectButton" runat="server" CommandName="Select" CssClass="login_link"
                    ForeColor="Blue" Style="position: static" Text='<%# Eval("Template_Name", "{0}") %>'></asp:LinkButton>
            </ItemTemplate>
            <SeparatorStyle BorderWidth="1px" CssClass="griditem" />
        </asp:DataList><asp:SqlDataSource ID="SqlDataSourceTemplate" runat="server" ConnectionString="<%$ ConnectionStrings:DMCConnectionString2 %>"
            SelectCommand="SELECT Admin_Assign_Template.Template_Id, Admin_Template.Template_Name FROM Admin_Assign_Template INNER JOIN Admin_Template ON Admin_Assign_Template.Template_Id = Admin_Template.Template_Id WHERE (Admin_Assign_Template.subdept_id = @subdeptid)&#13;&#10;and (Admin_Assign_Template.dept_id = @deptid)">
            <SelectParameters>
                <asp:SessionParameter Name="subdeptid" SessionField="SubDeptID" />
                <asp:SessionParameter Name="deptid" SessionField="dept_id" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:DataList ID="DataListMainGroup" runat="server" DataKeyField="Complaint_ID" DataSourceID="SqlDataSourceMainGroup"
            RepeatColumns="4" Style="position: static" Width="896px">
            <ItemTemplate>
                &nbsp;
                <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Select" CssClass="login_link"
                    Text='<%# Eval("Complaint_Name", "{0}") %>' Width="208px"></asp:LinkButton><br />
                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("Complaint_ID", "{0}") %>' />
            </ItemTemplate>
        </asp:DataList><asp:SqlDataSource ID="SqlDataSourceMainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
            SelectCommand="SELECT Pt_Presenting_Complaint.Complaint_Name, Pt_Presenting_Complaint_saveRecord.Complaint_ID FROM Pt_Presenting_Complaint_saveRecord INNER JOIN Pt_Presenting_Complaint ON Pt_Presenting_Complaint_saveRecord.Complaint_ID = Pt_Presenting_Complaint.Complaint_ID WHERE (Pt_Presenting_Complaint_saveRecord.YearlyNo = @Yearly) AND (Pt_Presenting_Complaint_saveRecord.RegNo = @RegNo)">
            <SelectParameters>
                <asp:SessionParameter Name="Yearly" SessionField="YearlyNo" />
                <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
            </SelectParameters>
        </asp:SqlDataSource>
                <asp:Panel ID="Panel1" runat="server" Height="50px" Width="900px">
                </asp:Panel><br />

                <asp:Button ID="Button_Save" runat="server" Text="Save" Width="150px" /><br />
<br />

                <asp:Label ID="Label1" runat="server" Text="Label" Width="72px" Visible="False"></asp:Label>
                <asp:HiddenField ID="HiddenField2" runat="server" Value="0" />
        <asp:HiddenField ID="HiddenField3" runat="server" Value="0" /></td>
                <td>&nbsp;</td>
              </tr>
            
            
            
              <asp:HiddenField ID="HiddenFieldToolTIp" runat="server" Value="true" /><asp:HiddenField ID="HiddenField1" runat="server" Value="true" />
            
            
            
            </table></td>
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
