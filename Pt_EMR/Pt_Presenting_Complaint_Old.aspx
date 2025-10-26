<%@ page language="VB" autoeventwireup="false" validaterequest="false" debug="true" masterpagefile="~/hacims_masterpage.master" inherits="Pt_EMR_Pt_Presenting_Complaint, App_Web_p0fljamz" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../css_hacims/SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>
    <link href="../css_hacims/SpryAssets/SpryTabbedPanels.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript">
        $(document).ready(function () {

            $(".link_review").colorbox({ width: "1000px", height: "580px", iframe: true });
            $("#ctl00_ContentPlaceHolder1_TextBox_Remarks").focus();
        });
		


    </script>
    <script src="../SpryAssets/mycollaps.js" type="text/javascript"></script>
    <script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript"></script>
    <style type="text/css">
        .Grid_dynamic table td
        {
            border: 0;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="../css_hacims/cleditor/jquery.cleditor.css" />
    <script src="../css_hacims/ck.js" type="text/javascript"></script>
    <script type="text/javascript" src="../css_hacims/cleditor/jquery.cleditor.min.js"></script>
    
    <script type="text/javascript">

        function complaintSelected(sender, e) {
            $get("<%=hfComplaintId.ClientID %>").value = e.get_value();
        }
        
    </script>
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td valign="top" class="leftnav">
                <asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
            </td>
            <td style="width: auto;" valign="top">
                <asp:Label ID="LabelComplaintID" CssClass="err" runat="server" Visible="False"></asp:Label>
                <div align="right">
                    <a runat="server" title="Patient Review" href="~/Pt_EMR/Pt_Infoinside.aspx" class="report"
                        visible="false">Patient Review</a>
                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn_hacims" Visible="false">Add Medicine</asp:LinkButton>
                    
                    <div id="divload" visible="false" runat="server" style="position:absolute; border:solid 1px;     padding: 10px;   background-color: aliceblue;z-index: 999; min-height:300px;height:500px;min-width:800px; width:1000px; overflow-y:auto; top:10%;">
                    <iframe id="iframComplaintTemplate"  runat="server"  scrolling="yes" frameborder="0"  style="min-height:300px;height:500px;min-width:800px; width:1000px;"  method="post"></iframe>
                    </div>
                    
                </div>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <cc1:AutoCompleteExtender ID="AutoComplete_Complaint" runat="server" CompletionListCssClass="AutoExtender"
                    CompletionListItemCssClass="AutoExtenderList" CompletionListHighlightedItemCssClass="AutoExtenderHighlight"
                    CompletionInterval="10" CompletionSetCount="12" EnableCaching="true" MinimumPrefixLength="3"
                    ServiceMethod="pre_complaint" OnClientItemSelected="complaintSelected"  ServicePath="../AutoComplete.asmx" TargetControlID="TextBoxComplaint_Name">
                </cc1:AutoCompleteExtender>
                <asp:HiddenField ID="hfComplaintId" runat="server" Value="0" />
                <asp:CheckBox ID="CheckBox1" Visible="false" runat="server" Text="Chief Complaint" />
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top" width="30%">
                            <div class="bxmain">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                                    <tr>
                                        <td>
                                            <strong>Complaint</strong>
                                        </td>
                                        <td>
                                            <strong>Duration</strong>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" valign="top">
                                            <asp:TextBox ID="TextBoxComplaint_Name" runat="server" Width="160px"></asp:TextBox>&nbsp;                                            
                                            <asp:TextBox ID="TextBoxDuration" runat="server" SkinID="intdata" Width="32px"></asp:TextBox>
                                            <asp:DropDownList ID="DropDownListDuration" runat="server" Width="70px" Style="height: 22px;
                                                margin-left: 2px;">
                                                <asp:ListItem>Hours</asp:ListItem>
                                                <asp:ListItem>Days</asp:ListItem>
                                                <asp:ListItem>Week</asp:ListItem>
                                                <asp:ListItem>Month</asp:ListItem>
                                                <asp:ListItem>Year</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:LinkButton ID="LinkButton_Add" runat="server">Add</asp:LinkButton>
                                            <asp:LinkButton ID="LinkButton_Cancel" runat="server" Visible="False">Cancel</asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                                <asp:ListBox ID="ListBox2" runat="server" AutoPostBack="True" Width="98%" Style="margin-top: 3px;
                                    margin-left: 3px;" Height="310px" CssClass="listbox"></asp:ListBox>
                                
                                <asp:XmlDataSource ID="XmlDataSource1" runat="server" DataFile="~/Complaints1.xml">
                                </asp:XmlDataSource>
                                <asp:Label ID="LabelComplaint" runat="server" CssClass="red" Visible="false" Style="background: none;
                                    padding-left: 0;"></asp:Label>
                                <asp:Button ID="ButtonRemove" runat="server" Text="Remove" SkinID="remove_btn" OnClick="ButtonRemove_Click"
                                    Visible="False" />
                                <asp:Button ID="ButtonEdit" runat="server" Text="Edit" SkinID="Edit_btn" Visible="False" />
                            </div>
                        </td>
                        <td valign="top" width="65%">
                            <div style="margin-left: 8px;">
                                <div id="TabbedPanels1" class="TabbedPanels">
                                    <ul class="TabbedPanelsTabGroup" style="margin-left: 10px;">                                       
                                        <li class="TabbedPanelsTab" tabindex="0" >Form</li>
                                        <li class="TabbedPanelsTab TabbedPanelsTabSelected" tabindex="1">Remarks</li></ul>                                        

                                    <div class="TabbedPanelsContentGroup" style="min-height: 223px;">                                        
                                       <div class="TabbedPanelsContent">
                                            <asp:Panel ID="Panel1" runat="server" Width="99%">
                                            </asp:Panel>
                                        </div>
                                         <div class="TabbedPanelsContent">
                                            <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label_name" runat="server" CssClass="red" Style="line-height: 20px;"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="height: 18px">
                                                        <asp:TextBox ID="TextBox_Remarks" CssClass="remarksbox" runat="server" Height="300px"
                                                            TextMode="MultiLine" Width="98%" BorderStyle="None"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                            <asp:Label ID="Label_Select_All" runat="server" Style="margin-left: 5px; margin-top: 5px;"></asp:Label>
                                            <asp:DataList ID="DataList_remarks" runat="server" DataSourceID="SqlDataSource_select_all"
                                                Visible="false">
                                                <ItemTemplate>
                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                                                        <tr>
                                                            <td>
                                                                <strong>
                                                                    <asp:Label ID="Complaint_NameLabel" runat="server" Text='<%# Eval("Complaint_Name") %>'></asp:Label></strong><br />
                                                                <asp:LinkButton ID="LinkButton_Description" runat="server" CommandName="Select" CssClass="linkc"
                                                                    Text='<%# Eval("Description") %>'></asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <asp:HiddenField ID="HiddenField_Complaint_ID" runat="server" Value='<%# Eval("Complaint_ID", "{0}") %>' />
                                                </ItemTemplate>
                                            </asp:DataList>
                                        </div>                                        
                                    </div>
                                </div>
                            </div>
                            <div align="center">
                                <asp:Button ID="Button_Save" runat="server" Text="Save" />
                            </div>
                        </td>
                    </tr>
                </table>
                <br />
                <asp:TextBox ID="remarks" Height="100px" runat="server" TextMode="MultiLine" Style="display: none;"
                    Visible="false"></asp:TextBox>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                    InsertCommand="Insert_Patient_Complaint_out" InsertCommandType="StoredProcedure"
                    ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                    SelectCommand="SELECT Description FROM Pt_Presenting_Complaint_saveRecord WHERE (YearlyNo = @YearlyNo) AND (RegNo = @RegNo) AND (Complaint_ID = @Complaint_ID)">
                    <SelectParameters>
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                        <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                        <asp:ControlParameter ControlID="HiddenFieldComplaint_ID" Name="Complaint_ID" PropertyName="Value" />
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
                <asp:SqlDataSource ID="SqlDataSource_select_all" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                    InsertCommand="Admin_Complaint_MainGroup_insert" InsertCommandType="StoredProcedure"
                    ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                    SelectCommand="SELECT Pt_Presenting_Complaint_saveRecord.Description, Admin_Complaint_MainGroup.Complaint_Name + ' ' + ISNULL(CONVERT (varchar, Pt_Presenting_Complaint_saveRecord.Duration), '') + ' ' + ISNULL(Pt_Presenting_Complaint_saveRecord.Duration_Time, '') AS Complaint_Name, Admin_Complaint_MainGroup.Complaint_ID FROM Pt_Presenting_Complaint_saveRecord INNER JOIN Admin_Complaint_MainGroup ON Pt_Presenting_Complaint_saveRecord.Complaint_ID = Admin_Complaint_MainGroup.Complaint_ID WHERE (Pt_Presenting_Complaint_saveRecord.YearlyNo = @YearlyNo) AND (Pt_Presenting_Complaint_saveRecord.RegNo = @RegNo)"
                    UpdateCommand="UPDATE Pt_Presenting_Complaint_saveRecord SET Duration =@Duration, Duration_Time =@Duration_Time WHERE YearlyNo =@YearlyNo and  RegNo =@RegNo and Complaint_ID =@Complaint_ID">
                    <SelectParameters>
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                        <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:ControlParameter ControlID="TextBoxComplaint_Name" Name="Complaint_Name" PropertyName="Text"
                            Type="String" />
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
                        <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
                        <asp:SessionParameter Name="empid" SessionField="emp_ID" Type="Int32" />
                        <asp:ControlParameter ControlID="TextBoxDuration" Name="Duration" PropertyName="Text"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="DropDownListDuration" Name="Duration_Time" PropertyName="SelectedValue"
                            Type="String" />
                        <asp:Parameter Direction="Output" Name="Complaint_ID_new" Type="Int32" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="TextBoxDuration" Name="Duration" PropertyName="Text" />
                        <asp:ControlParameter ControlID="DropDownListDuration" Name="Duration_Time" PropertyName="SelectedValue" />
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                        <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                        <asp:ControlParameter ControlID="HiddenFieldComplaint_ID" Name="Complaint_ID" PropertyName="Value" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:XmlDataSource ID="XmlDataSourceXML" runat="server" DataFile="~/Complaints1.xml"
                    XPath="/root/Pt_Presenting_Complaint"></asp:XmlDataSource>
                <asp:DataList ID="DataList1" runat="server" DataKeyField="Complaint_ID" DataSourceID="SqlDataSource1"
                    RepeatColumns="5" RepeatDirection="Horizontal" Visible="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButtonName" runat="server" CommandName="Select" Text='<%# Eval("Complaint_Name") %>'></asp:LinkButton>
                        <asp:Label ID="Column1Label" runat="server" Text='<%# Eval("Column1") %>' Visible="False"></asp:Label>
                    </ItemTemplate>
                </asp:DataList><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                    SelectCommand="SELECT DISTINCT Admin_Complaint_MainGroup.Complaint_Name, Admin_Complaint_MainGroup.Complaint_ID,isnull(Chief_Complaint,0) FROM Pt_Presenting_Complaint_saveRecord INNER JOIN Admin_Complaint_MainGroup ON Pt_Presenting_Complaint_saveRecord.Complaint_ID = Admin_Complaint_MainGroup.Complaint_ID WHERE (Pt_Presenting_Complaint_saveRecord.YearlyNo = @YearlyNo) AND (Pt_Presenting_Complaint_saveRecord.RegNo = @RegNo)">
                    <SelectParameters>
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                        <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                    </SelectParameters>
                </asp:SqlDataSource>
                
                <asp:SqlDataSource ID="SqlDataSourceSave" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                    InsertCommand="Insert_Patient_Complaint" ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                    InsertCommandType="StoredProcedure">
                    <InsertParameters>
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                        <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                        <asp:ControlParameter ControlID="HiddenFieldComplaint_ID" Name="Complaint_ID" PropertyName="Value" />
                        <asp:SessionParameter Name="empid" SessionField="emp_id" />
                        <asp:ControlParameter ControlID="HiddenFieldChief_Complaint" Name="Chief_Complaint"
                            PropertyName="Value" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenFieldTemplate_id" runat="server" Value="0" />
                <asp:HiddenField ID="HiddenFieldChief_Complaint" runat="server" />
                <asp:HiddenField ID="HiddenFieldDuration" runat="server" />
                <asp:HiddenField ID="HiddenFieldZone" runat="server" />
                <asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                    SelectCommand="SELECT     Admin_Complaint_MainGroup.Complaint_Name AS [Complaint Name], CONVERT(varchar, Pt_Presenting_Complaint_saveRecord.Date, 103) &#13;&#10;                      AS [Complaint Date]&#13;&#10;FROM         Pt_Presenting_Complaint_saveRecord INNER JOIN&#13;&#10;                      Admin_Complaint_MainGroup ON Pt_Presenting_Complaint_saveRecord.Complaint_ID = Admin_Complaint_MainGroup.Complaint_ID&#13;&#10;WHERE     (Pt_Presenting_Complaint_saveRecord.YearlyNo = @yearlyNo) AND (Pt_Presenting_Complaint_saveRecord.RegNo = @regno)">
                    <SelectParameters>
                        <asp:SessionParameter Name="regno" SessionField="registrationNo" Type="String" />
                        <asp:SessionParameter Name="yearlyNo" SessionField="YearlyNo" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenFieldComplaint_ID" runat="server" />
                <asp:HiddenField ID="HiddenFieldBodyPart" runat="server" />
                <asp:SqlDataSource ID="SqlDataSourceBodyPart" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT Pt_Main_Body_Part.pt_Main_Body_Part_ID, Pt_Main_Body_Part.pt_Main_Body_Part FROM Pt_Main_Body_Part INNER JOIN pt_BodyPart_Maintain ON Pt_Main_Body_Part.pt_Main_Body_Part_ID = pt_BodyPart_Maintain.Pt_Main_Body_Part WHERE (pt_BodyPart_Maintain.Complain_Id = @Complain_Id) ORDER BY Pt_Main_Body_Part.Pirority">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="HiddenFieldComplaint_ID" Name="Complain_Id" PropertyName="Value" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenFieldSide" runat="server" />
                <asp:HiddenField ID="HiddenFieldDurationTime" runat="server" />
                <asp:HiddenField ID="HiddenField2" runat="server" Value="0" />
                <asp:HiddenField ID="HiddenField3" runat="server" Value="0" />
                <asp:HiddenField ID="HiddenField_Complaint_new" runat="server" />
                <asp:GridView ID="GridViewComplaint" runat="server" AutoGenerateColumns="False" Visible="false"
                    DataSourceID="SqlDataSourceForGrid" Width="100%">
                    <Columns>
                        <asp:BoundField DataField="Complaint Name" HeaderText="Complaint Name" SortExpression="Complaint Name" />
                        <asp:BoundField DataField="Complaint Date" HeaderText="Complaint Date" SortExpression="Complaint Date" />
                    </Columns>
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
            </td>
        </tr>
    </table>
    <asp:Label ID="LabelFooter" runat="server" Text="Label"></asp:Label>
    <script type="text/javascript">
        var cookies = Spry.Utils.Cookie("read", "tabbedpanels_pr_complaints");
        var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1", { defaultTab: cookies ? parseFloat(cookies) : 0 });
        Spry.Utils.addUnLoadListener(function () {
            // save the current value
            Spry.Utils.Cookie('create', 'tabbedpanels_pr_complaints', TabbedPanels1.getCurrentTabIndex());
        });
    </script>
</asp:Content>
