<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Administrator_Admin_Doctor_Time_Slice, App_Web_xjzmobwq" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">




                    
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
   
<div class="bxmain">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form" >
    <tr>
        <td align="left" colspan="2">
            <asp:Label ID="Label_Note" runat="server" Font-Bold="True" ForeColor="Red" Text="Sechedule already set for some day from Selected Date."
                Visible="False"></asp:Label></td>
    </tr>
                           
    <tr>
        <td align="right" width="40%" style="height: 18px"  >
             Doctor : </td>
        <td width="60%" style="height: 18px" >
                                  <asp:DropDownList   DataTextField="Name" DataValueField="EmpID" ID="DropDownListDoctor_id" runat="server"  DataSourceID="SqlDataSourceDoctor" TabIndex="7" AutoPostBack="True" Width="217px"> </asp:DropDownList>        </td>
      </tr>
    <tr>
        <td align="right" width="40%" >
            Schedule Start From :
        </td>
        <td width="60%" >
            <igsch:WebDateChooser ID="WebDateChooser_St_Date" runat="server" Value="" CssClass="drop_date" width="202px">
                <AutoPostBack ValueChanged="True" />
            </igsch:WebDateChooser>
        </td>
    </tr>
    <tr>
        <td align="right"  >
             Start Time : </td>
        <td  >
            <igtxt:webdatetimeedit id="WebDateTimeEditStartTime" runat="server" editmodeformat="t" DisplayModeFormat="t"  TabIndex="9" Width="199px">
                            </igtxt:WebDateTimeEdit>
        </td>
      </tr>
    <tr>
      <td align="right" style="height: 18px"  >End Time : </td>
      <td style="height: 18px"  ><igtxt:webdatetimeedit id="WebdatetimeeditEndTime" runat="server" editmodeformat="t" DisplayModeFormat="t"  TabIndex="9" Width="199px" AutoPostBack="True">
                              </igtxt:WebDateTimeEdit>
          <asp:Label ID="Label_Time" runat="server" Text="Tim in Minutes" Width="145px"></asp:Label></td>
    </tr>
    <tr>
        <td align="right"  >
             For Day : </td>
        <td  >
            <asp:CheckBoxList ID="CheckBoxList_ForDay" runat="server" DataSourceID="SqlDataSource_ForDay"
                DataTextField="Day_Name" DataValueField="Day_ID" RepeatDirection="Horizontal">
            </asp:CheckBoxList></td>
    </tr>
                          <tr>
                            <td align="right"  >  Avg Patient Per Day :   </td>
                              <td    >
                                  <asp:TextBox ID="TextBox_AvgPatient"  Width="100px" runat="server" AutoPostBack="True" MaxLength="3"></asp:TextBox></td>
                            </tr>
      <tr>
                            <td align="right"  >Time Per Patient : </td>
                            <td  ><asp:TextBox ID="TextBox_TimePerPatient"  Width="100px" runat="server"    TabIndex="1" Enabled="False" ></asp:TextBox>
        (in Min)</td>
      </tr>
      <tr>
        <td align="right"  >Special Patient Appointment :</td>
        <td  ><asp:TextBox ID="TextBox_PatientSpecialAppointment"  Width="100px"  runat="server"></asp:TextBox></td>
      </tr>
    <tr>
        <td align="right">
            Consultant Sub Department :</td>
        <td>
            <asp:DropDownList ID="ddlSubDepartment" runat="server" DataSourceID="SQL_Subdepartment"
                DataTextField="SubDept_Name" DataValueField="SubDept_Id">
            </asp:DropDownList></td>
    </tr>
      <tr>
        <td align="right"  >&nbsp;</td>
        <td  ><asp:Button ID="ButtonSave" runat="server"  Text="Save" /></td>
      </tr>
              </table>
              
              </div>
 
    <asp:HiddenField ID="HiddenField_Admin_Doctor_Time_ID" runat="server" />
     
<asp:SqlDataSource ID="SqlDataSource_ForDay" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT Day_Name, Day_ID FROM Week_Day"></asp:SqlDataSource>
                        
                        <br />
