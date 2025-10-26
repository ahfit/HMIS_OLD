<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Doctor_Main_Page1, App_Web_tip0c1yj" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
.cr_reading {
	border-bottom:#CCC dotted 1px;
	width:100%;
	padding-bottom:2px;
	padding-top:4px;
}
.cr_reading ul {
	width:100%;
}
.cr_reading li {
	display:block;
	height:auto;
	line-height:17px;
	background:url(images_hacims/img_bullet-2.png) 0 6px no-repeat;
	padding-left:10px;
	width:100%;
}
.bno {
	color:#C00;
	border-left:#bfbfbf solid 1px;
	margin-left:5px;
	padding-left:5px;
}
.bnb {
	color:#333;
	border-left:#bfbfbf solid 1px;
	margin-left:5px;
	padding-left:5px;
}
.bnc {
	color:#0e5b87;
	margin-left:2px;
	padding-left:2px;
}
.cr_reading .detail {
	color:#999;
	background:none;
	padding-left:0;
}
.bx_infos_patients {
	width:94%;
}
.rd_tests {
}
.rd_tests ul {
}
.rd_tests li {
	display:block;
	line-height:17px;
	background:url(images_hacims/img_bullet-2.png) 0 6px no-repeat;
	height:auto;
	width:100%;
	margin-left:0px;
	margin-top:3px;
	border:#d6d6d6 solid 1px;
	background:#fff;
	-moz-border-radius: 4px;
}
.tcount {
	color:#015aae;
	padding-left:4px;
}
.information_block {
	height:auto;
	width:94%;
	border:#e0e0e0 solid 1px;
	background:#fff url(../images_hacims/bxinfobg.png) bottom left repeat-y;
	-webkit-border-radius: 8px;
	-moz-border-radius: 8px;
	border-radius: 8px;
	padding-left:5px;
	padding-right:5px;
}
.title_a {
	width:auto;
	height:auto;
	font-weight:bold;
	font-size:11px;
	border-left:#e0e0e0 solid 1px;
	border-right:#e0e0e0 solid 1px;
	margin-top:-7px;
	position:absolute;
	background-color:#FFF;
	padding-left:6px;
	padding-right:6px;
	margin-left:10px;
}
.slc_link li a {
	color:#e93349;
	font-size:12px;
}
A.ic_addmsg {
	background:url(images_hacims/ic_adm.png) 0 5px no-repeat;
	margin-left:10px;
	padding-left:20px;
	font-size:11px;
}
A.ic_addmsg:hover {
	color:#003399;
}
A.ic_addmet {
	background:url(images_hacims/ic_admet.png) 0 3px no-repeat;
	margin-left:10px;
	padding-left:20px;
	font-size:11px;
}
A.ic_addmet:hover {
	color:#003399;
}
.lightbox {
	height:auto;
}

</style>

    <script src="SpryAssets/mycollaps.js" type="text/javascript"></script>

    <link href="SpryAssets/mycollaps.css" rel="stylesheet" type="text/css" media="screen, projection" />
    <script src="css_hacims/SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>
 <link href="css_hacims/SpryAssets/SpryTabbedPanels.css" rel="stylesheet" type="text/css" />
    
    <script language="javascript" type="text/javascript">


        function openpage() { window.location.href = "Pt_EMR/Investigation_Results.aspx"; }
		
    
    
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tbody>
            <tr>
                <td valign="top" width="40%">
                    <div id="doc_patients" class="bx_infos_patients">
                        <h2>
                            <span>Patients </span>
                        </h2>
                        <asp:Label Style="display: none" ID="Label1" runat="server" Text="Label"></asp:Label>
                        <ul style="margin-top: 10px" class="links_bx">
                        <asp:HiddenField ID="hfldSubDeptId" runat="server" Value="" />
                            <asp:DataList ID="DataListSubDepartment" runat="server" DataKeyField="SubDept_Id"
                                DataSourceID="SqlDataSourceSubDepartment" RepeatColumns="2" Width="100%">
                                <ItemTemplate>
                                    <li style="margin-top: 7px; margin-left: 2px;">
                                        <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Select" Text='<%# Eval("SubDept_Name") %>'></asp:LinkButton>
                                        <span class="tcount">(
                                            <asp:Label ID="Label4" runat="server" ToolTip="Total Patients" Text='<%# Eval("Ct") %>'></asp:Label>
                                            )</span></li>
                                </ItemTemplate>
                                <SelectedItemStyle CssClass="slc_link" />
                            </asp:DataList>
                        </ul>
                        <table class="tbl_form" cellspacing="0" cellpadding="0" border="0">
                            <tbody>
                                <tr>
                                    <td valign="top" align="left" width="50%">
                                        <ul class="links_bx">
                                            <li style="margin-top: 4px; display: none">
                                                <asp:LinkButton ID="Link_inpatinet" runat="server">InPatient</asp:LinkButton>
                                                <span class="tcount">(10)</span></li><li style="margin-top: 4px; display: none">
                                                    <asp:LinkButton ID="Link_outpatient" runat="server">OutPatient</asp:LinkButton>
                                                    <span class="tcount">(12)</span></li><li style="margin-top: 4px; display: none">
                                                        <asp:LinkButton ID="LinkButton_Private_Patient" runat="server">Private Patient</asp:LinkButton>
                                                        <span class="tcount">(15)</span></li><li style="margin-top: 4px">
                                                            <asp:LinkButton ID="lnkAppointment" runat="server" Visible="False">Appointments</asp:LinkButton>
                                                            <span class="tcount"></span></li>
                                        </ul>
                                    </td>
                                    <td valign="top" align="left" width="50%">
                                        <ul style="display: none" class="links_bx">
                                            <li style="margin-top: 4px">
                                                <asp:LinkButton ID="Link_calls" runat="server">Calls</asp:LinkButton>
                                                <span class="tcount">(09)</span></li><li style="margin-top: 4px">
                                                    <asp:LinkButton ID="Link_correspondance" runat="server">Correspondance</asp:LinkButton>
                                                    <span class="tcount">(01)</span></li><li style="margin-top: 4px">
                                                        <asp:LinkButton ID="Link_tasks" runat="server">Tasks</asp:LinkButton>
                                                        <span class="tcount">(15)</span></li></ul>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <asp:SqlDataSource ID="SqlDataSourceSubDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                            ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" SelectCommand="


SELECT 1003 AS SubDept_Id, 'InPatient' AS SubDept_Name,(SELECT    Count(*)
FROM         Patient INNER JOIN
                      Payment ON Patient.RegNo = Payment.RegNo
WHERE     ((Payment.DoctorID = @DoctorID) or (Payment.DeptId = @Dept_Id)) AND (Payment.Patient_Type = 'IPD') AND (Payment.DischargeStatus = 0)) as Ct

