<%@ page language="VB" autoeventwireup="false" inherits="Duty_Roster, App_Web_rbfdm1yf" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="Paragma" content="no-cache"/>

<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="print.css" type="text/css" media="print">
<script type="text/JavaScript">
<!--
function MM_preloadImages() 
{ //v3.0
    var d=document; 
    if(d.images)
    { 
        if(!d.MM_p) 
        d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; 
    for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0)
        { 
        d.MM_p[j]=new Image; 
        d.MM_p[j++].src=a[i];
        }
    }
}
//-->
</script>

  <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
</head>

<body onload="MM_preloadImages('images1/img_bthover2.gif','images1/img_btup2.gif')">

<form id="form1" runat = "server">
<table width="1003" border="0" cellpadding="0" cellspacing="0" >
  <!--DWLayoutTable-->
  <tr>
    <td id="a1" height="24" colspan="3" valign="top"><img src="images1/img_border_top.gif" width="1003" height="24" /></td>
  </tr>
  <tr>
    <td  id="a3" width="23" height="550" valign="top" class="left_border"><img src="images1/img_border_left.gif" width="23" height="15" /></td>
    <td width="957" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
      
   <td height="73" colspan="2" valign="bottom" bgcolor="#F4F4F4" ><iframe 
      src="tabs.aspx" name="holder" width="957" marginwidth="0" height="97" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
      
                </tr>
      <tr>
        <td width="20" height="32" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="937" valign="middle" class="text_heading_02"><!--DWLayoutEmptyCell-->&nbsp;</td>
          </tr>
      
      
      
      
      
          <tr>
            <td height="449" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                <!--DWLayoutTable-->
                <tr>
                  <td width="20" rowspan="2" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td width="917" height="10" valign="top"><img src="images1/img_spacer2.gif" width="2" height="10" /></td>
                  <td width="20" rowspan="2" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                </tr>
                <tr>
                  <td height="439" valign="top" style="height: 439px"><table  width="100%" border="0" cellpadding="0" cellspacing="0">
                      <!--DWLayoutTable-->
                      <tr>
                        <td width="917" height="282" valign="top" style="text-align: center"><table width="100%" border="0" cellpadding="0" cellspacing="0" id="mytable">
                          <!--DWLayoutTable-->
                          <tr>
                            <td width="179" height="25" align="right" valign="middle" ><span style="width: 162px">Year :&nbsp;</span></td>
                              <td width="738" align="left" valign="middle"><span style="width: 198px">
                                <asp:DropDownList ID="DropDownList_Year" runat="server" AutoPostBack="True" Width="200px"> </asp:DropDownList>
                              </span></td>
                            </tr>
                          <tr>
                            <td height="25" align="right" valign="middle" ><span style="width: 162px">Month :&nbsp;</span></td>
                            <td align="left" valign="middle"><span style="width: 198px">
                              <asp:DropDownList ID="DropDownList_Month" runat="server" Width="200px"> </asp:DropDownList>
                            </span></td>
                          </tr>
                          <tr>
                            <td height="25" align="right" valign="middle" ><span style="width: 162px">Department :&nbsp;</span></td>
                            <td align="left" valign="middle"><span style="width: 198px">
                              <asp:DropDownList ID="DropDownListDepartment" runat="server" AutoPostBack="True"
                        Css DataSourceID="SqlDataSourceDepartmentName" DataTextField="Dept_Name"
                        DataValueField="Dept_ID" Width="200px"> </asp:DropDownList>
                            </span></td>
                          </tr>
                          <tr>
                            <td height="25" align="right" valign="middle" ><span style="width: 162px">Sub Department :&nbsp;</span></td>
                            <td align="left" valign="middle"><span style="width: 198px">
                              <asp:DropDownList ID="DropDownListSubDepartment" runat="server" AutoPostBack="True"
                        Css DataSourceID="SqlDataSourceSubDepartment" DataTextField="SubDept_Name"
                        DataValueField="SubDept_Id" Width="200px"> </asp:DropDownList>
                            </span></td>
                          </tr>
                          <tr>
                            <td height="25" align="right" valign="middle" ><span style="width: 162px">Profession :&nbsp;</span></td>
                            <td align="left" valign="middle"><span style="width: 198px">
                              <asp:DropDownList ID="DropDownList1" runat="server" Width="200px" AutoPostBack="True" DataSourceID="SqlDataSource_Profession" DataTextField="Profession_Name" DataValueField="Profession_Code"> </asp:DropDownList>
                            </span></td>
                          </tr>
                          <tr>
                            <td height="25" align="right" valign="middle" ><span style="width: 162px">Employee Name :&nbsp;</span></td>
                            <td align="left" valign="middle"><span style="width: 198px">
                              <asp:CheckBoxList CssClass="text_titles_bold_normal"
                        DataTextField="empolyeeName" DataValueField="EmpID" ID="CheckBoxList_Emp" RepeatColumns="3" RepeatDirection="Horizontal" runat="server"
                        Width="600px" DataSourceID="SqlDataSourceEmployeeName"> </asp:CheckBoxList>
                            </span></td>
                          </tr>
                          <tr>
                            <td height="25" align="right" valign="middle" ><!--DWLayoutEmptyCell-->&nbsp;</td>
                            <td align="left" valign="middle"><span style="width: 198px">
                              <asp:Button ID="Button_Search" runat="server" Text="Search" />                              
                            </span></td>
                          </tr>
                          <tr>
                            <td   height="25" colspan="2" align="right" valign="middle" ><br /></td>
                            </tr>
                          <tr>
                            <td height="25" colspan="2" align="right" valign="middle" ><!--DWLayoutEmptyCell-->&nbsp;</td>
                          </tr>
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                        </table></td>
                      </tr>
                      <tr>
                        <td height="31" valign="top"><div id="printit"><asp:SqlDataSource ID="SqlDataSourceDepartmentName" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
            ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>"
            SelectCommand="SELECT [Dept_Name], [Dept_ID] FROM [Department]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceSubDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
            ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>"
            SelectCommand="SELECT SubDept_Name, SubDept_Id FROM SubDepartment WHERE (Dept_Id = @Deptid)">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownListDepartment" Name="Deptid" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceEmployeeName" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
            SelectCommand="SELECT Employee.EmpID, ISNULL(Employee.Prefix, ' ') + ' ' + ISNULL(Employee.EFName, ' ') + ' ' + ISNULL(Employee.EMName, ' ') + ' ' + ISNULL(Employee.ELName, ' ') + ' (' + Designation.Designation_Name + ') ' AS empolyeeName, Employee.DeptID, Employee.SubDeptId, Employee.Profession_Code FROM Employee INNER JOIN Designation ON Employee.DesignationID = Designation.Designation_ID WHERE (Employee.DeptID = @DeptID) AND (Employee.SubDeptId = @SubDeptID) AND (Employee.Profession_Code = @Profession_Code)">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownListDepartment" Name="DeptID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="DropDownListSubDepartment" Name="SubDeptID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="DropDownList1" Name="Profession_Code" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_Profession" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
            ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>"
            SelectCommand="Select * From Admin_Employee_Profession"></asp:SqlDataSource>
        <asp:HiddenField ID="HiddenField_Date_End" runat="server" />
        <asp:HiddenField ID="HiddenField_Date_Start" runat="server" /><asp:Panel ID="Panel1" runat="server" Width="100%">
        </asp:Panel></div></td>
                      </tr>
                     

                      

                      

                      
                      
                      
                      
                      
                      
                      

                      
                      
                      

                      
                      
                      
                      
                      
                      
                  </table></td>
                </tr>
                
                
                
                

                
                
                
                
                
                
                
                

          
          
          
          
          
          
            </table></td>
          </tr>
      
      
      
      
      
      
      
      
      
      
            
    </table></td>
    <td width="32" id="a4" valign="top" class="right_border" ><img src="images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  
  <tr>
    <td height="24" id="a2" colspan="3" valign="top"><img src="images1/img_border_bottom.gif" width="1003" height="24" /></td>
  </tr>
</table>
<script type="text/javascript" src="images1/flash_01.js"></script>
</form>
</body>
</html>