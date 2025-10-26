<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Nursing_Duty_Roster, App_Web_eqmkimbh" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



<div class="bxmain">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form" id="TABLE1" >
                        
                        <tr>
                            <td align="right"   width="40%" style="height: 18px" >
                                Start From :</td>
                            <td style="width: 697px; height: 18px"    >

                          <igsch:webdatechooser id="WebDateChooser1" runat="server" CssClass="drop_date" width="202px">
                                    <AutoPostBack ValueChanged="True" />
                                    <CalendarLayout Culture="English (United Kingdom)">
                                    </CalendarLayout>
                                </igsch:webdatechooser>
                                <asp:TextBox ID="TextBox_Days" runat="server" AutoPostBack="True" MaxLength="2" Width="19px">00</asp:TextBox>
                            </td>
      </tr>
                        <tr>
                            <td align="right" style="height: 18px"   >
                                &nbsp;End Date :</td>
                            <td style="width: 697px; height: 18px;"   >
                                &nbsp;
                                <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True" RepeatDirection="Horizontal"
                                    Width="99px" CausesValidation="True">
                                    <asp:ListItem Value="0" Selected="True">Configured</asp:ListItem>
                                    <asp:ListItem Value="1">Normal</asp:ListItem>
                                </asp:RadioButtonList>
                                <igsch:webdatechooser id="Webdatechooser2" runat="server" CssClass="drop_date" width="202px">
                                    <AutoPostBack ValueChanged="True" />
                                    <CalendarLayout Culture="English (United Kingdom)">
                                    </CalendarLayout>
                                </igsch:WebDateChooser>
                            </td>
                        </tr>
                          <tr>
                            <td align="right" >Department Name :</td>
                        <td style="width: 697px"   >
                          <asp:DropDownList ID="DropDownListDepartment" runat="server" Width="200px" AutoPostBack="True"  DataSourceID="SqlDataSource_Dept" DataTextField="Dept_Name" DataValueField="Dept_ID"> </asp:DropDownList>
                        </td>
                      </tr>
                          <tr>
                              <td align="right" style="height: 18px">Sub Department Name :</td>
                            <td style="width: 697px; height: 18px;" >
                              <asp:DropDownList ID="DropDownListSubDepartment" runat="server" Width="200px" AutoPostBack="True"  DataSourceID="SqlDataSourceSubDepartment" DataTextField="SubDept_Name" DataValueField="SubDept_Id"> </asp:DropDownList>
                                <asp:DropDownList ID="DropDownList_Ward" runat="server" DataSourceID="SqlDataSourceSaveInfo"
                                    DataTextField="Ward_Name" DataValueField="Ward_id" AutoPostBack="True">
                                </asp:DropDownList></td>
                          </tr>
                          <tr>
                            <td align="right"  style="width: 375px; height: 25px; text-align: right;" >
                                Nursing Shifts :&nbsp; </td>
                            <td style="width: 697px"   ><asp:DropDownList ID="DropDownListShiftName" runat="server" Width="200px" Css DataSourceID="SqlDataSource_Shift" DataTextField="ShiftName" DataValueField="Duty_Roster_ID" AutoPostBack="True"> </asp:DropDownList>
                                <asp:DropDownList ID="DropDownList_Dsgn" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_Desgn"
                                    DataTextField="Designation_Name" DataValueField="Designation_ID">
                                </asp:DropDownList>
                                <asp:GridView ID="GridView_Rules" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_Config">
                                    <Columns>
                                        <asp:BoundField DataField="Designation_Name" HeaderText="Designation_Name" SortExpression="Designation_Name" />
                                        <asp:BoundField DataField="ShiftName" HeaderText="ShiftName" SortExpression="ShiftName" />
                                        <asp:TemplateField HeaderText="Days" SortExpression="Days">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Days") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                &nbsp;<asp:TextBox ID="TextBox_Shift_Days" runat="server" MaxLength="2" Text='<%# Bind("Days") %>'
                                                    Width="42px"></asp:TextBox>
                                                <asp:HiddenField ID="HiddenField_Shift_id" runat="server" Value='<%# Eval("Shift_id") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Off_Days" SortExpression="Off_Days">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Off_Days") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                &nbsp;<asp:TextBox ID="TextBox_Off_Days" runat="server" MaxLength="2" Text='<%# Bind("Off_Days") %>'
                                                    Width="42px"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="CheckBox_Rules" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                &nbsp;
                                <asp:SqlDataSource ID="SqlDataSource_Desgn" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                    SelectCommand="SELECT distinct Designation.Designation_Name,Designation.Designation_ID FROM Admin_Nurse_Roster_Config INNER JOIN Designation ON Admin_Nurse_Roster_Config.Dsgn_id = Designation.Designation_ID">
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSource_Config" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                    SelectCommand="Select_NurseDutyRoster_DsgnWise" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DropDownList_Dsgn" Name="Dsgn_id" PropertyName="SelectedValue"
                                            Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                          </tr>

                          <tr>
                            <td align="right"   >Day of Week :</td>
                          <td valign="top" style="width: 697px"  >
                                <asp:CheckBoxList ID="CheckBoxList_Day" runat="server" DataSourceID="SqlDataSourceDayofWeek"
                                    DataTextField="Day_Name" DataValueField="Day_ID" RepeatColumns="3" RepeatDirection="Horizontal"
                                    Width="100%">
                                </asp:CheckBoxList></td>
                          </tr>
                          <tr>
                            <td align="right" style="height: 18px"   >Employee Name :</td>
                            <td valign="top" style="width: 697px; height: 18px"  >
                                &nbsp;<asp:CheckBoxList ID="CheckBoxList_Emp" runat="server" DataSourceID="SqlDataSourceEmployeeName"
                                  DataTextField="empolyeeName" DataValueField="EmpID" RepeatColumns="3" RepeatDirection="Horizontal"
                                  Width="100%">
                              </asp:CheckBoxList></td>
                            </tr>
                            <tr>
                                <td align="right" style="height: 18px"    >&nbsp;                                     </td>
                                <td style="width: 697px; height: 18px"  >
                                    <asp:Button ID="ButtonSave" runat="server" Text="Save"  />

                                    <asp:LinkButton CssClass="login_link" ID="LinkButton1" runat="server" Visible="False">Show All Shift</asp:LinkButton>
                                    </td>
                            </tr>
  </table></div><br />
