<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Biopsy_Entry.aspx.vb"  MasterPageFile="~/hacims_masterpage.master" Inherits="Biopsy_Entry"  EnableEventValidation="false"%>

<%@ Register Assembly="Infragistics2.WebUI.WebHtmlEditor.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebHtmlEditor" TagPrefix="ighedit" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



 

<asp:GridView ID="GridView_Test_Status" runat="server" AutoGenerateColumns="False"
                CssClass="Grid_1" DataKeyNames="TGID" DataSourceID="SqlDataSource_Status" Width="100%">
                <Columns>
                    <asp:BoundField DataField="TB_Name" HeaderText="Test" ReadOnly="True" SortExpression="TB_Name" />
                    <asp:TemplateField HeaderText="Status" SortExpression="Status">
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownList_Status" runat="server" DataSourceID="SqlDataSource_Status_Edit"
                                DataTextField="Status" DataValueField="Status_ID" Width="167px">
                            </asp:DropDownList><br />
                            <asp:SqlDataSource ID="SqlDataSource_Status_Edit" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT Status, Status_ID FROM Test_Status WHERE (Status_ID = 3) OR (Status_ID = 5) OR (Status_ID = 9)">
                            </asp:SqlDataSource>
                            <asp:HiddenField ID="HiddenField_ID" runat="server" Value='<%# Bind("ID", "{0}") %>' />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Status") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowEditButton="True" />
                    <asp:BoundField DataField="Date_Time" HeaderText="Date Time" ReadOnly="True" SortExpression="Date_Time" />
                    <asp:TemplateField ShowHeader="False" HeaderText="Test Group Name">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" CommandName="Select"
                                Text='<%# Eval("TGName") %>'></asp:LinkButton><br />
                            <asp:HiddenField ID="HiddenField_TG_ID" runat="server" Value='<%# Eval("TGID", "{0}") %>' />
                            <asp:HiddenField ID="HiddenField7" runat="server" Value='<%# Eval("TGName", "{0}") %>' />
                            <asp:HiddenField ID="HiddenFieldMain_ID" runat="server" Value='<%# Eval("Main_ID", "{0}") %>' />
                            <asp:HiddenField ID="HiddenFieldTBID" runat="server" Value='<%# Bind("TB_ID", "{0}") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="TGName" HeaderText="Test Group Name" ReadOnly="True" SortExpression="TGName" Visible="False" />
                    <asp:BoundField DataField="Sample N0." HeaderText="Sample N0." SortExpression="Sample N0." ReadOnly="True" />
                </Columns>
                <RowStyle CssClass="GridItem" />
                <HeaderStyle CssClass="GridHeader" />
                <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView><br />

<asp:SqlDataSource ID="SqlDataSource_Status" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT Test_Booking.TB_Name, Test_Status.Status, Test_Booking_Services.ID, CONVERT (varchar, Path_Result_Delivery.Sample_Collection_Date, 107) AS Date_Time, TestGroup.TGName, TestGroup.TGID, Test_Main_Sub_Grouping.MS_TGID, Path_Result_Delivery.Main_ID, Test_Booking_Services.TB_ID, Path_Result_Delivery.Sample_No AS [Sample N0.] FROM Test_Booking_Services INNER JOIN Test_Booking ON Test_Booking_Services.TB_ID = Test_Booking.TB_ID INNER JOIN Test_Status ON Test_Booking_Services.Status = Test_Status.Status_ID INNER JOIN TestGroup ON Test_Booking.MG_ID = TestGroup.TGID INNER JOIN Test_Main_Sub_Grouping ON TestGroup.TGID = Test_Main_Sub_Grouping.TGID INNER JOIN Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID WHERE (TestGroup.TGID = 67) AND (Test_Status.Status_ID = @Status) AND (Path_Result_Delivery.Reg_no = @RegNo) AND (Path_Result_Delivery.Yearly_No = @YearlyNo) AND (Path_Result_Delivery.Main_ID = @Main_ID)"
                UpdateCommand="UPDATE Test_Booking_Services SET Status = @Status WHERE (ID = @ID)">
                <UpdateParameters>
                    <asp:ControlParameter ControlID="HiddenField_Edit_Status" Name="Status" PropertyName="Value" />
                    <asp:ControlParameter ControlID="HiddenField_Edit_ID" Name="ID" PropertyName="Value" />
                </UpdateParameters>
                <SelectParameters>
                    <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                    <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                    <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" Type="Int32" />
                    <asp:Parameter DefaultValue="1" Name="Status" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:HiddenField ID="HiddenField_Edit_Status" runat="server" />
            <asp:HiddenField ID="HiddenField_Edit_ID" runat="server" />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form" >

  <tr>
    <td width="17%" align="right" valign="middle">Clinical Data : </td>
    <td width="83%" align="left" ><ighedit:webhtmleditor id="WebHtmlEditor_Specimen" runat="server" ImageDirectory="../ig_images/htmleditor/" Height="120px" Width="95%">