UNION
SELECT 1004 AS SubDept_Id, 'Out Patient' AS SubDept_Name,(SELECT     Count(*)
FROM         Patient INNER JOIN
                      Payment ON Patient.RegNo = Payment.RegNo INNER JOIN
                      Gender ON Patient.SexID = Gender.Gender_ID
WHERE      ( (Payment.DeptId = @Dept_Id)) AND (Payment.Patient_Type = 'OPD') 
--WHERE      ( (Payment.DoctorID = @DoctorID) ) AND (Payment.Patient_Type = 'OPD') 
and (Payment.DischargeStatus = 0)
AND (CONVERT(varchar, Payment.DateTime, 103) = CONVERT(varchar, getdate(),103))
) as Ct
UNION
SELECT 5555 AS SubDept_Id, 'Private Patient' AS SubDept_Name,(SELECT     Count(*)
FROM         Patient INNER JOIN
                      Payment ON Patient.RegNo = Payment.RegNo INNER JOIN
                      Gender ON Patient.SexID = Gender.Gender_ID
--WHERE      ( (Payment.DeptId = @Dept_Id)) AND (Payment.Patient_Type = 'OPD') 
WHERE      ( (Payment.DoctorID = @DoctorID) ) AND (Payment.Patient_Type = 'OPD')
AND (CONVERT(varchar, Payment.DateTime, 103) = CONVERT(varchar, getdate(),103)) and ( Payment.DischargeStatus = 0) 
 
) as Ct">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="DropDownListDept" Name="Dept_Id" PropertyName="SelectedValue"
                                    Type="Int32" />
                                <asp:SessionParameter Name="DoctorID" SessionField="Emp_id" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <br />
                        <div class="bx_rad">
                            <ul id="CollapsiblePanel1">
                                <li><strong>&nbsp;Search</strong></li><li>
                                    <table class="tbl_form" cellspacing="0" cellpadding="0" width="100%" border="0">
                                        <tbody>
                                            <tr>
                                                <td align="right" width="35%">
                                                    Reg No.:
                                                </td>
                                                <td width="65%">
                                                    <asp:TextBox ID="TextBoxRegNo" runat="server" CssClass="input_txt" Width="130px"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    Visit No.:
                                                </td>
                                                <td width="77%">
                                                    <asp:TextBox ID="TextBoxYearlyNo" runat="server" CssClass="input_txt" Width="130px"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    Name :
                                                </td>
                                                <td width="77%">
                                                    <asp:TextBox ID="TextBoxPFName" runat="server" CssClass="input_txt" Width="130px"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td style="height: 18px" align="right">
                                                    Department :
                                                </td>
                                                <td style="height: 18px" width="77%">
                                                    <asp:DropDownList ID="DropDownListDept" runat="server" CssClass="dropbox" DataSourceID="SqlDataSourceDepartment"
                                                        Width="132px" DataTextField="Dept_Name" DataValueField="Dept_ID" AutoPostBack="True">
                                                    </asp:DropDownList></td>
                                            </tr>
                                            <tr>
                                                <td align="right">&nbsp;
                                                    </td>
                                                <td>
                                                    <asp:Button ID="Button1" runat="server" CssClass="btn1" Text="Search"></asp:Button></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </li>
                            </ul>
                        </div>
                        <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                            SelectCommand="Select_Dept" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                        <br />
                        <div style="margin-bottom: 10px; overflow: auto; width: 100%; height: 800px">
                            <asp:DataList ID="DataList1" runat="server" Width="100%">
                                <ItemTemplate>
                                    <div class="p_box">
                                        <table cellpadding="0" cellspacing="0" width="100%" class="tbl_pinfo">
                                            <tr>
                                                <td style="height: 16px">
                                                    <asp:LinkButton ID="LinkButtonName" runat="server" CommandName="Select" OnClick="LinkButtonName_Click"></asp:LinkButton></td>
                                                <td align="right" style="height: 16px">
                                                    <asp:Label ID="DiagonosisLabel" runat="server" Style="color: red; font-weight: bold;
                                                        font-size: 10px;" Text='<%# Eval("Diagonosis") %>'></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="LabelRegNo" runat="server" Style="color: #6b6b6b; font-size: 9px;"
                                                        Text='<%# Eval("RegNo") %>'></asp:Label>
                                                    <span class="spltr">&nbsp;|&nbsp;</span>
                                                    <asp:Label ID="Label2" runat="server" Style="color: #151313; font-size: 9px;" Text='<%# Eval("BedNo") %>'></asp:Label></td>
                                                <td align="right">
                                                    <asp:Label Style="color: #333; font-size: 10px;" ID="AgeLabel" runat="server" Text='<%# Eval("Age") %>'></asp:Label>
                                                    <asp:Label ID="AgeTypeLabel" Style="color: #6b6b6b; font-size: 10px;" runat="server"
                                                        Text='<%# Eval("AgeType") %>'></asp:Label>
                                                    <span class="spltr">&nbsp;|&nbsp;</span>
                                                    <asp:Label ID="LabelGender" Style="color: #d71635; font-size: 10px;" runat="server"
                                                        Text='<%# Eval("Gender") %>'></asp:Label>
                                                    <asp:Label ID="Label_Date" runat="server" Text='<%# Eval("DateTime") %>'></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:Label ID="PFNameLabel" CssClass="deslist" runat="server" Text='<%# Eval("PFName") %>'
                                                        Visible="False"></asp:Label>
                                                    <asp:Label ID="PrefixLabel" CssClass="deslist" runat="server" Text='<%# Eval("Prefix") %>'
                                                        Visible="False"></asp:Label>
                                                    <asp:Label ID="PMNameLabel" CssClass="deslist" runat="server" Text='<%# Eval("PMName") %>'
                                                        Visible="False"></asp:Label>
                                                    <asp:Label ID="PLNameLabel" CssClass="deslist" runat="server" Text='<%# Eval("PLName") %>'
                                                        Visible="False"></asp:Label>
                                                    <asp:Label ID="LabelPayID" CssClass="deslist" runat="server" Text='<%# Eval("PayID") %>'
                                                        Visible="False"></asp:Label>
                                                    <asp:HiddenField ID="HiddenField_reg_no" runat="server" Value='<%# Eval("RegNo") %>' />
                                                    <asp:HiddenField ID="HiddenField_pay_ID" runat="server" Value='<%# Eval("PayID") %>' />
                                                      <asp:HiddenField ID="HiddenField_IPD_OPD" runat="server" Value='<%# Eval("Patient_Type") %>' />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </ItemTemplate>
                            </asp:DataList>
                            <asp:Panel ID="Panel_App" runat="server">
                                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                    <tbody>
                                        <tr>
                                            <td valign="top">
                                                <div align="center">
                                                    <asp:ImageButton ID="ImageButton_Previous" runat="server" ImageUrl="~/images_hacims/1leftarrow.png">
                                                    </asp:ImageButton>
                                                    &nbsp; <strong>
                                                        <asp:Label ID="Label_Week" runat="server"></asp:Label>
                                                    </strong>&nbsp;
                                                    <asp:ImageButton ID="ImageButton_Forward" runat="server" ImageUrl="~/images_hacims/1rightarrow.png">
                                                    </asp:ImageButton>
                                                </div>
                                                <div style="height: auto" class="bxinfo_margin">
                                                    <asp:DataList Style="padding-right: 2px; padding-left: 2px; padding-bottom: 2px;
                                                        margin-left: 4px; padding-top: 2px" ID="DataList_DoctorsList" runat="server"
                                                        ForeColor="#333333" DataKeyField="EmpID" Width="98%" CellPadding="4">
                                                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                        <AlternatingItemStyle BackColor="White" />
                                                        <ItemStyle BackColor="#F0F7D0" />
                                                        <SelectedItemStyle BackColor="#E2E8F6" Font-Bold="True" ForeColor="#333333" />
                                                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                        <ItemTemplate>
                                                            <div style="border-bottom: #999 dotted 1px; padding-bottom: 0px; padding-top: 0px;
                                                                overflow: hidden;">
                                                                <strong>
                                                                    <asp:Label ID="Label_PatientName" runat="server" Style="color: #606060;" Text='<%# Eval("EmployeeName") %>'
                                                                        Visible="false"></asp:Label>
                                                                </strong>&nbsp;<span style="color: #959393; font-size: 10px; display: none;">(
                                                                    <asp:Label ID="Label_DeptName" runat="server" Text='<%# Eval("Dept_Name") %>'></asp:Label>
                                                                    )</span>
                                                                <div>
                                                                    <asp:LinkButton ID="LinkButton_Monday" runat="server" CommandArgument="Monday" CommandName="Select"
                                                                        CssClass="days" Style="padding-left: 0px;" Text='<%# Eval("Monday") %>'></asp:LinkButton>
                                                                    <asp:LinkButton ID="LinkButton_Tuesday" runat="server" CommandArgument="Tuesday"
                                                                        CommandName="Select" CssClass="days" Text='<%# Eval("Tuesday") %>'></asp:LinkButton>
                                                                    <asp:LinkButton ID="LinkButton_Wednesday" runat="server" CommandArgument="Wednesday"
                                                                        CommandName="Select" CssClass="days" Text='<%# Eval("Wednesday") %>'></asp:LinkButton>
                                                                    <asp:LinkButton ID="LinkButton_Thursday" runat="server" CommandArgument="Thursday"
                                                                        CommandName="Select" CssClass="days" Text='<%# Eval("Thursday") %>'></asp:LinkButton>
                                                                    <asp:LinkButton ID="LinkButton_Friday" runat="server" CommandArgument="Friday" CommandName="Select"
                                                                        CssClass="days" Text='<%# Eval("Friday") %>'></asp:LinkButton>
                                                                    <asp:LinkButton ID="LinkButton_Saturday" runat="server" CommandArgument="Saturday"
                                                                        CommandName="select" CssClass="days" Text='<%# Eval("Saturday") %>'></asp:LinkButton>
                                                                    <asp:LinkButton ID="LinkButton_Sunday" runat="server" CommandArgument="Sunday" CommandName="Select"
                                                                        CssClass="days" Text='<%# Eval("Sunday") %>'></asp:LinkButton>
                                                                </div>
                                                                <asp:HiddenField ID="HiddenField_EmpID" runat="server" Value='<%# Eval("EmpID") %>' />
                                                                <asp:HiddenField ID="HiddenField_Ad_Time_ID" runat="server" />
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:DataList>
                                                    <asp:SqlDataSource ID="SqlDataSource_EmployeeList" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                                                        ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" SelectCommand="SELECT Employee.EmpID, Employee.Prefix + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ISNULL(Employee.ELName, '') AS EmployeeName, Department.Dept_Name FROM Employee INNER JOIN Department ON Employee.DeptID = Department.Dept_ID ">
                                                    </asp:SqlDataSource>
                                                </div>
                                                <asp:DataList ID="DataList3" runat="server" Visible="False" DataSourceID="SqlDataSource_DataListSearch"
                                                    Width="100%" RepeatLayout="Flow">
                                                    <ItemTemplate>
                                                        <h2 style="display: none;">
                                                            <span>
                                                                <asp:Label ID="Label_Designation" runat="server" Style="background: none; padding-left: 0;
                                                                    font-weight: bold; display: none;" Text='<%# Eval("Designation_Name") %>'></asp:Label>
                                                                <asp:Label ID="Label_Name" runat="server" Style="background: none; padding-left: 0;
                                                                    font-weight: bold;" Text='<%# Eval("name") %>' Visible="false"></asp:Label>
                                                                &nbsp;<span style="color: #0658a8; background: none; padding-left: 0;">(
                                                                    <asp:Label ID="Label_Department" runat="server" Style="background: none; padding-left: 0;"
                                                                        Text='<%# Eval("Dept_Name") %>'></asp:Label>
                                                                    <asp:HiddenField ID="HiddenField_Emp_ID" runat="server" Value='<%# Eval("EmpID") %>' />
                                                                    )</span> </span>
                                                        </h2>
                                                        <table border="0" cellpadding="0" cellspacing="0" style="margin-top: 0px;" width="100%">
                                                            <tr>
                                                                <td align="center" style="width: 65px;" valign="top">
                                                                    &nbsp;
                                                                    <asp:Image ID="Image_EmpPIC" runat="server" ImageUrl="../images_hacims/docpic.jpg"
                                                                        Visible="false" /></td>
                                                                <td align="left" style="width: auto;" valign="top">
                                                                    <ul class="physicians">
                                                                        <asp:DataList ID="DataList_Dist_Ser" runat="server" DataSourceID="SqlDataSource_Deg_Dist_Ser"
                                                                            Visible="false">
                                                                            <ItemTemplate>
                                                                                <li>
                                                                                    <asp:Label ID="Label_Dis_deg_ser" runat="server" Text='<%# Eval("Emp_Information") %>'
                                                                                        Visible="false"></asp:Label>
                                                                                </li>
                                                                            </ItemTemplate>
                                                                        </asp:DataList>
                                                                        <asp:DataList ID="DataList_Description" runat="server" DataSourceID="SqlDataSource_Description">
                                                                            <ItemTemplate>
                                                                                <li class="profile">
                                                                                    <asp:Label ID="Label_Description" runat="server" Text='<%# Eval("Description") %>'></asp:Label>
                                                                                </li>
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
                                                </asp:DataList>
                                                &nbsp;
                                                <asp:Label ID="Label_app_SLabel" runat="server" Text="Appointments ( " Visible="False"></asp:Label>
                                                <asp:Label Style="color: #c00" ID="AppointmentLabel1" runat="server"> </asp:Label>
                                                <asp:Label ID="Label_app_ELabel" runat="server" Text=")   |   " Visible="False"></asp:Label>
                                                <asp:Label ID="Day_NameLabel1" runat="server" Visible="false"></asp:Label>
                                                &nbsp;&nbsp;
                                                <asp:Label ID="Label_AppointmentDate" runat="server"></asp:Label>
                                                <asp:Label ID="Label_Weekday" runat="server"></asp:Label>
                                                <div style="display: none; width: 99%">
                                                    <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                                        <tbody>
                                                            <tr>
                                                                <td align="left">
                                                                    &nbsp;&nbsp;
                                                                </td>
                                                                <td align="left">
                                                                    <asp:DataList ID="DataList_SelectDateAppointment" runat="server" Visible="False"
                                                                        DataSourceID="SqlDataSource_SelectedDateAppointmentSumary">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="AppointmentLabel" runat="server" Text='<%# Eval("Appointment") %>'
                                                                                Visible="False"></asp:Label>
                                                                            <asp:Label ID="Day_NameLabel" runat="server" Text='<%# Eval("Day_Name") %>' Visible="False"></asp:Label>
                                                                            New (
                                                                            <asp:Label ID="NewAppointmentLabel" runat="server" CssClass="redm" Text='<%# Eval("NewAppointment") %>'></asp:Label>
                                                                            ) <span style="color: #999;">&nbsp; | &nbsp;</span>Follow Up (
                                                                            <asp:Label ID="FollowUpLabel" runat="server" CssClass="txtb" Text='<%# Eval("FollowUp") %>'></asp:Label>
                                                                            ) <span style="color: #999;">&nbsp; | &nbsp;</span>Reports (
                                                                            <asp:Label ID="ReportCheckingLabel" runat="server" CssClass="txtb" Text='<%# Eval("ReportChecking") %>'></asp:Label>
                                                                            ) <span style="color: #999;">&nbsp; | &nbsp;</span>Others (
                                                                            <asp:Label ID="OtherLabel" runat="server" CssClass="txtb" Text='<%# Eval("Other") %>'></asp:Label>
                                                                            ) &nbsp;
                                                                        </ItemTemplate>
                                                                    </asp:DataList></td>
                                                            </tr>
                                                            <tr>
                                                                <td style="height: 24px" align="left" colspan="2">
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                    <asp:LinkButton ID="LinkButton_Print" runat="server" Visible="False">Print</asp:LinkButton>
                                                </div>
                                                <!--bxmain End -->
                                                <div>
                                                    <br />
                                                    <asp:DataList ID="DataList_ViewPtInfo" runat="server" Visible="False" RepeatLayout="Flow"
                                                        OnPreRender="DataList_ViewPtInfo_PreRender" OnSelectedIndexChanged="DataList_ViewPtInfo_SelectedIndexChanged">
                                                        <ItemTemplate>
                                                            <div class="p_boxb">
                                                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                    <tr>
                                                                        <td width="90%">
                                                                            <asp:Label ID="Slot_TimeLabel" runat="server" Style="color: #4d4d4d" Text='<%# Eval("Slot_Time") %>'></asp:Label>
                                                                            <span style="color: #999">&nbsp; | &nbsp;</span>
                                                                            <asp:Label ID="patientLabel" runat="server" Style="font-weight: bold" Text='<%# Eval("patient") %>'></asp:Label>
                                                                            &nbsp;
                                                                            <asp:LinkButton ID="LinkButton3" runat="server" CommandName="Select"></asp:LinkButton>
                                                                            <span>
                                                                                <asp:Label ID="ComplaintLabel" runat="server" Style="font-size: 10px; color: #d71635"
                                                                                    Text='<%# Eval("Complaint") %>'></asp:Label>
                                                                            </span>
                                                                        </td>
                                                                        <td rowspan="2" style="display: none" valign="middle" width="10%">
                                                                            <asp:HyperLink ID="LinkButton_AddAppointment" runat="server" CssClass="newapp" NavigateUrl='<%# "PatientAppointment_box.aspx?Doctor_ID=" & _&#13;&#10; Container.DataItem("Doctor_ID") & _&#13;&#10; "&Doctor_App_Slot_Id=" & Container.DataItem("Doctor_App_Slot_Id") %>'
                                                                                Text="" ToolTip="Add New Appointment"></asp:HyperLink>
                                                                            <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Cancel" CssClass="cancel_btn"
                                                                                OnClick="LinkButton1_Click" ToolTip="Cancel Appointment">&nbsp;</asp:LinkButton>
                                                                            <asp:LinkButton ID="LinkButton2" runat="server" CommandName="Update" CssClass="update_btn"
                                                                                OnClick="LinkButton2_Click" ToolTip="Confirm Appointment">&nbsp;</asp:LinkButton></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="padding-top: 2px">
                                                                            <asp:Label ID="Label_Appointment" runat="server" Style="margin-left: 47px" Text='<%# Eval("Appointment") %>'></asp:Label>
                                                                            &nbsp;&nbsp;
                                                                            <asp:Label ID="Label_CellNo" runat="server" Style="font-size: 10px; color: #646464"
                                                                                Text='<%# Eval("CellNo") %>'></asp:Label>
                                                                            <asp:Label ID="Label_Phone" runat="server" Style="font-size: 10px; color: #646464"
                                                                                Text='<%# Eval("Phone") %>'></asp:Label>
                                                                            <span style="font-size: 10px; color: #930">
                                                                                <asp:Label ID="Label_AppType" runat="server" Text='<%# Eval("App_Type") %>'></asp:Label>
                                                                            </span>&nbsp;
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
                                                                <asp:HiddenField ID="HiddenField_YearlyNo" runat="server" />
                                                                <asp:HiddenField ID="HiddenField_S_ID" runat="server" Value='<%# Eval("S_ID") %>' />
                                                                &nbsp;&nbsp;
                                                                <asp:HiddenField ID="HiddenField_Status" runat="server" Value='<%# Eval("Status") %>' />
                                                                <br />
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:DataList>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <br />
                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
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
                                <asp:Label ID="Label_APP_DATE" runat="server" Visible="False"></asp:Label>
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
                                <asp:HiddenField ID="HiddenField_DayofWeek" runat="server"></asp:HiddenField>
                                <asp:SqlDataSource ID="SqlDataSourceDoctor" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                    SelectCommand="SELECT ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS Name, EmpID FROM Employee ORDER BY ISNULL(EFName, '')">
                                </asp:SqlDataSource>
                                <asp:HiddenField ID="HiddenField_AppTime" runat="server"></asp:HiddenField>
                                <asp:HiddenField ID="HiddenFieldAppointmentDateTime" runat="server"></asp:HiddenField>
                                <asp:HiddenField ID="HiddenField_DoctorID" runat="server"></asp:HiddenField>
                                <asp:SqlDataSource ID="SqlDataSource_Patient_Appointment" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                                    SelectCommand="SELECT [Appoinment_ID], [For_Doctor], [Complaint], [Appointmant_DateTime], [By_Emp_id], [Reg_No], [Booking_Datetime], [AppointmentNo], [Confirmed], [Pre_Appoinment_ID], [Priority], [Other], [Referred_by], [Appointment_Time], [Dept_ID], [Sub_Dept_ID], [Prefix], [District_Id], [S_ID], [RegNo], [Description], [Doctor_App_Slot_Id], [Status], [App_Type], [Email_Address], [PFName], [PMName], [PLName], [PatientAddress], [PhoneNo], [CellNo] FROM [Patient_Appointment]"
                                    InsertCommand="PatientReg_Appointment" InsertCommandType="StoredProcedure" DeleteCommand="Update [Patient_Appointment] set Status=@status,Arrival_Time=getdate() WHERE [Appoinment_ID] = @Appoinment_ID"
                                    UpdateCommand="Patient_Appointment_Confirmed" UpdateCommandType="StoredProcedure">
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
                                <asp:HiddenField ID="HiddenField_Appointment_ID" runat="server"></asp:HiddenField>
                                <asp:HiddenField ID="HiddenField_Prefix" runat="server"></asp:HiddenField>
                                <asp:HiddenField ID="HiddenField_PFName" runat="server"></asp:HiddenField>
                                <asp:HiddenField ID="HiddenField_PMName" runat="server"></asp:HiddenField>
                                <asp:HiddenField ID="HiddenField_PLName" runat="server"></asp:HiddenField>
                                <asp:HiddenField ID="HiddenField_reg_no" runat="server"></asp:HiddenField>
                                <asp:HiddenField ID="HiddenField_status" runat="server"></asp:HiddenField>
                                <asp:HiddenField ID="HiddenField_Admin_Doctor_Time_ID" runat="server"></asp:HiddenField>
                                <asp:HiddenField ID="HiddenField_S_ID" runat="server"></asp:HiddenField>
                                <asp:HiddenField ID="HiddenField_YearlyNo" runat="server"></asp:HiddenField>
                                <asp:HiddenField ID="HF_track_date" runat="server" />
                                <br />
                                <asp:SqlDataSource ID="SDS_Patient_track" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                                    InsertCommand="usp_Patient_forward_to_sebdept" InsertCommandType="StoredProcedure"
                                    ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>">
                                    <InsertParameters>
                                        <asp:SessionParameter Name="Reg_No" SessionField="RegistrationNo" Type="String" />
                                        <asp:SessionParameter Name="yearly_no" SessionField="YearlyNo" Type="Decimal" />
                                        <asp:SessionParameter Name="to_sub_Dept" SessionField="SubDeptID" Type="Int32" />
                                        <asp:SessionParameter Name="by_doctor" SessionField="Emp_id" Type="Int32" />
                                        <asp:SessionParameter Name="by_sub_dept_id" SessionField="SubDeptID" Type="Int32" />
                                        <asp:ControlParameter ControlID="HF_track_date" DefaultValue="" Name="forward_date"
                                            PropertyName="Value" Type="DateTime" />
                                        
                                        <asp:Parameter DefaultValue="3" Name="request_type_id" Type="Int32" />
                                        <asp:Parameter Name="Description" Type="String" DefaultValue="N/A" />
                                        <asp:SessionParameter Name="To_Emp_Id" SessionField="emp_id" Type="Int32" />
                                    </InsertParameters>
                                </asp:SqlDataSource>
                            </asp:Panel>
                            <div>
                            </div>
                            <asp:Label ID="Label3" runat="server"></asp:Label>
                        </div>
                        <asp:Label ID="GenderLabel" runat="server" Text='<%# Eval("Gender") %>'></asp:Label>
                    </div>
                </td>
                <td valign="top">
                    <table cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tbody>
                            <tr>
                                <td valign="top" width="100%">
                                    <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                        <tbody>
                                            <tr>
                                                <td valign="top" width="50%">
                                                    <div id="cr_readings" class="bx_infos_patients tab_bx">
                                                        <h2>
                                                            <span>Critical Readings</span></h2>
                                                        <div style="height: auto" class="bxinfo_margin">
                                                            <asp:DataList ID="DataList_CriticalReading" runat="server" Width="100%">
                                                                <ItemTemplate>
                                                                    <div class="bx_crreadings">
                                                                        <ul>
                                                                            <li>
                                                                                <asp:LinkButton ID="LinkButton3" runat="server" CommandName="Select" Text='<%# Eval("Prefix") %>'></asp:LinkButton>
                                                                                (<span class="ward">
                                                                                    <asp:Label ID="Label_Bed_Diagnosis" runat="server" Text='<%# Eval("Bed_Diagnosis") %>'></asp:Label>
                                                                                </span>)</li><li class="detail">
                                                                                <asp:Label ID="Label_Time" runat="server" Text='<%# Eval("Time") %>'></asp:Label>
                                                                                <asp:HiddenField ID="hfRegNo" runat="server" Value='<%# Eval("RegNo") %>' />
                                                                            </li>
                                                                            <li class="detail">
                                                                                <asp:HiddenField ID="hfYearlyNo" runat="server" Value='<%# Eval("YearlyNo") %>' />
                                                                            </li>
                                                                        </ul>
                                                                    </div>
                                                                </ItemTemplate>
                                                            </asp:DataList>
                                                        </div>
                                                    </div>
                                                    <!--End Critical Readings-->
                                                    <br />
                                                    <div class="bx_infos_patients">
                                                        <h2>
                                                            <span><a style="text-decoration: none" href="Doctor_Main_Page_Lab.aspx">Pathology</a></span></h2>
                                                        <div style="height: auto" class="bxinfo_margin">
                                                            <asp:DataList ID="DataList_Pathology" runat="server" DataSourceID="SqlDataSource_Pathology_Test"
                                                                Width="100%">
                                                                <ItemTemplate>
                                                                    <asp:HiddenField ID="HiddenField_PFName" runat="server" Value='<%# Eval("PFName") %>' />
                                                                    <asp:HiddenField ID="HiddenField_PMName" runat="server" Value='<%# Eval("PMName") %>' />
                                                                    <asp:HiddenField ID="HiddenField_PLName" runat="server" Value='<%# Eval("PLName") %>' />
                                                                    <asp:HiddenField ID="HiddenField_DeptID" runat="server" Value='<%# Eval("DeptId") %>' />
                                                                    <asp:HiddenField ID="hfPrefix" runat="server" />
                                                                    <asp:HiddenField ID="HiddenField_RegNo" runat="server" Value='<%# Eval("RegNo") %>' />
                                                                    <div class="bx_pathology">
                                                                        <ul id="CollapsiblePanelp_<%# Eval("YearlyNo") %>">
                                                                            <li><span class="name">
                                                                                <asp:Label ID="PrefixLabel" runat="server" ToolTip="Patient & Relation Name" Text='<%# Eval("Prefix") %>'></asp:Label>
                                                                            </span>( <span class="ward">
                                                                                <asp:Label ID="AgeLabel" runat="server" ToolTip="Age" Text='<%# Eval("Age") %>'></asp:Label>
                                                                                Year </span>) (<span class="ward">
                                                                                    <asp:Label ID="Ward_NameLabel" runat="server" ToolTip="Ward Name" Text='<%# Eval("Ward_Name") %>'></asp:Label>
                                                                                    /
                                                                                    <asp:Label ID="Bed_NoLabel" runat="server" ToolTip="Bed Number" Text='<%# Eval("Bed_No") %>'></asp:Label>
                                                                                </span>)<span style="font-size: 10px; color: #6a6666; display: block;">
                                                                                    <asp:Label ID="RegNoLabel" runat="server" ToolTip="Registration Number" Text='<%# Eval("RegNo") %>'></asp:Label>
                                                                                    (
                                                                                    <asp:Label ID="YearlyNoLabel" Style="color: #000;" runat="server" Text='<%# Eval("YearlyNo") %>'></asp:Label>
                                                                                    )
                                                                                    <asp:Label ID="TestDateLabel" ToolTip="Test Date" CssClass="date" runat="server"
                                                                                        Text='<%# Eval("TestDate") %>'></asp:Label>
                                                                                </span></li>
                                                                            <li>
                                                                                <asp:DataList ID="DataList2" runat="server" DataSourceID="SqlDataSource_PathTestDetail">
                                                                                    <ItemTemplate>
                                                                                        <strong>
                                                                                            <asp:LinkButton ID="LinkButton2" runat="server" ToolTip="Test Group" 
                                                                                            onClientClick="javascript:openpage(); return false;"  
                                                                                            Text='<%# Eval("TGName") %>' onclick="LinkButton2_Click1" 
                                                                                            CommandArgument='<%# Eval("RegNo", "{0}") %>'></asp:LinkButton>
                                                                                            <asp:Label ID="TGNameLabel" runat="server" Visible="False" 
                                                                                            ToolTip="Test Group" Text='<%# Eval("TGName") %>'></asp:Label>
                                                                                        </strong>{ <span class="bnc">
                                                                                            <asp:Label ID="TBNameLabel" ToolTip="Test Sub Group" runat="server" Text='<%# Eval("TBName") %>'></asp:Label>
                                                                                        </span>}
                                                                                    </ItemTemplate>
                                                                                </asp:DataList>
                                                                            </li>
                                                                        </ul>

                                                                        <script type='text/javascript'>var CollapsiblePanelp_<%# Eval("YearlyNo") %> = new Spry.Widget.CollapsiblePanel('CollapsiblePanelp_<%# Eval("YearlyNo") %>',{contentIsOpen:false});</script>

                                                                    </div>
                                                                    <asp:SqlDataSource ID="SqlDataSource_PathTestDetail" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                                                        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                                                        
                                                                        SelectCommand="SELECT DISTINCT TestGroup.TGName, dbo.Pathology_TB_Name(Investigation_Order_Main.DeptId, Investigation_Order_Main.YearlyNo, Investigation_Order_Main.RegNo, TestGroup.TGID) AS TBName, Investigation_Order_Main.RegNo FROM Test_Booking INNER JOIN TestGroup ON Test_Booking.MG_ID = TestGroup.TGID INNER JOIN Investigation_Order_Sub INNER JOIN Investigation_Order_Main ON Investigation_Order_Sub.Investigation_Order_ID = Investigation_Order_Main.Investigation_Order_ID ON Test_Booking.TB_ID = Investigation_Order_Sub.TB_ID WHERE (Investigation_Order_Main.YearlyNo = @YearlyNo) AND (Investigation_Order_Main.RegNo = @RegNo) AND (Investigation_Order_Main.DeptId = @DeptId) AND (CONVERT (varchar, Investigation_Order_Main.Date_Time, 103) = @Date)">
                                                                        <SelectParameters>
                                                                            <asp:ControlParameter ControlID="YearlyNoLabel" Name="YearlyNo" PropertyName="Text" />
                                                                            <asp:ControlParameter ControlID="HiddenField_RegNo" Name="RegNo" PropertyName="Value" />
                                                                            <asp:ControlParameter ControlID="HiddenField_DeptID" Name="DeptId" PropertyName="Value" />
                                                                            <asp:ControlParameter ControlID="TestDateLabel" Name="Date" PropertyName="Text" />
                                                                        </SelectParameters>
                                                                    </asp:SqlDataSource>
                                                                </ItemTemplate>
                                                            </asp:DataList>
                                                            <asp:SqlDataSource ID="SqlDataSource_Pathology_Test" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                                                ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                                                SelectCommand="SELECT DISTINCT &#13;&#10;                      CONVERT(varchar, Investigation_Order_Main.Date_Time, 103) AS TestDate, Investigation_Order_Main.YearlyNo, Investigation_Order_Main.RegNo, &#13;&#10;                      Investigation_Order_Main.DeptId, admin_Hospital_Wards.Ward_Name, Ward_Beds.Bed_No, Patient.Prefix, Patient.PFName, Patient.PMName, Patient.PLName, &#13;&#10;                      Patient.Age&#13;&#10;FROM         Patient INNER JOIN&#13;&#10;                      Payment ON Patient.RegNo = Payment.RegNo INNER JOIN&#13;&#10;                      Investigation_Order_Main ON Payment.PayID = Investigation_Order_Main.YearlyNo AND Payment.RegNo = Investigation_Order_Main.RegNo LEFT OUTER JOIN&#13;&#10;                      Ward_Beds INNER JOIN&#13;&#10;                      Pt_Assign_Bed ON Ward_Beds.Bed_id = Pt_Assign_Bed.Bed_id AND Ward_Beds.ward_Id = Pt_Assign_Bed.Ward_id INNER JOIN&#13;&#10;                      admin_Hospital_Wards ON Pt_Assign_Bed.Ward_id = admin_Hospital_Wards.Ward_id ON Investigation_Order_Main.YearlyNo = Pt_Assign_Bed.Yearly_No AND &#13;&#10;                      Investigation_Order_Main.RegNo = Pt_Assign_Bed.Reg_No&#13;&#10;WHERE     (Investigation_Order_Main.DeptId = @Dept_Id)and ( Payment.DischargeStatus=0)">
                                                                <SelectParameters>
                                                                    <asp:SessionParameter SessionField="Dept_Id" Name="Dept_Id"></asp:SessionParameter>
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                        </div>
                                                    </div>
                                                    <!--Pathology Test-->
                                                    <br />
                                                    <div class="bx_infos_patients">
                                                        <h2>
                                                            <span>Radiology Test</span></h2>
                                                        <div style="margin-top: 10px; height: auto" class="bxinfo_margin">
        
                                                            <asp:DataList ID="DataList_RadiologyTest" runat="server" DataSourceID="SqlDataSource_RadiologyTest"
                                                                Width="100%">
                                                                <ItemTemplate>
                                                                    <asp:HiddenField ID="HiddenField_Reg_No" runat="server" Value='<%# Eval("Reg_No") %>' />
                                                                    <asp:HiddenField ID="HiddenField_PFName" runat="server" Value='<%# Eval("PFName") %>' />
                                                                    <asp:HiddenField ID="HiddenField_PMName" runat="server" Value='<%# Eval("PMName") %>' />
                                                                    <asp:HiddenField ID="HiddenField_DeptID" runat="server" Value='<%# Eval("DeptId") %>' />
                                                                    <asp:HiddenField ID="HiddenField_PLName" runat="server" Value='<%# Eval("PLName") %>' />
                                                                    <asp:HiddenField ID="hfPrefix" runat="server" Value='<%# Eval("Prefix") %>' />
                                                                    <div class="bx_rad">
                                                                        <ul id="CollapsiblePanel_<%# Eval("Yearly_No") %>">
                                                                            <li><span class="name">
                                                                                <asp:Label ID="PrefixLabel" runat="server" Text='<%# Eval("Prefix") %>'></asp:Label>
                                                                            </span>( <span class="ward">
                                                                                <asp:Label ID="AgeLabel" runat="server" Text='<%# Eval("Age") %>'></asp:Label>
                                                                                Year </span>) ( <span class="ward">
                                                                                    <asp:Label ID="patientWardbedLabel" runat="server" ToolTip="Ward & Bed Number" Text='<%# Eval("patientWardbed") %>'></asp:Label>
                                                                                </span>)
                                                                                <asp:Label ID="DateTimeLabel" runat="server" Style="font-size: 10px; color: #6a6666;
                                                                                    display: block;" CssClass="date" Text='<%# Eval("DateTime") %>'></asp:Label>
                                                                            </li>
                                                                            <li>
                                                                                <asp:Label ID="Reg_NoLabel" Style="font-size: 10px; color: #6a6666;" runat="server"
                                                                                    Text='<%# Eval("Reg_No") %>'></asp:Label>
                                                                                (
                                                                                <asp:Label ID="Yearly_NoLabel" Style="color: #000;" runat="server" Text='<%# Eval("Yearly_No") %>'></asp:Label>
                                                                                )
                                                                                <asp:DataList ID="DataList_TestDetail" runat="server" DataSourceID="SqlDataSource_TestDetail"
                                                                                    Width="100%">
                                                                                    <ItemTemplate>
                                                                                        <strong>
                                                                                            <asp:Label ID="TGNameLabel" runat="server" Text='<%# Eval("TGName") %>'></asp:Label>
                                                                                        </strong>{ <span class="bnc">
                                                                                            <asp:Label ID="tbnameLabel" runat="server" Text='<%# Eval("tbname") %>'></asp:Label>
                                                                                        </span>}
                                                                                    </ItemTemplate>
                                                                                </asp:DataList>
                                                                            </li>
                                                                        </ul>

                                                                        <script type='text/javascript'>var CollapsiblePanel_<%# Eval("Yearly_No") %> = new Spry.Widget.CollapsiblePanel('CollapsiblePanel_<%# Eval("Yearly_No") %>',{contentIsOpen:false});</script>

                                                                    </div>
                                                                    <asp:SqlDataSource ID="SqlDataSource_TestDetail" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                                                        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                                                        SelectCommand="&#13;&#10;SELECT DISTINCT Radiology.dbo.TestGroup.TGName, dbo.Radiology_TB_Name(Radiology_Order_Main.DeptId, Radiology_Order_Main.YearlyNo, Radiology_Order_Main.RegNo, &#13;&#10;                      Radiology.dbo.TestGroup.TGID) AS tbname&#13;&#10;FROM         Radiology_Order_Sub INNER JOIN&#13;&#10;                      Radiology_Order_Main ON Radiology_Order_Sub.Order_ID = Radiology_Order_Main.Order_ID INNER JOIN&#13;&#10;                      Radiology.dbo.Test_Booking ON Radiology_Order_Sub.TB_ID = Radiology.dbo.Test_Booking.TB_ID INNER JOIN&#13;&#10;                      Radiology.dbo.TestGroup ON Radiology.dbo.Test_Booking.MG_ID = Radiology.dbo.TestGroup.TGID&#13;&#10;WHERE     (Radiology_Order_Main.DeptId = @DeptId) AND (Radiology_Order_Main.YearlyNo = @YearlyNo) AND &#13;&#10;                      (Radiology_Order_Main.RegNo =@RegNo) AND (CONVERT(varchar, Radiology_Order_Main.Date_Time, 103) &#13;&#10;                      = @Date)">
                                                                        <SelectParameters>
                                                                            <asp:ControlParameter ControlID="HiddenField_DeptID" Name="DeptId" PropertyName="Value" />
                                                                            <asp:ControlParameter ControlID="HiddenField_Reg_No" Name="RegNo" PropertyName="Value" />
                                                                            <asp:ControlParameter ControlID="DateTimeLabel" Name="Date" PropertyName="Text" />
                                                                            <asp:ControlParameter ControlID="Yearly_NoLabel" Name="YearlyNo" PropertyName="Text" />
                                                                        </SelectParameters>
                                                                    </asp:SqlDataSource>
                                                                </ItemTemplate>
                                                            </asp:DataList>
                                                            <asp:SqlDataSource ID="SqlDataSource_RadiologyTest" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                                                ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                                                SelectCommand="SELECT DISTINCT Radiology_Order_Main.YearlyNo AS Yearly_No, CONVERT (varchar, Radiology_Order_Main.Date_Time, 103) AS DateTime, Radiology_Order_Main.RegNo AS Reg_No, Radiology_Order_Main.DeptId, ISNULL(admin_Hospital_Wards.Ward_Name, '') + ' ( ' + ISNULL(Ward_Beds.Bed_No, '') + ' ) ' AS patientWardbed, Patient.Prefix, Patient.PFName, Patient.PMName, Patient.PLName, Patient.Age FROM Patient INNER JOIN Radiology_Order_Main ON Patient.RegNo = Radiology_Order_Main.RegNo LEFT OUTER JOIN Ward_Beds INNER JOIN Pt_Assign_Bed ON Ward_Beds.Bed_id = Pt_Assign_Bed.Bed_id AND Ward_Beds.ward_Id = Pt_Assign_Bed.Ward_id INNER JOIN admin_Hospital_Wards ON Ward_Beds.ward_Id = admin_Hospital_Wards.Ward_id INNER JOIN SubDepartment ON admin_Hospital_Wards.SubDept_Id = SubDepartment.SubDept_Id AND admin_Hospital_Wards.Dept_Id = SubDepartment.Dept_Id INNER JOIN Department ON SubDepartment.Dept_Id = Department.Dept_ID ON Radiology_Order_Main.RegNo = Pt_Assign_Bed.Reg_No AND Radiology_Order_Main.YearlyNo = Pt_Assign_Bed.Yearly_No WHERE (Radiology_Order_Main.DeptId = @Dept_ID) AND (CONVERT (varchar, Radiology_Order_Main.Date_Time, 103) = CONVERT (varchar, GETDATE(), 103))">
                                                                <SelectParameters>
                                                                    <asp:SessionParameter Name="Dept_ID" SessionField="Dept_ID" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                        </div>
                                                    </div>
                                                    <!--End Radiology Test-->
                                                    <br />
                                                    <div class="bx_infos_patients">
                                                        <h2>
                                                            <span>Operation List</span></h2>
                                                        <div style="margin-top: 10px; height: auto" class="bxinfo_margin">
                                                            <asp:DataList ID="DataList_OperationList" runat="server" Width="100%">
                                                                <ItemTemplate>
                                                                    <div class="bx_oplist" style="margin-top: 2px;">
                                                                        <asp:LinkButton ID="lnkPrefix" runat="server" CommandName="Select" Style="margin-left: 8px;"
                                                                            Text='<%# Eval("Prefix") %>' OnClick="lnkPrefix_Click"></asp:LinkButton>
                                                                        (<span class="ward">
                                                                            <asp:Label ID="Label_Ward_Name" runat="server" Text='<%# Eval("Ward_Name") %>'></asp:Label>
                                                                            /
                                                                            <asp:Label ID="Label_Bed_No" runat="server" ToolTip="Bed Number" Text='<%# Eval("Bed_No") %>'></asp:Label>
                                                                        </span>)
                                                                        <ul id="CollapsiblePanel_<%# Eval("YearlyNo") %>">
                                                                            <li><span style="font-size: 10px; color: #666666; display: block;">( From Time :
                                                                                <asp:Label ID="lblStratTime" runat="server" Text='<%# Eval("From_Time") %>'></asp:Label>
                                                                                ) ( To Time :
                                                                                <asp:Label ID="lblEndTime" runat="server" Text='<%# Eval("To_Time") %>'></asp:Label>
                                                                                )
                                                                                <asp:Label ID="Label_ExpectedOpDate" runat="server" CssClass="date" ToolTip="Expected Operation Date"
                                                                                    Text='<%# Eval("ExpectedOpDate") %>'></asp:Label>
                                                                            </span></li>
                                                                            <li>
                                                                                <asp:Label ID="Label_Urgency" runat="server" Style="color: #d73c3d;" Text='<%# Eval("Urgency") %>'></asp:Label>
                                                                                (
                                                                                <asp:Label ID="Label_Procedure_Name" Style="color: #0e5b87;" ToolTip="Procedure Name"
                                                                                    runat="server" Text='<%# Eval("Procedure_Name") %>'></asp:Label>
                                                                                )
                                                                                <div style="font-size: 10px; color: #6a6666;">
                                                                                    <asp:Label ID="Label_RegNo" ToolTip="Registration Number" runat="server" Text='<%# Eval("RegNo") %>'></asp:Label>
                                                                                    (
                                                                                    <asp:Label ID="Label_YearlyNo" runat="server" Style="color: #000;" ToolTip="Yearly Number"
                                                                                        Text='<%# Eval("YearlyNo") %>'></asp:Label>
                                                                                    )
                                                                                </div>
                                                                            </li>
                                                                        </ul>

                                                                        <script type='text/javascript'>var CollapsiblePanel_<%# Eval("YearlyNo") %> = new Spry.Widget.CollapsiblePanel('CollapsiblePanel_<%# Eval("YearlyNo") %>',{contentIsOpen:false});</script>

                                                                    </div>
                                                                </ItemTemplate>
                                                            </asp:DataList>
                                                            <br />
                                                        </div>
                                                    </div>
                                                    <!--End Info block-->
                                                    <br />
                                                    <div class="bx_infos_patients">
                                                        <h2>
                                                            <span>Doctor Information</span></h2>
                                                        <div style="height: auto" class="bxinfo_margin">
                                                            <asp:DataList ID="DataList_Search" runat="server" DataSourceID="SqlDataSource_DataListSearch"
                                                                Width="100%" RepeatLayout="Flow">
                                                                <ItemTemplate>
                                                                    <div class="bx_doctor">
                                                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                            <tr>
                                                                                <td valign="top" align="center" style="width: 75px;">
                                                                                    <img src="images_hacims/docpic.jpg" width="59" height="72" style="margin-top: 4px;" /></td>
                                                                                <td valign="top">
                                                                                    <ul>
                                                                                        <li><span class="name">
                                                                                            <asp:Label ID="Label_Designation" runat="server" Text='<%# Eval("Designation_Name") %>'></asp:Label>
                                                                                            <asp:Label ID="Label_Name" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                                                                                        </span><span style="color: #0658a8">(
                                                                                            <asp:Label ID="Label_Department" runat="server" Text='<%# Eval("Dept_Name") %>'></asp:Label>
                                                                                            <asp:HiddenField ID="HiddenField_Emp_ID" runat="server" Value='<%# Eval("EmpID") %>' />
                                                                                            )</span></li>
                                                                                        <asp:DataList ID="DataList_Dist_Ser" runat="server" DataSourceID="SqlDataSource_Deg_Dist_Ser">
                                                                                            <ItemTemplate>
                                                                                                <li>
                                                                                                    <asp:Label ID="Label_deg" runat="server" Text='<%# Eval("Degree") %>'></asp:Label>
                                                                                                </li>
                                                                                                <li>
                                                                                                    <asp:Label ID="Label_Dis" runat="server" Text='<%# Eval("Distinction") %>'></asp:Label>
                                                                                                </li>
                                                                                                <li class="services">
                                                                                                    <asp:Label ID="Label_ser" runat="server" Text='<%# Eval("Services") %>'></asp:Label>
                                                                                                </li>
                                                                                            </ItemTemplate>
                                                                                        </asp:DataList>
                                                                                        <asp:DataList ID="DataList_Description" runat="server" DataSourceID="SqlDataSource_Description">
                                                                                            <ItemTemplate>
                                                                                                <li class="profile">
                                                                                                    <asp:Label ID="Label_Description" runat="server" Text='<%# Eval("Description") %>'></asp:Label>
                                                                                                </li>
                                                                                            </ItemTemplate>
                                                                                        </asp:DataList>
                                                                                    </ul>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </div>
                                                                    <asp:SqlDataSource ID="SqlDataSource_Description" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                                                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                                                        SelectCommand="SELECT Emp_Information AS Description FROM Employee_Other_Info WHERE (Emp_id = @Emp_id) AND (Emp_info_Type_id = 4)">
                                                                        <SelectParameters>
                                                                            <asp:ControlParameter ControlID="HiddenField_Emp_ID" Name="Emp_id" PropertyName="Value" />
                                                                        </SelectParameters>
                                                                    </asp:SqlDataSource>
                                                                    <asp:SqlDataSource ID="SqlDataSource_Deg_Dist_Ser" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                                                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                                                        SelectCommand="SELECT (CASE WHEN (Emp_info_Type_id = 1) THEN Emp_Information ELSE '' END) AS Degree, (CASE WHEN (Emp_info_Type_id = 2) THEN Emp_Information ELSE '' END) AS Distinction, (CASE WHEN (Emp_info_Type_id = 3) THEN Emp_Information ELSE '' END) AS Services FROM Employee_Other_Info WHERE (Emp_id = @Emp_id) AND (Emp_info_Type_id <> 4)">
                                                                        <SelectParameters>
                                                                            <asp:ControlParameter ControlID="HiddenField_Emp_ID" Name="Emp_id" PropertyName="Value" />
                                                                        </SelectParameters>
                                                                    </asp:SqlDataSource>
                                                                </ItemTemplate>
                                                            </asp:DataList>
                                                            <asp:SqlDataSource ID="SqlDataSource_DataListSearch" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                                                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                                                SelectCommand="SELECT name, Dept_Name, DeptID, SexID, Designation_Name, EmpID FROM (SELECT ISNULL(Employee.Prefix, '') + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS name, ISNULL(Department.Dept_Name, '') AS Dept_Name, Employee.DeptID, Employee.SexID, ISNULL(Designation.Designation_Name, '') AS Designation_Name, Employee.EmpID FROM Employee INNER JOIN Department ON Employee.DeptID = Department.Dept_ID INNER JOIN Designation ON Employee.DesignationID = Designation.Designation_ID WHERE (Employee.Profession_Code = 1)) AS tblview WHERE (EmpID = @EmpID)">
                                                                <SelectParameters>
                                                                    <asp:ControlParameter ControlID="HiddenField_EmpId" Name="EmpID" PropertyName="Value" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                            <asp:HiddenField ID="HiddenField_EmpId" runat="server" Value="665"></asp:HiddenField>
                                                        </div>
                                                    </div>
                                                    <!--End Docotor Info-->
                                                </td>
                                                <td valign="top" width="50%">
                                                    <div class="bx_infos_patients">
                                                        <h2>
                                                            <span>Calls</span></h2>
                                                        <div style="height: auto" class="bxinfo_margin">
