<%@ page language="VB" autoeventwireup="false" inherits="Assign_Shift, App_Web_rbfdm1yf" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
 <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<link href="../images1/st_sheet_01.css" rel="stylesheet" type="text/css" />



</head>

<body  dir="ltr">

<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="../images1/img_border_top.gif" width="1003" height="24" /></td>
  </tr>
  <tr>
    <td width="23" height="359" valign="top" class="left_border"><img src="../images1/img_border_left.gif" width="23" height="15" /></td>
    <td width="957" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
        <td height="40" colspan="2" valign="top"><iframe 
      src="../tabs.aspx" name="holder" width="957" marginwidth="0" height="97" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
      </tr>
      
      <tr>
        <td width="20" height="32" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="937" valign="middle" class="text_heading_02"> <span class="text_heading_arial">
                Assign Shift</span></td>
          </tr>
       <tr>
            <td height="240" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                <!--DWLayoutTable-->
                <tr>
                  <td width="20" rowspan="2" valign="top"><img src="../images1/img_spacer.gif" width="20" height="2" /></td>
                  <td width="917" valign="top" style="height: 10px"><img src="../images1/img_spacer2.gif" width="2" height="10" />
                    <table width="100%" border="0" cellpadding="0" cellspacing="0"   id="TABLE1" onclick="return TABLE1_onclick()">
                          <!--DWLayoutTable-->
                        <tr>
                            <td align="right"  style="height: 21px" valign="middle" width="33%">
                                Start From :</td>
                            <td style="height: 21px" valign="middle" width="67%">
                                <igsch:webdatechooser id="WebDateChooser1" runat="server" width="192px">
                                    <AutoPostBack ValueChanged="True" />
                                </igsch:webdatechooser>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"  style="height: 19px" valign="middle" width="33%">
                                End Date :&nbsp;</td>
                            <td style="height: 19px" valign="middle" width="67%">
                                <igsch:webdatechooser id="WebDateChooser2" runat="server" width="192px">
                                    <AutoPostBack ValueChanged="True" />
                                </igsch:webdatechooser>
                            </td>
                        </tr>
                          <tr>
                            <td width="33%" align="right" valign="middle"  style="height: 27px" ><span  style="width: 194px">Department Name :&nbsp;</span></td>
                        <td width="67%" valign="middle" style="height: 27px" ><span  style="width: 217px">
                          <asp:DropDownList ID="DropDownListDepartment" runat="server" Width="200px" AutoPostBack="True" Css DataSourceID="SqlDataSourceDepartmentName" DataTextField="Dept_Name" DataValueField="Dept_ID"> </asp:DropDownList>
                        </span><strong  ></strong></td>
                      </tr>
                          <tr>
                              <td align="right"  height="32" valign="middle"><span  style="width: 194px; height: 21px;">Sub Department Name :&nbsp;</span></td>
                            <td valign="middle"><span  style="width: 217px; height: 21px;">
                              <asp:DropDownList ID="DropDownListSubDepartment" runat="server" Width="200px" AutoPostBack="True" Css DataSourceID="SqlDataSourceSubDepartment" DataTextField="SubDept_Name" DataValueField="SubDept_Id"> </asp:DropDownList>
                            </span></td>
                          </tr>
                        <tr>
                            <td align="right"  height="32" valign="middle">
                                Profession :&nbsp;
                            </td>
                            <td valign="middle">
                                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_Profession"
                                    DataTextField="Profession_Name" DataValueField="Profession_Code" Width="200px">
                                </asp:DropDownList></td>
                        </tr>
                          <tr>
                            <td height="24" align="right" valign="middle"  ><span  style="width: 194px; height: 21px;">Shift Name :&nbsp; </span></td>
                            <td valign="middle" ><span  style="width: 217px; height: 21px;">&nbsp;<asp:DropDownList ID="DropDownListShiftName" runat="server" Width="200px" Css DataSourceID="SqlDataSourceShiftName" DataTextField="ShiftName" DataValueField="ShiftId" AutoPostBack="True"> </asp:DropDownList></span></td>
                          </tr>
                          <tr>
                            <td height="27" align="right" valign="middle"  ><span  style="width: 194px">Employee Name :&nbsp;</span></td>
                          <td valign="middle" ><span  style="width: 217px">
                              <asp:CheckBoxList ID="CheckBoxList_Emp" runat="server" DataSourceID="SqlDataSourceEmployeeName"
                                  DataTextField="empolyeeName" DataValueField="EmpID" RepeatColumns="3" RepeatDirection="Horizontal"
                                  Width="600px">
                              </asp:CheckBoxList></span></td>
                          </tr>
                          <tr>
                            <td height="26" align="right" valign="middle"  ><span  style="width: 194px">Day of Week :&nbsp;</span></td>
                            <td valign="middle" ><span >
                                <asp:CheckBoxList ID="CheckBoxList_Day" runat="server" DataSourceID="SqlDataSourceDayofWeek"
                                    DataTextField="Day_Name" DataValueField="Day_ID" RepeatColumns="3" RepeatDirection="Horizontal"
                                    Width="600px">
                                </asp:CheckBoxList>
                                &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                  </span></td>
                            </tr>
                            <tr>
                                <td align="right"  valign="middle"  style="height: 34px">&nbsp;                                     </td>
                                <td style="height: 34px" >
                                    &nbsp;<asp:Button ID="ButtonSave" runat="server" Text="Save" CssClass="bt1up" />
                                    <span  style="width: 100px">
                                    <asp:LinkButton CssClass="login_link" ID="LinkButton1" runat="server">Show All Shift</asp:LinkButton>
                                    </span> </td>
                            </tr>
                  </table></td>
                  <td width="20" rowspan="2" valign="top"><img src="../images1/img_spacer.gif" width="20" height="2" /></td>
                </tr>
                <tr>
                  <td  valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <!--DWLayoutTable-->
                     
                      
                      <tr>
                        <td colspan="2" valign="top" dir="ltr" style="height: 22px" align="center"><br />
                        <span style="width: 888px; height: 614px; vertical-align: top; text-align: center;">
                        <asp:GridView ID="GridViewEmployeeShift" runat="server" AllowPaging="True" AutoGenerateColumns="False" AutoGenerateDeleteButton="True"  DataKeyNames="ES_ID" DataSourceID="SqlDataSourceEmployeeShift" Width="100%">
                          <Columns>
                          <asp:BoundField DataField="EMPLOYEE_NAME" HeaderText="Employee Name" ReadOnly="True"
                        SortExpression="EMPLOYEE_NAME" />
                          <asp:BoundField DataField="Dept_Name" HeaderText="Dept Name" SortExpression="Dept_Name" />
                          <asp:BoundField DataField="SubDept_Name" HeaderText="Sub Dept Name" SortExpression="SubDept_Name" />
                          <asp:BoundField DataField="ShiftName" HeaderText="Shift Name" SortExpression="ShiftName" />
                          <asp:BoundField DataField="start_Time" HeaderText="Start Time" ReadOnly="True" SortExpression="start_Time" />
                          <asp:BoundField DataField="end_time" HeaderText="End Time" ReadOnly="True" SortExpression="end_time" />
                          <asp:BoundField DataField="Day_Name" HeaderText="Day Name" SortExpression="Day_Name" />
                          <asp:BoundField DataField="ES_ID" HeaderText="ES_ID" InsertVisible="False" ReadOnly="True"
                        SortExpression="ES_ID" Visible="False" />
                              <asp:BoundField DataField="Duty_Date" HeaderText="Duty Date" SortExpression="Duty_Date" />
                          </Columns>
                          <RowStyle CssClass="GridItem" />
                          <HeaderStyle CssClass="GridHeader" />                        
                          <AlternatingRowStyle CssClass="GridAltItem" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSourceEmployeeShift" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>" SelectCommand="Admin_Select_Employee_Shift" SelectCommandType="StoredProcedure" DeleteCommand="DELETE FROM Emp_shift WHERE (ES_ID = @ES_ID)">
                          <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownListShiftName" Name="shift_id" PropertyName="SelectedValue"
                        Type="Int32" />
                            <asp:ControlParameter ControlID="DropDownListDepartment" Name="Dept_id" PropertyName="SelectedValue"
                        Type="Int32" />
                            <asp:ControlParameter ControlID="DropDownListSubDepartment" Name="subdept_id" PropertyName="SelectedValue"
                        Type="Int32" />
                            <asp:ControlParameter ControlID="HiddenFieldFlag" Name="Flag" PropertyName="Value"
                        Type="Int32" />
                          </SelectParameters>
                          <DeleteParameters>
                            <asp:ControlParameter ControlID="GridViewEmployeeShift" Name="ES_ID" PropertyName="SelectedValue" />
                          </DeleteParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSourceDepartmentName" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>" SelectCommand="SELECT [Dept_Name], [Dept_ID] FROM [Department]"> </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSourceSubDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>" SelectCommand="SELECT SubDept_Name, SubDept_Id FROM SubDepartment WHERE (Dept_Id = @Deptid)">
                          <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownListDepartment" Name="Deptid" PropertyName="SelectedValue" />
                          </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSourceEmployeeName" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="SELECT Employee.EmpID, ISNULL(Employee.Prefix, ' ') + ' ' + ISNULL(Employee.EFName, ' ') + ' ' + ISNULL(Employee.EMName, ' ') + ' ' + ISNULL(Employee.ELName, ' ') + ' (' + Designation.Designation_Name + ') ' AS empolyeeName, Employee.DeptID, Employee.SubDeptId FROM Employee INNER JOIN Designation ON Employee.DesignationID = Designation.Designation_ID WHERE (Employee.EmpID NOT IN (SELECT Emp_ID FROM Emp_shift WHERE (Duty_Date BETWEEN @Date_Start AND @Date_End))) AND (Employee.DeptID = @DeptID) AND (Employee.SubDeptId = @SubDeptID)">
                          <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownListDepartment" Name="DeptID" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="DropDownListSubDepartment" Name="SubDeptID" PropertyName="SelectedValue" />
                              <asp:ControlParameter ControlID="HiddenField_Date_Start" Name="Date_Start" PropertyName="Value" />
                              <asp:ControlParameter ControlID="HiddenField_Date_End" Name="Date_End" PropertyName="Value" />
                          </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSourceShiftName" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>" SelectCommand="SELECT ShiftName, ShiftId, DeptID, SubDeptId FROM emp_DutyShift WHERE (DeptID = @DeptID) AND (SubDeptId = @SubDeptID)">
                          <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownListDepartment" Name="DeptID" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="DropDownListSubDepartment" Name="SubDeptID" PropertyName="SelectedValue" />
                          </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" InsertCommand="INSERT INTO Emp_shift(Shift_ID, Emp_ID, Duty_Date) VALUES (@Shift_ID, @Emp_ID, @Duty_Date)" ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>">
                          <InsertParameters>
                            <asp:ControlParameter ControlID="DropDownListShiftName" Name="Shift_ID" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="HiddenField_Emp_ID" Name="Emp_ID" PropertyName="Value" />
                              <asp:ControlParameter ControlID="HiddenField_Day_ID" Name="Duty_Date" PropertyName="Value" />
                          </InsertParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSourceDayofWeek" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                InsertCommand="INSERT INTO emp_DutyShift(ShiftName, StartTime, EndTime, DeptID, SubDeptId) VALUES (@ShiftName, @StartTime, @EndTime, @DeptID, @SubDeptId)"
                ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>" SelectCommand="SELECT Day_Name, Day_ID FROM Week_Day">
                          <InsertParameters>
                            <asp:ControlParameter ControlID="TextBoxShiftName" Name="ShiftName" PropertyName="Text" />
                            <asp:ControlParameter ControlID="HiddenFieldStartTime" Name="StartTime" PropertyName="Value" />
                            <asp:ControlParameter ControlID="HiddenFieldToTime" Name="EndTime" PropertyName="Value" />
                            <asp:ControlParameter ControlID="DropDownListDepartment" Name="DeptID" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="DropDownListSubDepartment" Name="SubDeptId" PropertyName="SelectedValue" />
                          </InsertParameters>
                        </asp:SqlDataSource>
                        <asp:HiddenField ID="HiddenFieldFlag" runat="server" />
                            <asp:SqlDataSource ID="SqlDataSource_Emp" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>"
                                SelectCommand="SELECT Employee.EmpID, ISNULL(Employee.Prefix, ' ') + ' ' + ISNULL(Employee.EFName, ' ') + ' ' + &#13;&#10;ISNULL(Employee.EMName, ' ') + ' ' + ISNULL(Employee.ELName, ' ') + ' (' + Designation.Designation_Name + ') ' AS &#13;&#10;empolyeeName, Employee.DeptID, Employee.SubDeptId &#13;&#10;FROM Employee INNER JOIN Designation ON Employee.DesignationID = Designation.Designation_ID &#13;&#10;order by  Designation.Designation_ID &#13;&#10;WHERE (Employee.DeptID = @DeptID) AND (Employee.SubDeptId = @SubDeptID)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropDownListDepartment" Name="DeptID" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="DropDownListSubDepartment" Name="SubDeptID" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:HiddenField ID="HiddenField_Emp_ID" runat="server" />
                            <asp:HiddenField ID="HiddenField_Day_ID" runat="server" />
                            <asp:HiddenField ID="HiddenField_Date_End" runat="server" />
                            <asp:HiddenField ID="HiddenField_Date_Start" runat="server" />
                            <asp:SqlDataSource ID="SqlDataSource_Profession" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>"
                                SelectCommand="Select * From Admin_Employee_Profession"></asp:SqlDataSource>
                        </span><br />
                        <br /></td>
                      </tr>
                      <tr>
                        <td  colspan="2" valign="top" dir="ltr" ><asp:SqlDataSource ID="SqlDataSourceShift" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" SelectCommand="SELECT [ShiftID], [ShiftName], [Abberivation] FROM [Admin_Shift]" InsertCommand="INSERT INTO Admin_Shift(ShiftName, Description, Abberivation) VALUES (@ShiftName, @Description, @Abberivation)" ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>">
                            <InsertParameters>
                              <asp:ControlParameter ControlID="TextBoxShiftName" Name="ShiftName" PropertyName="Text" />
                              <asp:ControlParameter ControlID="TextBoxDescription" Name="Description" PropertyName="Text" />
                              <asp:ControlParameter ControlID="TextBoxAbb" Name="Abberivation" PropertyName="Text" />
                            </InsertParameters>
                          </asp:SqlDataSource>
                        </td>
                      </tr>
                 </table></td>
                </tr>
                
        </table></td>
          </tr>
   </table></td>
    <td width="32" valign="top" class="right_border" ><img src="../images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  
  <tr>
    <td colspan="3" valign="top" style="height: 29px"><img src="../images1/img_border_bottom.gif" width="1003" height="24" /></td>
  </tr>
</table>
</form>
</body>
</html>