<Toolbar><ighedit:ToolbarImage runat="server" Type="DoubleSeparator"></ighedit:ToolbarImage>
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
<Menu Width="80px"><ighedit:HtmlBoxMenuItem runat="server" Act="TableProperties">
<Dialog InternalDialogType="InsertTable"></Dialog>
</ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="InsertColumnRight"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="InsertColumnLeft"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="InsertRowAbove"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="InsertRowBelow"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="DeleteRow"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="DeleteColumn"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="IncreaseColspan"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="DecreaseColspan"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="IncreaseRowspan"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="DecreaseRowspan"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="CellProperties">
<Dialog InternalDialogType="CellProperties"></Dialog>
</ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="TableProperties">
<Dialog InternalDialogType="ModifyTable"></Dialog>
</ighedit:HtmlBoxMenuItem>
</Menu>
</ighedit:ToolbarMenuButton>
<ighedit:ToolbarButton runat="server" Type="ToggleBorders"></ighedit:ToolbarButton>
<ighedit:ToolbarImage runat="server" Type="Separator"></ighedit:ToolbarImage>
<ighedit:ToolbarButton runat="server" Type="InsertLink"></ighedit:ToolbarButton>
<ighedit:ToolbarButton runat="server" Type="RemoveLink"></ighedit:ToolbarButton>
<ighedit:ToolbarImage runat="server" Type="Separator"></ighedit:ToolbarImage>
<ighedit:ToolbarButton runat="server" Type="Save" RaisePostback="True"></ighedit:ToolbarButton>
<ighedit:ToolbarUploadButton runat="server" Type="Open">
<Upload Width="500px" Height="350px" Mode="File" Filter="*.htm,*.html,*.asp,*.aspx"></Upload>
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
<Upload Width="500px" Height="420px"></Upload>
</ighedit:ToolbarUploadButton>
<ighedit:ToolbarUploadButton runat="server" Type="InsertFlash">
<Upload Width="500px" Height="440px" Mode="Flash" Filter="*.swf"></Upload>
</ighedit:ToolbarUploadButton>
<ighedit:ToolbarUploadButton runat="server" Type="InsertWindowsMedia">
<Upload Width="500px" Height="400px" Mode="WindowsMedia" Filter="*.asf,*.wma,*.wmv,*.wm,*.avi,*.mpg,*.mpeg,*.m1v,*.mp2,*.mp3,*.mpa,*.mpe,*.mpv2,*.m3u,*.mid,*.midi,*.rmi,*.aif,*.aifc,*.aiff,*.au,*.snd,*.wav,*.cda,*.ivf"></Upload>
</ighedit:ToolbarUploadButton>
<ighedit:ToolbarDialogButton runat="server" Type="Help">
<Dialog InternalDialogType="Text"></Dialog>
</ighedit:ToolbarDialogButton>
<ighedit:ToolbarButton runat="server" Type="CleanWord"></ighedit:ToolbarButton>
<ighedit:ToolbarButton runat="server" Type="WordCount"></ighedit:ToolbarButton>
<ighedit:ToolbarButton runat="server" Type="PasteHtml"></ighedit:ToolbarButton>
<ighedit:ToolbarMenuButton runat="server" Type="Zoom">
<Menu Width="180px"><ighedit:HtmlBoxMenuItem runat="server" Act="Zoom25"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom50"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom75"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom100"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom200"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom300"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom400"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom500"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom600"></ighedit:HtmlBoxMenuItem>
</Menu>
</ighedit:ToolbarMenuButton>
<ighedit:ToolbarButton runat="server" Type="TogglePositioning"></ighedit:ToolbarButton>
<ighedit:ToolbarButton runat="server" Type="BringForward"></ighedit:ToolbarButton>
<ighedit:ToolbarButton runat="server" Type="SendBackward"></ighedit:ToolbarButton>
<ighedit:ToolbarImage runat="server" Type="RowSeparator"></ighedit:ToolbarImage>
<ighedit:ToolbarImage runat="server" Type="DoubleSeparator"></ighedit:ToolbarImage>
<ighedit:ToolbarDropDown runat="server" Type="FontName"></ighedit:ToolbarDropDown>
<ighedit:ToolbarDropDown runat="server" Type="FontSize"></ighedit:ToolbarDropDown>
<ighedit:ToolbarDropDown runat="server" Type="FontFormatting"></ighedit:ToolbarDropDown>
<ighedit:ToolbarDropDown runat="server" Type="FontStyle"></ighedit:ToolbarDropDown>
<ighedit:ToolbarDropDown runat="server" Type="Insert"><Items>
<ighedit:ToolbarDropDownItem runat="server" Act="Greeting"></ighedit:ToolbarDropDownItem>
<ighedit:ToolbarDropDownItem runat="server" Act="Signature"></ighedit:ToolbarDropDownItem>
</Items>
</ighedit:ToolbarDropDown>
</Toolbar>