<asp:DataList ID="DataList_DOCTOR_CALL" runat="server" DataSourceID="SqlDataSource_DOCTOR_CALL" Width="100%">
<ItemTemplate>
<div class="bx_pathology">
<asp:LinkButton ID="LinkButton_Patient" Style="margin-left: 10px;" runat="server"  ToolTip="Patient Name" CommandName="Select">LinkButton</asp:LinkButton>
                                                                        <ul id="CollapsiblePanel_a<%# Eval("YearlyNo") %>">
                                                                            <li><span class="name"></span>( <span class="ward">
                                                                                <asp:Label ID="AgeLabel" runat="server" Text='<%# Eval("Age") %>' ToolTip="Patient Age"></asp:Label>
                                                                                Year </span>) (<span class="ward">
                                                                                    <asp:Label ID="Ward_NameLabel" runat="server" Text='<%# Eval("Ward_Name") %>' ToolTip="Ward Name"></asp:Label>
                                                                                    /
                                                                                    <asp:Label ID="Bed_NoLabel" runat="server" Text='<%# Eval("Bed_No") %>' ToolTip="Bed Number"></asp:Label>
                                                                                </span>)</li><li style="font-size: 11px;">
                                                                                <asp:Label ID="CallBYLabel" ToolTip="Call By" runat="server" Text='<%# Eval("CallBY") %>'></asp:Label>
                                                                                    |
                                                                                <asp:Label ID="CallByDepartmentLabel" runat="server" ToolTip="Call by Department"
                                                                                    Text='<%# Eval("CallByDepartment") %>'></asp:Label>
                                                                                    |
                                                                                <asp:Label ID="Label_CallType" ToolTip="Call Type" runat="server" Text='<%# Eval("Call_Type") %>'></asp:Label>
                                                                                    |
                                                                                <asp:Label ID="Label_CallDate" ToolTip="Call Type" runat="server" Text='<%# Eval("CallDate") %>'></asp:Label>
                                                                                    |
                                                                                <asp:Label ID="CallTimeLabel" runat="server" ToolTip="Call Time" Text='<%# Eval("CallTime") %>'></asp:Label>
                                                                                <asp:HiddenField ID="hfPrefix" runat="server" Value='<%# Eval("Prefix") %>' />
                                                                                <asp:HiddenField ID="HiddenField_Reg_No" runat="server" Value='<%# Eval("RegNo") %>' />
                                                                                <asp:HiddenField ID="HiddenField_PFName" runat="server" Value='<%# Eval("PFName") %>' />
                                                                                <asp:HiddenField ID="HiddenField_PMName" runat="server" Value='<%# Eval("PMName") %>' />
                                                                                <div style="display: block;">
                                                                                    (MR#
                                                                                    <asp:Label ID="Label_RegNo" runat="server" ToolTip="Registration Number" Style="font-size: 10px;
                                                                                        color: #6a6666"></asp:Label>
                                                                                    Yearly #
                                                                                    <asp:Label ID="Label_YearlyNo" runat="server" ToolTip="Yearly Number" Text='<%# Eval("YearlyNo") %>'></asp:Label>)
                                                                                </div>
                                                                            </li>
                                                                        </ul>
                                                                        <asp:HiddenField ID="HiddenField_PLName" runat="server" Value='<%# Eval("PLName") %>' />

