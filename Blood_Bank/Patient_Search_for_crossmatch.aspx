<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Patient_Search_for_crossmatch, App_Web_lv2mnwrp" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src="../SpryAssets/mycollaps.js" type="text/javascript"></script>
    <link href="../SpryAssets/mycollaps.css" rel="stylesheet" type="text/css" />


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">



    <asp:Label ID="Label_Header" runat="server" CssClass="err" Visible="false"></asp:Label>
    <asp:Label ID="Label_message" runat="server" CssClass="err"></asp:Label>

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>



    <div class="bx_rad">
        <ul id="CollapsiblePanel1">
            <li><strong>&nbsp;Patient Search</strong></li>
            <li>

                <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                    <tr>
                        <td width="16%" align="right">Patient Name :</td>
                        <td width="16%">
                            <asp:TextBox ID="txtPName" runat="server"></asp:TextBox></td>
                        <td width="16%" align="right">MR # :</td>
                        <td width="16%">
                            <asp:TextBox ID="txtRegNo" runat="server"></asp:TextBox></td>
                    </tr>
                    <tr>

                        <td align="right">CNIC # :</td>
                        <td>
                            <asp:TextBox ID="txtCnic" runat="server"></asp:TextBox>
                        </td>
                        <td align="right">
                            <asp:Label ID="lbl_Sample" runat="server" Text="Lab # :"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtSample" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">From Date:</td>
                        <td>
                            <igsch:WebDateChooser ID="WebDateChooser_FromDate" runat="server">
                            </igsch:WebDateChooser>
                        </td>
                        <td align="right">To Date:</td>
                        <td>
                            <igsch:WebDateChooser ID="WebDateChooser_Todate" runat="server">
                            </igsch:WebDateChooser>
                        </td>
                    </tr>
                </table>
                <asp:HiddenField ID="HiddenField_ID" runat="server"></asp:HiddenField>
                <asp:HiddenField ID="HiddenField_FromDate" runat="server" />
                <asp:HiddenField ID="HiddenField_ToDate" runat="server" />
                <asp:Panel ID="Panel2" runat="server" Width="100%"></asp:Panel>
            </li>
        </ul>
    </div>


    <br />
    <asp:UpdatePanel ID="UpdatePanel_search" runat="server">
        <ContentTemplate>
            <div align="center">
                <asp:Button ID="Button1" runat="server" Text="Search" />
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="UpdateProgress_search" AssociatedUpdatePanelID="UpdatePanel_search" runat="server" DisplayAfter="0">
        <ProgressTemplate>
            <div style="margin-top: 5px; font-size: 11px; position: absolute; margin-top: -29px;">
                <img src="~/Images_hacims/process.gif" alt="" runat="server" />
                <span style="margin-left: 5px; color: #999999; display: inline; margin-top: -18px; float: right;">Processing your request.  Please wait.... </span>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <br />
            <asp:GridView ID="GridView2" runat="server" AllowPaging="true" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true"
                EmptyDataText="No Record Found" Width="100%" PageSize="50">

                <Columns>
                    <asp:HyperLinkField Text="Register Donor" Target="_blank" DataNavigateUrlFields="Reg_No,PayID,Main_ID" DataNavigateUrlFormatString="BloodDonorRegistration.aspx?Reg_No={0}&YearlyNo={1}&Main_ID={2}" />
                    <asp:HyperLinkField Text="Add Blood Request" Target="_blank" DataNavigateUrlFields="Reg_No,PayID,Main_ID" DataNavigateUrlFormatString="BloodRequestForm.aspx?registrationno={0}&YearlyNo={1}&Main_ID={2}" />
                    
                    <asp:TemplateField HeaderText="Sample No">
                        <ItemTemplate>
                            <asp:Label ID="lblSampleNo" Text='<%#Bind("Sample_No")%>' runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Reg No">
                        <ItemTemplate>
                            <asp:Label ID="lblRegNo" Text='<%#Bind("Reg_No")%>' runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Yearly No">
                        <ItemTemplate>
                            <asp:Label Text='<%#Bind("PayID")%>' ID="lblYearlyNo" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Patient">
                        <ItemTemplate>
                            <asp:Label Text='<%#Bind("Patient_Name")%>' ID="lblPatientName" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Relation">
                        <ItemTemplate>
                            <asp:Label Text='<%#Bind("Relation_Name")%>' ID="lblRelation" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Age">
                        <ItemTemplate>
                            <asp:Label Text='<%#Bind("Age")%>' ID="lblAge" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Booking Date">
                        <ItemTemplate>
                            <asp:Label Text='<%#Bind("Test_Booking_Date")%>' ID="lblBookingDate" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Department">
                        <ItemTemplate>
                            <asp:Label Text='<%#Bind("Department")%>' ID="lblDepartment" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Collected At">
                        <ItemTemplate>
                            <asp:Label Text='<%#Bind("Collected_At")%>' ID="lblCollected_At" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:HyperLinkField DataNavigateUrlFields="Blood_Request_Id,Reg_No,PayID" DataNavigateUrlFormatString="BloodGroup.aspx?bloodrequestid={0}&amp;Registration={1}&amp;YearlyNo={2}"
                        Text="Blood Group" />
                    <asp:HyperLinkField Text="Issue Blood"  Target="_blank" DataNavigateUrlFields="Blood_Request_Id,Reg_No,PayID"  DataNavigateUrlFormatString="Issue_Blood.aspx?BloodRequestId={0}&Registration={1}&YearlyNo={2}" />
                 <asp:HyperLinkField Text="Add Vitals"  Target="_blank" DataNavigateUrlFields="Reg_No,PayID"  DataNavigateUrlFormatString="~/nursing/nursevitals.aspx?RegNo={0}&amp;YearlyNo={1}" />
                </Columns>
                <RowStyle CssClass="GridItem" />
                <AlternatingRowStyle CssClass="GridAltItem" />
                <PagerStyle CssClass="GridPager" />

            </asp:GridView>
            <br />
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <asp:HiddenField ID="HiddenFieldSubDept" runat="server" />
    <asp:HiddenField ID="HiddenFieldDate" runat="server" />
    <asp:HiddenField ID="HiddenFieldpfname" runat="server" />
    <asp:HiddenField ID="HiddenField_yearlyno" runat="server" />
    <asp:HiddenField ID="HiddenField_regno" runat="server" />
    <asp:HiddenField ID="HiddenFieldrequestid" runat="server" />
    <asp:HiddenField ID="HiddenFieldYearlyNo" runat="server" />
    <asp:HiddenField ID="HiddenFieldPMName" runat="server" />
    <asp:HiddenField ID="HiddenFieldRelationFirstName" runat="server" />
    <asp:HiddenField ID="HiddenFieldRelation" runat="server" />
    <asp:HiddenField ID="HiddenFieldRMName" runat="server" />
    <asp:HiddenField ID="HiddenFieldRegNo" runat="server" />
    <asp:HiddenField ID="HiddenFieldAge" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourcePatient" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        InsertCommand="PatientRegistrationNextVisit" InsertCommandType="StoredProcedure"
        ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" SelectCommand="SELECT     Payment.datetime,ISNULL(Patient.Prefix, ' ') + ' ' + ISNULL(Patient.PFName, ' ') + ' ' + ISNULL(Patient.PMName, ' ') + ' ' + ISNULL(Patient.PLName, ' ') +&#13;&#10;                      ISNULL(Patient.Relation, '') + ISNULL(Patient.RFName, ' ') + ' ' + ISNULL(Patient.RMName, ' ') + ' ' + ISNULL(Patient.RLName, ' ') AS Name, &#13;&#10;                      CONVERT(varchar, ISNULL(Patient.Age, ' ')) + ' ' + ISNULL(Patient.AgeType, ' ') AS Age, Patient.RegNo, Patient.RegDateTime, &#13;&#10;                     'H.No.'+ ISNULL(Patient.House_No, ' ') + ' St.No.'&#13;&#10;+ ISNULL(Patient.StreetAddress, '') + ' '+&#13;&#10;ISNULL(Patient.Colony, '') + ' Tehsil '+ISNULL(Tehsil.TehsilName, '')+ ' District '+ &#13;&#10;                       ISNULL(DISTRICT.DistrictName, '') +  ' Province'+&#13;&#10;ISNULL(Province.ProvinceName, '')+ ' '+&#13;&#10; ISNULL(Country.CountryName, '') AS Address, Patient.Zipcode, &#13;&#10;                      PatientSex.SexDescription, Patient.OtherProvince, Patient.OtherDistrict, Patient.OtherTehsil, Patient.HomePhone, Patient.MobilePhone, Patient.CNIC, &#13;&#10;                      payment.diagonosis&#13;&#10;FROM         Patient INNER JOIN&#13;&#10;                      Payment ON Patient.RegNo = Payment.RegNo LEFT OUTER JOIN&#13;&#10;                      Tehsil ON Patient.TehsilCode = Tehsil.TehsilCode LEFT OUTER JOIN&#13;&#10;                      PatientSex ON Patient.SexID = PatientSex.SexID LEFT OUTER JOIN&#13;&#10;                      Province ON Patient.ProvinceCode = Province.ProvinceCode LEFT OUTER JOIN&#13;&#10;                      DISTRICT ON Patient.DistrictCode = DISTRICT.DistrictCode LEFT OUTER JOIN&#13;&#10;                      Country ON Patient.CountryCode = Country.CountryCode&#13;&#10;WHERE (Patient.RegNo = @RegNo)">
        <SelectParameters>
            <asp:QueryStringParameter Name="RegNo" QueryStringField="regno" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter DefaultValue="10" Name="DeptID" Type="Int32" />
            <asp:Parameter DefaultValue="DMC" Name="Status" Type="String" />
            <asp:SessionParameter DefaultValue="" Name="EmpID" SessionField="emp_id" Type="Int32" />
            <asp:Parameter DefaultValue="Diabetes" Name="Diagonosis" Type="String" />
            <asp:Parameter DefaultValue="DMC" Name="PatientType" Type="String" />
            <asp:Parameter DefaultValue="" Name="ReferFrom" Type="String" />
            <asp:Parameter Direction="InputOutput" Name="paymentid" Type="Decimal" />
            <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" Type="String" />
            <asp:Parameter Name="to_sub_Dept" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>



    <br />
    <br />
    <br />
    <script type="text/javascript">
<!--
    var CollapsiblePanel1 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel1", { contentIsOpen: true });
    //-->
    </script>
</asp:Content>