<DialogStyle BackColor="#ECE9D8" BorderStyle="Solid" ForeColor="Black" BorderWidth="1px" BorderColor="Black" Font-Size="8pt" Font-Names="sans-serif"></DialogStyle>

<RightClickMenu><ighedit:HtmlBoxMenuItem runat="server" Act="Cut"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Copy"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Paste"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="PasteHtml"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="CellProperties">
<Dialog InternalDialogType="CellProperties"></Dialog>
</ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="TableProperties">
<Dialog InternalDialogType="ModifyTable"></Dialog>
</ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="InsertImage"></ighedit:HtmlBoxMenuItem>
</RightClickMenu>
</ighedit:webhtmleditor><br />
</td>
  </tr>
  <tr>
    <td align="right"  >Gross Examination : </td>
    <td align="left" ><ighedit:webhtmleditor id="WebHtmlEditor_Gross_Examination" runat="server" ImageDirectory="../ig_images/htmleditor/" Height="120px" Width="95%">
<Toolbar><ighedit:ToolbarImage runat="server" Type="DoubleSeparator"></ighedit:ToolbarImage>
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
<Menu Width="80px"><ighedit:HtmlBoxMenuItem runat="server" Act="TableProperties">
<Dialog InternalDialogType="InsertTable"></Dialog>
</ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="InsertColumnRight"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="InsertColumnLeft"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="InsertRowAbove"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="InsertRowBelow"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="DeleteRow"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="DeleteColumn"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="IncreaseColspan"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="DecreaseColspan"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="IncreaseRowspan"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="DecreaseRowspan"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="CellProperties">
<Dialog InternalDialogType="CellProperties"></Dialog>
</ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="TableProperties">
<Dialog InternalDialogType="ModifyTable"></Dialog>
</ighedit:HtmlBoxMenuItem>
</Menu>
</ighedit:ToolbarMenuButton>
<ighedit:ToolbarButton runat="server" Type="ToggleBorders"></ighedit:ToolbarButton>
<ighedit:ToolbarImage runat="server" Type="Separator"></ighedit:ToolbarImage>
<ighedit:ToolbarButton runat="server" Type="InsertLink"></ighedit:ToolbarButton>
<ighedit:ToolbarButton runat="server" Type="RemoveLink"></ighedit:ToolbarButton>
<ighedit:ToolbarImage runat="server" Type="Separator"></ighedit:ToolbarImage>
<ighedit:ToolbarButton runat="server" Type="Save" RaisePostback="True"></ighedit:ToolbarButton>
<ighedit:ToolbarUploadButton runat="server" Type="Open">
<Upload Width="500px" Height="350px" Mode="File" Filter="*.htm,*.html,*.asp,*.aspx"></Upload>
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
<Upload Width="500px" Height="420px"></Upload>
</ighedit:ToolbarUploadButton>
<ighedit:ToolbarUploadButton runat="server" Type="InsertFlash">
<Upload Width="500px" Height="440px" Mode="Flash" Filter="*.swf"></Upload>
</ighedit:ToolbarUploadButton>
<ighedit:ToolbarUploadButton runat="server" Type="InsertWindowsMedia">
<Upload Width="500px" Height="400px" Mode="WindowsMedia" Filter="*.asf,*.wma,*.wmv,*.wm,*.avi,*.mpg,*.mpeg,*.m1v,*.mp2,*.mp3,*.mpa,*.mpe,*.mpv2,*.m3u,*.mid,*.midi,*.rmi,*.aif,*.aifc,*.aiff,*.au,*.snd,*.wav,*.cda,*.ivf"></Upload>
</ighedit:ToolbarUploadButton>
<ighedit:ToolbarDialogButton runat="server" Type="Help">
<Dialog InternalDialogType="Text"></Dialog>
</ighedit:ToolbarDialogButton>
<ighedit:ToolbarButton runat="server" Type="CleanWord"></ighedit:ToolbarButton>
<ighedit:ToolbarButton runat="server" Type="WordCount"></ighedit:ToolbarButton>
<ighedit:ToolbarButton runat="server" Type="PasteHtml"></ighedit:ToolbarButton>
<ighedit:ToolbarMenuButton runat="server" Type="Zoom">
<Menu Width="180px"><ighedit:HtmlBoxMenuItem runat="server" Act="Zoom25"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom50"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom75"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom100"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom200"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom300"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom400"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom500"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom600"></ighedit:HtmlBoxMenuItem>
</Menu>
</ighedit:ToolbarMenuButton>
<ighedit:ToolbarButton runat="server" Type="TogglePositioning"></ighedit:ToolbarButton>
<ighedit:ToolbarButton runat="server" Type="BringForward"></ighedit:ToolbarButton>
<ighedit:ToolbarButton runat="server" Type="SendBackward"></ighedit:ToolbarButton>
<ighedit:ToolbarImage runat="server" Type="RowSeparator"></ighedit:ToolbarImage>
<ighedit:ToolbarImage runat="server" Type="DoubleSeparator"></ighedit:ToolbarImage>
<ighedit:ToolbarDropDown runat="server" Type="FontName"></ighedit:ToolbarDropDown>
<ighedit:ToolbarDropDown runat="server" Type="FontSize"></ighedit:ToolbarDropDown>
<ighedit:ToolbarDropDown runat="server" Type="FontFormatting"></ighedit:ToolbarDropDown>
<ighedit:ToolbarDropDown runat="server" Type="FontStyle"></ighedit:ToolbarDropDown>
<ighedit:ToolbarDropDown runat="server" Type="Insert"><Items>
<ighedit:ToolbarDropDownItem runat="server" Act="Greeting"></ighedit:ToolbarDropDownItem>
<ighedit:ToolbarDropDownItem runat="server" Act="Signature"></ighedit:ToolbarDropDownItem>
</Items>
</ighedit:ToolbarDropDown>
</Toolbar>

