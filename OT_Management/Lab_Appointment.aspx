<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Lab_Appointment.aspx.vb"
    MasterPageFile="~/hacims_masterpage.master" Inherits="Lab_Appointment" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {


            $(".openimages").colorbox({ width: "920px", height: "90%", iframe: true });
            $(".openimages").colorbox({ onClosed: function () { window.reload(); }
            });

        });
    </script>
    <script language="javascript" type="text/javascript">
        function OpenNewPage() {
            var regno = document.getElementById("HiddenFieldRegNo").value;
            var yearlyno = document.getElementById("HiddenFieldYearlyNo").value;
            window.open("", "MyWidows")

        }
    </script>
    <style type="text/css" media="screen">
        .medication
        {
            margin-left: 0px;
        }
        .medication li span
        {
            color: #333;
            padding-left: 0px;
            padding-right: 0px;
        }
        .medication li .span
        {
            color: #cccccc;
            padding-left: 10px;
            padding-right: 10px;
        }
        .list_style
        {
            background-color: #b9daff;
        }
    </style>
    <script src="../css_hacims/ck.js" type="text/javascript"></script>
    <script src="../SpryAssets/mycollaps.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="leftnav" valign="top">
                <asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
            </td>
            <td style="width: auto;" valign="top">
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                    <tr>
                        <td valign="top" width="60%">
                            <asp:DataList ID="DataList1" runat="server" DataKeyField="ID" RepeatLayout="Table"
                                AlternatingItemStyle-CssClass="list_style" DataSourceID="SqlDataSource_Booking_Service"
                                CellPadding="4">
                                <ItemTemplate>
                                    <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" style="margin-top: 5px;
                                        margin-bottom: 5px;">
                                        <tr>
                                            <td align="right" width="25%">
                                                Name :
                                            </td>
                                            <td width="25%">
                                                <asp:Label ID="TB_NameLabel" runat="server" Text='<%# Eval("TB_Name") %>'></asp:Label>
                                            </td>
                                            <td align="right" width="25%">
                                                Group Name :
                                            </td>
                                            <td align="left" width="25%">
                                                <asp:Label ID="TGNameLabel" runat="server" Text='<%# Eval("TGName") %>'></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                Appointment Date :
                                            </td>
                                            <td>
                                                <igsch:WebDateChooser ID="WebDateChooser_AppointmentDate" runat="server" OnValueChanged="WebDateChooser_AppointmentDate_ValueChanged">
                                                    <CalendarLayout Culture="English (United Kingdom)">
                                                    </CalendarLayout>
                                                    <AutoPostBack ValueChanged="True" />
                                                </igsch:WebDateChooser>
                                            </td>
                                            <td align="right">
                                                Appointment Time :
                                            </td>
                                            <td>
                                                <igtxt:WebDateTimeEdit ID="WebDateTimeEdit_Appointment_time" runat="server" EditModeFormat="t">
                                                </igtxt:WebDateTimeEdit>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                Report Date :
                                            </td>
                                            <td>
                                                <igsch:WebDateChooser ID="WebDateChooser_ReportDate" runat="server">
                                                    <CalendarLayout Culture="English (United Kingdom)">
                                                    </CalendarLayout>
                                                </igsch:WebDateChooser>
                                            </td>
                                            <td align="right">
                                                Report Time :
                                            </td>
                                            <td>
                                                <igtxt:WebDateTimeEdit ID="WebDateTimeEdit_Report_time" runat="server" EditModeFormat="t">
                                                </igtxt:WebDateTimeEdit>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                Doctor :
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlDoctor" runat="server" DataSourceID="SqlDataSource_Employee"
                                                    onChange="selectConsultant();" DataTextField="Employee Name" DataValueField="EmpID"
                                                    Width="225px" Height="26px">
                                                </asp:DropDownList>
                                            </td>
                                            <td align="right">
                                                Anesthesia Type :
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlAnesthesia" runat="server" DataSourceID="SqlDataSourceAnesthesia"
                                                    onChange="" DataTextField="Anesthesia_Desc" DataValueField="Anesthesia_Id" Width="225px"
                                                    Height="26px">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                OT Department :
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlOTDept" runat="server" DataSourceID="SqlDataSource_OTDept"
                                                    onChange="" DataTextField="OT_Dept_Name" DataValueField="OT_Dept_ID" Width="225px"
                                                    Height="26px">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                Remarks :
                                            </td>
                                            <td>
                                                <asp:TextBox ID="TextBox_Instructions" runat="server" Height="35px" TextMode="MultiLine"
                                                    Width="200px"></asp:TextBox>
                                            </td>
                                            <td align="right">
                                            </td>
                                            <td>
                                                <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal"
                                                    AutoPostBack="True" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged">
                                                    <asp:ListItem>Fit</asp:ListItem>
                                                    <asp:ListItem>Unfit</asp:ListItem>
                                                    <asp:ListItem Selected="True">None</asp:ListItem>
                                                </asp:RadioButtonList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                            </td>
                                            <td>
                                            </td>
                                            <td align="right">
                                            </td>
                                            <td>
                                                <asp:RadioButtonList ID="rblLab_Type" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblLab_Type_SelectedIndexChanged"
                                                    RepeatDirection="Horizontal" Visible="False">
                                                    <asp:ListItem Selected="True" Value="0">Internal Lab</asp:ListItem>
                                                    <asp:ListItem Value="1">External Lab</asp:ListItem>
                                                </asp:RadioButtonList>
                                                <br />
                                                <asp:DropDownList ID="ddlExternalLab" runat="server" DataTextField="External_Lab"
                                                    DataValueField="External_Lab_ID" Visible="False">
                                                </asp:DropDownList>
                                                &nbsp;
                                                <asp:HyperLink ID="hl_AddLab" runat="server" CssClass="openimages add_icon" NavigateUrl="~/Radiology/Add_External_Lab.aspx"
                                                    Visible="false">Add Lab.</asp:HyperLink>
                                                <asp:SqlDataSource ID="SQL_ExternalType" runat="server" ConnectionString="<%$ ConnectionStrings:OT_ManagementConnectionString %>"
                                                    SelectCommand="SELECT [External_Lab], [External_Lab_ID] FROM [Admin_External_Lab]">
                                                </asp:SqlDataSource>
                                            </td>
                                        </tr>
                                    </table>
                                    <div style="border-bottom: #999 dotted 1px;">
                                    </div>
                                    <asp:HiddenField ID="HiddenField_ID" runat="server" Value='<%# Eval("ID", "{0}") %>' />
                                    <asp:HiddenField ID="HiddenField_Main_ID" runat="server" Value='<%# Eval("Main_ID", "{0}") %>' />
                                    <asp:HiddenField ID="HiddenField_TB_ID" runat="server" Value='<%# Eval("TB_ID", "{0}") %>' />
                                    <asp:HiddenField ID="HiddenField_TGID" runat="server" Value='<%# Eval("TGID", "{0}") %>' />
                                    <asp:HiddenField ID="HiddenField_S_Id" runat="server" Value='<%# Eval("S_Id", "{0}") %>' />
                                </ItemTemplate>
                                <AlternatingItemStyle CssClass="list_style" />
                            </asp:DataList>
                            <br />
                            <div align="center">
                                <asp:Button ID="Button_Save" runat="server" Text="Save" /></div>
                        </td>
                        <td valign="top" align="left">
                            <asp:DataList ID="DataList_Final_List" runat="server" DataSourceID="SqlDataSource_Save_Sub"
                                Width="96%" Style="margin-left: 10px;">
                                <ItemTemplate>
                                    <ul class="medication">
                                        <li style="border-bottom: #cccccc dotted 1px; border-right: 0; border-left: 0; color: #d50000;">
                                            <strong class="mname">
                                                <asp:Label ID="Appointment_DateLabel" runat="server" Text='<%# Eval("Appointment_Date") %>'></asp:Label>
                                            </strong></li>
                                        <li>
                                            <asp:Label ID="TB_IDLabel" runat="server" Visible="false" Text='<%# Eval("TB_ID") %>'></asp:Label><span
                                                class="span">|</span> TB Name :
                                            <asp:Label ID="TB_NameLabel" runat="server" Text='<%# Eval("TB_Name") %>'></asp:Label>
                                            Report Date :
                                            <asp:Label ID="Report_DateLabel" runat="server" Text='<%# Eval("Report_Date") %>'>
                                            </asp:Label><span class="span">|</span> Instruction :
                                            <asp:Label ID="InstructionLabel" runat="server" Text='<%# Eval("Instruction") %>'>
                                            </asp:Label><span class="span">|</span> befor after :
                                            <asp:Label ID="befor_afterLabel" runat="server" Text='<%# Eval("befor_after") %>'>
                                            </asp:Label><span class="span">|</span> Status :
                                            <asp:Label ID="StatusLabel" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                                        </li>
                                        <br />
                                        <br />
                                        <br />
                                        <br />
                                    </ul>
                                </ItemTemplate>
                            </asp:DataList>
                        </td>
                    </tr>
                </table>
                <asp:SqlDataSource ID="SqlDataSource_Save_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:OT_ManagementConnectionString %>"
                    InsertCommand="INSERT INTO OT_Operation_Assign_Sub(ID, YearlyNo, RegNo, OperationNo) VALUES (@ID, @YearlyNo, @RegNo, @OperationNo)"
                    ProviderName="<%$ ConnectionStrings:OT_ManagementConnectionString.ProviderName %>"
                    SelectCommand="SELECT     Test_Booking.TB_ID, Test_Booking.TB_Name, Test_Booking_Services.Appointment_Date, Test_Booking_Services.Report_Date, Test_Booking_Services.Instruction, &#13;&#10;                      Test_Booking_Services.befor_after, Test_Booking_Services.Emp_ID, Path_Result_Delivery.Reg_no, Path_Result_Delivery.Yearly_No, Test_Status.Status&#13;&#10;FROM         Test_Booking_Services INNER JOIN&#13;&#10;                      Test_Booking ON Test_Booking_Services.TB_ID = Test_Booking.TB_ID INNER JOIN&#13;&#10;                      Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID INNER JOIN&#13;&#10;                      Test_Status ON Test_Booking_Services.Status_Id = Test_Status.Status_ID&#13;&#10;where (convert(varchar,Test_Booking_Services.Appointment_Date,101) = convert(varchar,convert(datetime, @appointment_time),101))&#13;&#10;">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="HiddenField_Date" Name="appointment_time" PropertyName="Value" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:ControlParameter ControlID="HiddenField_ID" Name="ID" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenField_YearlyNo" Name="YearlyNo" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenField_RegNO" Name="RegNo" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenField_OP_No" Name="OperationNo" PropertyName="Value" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenField_Date" runat="server" />
                <asp:SqlDataSource ID="SqlDataSource_Booking_Service" runat="server" ConnectionString="<%$ ConnectionStrings:OT_ManagementConnectionString %>"
                    SelectCommand="SELECT     Test_Booking.TB_Name, TestGroup.TGName, Test_Booking_Services.ID, Test_Status.Status, Test_Booking_Services.Main_ID,Test_Booking_Services.TB_ID,TestGroup.TGID,Test_Booking.S_Id FROM  Test_Booking_Services INNER JOIN Test_Booking ON Test_Booking_Services.TB_ID = Test_Booking.TB_ID INNER JOIN TestGroup ON Test_Booking.MG_ID = TestGroup.TGID INNER JOIN Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID INNER JOIN Test_Status ON Test_Booking_Services.Status = Test_Status.Status_ID WHERE (Path_Result_Delivery.Yearly_No = @YearlyNo) AND (Path_Result_Delivery.Reg_no = @RegNo) and (Test_Booking_Services.Status=14 or Test_Booking_Services.Status=12)  and Test_Booking_Services.Main_ID=@Main_ID"
                    DeleteCommand="DELETE FROM Test_Booking_Services WHERE (ID = @ID)" UpdateCommand="return_status"
                    UpdateCommandType="StoredProcedure" InsertCommand="INSERT_Pt_External_Lab_Record"
                    InsertCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                        <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                        <asp:SessionParameter Name="Main_ID" SessionField="main_ID" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:ControlParameter ControlID="GridView_Services" Name="ID" PropertyName="SelectedValue" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:SessionParameter Name="Main_ID" SessionField="Main_ID" Type="Int32" />
                        <asp:Parameter Direction="Output" Name="Status" Type="Int32" />
                        <asp:Parameter Direction="Output" Name="befor_after" Type="Boolean" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:ControlParameter ControlID="HiddenField_Ext_lab_ID" Name="External_Lab_ID" PropertyName="Value"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="HiddenField_Main_ID" Name="Main_ID" PropertyName="Value"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="HiddenField_TB_ID" Name="TB_ID" PropertyName="Value"
                            Type="Int32" />
                        <asp:SessionParameter Name="Emp_ID" SessionField="Emp_ID" Type="Int32" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenFieldRegNo" runat="server" />
                <asp:HiddenField ID="HiddenFieldYearlyNo" runat="server" />
                <asp:HiddenField ID="HiddenField_status" runat="server" />
                <asp:HiddenField ID="HiddenField_befor_after" runat="server" />
                <br>
                <asp:HiddenField ID="HiddenField_Ext_lab_ID" runat="server" />
                <asp:HiddenField ID="HiddenField_TB_ID" runat="server" />
                <asp:HiddenField ID="HiddenField_Main_ID" runat="server" />
            </td>
            <td style="width: auto" valign="top">
            </td>
        </tr>
    </table>
    <asp:Label ID="LabelFooter" runat="server" Text="Label"></asp:Label>
    <asp:SqlDataSource ID="SqlDataSource_Employee" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="Select_Consultant_SubDept" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="" Name="HospitalId" SessionField="HospitalId"
                Type="Int32" />
            <asp:SessionParameter DefaultValue="" Name="Subdeptid" SessionField="dept_id" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceAnesthesia" runat="server" ConnectionString="<%$ ConnectionStrings:OT_ManagementConnectionString %>"
        ProviderName="<%$ ConnectionStrings:OT_ManagementConnectionString.ProviderName %>"
        SelectCommand="select  Anesthesia_Id,  Anesthesia_Desc from [dbo].[Anesthesia_Type] where  Status=1"
        SelectCommandType="Text"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource_OTDept" runat="server" ConnectionString="<%$ ConnectionStrings:OT_ManagementConnectionString %>"
        ProviderName="<%$ ConnectionStrings:OT_ManagementConnectionString.ProviderName %>"
        SelectCommand="SELECT        OT_Department.OT_Dept_Name, OT_Department.OT_Dept_ID FROM  OT_Department INNER JOIN Admin_Dept_Merge ON OT_Department.OT_Dept_ID = Admin_Dept_Merge.Admin_OT_Dept_ID where Admin_Dept_Merge.[Admin_Dept_Binfo_ID]=@Subdeptid" SelectCommandType="Text">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="" Name="Subdeptid" SessionField="dept_id" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
