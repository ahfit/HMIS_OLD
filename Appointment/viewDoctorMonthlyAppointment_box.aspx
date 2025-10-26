<%@ page language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="Patient_Registration_viewDoctorMonthlyAppointment_box, App_Web_xjzmobwq" title="Untitled Page" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
    .doctorNameStyle{color:maroon;font-weight:bold;}
    .physicians {margin-left:3px; margin-top:3px; margin-right:0px; }
    .physicians ul{ list-style:none; margin:0px;  width:100%; }
    .physicians li { margin:0px; list-style:none; display:block; margin-top:0px; font-weight:normal; color:#000; text-decoration:none; background:url(../images_hacims/kih_bulletb.png) 0 7px no-repeat;  line-height:16px; padding-left:8px; text-align:left;  }
    .physicians  .name {font-size:12px; color:#333; font-weight:bold; background-image:none;  }
    .physicians  .profile {background:none; margin-top:0px; color:#7c7c7c; text-align:left; font-size:11px;}
    .physicians  .services {  color:#3477d1; text-align:left;}

    .txtb {font-weight:bold; color:#114e9a; font-size:11px;}
    .redm {color:#d71635; font-weight:bold; font-size:11px;}
    .bxinfo_margin {}

    .p_boxb { height:32px; width:99%; display:inline-block; padding-left:5px; padding-top:3px;  border:#dddddd solid 1px; background:#a4cada url(../images_hacims/pbg.png) top left repeat-x; -webkit-border-radius: 4px; -moz-border-radius: 4px; border-radius: 4px; behavior: url(PIE.htc); float:left; clear:right; margin-bottom:4px; }

    .p_boxb a { color:#0056c5; font-size:11px; }
    .p_boxb a:hover { color:#333; }

    .p_boxb:hover { background:url(../images_hacims/img_pnamebg.png) bottom left repeat-x;  }

    .newapp  { background:url(../images_hacims/plus.png) 6px 2px no-repeat; padding-left:16px;  }
    .NotAvailable {font-size:12;color:REd;font-weight:bold;}
    </style>

    <link href="SpryAssets/SpryCollapsiblePanel.css" rel="stylesheet" type="text/css" />

    <script language="javascript" type="application/javascript">
        $(document).ready(function(){
            $(".newapp").colorbox({width:"1000px", height:"580px", iframe:true});
            $(".newapp").colorbox({ 			
                onClosed:function(){ //alert('Test'); 
                window.location.reload(false); 
            }
        });

        });
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td style="width: 300px;" valign="top">
                <div class="bx_infos_patients" style="height: 500px;">
                    <h2>
                        <span>Schedules</span></h2>
                    <br />
                    <%--<div align="center">
                        <asp:ImageButton ID="ImageButton_Previous" runat="server" ImageUrl="~/images_hacims/1leftarrow.png" />&nbsp;
                        <strong>
                            <asp:Label ID="Label_Week" runat="server"></asp:Label></strong>&nbsp;
                        <asp:ImageButton ID="ImageButton_Forward" runat="server" ImageUrl="~/images_hacims/1rightarrow.png" /></div>--%>
                    <br />
                    <div class="bxinfo_margin" style="height: auto; max-height: 410px;">
                    
                        <asp:DataList ID="DataList_DoctorsList" runat="server"  
                            DataKeyField="EmpID" Style="margin-left: 4px; 
                            padding: 2px;" Width="98%" CellPadding="4">
                            <SelectedItemStyle CssClass="bx_rad_selb" />
                            <ItemTemplate>
                                <div style="border-bottom: #999 dotted 0px; padding-bottom: 8px; padding-top: 5px;
                                    padding-left: 5px; width: 97%; overflow: hidden;" class="bx_rad">
                                    <strong>
                                        <%--<asp:Label ID="Label_PatientName" Style="color: #202f3f;" runat="server" Text='<%# Eval("EmployeeName") %>'></asp:Label>--%>
                                        <asp:LinkButton ID="lnkDoctorName" CssClass="days" runat="server"  OnClick="lnkDoctorName_Click"
                                        Text='<%# Eval("EmployeeName") %>' CommandArgument='<%# Eval("EmpID") %>'></asp:LinkButton>
                                        </strong>&nbsp;<span
                                            style="color: #e4304d; font-size: 10px;">(
                                            <asp:Label ID="Label_DeptName" runat="server" Text='<%# Eval("Dept_Name") %>'></asp:Label>)</span>
                                    <%--<div style="margin-top: 5px;">
                                        <asp:LinkButton ID="LinkButton_Monday" runat="server" CssClass="days" Text='<%# Eval("Monday") %>'
                                            CommandArgument='Monday' CommandName="Select"></asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton_Tuesday" runat="server" CssClass="days" Text='<%# Eval("Tuesday") %>'
                                            CommandArgument='Tuesday' CommandName="Select"></asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton_Wednesday" runat="server" CssClass="days" Text='<%# Eval("Wednesday") %>'
                                            CommandArgument='Wednesday' CommandName="Select"></asp:LinkButton><br />
                                        <asp:LinkButton ID="LinkButton_Thursday" runat="server" CssClass="days" Text='<%# Eval("Thursday") %>'
                                            CommandArgument='Thursday' CommandName="Select"></asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton_Friday" runat="server" CssClass="days" Text='<%# Eval("Friday") %>'
                                            CommandArgument='Friday' CommandName="Select"></asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton_Saturday" runat="server" CssClass="days" Text='<%# Eval("Saturday") %>'
                                            CommandArgument='Saturday' CommandName="select"></asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton_Sunday" runat="server" CssClass="days" Text='<%# Eval("Sunday") %>'
                                            CommandArgument='Sunday' CommandName="Select"></asp:LinkButton></div>--%>
                                    <%--<asp:HiddenField ID="HiddenField_EmpID" runat="server" Value='<%# Eval("EmpID") %>' />
                                    <asp:HiddenField ID="HiddenField_Ad_Time_ID" runat="server" />
                                    <asp:HiddenField ID="HF_Monday" runat="server" Value='<%# Eval("Mon_IS_Passed") %>' />
                                    <asp:HiddenField ID="HF_Tuesday" runat="server" Value='<%# Eval("Tues_IS_Passed") %>' />
                                    <asp:HiddenField ID="HF_Wednesday" runat="server" Value='<%# Eval("Wed_IS_Passed") %>' />
                                    <asp:HiddenField ID="HF_Thursday" runat="server" Value='<%# Eval("Thur_IS_Passed") %>' />
                                    <asp:HiddenField ID="HF_Friday" runat="server" Value='<%# Eval("Fri_IS_Passed") %>' />
                                    <asp:HiddenField ID="HF_Saturday" runat="server" Value='<%# Eval("Sat_IS_Passed") %>' />
                                    <asp:HiddenField ID="HF_Sunday" runat="server" Value='<%# Eval("Sun_IS_Passed") %>' />--%>
                                </div>
                            </ItemTemplate>
                        </asp:DataList>
                        <asp:SqlDataSource ID="SqlDataSource_EmployeeList" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                            ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" SelectCommand="SELECT Employee.EmpID, Employee.Prefix + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ISNULL(Employee.ELName, '') AS EmployeeName, Department.Dept_Name FROM Employee INNER JOIN Department ON Employee.DeptID = Department.Dept_ID ">
                        </asp:SqlDataSource>
                    </div>
                </div>
            </td>
            <td valign="top">
                <div id="doc_patients" class="bx_infos_patients" style="width: 95%; height: 100%;
                    float: left; margin-left: 20px;">
                    <table>
                            <tr>
                                <td>
                                    <asp:Label ID="lblDoctorName" CssClass="doctorNameStyle" runat="Server"></asp:Label>
                                    <asp:HiddenField ID="hfldEmpId" runat="Server" Value="" />
                                </td>
                                <td>
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                    Year: <asp:DropDownList ID="ddlYear" runat="server"></asp:DropDownList>
                        Month: <asp:DropDownList ID="ddlMonth" runat="server"></asp:DropDownList>
                        <asp:Button id="btnViewAppointments" runat="Server" Text="View Appointments" />
                                </td>
                            </tr>
                        </table>
                    
                    
                    &nbsp;<div class="bxmain" style="width: 99%;">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <%--<td align="left">
                                    &nbsp;&nbsp;<asp:Label ID="Label_app_SLabel" runat="server" Text="Appointments ( "
                                        Visible="False"></asp:Label>
                                    <asp:Label ID="AppointmentLabel1" Style="color: #C00;" runat="server"> </asp:Label>
                                    <asp:Label ID="Label_app_ELabel" runat="server" Text=")   |   " Visible="False"></asp:Label><asp:Label
                                        ID="Day_NameLabel1" runat="server" Visible="false"></asp:Label><asp:Label ID="Label_AppointmentDate"
                                            runat="server"></asp:Label>
                                    <asp:Label ID="Label_Weekday" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;<asp:LinkButton
                                        ID="LinkButton_Print" runat="server" Visible="False" CssClass="print_btn">Print</asp:LinkButton>
                                </td>--%>
                                <td align="left">
                                    <asp:DataList ID="DataList_SelectDateAppointment" runat="server" 
                                       width="100%" Visible="True">
                                        <HeaderTemplate>
                                            <table style="width:95%;margin:auto;">
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr style="height:40px;border:1px solid Green;">
                                            <td style="background-color:#A2B5CD;color:Black;font-weight:bold;text-align:center;">
                                                <%# Eval("Appointment_Day") %>
                                            </td>
                                            <td style="background-color:#CAE1FF;text-align:center;">
                                                <asp:LinkButton ID="LinkButton_Print" CssClass="print_btn" Text="Print" OnClick="LinkButton_Print_Click" CommandArgument='<%# Eval("Appointment_Day") %>' runat="Server">
                                                    
                                                </asp:LinkButton>
                                            </td>
                                            <td style="background-color:#CAE1FF;color:Black;font-weight:bold;text-align:center;">
                                                <%# Eval("Day_Name") %>
                                            </td>
                                            
                                            <td style="width:140px;text-align:center;background-color:#CAE1FF;">
                                                <asp:Label ID="lblAppointmentDetail" runat="server" text='<%# Eval("Appointment") %>'></asp:Label>
                                                <asp:Label ID="lblNotAvailable" Visible="false" CssClass="NotAvailable" runat="server" Text="NOT AVAILABLE"></asp:Label>
                                            </td>
                                            
                                                <td style="background-color:#CAE1FF;text-align:center;">
                                            
                                            <asp:Label ID="NewAppointmentLabel" runat="server" CssClass="redm" Text='<%# Eval("NewAppointment") %>'></asp:Label>
                                             
                                            </td>
                                            <td style="background-color:#CAE1FF;text-align:center;">
                                            
                                            
                                            
                                            <asp:Label ID="FollowUpLabel" runat="server" CssClass="txtb" Text='<%# Eval("FollowUp") %>'></asp:Label>
                                             </td>
                                            <td style="background-color:#CAE1FF;text-align:center;">
                                            
                                            <asp:Label ID="ReportCheckingLabel" runat="server" CssClass="txtb" Text='<%# Eval("ReportChecking") %>'></asp:Label>
                                             
                                            
                                            </td>
                                            <td style="background-color:#CAE1FF;">
                                            
                                            <asp:Label ID="OtherLabel" runat="server" CssClass="txtb" Text='<%# Eval("Other") %>'></asp:Label>
                                             </td><td style="background-color:#CAE1FF;text-align:center;"> 
                                            <asp:Label ID="Label_Canceled" runat="server" CssClass="txtb" ForeColor="Red" Text='<%# Eval("Canceled") %>'></asp:Label>
                                             </td>
                                            </tr>                                   
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </table>
                                        </FooterTemplate>
                                    </asp:DataList></td>
                            </tr>
                        </table>
                    </div>
                    <!--bxmain End -->
                    <br />
                    <%--<asp:DataList ID="DataList_ViewPtInfo" runat="server" RepeatLayout="Flow" OnPreRender="DataList_ViewPtInfo_PreRender"
                        OnSelectedIndexChanged="DataList_ViewPtInfo_SelectedIndexChanged" Visible="False">
                        <ItemTemplate>
                            <div class="p_boxb">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td width="90%">
                                            <asp:Label ID="Slot_TimeLabel" Style="color: #4d4d4d;" runat="server" Text='<%# Eval("Slot_Time") %>'></asp:Label>
                                            <span style="color: #999;">&nbsp;&nbsp;|&nbsp;&nbsp;</span>
                                            <asp:Label ID="patientLabel" runat="server" CssClass="patient_n" Text='<%# Eval("patient") %>'></asp:Label>
                                            <span>
                                                <asp:Label ID="ComplaintLabel" runat="server" Style="color: #d71635;" Text='<%# Eval("Complaint") %>'></asp:Label></span></td>
                                        <td width="10%" rowspan="2" valign="middle">
                                            &nbsp;
                                            <asp:Label ID="Label_Appointment_Status" runat="server" Font-Bold="True" Style="color: #d71635"
                                                Text='<%# Eval("Appointment_Status") %>'></asp:Label>
                                            <asp:HyperLink ID="LinkButton_AddAppointment" runat="server" CssClass="newapp" Text=""
                                                ToolTip="Add New Appointment" NavigateUrl='<%# "PatientAppointment_box.aspx?Doctor_ID=" & _&#13;&#10; Container.DataItem("Doctor_ID") & _&#13;&#10; "&Doctor_App_Slot_Id=" & Container.DataItem("Doctor_App_Slot_Id") %>'></asp:HyperLink>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Cancel" CssClass="cancel_btn"
                                                ToolTip="Cancel Appointment" OnClick="LinkButton1_Click" OnClientClick="return confirmation_Cancel(this) ">&nbsp;</asp:LinkButton><asp:LinkButton
                                                    ID="LinkButton2" runat="server" CommandName="Update" CssClass="update_btn" ToolTip="Confirm Appointment"
                                                    OnClick="LinkButton2_Click" OnClientClick="return confirmation_Confirm(this) ">&nbsp;</asp:LinkButton></td>
                                    </tr>
                                    <tr>
                                        <td style="padding-top: 2px;">
                                            <asp:Label ID="Label_Appointment" Style="margin-left: 47px;" runat="server" Text='<%# Eval("Appointment") %>'></asp:Label>&nbsp;&nbsp;
                                            <asp:Label ID="Label_CellNo" runat="server" Style="color: #646464; font-size: 10px;"
                                                Text='<%# Eval("CellNo") %>'></asp:Label>
                                            <asp:Label ID="Label_Phone" runat="server" Style="font-size: 11px; color: #646464"
                                                Text='<%# Eval("Phone") %>'></asp:Label>
                                            <span style="font-size: 11px; color: #930;">
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
                                <asp:HiddenField ID="HiddenField_Status" runat="server" Value='<%# Eval("Status") %>' />
                                <br />
                            </div>
                        </ItemTemplate>
                    </asp:DataList>--%>
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
    <br />
    <asp:HiddenField ID="HF_IsPassed" runat="server" />
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
    <asp:Panel ID="Panel_appointment" runat="server" Width="100%">
    </asp:Panel>
</asp:Content>