<DialogStyle BackColor="#ECE9D8" BorderStyle="Solid" ForeColor="Black" BorderWidth="1px" BorderColor="Black" Font-Size="8pt" Font-Names="sans-serif"></DialogStyle>

<RightClickMenu><ighedit:HtmlBoxMenuItem runat="server" Act="Cut"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Copy"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Paste"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="PasteHtml"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="CellProperties">
<Dialog InternalDialogType="CellProperties"></Dialog>
</ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="TableProperties">
<Dialog InternalDialogType="ModifyTable"></Dialog>
</ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="InsertImage"></ighedit:HtmlBoxMenuItem>
</RightClickMenu>
</ighedit:webhtmleditor><br />
</td>
  </tr>
  <tr>
    <td align="right"  >Microscopic Examination :&nbsp;</td>
    <td align="left" ><ighedit:webhtmleditor id="WebHtmlEditor_Micro_Exam" runat="server" ImageDirectory="../ig_images/htmleditor/" Height="120px" Width="95%">
<Toolbar><ighedit:ToolbarImage runat="server" Type="DoubleSeparator"></ighedit:ToolbarImage>
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
<Menu Width="80px"><ighedit:HtmlBoxMenuItem runat="server" Act="TableProperties">
<Dialog InternalDialogType="InsertTable"></Dialog>
</ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="InsertColumnRight"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="InsertColumnLeft"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="InsertRowAbove"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="InsertRowBelow"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="DeleteRow"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="DeleteColumn"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="IncreaseColspan"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="DecreaseColspan"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="IncreaseRowspan"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="DecreaseRowspan"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="CellProperties">
<Dialog InternalDialogType="CellProperties"></Dialog>
</ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="TableProperties">
<Dialog InternalDialogType="ModifyTable"></Dialog>
</ighedit:HtmlBoxMenuItem>
</Menu>
</ighedit:ToolbarMenuButton>
<ighedit:ToolbarButton runat="server" Type="ToggleBorders"></ighedit:ToolbarButton>
<ighedit:ToolbarImage runat="server" Type="Separator"></ighedit:ToolbarImage>
<ighedit:ToolbarButton runat="server" Type="InsertLink"></ighedit:ToolbarButton>
<ighedit:ToolbarButton runat="server" Type="RemoveLink"></ighedit:ToolbarButton>
<ighedit:ToolbarImage runat="server" Type="Separator"></ighedit:ToolbarImage>
<ighedit:ToolbarButton runat="server" Type="Save" RaisePostback="True"></ighedit:ToolbarButton>
<ighedit:ToolbarUploadButton runat="server" Type="Open">
<Upload Width="500px" Height="350px" Mode="File" Filter="*.htm,*.html,*.asp,*.aspx"></Upload>
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
<Upload Width="500px" Height="420px"></Upload>
</ighedit:ToolbarUploadButton>
<ighedit:ToolbarUploadButton runat="server" Type="InsertFlash">
<Upload Width="500px" Height="440px" Mode="Flash" Filter="*.swf"></Upload>
</ighedit:ToolbarUploadButton>
<ighedit:ToolbarUploadButton runat="server" Type="InsertWindowsMedia">
<Upload Width="500px" Height="400px" Mode="WindowsMedia" Filter="*.asf,*.wma,*.wmv,*.wm,*.avi,*.mpg,*.mpeg,*.m1v,*.mp2,*.mp3,*.mpa,*.mpe,*.mpv2,*.m3u,*.mid,*.midi,*.rmi,*.aif,*.aifc,*.aiff,*.au,*.snd,*.wav,*.cda,*.ivf"></Upload>
</ighedit:ToolbarUploadButton>
<ighedit:ToolbarDialogButton runat="server" Type="Help">
<Dialog InternalDialogType="Text"></Dialog>
</ighedit:ToolbarDialogButton>
<ighedit:ToolbarButton runat="server" Type="CleanWord"></ighedit:ToolbarButton>
<ighedit:ToolbarButton runat="server" Type="WordCount"></ighedit:ToolbarButton>
<ighedit:ToolbarButton runat="server" Type="PasteHtml"></ighedit:ToolbarButton>
<ighedit:ToolbarMenuButton runat="server" Type="Zoom">
<Menu Width="180px"><ighedit:HtmlBoxMenuItem runat="server" Act="Zoom25"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom50"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom75"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom100"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom200"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom300"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom400"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom500"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom600"></ighedit:HtmlBoxMenuItem>
</Menu>
</ighedit:ToolbarMenuButton>
<ighedit:ToolbarButton runat="server" Type="TogglePositioning"></ighedit:ToolbarButton>
<ighedit:ToolbarButton runat="server" Type="BringForward"></ighedit:ToolbarButton>
<ighedit:ToolbarButton runat="server" Type="SendBackward"></ighedit:ToolbarButton>
<ighedit:ToolbarImage runat="server" Type="RowSeparator"></ighedit:ToolbarImage>
<ighedit:ToolbarImage runat="server" Type="DoubleSeparator"></ighedit:ToolbarImage>
<ighedit:ToolbarDropDown runat="server" Type="FontName"></ighedit:ToolbarDropDown>
<ighedit:ToolbarDropDown runat="server" Type="FontSize"></ighedit:ToolbarDropDown>
<ighedit:ToolbarDropDown runat="server" Type="FontFormatting"></ighedit:ToolbarDropDown>
<ighedit:ToolbarDropDown runat="server" Type="FontStyle"></ighedit:ToolbarDropDown>
<ighedit:ToolbarDropDown runat="server" Type="Insert"><Items>
<ighedit:ToolbarDropDownItem runat="server" Act="Greeting"></ighedit:ToolbarDropDownItem>
<ighedit:ToolbarDropDownItem runat="server" Act="Signature"></ighedit:ToolbarDropDownItem>
</Items>
</ighedit:ToolbarDropDown>
</Toolbar>

