<%@ Page Language="VB" AutoEventWireup="true" CodeFile="Pt_AssignRadiology_Tests.aspx.vb"
    MasterPageFile="~/hacims_masterpage.master" Inherits="Pt_AssignRadiology_Tests_1" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <hta:application applicationname="HTA Test" scroll="yes" singleinstance="yes">
    <script src="../css_hacims/ck.js" type="text/javascript"></script>
    <script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript"></script>
    <script src="../css_hacims/SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>
    <link href="../css_hacims/SpryAssets/SpryTabbedPanels.css" rel="stylesheet" type="text/css" />

 <script type="text/javascript">
     function showModal() {
         $("#myModal").modal('show');
     }
    </script>
    
    <script language="javascript" type="text/JavaScript">
        $(document).ready(function () {
            $('#prevs').click(function () {
                location.reload();
            });
            $(".openimages").colorbox({ width: "920px", height: "90%", iframe: true });
        });
        function ViewReport() {
            window.open("PatalogyTestReport.aspx", "MyWindow", "");
            return false;
        }
        function confirmSaveTestRadiology() {
            var result = confirm("Do you want to save?");

            if (result == true) {
                //setTimeout('__doPostBack(\'ctl00$ContentPlaceHolder1$btnAdd\',\'\')', 0)
                //$("[id$='btnAdd']").attr("disabled", "disabled");
                //$("[id$='btnAdd']").removeClass("btn_hacims");
                //$("[id$='btnAdd']").addClass("btn_hacims_disabled");

                return true;
            } else {
                return false;
            }

        }
        //        function redirectToSynapserp(TBS_ID) {

        //            var url = "http://192.168.79.17/Explore.asp?path=/All%20Studies/AccessionNumber=" + TBS_ID;
        //            window.open(url, '', 'window settings');
        //           
        //        }
    </script>

    <style type="text/css">
        .btn1 {
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="../autocomplete.asmx" />
        </Services>
    </asp:ScriptManager>
    <asp:Panel ID="Panel2" runat="server" Width="100%">
    </asp:Panel>
    <asp:Label ID="Label2" runat="server" CssClass="err"></asp:Label>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="leftnav" valign="top">
                <asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
                <asp:Panel ID="Panel1" runat="server" Visible="False">
                </asp:Panel>
            </td>
            <td style="width: auto;" valign="top">
                <div id="TabbedPanels1" class="TabbedPanels">
                    <ul class="TabbedPanelsTabGroup" style="margin-left: 10px;">
                        <li class="TabbedPanelsTab" tabindex="1">Procedure Entry</li>
                    </ul>
                    <div class="TabbedPanelsContentGroup">
                        <div class="TabbedPanelsContent">

                            <%-- <asp:UpdateProgress ID="updProgress"
                                AssociatedUpdatePanelID="UpdatePanel1"
                                runat="server">
                                <ProgressTemplate>
                                    <img height="30px" width="30px" style="position: fixed;    left: 600px;    height: 50px;   width: 50px;    top: 500px;" alt="progress" src="../images/ajaxloader.gif" />
                                   
                                </ProgressTemplate>
                            </asp:UpdateProgress>--%>



                            <div>
                                <asp:Label Font-Size="14px" Font-Bold="true" ForeColor="Green" ID="lblMessage" runat="server"></asp:Label></div>

                            <cc1:AutoCompleteExtender ID="Get_Radiology_Test" runat="server" CompletionInterval="10"
                                CompletionListCssClass="AutoExtender" CompletionListItemCssClass="AutoExtenderList"
                                CompletionListHighlightedItemCssClass="AutoExtenderHighlight" CompletionSetCount="12"
                                EnableCaching="true" MinimumPrefixLength="2" ServiceMethod="Get_OT_Procedures"
                                UseContextKey="true" TargetControlID="TextBox_Test" BehaviorID="Get_Radiology_Test">
                            </cc1:AutoCompleteExtender>


                            <table cellspacing="0" cellpadding="0" width="100%">
                                <tbody>
                                    <tr>
                                        <td width="30%" rowspan="2" valign="top">
                                            <table class="tbl_form" cellspacing="0" cellpadding="0" width="100%" border="0">
                                                <tbody>
                                                    <tr>
                                                        <td valign="top" colspan="2">
                                                            <asp:DataList ID="DataList1" runat="server" Width="100%" DataSourceID="ForTestGroup"
                                                                DataKeyField="TGID" RepeatColumns="3" RepeatDirection="Horizontal" SelectedItemStyle-CssClass="link_datalist_sel">
                                                                <SelectedItemStyle CssClass="link_datalist_sel"></SelectedItemStyle>
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="LinkButton1" runat="server" Text='<%# Eval("TGName", "{0}") %>'
                                                                        CssClass="link_datalist" CommandName="Select" CommandArgument='<%# Eval("TGID", "{0}") %>'></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:DataList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right">Test Name :
                                                        </td>
                                                        <td>
                                                            <asp:TextBox AccessKey="n" ID="TextBox_Test" runat="server" Width="90%" AutoPostBack="True"
                                                                Visible="true"></asp:TextBox>
                                                            <%--     <asp:TextBox AccessKey="n" ID="TextBox_testDental" runat="server" Width="95%" AutoPostBack="True"
                                                                        Visible="false"></asp:TextBox>
                                                                    <asp:TextBox AccessKey="n" ID="TextBox_TestComplex" runat="server" Width="95%" AutoPostBack="True"
                                                                        Visible="false"></asp:TextBox>--%>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <div style="margin-top: 5px; width: 96%" class="bx_infos_patients">
                                                <div class="bxinfo_margin">
                                                    <asp:CheckBoxList ID="CheckBoxList_Rad_Test" Style="font-size: 10px;" runat="server"
                                                        DataSourceID="SqlDataSource_Test_booking_new" AutoPostBack="True" RepeatLayout="Flow"
                                                        DataTextField="TB_Name" DataValueField="TB_ID">
                                                    </asp:CheckBoxList>
                                                    <asp:HiddenField ID="HiddenField_TestType" runat="server"></asp:HiddenField>
                                                    <asp:SqlDataSource ID="SqlDataSource_Test_Type" runat="server"
                                                        SelectCommand="SELECT [Test_Type], [Test_Type_ID] FROM [Test_Type]"
                                                        ConnectionString="<%$ ConnectionStrings:OT_ManagementConnectionString %>"></asp:SqlDataSource>
                                                </div>
                                            </div>
                                            <asp:SqlDataSource ID="SqlDataSource_Test_booking_new" runat="server" SelectCommand="SELECT     Test_Booking.TB_Name, Test_Booking.TB_ID,'' as TGName
FROM        Test_Booking
"
                                                ProviderName="<%$ ConnectionStrings:OT_ManagementConnectionString.ProviderName %>" ConnectionString="<%$ ConnectionStrings:OT_ManagementConnectionString %>">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="HiddenFieldTestSubGroup" PropertyName="Value" DefaultValue=""
                                                        Name="MG_ID"></asp:ControlParameter>
                                                    <asp:ControlParameter ControlID="TextBox_Test" PropertyName="Text" DefaultValue="%"
                                                        Name="TB_Name"></asp:ControlParameter>
                                                    <asp:SessionParameter Name="HospitalID" SessionField="HospitalId" />
                                                    <asp:SessionParameter Name="AttachedHospitalID" SessionField="PatientHospital_ID" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:HiddenField ID="HiddenFieldGender" runat="server"></asp:HiddenField>
                                        </td>
                                        <td valign="top">
                                            <strong>
                                                <asp:Label ID="labelGName" runat="server" CssClass="err"></asp:Label>
                                            </strong>
                                            <asp:DropDownList ID="DropDownListCategory" runat="server" Width="150px" Visible="False"
                                                AutoPostBack="True">
                                                <asp:ListItem>Section</asp:ListItem>
                                                <asp:ListItem>Specimen</asp:ListItem>
                                            </asp:DropDownList>


                                            <br />
                                            <asp:GridView ID="GridViewTest_Assign" runat="server" CssClass="Grid_1" Width="100%"
                                                AutoGenerateColumns="False" ShowFooter="True">
                                                <RowStyle CssClass="GridItem" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="TestName" SortExpression="TestName">
                                                        <EditItemTemplate>
                                                            <asp:Label ID="Label_TestName" runat="server" Text='<%# Bind("TestName") %>'></asp:Label>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label_TestName" runat="server" Text='<%# Bind("TestName") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="TID" HeaderText="TID" SortExpression="TID" ReadOnly="True" />
                                                    <asp:TemplateField Visible="false" HeaderText="Priority" SortExpression="Test Type">
                                                        <EditItemTemplate>
                                                            <asp:RadioButtonList ID="RadioButtonList_TypeG" runat="server" DataSourceID="SqlDataSource_Test_Type_G"
                                                                DataTextField="Test_Type" DataValueField="Test_Type_ID" RepeatDirection="Horizontal"
                                                                RepeatLayout="Flow" SelectedValue='<%# Eval("TestType_ID") %>' TabIndex="16"
                                                                Width="100%">
                                                            </asp:RadioButtonList>
                                                            <asp:SqlDataSource ID="SqlDataSource_Test_Type_G" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
                                                                ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" SelectCommand="SELECT Test_Type, Test_Type_ID FROM Test_Type"></asp:SqlDataSource>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label_TestType" runat="server" Text='<%# Bind("[Test Type]") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField Visible="false" HeaderText="Description" SortExpression="Description">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="TextBox_Description" Width="100px" runat="server" Text='<%# Eval("Description") %>'></asp:TextBox>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            &nbsp;<asp:TextBox ID="TextBox_Description" runat="server" Text='<%# Eval("Description") %>'></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField Visible="false" DataField="TestType_ID" HeaderText="TestType_ID" SortExpression="TestType_ID"
                                                        ReadOnly="True" />

                                                    <asp:ButtonField CommandName="select" Text="Cancel" />
                                                </Columns>
                                                <HeaderStyle CssClass="GridHeader" />
                                                <AlternatingRowStyle CssClass="GridAltItem" />
                                            </asp:GridView>


                                            <br />


                                            <div class="bxmain">
                                                <table class="tbl_form" cellspacing="0" cellpadding="0" width="100%" border="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class="style12" valign="top">Mode of Operation :</td>
                                                            <td align="left" class="style6" valign="top">
                                                                <asp:RadioButtonList ID="RadioButtonList_Type" runat="server"
                                                                    DataSourceID="SqlDataSource_Test_Type" DataTextField="Test_Type"
                                                                    DataValueField="Test_Type_ID" RepeatDirection="Horizontal" RepeatLayout="Flow"
                                                                    TabIndex="16" Width="100%">
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="style12" valign="top">Mode of Admission</td>
                                                            <td class="style6" valign="top">
                                                                <asp:RadioButtonList ID="RadioButtonList_AdmissionType" runat="server"
                                                                    RepeatColumns="5" RepeatDirection="Horizontal" RepeatLayout="Flow"
                                                                    TabIndex="16" Width="112%">
                                                                    <asp:ListItem Selected="True">Pre-OP Admission</asp:ListItem>
                                                                    <asp:ListItem>Post-OP Admission</asp:ListItem>
                                                                    <asp:ListItem>Day Case</asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="style12" valign="top">Anesthesia 
                                                            </td>
                                                            <td class="style6" valign="top">
                                                                <asp:DropDownList ID="ddlAnesthsia" runat="server"></asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="style12" valign="top">Anesthetist Opinion
                                                            </td>
                                                            <td class="style6" valign="top">
                                                                <asp:RadioButtonList ID="RadioButtonList_Anesthesia" runat="server"
                                                                    RepeatColumns="3">
                                                                    <asp:ListItem Value="1">Required</asp:ListItem>
                                                                    <asp:ListItem Selected="True" Value="0">Not Required</asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="style12" valign="top">Recommanded By
                                                            </td>
                                                            <td class="style6" valign="top">
                                                                <asp:DropDownList ID="ddlRecommendedBy" runat="server"></asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="style12" valign="top">Openion for Internal Medicine
                                                            </td>
                                                            <td class="style6" valign="top">
                                                                <asp:RadioButtonList ID="RadioButtonListInternalMed" runat="server"
                                                                    RepeatColumns="3">
                                                                    <asp:ListItem Value="1">Required</asp:ListItem>
                                                                    <asp:ListItem Selected="True" Value="0">Not Required</asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="style12" valign="top">Shift To (After Opeartion)</td>
                                                            <td class="style6" valign="top">
                                                                <asp:RadioButtonList ID="RadioButtonList_ShiftTo" runat="server"
                                                                    RepeatColumns="5" RepeatDirection="Horizontal" RepeatLayout="Flow"
                                                                    TabIndex="16" Width="112%">
                                                                    <asp:ListItem>ICU</asp:ListItem>
                                                                    <asp:ListItem Selected="True">Ward</asp:ListItem>
                                                                    <asp:ListItem>Others</asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="style12" valign="top">Blood Required</td>
                                                            <td class="style6" valign="top">
                                                                <asp:TextBox ID="TextBox_Blood" runat="server" Width="141px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="style15" align="right">Admitting Diagnosis:</td>
                                                            <td>&nbsp;
                                      <asp:CheckBoxList ID="CheckBoxList_Diagnosis" runat="server" AutoPostBack="True"
                                          DataSourceID="SqlDataSource_CurrnentDiagnosis" DataTextField="DiseaseName" DataValueField="Diagnosis_ID" RepeatColumns="2">
                                      </asp:CheckBoxList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="style15">&nbsp;</td>
                                                            <td>&nbsp;
                                     
                                     <asp:TextBox ID="TextBox_admision_Diagnosis" runat="server" Enabled="False"
                                         Width="505px"></asp:TextBox>
                                                                <asp:SqlDataSource ID="SqlDataSource_CurrnentDiagnosis" runat="server"
                                                                    ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                                                    ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT  ISNULL(DiseaseName, '') AS DiseaseName,  Diagnosis_ID,ISNULL(dsCode, '') AS [ICD10 Code]
FROM         pt_Diagnosis
WHERE (pt_Diagnosis.YearlyNo = @yearlyNo) AND (pt_Diagnosis.RegNo = @regno)">
                                                                    <SelectParameters>
                                                                        <asp:SessionParameter Name="yearlyNo" SessionField="yearlyno" />
                                                                        <asp:SessionParameter Name="regno" SessionField="registrationno" />
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>

                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="style15" align="right">Ward:</td>
                                                            <td>&nbsp;
                                     <asp:DropDownList ID="DDL_Wards" runat="server" AutoPostBack="false"
                                         Height="25px" OnSelectedIndexChanged="DDL_Wards_SelectedIndexChanged"
                                         Width="234px">
                                     </asp:DropDownList>
                                                                <asp:SqlDataSource ID="SDS_Wards" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                                                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                                                    SelectCommand="SELECT     admin_Hospital_Wards.Ward_id, admin_Hospital_Wards.Ward_Name
FROM         admin_Hospital_Wards INNER JOIN
                      Department ON admin_Hospital_Wards.Dept_Id = Department.Dept_ID
WHERE     (Department.Hospital_ID = @Hospital_Id) and(( Department.Dept_ID =@Dept_Id) or ( Department.Dept_ID is null))
ORDER BY admin_Hospital_Wards.Ward_Name">
                                                                    <SelectParameters>
                                                                        <asp:SessionParameter Name="Hospital_Id" SessionField="PatientHospital_ID"
                                                                            DefaultValue="" />
                                                                        <asp:SessionParameter Name="Dept_Id" SessionField="Dept_Id" />
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
                                                                <asp:Label ID="Label_Ward_Count" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="style15" align="right">Consultant : </td>
                                                            <td class="style11">&nbsp;
                                      <asp:DropDownList ID="DropDownListConsultant" runat="server" Height="25px" Width="228px">
                                      </asp:DropDownList>
                                                                <asp:SqlDataSource ID="SqlDataSource_Employee" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                                                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                                                    SelectCommand="SELECT Employee.EmpID, ISNULL(Employee.EFName, ' ') + ' ' + ISNULL(Employee.EMName, ' ') + ' ' + ISNULL(Employee.ELName, ' ') AS [Employee Name] FROM Employee INNER JOIN Department ON Employee.DeptID = Department.Dept_ID WHERE (Employee.Emp_Type = 'Consultant') AND (Department.Hospital_ID = @HospitalId)  ORDER BY [Employee Name]">
                                                                    <SelectParameters>
                                                                        <asp:SessionParameter Name="HospitalId" SessionField="HospitalId" Type="Int32" />
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="style15" align="right">Package Name : </td>
                                                            <td class="style11">
                                                                <asp:DropDownList ID="chkboxPackageName" runat="server" Width="250px" Visible="false"></asp:DropDownList>
                                                                <div style="overflow-y: scroll; width: 500px; height: 100px;">
                                                                    <asp:CheckBoxList ID="CheckBoxList_Packages" runat="server" Width="98%"></asp:CheckBoxList>
                                                                </div>



                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="style15" align="right">Date of Addmission:</td>
                                                            <td>&nbsp;  &nbsp;  
                                     <igsch:WebDateChooser ID="WebDateChooser_Date_Of_admission" runat="server"
                                         CssClass="drop_date" Height="17px" Width="151px"
                                         Value="07/16/2016 01:02:03">
                                         <CalendarLayout Culture="English (United Kingdom)">
                                         </CalendarLayout>
                                     </igsch:WebDateChooser>
                                                            </td>
                                                            <td rowspan="2">
                                                                <asp:GridView ID="grdOTDays" runat="server" AutoGenerateColumns="false">
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="OT Day">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblDate" runat="server" Text='<%# Eval("OTDay") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="OT List">
                                                                        <ItemTemplate>
                                                                        <asp:LinkButton ID="lnk_OTList" runat="server" CommandArgument='<%# Eval("OTDay")%>'
                                                                        Text="OT List" ToolTip='<%# Eval("OTDay")%>' OnClick="lnk_OTList_Click"></asp:LinkButton>
                                                                        </ItemTemplate>
                                                                        </asp:TemplateField>

                                                                    </Columns>
                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="style15" align="right">Date of Operation:</td>
                                                            <td>
                                                                <igsch:WebDateChooser ID="WebDateChooser_Date_Of_Operation" runat="server"
                                                                    CssClass="drop_date" Height="17px" Value="07/16/2016 01:02:14"
                                                                    Width="151px">
                                                                    <CalendarLayout Culture="English (United Kingdom)">
                                                                    </CalendarLayout>
                                                                </igsch:WebDateChooser>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right">Advice to Patient:</td>
                                                            <td>&nbsp;
                                     <asp:TextBox ID="TextBox_Instructions" runat="server" Height="58px"
                                         Style="text-align: left" TabIndex="19" TextMode="MultiLine" Width="100%"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="style9" style="font-size: large; font-weight: bold;">&nbsp;</td>
                                                            <td>
                                                                <asp:Button ID="btnAdd" runat="server"
                                                                    OnClick="btnAdd_Click" Text="Save" CssClass="btn1"
                                                                    Width="81px" Height="28px"></asp:Button>

                                                            </td>

                                                        </tr>
                                                        <tr>
                                                            <td class="style9" style="font-size: large; font-weight: bold;" colspan="2">
                                                                <asp:GridView ID="GridView_Radiology0" runat="server" AutoGenerateColumns="False"
                                                                    Width="100%" CssClass="Grid_1" DataSourceID="SqlDataSourceRadiology" DataKeyNames="TB_ID">
                                                                    <Columns>
                                                                        <asp:BoundField DataField="Doctor" HeaderText="Doctor"
                                                                            SortExpression="Doctor" ReadOnly="True" />
                                                                        <asp:BoundField DataField="TB_Name" HeaderText="Test Name" SortExpression="TB_Name" />
                                                                        <asp:BoundField DataField="TB_ID" HeaderText="TB_ID"
                                                                            SortExpression="TB_ID" ReadOnly="True" Visible="false" />
                                                                        <asp:BoundField DataField="Date_Time" HeaderText="Date Time" SortExpression="Date_Time" />
                                                                        <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" Visible="false" />
                                                                        <asp:BoundField DataField="DateOfOperation" SortExpression="DateOfOperation" HeaderText="Oper. Date" />
                                                                        <asp:BoundField DataField="Date_Of_admission" SortExpression="Date_Of_admission" HeaderText="Adm. Date" />
                                                                        <asp:BoundField DataField="YearlyNo" HeaderText="Yearly #" SortExpression="PayID" />
                                                                        <asp:BoundField DataField="RegNo" HeaderText="Reg #" SortExpression="RegNo" />
                                                                        <asp:BoundField DataField="Order_ID" HeaderText="Order ID" SortExpression="Order_ID" Visible="false" />
                                                                        <asp:HyperLinkField DataNavigateUrlFields="Regno,YearlyNo" DataNavigateUrlFormatString="~/PT_EMR/pt_physician_order.aspx?RegNo={0}&amp;YearlyNo={1}"
                                                                            Text="Pre/Post Order"></asp:HyperLinkField>
                                                                        <asp:HyperLinkField DataNavigateUrlFields="Order_id" DataNavigateUrlFormatString="~/OT_management/Surgical_order_intermedcn_assessment.aspx?Order_Id={0}"
                                                                            Text="Internal Medicine"></asp:HyperLinkField>

                                                                        <asp:HyperLinkField DataNavigateUrlFields="Order_Id" DataNavigateUrlFormatString="~/OT_management/Surgical_order_anesthesia_assessment.aspx?Order_Id={0}"
                                                                            Text="Anesthesia"></asp:HyperLinkField>
                                                                        <asp:HyperLinkField DataNavigateUrlFields="Order_Id,Regno,YearlyNo" DataNavigateUrlFormatString="~/OT_management/PreOperationConsultantNotesReport.aspx?Order_Id={0}&RegNo={1}&amp;YearlyNo={2}"
                                                                            Text="Report"></asp:HyperLinkField>
                                                                    </Columns>
                                                                    <HeaderStyle CssClass="GridHeader" />
                                                                    <SelectedRowStyle CssClass="RowItem" />
                                                                    <AlternatingRowStyle CssClass="GridAltItem" />
                                                                </asp:GridView>
                                                            </td>

                                                        </tr>
                                                    </tbody>
                                                </table>



                                            </div>
                                            <div align="center">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td valign="top">
                                            <br />
                                            <asp:TreeView ID="TreeView1" runat="server" Visible="False">
                                            </asp:TreeView>
                                            <asp:Panel ID="Panel_Register_Test" runat="server" Visible="False">
                                                <br />
                                                <asp:SqlDataSource ID="SqlDataSource_MG_Name" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_OTConnectionString %>"
                                                    InsertCommand="INSERT INTO Test_Booking(TB_Name, Private_Price, Public_Price, MG_ID,S_Id) VALUES (@TB_Name, @Private_Price, @Public_Price, @MG_ID,@S_Id)"
                                                    ProviderName="<%$ ConnectionStrings:Admin_OTConnectionString.ProviderName %>"
                                                    SelectCommand="SELECT TGName, TGID FROM TestGroup ">
                                                    <InsertParameters>
                                                        <asp:ControlParameter ControlID="TextBox_TBNAme" Name="TB_Name" PropertyName="Text" />
                                                        <asp:Parameter DefaultValue="0" Name="Private_Price" />
                                                        <asp:Parameter DefaultValue="0" Name="Public_Price" />
                                                        <asp:ControlParameter ControlID="DropDownList_MGName" Name="MG_ID" PropertyName="SelectedValue" />
                                                        <asp:Parameter DefaultValue="0" Name="S_Id" />
                                                    </InsertParameters>
                                                </asp:SqlDataSource>
                                                <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                                                    <tbody>
                                                        <tr>
                                                            <td colspan="2">
                                                                <strong>Test is not Registered in Hospital.</strong>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="25%">Main Group :
                                                            </td>
                                                            <td width="25%">&nbsp;
                                                                        <asp:DropDownList ID="DropDownList_MGName" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_MG_Name"
                                                                            DataTextField="TGName" DataValueField="TGID" Width="200px">
                                                                        </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right">Name :
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="TextBox_TBNAme" runat="server" CssClass="input_txt" Width="200px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right"></td>
                                                            <td>
                                                                <asp:Button ID="Button_Save_TestBooking" runat="server" OnClick="Button_Save_TestBooking_Click"
                                                                    Text="Save" Width="88px" />
                                                                <asp:Button ID="Button_Pnl_Cancel" runat="server" OnClick="Button_Pnl_Cancel_Click"
                                                                    Text="Cancel" />
                                                                <asp:Button ID="Button1" runat="server" Text="Button" />
                                                            </td>
                                                        </tr>

                                                    </tbody>
                                                </table>
                                                <br />

                                                <br />

                                            </asp:Panel>
                                            <asp:SqlDataSource ID="SqlDataSourceRadiology" runat="server" SelectCommandType="StoredProcedure"
                                                SelectCommand="pt_Radiology_Select_Tests"
                                                ConnectionString="<%$ ConnectionStrings:OT_ManagementConnectionString %>">
                                                <SelectParameters>
                                                    <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" Type="String" />
                                                    <asp:SessionParameter Name="PayID" SessionField="YearlyNo" Type="Decimal" />
                                                    <asp:Parameter DefaultValue="0" Name="Order_Id" Type="Decimal" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <br />
                            <asp:HiddenField ID="HiddenField_Sample_collection" runat="server"></asp:HiddenField>
                            <asp:HiddenField ID="HiddenField_Report_Date" runat="server"></asp:HiddenField>
                            <asp:HiddenField ID="HiddenFieldMain_ID" runat="server"></asp:HiddenField>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" SelectCommand="Select @PFNAME = PFNAME from patient"
                                ProviderName="<%$ ConnectionStrings:LGHConnectionString12.ProviderName %>" ConnectionString="<%$ ConnectionStrings:LGHConnectionString12 %>"></asp:SqlDataSource>
                            <asp:HiddenField ID="HiddenField2" runat="server"></asp:HiddenField>
                            <asp:SqlDataSource ID="ForTestGroup" runat="server" SelectCommand="
                                        
SELECT TGName, TGID FROM TestGroup 

where TGID in (SELECT DISTINCT Admin_Services.S_Category
FROM         
            [BasicDataInfo].[dbo].Admin_Services )           
                                        "
                                ProviderName="<%$ ConnectionStrings:Admin_OTConnectionString.ProviderName %>"
                                ConnectionString="<%$ ConnectionStrings:Admin_OTConnectionString %>">
                                <SelectParameters>
                                    <asp:SessionParameter Name="Hospital_Id" SessionField="HospitalId" />
                                    <asp:SessionParameter Name="Attached_College" SessionField="HospitalId" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="ForTestSubGroup" runat="server" SelectCommand="SELECT isnull(TestSubGroup.TSGName,'') as TSGName, TestSubGroup.TSGID, isnull(TestGroup.TGName,'') as TGName FROM TestSubGroup INNER JOIN TestGroup ON TestSubGroup.TGID = TestGroup.TGID WHERE (TestSubGroup.TGID = @TGID)"
                                ProviderName="<%$ ConnectionStrings:Admin_OTConnectionString.ProviderName %>" ConnectionString="Data Source=DEMO\HACIMS;Initial Catalog=Admin_OT;User ID=sa;Password=123;Max Pool Size=900;">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DataList1" Name="TGID" PropertyName="SelectedValue"
                                        Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="ForTest" runat="server" SelectCommand="SELECT [TestName], [TID] FROM [Test] WHERE ([TGID] = @TGID)"
                                ProviderName="<%$ ConnectionStrings:Admin_OTConnectionString.ProviderName %>" ConnectionString="Data Source=DEMO\HACIMS;Initial Catalog=Admin_OT;User ID=sa;Password=123;Max Pool Size=900;">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="HiddenFieldTestSubGroup" Name="TGID" PropertyName="Value"
                                        Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:HiddenField ID="HiddenFieldTestSubGroup" runat="server"></asp:HiddenField>
                            <asp:SqlDataSource ID="SqlDataSourcefortsetSG" runat="server" SelectCommand="SELECT [TID], [TestName] FROM [Test] WHERE ([TSGID] = @TSGID)"
                                ProviderName="<%$ ConnectionStrings:Admin_OTConnectionString.ProviderName %>" ConnectionString="Data Source=DEMO\HACIMS;Initial Catalog=Admin_OT;User ID=sa;Password=123;Max Pool Size=900;">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="HiddenField_for_test" Name="TSGID" PropertyName="Value"
                                        Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:HiddenField ID="HiddenField_for_test" runat="server"></asp:HiddenField>
                            <%-- </ContentTemplate>
                            </asp:UpdatePanel>--%>
                        </div>
                        <div class="TabbedPanelsContent">
                            <asp:GridView ID="GridView_Radiology" runat="server" AutoGenerateColumns="False"
                                Width="100%" CssClass="Grid_1" DataSourceID="SqlDataSourceRadiology" DataKeyNames="TB_ID">
                                <Columns>
                                    <asp:BoundField DataField="Doctor" HeaderText="Doctor" ReadOnly="True" SortExpression="Doctor" />
                                    <asp:BoundField DataField="TB_Name" HeaderText="TB_Name" SortExpression="TB_Name" />
                                    <asp:BoundField DataField="TB_ID" HeaderText="TB_ID" ReadOnly="True" SortExpression="TB_ID" Visible="False" />
                                    <asp:BoundField DataField="Date_Time" HeaderText="Date_Time" SortExpression="Date_Time" />
                                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                                    <%-- <asp:BoundField DataField="Clinical_Information" HeaderText="Clinical_Information" SortExpression="Clinical_Information" />
                                    --%>
                                    <asp:BoundField DataField="ModeOfOperation" HeaderText="ModeOfOperation" SortExpression="ModeOfOperation" />
                                    <asp:BoundField DataField="ModeOfAdmission" HeaderText="ModeOfAdmission" SortExpression="ModeOfAdmission" Visible="False" />
                                    <asp:CheckBoxField DataField="AnesthesiaOpinion" HeaderText="AnesthesiaOpinion" SortExpression="AnesthesiaOpinion" />
                                    <%--  <asp:BoundField DataField="AdviceToPatient" HeaderText="AdviceToPatient" SortExpression="AdviceToPatient" />
                                    --%>
                                    <asp:BoundField DataField="DateOfOperation" HeaderText="DateOfOperation" SortExpression="DateOfOperation" Visible="False" />
                                    <asp:BoundField DataField="Date_Of_admission" HeaderText="Date_Of_admission" SortExpression="Date_Of_admission" />
                                    <asp:BoundField DataField="YearlyNo" HeaderText="YearlyNo" SortExpression="YearlyNo" Visible="False" />
                                    <asp:BoundField DataField="RegNo" HeaderText="RegNo" SortExpression="RegNo" Visible="False" />
                                    <asp:BoundField DataField="Order_ID" HeaderText="Order_ID" SortExpression="Order_ID" />

                                    <asp:HyperLinkField DataNavigateUrlFields="Regno,YearlyNo" DataNavigateUrlFormatString="~/PT_EMR/pt_physician_order.aspx?RegNo={0}&amp;YearlyNo={1}"
                                        Text="Pre/Post Order"></asp:HyperLinkField>
                                    <asp:HyperLinkField DataNavigateUrlFields="Order_id" DataNavigateUrlFormatString="~/OT_management/Surgical_order_intermedcn_assessment.aspx?Order_Id={0}"
                                        Text="Internal Medicine"></asp:HyperLinkField>

                                    <asp:HyperLinkField DataNavigateUrlFields="Order_Id" DataNavigateUrlFormatString="~/OT_management/Surgical_order_anesthesia_assessment.aspx?Order_Id={0}"
                                        Text="Anesthesia"></asp:HyperLinkField>
                                    <asp:HyperLinkField DataNavigateUrlFields="Order_Id" DataNavigateUrlFormatString="~/OT_management/PreOperationConsultantNotesReport.aspx?Order_Id={0}"
                                        Text="Report"></asp:HyperLinkField>

                                </Columns>
                                <HeaderStyle CssClass="GridHeader" />
                                <SelectedRowStyle CssClass="RowItem" />
                                <AlternatingRowStyle CssClass="GridAltItem" />
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
    </table>

     
    <asp:Label ID="LabelFooter" runat="server" Text=""></asp:Label>
    <script type="text/javascript">
        var cookies = Spry.Utils.Cookie("read", "tabbedpanels_radiology");
        var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1", { defaultTab: cookies ? parseFloat(cookies) : 1 });
        Spry.Utils.addUnLoadListener(function () {
            // save the current value
            Spry.Utils.Cookie('create', 'tabbedpanels_radiology', TabbedPanels1.getCurrentTabIndex());
        });

    </script>
    <asp:HiddenField ID="HfPackageList" runat="server" />
</asp:Content>