<asp:GridView ID="GridView_Emp_Shift" runat="server" AllowPaging="True" AutoGenerateColumns="False" AutoGenerateDeleteButton="True" CssClass="Grid_1" DataKeyNames="Emp_Duty_Roster" DataSourceID="SqlDataSource_Emp_Shift" Width="100%">
                          <Columns>
                          <asp:BoundField DataField="EMPLOYEE_NAME" HeaderText="Employee Name" ReadOnly="True"
                        SortExpression="EMPLOYEE_NAME" />
                          <asp:BoundField DataField="ShiftName" HeaderText="Shift Name" SortExpression="ShiftName" />
                              <asp:BoundField DataField="Ward_Name" HeaderText="Ward_Name" SortExpression="Ward_Name" />
                              <asp:BoundField DataField="StartDuty_Date" HeaderText="Date" SortExpression="StartDuty_Date" />
                              <asp:BoundField DataField="ENDDuty_Date" HeaderText="Shift End On" SortExpression="ENDDuty_Date" />
                              <asp:TemplateField Visible="False">
                                  <ItemTemplate>
                                      <asp:LinkButton ID="LinkButton2" runat="server" CommandArgument='<%# Eval("Emp_Duty_Roster") %>'>Delete</asp:LinkButton>
                                  </ItemTemplate>
                              </asp:TemplateField>
                          </Columns>
                          <RowStyle CssClass="GridItem" />
                          <HeaderStyle CssClass="GridHeader" />                        
                          <AlternatingRowStyle CssClass="GridAltItem" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource_Emp_Shift" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="Select_Employee_Shift" DeleteCommand="DELETE FROM Admin_Employee_Duty_Roster WHERE (Emp_Duty_Roster = @Emp_Duty_Roster)" SelectCommandType="StoredProcedure">
                          <SelectParameters>
                              <asp:ControlParameter ControlID="DropDownListDepartment" Name="DeptID" PropertyName="SelectedValue" />
                              <asp:ControlParameter ControlID="DropDownListSubDepartment" Name="SubDeptId" PropertyName="SelectedValue" />
                              <asp:ControlParameter ControlID="DropDownListShiftName" Name="Duty_Roster_ID" PropertyName="SelectedValue" />
                              <asp:Parameter DefaultValue="0" Name="Ward_Id" Type="Int32" />
                          </SelectParameters>
                          <DeleteParameters>
                              <asp:ControlParameter ControlID="HiddenField_DutyRosterID" Name="Emp_Duty_Roster" PropertyName="Value" />
                          </DeleteParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSource_Dept" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="Select_Dept" SelectCommandType="StoredProcedure"> </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Shift" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT Admin_Shift.ShiftName, Admin_DutyRoster.Duty_Roster_ID, Admin_DutyRoster.DeptID, Admin_DutyRoster.SubDeptId FROM Admin_DutyRoster INNER JOIN Admin_Shift ON Admin_DutyRoster.Shift_ID = Admin_Shift.ShiftID WHERE (Admin_DutyRoster.DeptID = @DeptID) AND (Admin_DutyRoster.SubDeptId = @SubDeptId)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListDepartment" Name="DeptID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownListSubDepartment" Name="SubDeptId" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    &nbsp;
                        <asp:SqlDataSource ID="SqlDataSourceSubDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="SELECT SubDept_Name, SubDept_Id FROM SubDepartment WHERE (Dept_Id = @Deptid)">
                          <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownListDepartment" Name="Deptid" PropertyName="SelectedValue" />
                          </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSourceEmployeeName" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="SELECT     Employee.EmpID, ISNULL(Employee.Prefix, ' ') + ' ' + ISNULL(Employee.EFName, ' ') + ' ' + ISNULL(Employee.EMName, ' ') + ' ' + ISNULL(Employee.ELName, ' ') &#13;&#10;                      + ' (' + Designation.Designation_Name + ') ' AS empolyeeName, Employee.DeptID, Employee.SubDeptId&#13;&#10;FROM         Employee INNER JOIN&#13;&#10;                      Designation ON Employee.DesignationID = Designation.Designation_ID&#13;&#10;WHERE     (Employee.EmpID NOT IN&#13;&#10;                          (SELECT     Emp_ID&#13;&#10;                            FROM          Admin_Employee_Duty_Roster&#13;&#10;                            WHERE     (convert(varchar, Duty_Start_Date, 103) = @Date_Start) AND (convert(varchar, Duty_End_Date , 103)= @Date_End))) AND (Employee.DeptID = 183) AND (Employee.SubDeptId = 182)">
                          <SelectParameters>
                              <asp:ControlParameter ControlID="HiddenField_Date_Start" Name="Date_Start" PropertyName="Value" />
                              <asp:ControlParameter ControlID="HiddenField_Date_End" Name="Date_End" PropertyName="Value" />
                          </SelectParameters>
                        </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_DutyRosterID" runat="server" />
    &nbsp;&nbsp;
                        <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" InsertCommand="INSERT INTO Admin_Employee_Duty_Roster(Duty_Roster_ID, Emp_ID, Duty_Start_Date, Duty_End_Date, Week_Day,Ward_Id) VALUES (@Duty_Roster_ID, @Emp_ID, @Start_Duty_Date, @Duty_End_Date, @Week_Day,@Ward_id)" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="Select_Hospital_Wards" SelectCommandType="StoredProcedure">
                          <InsertParameters>
                              <asp:ControlParameter ControlID="HiddenField_Shift_Id" Name="Duty_Roster_ID" PropertyName="Value" />
                              <asp:ControlParameter ControlID="HiddenField_Emp_ID" Name="Emp_ID" PropertyName="Value" />
                              <asp:ControlParameter ControlID="HiddenField_Date_Start" Name="Start_Duty_Date" PropertyName="Value" DbType="DateTime" />
                              <asp:ControlParameter ControlID="HiddenField_Date_End" Name="Duty_End_Date" PropertyName="Value" DbType="DateTime" />
                              <asp:ControlParameter ControlID="HiddenField_WeekDay" Name="Week_Day" PropertyName="Value" />
                              <asp:ControlParameter ControlID="DropDownList_Ward" Name="Ward_id" PropertyName="SelectedValue" />
                          </InsertParameters>
                            <SelectParameters>
                                <asp:SessionParameter Name="Hospital_id" SessionField="HospitalID" Type="Int32" />
                                <asp:ControlParameter ControlID="DropDownListDepartment" Name="dept_id" PropertyName="SelectedValue"
                                    Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSourceDayofWeek" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                InsertCommand="INSERT INTO emp_DutyShift(ShiftName, StartTime, EndTime, DeptID, SubDeptId,Ward_Id) VALUES (@ShiftName, @StartTime, @EndTime, @DeptID, @SubDeptId,@Ward_Id) "
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="SELECT Day_Name, Day_ID FROM Week_Day">
                          <InsertParameters>
                            <asp:ControlParameter ControlID="TextBoxShiftName" Name="ShiftName" PropertyName="Text" />
                            <asp:ControlParameter ControlID="HiddenFieldStartTime" Name="StartTime" PropertyName="Value" />
                            <asp:ControlParameter ControlID="HiddenFieldToTime" Name="EndTime" PropertyName="Value" />
                            <asp:ControlParameter ControlID="DropDownListDepartment" Name="DeptID" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="DropDownListSubDepartment" Name="SubDeptId" PropertyName="SelectedValue" />
                              <asp:ControlParameter ControlID="DropDownList_Ward" Name="Ward_Id" PropertyName="SelectedValue" />
                          </InsertParameters>
                        </asp:SqlDataSource>
                        <asp:HiddenField ID="HiddenFieldFlag" runat="server" />
                            <asp:SqlDataSource ID="SqlDataSource_Emp" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                SelectCommand="SELECT Employee.EmpID, ISNULL(Employee.Prefix, ' ') + ' ' + ISNULL(Employee.EFName, ' ') + ' ' + ISNULL(Employee.EMName, ' ') + ' ' + ISNULL(Employee.ELName, ' ') + ' (' + Designation.Designation_Name + ') ' AS empolyeeName, Employee.DeptID, Employee.SubDeptId FROM Employee INNER JOIN Designation ON Employee.DesignationID = Designation.Designation_ID WHERE (Employee.DeptID = 94) ORDER BY Designation.Designation_ID">
                            </asp:SqlDataSource>
                            <asp:HiddenField ID="HiddenField_Emp_ID" runat="server" />
                            <asp:HiddenField ID="HiddenField_WeekDay" runat="server" />
    <asp:HiddenField ID="HiddenField_Shift_Id" runat="server" />
                            <asp:HiddenField ID="HiddenField_Date_End" runat="server" />
                            <asp:HiddenField ID="HiddenField_Date_Start" runat="server" />
  </asp:Content>