<DialogStyle BackColor="#ECE9D8" BorderStyle="Solid" ForeColor="Black" BorderWidth="1px" BorderColor="Black" Font-Size="8pt" Font-Names="sans-serif"></DialogStyle>

<RightClickMenu><ighedit:HtmlBoxMenuItem runat="server" Act="Cut"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Copy"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Paste"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="PasteHtml"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="CellProperties">
<Dialog InternalDialogType="CellProperties"></Dialog>
</ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="TableProperties">
<Dialog InternalDialogType="ModifyTable"></Dialog>
</ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="InsertImage"></ighedit:HtmlBoxMenuItem>
</RightClickMenu>
</ighedit:webhtmleditor><br />
</td>
  </tr>
  <tr>
    <td align="right"  >Diagnosis :&nbsp;</td>
    <td align="left" ><ighedit:webhtmleditor id="WebHtmlEditor_Diagnosis" runat="server" ImageDirectory="../ig_images/htmleditor/" Height="120px" Width="95%">
<Toolbar><ighedit:ToolbarImage runat="server" Type="DoubleSeparator"></ighedit:ToolbarImage>
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
<Menu Width="80px"><ighedit:HtmlBoxMenuItem runat="server" Act="TableProperties">
<Dialog InternalDialogType="InsertTable"></Dialog>
</ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="InsertColumnRight"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="InsertColumnLeft"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="InsertRowAbove"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="InsertRowBelow"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="DeleteRow"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="DeleteColumn"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="IncreaseColspan"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="DecreaseColspan"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="IncreaseRowspan"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="DecreaseRowspan"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="CellProperties">
<Dialog InternalDialogType="CellProperties"></Dialog>
</ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="TableProperties">
<Dialog InternalDialogType="ModifyTable"></Dialog>
</ighedit:HtmlBoxMenuItem>
</Menu>
</ighedit:ToolbarMenuButton>
<ighedit:ToolbarButton runat="server" Type="ToggleBorders"></ighedit:ToolbarButton>
<ighedit:ToolbarImage runat="server" Type="Separator"></ighedit:ToolbarImage>
<ighedit:ToolbarButton runat="server" Type="InsertLink"></ighedit:ToolbarButton>
<ighedit:ToolbarButton runat="server" Type="RemoveLink"></ighedit:ToolbarButton>
<ighedit:ToolbarImage runat="server" Type="Separator"></ighedit:ToolbarImage>
<ighedit:ToolbarButton runat="server" Type="Save" RaisePostback="True"></ighedit:ToolbarButton>
<ighedit:ToolbarUploadButton runat="server" Type="Open">
<Upload Width="500px" Height="350px" Mode="File" Filter="*.htm,*.html,*.asp,*.aspx"></Upload>
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
<Upload Width="500px" Height="420px"></Upload>
</ighedit:ToolbarUploadButton>
<ighedit:ToolbarUploadButton runat="server" Type="InsertFlash">
<Upload Width="500px" Height="440px" Mode="Flash" Filter="*.swf"></Upload>
</ighedit:ToolbarUploadButton>
<ighedit:ToolbarUploadButton runat="server" Type="InsertWindowsMedia">
<Upload Width="500px" Height="400px" Mode="WindowsMedia" Filter="*.asf,*.wma,*.wmv,*.wm,*.avi,*.mpg,*.mpeg,*.m1v,*.mp2,*.mp3,*.mpa,*.mpe,*.mpv2,*.m3u,*.mid,*.midi,*.rmi,*.aif,*.aifc,*.aiff,*.au,*.snd,*.wav,*.cda,*.ivf"></Upload>
</ighedit:ToolbarUploadButton>
<ighedit:ToolbarDialogButton runat="server" Type="Help">
<Dialog InternalDialogType="Text"></Dialog>
</ighedit:ToolbarDialogButton>
<ighedit:ToolbarButton runat="server" Type="CleanWord"></ighedit:ToolbarButton>
<ighedit:ToolbarButton runat="server" Type="WordCount"></ighedit:ToolbarButton>
<ighedit:ToolbarButton runat="server" Type="PasteHtml"></ighedit:ToolbarButton>
<ighedit:ToolbarMenuButton runat="server" Type="Zoom">
<Menu Width="180px"><ighedit:HtmlBoxMenuItem runat="server" Act="Zoom25"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom50"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom75"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom100"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom200"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom300"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom400"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom500"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Zoom600"></ighedit:HtmlBoxMenuItem>
</Menu>
</ighedit:ToolbarMenuButton>
<ighedit:ToolbarButton runat="server" Type="TogglePositioning"></ighedit:ToolbarButton>
<ighedit:ToolbarButton runat="server" Type="BringForward"></ighedit:ToolbarButton>
<ighedit:ToolbarButton runat="server" Type="SendBackward"></ighedit:ToolbarButton>
<ighedit:ToolbarImage runat="server" Type="RowSeparator"></ighedit:ToolbarImage>
<ighedit:ToolbarImage runat="server" Type="DoubleSeparator"></ighedit:ToolbarImage>
<ighedit:ToolbarDropDown runat="server" Type="FontName"></ighedit:ToolbarDropDown>
<ighedit:ToolbarDropDown runat="server" Type="FontSize"></ighedit:ToolbarDropDown>
<ighedit:ToolbarDropDown runat="server" Type="FontFormatting"></ighedit:ToolbarDropDown>
<ighedit:ToolbarDropDown runat="server" Type="FontStyle"></ighedit:ToolbarDropDown>
<ighedit:ToolbarDropDown runat="server" Type="Insert"><Items>
<ighedit:ToolbarDropDownItem runat="server" Act="Greeting"></ighedit:ToolbarDropDownItem>
<ighedit:ToolbarDropDownItem runat="server" Act="Signature"></ighedit:ToolbarDropDownItem>
</Items>
</ighedit:ToolbarDropDown>
</Toolbar>

