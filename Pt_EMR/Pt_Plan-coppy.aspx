<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage.master" inherits="Pt_EMR_Pt_Plan, App_Web_p0fljamz" validaterequest="false" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebHtmlEditor.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebHtmlEditor" TagPrefix="ighedit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        function picture() {
            window.open("mlc_mainpic.aspx?reg={0}&yno={1}");
        }
    </script>

    <script src="../css_hacims/ck.js" type="text/javascript"></script>

    <script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript"></script>

    <script src="../SpryAssets/mycollaps.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td valign="top" class="leftnav">
                <asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
                <asp:Panel ID="Panel1" runat="server" Visible="False">
                </asp:Panel>
            </td>
            <td style="width: auto;" valign="top">
                <div class="bx_rad" style="width: 100%;">
                    <ul id="CollapsiblePanel1">
                        <li><strong>&nbsp;View Patient Report</strong></li>
                        <li>
                            <div style="background: #fff; overflow: auto; overflow-x: hidden; width: 100%; height: 250px;">
                                <iframe width="100%" height="100%" frameborder="0" src="../PatientFaceSheet.aspx"></iframe>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="drop_doiwn" style="width:100%">
                    <div class="in_drop_doiwn" style="width:60%;padding-left: 40%;padding-top:5px;">
                        <asp:DropDownList ID="DropDownList1" runat="server" Width="250px" AutoPostBack="True"
                            DataSourceID="SqlDataSource1" DataTextField="physicianNotes_Category" DataValueField="ID">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                            ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                            SelectCommand="SELECT [ID], [physicianNotes_Category] FROM [physician_Instruction]"></asp:SqlDataSource>
                        <asp:HiddenField ID="HF_physician_category_notes" runat="server" />
                    </div>
                    <!--in_drop_doiwn-->
                </div>
                <!--drop_doiwn -->
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="25%" valign="top" style="height: 666px">
                            <div class="bx_infos" style="height: 273px;margin-top: 10px;">
                                <h2>
                                    <span>Physician Notes</span></h2>
                                <div style="width: 100%; height: 230px; display: block; overflow: auto; overflow-x: hidden; margin-top: 5px;">
                                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_pt_Treatment_Plan"
                                        Width="100%" DataKeyNames="Plan_id">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <table cellpadding="0" cellspacing="0" width="100%" border="0" class="tbl_form">
                                                        <tr>
                                                            <td style="border: 0; line-height: 15px;">
                                                                <p>
                                                                </p>
                                                                <p style="margin-top: 2px;">
                                                                    &nbsp;<span style="color: #900;">
                                                                        <asp:LinkButton
                                                                            ID="LinkButton1" runat="server" CommandName="Select" CommandArgument='<%# Eval("Date") %>' OnClick="LinkButton1_Click1"
                                                                            Text='<%# Eval("Date", "{0:g}") %>'></asp:LinkButton>

                                                                        <asp:Label ID="Label1" runat="server" CssClass="small_f" Text='<%# Eval("[Physician Name]", "{0}") %>'></asp:Label>
                                                                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("Department") %>'></asp:Label>()</span>
                                                                </p>
                                                                <span style="border-bottom: #e1e1e1 dotted 1px; display: block; height: 1px; width: 100%; margin-top: 3px; margin-bottom: 3px;">&nbsp;<span style="color: #900;"></span></span></td>
                                                        </tr>
                                                    </table>
                                                    <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("Plan_Detail") %>' />
                                                </ItemTemplate>
                                                <HeaderStyle CssClass="hide" />
                                            </asp:TemplateField>

                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </td>
                        <td width="75%" valign="top" style="height: 666px; margin-top: 10px;">
                            <div style="margin-left: 10px;margin-top: 10px;">
                                <dialog internaldialogtype="InsertRule"></dialog>
                                <dialog backcolor="#ECE9D8" bordercolor="Black" borderstyle="Solid" borderwidth="1px"
                                    font-names="sans-serif" font-size="8pt" forecolor="Black"></dialog>
                                <ighedit:WebHtmlEditor ID="WebHtmlEditor1" Width="100%" Height="275px" runat="server"
                                    UploadedFilesDirectory="HtmlEditor" ImageDirectory="/htmleditor/">
                                    <Toolbar>
                                        <ighedit:ToolbarImage runat="server" Type="DoubleSeparator"></ighedit:ToolbarImage>
                                        <ighedit:ToolbarButton runat="server" Type="Bold"></ighedit:ToolbarButton>
                                        <ighedit:ToolbarButton runat="server" Type="Italic"></ighedit:ToolbarButton>
                                        <ighedit:ToolbarButton runat="server" Type="Underline"></ighedit:ToolbarButton>
                                        <ighedit:ToolbarButton runat="server" Type="Strikethrough"></ighedit:ToolbarButton>
                                        <ighedit:ToolbarImage runat="server" Type="Separator"></ighedit:ToolbarImage>
                                        <ighedit:ToolbarButton runat="server" Type="Subscript"></ighedit:ToolbarButton>
                                        <ighedit:ToolbarButton runat="server" Type="Superscript"></ighedit:ToolbarButton>
                                        <ighedit:ToolbarImage runat="server" Type="Separator"></ighedit:ToolbarImage>
                                        <ighedit:ToolbarButton runat="server" Type="Cut"></ighedit:ToolbarButton>
                                        <ighedit:ToolbarButton runat="server" Type="Copy"></ighedit:ToolbarButton>
                                        <ighedit:ToolbarButton runat="server" Type="Paste"></ighedit:ToolbarButton>
                                        <ighedit:ToolbarImage runat="server" Type="Separator"></ighedit:ToolbarImage>
                                        <ighedit:ToolbarButton runat="server" Type="Undo"></ighedit:ToolbarButton>
                                        <ighedit:ToolbarButton runat="server" Type="Redo"></ighedit:ToolbarButton>
                                        <ighedit:ToolbarImage runat="server" Type="Separator"></ighedit:ToolbarImage>
                                        <ighedit:ToolbarButton runat="server" Type="JustifyLeft"></ighedit:ToolbarButton>
                                        <ighedit:ToolbarButton runat="server" Type="JustifyCenter"></ighedit:ToolbarButton>
                                        <ighedit:ToolbarButton runat="server" Type="JustifyRight"></ighedit:ToolbarButton>
                                        <ighedit:ToolbarButton runat="server" Type="JustifyFull"></ighedit:ToolbarButton>
                                        <ighedit:ToolbarImage runat="server" Type="Separator"></ighedit:ToolbarImage>
                                        <ighedit:ToolbarButton runat="server" Type="Indent"></ighedit:ToolbarButton>
                                        <ighedit:ToolbarButton runat="server" Type="Outdent"></ighedit:ToolbarButton>
                                        <ighedit:ToolbarImage runat="server" Type="Separator"></ighedit:ToolbarImage>
                                        <ighedit:ToolbarButton runat="server" Type="UnorderedList"></ighedit:ToolbarButton>
                                        <ighedit:ToolbarButton runat="server" Type="OrderedList"></ighedit:ToolbarButton>
                                        <ighedit:ToolbarImage runat="server" Type="Separator"></ighedit:ToolbarImage>
                                        <ighedit:ToolbarDialogButton runat="server" Type="InsertRule">
                                            <Dialog InternalDialogType="InsertRule"></Dialog>
                                        </ighedit:ToolbarDialogButton>
                                        <ighedit:ToolbarImage runat="server" Type="RowSeparator"></ighedit:ToolbarImage>
                                        <ighedit:ToolbarImage runat="server" Type="DoubleSeparator"></ighedit:ToolbarImage>
                                        <ighedit:ToolbarDialogButton runat="server" Type="FontColor">
                                            <Dialog BackColor="#ECE9D8" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px"
                                                Font-Names="sans-serif" Font-Size="8pt" ForeColor="Black" />
                                        </ighedit:ToolbarDialogButton>
                                        <ighedit:ToolbarDialogButton runat="server" Type="FontHighlight">
                                            <Dialog BackColor="#ECE9D8" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px"
                                                Font-Names="sans-serif" Font-Size="8pt" ForeColor="Black" />
                                        </ighedit:ToolbarDialogButton>
                                        <ighedit:ToolbarDialogButton runat="server" Type="SpecialCharacter">
                                            <Dialog InternalDialogType="SpecialCharacterPicker" Type="InternalWindow"></Dialog>
                                        </ighedit:ToolbarDialogButton>
                                        <ighedit:ToolbarMenuButton runat="server" Type="InsertTable">
                                            <Menu Width="80px">
                                                <ighedit:HtmlBoxMenuItem runat="server" Act="TableProperties">
                                                    <Dialog InternalDialogType="InsertTable"></Dialog>
                                                </ighedit:HtmlBoxMenuItem>
                                                <ighedit:HtmlBoxMenuItem runat="server" Act="InsertColumnRight">
                                                </ighedit:HtmlBoxMenuItem>
                                                <ighedit:HtmlBoxMenuItem runat="server" Act="InsertColumnLeft">
                                                </ighedit:HtmlBoxMenuItem>
                                                <ighedit:HtmlBoxMenuItem runat="server" Act="InsertRowAbove">
                                                </ighedit:HtmlBoxMenuItem>
                                                <ighedit:HtmlBoxMenuItem runat="server" Act="InsertRowBelow">
                                                </ighedit:HtmlBoxMenuItem>
                                                <ighedit:HtmlBoxMenuItem runat="server" Act="DeleteRow">
                                                </ighedit:HtmlBoxMenuItem>
                                                <ighedit:HtmlBoxMenuItem runat="server" Act="DeleteColumn">
                                                </ighedit:HtmlBoxMenuItem>
                                                <ighedit:HtmlBoxMenuItem runat="server" Act="IncreaseColspan">
                                                </ighedit:HtmlBoxMenuItem>
                                                <ighedit:HtmlBoxMenuItem runat="server" Act="DecreaseColspan">
                                                </ighedit:HtmlBoxMenuItem>
                                                <ighedit:HtmlBoxMenuItem runat="server" Act="IncreaseRowspan">
                                                </ighedit:HtmlBoxMenuItem>
                                                <ighedit:HtmlBoxMenuItem runat="server" Act="DecreaseRowspan">
                                                </ighedit:HtmlBoxMenuItem>
                                                <ighedit:HtmlBoxMenuItem runat="server" Act="CellProperties">
                                                    <Dialog InternalDialogType="CellProperties"></Dialog>
                                                </ighedit:HtmlBoxMenuItem>
                                                <ighedit:HtmlBoxMenuItem runat="server" Act="TableProperties">
                                                    <Dialog InternalDialogType="ModifyTable"></Dialog>
                                                </ighedit:HtmlBoxMenuItem>
                                            </Menu>
                                        </ighedit:ToolbarMenuButton>
                                        <ighedit:ToolbarImage runat="server" Type="Separator"></ighedit:ToolbarImage>
                                        <ighedit:ToolbarButton runat="server" Type="InsertLink"></ighedit:ToolbarButton>
                                        <ighedit:ToolbarButton runat="server" Type="RemoveLink"></ighedit:ToolbarButton>
                                        <ighedit:ToolbarImage runat="server" Type="Separator"></ighedit:ToolbarImage>
                                        <ighedit:ToolbarButton runat="server" Type="Save" RaisePostback="True"></ighedit:ToolbarButton>
                                        <ighedit:ToolbarUploadButton runat="server" Type="Open">
                                            <Upload Width="480px" Height="350px" Mode="File" Filter="*.htm,*.html,*.asp,*.aspx"></Upload>
                                        </ighedit:ToolbarUploadButton>
                                        <ighedit:ToolbarButton runat="server" Type="Preview"></ighedit:ToolbarButton>
                                        <ighedit:ToolbarImage runat="server" Type="Separator"></ighedit:ToolbarImage>
                                        <ighedit:ToolbarDialogButton runat="server" Type="FindReplace">
                                            <Dialog InternalDialogType="FindReplace"></Dialog>
                                        </ighedit:ToolbarDialogButton>
                                        <ighedit:ToolbarDialogButton runat="server" Type="InsertBookmark">
                                            <Dialog InternalDialogType="InsertBookmark"></Dialog>
                                        </ighedit:ToolbarDialogButton>
                                        <ighedit:ToolbarUploadButton runat="server" Type="InsertImage">
                                            <Upload Width="480px" Height="420px"></Upload>
                                        </ighedit:ToolbarUploadButton>
                                        <ighedit:ToolbarUploadButton runat="server" Type="InsertFlash">
                                            <Upload Width="480px" Height="440px" Mode="Flash" Filter="*.swf"></Upload>
                                        </ighedit:ToolbarUploadButton>
                                        <ighedit:ToolbarUploadButton runat="server" Type="InsertWindowsMedia">
                                            <Upload Width="480px" Height="400px" Mode="WindowsMedia" Filter="*.asf,*.wma,*.wmv,*.wm,*.avi,*.mpg,*.mpeg,*.m1v,*.mp2,*.mp3,*.mpa,*.mpe,*.mpv2,*.m3u,*.mid,*.midi,*.rmi,*.aif,*.aifc,*.aiff,*.au,*.snd,*.wav,*.cda,*.ivf"></Upload>
                                        </ighedit:ToolbarUploadButton>
                                        <ighedit:ToolbarDialogButton runat="server" Type="Help">
                                            <Dialog InternalDialogType="Text"></Dialog>
                                        </ighedit:ToolbarDialogButton>
                                        <ighedit:ToolbarButton runat="server" Type="CleanWord"></ighedit:ToolbarButton>
                                        <ighedit:ToolbarButton runat="server" Type="WordCount"></ighedit:ToolbarButton>
                                        <ighedit:ToolbarButton runat="server" Type="PasteHtml"></ighedit:ToolbarButton>
                                        <ighedit:ToolbarButton runat="server" Type="TogglePositioning"></ighedit:ToolbarButton>
                                        <ighedit:ToolbarButton runat="server" Type="BringForward"></ighedit:ToolbarButton>
                                        <ighedit:ToolbarButton runat="server" Type="SendBackward"></ighedit:ToolbarButton>
                                        <ighedit:ToolbarImage runat="server" Type="RowSeparator"></ighedit:ToolbarImage>
                                        <ighedit:ToolbarImage runat="server" Type="DoubleSeparator"></ighedit:ToolbarImage>
                                        <ighedit:ToolbarDropDown runat="server" Type="FontName">
                                        </ighedit:ToolbarDropDown>
                                        <ighedit:ToolbarDropDown runat="server" Type="FontSize">
                                        </ighedit:ToolbarDropDown>
                                        <ighedit:ToolbarDropDown runat="server" Type="FontFormatting">
                                        </ighedit:ToolbarDropDown>
                                        <ighedit:ToolbarDropDown runat="server" Type="FontStyle">
                                        </ighedit:ToolbarDropDown>
                                        <ighedit:ToolbarDropDown runat="server" Type="Insert">
                                            <Items>
                                                <ighedit:ToolbarDropDownItem runat="server" Act="Greeting"></ighedit:ToolbarDropDownItem>
                                                <ighedit:ToolbarDropDownItem runat="server" Act="Signature"></ighedit:ToolbarDropDownItem>
                                            </Items>
                                        </ighedit:ToolbarDropDown>
                                    </Toolbar>
                                    <DialogStyle BackColor="#ECE9D8" BorderStyle="Solid" ForeColor="Black" BorderWidth="1px"
                                        BorderColor="Black" Font-Size="8pt" Font-Names="sans-serif"></DialogStyle>
                                    <RightClickMenu>
                                        <ighedit:HtmlBoxMenuItem runat="server" Act="Cut">
                                        </ighedit:HtmlBoxMenuItem>
                                        <ighedit:HtmlBoxMenuItem runat="server" Act="Copy">
                                        </ighedit:HtmlBoxMenuItem>
                                        <ighedit:HtmlBoxMenuItem runat="server" Act="Paste">
                                        </ighedit:HtmlBoxMenuItem>
                                        <ighedit:HtmlBoxMenuItem runat="server" Act="PasteHtml">
                                        </ighedit:HtmlBoxMenuItem>
                                        <ighedit:HtmlBoxMenuItem runat="server" Act="CellProperties">
                                            <Dialog InternalDialogType="CellProperties"></Dialog>
                                        </ighedit:HtmlBoxMenuItem>
                                        <ighedit:HtmlBoxMenuItem runat="server" Act="TableProperties">
                                            <Dialog InternalDialogType="ModifyTable"></Dialog>
                                        </ighedit:HtmlBoxMenuItem>
                                        <ighedit:HtmlBoxMenuItem runat="server" Act="InsertImage">
                                        </ighedit:HtmlBoxMenuItem>
                                    </RightClickMenu>
                                </ighedit:WebHtmlEditor>


                                <br />
                                <dialog internaldialogtype="InsertRule"></dialog>
                                <dialog internaldialogtype="SpecialCharacterPicker" type="InternalWindow"></dialog>
                                <upload filter="*.htm,*.html,*.asp,*.aspx" height="350px" mode="File" width="500px"></upload>
                                <upload filter="*.asf,*.wma,*.wmv,*.wm,*.avi,*.mpg,*.mpeg,*.m1v,*.mp2,*.mp3,*.mpa,*.mpe,*.mpv2,*.m3u,*.mid,*.midi,*.rmi,*.aif,*.aifc,*.aiff,*.au,*.snd,*.wav,*.cda,*.ivf"
                                    height="400px" mode="WindowsMedia" width="500px"></upload>
                                <items></items>
                                <div align="center">
                                    <asp:Button CssClass="btn1" ID="Button1" runat="server" Text="Save" OnClick="Button1_Click" />
                                    <asp:Button ID="Button2" runat="server" Text="Detail Report" Visible="false" />
                                </div>
                                <br />
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                &nbsp;&nbsp;<asp:Button ID="btn_transfer" runat="server" Text="Transfer to Ward"
                                    Visible="False" /><br />
                            </div>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 82px" valign="top" width="32%"></td>
                        <td style="height: 82px" valign="top" width="50%">

                            <asp:Panel Style="left: 38%; top: 50%" ID="Panel2" runat="server" CssClass="lightbox"
                                Width="75%" Visible="False">
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                                <asp:DropDownList ID="DropDownListFloor" runat="server" CssClass="dropbox" Width="250px"
                                    DataValueField="Ward_id" DataTextField="Ward_Name" DataSourceID="SqlDataSourceFloor">
                                </asp:DropDownList>&nbsp;&nbsp;<br />
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;<asp:Button ID="btn_shift" runat="server"
                                    Text="Shift" Width="50px" Visible="False"></asp:Button>
                                <asp:Button ID="btn_cancel" runat="server" Text="cancel" Width="70px"></asp:Button>
                                <asp:Button ID="Button_transfer" runat="server" Text="Transfer" Width="70px"></asp:Button>
                                <br />
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                                <asp:Label ID="Label4" runat="server" ForeColor="#C00000" Font-Bold="True"></asp:Label><br />
                                <br />
                                <asp:GridView ID="GridView_Employee_info" runat="server" DataSourceID="Sql_forGrid"
                                    AutoGenerateColumns="False">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Patient Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_prefix" runat="server" Text='<%# Eval("Prefix") %>'></asp:Label>
                                                <asp:Label ID="lbl_FName" runat="server" Text='<%# Eval("PFName") %>'></asp:Label>
                                                <asp:Label ID="lbl_MName" runat="server" Text='<%# Eval("PMName") %>'></asp:Label>
                                                <asp:Label ID="lbl_LName" runat="server" Text='<%# Eval("PLName") %>'></asp:Label><br />
                                                <asp:HiddenField ID="HF_P_Name" runat="server" Value='<%# Eval("Patient_Name") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Ward_Name" HeaderText="Ward Name" SortExpression="Ward_Name" />
                                        <asp:BoundField DataField="Yearly_No" HeaderText="Yearly No" SortExpression="Yearly_No" />
                                        <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
                                        <asp:BoundField DataField="Age" HeaderText="Age" SortExpression="Age" />
                                        <asp:BoundField DataField="Reg_No" HeaderText="Reg No" SortExpression="Reg_No" Visible="False" />
                                        <asp:BoundField DataField="Admitted_BY" HeaderText="Admitted BY" ReadOnly="True"
                                            SortExpression="Admitted_BY" />
                                        <asp:BoundField DataField="Location" HeaderText="Location" SortExpression="Location" />
                                        <asp:BoundField DataField="Patient_Name" HeaderText="Patient_Name" ReadOnly="True"
                                            SortExpression="Patient_Name" Visible="False" />
                                        <asp:BoundField DataField="datetime" HeaderText="Date time" SortExpression="datetime" />
                                        <asp:BoundField DataField="RegDateTime" HeaderText="Reg DateTime" SortExpression="RegDateTime" />
                                    </Columns>
                                </asp:GridView>
                                <asp:Label ID="Label_row" runat="server" Visible="False"></asp:Label>
                                <asp:SqlDataSource ID="Sql_transfer" runat="server" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                    ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" InsertCommand="insert_Transfer_Pt_Ward"
                                    InsertCommandType="StoredProcedure">
                                    <InsertParameters>
                                        <asp:ControlParameter ControlID="DropDownListFloor" Name="Ward_id" PropertyName="SelectedValue"
                                            Type="Int32" />
                                        <asp:Parameter DefaultValue="0" Name="Bed_id" Type="String" />
                                        <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" Type="String" />
                                        <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" Type="Decimal" />
                                        <asp:Parameter DefaultValue="false" Name="Pt_Status" Type="Boolean" />
                                        <asp:SessionParameter Name="admission_By" SessionField="emp_id" Type="Int32" />
                                    </InsertParameters>
                                </asp:SqlDataSource>
                                <br />
                                <asp:SqlDataSource ID="Sql_forGrid" runat="server" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                    SelectCommand="SELECT admin_Hospital_Wards.Ward_Name, Pt_Assign_Bed.Yearly_No, ISNULL(Employee.Prefix, '') + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') AS Admitted_BY, Ward_Beds.Location, ISNULL(Patient.PFName, '') AS Patient_Name, Pt_Assign_Bed.datetime, Patient.Age, Patient.RegDateTime, Gender.Gender, Pt_Assign_Bed.Reg_No, Patient.Prefix, Patient.PFName, Patient.PMName, Patient.PLName FROM Patient INNER JOIN Pt_Assign_Bed ON Patient.RegNo = Pt_Assign_Bed.Reg_No INNER JOIN Gender ON Patient.SexID = Gender.Gender_ID LEFT OUTER JOIN admin_Hospital_Wards ON Pt_Assign_Bed.Ward_id = admin_Hospital_Wards.Ward_id LEFT OUTER JOIN Employee ON Pt_Assign_Bed.admission_By = Employee.EmpID LEFT OUTER JOIN Ward_Beds ON Pt_Assign_Bed.Bed_id = Ward_Beds.Bed_id WHERE (Pt_Assign_Bed.Reg_No = @Reg_No)"
                                    ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSourceFloor" runat="server" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                    SelectCommand="SELECT DISTINCT admin_Hospital_Wards.Ward_Name, admin_Hospital_Wards.Ward_id, SubDepartment.SubDept_Id FROM SubDepartment INNER JOIN admin_Hospital_Wards ON SubDepartment.SubDept_Id = admin_Hospital_Wards.SubDept_Id WHERE (admin_Hospital_Wards.isDeleted = 0)"
                                    ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="SubDept_Id" SessionField="SubDeptID" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </asp:Panel>

                        </td>
                    </tr>
                </table>
                <br />
                <br />
                <asp:SqlDataSource ID="SqlDataSourceDiagnosis" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                    SelectCommand="pt_get_diagnosis" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="COD" SessionField="YearlyNo" Type="String" />
                        <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenField_description" runat="server" />
                <asp:SqlDataSource ID="SqlDataSource_Insert_Plan" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                    InsertCommand="INSERT INTO pt_Treatment_Plan(Reg_No, Yearly_No, Plan_Detail, emp_id) VALUES (@RegNo, @YearlyNo, @Plan , @empid)"
                    ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>" />
                <asp:SqlDataSource ID="SqlDataSource_pt_Treatment_Plan" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                    SelectCommand="Physician_Notes" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="Reg_no" SessionField="RegistrationNo" Type="String" />
                        <asp:SessionParameter Name="Yearly_no" SessionField="YearlyNo" Type="Decimal" />
                        <asp:SessionParameter Name="Dept_ID" SessionField="dept_id" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
    

    <script type="text/javascript">
<!--
    var CollapsiblePanel1 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel1", { contentIsOpen: true });
    //-->
    </script>

</asp:Content>
