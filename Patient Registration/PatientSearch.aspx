<%@ Page Language="VB" AutoEventWireup="false" CodeFile="~/Patient Registration/PatientSearch.aspx.vb" MasterPageFile="~/hacims_masterpage_admin.master" Inherits="Patient_Registration_PatientSearch" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">


    <script src="../SpryAssets/mycollaps.js" type="text/javascript"></script>
    <link href="../SpryAssets/mycollaps.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        function resetform() { document.form1.reset(); document.form1.TextBoxYearlyNo.focus(); }
        function enablelist(a) {
            if (a.checked == true) {
                document.getElementById("dropdownlistDiagnosis").disabled = false;
            }
            else {

                document.getElementById("dropdownlistDiagnosis").disabled = true;
            }

        }
    </script>
    <script type="text/javascript" language="javascript">
        function ConfirmOnDelete() {
            if (confirm("After Listening Beep Press ok otherwise press Cancel button?") == true) {
                //  window.location = "patientsearch.aspx";  
                return true;
            }

        }
    </script>
    <script type="text/javascript">

        $(document).ready(function () {


            $('a.grid_track').attr('title', 'Track Patient History');
            $('a.grid_edit').attr('title', 'Edit Patient Information');
            $('a.grid_view').attr('title', 'View Patient Detail');
            $('a.grid_add').attr('title', 'Assign Bed to Patient');


        });
    </script>
    <script type="text/javascript">

        $(document).ready(function () {

            $('#Button_clr').click(function () {
                $('input').val("")
                $('input#ctl00_ContentPlaceHolder1_Button1').val("Search")
                $('input#ctl00_ContentPlaceHolder1_Button_Advance_Search').val("Advance Search")
                $('#Button_clr').val("Clear")
            });
        });


    </script>


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">



<%--    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>--%>
    <%--<asp:UpdatePanel ID="UpdatePanel_search" runat="server">
        <ContentTemplate>--%>


            <div class="bx_rad">
                <ul id="CollapsiblePanel1">
                    <li><strong>&nbsp;Click here for Patient Search</strong></li>
                    <li>

                        <asp:Panel ID="Panel2" runat="server" Width="100%"></asp:Panel>



                    </li>
                </ul>
            </div>
            <br />
            <div align="center">
                <asp:Button CssClass="btn1" ID="Button1" runat="server" Text="Search" />
                <asp:Button ID="Button_Advance_Search" runat="server" Text="Advance Search" CssClass="btn2" />
                <input class="btn_hacims" name="Clear" value="Clear" type="button" id="Button_clr" />






            </div>
    <%--    </ContentTemplate>
    </asp:UpdatePanel>--%>



    <asp:Label CssClass="err" ID="Label1" runat="server" Style="display: inline-block; padding-bottom: 10px; font-weight: bold;"></asp:Label>

    <br />
    <%--<asp:UpdateProgress ID="UpdateProgress_search" AssociatedUpdatePanelID="UpdatePanel_search" runat="server" DisplayAfter="0">
        <ProgressTemplate>
            <div style="margin-top: 5px; font-size: 11px; position: absolute; margin-top: -29px;">
                <img src="~/Images_hacims/process.gif" alt="" runat="server" />
                <span style="margin-left: 5px; color: #999999; display: inline-block; margin-top: 5px; float: right;">Processing your request.  Please wait.... </span>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>--%>

