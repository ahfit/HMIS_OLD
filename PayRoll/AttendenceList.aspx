
<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AttendenceList.aspx.vb"
    MasterPageFile="~/hacims_masterpage_admin.master" Inherits="AttendenceList" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1
        {
            height: 48px;
        }
        .style2
        {
            width: 235px;
            height: 48px;
        }
        .style3
        {
            width: 239px;
        }
        .style4
        {
            width: 239px;
            height: 48px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <div class="bxmain">
            <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
                <tr>
                    <td align="right">
                        Hospital :
                    </td>
                    <td>
                        <asp:DropDownList ID="DropdownlistHospital" runat="server" DataSourceID="SqlDataSourceHospital"
                            DataTextField="Hospital_Name" DataValueField="Hospital_ID" TabIndex="5" Width="220px"
                            AutoPostBack="True">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSourceHospital" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                            SelectCommand="
 SELECT DISTINCT Hospital_ID, Hospital_Name
FROM            Hospital order by Hospital_Name ">
                            <SelectParameters>
                              
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sqlDs_SalaryDates" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
                            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="Select Hospital_ID,Salary_Start_Day,Last_Month_Date
From Hospital_Setting Where Hospital_ID = @Hospital_ID">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="DropdownlistHospital" Name="Hospital_ID" 
                                    PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                    <td align="right">
                        Department :
                    </td>
                    <td>
                        <asp:DropDownList ID="Dropdownlistdepartment" runat="server" DataSourceID="SqlDataSourceDepartment"
                            DataTextField="Dept_Name" DataValueField="Dept_ID" TabIndex="5" Width="220px" >
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                            SelectCommand="select '---All---' as Dept_Name,0 as Dept_ID union
SELECT     Department.Dept_Name + ' ( ' + Hospital.Hospital_Abb + ' ) ' Dept_Name, Department.Dept_ID 
FROM         Department Left Outer JOIN
                      Hospital ON Department.Hospital_ID = Hospital.Hospital_ID 
                      where  (@HospitalID =0 or Department.Hospital_ID = @HospitalID)
                      ORDER BY [Dept_Name]">
                            <SelectParameters>
                                
                                <asp:ControlParameter ControlID="DropdownlistHospital" Name="HospitalID" 
                                    PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td width="25%" align="right">
                        Month :</td>
                    <td class="style3">
                        <asp:DropDownList ID="ddlMonths" runat="server" DataSourceID="sqlDs_Months" 
                            DataTextField="Month_Name" DataValueField="Month_No" AutoPostBack="True">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sqlDs_Months" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
                            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" 
                            SelectCommand="SELECT Month_No,Month_Name FROM Year_Months"></asp:SqlDataSource>
                    </td>
                    <td width="25%" align="right">
                        &nbsp;</td>
                    <td width="25%">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td width="25%" align="right">
                        Salary Start Date :
                    </td>
                    <td class="style3">
                        <igsch:WebDateChooser ID="WebDateChooser_Start_Date" runat="server" Width="220px">
                      </igsch:WebDateChooser>
                    </td>
                    <td width="25%" align="right">
                        End Date :
                    </td>
                    <td width="25%">
                        <igsch:WebDateChooser ID="WebDateChooser_end_Date" runat="server" Width="220px">
                      </igsch:WebDateChooser>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Attendance Start Date :
                    </td>
                    <td class="style3">
                        <igsch:WebDateChooser ID="WebdatechooserAttendanceDate" runat="server" Width="220px">
                    </igsch:WebDateChooser>
                        <asp:Label ID="Label_Alert" runat="server" ForeColor="#FF3300" Text="Must be between Start Date and End Date"
                            Visible="False"></asp:Label>
                    </td>
                    <td align="right">
                        Attendance End Date :</td>
                    <td>
                        <igsch:WebDateChooser ID="WebdatechooserAttendanceEDate" runat="server" 
                            Width="220px">
                    </igsch:WebDateChooser>
                        </td>
                </tr>
                <tr style = "display:none">
                    <td align="right">
                        &nbsp;</td>
                    <td class="style3">
                        <asp:TextBox ID="TextBox_Holydays" runat="server" Width="45px">0</asp:TextBox>
                        <br />
                        <asp:TextBox ID="TextBox_TCPHolyDat" runat="server" Width="45px" AutoPostBack="True">0</asp:TextBox>
                        <asp:TextBox ID="TextBox_Totaldays" runat="server" Width="45px">0</asp:TextBox>
                    </td>
                    <td align="right">
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr style="display:none;">
                    <td align="right">
                    </td>
                    <td class="style3">
                        &nbsp;
                    </td>
                    <td align="right">
                        Days ( After Attendance Date ) :
                    </td>
                    <td>
                        <asp:TextBox ID="TextBox_AfterAttendance" runat="server" Width="45px">0</asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        &nbsp;
                    </td>
                    <td class="style3">
                        &nbsp;
                    </td>
                    <td align="right">
                        Month Days
                    </td>
                    <td>
                        <asp:TextBox ID="txtMonthDays" Width="45px" Text="0" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        &nbsp;
                    </td>
                    <td class="style3">
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource_shift_type"
                            DataTextField="Shift" DataValueField="Shift_ID" TabIndex="5" Width="202px" Visible="False">
                        </asp:DropDownList>
                        <asp:DropDownList ID="DropDownList_desg" runat="server" DataSourceID="SqlDataSource_desg"
                            DataTextField="Designation_Name" DataValueField="Designation_ID" TabIndex="5"
                            Width="202px" Visible="False">
                        </asp:DropDownList>
                    </td>
                    <td align="right">
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="4" align="center" style="height: 26px">
                        <br />
                        <asp:Button ID="Button1" runat="server" Text="Search" Style="height: 26px" />
                        <asp:Button ID="Button_Calc" runat="server" Text="Calculate" />
                        <asp:Button ID="Button_Save" runat="server" Text="Save" />
                        <asp:Label ID="Label_Mesg" runat="server" ForeColor="#009933" Visible="False"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" align="center" style="height: 26px">
                        <asp:RadioButtonList ID="RadioButtonList_EmployeeType" runat="server" DataSourceID="SqlDataSource_EmployeeType"
                            DataTextField="Type" DataValueField="Employee_Type_ID" RepeatDirection="Horizontal"
                            Width="198px" Visible="False">
                        </asp:RadioButtonList>
                        <asp:RadioButtonList ID="RadioButtonList_DesgType" runat="server" RepeatDirection="Horizontal"
                            Visible="False">
                            <asp:ListItem Selected="True" Value="Officer">Officer</asp:ListItem>
                            <asp:ListItem Value="Staff">Staff</asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:SqlDataSource ID="SqlDataSource_EmployeeType" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                            SelectCommand="SELECT Employee_Type_ID, Type FROM Employee_Type"></asp:SqlDataSource>
                    </td>
                </tr>
            </table>
        </div>
        <br />
        <br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" CancelSelectOnNullParameter="False"
            ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" SelectCommand="Attendence_Detail"
            SelectCommandType="StoredProcedure" InsertCommand="usp_SaveEmployeeAttendance"
            InsertCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="HiddenField_Start_Date" Name="start_Date" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_end_Date" Name="end_Date" 
                    PropertyName="Value" />
                <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="Dept_ID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="DropDownList_desg" Name="Designation" PropertyName="SelectedValue"
                    DefaultValue="0" />
                <asp:ControlParameter ControlID="DropDownList1" Name="Shift_ID" PropertyName="SelectedValue"
                    DefaultValue="0" />
                <asp:ControlParameter ControlID="RadioButtonList_EmployeeType" Name="Emp_Type" PropertyName="SelectedValue"
                    Type="Int32" />
                <asp:ControlParameter ControlID="RadioButtonList_DesgType" Name="Designation_Type"
                    PropertyName="SelectedValue" Type="String" />
                <asp:ControlParameter ControlID="DropdownlistHospital" Name="hospitalId" PropertyName="SelectedValue"
                    Type="Int32" />
                <asp:SessionParameter Name="Admin_ID" SessionField="emp_id" Type="Int32" />
                <asp:ControlParameter ControlID="HiddenField_AttendanceDate" Name="Astart_Date" 
                    PropertyName="Value" Type="String" />
                <asp:Parameter Name="Aend_Date" Type="String" />
            </SelectParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="HiddenField_Emp_ID" Name="Emp_ID" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_month" Name="Salary_Month" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_year" Name="Salary_Year" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_Machine_Attendance" Name="Machine_Attendance"
                    PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_Other_Attendance" Name="Other_Attendance"
                    PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_Deducted" Name="Deducted" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_Leave" Name="Leave" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_Over_Time" Name="Over_Time" PropertyName="Value" />
                <asp:ControlParameter ControlID="TextBox_Holydays" Name="Holy_day" PropertyName="Text" />
                <asp:ControlParameter ControlID="TextBox_Totaldays" Name="Working_Day" PropertyName="Text" />
                <asp:ControlParameter ControlID="TextBox_TCPHolyDat" Name="Public_Holy_Day" PropertyName="Text" />
                <asp:ControlParameter ControlID="HiddenField_Start_Date" Name="From_date" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_end_Date" Name="To_date" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_AttendanceDate" Name="Attendance_End_Date"
                    PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_SalaryDays" Name="Salary_Days" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_PreDaysDeducted" Name="Pre_Deduction_Days"
                    PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_PreMinutes" Name="Pre_Late_Min" PropertyName="Value" />
                <asp:ControlParameter ControlID="TextBox_AfterAttendance" Name="Advance_Pay_Days"
                    PropertyName="Text" />
                <asp:ControlParameter ControlID="HiddenField_late_Comming" Name="late_Comming" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_Remarks" Name="Remarks" PropertyName="Value" />
                <asp:ControlParameter ControlID="txtMonthDays" Name="Month_Days" PropertyName="Text" />
            </InsertParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="HiddenField_Machine_Attendance" Name="Machine_Attendance"
                    PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_Other_Attendance" Name="Other_Attendance"
                    PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_Deducted" Name="Deducted" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_Leave" Name="Leave" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_Over_Time" Name="Over_Time" PropertyName="Value" />
                <asp:ControlParameter ControlID="TextBox_Holydays" Name="Holy_day" PropertyName="Text" />
                <asp:ControlParameter ControlID="TextBox_Totaldays" Name="Working_Day" PropertyName="Text" />
                <asp:ControlParameter ControlID="TextBox_TCPHolyDat" Name="Public_Holy_Day" PropertyName="Text" />
                <asp:ControlParameter ControlID="HiddenField_Start_Date" Name="From_date" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_end_Date" Name="To_date" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_AttendanceDate" Name="Attendance_End_Date"
                    PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_SalaryDays" Name="Salary_Days" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_PreDaysDeducted" Name="Pre_Deduction_Days"
                    PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_PreMinutes" Name="Pre_Late_Min" PropertyName="Value" />
                <asp:ControlParameter ControlID="TextBox_AfterAttendance" Name="Advance_Pay_Days"
                    PropertyName="Text" />
                <asp:ControlParameter ControlID="HiddenField_late_Comming" Name="late_Comming" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_Emp_ID" Name="Emp_ID" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_month" Name="Salary_Month" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_year" Name="Salary_Year" PropertyName="Value" />
                <asp:ControlParameter ControlID="txtMonthDays" Name="Month_Days" PropertyName="Text" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
            DataSourceID="SqlDataSource1" Style="direction: ltr;" PageSize="28" Width="100%">
            <FooterStyle CssClass="GridPager" />
            <Columns>
                <asp:TemplateField HeaderText="Sr No.">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1%>
                    </ItemTemplate>
                    <ItemStyle Width="38px" />
                </asp:TemplateField>
                <asp:BoundField DataField="Emp_ID" HeaderText="Emp ID" SortExpression="Emp_ID" />
                <asp:BoundField DataField="EFName" HeaderText="Name" SortExpression="EFName" />
                <asp:BoundField DataField="Designation_Name" HeaderText="Desig." ReadOnly="True"
                    SortExpression="Designation_Name" />
                <asp:BoundField DataField="Dept_Name" HeaderText="Dept." ReadOnly="True" SortExpression="Dept_Name" />
                <asp:BoundField DataField="Shift_ID" HeaderText="Shift_ID" SortExpression="Shift_ID"
                    Visible="False" />
                <asp:BoundField DataField="Machine_Attendance" HeaderText="M. Atten." ReadOnly="True"
                    SortExpression="Machine_Attendance" />
                    <asp:TemplateField HeaderText="Holidays" SortExpression="Holidays">
                        <ItemTemplate>
                            <asp:Label ID="lbl_Holidays" runat="server" Text='<%# Bind("Holidays") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Eval("Holidays") %>'></asp:Label>
                        </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Oth. Atten." Visible="false" SortExpression="Other_Attendance">
                    <EditItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Eval("Other_Attendance") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("Other_Attendance") %>' Visible="False"></asp:Label>
                        <asp:TextBox ID="TextBox_Oth_Att" runat="server" Width="29px" 
                            AutoPostBack="True" ontextchanged="TextBox_Oth_Att_TextChanged">0</asp:TextBox>                        
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:BoundField DataField="Minute_Deduct" HeaderText="Deducted (min)" 
                    ReadOnly="True" SortExpression="Minute_Deduct" Visible="False" />
                <asp:TemplateField HeaderText="Leave Encash" SortExpression="Leave_Enchashment">
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Leave_Enchashment") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Leave_Enchashment") %>' Visible="False"></asp:Label>
                        <asp:TextBox ID="TextBox_Leave" runat="server" Text='<%# Bind("Leave_Enchashment", "{0}") %>'
                            Width="34px" AutoPostBack="True" ontextchanged="TextBox_Leave_TextChanged"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Over Time" SortExpression="Over_Time"  Visible="false" >
                    <EditItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("Over_Time") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Over_Time") %>' Visible="False"></asp:Label>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Over_Time") %>' 
                            Width="36px" AutoPostBack="True"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Pre. Deduction"  Visible="false" >
                    <ItemTemplate>
                        <asp:TextBox ID="TextBox_Pre_Leave" runat="server" Width="38px" 
                            AutoPostBack="True">0</asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Pre. Min"  Visible="false" >
                    <ItemTemplate>
                        <asp:TextBox ID="TextBox_Pre_Min" runat="server" Width="38px">0</asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="LWP" Visible="False">
                    <ItemTemplate>
                        <asp:TextBox ID="txtLWP" runat="server" Width="38px" Text='<%# Bind("LWP") %>'></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Salary Days">
                    <ItemTemplate>
                        <asp:TextBox ID="TextBox_SalaryDays"  runat="server" AutoPostBack="true" Text='<%#Eval("Salary_Days") %>'
                            Width="38px" OnTextChanged ="TextBox_SalaryDays_TextChanged1" ></asp:TextBox>
                        <asp:HiddenField ID="HiddenField_DESIG_ID" runat="server" />
                        <asp:HiddenField ID="HiddenField_DEPT_ID" runat="server" />
                        <asp:HiddenField ID="HiddenField_SUBDEPT_ID" runat="server" />
                        <asp:HiddenField ID="HiddenField_OA" runat="server" Value='<%# Eval("Other_Attendance") %>' />
                        <asp:HiddenField ID="HiddenField_emp_ID" runat="server"  Value='<%# Eval("Emp_ID", "{0}") %>' />
                        <asp:HiddenField ID="HiddenField_late_Comming" runat="server" Value='<%# Eval("Late_Coming_Days", "{0}") %>' />
                        <asp:HiddenField ID="HiddenFieldMachine_att" runat="server" Value='<%# Eval("Machine_Attendance", "{0}") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Remarks">
                    <ItemTemplate>
                        <asp:TextBox ID="txtRemarks" runat="server" Text='<%#Eval("Remarks") %>' TextMode="MultiLine"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Sys_cal" HeaderText="System Calculation" 
                    SortExpression="Sys_cal" />
            </Columns>
            <RowStyle CssClass="GridItem" />
            <PagerStyle CssClass="GridPager" />
            <HeaderStyle CssClass="GridHeader" />
            <AlternatingRowStyle CssClass="GridAltItem" />
        </asp:GridView>
        <asp:HiddenField ID="HiddenField_late_Comming" runat="server" />
        <asp:HiddenField ID="HiddenField_CurrntDesigID" runat="server" />
        <asp:HiddenField ID="HiddenField_CurrntDeptId" runat="server" />
        <asp:HiddenField ID="HiddenField_CurrntSubDeptId" runat="server" />
        <asp:HiddenField ID="HiddenField_Remarks" runat="server" />
        <asp:HiddenField ID="HF_Status" runat="server" Value = "0" />
        <br />
        <asp:SqlDataSource ID="SqlDataSource_desg" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            SelectCommand="SELECT [Designation_ID], [Designation_Name] FROM [Designation]">
        </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenField_CNIC" runat="server" />
        <asp:HiddenField ID="HiddenField_TWorkingDays" runat="server" Value="0" />
        <asp:SqlDataSource ID="SqlDataSource_shift_type" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            SelectCommand="SELECT [Shift_ID], [Shift], [Abb_Shift] FROM [Shift]"></asp:SqlDataSource>
        <asp:HiddenField ID="HiddenField_Start_Date" runat="server" />
        <asp:HiddenField ID="HiddenField_end_Date" runat="server" />
        <asp:HiddenField ID="HiddenField_Dept_ID" runat="server" />
        <asp:HiddenField ID="HiddenField_Emp_ID" runat="server" />
        <asp:HiddenField ID="HiddenField_Machine_Attendance" runat="server" />
        <asp:HiddenField ID="HiddenField_Other_Attendance" runat="server" />
        <asp:HiddenField ID="HiddenField_Deducted" runat="server" />
        <asp:HiddenField ID="HiddenField_Leave" runat="server" />
        <asp:HiddenField ID="HiddenField_Over_Time" runat="server" />
        <asp:HiddenField ID="HiddenField_month" runat="server" />
        <asp:HiddenField ID="HiddenField_year" runat="server" />
        <asp:HiddenField ID="HiddenField_PreDaysDeducted" runat="server" />
        <asp:HiddenField ID="HiddenField_SalaryDays" runat="server" />
        <asp:HiddenField ID="HiddenField_AttendanceDate" runat="server" />
        <asp:HiddenField ID="HiddenField_PreMinutes" runat="server" />
        <br />
        <br />
    </div>
</asp:Content>