<DialogStyle BackColor="#ECE9D8" BorderStyle="Solid" ForeColor="Black" BorderWidth="1px" BorderColor="Black" Font-Size="8pt" Font-Names="sans-serif"></DialogStyle>

<RightClickMenu><ighedit:HtmlBoxMenuItem runat="server" Act="Cut"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Copy"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="Paste"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="PasteHtml"></ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="CellProperties">
<Dialog InternalDialogType="CellProperties"></Dialog>
</ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="TableProperties">
<Dialog InternalDialogType="ModifyTable"></Dialog>
</ighedit:HtmlBoxMenuItem>
<ighedit:HtmlBoxMenuItem runat="server" Act="InsertImage"></ighedit:HtmlBoxMenuItem>
</RightClickMenu>
</ighedit:webhtmleditor><br />
</td>
  </tr>
 
</table>
<br />

<div align="center">
<asp:Button CssClass="btn1" ID="Button1" runat="server" Text="Save " /> &nbsp;<asp:Button CssClass="btn1" ID="Button_Final" runat="server" Text="Final" /></div>

    <asp:HiddenField ID="HiddenField_TGID" runat="server" />
    <asp:HiddenField ID="HiddenFieldMainID" runat="server" />
    <asp:HiddenField ID="HiddenFieldTRMID" runat="server" />
    <asp:HiddenField ID="HiddenField_TB_ID" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Update_Status" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" UpdateCommand="Update_Patient_Test_Status"
        UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter DefaultValue="6" Name="Status" />
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
            <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
            <asp:ControlParameter ControlID="HiddenField_TB_ID" Name="TB_ID" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="HiddenFieldMainID" Name="Main_ID" PropertyName="Value"
                Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
              <br />
  
                