<%--    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>
            <asp:GridView ID="GridViewSearch" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                CssClass="Grid_1" Width="100%" PageSize="20">
                <RowStyle CssClass="GridItem" />
                <HeaderStyle CssClass="GridHeader" />
                <AlternatingRowStyle CssClass="GridAltItem" />
                <Columns>
                    <asp:ButtonField CommandName="patienttrack">
                        <ControlStyle CssClass="grid_track" />
                    </asp:ButtonField>
                    <asp:ButtonField CommandName="Editrecord">
                        <ControlStyle CssClass="grid_edit" />
                    </asp:ButtonField>
                    <asp:ButtonField CommandName="View">
                        <ControlStyle CssClass="grid_view" />
                    </asp:ButtonField>
                    <asp:TemplateField Visible="true">
                        <ItemTemplate>
                            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("[Registration No]", "PatientAppointment_box.aspx?regno={0}") %>'
                                Target="_blank" Text="Appointment"></asp:HyperLink>&nbsp;
                              
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkbNewVisit" runat="server" OnClick="lnkbNewVisit_Click">OPD Slip</asp:LinkButton>&nbsp;&nbsp;
                                        <asp:LinkButton ID="lnkbNewAdmission" runat="server" ToolTip="Admission Slip" OnClick="lnkbNewAdmission_Click">Admission</asp:LinkButton>&nbsp;&nbsp;
                                      <asp:ImageButton ID="ImageButton_FP" runat="server"
                                          ToolTip="Register Finger Print" ImageUrl="~/images_hacims/fpic.png"
                                          OnClick="ImageButton_FP_Click" CausesValidation="False"
                                          Height="30px" Width="36px" Visible="False" />
                            <asp:HiddenField ID="HF_Subdept" runat="server"
                                Value='<%# Eval("SubDept_id")%>' />
                                                  <asp:HiddenField ID="hfDeptID" runat="server"
                                Value='<%# Eval("DeptID")%>' />

                            <asp:HiddenField ID="HiddenFieldPartyid" Value='<%# Eval("Billing_party_id") %>' runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="No Of Visits" ShowHeader="False">
                        <ItemTemplate>
                            <asp:HiddenField ID="HiddenField_FP" runat="server" Value='<%# Eval("[FP]") %>' />
                            <asp:LinkButton CssClass="openbssox" ID="LinkButton1" runat="server" CausesValidation="False" CommandArgument='<%# Eval("Registration No") %>'
                                CommandName="NoOFVisit" Text='<%# Eval("[No_Of_Visits]") %>' OnClick="LinkButton1_Click"></asp:LinkButton>
                            <asp:HiddenField ID="HiddenField_RegNo" runat="server" Value='<%# Eval("[Registration No]") %>' />
                            <asp:HiddenField ID="HiddenField_YearlyNo" runat="server" Value="" />
                            <asp:HiddenField ID="HiddenField_Patient_Type_ID" runat="server" Value='<%# Eval("[Patient_Type_ID]") %>' />
                            <%-- <asp:HiddenField ID="HiddenField_Patient_Type" runat="server" Value='<%# Eval("[Patient_Type]") %>' />--%>
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
                <PagerStyle CssClass="GridPager" />

            </asp:GridView>

            <asp:Panel ID="Panel_Visit_Summary" runat="server" Width="100%" Visible="false" CssClass="lightbox_bg">
                <div class="lightbox">
                    <div style="float: right; text-align: right; heigh: 10px;">
                        <asp:ImageButton ID="ImageButton_Close" runat="server" ImageUrl="~/images_hacims/icon_delete.gif" />
                    </div>
                    <div style="height: 350px; display: block; overflow: auto; overflow-x: hidden;">
                        <asp:DataList ID="DataList_Visit_Summary" runat="server" DataSourceID="SqlDataSource_Visit_Summary" Width="100%">
                            <ItemTemplate>
                                <div class="bx_infos_patients" style="margin-top: 15px; display: block-block;">
                                    <ul style="line-height: 18px;">
                                        <li>Visit Date Time :
                                            <asp:Label ID="visit_Date_TimeLabel" runat="server" Text='<%# Eval("visit_Date_Time") %>'></asp:Label><span class="splt">|</span>
                                            Patient Type :
                                            <asp:Label ID="PatientTypeLabel" runat="server" Text='<%# Eval("PatientType") %>'> </asp:Label><span class="splt">|</span>
                                            Status :
                                            <asp:Label ID="StatusLabel" runat="server" Text='<%# Eval("Status") %>'></asp:Label><span class="splt">|</span>
                                            Daily No. :
                                            <asp:Label ID="DailyNoLabel" runat="server" Text='<%# Eval("DailyNo") %>'></asp:Label><span class="splt">|</span>
                                            <asp:Label ID="Patient_TypeLabel" Visible="false" runat="server" Text='<%# Eval("Patient_Type") %>'> </asp:Label></li>
                                          <li>Daycase :
                                            <asp:Label ID="DaycaseLabel" runat="server" Text='<%# Eval("Daycase") %>'></asp:Label><span class="splt">|</span>
                                            Discharge Date Time :
                                            <asp:Label ID="DischargeDateTimeLabel" runat="server" Text='<%# Eval("DischargeDateTime") %>'> </asp:Label><span class="splt">|</span>
                                            Visit # :
                                            <asp:Label ID="visit_NoLabel" runat="server" Text='<%# Eval("visit_No") %>'></asp:Label><span class="splt">|</span>
                                            Diagonosis :
                                            <asp:Label ID="DiagonosisLabel" runat="server" Text='<%# Eval("Diagonosis") %>'> </asp:Label></li>
                                        <li>Doctor :
                                            <asp:Label ID="DoctorLabel" runat="server" Text='<%# Eval("Doctor") %>'></asp:Label></li>
                                    </ul>
                                </div>
                            </ItemTemplate>
                        </asp:DataList>
                    </div>
                </div>
                <asp:SqlDataSource ID="SqlDataSource_Visit_Summary" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" SelectCommand="SELECT     CONVERT(varchar, Payment.DateTime, 105) + ' ' + RIGHT(CONVERT(varchar, Payment.DateTime, 100), 7) AS visit_Date_Time, Payment.PatientType, Payment.Status, &#13;&#10;                      Payment.DailyNo, Payment.Patient_Type, Payment.Daycase, Payment.DischargeDateTime, Payment.PayID AS visit_No, Payment.Diagonosis, &#13;&#10;                      Employee.Prefix + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS Doctor&#13;&#10;FROM         Payment LEFT OUTER JOIN&#13;&#10;                      Employee ON Payment.DoctorID = Employee.EmpID&#13;&#10;WHERE     (Payment.RegNo = @RegNo)">
                    <SelectParameters>
                        <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </asp:Panel>


    <%--    </ContentTemplate>
    </asp:UpdatePanel>--%>




<%--
    <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel1" runat="server" DisplayAfter="0">
        <ProgressTemplate>
            <div style="margin-top: 5px; font-size: 11px; position: absolute;">
                <img src="~/Images_hacims/process.gif" alt="" runat="server" />
                <span style="margin-left: 5px; color: #999999; display: inline-block; margin-top: 5px; float: right;">Processing your request.  Please wait.... </span>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>--%>

    <asp:SqlDataSource ID="SqlDataSourceSearch" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"></asp:SqlDataSource>


    <asp:SqlDataSource ID="SqlDataSourceDiagnosis" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
        SelectCommand="SELECT [Diagnosis] FROM [Diagnosis]"></asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Flag" runat="server" />

    <br />
    <div align="center">
        <asp:Button CssClass="btn1" ID="Button_Print" runat="server" Visible="false" Text="Print" /></div>


    <script type="text/javascript">
<!--
    var CollapsiblePanel1 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel1", { contentIsOpen: true });
    //-->
    </script>

</asp:Content>