<asp:GridView ID="GridView_Schedule" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
                DataSourceID="SqlDataSourceSaveInfo" Width="100%" DataKeyNames="Admin_Doctor_Time_ID">
                <Columns>
                    <asp:BoundField DataField="Doctor Name" HeaderText="Doctor Name" SortExpression="Doctor Name" />
                    <asp:BoundField DataField="StartTime" HeaderText="Start Time" SortExpression="StartTime" />
                    <asp:BoundField DataField="EndTime" HeaderText="End Time" SortExpression="EndTime" />
                    <asp:BoundField DataField="Day_Name" HeaderText="Weekday" SortExpression="Day_Name" />
                    <asp:BoundField DataField="Time_Slice_Duration" HeaderText="Time Slice Duration"
                        SortExpression="Time_Slice_Duration" />
                    <asp:BoundField DataField="Admin_Doctor_Time_ID" HeaderText="Admin_Doctor_Time_ID"
                        InsertVisible="False" ReadOnly="True" SortExpression="Admin_Doctor_Time_ID" />
                    <asp:BoundField DataField="SubDept_Name" HeaderText="Sub Dept. Name" SortExpression="SubDept_Name" />
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            &nbsp;<asp:ImageButton ID="ImageButton_Delete" runat="server" CommandName="Delete"
                                ImageUrl="~/images_hacims/icon_delete.gif" OnClientClick="return confirmation(this)"
                                ToolTip="Delete" />
                            <asp:HiddenField ID="HiddenField_App_Fix" runat="server" Value='<%# Eval("app_Fixed") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle CssClass="GridHeader" />
                <AlternatingRowStyle CssClass="GridAltItem" />
            </asp:GridView>
                        
                        
                        
 <asp:SqlDataSource ID="SqlDataSourceDoctor" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" SelectCommand="SELECT ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS Name, Employee.EmpID FROM Employee INNER JOIN Designation ON Employee.DesignationID = Designation.Designation_ID INNER JOIN Department ON Employee.DeptID = Department.Dept_ID WHERE (Department.Hospital_ID = @Hospital_Id) AND (Employee.ActiveStatus = 1) AND (Employee.Is_Consultant = 1) ORDER BY ISNULL(Employee.EFName, '')">
     <SelectParameters>
         <asp:SessionParameter Name="Hospital_Id" SessionField="Hospitalid" />
     </SelectParameters>
    
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldStartTime" runat="server" />
    <asp:HiddenField ID="HiddenFielEndTime" runat="server" />
                        
<asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        InsertCommand="INSERT INTO Admin_Doctor_Time_Slice(Doctor_ID, Time_Slice_Duration, StartTime, EndTime) VALUES (@Doctor_ID, @Time_Slice_Duration, @StartTime, @EndTime)"
        ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" SelectCommand="SELECT     ISNULL(Employee.Prefix, '') + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS [Doctor Name], &#13;&#10;                      Admin_Doctor_Time_Slice.Time_Slice_Duration, CONVERT(varchar, Admin_Doctor_Time_Slice.StartTime, 108) AS StartTime, CONVERT(varchar, &#13;&#10;                      Admin_Doctor_Time_Slice.EndTime, 108) AS EndTime, Week_Day.Day_Name, Admin_Doctor_Time_Slice.Admin_Doctor_Time_ID, ISNULL(c_App_view.app_Fixed, 0) &#13;&#10;                      AS app_Fixed, sd.SubDept_Name&#13;&#10;FROM         Admin_Doctor_Time_Slice INNER JOIN&#13;&#10;                      Employee ON Admin_Doctor_Time_Slice.Doctor_ID = Employee.EmpID INNER JOIN&#13;&#10;                      Week_Day ON Admin_Doctor_Time_Slice.For_Day = Week_Day.Day_ID LEFT OUTER JOIN&#13;&#10;                      SubDepartment AS sd ON Admin_Doctor_Time_Slice.SubDept_ID = sd.SubDept_Id LEFT OUTER JOIN&#13;&#10;                          (SELECT     Doctor_Appointment_Slot.Admin_Doctor_Time_ID, COUNT(Doctor_Appointment_Slot.Slot_Time) AS app_Fixed&#13;&#10;                            FROM          Doctor_Appointment_Slot INNER JOIN&#13;&#10;                                                   Patient_Appointment ON Doctor_Appointment_Slot.Doctor_App_Slot_Id = Patient_Appointment.Doctor_App_Slot_Id&#13;&#10;                            GROUP BY Doctor_Appointment_Slot.Admin_Doctor_Time_ID) AS c_App_view ON &#13;&#10;                      Admin_Doctor_Time_Slice.Admin_Doctor_Time_ID = c_App_view.Admin_Doctor_Time_ID&#13;&#10;WHERE     (Admin_Doctor_Time_Slice.Doctor_ID = @Doctor_ID)" DeleteCommand="[Delete_Doctor_Schedule]" DeleteCommandType="StoredProcedure">
        <InsertParameters>
            <asp:ControlParameter ControlID="DropDownListDoctor_id" Name="Doctor_ID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="TextBoxDuration" Name="Time_Slice_Duration" PropertyName="Text" />
            <asp:ControlParameter ControlID="HiddenFieldStartTime" Name="StartTime" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFielEndTime" Name="EndTime" PropertyName="Value" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListDoctor_id" Name="Doctor_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    <DeleteParameters>
        <asp:ControlParameter ControlID="GridView_Schedule" Name="Admin_Doctor_Time_ID" PropertyName="SelectedValue" />
    </DeleteParameters>
    </asp:SqlDataSource>
    <br />
    <asp:SqlDataSource ID="SQL_Subdepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        SelectCommand="SELECT DISTINCT SubDepartment.SubDept_Name, SubDepartment.SubDept_Id, SubDepartment.SubDept_Type, Employee.EmpID FROM SubDepartment INNER JOIN Employee ON SubDepartment.SubDept_Id = Employee.SubDeptId WHERE (Employee.EmpID = @Emp_ID) ORDER BY SubDepartment.SubDept_Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListDoctor_id" DefaultValue="" Name="Emp_ID"
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <cc1:ListSearchExtender ID="ListSearchExtender1" runat="server" TargetControlID="DropDownListDoctor_id">
    </cc1:ListSearchExtender><br />
<br />

  </asp:Content>