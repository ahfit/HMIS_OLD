<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage.master" inherits="Pt_EMR_Pt_Plan, App_Web_tip0c1yj" validaterequest="false" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebHtmlEditor.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebHtmlEditor" TagPrefix="ighedit" %>




 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">



 
 
 
<script type="text/javascript">
function picture()
{
window.open("mlc_mainpic.aspx?reg={0}&yno={1}");
}
</script>
<script src="../css_hacims/ck.js" type="text/javascript"></script>

 <script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript"></script>
 

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" class="leftnav"><asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
    <asp:Panel ID="Panel1" runat="server"
       Visible="False">
    </asp:Panel></td>
    <td style="width:auto;" valign="top" >
    
   <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" style="width: 2%"></td>
 
 
 
 
 
    <td width="75%" valign="top">
<div style="margin-left:10px;">

  <dialog internaldialogtype="InsertRule"></dialog>
                                <dialog backcolor="#ECE9D8" bordercolor="Black" borderstyle="Solid" borderwidth="1px"
                                    font-names="sans-serif" font-size="8pt" forecolor="Black"></dialog>
    &nbsp;<br />
                                <dialog internaldialogtype="InsertRule"></dialog>
                                <dialog internaldialogtype="SpecialCharacterPicker" type="InternalWindow"></dialog>
                                <upload filter="*.htm,*.html,*.asp,*.aspx" height="350px" mode="File" width="500px"></upload>
                                <upload filter="*.asf,*.wma,*.wmv,*.wm,*.avi,*.mpg,*.mpeg,*.m1v,*.mp2,*.mp3,*.mpa,*.mpe,*.mpv2,*.m3u,*.mid,*.midi,*.rmi,*.aif,*.aifc,*.aiff,*.au,*.snd,*.wav,*.cda,*.ivf"
                                    height="400px" mode="WindowsMedia" width="500px"></upload>
                                <items></items>
  
<div align="center">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
<td style="width: 92px; height: 39px">
    Refer Date</td>
      <td style="width: 197px; height: 39px">
          <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox></td>
      <td style="height: 39px">
          Hospital Name/Clinic/Lab</td>
