<%@ page language="VB" debug="true" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="PatientAppointmant_box, App_Web_5he23oin" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
.physicians {margin-left:3px; margin-top:3px; margin-right:0px; }
.physicians ul{ list-style:none; margin:0px;  width:100%; }
.physicians li { margin:0px; list-style:none; display:block; margin-top:0px; font-weight:normal; color:#000; text-decoration:none; background:url(../images_hacims/kih_bulletb.png) 0 7px no-repeat;  line-height:16px; padding-left:8px; text-align:left;  }
.physicians  .name {font-size:12px; color:#333; font-weight:bold; background-image:none;  }
.physicians  .profile {background:none; margin-top:0px; color:#7c7c7c; text-align:left; font-size:11px;}
.physicians  .services {  color:#3477d1; text-align:left;}

.txtb {font-weight:bold; color:#114e9a; font-size:11px;}
.redm {color:#d71635; font-weight:bold; font-size:11px;}
.bxinfo_margin {}

.p_boxb { height:27px; width:98%; display:inline-block; padding-left:5px; padding-top:3px;  border:#dddddd solid 1px; background:url(../images_hacims/pbg.png) bottom left repeat-x; -webkit-border-radius: 4px; -moz-border-radius: 4px; border-radius: 4px; behavior: url(PIE.htc); float:left; clear:right; margin-bottom:4px; }

.p_boxb a { color:#0056c5; font-size:11px; }
.p_boxb a:hover { color:#333; }

.p_boxb:hover { background:url(../images_hacims/img_pnamebg.png) bottom left repeat-x;  }

.newapp  { background:url(../images_hacims/plus.png) 0px 2px no-repeat; padding-left:15px;  }




</style>
    <link href="SpryAssets/SpryCollapsiblePanel.css" rel="stylesheet" type="text/css" />

    <script language="javascript" type="application/javascript">
		$(document).ready(function(){
			
			$(".newapp").colorbox({width:"1000px", height:"580px", iframe:true});
 		   $(".newapp").colorbox({
 			
 			onClosed:function(){ window.location.reload(true); }
 		});
				
		});
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:Label ID="Label_Note" runat="server" Font-Bold="True"></asp:Label>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td style="width: 300px; height: 1103px;" valign="top">
                <div class="bx_infos_patients" style="height: 400px;">
                    <h2>
                        <span>Schedules</span></h2>
                    <br />
                    <div>
                        <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                            <tr>
                                <td align="right" style="width: 100px; height: 12px">
                                    Doctor :</td>
                                <td style="width: 100px; height: 12px">
                                    <asp:DropDownList ID="DropDownList_Doctor" runat="server" DataSourceID="SqlDataSource_Doctor_Services"
                                        DataTextField="Doctor" DataValueField="EmpID" Width="154px">
                                    </asp:DropDownList></td>
                            </tr>
                            <tr>
                                <td align="right" style="width: 100px; height: 36px">
                                    Select Date</td>
                                <td style="width: 100px; height: 36px">
                                    <igsch:WebDateChooser ID="WebDateChooser_Date" runat="server">
                                        <CalendarLayout Culture="English (United Kingdom)">
                                        </CalendarLayout>
                                    </igsch:WebDateChooser>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="width: 100px; height: 29px">
                                    Day</td>
                                <td style="width: 100px; height: 29px">
                                    <asp:Label ID="Label_Day" runat="server" Text=" "></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="height: 11px">
                                    <asp:Button ID="Button_Search" runat="server" Text="Search" /></td>
                            </tr>
                        </table>
                        &nbsp;&nbsp; <strong></strong>&nbsp;
                    </div>
                    <br />
                    <div class="bxinfo_margin" style="height: auto; max-height: 340px;">
                        &nbsp;<asp:SqlDataSource ID="SqlDataSource_Doctor_Services" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                            DeleteCommand="DELETE FROM Doctor_Service WHERE (DS_ID = @DS_ID)" ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>"
                            SelectCommand="SELECT DISTINCT &#13;&#10;                      ISNULL(Employee.Prefix, '') + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS Doctor, &#13;&#10;                      Employee.EmpID&#13;&#10;FROM         Employee INNER JOIN&#13;&#10;                      Admin_Doctor_Time_Slice ON Employee.EmpID = Admin_Doctor_Time_Slice.Doctor_ID">
                            <DeleteParameters>
                                <asp:ControlParameter ControlID="GridView1" Name="DS_ID" PropertyName="SelectedValue" />
                            </DeleteParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSource_EmployeeList" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                            ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" SelectCommand="SELECT Employee.EmpID, Employee.Prefix + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ISNULL(Employee.ELName, '') AS EmployeeName, Department.Dept_Name FROM Employee INNER JOIN Department ON Employee.DeptID = Department.Dept_ID ">
                        </asp:SqlDataSource>
                    </div>
                </div>
            </td>
            <td valign="top" style="height: 1103px">
                <div id="doc_patients" class="bx_infos_patients" style="width: 93%; margin-left: 20px;">
                    <asp:DataList ID="DataList_Search" runat="server" DataSourceID="SqlDataSource_DataListSearch"
                        Width="100%" RepeatLayout="Flow" Visible="False">
                        <ItemTemplate>
                            <h2>
                                <span>
                                    <asp:Label ID="Label_Designation" Style="background: none; padding-left: 0; font-weight: bold;"
                                        runat="server" Text='<%# Eval("Designation_Name") %>'></asp:Label>
                                    <asp:Label ID="Label_Name" Style="background: none; padding-left: 0; font-weight: bold;"
                                        runat="server" Text='<%# Eval("name") %>'></asp:Label>&nbsp;<span style="color: #0658a8;
                                            background: none; padding-left: 0;">(
                                            <asp:Label ID="Label_Department" runat="server" Style="background: none; padding-left: 0;"
                                                Text='<%# Eval("Dept_Name") %>'></asp:Label><asp:HiddenField ID="HiddenField_Emp_ID"
                                                    runat="server" Value='<%# Eval("EmpID") %>' />
                                            )</span> </span>
                            </h2>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 5px;">
                                <tr>
                                    <td style="width: 65px;" align="center" valign="top">
                                        &nbsp;<asp:Image ID="Image_EmpPIC" runat="server" ImageUrl="../images_hacims/docpic.jpg" />
                                    </td>
                                    <td style="width: auto;" align="left" valign="top">
                                        <ul class="physicians">
                                            <asp:DataList ID="DataList_Dist_Ser" runat="server" DataSourceID="SqlDataSource_Deg_Dist_Ser">
                                                <ItemTemplate>
                                                    <li>
                                                        <asp:Label ID="Label_Dis_deg_ser" runat="server" Text='<%# Eval("Emp_Information") %>'></asp:Label></li>
                                                </ItemTemplate>
                                            </asp:DataList>
                                            <asp:DataList ID="DataList_Description" runat="server" DataSourceID="SqlDataSource_Description">
                                                <ItemTemplate>
                                                    <li class="profile">
                                                        <asp:Label ID="Label_Description" runat="server" Text='<%# Eval("Description") %>'></asp:Label></li>
                                                </ItemTemplate>
                                            </asp:DataList>
                                        </ul>
                                    </td>
                                </tr>
                            </table>
                            <asp:SqlDataSource ID="SqlDataSource_Description" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                SelectCommand="SELECT Emp_Information Description FROM Employee_Other_Info WHERE (Emp_id = @Emp_id) AND (Emp_info_Type_id = 4)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="HiddenField_Emp_ID" Name="Emp_id" PropertyName="Value" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSource_Deg_Dist_Ser" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                SelectCommand="SELECT Emp_Information FROM Employee_Other_Info WHERE (Emp_id = @Emp_id) AND (Emp_info_Type_id <> 4)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="HiddenField_Emp_ID" Name="Emp_id" PropertyName="Value" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:DataList>&nbsp;<div class="bxmain" style="width: 99%;">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align="left">
                                    &nbsp;&nbsp;<asp:Label ID="Label_app_SLabel" runat="server" Text="Appointments ( "
                                        Visible="False"></asp:Label>
                                    <asp:Label ID="AppointmentLabel1" Style="color: #C00;" runat="server"> </asp:Label>
                                    <asp:Label ID="Label_app_ELabel" runat="server" Text=")   |   " Visible="False"></asp:Label><asp:Label
                                        ID="Day_NameLabel1" runat="server" Visible="false"></asp:Label>&nbsp;&nbsp;<asp:Label
                                            ID="Label_AppointmentDate" runat="server"></asp:Label>(<asp:Label ID="Label_Weekday"
                                                runat="server"></asp:Label>)
                                </td>
                                <td align="left">
                                    <asp:DataList ID="DataList_SelectDateAppointment" runat="server" DataSourceID="SqlDataSource_SelectedDateAppointmentSumary"
                                        Visible="False">
                                        <ItemTemplate>
                                            <asp:Label ID="AppointmentLabel" Visible="False" runat="server" Text='<%# Eval("Appointment") %>'></asp:Label>
                                            <asp:Label ID="Day_NameLabel" runat="server" Visible="False" Text='<%# Eval("Day_Name") %>'></asp:Label>
                                            New (
                                            <asp:Label ID="NewAppointmentLabel" runat="server" CssClass="redm" Text='<%# Eval("NewAppointment") %>'></asp:Label>
                                            ) <span style="color: #999;">&nbsp;&nbsp;|&nbsp;&nbsp;</span>Follow Up (
                                            <asp:Label ID="FollowUpLabel" runat="server" CssClass="txtb" Text='<%# Eval("FollowUp") %>'></asp:Label>
                                            ) <span style="color: #999;">&nbsp;&nbsp;|&nbsp;&nbsp;</span>Reports (
                                            <asp:Label ID="ReportCheckingLabel" runat="server" CssClass="txtb" Text='<%# Eval("ReportChecking") %>'></asp:Label>
                                            ) <span style="color: #999;">&nbsp;&nbsp;|&nbsp;&nbsp;</span>Others (
                                            <asp:Label ID="OtherLabel" runat="server" CssClass="txtb" Text='<%# Eval("Other") %>'></asp:Label>
                                            )&nbsp;&nbsp;<span style="color: #999999"> | &nbsp;</span>Canceled &nbsp;(
                                            <asp:Label ID="Label_Canceled" runat="server" CssClass="txtb" ForeColor="Red" Text='<%# Eval("Canceled") %>'></asp:Label>
                                            ) &nbsp;&nbsp;
                                        </ItemTemplate>
                                    </asp:DataList></td>
                            </tr>
                            <tr>
                                <td colspan="2" align="left" style="height: 24px">
                                </td>
                            </tr>
                        </table>
                        <asp:LinkButton ID="LinkButton_Print" runat="server" Visible="False">Print</asp:LinkButton>
                        &nbsp; &nbsp; &nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton_Admin_Add_Time_Slots" runat="server" Visible="False">Add Slots</asp:LinkButton></div>
                    <!--bxmain End -->
                    <div class="bxinfo_marginb">&nbsp;&nbsp;
                        <asp:Button ID="btnUnCancelAllAppointments" runat="server" Text="Uncancel All Appointments" style="float:right;" />
                        <asp:Button ID="btnCancelAllAppointments" runat="server" Text="Cancel All Appointments" style="float:right;" />&nbsp;&nbsp;
                        <br /><br />
                        <asp:DataList ID="DataList_ViewPtInfo" runat="server" RepeatLayout="Flow" OnPreRender="DataList_ViewPtInfo_PreRender"
                            Visible="False">
                            <ItemTemplate>
                                <div class="p_boxb">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="90%">
                                                <asp:Label ID="Slot_TimeLabel" Style="color: #4d4d4d;" runat="server" Text='<%# Eval("Slot_Time") %>'></asp:Label>
                                                <span style="color: #999;">&nbsp;&nbsp;|&nbsp;&nbsp;</span>
                                                <asp:Label ID="patientLabel" runat="server" Style="font-weight: bold;" Text='<%# Eval("patient") %>'></asp:Label>
                                                <span>
                                                    <asp:Label ID="ComplaintLabel" runat="server" Style="color: #d71635;" Text='<%# Eval("Complaint") %>'></asp:Label></span></td>
                                            <td width="10%" rowspan="2" valign="middle">
                                                &nbsp;
                                                <asp:LinkButton ID="LinkButton2" runat="server" CommandName="Update" CssClass="update_btn"
                                                    OnClick="LinkButton2_Click" ToolTip="Uncancel Appointment">&nbsp;</asp:LinkButton>
                                                <asp:Label ID="Label_Appointment_Status" runat="server" Font-Bold="True" Style="color: #d71635"
                                                    Text='<%# Eval("Appointment_Status") %>'></asp:Label>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Cancel" CssClass="cancel_btn"
                                                    ToolTip="Cancel Appointment">&nbsp;</asp:LinkButton></td>
                                        </tr>
                                        <tr>
                                            <td style="padding-top: 2px;">
                                                <asp:Label ID="Label_Appointment" Style="margin-left: 47px;" runat="server" Text='<%# Eval("Appointment") %>'></asp:Label>&nbsp;&nbsp;
                                                <asp:Label ID="Label_CellNo" runat="server" Style="color: #646464; font-size: 10px;"
                                                    Text='<%# Eval("CellNo") %>'></asp:Label>
                                                <asp:Label ID="Label_Phone" runat="server" Style="font-size: 10px; color: #646464"
                                                    Text='<%# Eval("Phone") %>'></asp:Label>
                                                <span style="font-size: 10px; color: #930;">
                                                    <asp:Label ID="Label_AppType" runat="server" Text='<%# Eval("App_Type") %>'></asp:Label></span>&nbsp;
                                                <asp:Label ID="Label_District" runat="server" Text='<%# Eval("DistrictName") %>'></asp:Label></td>
                                        </tr>
                                    </table>
                                    <asp:HiddenField ID="HiddenField_Appoinment_ID" runat="server" Value='<%# Eval("Appoinment_ID") %>' />
                                    <asp:HiddenField ID="HiddenField_Doctor_ID" runat="server" Value='<%# Eval("Doctor_ID") %>' />
                                    <asp:HiddenField ID="HiddenField_Doctor_App_Slot_Id" runat="server" Value='<%# Eval("Doctor_App_Slot_Id") %>' />
                                    <asp:HiddenField ID="HiddenField_Prefix" runat="server" Value='<%# Eval("Prefix") %>' />
                                    <asp:HiddenField ID="HiddenField_PFName" runat="server" Value='<%# Eval("PFName") %>' />
                                    <asp:HiddenField ID="HiddenField_PMName" runat="server" Value='<%# Eval("PMName") %>' />
                                    <asp:HiddenField ID="HiddenField_PLName" runat="server" Value='<%# Eval("PLName") %>' />
                                    <asp:HiddenField ID="HiddenField_reg_no" runat="server" Value='<%# Eval("Reg_no") %>' />
                                    <asp:HiddenField ID="HiddenField_S_ID" runat="server" Value='<%# Eval("S_ID") %>' />
                                    <%--<asp:HiddenField ID="HiddenField_Email" runat="server" Value='<%# Eval("Pt_Email_Address") %>' />--%>
                                    &nbsp;&nbsp;
                                    <asp:HiddenField ID="HiddenField_Status" runat="server" Value='<%# Eval("Status") %>' />
                                    <br />
                                </div>
                            </ItemTemplate>
                        </asp:DataList>
                    </div>
                </div>
            </td>
        </tr>
    </table>
    <br />
    <asp:SqlDataSource ID="SqlDataSource_DataListSearch" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT     name, Dept_Name, DeptID, SexID, Designation_Name, EmpID&#13;&#10;FROM         (SELECT     ISNULL(Employee.Prefix, '') + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS name, &#13;&#10;                                              ISNULL(Department.Dept_Name, '') AS Dept_Name, Employee.DeptID, Employee.SexID, ISNULL(Designation.Designation_Name, '') AS Designation_Name, &#13;&#10;                                              Employee.EmpID&#13;&#10;                       FROM          Employee INNER JOIN&#13;&#10;                                              Department ON Employee.DeptID = Department.Dept_ID INNER JOIN&#13;&#10;                                              Designation ON Employee.DesignationID = Designation.Designation_ID&#13;&#10;                       WHERE      (Employee.Profession_Code = 1)) AS tblview&#13;&#10;WHERE     (EmpID = @EmpID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_DoctorID" DefaultValue="" Name="EmpID"
                PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="Label_Sdate" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="Label_Edate" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="HiddenField_Edate" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="HiddenField_Sdate" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="Label_APP_DATE" runat="server" Visible="False"></asp:Label><br />
    <asp:SqlDataSource ID="SqlDataSource_SelectedDateAppointmentSumary" runat="server"
        ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>" ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>"
        SelectCommand="[Selected_Date_Appointment_Sumary]" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_DayofWeek" Name="Day_Name" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="HiddenFieldAppointmentDateTime" Name="date" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="HiddenField_DoctorID" Name="EmpID" PropertyName="Value"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_ViewPtAppointment" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" SelectCommand="SELECT     Admin_Doctor_Time_Slice.Doctor_ID, Doctor_Appointment_Slot.Doctor_App_Slot_Id, left(Convert(varchar,Doctor_Appointment_Slot.Slot_Time,108),5) as Slot_Time, Week_Day.Day_Name&#13;&#10;FROM         Doctor_Appointment_Slot INNER JOIN&#13;&#10;                      Admin_Doctor_Time_Slice ON Doctor_Appointment_Slot.Admin_Doctor_Time_ID = Admin_Doctor_Time_Slice.Admin_Doctor_Time_ID INNER JOIN&#13;&#10;                      Week_Day ON Admin_Doctor_Time_Slice.For_Day = Week_Day.Day_ID                      &#13;&#10;                      WHERE (Week_Day.Day_Name = 'Wednesday') AND (Admin_Doctor_Time_Slice.Doctor_ID = 665) &#13;&#10;">
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_DayofWeek" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourceDoctor" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS Name, EmpID FROM Employee ORDER BY ISNULL(EFName, '')">
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_AppTime" runat="server" />
    <asp:HiddenField ID="HiddenFieldAppointmentDateTime" runat="server" />
    <asp:HiddenField ID="HiddenField_DoctorID" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Patient_Appointment" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        DeleteCommand="Update [Patient_Appointment] set Status=@status,Arrival_Time=getdate() WHERE [Appoinment_ID] = @Appoinment_ID"
        InsertCommand="PatientReg_Appointment" SelectCommand="SELECT [Appoinment_ID], [For_Doctor], [Complaint], [Appointmant_DateTime], [By_Emp_id], [Reg_No], [Booking_Datetime], [AppointmentNo], [Confirmed], [Pre_Appoinment_ID], [Priority], [Other], [Referred_by], [Appointment_Time], [Dept_ID], [Sub_Dept_ID], [Prefix], [District_Id], [S_ID], [RegNo], [Description], [Doctor_App_Slot_Id], [Status], [App_Type], [Email_Address], [PFName], [PMName], [PLName], [PatientAddress], [PhoneNo], [CellNo] FROM [Patient_Appointment]"
        UpdateCommand="Patient_Appointment_Confirmed" UpdateCommandType="StoredProcedure"
        InsertCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:ControlParameter ControlID="HiddenField_Appointment_ID" Name="Appoinment_ID"
                PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_status" Name="status" PropertyName="Value" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenField_Appointment_ID" Name="Appoinment_ID"
                PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_reg_no" Name="Reg_no_new" PropertyName="Value"
                Type="String" />
            <asp:Parameter Direction="Output" Name="YearlyNo" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_DoctorID" Name="DoctorID" PropertyName="Value"
                Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenField_reg_no" Name="RegNo" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Prefix" Name="Prefix" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_PFName" Name="PFName" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_PMName" Name="PMName" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_PLName" Name="PLName" PropertyName="Value" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Appointment_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_Prefix" runat="server" />
    <asp:HiddenField ID="HiddenField_PFName" runat="server" />
    <asp:HiddenField ID="HiddenField_PMName" runat="server" />
    <asp:HiddenField ID="HiddenField_PLName" runat="server" />
    <asp:HiddenField ID="HiddenField_reg_no" runat="server" />
    <asp:HiddenField ID="HiddenField_status" runat="server" />
    &nbsp;&nbsp;
    <asp:HiddenField ID="HiddenField_Admin_Doctor_Time_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_S_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_YearlyNo" runat="server" />
</asp:Content>
