<%@ page language="VB" autoeventwireup="false" inherits="Call_to_Doctor, App_Web_rbfdm1yf" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

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
    
    </tr>
  
  <tr>
    <td height="560" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" background="../images/image_bg_05.gif">
      <!--DWLayoutTable-->
      <tr>
        <td height="30" colspan="3" valign="top"><iframe 
      src="../tabs.aspx" name="holder" width="957" marginwidth="0" height="215" marginheight="0" 
      scrolling="No" frameborder="0" id="holder" style="height: 113px"></iframe>
        </td>
          </tr>
        <tr>
            <td align="left" class="text_lables3">
                <strong>New Patient &gt;&gt;</strong> <span class="text_heading_02" style="color: #317c3b">
                    <strong>Treatment for Patient &gt;&gt; Doctor Call</strong></span></td>
            <td class="text_lables3" style="height: 16px" valign="top">
            </td>
            <td class="text_lables3" style="height: 16px">
            </td>
        </tr>
        <tr>
            <td align="left" class="text_lables3">
            <iframe src="../PatientBasicInfo_Iframe.aspx" width="930" name="holder1" scrolling="no" frameborder="0" 
            style="height: 76px; width: 920px;" id="holder1" class="text_lables3" ></iframe>
            </td>
            <td class="text_lables3" style="height: 16px" valign="top">
            </td>
            <td class="text_lables3" style="height: 16px">
            </td>
        </tr>
      <tr>
        <td style="width: 919px; height: 441px; vertical-align: top; text-align: center;">
            <br />
            <table>
                <tr>
                    <td colspan="3" style="background-color: gainsboro">
                        <span style="font-size: 14pt"><strong>Call the Doctor</strong></span></td>
                </tr>
                <tr>
                    <td style="width: 285px; height: 24px;" align="right">
                        <strong>Department Name :</strong></td>
                    <td style="width: 268px; text-align: left; height: 24px;">
                        <asp:DropDownList ID="DropDownListDeptName" runat="server" DataSourceID="SqlDataSourceDepartmentName"
                            DataTextField="Dept_Name" DataValueField="Dept_ID" Width="175px" AutoPostBack="True">
                        </asp:DropDownList></td>
                    <td style="width: 57px; height: 24px;">
                    </td>
                </tr>
                <tr>
                    <td style="width: 285px" align="right">
                        <strong>
                        Sub Department&nbsp; Name :</strong></td>
                    <td style="width: 268px; text-align: left">
                        <asp:DropDownList ID="DropDownListSubDept" runat="server" DataSourceID="SqlDataSourceSubDepartmentName"
                            DataTextField="SubDept_Name" DataValueField="SubDept_Id" Width="175px">
                        </asp:DropDownList></td>
                    <td style="width: 57px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 285px" align="right">
                        <strong>Doctor Name :</strong></td>
                    <td style="width: 268px; text-align: left">
                        <asp:DropDownList ID="DropDownListDoctorName" runat="server" DataSourceID="SqlDataSourceDoctorName"
                            DataTextField="EmployeeName" DataValueField="EmpID" Width="175px">
                        </asp:DropDownList></td>
                    <td style="width: 57px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 285px" align="right">
                        <strong>
                        Subject to Call :</strong></td>
                    <td style="width: 268px; text-align: left">
                        <asp:TextBox ID="TextBoxSubject" runat="server" TextMode="MultiLine" Width="263px"></asp:TextBox></td>
                    <td style="width: 57px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 285px; height: 21px" align="right">
                        <strong>
                        Description to Call :</strong></td>
                    <td style="width: 268px; height: 21px">
                        <asp:TextBox ID="TextBoxDescription" runat="server" TextMode="MultiLine" Width="263px"></asp:TextBox></td>
                    <td style="width: 57px; height: 21px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 285px; height: 21px" align="right">
                        <strong>
                        When Needed :</strong></td>
                    <td style="width: 268px; height: 21px; text-align: left">
                        <asp:TextBox ID="TextBoxHours" runat="server" Width="28px"></asp:TextBox>
                        HH<asp:TextBox ID="TextBoxMin" runat="server" Width="28px"></asp:TextBox>
                        Min</td>
                    <td style="width: 57px; height: 21px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 285px">
                    </td>
                    <td style="width: 268px">
                    </td>
                    <td style="width: 57px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 285px">
                    </td>
                    <td style="width: 268px; text-align: left">
                        <asp:Button ID="ButtonSave" runat="server" Text="Save" Width="104px" /></td>
                    <td style="width: 57px">
                    </td>
                </tr>
            </table>
            &nbsp; &nbsp;&nbsp;<asp:SqlDataSource ID="SqlDataSourceDepartmentName" runat="server"
                ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>" ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>"
                SelectCommand="SELECT Dept_Name, Dept_ID FROM Department"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceSubDepartmentName" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT SubDept_Name, SubDept_Id FROM SubDepartment WHERE (Dept_Id = @DeptID)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownListDeptName" Name="DeptID" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceDoctorName" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT ISNULL(Prefix, ' ') + ' ' + ISNULL(EFName, ' ') + ' ' + ISNULL(EMName, ' ') + ' ' + ISNULL(ELName, ' ') AS EmployeeName, EmpID FROM Employee WHERE (DeptID = @DeptID)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownListDeptName" Name="DeptID" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server"></asp:SqlDataSource>
        </td>
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