<script type='text/javascript'>var CollapsiblePanel_a<%# Eval("YearlyNo") %> = new Spry.Widget.CollapsiblePanel('CollapsiblePanel_a<%# Eval("YearlyNo") %>',{contentIsOpen:false});</script></div>
</ItemTemplate>
</asp:DataList>
</div>
                                                        <asp:SqlDataSource ID="SqlDataSource_DOCTOR_CALL" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                                            ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                                            SelectCommand="Select_Doctor_Call_XML_New" SelectCommandType="StoredProcedure">
                                                            <SelectParameters>
                                                                <asp:SessionParameter DefaultValue="" Name="Doctor_ID" SessionField="Emp_id" Type="Int32" />
                                                                <asp:SessionParameter Name="Call_To_Dept" SessionField="Dept_Id" Type="Int32" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </div>
                                                    <!--End calls Info-->
                                                    <br />
                                                    <div class="bx_infos_patients">
                                                        <h2>
                                                            <span>Correspondence</span>
                                                            <asp:LinkButton Style="float: right; margin-right: 5px; display:none;" ID="lbtnMessage" runat="server"
                                                                CssClass="ic_addmsg">New Message</asp:LinkButton>
                                                        </h2>
                                                        <div style="height: auto" class="bxinfo_margin">
                                                            <asp:Label ID="Label_Message" runat="server"></asp:Label>
                                                        </div>
                                                    </div>
                                                    <!--End Correspondanc Info-->
                                                    <br />
                                                    <div class="bx_infos_patients">
                                                        <h2>
                                                            <span>Tasks</span>
                                                            <asp:LinkButton Style="float: right; margin-right: 5px;display:none;" ID="lbtn_Meeting" runat="server"
                                                                CssClass="ic_addmet">New Meeting</asp:LinkButton>
                                                        </h2>
                                                        <div style="height: auto" class="bxinfo_margin">
                                                            <asp:Label ID="LabelMeeting" runat="server"></asp:Label>
                                                        </div>
                                                    </div>
                                                    <!--End Tasks Info-->
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <br />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </tbody>
    </table>
    
    
    
    <asp:Panel ID="PanelMessage" runat="server" CssClass="lightbox_bg" Visible="false">
        <div class="lightbox">
            <br />
            
         <div id="TabbedPanels1" class="TabbedPanels">
          <ul class="TabbedPanelsTabGroup" style="margin-left:10px;">
            <li class="TabbedPanelsTab" tabindex="0">Add New Message</li><li class="TabbedPanelsTab" tabindex="0">Previous Messages</li></ul>
       
          <div class="TabbedPanelsContentGroup" style="height:auto;">
          
            <div class="TabbedPanelsContent">  
         
            
            
            <table cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
                <tr>
                    <td width="35%" align="right">
                        Message Text :
                    </td>
                    <td width="65%" colspan="3" align="left">
                        <asp:TextBox ID="TextBoxMessageText" TextMode="MultiLine" MaxLength="300" Height="65px"
                            Width="80%" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td align="right">
                        Message Date :
                    </td>
                    <td colspan="3" align="left">
                        <igsch:WebDateChooser ID="WebDateChooser1" runat="server">
                            <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                        </igsch:WebDateChooser>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Message To :
                    </td>
                    <td colspan="3" align="left">
                        <asp:DropDownList ID="DropDownListDepartment" runat="server" AutoPostBack="True"
                            DataSourceID="SqlDataSourceDept" DataTextField="Dept_Name" DataValueField="Dept_ID">
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td colspan="4" align="center">
                        <div style="height: 200px; overflow: auto; overflow-x: hidden; margin-left: 10px;
                            margin-top: 10px; margin-bottom: 7px;">
                            <asp:CheckBoxList ID="CheckBoxListEmployee" runat="server" DataSourceID="SqlDataSourceMessageTo"
                                DataTextField="Name" DataValueField="EmpID" RepeatColumns="2" RepeatDirection="Horizontal">
                            </asp:CheckBoxList>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" align="center">
                        <asp:Button ID="ButtonAdd" runat="server" Text="Add Recipients" CssClass="btn_1" />
                        <asp:Button ID="ButtonSave" runat="server" CssClass="btn_1" Text="Send Message" />
                      <br />
                        <asp:Label ID="lblAddRecipents" runat="server"></asp:Label></td>
                </tr>
            </table> </div>    
            <div class="TabbedPanelsContent">    <asp:GridView ID="gvOldMessages" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceInsert_Message_Main"
                Width="98%">
                <Columns>
                    <asp:TemplateField HeaderText="Sr. No.">
                        <ItemTemplate>
                            <%# Container.DataItemIndex + 1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Msg_Date" HeaderText="Message Date" SortExpression="Msg_Date" />
                    <asp:BoundField DataField="Msg_text" HeaderText="Message" SortExpression="Msg_text" />
                    <asp:TemplateField HeaderText="Recipients">
                        <ItemTemplate>
                            <asp:Label ID="lblShort" runat="server" Text='<%# Eval("Recipents") %>'></asp:Label><asp:Label
                                ID="lblLong" runat="server" Text='<%# Eval("Recipents") %>' Visible="False"></asp:Label>
                            <asp:LinkButton ID="lblViewCompleteRecipients" runat="server" OnClick="lblViewCompleteRecipients_Click"
                                Visible="False">View Complete</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView></div>  
            
            
          </div></div>  
          <div align="center">  <asp:Button ID="btnCloseMessagePanel" runat="server" Text="Close" CssClass="btn_1" /></div>  
            
          
        </div>
    </asp:Panel>
    
    
    
    <asp:Panel ID="PanelMeeting" runat="server" CssClass="lightbox_bg" Visible="False">
        <div class="lightbox">
            <br />
            
        <div id="TabbedPanels2" class="TabbedPanels">
          <ul class="TabbedPanelsTabGroup" style="margin-left:10px;">
            <li class="TabbedPanelsTab" tabindex="0">Add New Meeting</li><li class="TabbedPanelsTab" tabindex="0">Previous Messages</li></ul>
       
          <div class="TabbedPanelsContentGroup" style="height:auto;">
          
            <div class="TabbedPanelsContent">
            <table cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
                <tr>
                    <td width="35%" align="right">
                        Subject :
                    </td>
                    <td>
                        <asp:TextBox ID="TextBoxMeetingSub" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td align="right">
                        Location :
                    </td>
                    <td>
                        <asp:TextBox ID="TextBoxMeetLoc" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td align="right">
                        Date :
                    </td>
                    <td>
                        <igsch:WebDateChooser ID="WebDateChooserMeetingDate" runat="server">
                        </igsch:WebDateChooser>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Start Time :
                    </td>
                    <td>
                        <igtxt:WebDateTimeEdit ID="WebDateTimeEditMeetingStart" runat="server" EditModeFormat="t"
                            CssClass="input_txt">
                        </igtxt:WebDateTimeEdit>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        End Time :
                    </td>
                    <td>
                        <igtxt:WebDateTimeEdit ID="WebDateTimeEditMeetingEnd" runat="server" EditModeFormat="t"
                            CssClass="input_txt">
                        </igtxt:WebDateTimeEdit>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        ChairPerson :
                    </td>
                    <td s>
                        <asp:DropDownList ID="DropDownListChairPerson" runat="server" DataSourceID="SqlDataSourceChairPerson"
                            DataTextField="Name" DataValueField="EmpID">
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td align="right">
                        Attendies :
                    </td>
                    <td>
                        <asp:DropDownList ID="DropDownListMeetingDept" runat="server" DataSourceID="SqlDataSourceDept"
                            DataTextField="Dept_Name" DataValueField="Dept_ID" AutoPostBack="True">
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <div style="height: 150px; overflow: auto; overflow-x: hidden; margin-left: 10px;
                            margin-top: 10px; margin-bottom: 7px;">
                            <asp:CheckBoxList ID="CheckBoxListAttendies" runat="server" DataSourceID="SqlDataSourceAttendies"
                                DataTextField="Name" DataValueField="EmpID" RepeatColumns="4" RepeatDirection="Horizontal"
                                Width="50%" AutoPostBack="True">
                            </asp:CheckBoxList>
                            <asp:GridView ID="gvMeetingRecipients" runat="server" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr. No.">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderText="Name" DataField="Name" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lbtnDeleteMeetingRecipents" runat="server" OnClick="lbtnDeleteMeetingRecipents_Click">Delete</asp:LinkButton>
                                            <asp:Label ID="lblEmp_ID" runat="server" Text='<%# Eval("Emp_ID") %>' Visible="False"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <asp:Button ID="ButtonAddAttendies" runat="server" Text="Add Attendies" Visible="False" />
                        <asp:Button ID="ButtonSaveMeeting" runat="server" Text="Save" />
                        
                        <asp:Label ID="lblMeetingMessage" runat="server" Font-Bold="True"></asp:Label></td>
                </tr>
            </table>
            <asp:SqlDataSource ID="SqlDataSourceChairPerson" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                SelectCommand="SELECT     EmpID, Treatment.dbo.Emp_Name(EmpID) AS Name&#13;&#10;FROM         Employee AS e&#13;&#10;WHERE e.Emp_Type = 'Consultant'&#13;&#10;ORDER BY Name">
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceAttendies" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                SelectCommand="SELECT EmpID, ISNULL(Prefix, '') + ' ' + ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS Name FROM Employee WHERE (DeptID = @DeptID) ORDER BY Name">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownListMeetingDept" Name="DeptID" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:HiddenField ID="HiddenFieldMeetingAttendies" runat="server" />
            <asp:HiddenField ID="HiddenFieldMeetingDate" runat="server" />
            <asp:HiddenField ID="HiddenFieldStartTime" runat="server" />
            <asp:HiddenField ID="HiddenFieldEndTime" runat="server" />
            <asp:SqlDataSource ID="SqlDataSourceInsert_MeetingMain" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                InsertCommand="Insert_Meeting_Main" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="SELECT Top(20) mm.Subject,mm.Location, CONVERT(varchar,mm.Start_Date,107) AS Start_Date,CONVERT(varchar,mm.Start_Time,108) + ' to ' + CONVERT(varchar,mm.End_Time,108) AS MeetingTime,treatment.dbo.Emp_Name(mm.ChairmanShip_ID) AS ChairPerson, dbo.GET_Meeting_ToRecipeantNames(mm.Meeting_ID)&#13;&#10;FROM Meeting_Main mm&#13;&#10;WHERE mm.Emp_ID = @Emp_ID ">
                <InsertParameters>
                    <asp:ControlParameter ControlID="TextBoxMeetingSub" Name="Subject" PropertyName="Text"
                        Type="String" />
                    <asp:ControlParameter ControlID="TextBoxMeetLoc" Name="Location" PropertyName="Text"
                        Type="String" />
                    <asp:ControlParameter ControlID="HiddenFieldStartTime" Name="Start_Time" PropertyName="Value"
                        Type="DateTime" />
                    <asp:ControlParameter ControlID="HiddenFieldEndTime" Name="End_Time" PropertyName="Value"
                        Type="DateTime" />
                    <asp:ControlParameter ControlID="HiddenFieldMeetingDate" Name="Start_Date" PropertyName="Value"
                        Type="DateTime" />
                    <asp:ControlParameter ControlID="DropDownListChairPerson" Name="ChairmanShip_ID"
                        PropertyName="SelectedValue" Type="Int32" />
                    <asp:SessionParameter Name="Emp_ID" SessionField="Emp_ID" Type="Int32" />
                    <asp:Parameter Direction="Output" Name="Meeting_Id" Type="Int32" />
                </InsertParameters>
                <SelectParameters>
                    <asp:SessionParameter Name="Emp_ID" SessionField="Emp_ID" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceIsert_MeetingSub" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                InsertCommand="Insert_Meeting_Sub" InsertCommandType="StoredProcedure">
                <InsertParameters>
                    <asp:ControlParameter ControlID="HiddenFieldMeetingAttendies" Name="Emp_ID" PropertyName="Value"
                        Type="Int32" />
                    <asp:ControlParameter ControlID="HiddenFieldMeetingID" Name="Meeting_ID" PropertyName="Value"
                        Type="Int32" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:HiddenField ID="HiddenFieldMeetingID" runat="server" />
            <asp:HiddenField ID="HiddenFieldAttendiesID" runat="server" />   </div>    
              <div class="TabbedPanelsContent">             
            <asp:GridView ID="gvOldMeetingList" runat="server" AutoGenerateColumns="False" Width="98%" DataSourceID="SqlDataSourceInsert_MeetingMain">
                <Columns>
                    <asp:BoundField DataField="Subject" HeaderText="Subject" SortExpression="Subject" />
                    <asp:BoundField DataField="Location" HeaderText="Location" SortExpression="Location" />
                    <asp:BoundField DataField="Start_Date" HeaderText="Meeting Date" ReadOnly="True"
                        SortExpression="Start_Date" />
                    <asp:BoundField DataField="MeetingTime" HeaderText="Meeting Time" ReadOnly="True"
                        SortExpression="MeetingTime" />
                    <asp:BoundField DataField="ChairPerson" HeaderText="ChairPerson" ReadOnly="True"
                        SortExpression="ChairPerson" />
                    <asp:BoundField DataField="Column1" HeaderText="Meeting Recipients" ReadOnly="True"
                        SortExpression="Column1" />
                </Columns>
            </asp:GridView>  </div>   
          </div></div>  
            