<asp:SqlDataSource ID="SqlDataSource_MainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT     distinct TestSubGroup.TSGName, TestSubGroup.TSGID
FROM         PatientsLabTest INNER JOIN
                      Test ON PatientsLabTest.TID = Test.TID INNER JOIN
                      TestSubGroup ON Test.TGID = TestSubGroup.TGID AND Test.TSGID = TestSubGroup.TSGID
WHERE     (PatientsLabTest.RegNo = @RegNO) AND (PatientsLabTest.PayID = @PayID)">
                <SelectParameters>
                  <asp:QueryStringParameter Name="RegNO" QueryStringField="RegNo" />
                  <asp:QueryStringParameter Name="PayID" QueryStringField="YearlyNo" />
                </SelectParameters>
              </asp:SqlDataSource>
              <asp:SqlDataSource ID="SqlDataSource_Test" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT     PatientsLabTest.TID, isnull(Test.TestName,' ') + '  (' + isnull(PatientsLabTest.Biopsy_description,' ') + ' )' as TestName&#13;&#10;FROM         PatientsLabTest INNER JOIN&#13;&#10;                      Test ON PatientsLabTest.TID = Test.TID&#13;&#10;WHERE      (TGID = 67) AND  (PatientsLabTest.RegNo = @RegNO) AND (PatientsLabTest.PayID = @PayID) ">
                <SelectParameters>
                  <asp:QueryStringParameter Name="RegNO" QueryStringField="RegNo" />
                  <asp:QueryStringParameter Name="PayID" QueryStringField="YearlyNo" />
                </SelectParameters>
              </asp:SqlDataSource>
              <asp:HiddenField ID="HiddenField_Gross_Exam" runat="server" />
              <asp:HiddenField ID="HiddenField_Microscopic_Exam" runat="server" />
              <asp:HiddenField ID="HiddenField_Sepecimen" runat="server" />
              <asp:HiddenField ID="HiddenField_Diagnosis" runat="server" />
              <asp:SqlDataSource ID="SqlDataSource_Save_Value" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" InsertCommand="Pt_Insert_Biopsy_SaveRecord" InsertCommandType="StoredProcedure">
                <InsertParameters>
                    <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" Type="String" />
                    <asp:SessionParameter Name="Yearly_no" SessionField="YearlyNo" Type="Decimal" />
                    <asp:ControlParameter ControlID="HiddenField_TB_ID" Name="TID" PropertyName="Value"
                        Type="Int32" />
                    <asp:ControlParameter ControlID="HiddenField_Sepecimen" Name="Specimen" PropertyName="Value"
                        Type="String" />
                    <asp:ControlParameter ControlID="HiddenField_Gross_Exam" Name="Gross_Exam" PropertyName="Value"
                        Type="String" />
                    <asp:ControlParameter ControlID="HiddenField_Microscopic_Exam" Name="Micro_Exam"
                        PropertyName="Value" Type="String" />
                    <asp:ControlParameter ControlID="HiddenField_Diagnosis" Name="Diagnosis" PropertyName="Value"
                        Type="String" />
                    <asp:ControlParameter ControlID="HiddenFieldTRMID" Name="trmid" PropertyName="Value"
                        Type="Int32" />
                </InsertParameters>
              </asp:SqlDataSource>
   
    <asp:SqlDataSource ID="SqlDataSource_UpdateStatus" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" UpdateCommand="UPDATE Forward_To_Sub_Dept SET status = @status WHERE (Reg_No = @Reg_No) AND (yearly_no = @yearly_no) AND (to_sub_Dept = @to_sub_Dept)">
        <UpdateParameters>
            <asp:Parameter DefaultValue="1" Name="status" />
            <asp:SessionParameter DefaultValue="" Name="Reg_No" SessionField="registrationNo" />
            <asp:SessionParameter Name="yearly_no" SessionField="YearlyNo" />
            <asp:Parameter DefaultValue="13" Name="to_sub_Dept" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceUpdate" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" UpdateCommand="UPDATE PatientsLabTest SET Status = @Status WHERE (RegNo = @RegNo) AND (PayID = @PayID) AND (TID = @TID)">
        <UpdateParameters>
            <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
            <asp:Parameter DefaultValue="6" Name="Status" />
            <asp:SessionParameter DefaultValue="" Name="PayID" SessionField="YearlyNo" />
            <asp:ControlParameter ControlID="HiddenField_TB_ID" DefaultValue="" Name="TID" PropertyName="Value" />
        </UpdateParameters>
    </asp:SqlDataSource>
<br />
<br />

  </asp:Content>