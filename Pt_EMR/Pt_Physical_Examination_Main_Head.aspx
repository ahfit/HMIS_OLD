<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>

<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Pt_Physical_Examination_Main_Head.aspx.vb"
    ValidateRequest="false" MasterPageFile="~/hacims_masterpage.master" Inherits="Pt_EMR_Pt_Physical_Examination_Main_Head" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script language="javascript" type="text/javascript">
        function ShowPanel(Control_ID) {
            document.getElementById("ctl00_ContentPlaceHolder1_HiddenFieldTextOther").value = Control_ID;
            document.getElementById('ctl00_ContentPlaceHolder1_Div_Text').style.visibility = 'visible';
            //document.getElementById('Div_Text').style.left=event.clientX-100;
            document.getElementById('ctl00_ContentPlaceHolder1_Div_Text').style.top = event.clientY - 100;
            document.getElementById("ctl00_ContentPlaceHolder1_TextBox1").value = document.getElementById(Control_ID).value;
        }
        function Show_Text_Value() {
            var id = document.getElementById("ctl00_ContentPlaceHolder1_HiddenFieldTextOther").value;
            var text = document.getElementById("ctl00_ContentPlaceHolder1_TextBox1").value;
            if (id != "") {
                document.getElementById(id).value = text;
            }
            document.getElementById("ctl00_ContentPlaceHolder1_HiddenFieldTextOther").value = "";
        }
        function showGrowthChart(elem) {            
            var chartId = $.trim($(elem).next().val ());
            window.open("../Patient%20Billing/PatientGrwothChart.aspx?ChartId=" + chartId);
        }
    </script>
    <script src="../css_hacims/autoresize.jquery.min.js" type="text/javascript"></script>
    <script src="../css_hacims/savetext.js" type="text/javascript"></script>
    <script>
        $(document).ready(function () {

            $(".example7").colorbox({ width: "1000px", height: "590px", iframe: true });
            $(".example8").colorbox({ width: "1000px", height: "590px", iframe: true });
            $("textarea#ctl00_ContentPlaceHolder1_TextBox_Remarks").autoResize({});

        });

        $(document).ready(function () { $("#ctl00_ContentPlaceHolder1_TextBox_Remarks").textSaver(); });
	  	 

    </script>
    <link rel="stylesheet" type="text/css" href="../css_hacims/cleditor/jquery.cleditor.css" />
    <script type="text/javascript" src="../css_hacims/cleditor/jquery.cleditor.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#ctl00_ContentPlaceHolder1_TextBox_Remarks").cleditor({ width: 800 });
        });
    </script>
    <script type="text/javascript">        $(document).ready(function () { $("textarea#ctl00_ContentPlaceHolder1_TextBox_Remarks").autoResize({}); });</script>
    <script src="../css_hacims/SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>
    <link href="../css_hacims/SpryAssets/SpryTabbedPanels.css" rel="stylesheet" type="text/css" />
    <script src="../css_hacims/ck.js" type="text/javascript"></script>
    <script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript"></script>
    <style type="text/css">
        .Grid_dynamic table td
        {
            border: 0;
        }
        .inter_thumbs li
        {
            margin-top: 10px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="leftnav" valign="top">
                <asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
                <asp:Panel ID="Panel2" runat="server" Visible="false">
                </asp:Panel>
            </td>
            <td style="width: auto;" valign="top">
                <%--  <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>--%>
                <asp:Label ID="Label_message" runat="server"></asp:Label>
                <ul class="inter_thumbs" style="display: none;">
                    <li><a href="dermatomes_mark.aspx" target="_blank" title="Dermatomes">
                        <img border="0" src="../images_hacims/img_image1.gif" id="IMG1" onclick="return IMG1_onclick()" /></a></li>
                    <li><a href="../diagrams_001/abdominal_examination.aspx" target="_blank" title="Abdominal Examination">
                        <img border="0" src="../images_hacims/img_image2.gif" /></a> </li>
                    <li><a href="../diagrams_001/chest_examination.aspx" title="Chest Examination" target="_blank">
                        <img border="0" src="../images_hacims/img_image3.gif" /></a></li>
                    <li><a href="../diagrams_001/urin_examination.aspx" title="Urin Examination" target="_blank">
                        <img border="0" src="../images_hacims/urin.gif" /></a></li>
                    <li><a href="../diagrams_001/heart_left_dominant.aspx" target="_blank" title="Heart Left Dominant">
                        <img border="0" src="../images_hacims/heart_a.png" /></a></li>
                    <li><a href="../diagrams_001/Heart_Right_dominant.aspx" target="_blank" title="Heart Right Dominant">
                        <img border="0" src="../images_hacims/heart_b.png" /></a></li>
                    <li><a href="../diagrams_001/heart_co_dominant.aspx" target="_blank" title="Heart co-Dominant">
                        <img border="0" src="../images_hacims/heart_c.png" /></a></li>
                    <li><a href="../diagrams_001/initial_periodontal_examination.aspx" target="_blank"
                        title="Initial Periodontal Examination">
                        <img border="0" src="../diagrams_001/dental_a.png" /></a></li>
                    <li><a href="../diagrams_001/dental_examination.aspx" target="_blank" title="Dental Examination">
                        <img border="0" src="../diagrams_001/dental_b.png" /></a></li>
                    <li><a href="../diagrams_001/oralpathology.aspx" target="_blank" title="Oral Pathology">
                        <img border="0" src="../diagrams_001/dental_c.png" /></a></li>
                    <li><a href="../diagrams_001/dentalexaminationB.aspx" target="_blank" title="Dental Examination">
                        <img border="0" src="../diagrams_001/dental_d.png" /></a></li>
                    <li><a href="../diagrams_001/dental_chart.aspx" target="_blank" title="Dental Chart">
                        <img border="0" src="../diagrams_001/dental_e.png" /></a></li>
                    <li><a href="../diagrams_001/ophthalmology.aspx" target="_blank" title="Opthomology">
                        <img border="0" src="../diagrams_001/opthology.png" /></a></li>
                </ul>
                <br />
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top" width="100%">
                            <div style="margin-left: 8px;">
                                <div style="padding: 2px 0 20px 20px; display:none;">
                                    <div style="color: Green; font-size: 13px; font-weight: bold; border-bottom: solid 1px #ccc;width:100px;
                                        padding-bottom: 3px;">Growth Charts</div>
                                        <div style="padding-top:10px;">
                                    <asp:DataList ID="dlCharts" runat="server" RepeatDirection="Horizontal">
                                        <ItemTemplate>
                                            <asp:Label ID="lblChart" runat="server" Text='<%# Bind("ChartName") %>' onclick="showGrowthChart(this)"
                                                Style="color: Blue; font-size: 12px; font-weight: bold; cursor: pointer; padding-right: 20px;"></asp:Label>
                                            <asp:HiddenField ID="hdnChartId" runat="server" Value='<%# Bind("ChartId") %>' />
                                        </ItemTemplate>
                                    </asp:DataList>
                                    </div>
                                </div>
                                <div id="TabbedPanels1" class="TabbedPanels">
                                    <ul class="TabbedPanelsTabGroup" style="margin-left: 10px;">
                                        <li class="TabbedPanelsTab" tabindex="0">Form</li><li class="TabbedPanelsTab" tabindex="0">
                                            Remarks</li></ul>
                                    <div class="TabbedPanelsContentGroup" style="height: auto;">
                                        <div class="TabbedPanelsContent">
                                            <asp:Panel ID="Panel1" runat="server" Width="100%">
                                            </asp:Panel>
                                            <asp:DataList ID="DataListtemplate" runat="server" DataKeyField="Template_id" DataSourceID="SqlDataSourceTemplate"
                                                RepeatColumns="5" RepeatDirection="Horizontal" Style="position: static" Width="100%"
                                                Visible="False">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="SelectButton" runat="server" CommandName="Select" CssClass="login_link"
                                                        ForeColor="Blue" Style="position: static" Text='<%# Eval("Template_Name", "{0}") %>'></asp:LinkButton>
                                                </ItemTemplate>
                                                <SeparatorStyle BorderWidth="1px" CssClass="griditem" />
                                            </asp:DataList><asp:SqlDataSource ID="SqlDataSourceTemplate" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                                                SelectCommand="SELECT Admin_Assign_Template.Template_Id, Admin_Template.Template_Name FROM Admin_Assign_Template INNER JOIN Admin_Template ON Admin_Assign_Template.Template_Id = Admin_Template.Template_Id WHERE (Admin_Assign_Template.subdept_id = @subdeptid)&#13;&#10;and (Admin_Assign_Template.dept_id = @deptid)"
                                                ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>">
                                                <SelectParameters>
                                                    <asp:SessionParameter Name="subdeptid" SessionField="SubDeptID" />
                                                    <asp:SessionParameter Name="deptid" SessionField="dept_id" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </div>
                                        <div class="TabbedPanelsContent">
                                            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                <tr>
                                                    <td width="50%" valign="top">
                                                        <asp:TextBox ID="TextBox_Remarks" runat="server" Height="150px" Width="98%" TextMode="MultiLine"></asp:TextBox>
                                                    </td>
                                                    <td width="50%" valign="top" align="left">
                                                        <asp:Label ID="Label_Select_All" runat="server" Visible="False">find</asp:Label>
                                                        <asp:DataList ID="DataList_remarks" runat="server" DataSourceID="SqlDataSource_select_all"
                                                            Width="98%" Style="margin-left: 2px;">
                                                            <ItemTemplate>
                                                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form" style="border-bottom: #CCC dotted 1px;">
                                                                    <tr>
                                                                        <td style="padding-bottom: 5px;">
                                                                            <strong>
                                                                                <asp:Label ID="Complaint_NameLabel" runat="server" Text='<%# Eval("MH_Heading") %>'></asp:Label></strong><br />
                                                                            <asp:LinkButton ID="LinkButton_Description" runat="server" CommandName="Select" CssClass="linkc"
                                                                                Text='<%# Eval("Remarks") %>'></asp:LinkButton>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                                <asp:HiddenField ID="HiddenField_Complaint_ID" runat="server" Value='<%# Eval("MH_Code", "{0}") %>' />
                                                            </ItemTemplate>
                                                        </asp:DataList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
                <asp:SqlDataSource ID="SqlDataSourceMainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                    SelectCommand="SELECT DISTINCT Admin_Exam_Main_Heading.MH_Heading, Admin_Exam_Main_Heading.Priority, Admin_Exam_Main_Heading.MH_Code FROM Admin_Exam_Main_Heading INNER JOIN Admin_Exam_MainHeading_Group ON Admin_Exam_Main_Heading.MH_Code = Admin_Exam_MainHeading_Group.MH_Code WHERE (Admin_Exam_MainHeading_Group.Mg_Code IN (SELECT MainGroup_Id FROM Admin_Template_phy_Elements WHERE (Template_Id = @Template_Id))) AND (Admin_Exam_Main_Heading.Dept_id = @detp_id) ORDER BY Admin_Exam_Main_Heading.Priority"
                    ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="HiddenFieldTemplate_id" Name="Template_Id" PropertyName="Value" />
                        <asp:SessionParameter Name="detp_id" SessionField="dept_id" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource_select_all" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                    InsertCommand="Insert_Patient_Complaint_out" InsertCommandType="StoredProcedure"
                    ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                    SelectCommand="SELECT ISNULL(OPD_Encounter_Form_Remarks.Remarks, '') AS Remarks, Admin_Exam_Main_Heading.MH_Heading, Admin_Exam_Main_Heading.MH_Code FROM OPD_Encounter_Form_Remarks INNER JOIN Admin_Exam_Main_Heading ON OPD_Encounter_Form_Remarks.MH_Code = Admin_Exam_Main_Heading.MH_Code WHERE (OPD_Encounter_Form_Remarks.Yearly_No = @YearlyNo) and Type_val='PHY'">
                    <SelectParameters>
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                        <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                        <asp:ControlParameter ControlID="HiddenFieldComplaint_ID" Name="Complaint_ID" PropertyName="Value" />
                        <asp:SessionParameter Name="empid" SessionField="emp_id" />
                        <asp:ControlParameter ControlID="TextBox_Remarks" Name="Description" PropertyName="Text"
                            Type="String" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource_OPD_Encounter_Form_Remarks" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                    DeleteCommand="DELETE FROM [OPD_Encounter_Form_Remarks] WHERE [Reg_No] = @Reg_No AND [Yearly_No] = @Yearly_No AND [MH_Code] = @MH_Code"
                    InsertCommand="OPD_Encounter_Form_Remarks_Insert" InsertCommandType="StoredProcedure"
                    SelectCommand="SELECT  [Remarks] FROM [OPD_Encounter_Form_Remarks] where [Reg_No]=@Reg_No and  [Yearly_No]=@Yearly_No and [MH_Code]=@MH_Code and Type_Val='PHY'"
                    UpdateCommand="UPDATE [OPD_Encounter_Form_Remarks] SET [Remarks] = @Remarks WHERE [Reg_No] = @Reg_No AND [Yearly_No] = @Yearly_No AND [MH_Code] = @MH_Code">
                    <SelectParameters>
                        <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" />
                        <asp:SessionParameter Name="Yearly_No" SessionField="Yearlyno" />
                        <asp:ControlParameter ControlID="HiddenField3" Name="MH_Code" PropertyName="Value" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="Reg_No" Type="String" />
                        <asp:Parameter Name="Yearly_No" Type="String" />
                        <asp:Parameter Name="MH_Code" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Remarks" Type="String" />
                        <asp:Parameter Name="Reg_No" Type="String" />
                        <asp:Parameter Name="Yearly_No" Type="String" />
                        <asp:Parameter Name="MH_Code" Type="Int32" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" Type="String" />
                        <asp:SessionParameter Name="Yearly_No" SessionField="Yearlyno" Type="String" />
                        <asp:ControlParameter ControlID="HiddenField3" Name="MH_Code" PropertyName="Value"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="TextBox_Remarks" Name="Remarks" PropertyName="Text"
                            Type="String" />
                        <asp:Parameter DefaultValue="PHY" Name="type" Type="String" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
                    DataSourceID="SqlDataSourceSaveValue" Width="95%">
                    <Columns>
                        <asp:BoundField DataField="e_Name" HeaderText="Element" SortExpression="e_Name" />
                        <asp:BoundField DataField="Exam_Result" HeaderText="Value" SortExpression="Exam_Result" />
                        <asp:BoundField DataField="Time" HeaderText="Date Time" SortExpression="Time" />
                    </Columns>
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
                <br />
                <div align="center">
                    <asp:Button ID="Button_Save" runat="server" Text="Save" />
                    <asp:SqlDataSource ID="SqlDataSourceSaveValue" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                        SelectCommand="SELECT Pt_physical_exam_saveRecord.Exam_Result, admin_Phy_Exam_Elements.e_Name, Pt_physical_exam_saveRecord.Time FROM Pt_physical_exam_saveRecord INNER JOIN Admin_Exam_MainHeading_Group ON Pt_physical_exam_saveRecord.body_system_Id = Admin_Exam_MainHeading_Group.Mg_Code INNER JOIN admin_Phy_Exam_Elements ON Pt_physical_exam_saveRecord.E_ID = admin_Phy_Exam_Elements.e_Code WHERE (Pt_physical_exam_saveRecord.YearlyNo = @YearlyNo) AND (Pt_physical_exam_saveRecord.RegNo = @RegNo) AND (Pt_physical_exam_saveRecord.Ele_Status = 0) AND (Admin_Exam_MainHeading_Group.MH_Code = @MH_Code) ORDER BY admin_Phy_Exam_Elements.e_Name, Pt_physical_exam_saveRecord.Time DESC">
                        <SelectParameters>
                            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                            <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                            <asp:ControlParameter ControlID="ListBox1" Name="MH_Code" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:HiddenField ID="HiddenField2" runat="server" Value="0" />
                    <asp:HiddenField ID="HiddenField3" runat="server" Value="0" />
                    <asp:HiddenField ID="HiddenFieldTemplate_id" runat="server" />
                </div>
                <asp:HiddenField ID="HiddenFieldTextOther" runat="server" />
                <asp:ListBox ID="ListBox1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceMainGroup"
                    DataTextField="MH_Heading" DataValueField="MH_Code" Height="222px" Width="96%"
                    Visible="False"></asp:ListBox>
                <br />
                <div style="width: 20%; float: left; clear: right;">
                    &nbsp;
                    <div id="Div_Text" style="border-right: #999999 3px solid; padding-right: 10px; border-top: #999999 3px solid;
                        padding-left: 10px; z-index: 100; left: 552px; visibility: hidden; padding-bottom: 10px;
                        border-left: #999999 3px solid; width: 250px; padding-top: 10px; border-bottom: #999999 3px solid;
                        position: absolute; top: 72px; height: 100px; background-color: #ffffff">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td align="right">
                                    <asp:Button ID="Button1" runat="server" CssClass="btn_close" Text="" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox ID="TextBox1" runat="server" CssClass="input_txt" Height="88px" TextMode="MultiLine"
                                        Width="100%"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </td>
        </tr>
    </table>
    <asp:Label ID="LabelFooter" runat="server" Text=""></asp:Label>
    <script type="text/javascript">
<!--
        var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1", { defaultTab: 1 });
//-->
    </script>
    <script type="text/javascript">
        var cookies = Spry.Utils.Cookie("read", "tabbedpanels");
        var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1", { defaultTab: cookies ? parseFloat(cookies) : 0 });
        Spry.Utils.addUnLoadListener(function () {
            // save the current value
            Spry.Utils.Cookie('create', 'tabbedpanels', TabbedPanels1.getCurrentTabIndex());
        });

    </script>
</asp:Content>
