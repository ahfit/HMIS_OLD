<%@ page title="" language="VB" masterpagefile="~/hacims_demo.master" autoeventwireup="false" inherits="DemoHome, App_Web_tip0c1yj" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .ImgButtonMainPage
        {
            padding: 20px;
            padding-bottom: 5px;
        }
        .LinkBoxMainPage
        {
            color: Blue !important;
            text-align: center !important;
            vertical-align: top !important;
        }
        
        .LinkMainPage
        {
            text-decoration: none;
            color: Blue;
            font-weight: bold;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="width: 100%; margin: auto;">
        <table style="width: 95%; margin: auto;">
            <tr>
                <td>
                    <table style="width: 150px; border: 1px solid #00BFFF; margin-left: 30px;" cellpadding="0"
                        cellspacing="0">
                        <tr style='height: 24px; background: url("images_hacims/img_spltb.jpg") repeat-x scroll right top transparent;'>
                            <td style="color: White; font-weight: bold; padding-left: 10px;">
                                Patient Registration
                            </td>
                        </tr>
                        <tr>
                            <td class="ImgButtonMainPage" style="text-align: center;">
                                <asp:ImageButton ID="imgBtnReception" runat="server" ImageUrl="~/Images/Receptionist-icon.png" />
                            </td>
                        </tr>
                        <tr style="height: 20px;">
                            <td class="LinkBoxMainPage">
                                <asp:LinkButton ID="lnkReception" CssClass="LinkMainPage" runat="server" Text="Reception"></asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table style="width: 300px; border: 1px solid #00BFFF; margin-left: 30px;" cellpadding="0"
                        cellspacing="0">
                        <tr style='height: 24px; background: url("images_hacims/img_spltb.jpg") repeat-x scroll right top transparent;'>
                            <td colspan="2" style="color: White; font-weight: bold; padding-left: 10px;">
                                OPD
                            </td>
                        </tr>
                        <tr>
                            <td class="ImgButtonMainPage" style="text-align: center;">
                                <asp:ImageButton ID="imgAppointmentRegistration" runat="server" Width="72px" Height="72px"
                                    ImageUrl="~/Images/Medical Appointment Restrict.jpg" />
                            </td>
                            <td class="ImgButtonMainPage" style="text-align: center;">
                                <asp:ImageButton ID="imgDoctorOPD" runat="server" Width="72" Height="72" ImageUrl="~/Images/Head-physician-icon.png" />
                            </td>
                        </tr>
                        <tr style="height: 20px;">
                            <td class="LinkBoxMainPage" style="height: 20px">
                                <asp:LinkButton ID="lnkAppointmentRegistration" CssClass="LinkMainPage" runat="server"
                                    Text="Appointment & Registration"></asp:LinkButton>
                            </td>
                            <td class="LinkBoxMainPage" style="height: 20px">
                                <asp:LinkButton ID="lnkDoctorOPD" CssClass="LinkMainPage" runat="server" Text="Doctor"></asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table style="width: 500px; border: 1px solid #00BFFF; margin-left: 30px;" cellpadding="0"
                        cellspacing="0">
                        <tr style='height: 24px; background: url("images_hacims/img_spltb.jpg") repeat-x scroll right top transparent;'>
                            <td colspan="4" style="color: White; font-weight: bold; padding-left: 10px;">
                                Laboratory
                            </td>
                        </tr>
                        <tr>
                            <td class="ImgButtonMainPage" style="text-align: center;">
                                <asp:ImageButton ID="imgHaematology" runat="server" Width="72px" Height="72px" ImageUrl="~/Images/haematology.jpg" />
                            </td>
                            <td class="ImgButtonMainPage" style="text-align: center;">
                                <asp:ImageButton ID="imgBioChemistry" runat="server" Width="72" Height="72" ImageUrl="~/Images/biochemistry.jpg" />
                            </td>
                            <td class="ImgButtonMainPage" style="text-align: center;">
                                <asp:ImageButton ID="imgMicroBiology" Width="72" Height="72" runat="server" ImageUrl="~/Images/microbio.jpg" />
                            </td>
                            <td class="ImgButtonMainPage" style="text-align: center;">
                                <asp:ImageButton ID="imgHistoPithology" runat="server" Width="72px" Height="72px"
                                    ImageUrl="~/Images/histopathalogy.jpg" />
                            </td>
                        </tr>
                        <tr style="height: 20px;">
                            <td class="LinkBoxMainPage" style="height: 20px">
                                <asp:LinkButton ID="lnkHaematology" CssClass="LinkMainPage" runat="server" Text="Haematology"></asp:LinkButton>
                            </td>
                            <td class="LinkBoxMainPage" style="height: 20px">
                                <asp:LinkButton ID="lnkBiochemistry" CssClass="LinkMainPage" runat="server" Text="BioChemistry"></asp:LinkButton>
                            </td>
                            <td class="LinkBoxMainPage" style="height: 20px">
                                <asp:LinkButton ID="lnkMicrobiology" CssClass="LinkMainPage" runat="server" Text="MicroBiology"></asp:LinkButton>
                            </td>
                            <td class="LinkBoxMainPage" style="height: 20px">
                                <asp:LinkButton ID="lnkHistopithaology" CssClass="LinkMainPage" runat="server" Text="Histo-Phathology"></asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="height: 102px">
                    <table style="width: 150px; border: 1px solid #00BFFF; margin-left: 30px;" cellpadding="0"
                        cellspacing="0">
                        <tr style='height: 24px; background: url("images_hacims/img_spltb.jpg") repeat-x scroll right top transparent;'>
                            <td style="color: White; font-weight: bold; padding-left: 10px;">
                                Ward
                            </td>
                        </tr>
                        <tr>
                            <td class="ImgButtonMainPage" style="text-align: center;">
                                <asp:ImageButton ID="imgBtnNursing" runat="server" ImageUrl="~/Images/Medical-Nurse-Female-Light-icon.png" />
                            </td>
                        </tr>
                        <tr style="height: 20px;">
                            <td class="LinkBoxMainPage">
                                <asp:LinkButton ID="lnkNursing" CssClass="LinkMainPage" runat="server" Text="Nursing"></asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </td>
                <td style="height: 102px">
                    <table style="width: 300px; border: 1px solid #00BFFF; margin-left: 30px;" cellpadding="0"
                        cellspacing="0">
                        <tr style='height: 24px; background: url("images_hacims/img_spltb.jpg") repeat-x scroll right top transparent;'>
                            <td colspan="2" style="color: White; font-weight: bold; padding-left: 10px;">
                                IPD
                            </td>
                        </tr>
                        <tr>
                            <td class="ImgButtonMainPage" style="text-align: center;">
                                <asp:ImageButton ID="imgAdmission" runat="server" ImageUrl="~/Images/Receptionist-icon.png" />
                            </td>
                            <td class="ImgButtonMainPage" style="text-align: center;">
                                <asp:ImageButton ID="imgIPDDoctor" runat="server" Width="72px" Height="72" ImageUrl="~/Images/Head-physician-icon.png" />
                            </td>
                        </tr>
                        <tr style="height: 20px;">
                            <td class="LinkBoxMainPage">
                                <asp:LinkButton ID="LnkAddmission" CssClass="LinkMainPage" runat="server" Text="Admission"></asp:LinkButton>
                            </td>
                            <td class="LinkBoxMainPage">
                                <asp:LinkButton ID="lnkIPDDoctor" CssClass="LinkMainPage" runat="server" Text="Doctor"></asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </td>
                <td style="height: 102px">
                    <table>
                        <tr>
                            <td style="height: 133px">
                                <table style="width: 166px; border: 1px solid #00BFFF; margin-left: 28px;" cellpadding="0"
                                    cellspacing="0" id="TABLE1">
                                    <tr style='height: 24px; background: url("images_hacims/img_spltb.jpg") repeat-x scroll right top transparent;'>
                                        <td style="color: White; font-weight: bold; padding-left: 10px;">
                                            Radiology
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="ImgButtonMainPage" style="text-align: center;">
                                            <asp:ImageButton ID="imgBtnRadiology" runat="server" Width="72" Height="72" ImageUrl="~/Images/radiology_icon.jpg" />
                                        </td>
                                    </tr>
                                    <tr style="height: 20px;">
                                        <td class="LinkBoxMainPage">
                                            <asp:LinkButton ID="lnkRadiology" CssClass="LinkMainPage" runat="server" Text="Radiology"></asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="height: 133px">
                                <table style="width: 163px; border: 1px solid #00BFFF;" cellpadding="0" cellspacing="0">
                                    <tr style='height: 24px; background: url("images_hacims/img_spltb.jpg") repeat-x scroll right top transparent;'>
                                        <td style="color: White; font-weight: bold; padding-left: 10px;">
                                            Patient Billing
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="ImgButtonMainPage" style="text-align: center; height: 65px;">
                                            <asp:ImageButton ID="imgPatientBilling" Width="72" Height="72" runat="server" ImageUrl="~/Images/billing.png" />
                                        </td>
                                    </tr>
                                    <tr style="height: 20px;">
                                        <td class="LinkBoxMainPage" style="height: 20px">
                                            <asp:LinkButton ID="lnkPatientBilling" CssClass="LinkMainPage" runat="server" Text="Patient Billing"></asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="height: 133px">
                                <table style="width: 167px; border: 1px solid #00BFFF;" cellpadding="0" cellspacing="0">
                                    <tr style='height: 24px; background: url("images_hacims/img_spltb.jpg") repeat-x scroll right top transparent;'>
                                        <td style="color: White; font-weight: bold; padding-left: 10px;">
                                            Doctor Share
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="ImgButtonMainPage" style="text-align: center;">
                                            <asp:ImageButton ID="imgDoctorShare" runat="server" Width="72" Height="72" ImageUrl="~/Images/doctorshare.jpg" />
                                        </td>
                                    </tr>
                                    <tr style="height: 20px;">
                                        <td class="LinkBoxMainPage">
                                            <asp:LinkButton ID="lnkDoctorShare" CssClass="LinkMainPage" runat="server" Text="Doctor Share"></asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table style="width: 150px; border: 1px solid #00BFFF; margin-left: 28px;" cellpadding="0"
                        cellspacing="0">
                        <tr style='height: 24px; background: url("images_hacims/img_spltb.jpg") repeat-x scroll right top transparent;'>
                            <td style="color: White; font-weight: bold; padding-left: 10px;">
                                Administration
                            </td>
                        </tr>
                        <tr>
                            <td class="ImgButtonMainPage" style="text-align: center;">
                                <asp:ImageButton ID="imgAdministration" runat="server" ImageUrl="~/Images/administrator72.png" />
                            </td>
                        </tr>
                        <tr style="height: 20px;">
                            <td class="LinkBoxMainPage">
                                <asp:LinkButton ID="lnkAdministration1" CssClass="LinkMainPage" runat="server" Text="Administration"></asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table style="width: 300px; border: 1px solid #00BFFF; margin-left: 30px;" cellpadding="0"
                        cellspacing="0">
                        <tr style='height: 24px; background: url("images_hacims/img_spltb.jpg") repeat-x scroll right top transparent;'>
                            <td colspan="2" style="color: White; font-weight: bold; padding-left: 10px;">
                                Pharmacy
                            </td>
                        </tr>
                        <tr>
                            <td class="ImgButtonMainPage" style="text-align: center;">
                                <asp:ImageButton ID="imgMainStore" runat="server" Width="72px" Height="72px" ImageUrl="~/Images/mainstore.jpg" />
                            </td>
                            <td class="ImgButtonMainPage" style="text-align: center;">
                                <asp:ImageButton ID="imgPharmacyStore" runat="server" Width="72" Height="72" ImageUrl="~/Images/pharmacy_icon.jpg" />
                            </td>
                        </tr>
                        <tr style="height: 20px;">
                            <td class="LinkBoxMainPage">
                                <asp:LinkButton ID="lnkMainStore" CssClass="LinkMainPage" runat="server" Text="Main Store"></asp:LinkButton>
                            </td>
                            <td class="LinkBoxMainPage">
                                <asp:LinkButton ID="lnkPharmacyStore" CssClass="LinkMainPage" runat="server" Text="Pharmacy Store"></asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </td>
                <td style="height: 102px">
                    <table>
                        <tr>
                            <td style="height: 133px">
                                <table style="width: 166px; border: 1px solid #00BFFF; margin-left: 28px;" cellpadding="0"
                                    cellspacing="0">
                                    <tr style='height: 24px; background: url("images_hacims/img_spltb.jpg") repeat-x scroll right top transparent;'>
                                        <td style="color: White; font-weight: bold; padding-left: 10px;">
                                            Procurement
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="ImgButtonMainPage" style="text-align: center;">
                                            <asp:ImageButton ID="imgProcurement" Width="72" Height="72" runat="server" ImageUrl="~/Images/procurement.jpg" />
                                        </td>
                                    </tr>
                                    <tr style="height: 20px;">
                                        <td class="LinkBoxMainPage">
                                            <asp:LinkButton ID="lnkProcurement" CssClass="LinkMainPage" runat="server" Text="Procurement"></asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="height: 133px">
                                <table style="width: 163px; border: 1px solid #00BFFF;" cellpadding="0" cellspacing="0">
                                    <tr style='height: 24px; background: url("images_hacims/img_spltb.jpg") repeat-x scroll right top transparent;'>
                                        <td style="color: White; font-weight: bold; padding-left: 10px;">
                                            Finance
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="ImgButtonMainPage" style="text-align: center; height: 65px;">
                                            <asp:ImageButton ID="imgFinance" Width="72" Height="72" runat="server" ImageUrl="~/Images/coins-icon.png" />
                                        </td>
                                    </tr>
                                    <tr style="height: 20px;">
                                        <td class="LinkBoxMainPage" style="height: 20px">
                                            <asp:LinkButton ID="lnkFinance1" CssClass="LinkMainPage" runat="server" Text="Finance"></asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="height: 133px">
                                <table style="width: 167px; border: 1px solid #00BFFF;" cellpadding="0" cellspacing="0">
                                    <tr style='height: 24px; background: url("images_hacims/img_spltb.jpg") repeat-x scroll right top transparent;'>
                                        <td style="color: White; font-weight: bold; padding-left: 10px;">
                                            Payroll
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="ImgButtonMainPage" style="text-align: center;">
                                            <asp:ImageButton ID="imgBtnPayroll1" runat="server" Width="72" Height="72" ImageUrl="~/Images/Payroll.png" />
                                        </td>
                                    </tr>
                                    <tr style="height: 20px;">
                                        <td class="LinkBoxMainPage">
                                            <asp:LinkButton ID="lnkPayroll1" CssClass="LinkMainPage" runat="server" Text="Payroll"></asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table style="width: 150px; border: 1px solid #00BFFF; margin-left: 30px;" cellpadding="0"
                        cellspacing="0" id="TABLE2">
                        <tr style='height: 24px; background: url("images_hacims/img_spltb.jpg") repeat-x scroll right top transparent;'>
                            <td style="color: White; font-weight: bold; padding-left: 10px;">
                                Human Resource
                            </td>
                        </tr>
                        <tr>
                            <td class="ImgButtonMainPage" style="text-align: center;">
                                <asp:ImageButton ID="imgHumanResource" runat="server" Width="72" Height="72" ImageUrl="~/Images/humanresource.jpg" />
                            </td>
                        </tr>
                        <tr style="height: 20px;">
                            <td class="LinkBoxMainPage">
                                <asp:LinkButton ID="lnkHumanResouce" CssClass="LinkMainPage" runat="server" Text="Human Resouce"></asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table style="width: 300px; border: 1px solid #00BFFF; margin-left: 30px;" cellpadding="0"
                        cellspacing="0">
                        <tr style='height: 24px; background: url("images_hacims/img_spltb.jpg") repeat-x scroll right top transparent;'>
                            <td colspan="2" style="color: White; font-weight: bold; padding-left: 10px;">
                                Ward Management
                            </td>
                        </tr>
                        <tr>
                            <td class="ImgButtonMainPage" style="text-align: center;">
                                <asp:ImageButton ID="imgBedAllocation" Width="72px" Height="72px" runat="server"
                                    ImageUrl="~/Images/wardbed.jpg" />
                            </td>

                            <td class="ImgButtonMainPage" style="text-align: center;">
                                <asp:ImageButton ID="imgAssetManagement" runat="server" Width="72" Height="72"
                                    ImageUrl="~/Images/patientcare.jpg" />
                            </td>
                        </tr>
                        <tr style="height: 20px;">
                            <td class="LinkBoxMainPage">
                                <asp:LinkButton ID="lnkBedAllocation" CssClass="LinkMainPage" runat="server" Text="Bed Allocation"></asp:LinkButton>
                            </td>
                            <td class="LinkBoxMainPage">
                                <asp:LinkButton ID="lnkAssetManagement" CssClass="LinkMainPage" runat="server" Text="Asset Management"></asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </td>
                <td style="height: 102px">
                    <table>
                        <tr>
                            <td style="height: 133px">
                                <table style="width: 166px; border: 1px solid #00BFFF; margin-left: 28px;" cellpadding="0"
                                    cellspacing="0">
                                    <tr style='height: 24px; background: url("images_hacims/img_spltb.jpg") repeat-x scroll right top transparent;'>
                                        <td style="color: White; font-weight: bold; padding-left: 10px;">
                                            Attendance
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="ImgButtonMainPage" style="text-align: center;">
                                            <asp:ImageButton ID="imgAttendance" Width="72" Height="72" runat="server" ImageUrl="~/Images/Attandence.jpg" />
                                        </td>
                                    </tr>
                                    <tr style="height: 20px;">
                                        <td class="LinkBoxMainPage">
                                            <asp:LinkButton ID="lnkAttendance" CssClass="LinkMainPage" runat="server" Text="Attendance"></asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="height: 133px">
                                <table style="width: 166px; border: 1px solid #00BFFF;" cellpadding="0" cellspacing="0">
                                    <tr style='height: 24px; background: url("images_hacims/img_spltb.jpg") repeat-x scroll right top transparent;'>
                                        <td style="color: White; font-weight: bold; padding-left: 10px;">
                                            Duty Roster
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="ImgButtonMainPage" style="text-align: center;">
                                            <asp:ImageButton ID="ImageButton1" Width="72" Height="72" runat="server" ImageUrl="~/Images/DutyRoster.jpg" />
                                        </td>
                                    </tr>
                                    <tr style="height: 20px;">
                                        <td class="LinkBoxMainPage">
                                            <asp:LinkButton ID="LinkButton1" CssClass="LinkMainPage" runat="server" Text="Duty Roster"></asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="height: 133px">
                                <table style="width: 166px; border: 1px solid #00BFFF;" cellpadding="0" cellspacing="0">
                                    <tr style='height: 24px; background: url("images_hacims/img_spltb.jpg") repeat-x scroll right top transparent;'>
                                        <td style="color: White; font-weight: bold; padding-left: 10px;">
                                            Leave Management
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="ImgButtonMainPage" style="text-align: center;">
                                            <asp:ImageButton ID="ImageButton2" Width="72" Height="72" runat="server" ImageUrl="~/Images/LeavePic.jpg" />
                                        </td>
                                    </tr>
                                    <tr style="height: 20px;">
                                        <td class="LinkBoxMainPage">
                                            <asp:LinkButton ID="LinkButton2" CssClass="LinkMainPage" runat="server" Text="Leave Management"></asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;</td>
                <td>
                    
                </td>
                <td style="height: 102px">
                    <table>
                        <tr>
                            <td style="height: 133px">
                                &nbsp;</td>
                            <td style="height: 133px">
                                &nbsp;</td>
                            <td style="height: 133px">
                                &nbsp;</td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