<td style="height: 39px">
    <asp:TextBox ID="TextBox_HospitalName" runat="server" MaxLength="50" Width="289px"></asp:TextBox></td>
    </tr>
    <tr>
        <td style="width: 92px; height: 39px">
            Purpose</td>
        <td style="width: 197px; height: 39px">
            <asp:DropDownList ID="DropDownList1" runat="server">
                <asp:ListItem>Opinion Only</asp:ListItem>
                <asp:ListItem>Investigation</asp:ListItem>
            </asp:DropDownList></td>
        <td style="height: 39px">
            Doctor Name</td>
        <td style="height: 39px">
            <asp:TextBox ID="TextBox3" runat="server" MaxLength="50"></asp:TextBox></td>
    </tr>
    <tr>
        <td style="width: 92px; height: 39px">
            Diagnosis</td>
        <td colspan="2" style="height: 39px">
            <asp:CheckBoxList ID="CheckBoxList_Diagnosis" runat="server" AutoPostBack="True"
                DataSourceID="SqlDataSource_CurrentDiagnosis" DataTextField="DiseaseName" DataValueField="Diagnosis_ID"
                RepeatDirection="Horizontal">
            </asp:CheckBoxList>
            <asp:TextBox ID="TextBox_admision_Diagnosis" runat="server" Enabled="False" MaxLength="500"
                Width="265px"></asp:TextBox></td>
        <td style="height: 39px">
            <asp:SqlDataSource ID="SqlDataSource_CurrentDiagnosis" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                SelectCommand="SELECT DISTINCT  ISNULL(DiseaseName, '') AS DiseaseName,  Diagnosis_ID,ISNULL(dsCode, '') AS [ICD10 Code]&#13;&#10;FROM         pt_Diagnosis&#13;&#10;WHERE (pt_Diagnosis.YearlyNo = @yearlyNo) AND (pt_Diagnosis.RegNo = @regno)">
                <SelectParameters>
                    <asp:SessionParameter Name="yearlyNo" SessionField="yearlyno" />
                    <asp:SessionParameter Name="regno" SessionField="registrationno" />
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td style="width: 92px; height: 39px">
            Investigations</td>
        <td colspan="3" style="height: 39px">
            <asp:SqlDataSource ID="SqlDataSourceTest" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                SelectCommand="SELECT DISTINCT CONVERT (varchar, Investigation_Order_Main.Date_Time, 103) + ' ' + CONVERT (varchar, Investigation_Order_Main.Date_Time, 108) AS TestAssignDate, TestGroup.TGName, Test_Booking.TB_Name, ISNULL(Path_Result_Delivery.Main_ID, '') AS Main_ID, TestGroup.TGID, Test_Type.Test_Type, Test_Status.Status, Path_Result_Delivery.Reg_no, Path_Result_Delivery.Yearly_No, Investigation_Order_Sub.TB_ID FROM Test_Status INNER JOIN Investigation_Order_Sub INNER JOIN Investigation_Order_Main ON Investigation_Order_Sub.Investigation_Order_ID = Investigation_Order_Main.Investigation_Order_ID INNER JOIN Test_Booking INNER JOIN TestGroup ON Test_Booking.MG_ID = TestGroup.TGID ON Investigation_Order_Sub.TB_ID = Test_Booking.TB_ID ON Test_Status.Status_ID = Investigation_Order_Main.Status LEFT OUTER JOIN Test_Type ON Investigation_Order_Sub.TestType_ID = Test_Type.Test_Type_ID LEFT OUTER JOIN Path_Test_Booking_Services INNER JOIN Path_Result_Delivery ON Path_Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID ON Investigation_Order_Main.YearlyNo = Path_Result_Delivery.Yearly_No AND Investigation_Order_Main.RegNo = Path_Result_Delivery.Reg_no AND Investigation_Order_Main.Investigation_Order_ID = Path_Result_Delivery.HospitalOrderNo WHERE (Investigation_Order_Main.YearlyNo = @PayID) AND (Investigation_Order_Main.RegNo = @RegNo)">
                <SelectParameters>
                    <asp:SessionParameter Name="PayID" SessionField="YearlyNo" Type="Int32" />
                    <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Main_ID"
                DataSourceID="SqlDataSourceTest" Visible="False" Width="100%">
                <RowStyle CssClass="GridItem" />
                <Columns>
                    <asp:BoundField DataField="TestAssignDate" HeaderText="Advise Date" ReadOnly="True"
                        SortExpression="TestAssignDate" />
                    <asp:BoundField DataField="TGName" HeaderText="Group" SortExpression="TGName" />
                    <asp:BoundField DataField="TB_Name" HeaderText="Test" SortExpression="TB_Name" />
                    <asp:BoundField DataField="Main_ID" HeaderText="Main ID" InsertVisible="False" ReadOnly="True"
                        SortExpression="Main_ID" />
                    <asp:BoundField DataField="TGID" HeaderText="TGID" InsertVisible="False" ReadOnly="True"
                        SortExpression="TGID" />
                    <asp:BoundField DataField="Test_Type" HeaderText="Test Type" SortExpression="Test_Type" />
                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                    <asp:HyperLinkField DataNavigateUrlFields="Reg_no,Yearly_No,TGID,Main_ID" DataNavigateUrlFormatString="~/Pathology/Patient_Result_Report.aspx?RegNo={0}&amp;YearlyNo={1}&amp;TGID={2}&amp;Main_ID={3}"
                        HeaderText="Report" Text="Report">
                        <ControlStyle CssClass="openlink" />
                    </asp:HyperLinkField>
                </Columns>
                <HeaderStyle CssClass="GridHeader" />
                <AlternatingRowStyle CssClass="GridAltItem" />
            </asp:GridView>
        </td>
    </tr>
  
</table>
<asp:Button CssClass="btn1" ID="Button1" runat="server" Text="Save"  />
    <asp:Button ID="Button2" runat="server" Text="Detail Report" /></div>
<br />

</div>

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
                                <ighedit:webhtmleditor id="WebHtmlEditor1" Width="99%" Height="193px" runat="server" uploadedfilesdirectory="HtmlEditor" ImageDirectory="htmleditor/">
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
</ighedit:webhtmleditor>
                          <asp:HiddenField ID="HiddenField_description" runat="server" />
                          <asp:SqlDataSource ID="SqlDataSource_Insert_Plan" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>" InsertCommand="INSERT INTO pt_Treatment_Plan(Reg_No, Yearly_No, Plan_Detail, emp_id) VALUES (@RegNo, @YearlyNo, @Plan , @empid)" ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>" />
       
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





 
    <asp:Label ID="LabelFooter" runat="server" Text=""></asp:Label>
    
    
     </asp:Content>
 