<div align="center">  <asp:Button ID="btnCloseMeetingPanel" runat="server" Text="Close" /></div>
           
            
        </div>
    </asp:Panel>
    <asp:SqlDataSource ID="SqlDataSourceDept" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT Dept_ID, Dept_Name FROM Department Order By Dept_Name "></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceMessageTo" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT EmpID, ISNULL(Prefix, '') + ' ' + ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS Name FROM Employee WHERE (DeptID = @DeptID) ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListDepartment" Name="DeptID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceInsert_Message_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        InsertCommand="Insert_Emp_Message_Sub" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenFieldMessage_ID" Name="Msg_Id" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="HiddenFieldMessageTo" DefaultValue="" Name="Emp_To"
                PropertyName="Value" Type="Int32" />
            <asp:Parameter DefaultValue="true" Name="Msg_Status" Type="Boolean" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceInsert_Message_Main" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        InsertCommand="Insert_Emp_Message_Main" InsertCommandType="StoredProcedure" SelectCommand="SELECT  TOP(20)   Msg_text, CONVERT(varchar,Msg_Date,107) AS Msg_Date,dbo.GET_Msg_ToRecipeantNames(emm.Msg_id) AS Recipents&#13;&#10;FROM         Emp_Messages_Main AS emm&#13;&#10;WHERE emm.By_Emp = @By_Emp&#13;&#10;ORDER BY emm.Msg_Date DESC ">
        <InsertParameters>
            <asp:ControlParameter ControlID="TextBoxMessageText" Name="Msg_text" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="HiddenFieldDate" Name="Msg_Date" PropertyName="Value"
                Type="DateTime" />
            <asp:SessionParameter Name="By_Emp" SessionField="emp_id" Type="Int32" />
            <asp:Parameter DefaultValue="1" Name="Msg_Type" Type="Int32" />
            <asp:Parameter DefaultValue="" Direction="InputOutput" Name="Message_Id" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter Name="By_Emp" SessionField="Emp_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    &nbsp;<asp:HiddenField ID="HiddenFieldMessageToStr" runat="server"></asp:HiddenField>
    <asp:HiddenField ID="HiddenFieldDate" runat="server"></asp:HiddenField>
    <asp:HiddenField ID="HiddenFieldMessage_ID" runat="server"></asp:HiddenField>
    <asp:HiddenField ID="HiddenFieldMessageTo" runat="server"></asp:HiddenField>

    <script type="text/javascript">
<!--
var CollapsiblePanel1 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel1",{contentIsOpen:false});

//-->
    </script>
     
      <script type="text/javascript">
<!--
var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1", {defaultTab:0});
//-->
  </script>
  
  <script type="text/javascript">
var cookies = Spry.Utils.Cookie("read","tabbedpanels");
var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1", { defaultTab: cookies ? parseFloat(cookies) : 0 });
Spry.Utils.addUnLoadListener(function(){
    // save the current value
    Spry.Utils.Cookie('create','tabbedpanels',TabbedPanels1.getCurrentTabIndex());
});

</script>

 <script type="text/javascript">
<!--
var TabbedPanels2 = new Spry.Widget.TabbedPanels("TabbedPanels2", {defaultTab:0});
//-->
  </script>
  
  <script type="text/javascript">
var cookies = Spry.Utils.Cookie("read","tabbedpanels");
var TabbedPanels2 = new Spry.Widget.TabbedPanels("TabbedPanels2", { defaultTab: cookies ? parseFloat(cookies) : 0 });
Spry.Utils.addUnLoadListener(function(){
    // save the current value
    Spry.Utils.Cookie('create','tabbedpanels',TabbedPanels2.getCurrentTabIndex());
});

</script>

</asp:Content>
