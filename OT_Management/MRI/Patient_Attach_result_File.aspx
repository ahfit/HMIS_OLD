<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Patient_Attach_result_File.aspx.vb" Inherits="Patient_Attach_result_File" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="Infragistics2.WebUI.WebHtmlEditor.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebHtmlEditor" TagPrefix="ighedit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
</head>

<body>
<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_top.gif" width="1003" height="24" alt=""/></td>
  </tr>
  <tr>
    <td width="23" height="617" valign="top" class="left_border"><img src="images1/img_border_left.gif" width="23" height="15" alt=""/></td>
    <td width="957" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
        <td height="97" colspan="2" valign="top"><iframe 
      src="tabs.aspx" name="holder" width="957" marginwidth="0" height="157" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
          </tr>
      
      
      <tr>
        <td width="19" height="25" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="938" valign="middle" class="text_lables3">
                Add Result
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                </td>
          </tr>
      <tr>
        <td height="435" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="mainframe_bg1">
          <!--DWLayoutTable-->
          <tr>
            <td rowspan="6" valign="top" style="width: 20px"><img src="images1/img_spacer.gif" width="20" height="2" alt=""/></td>
                  <td height="10" colspan="2" valign="top"><img src="images1/img_spacer2.gif" width="2" height="10" alt=""/></td>
                  <td width="20" rowspan="6" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" alt=""/></td>
                </tr>
          <tr>
            <td colspan="2" valign="top" style="height: 95px"><table width="917" class="table1" border="0" cellpadding="0" cellspacing="0" style="height: 66px">
              <tr>
                <th width="133" align="right"  style="height: 32px" >Name :&nbsp; </th>
                    <th width="307" align="left" scope="col" style="height: 32px"><span class="myborder3" style="width: 373px">
                      &nbsp;
                      <asp:Label ID="labelPName" runat="server" CssClass="text_nameheading" Width="350px"></asp:Label>
                      </span></th>
                    <th width="119" align="right"  style="height: 32px" >Relation :&nbsp; &nbsp;</th>
                    <th width="356" align="left" style="height: 32px" ><span >
                      &nbsp;
                      <asp:Label ID="LabelRelation" runat="server" CssClass="text_labels_two" Visible="false"
                                              ></asp:Label>
                      <asp:Label ID="LabelRName" runat="server" CssClass="text_boxtitle" ></asp:Label>
                        &nbsp;
                      </span></th>
                  </tr>
              <tr>
                <th align="right"  style="height: 22px" >Age :&nbsp;</th>
                    <td align="left" style="height: 22px"><span  style="width: 373px">
                      &nbsp;<asp:Label ID="LabelPAge" runat="server" CssClass="text_boxtitle"></asp:Label><span style="font-size: 8pt; font-family: Verdana"><strong></strong></span></span></td>
                    <td align="right"  style="height: 22px">
                        Date of Birth :&nbsp;</td>
                    <td align="left" class="myborder3" style="height: 22px">
                      <span >
                      &nbsp;
                      <asp:Label ID="LabelAge" runat="server" CssClass="text_boxtitle"></asp:Label><asp:Label ID="LabelPType" runat="server" CssClass="text_boxtitle" Visible="False"></asp:Label></span></td>
                  </tr>
              </table></td>
                </tr>
          <tr>
            <td colspan="2" valign="top" style="text-align: center; height: 81px;"><span style="height: 27px">
                        <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False"
                    DataKeyNames="Table_ID" DataSourceID="SqlDataSource1" Width="625px" >
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" />
                        <asp:BoundField DataField="Table_ID" HeaderText="Table_ID" InsertVisible="False"
                            ReadOnly="True" SortExpression="Table_ID" Visible="False" />
                        <asp:BoundField DataField="RegNo" HeaderText="Registration No." SortExpression="RegNo" />
                        <asp:BoundField DataField="YearlyNo" HeaderText="Yearly No." SortExpression="YearlyNo" />
                        <asp:BoundField DataField="RadiologyName" HeaderText="Area of Scan" SortExpression="RadiologyName" />
                        <asp:BoundField DataField="RID" HeaderText="RID" InsertVisible="False" ReadOnly="True"
                            SortExpression="RID" Visible="False" />
                        <asp:HyperLinkField DataNavigateUrlFields="rid,YearlyNo,RegNo" DataNavigateUrlFormatString="~/Dicom/DicomeViewer.aspx?RID={0}&amp;Payid={1}&amp;RegNo={2}  "
                            Text="Dicom Viewer" Visible="False" />
                    </Columns>
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
                <br />
                </span>
                        <table>
                        
                            <tr>
                               
                                <td style="width: 100px"><span>
              <asp:FileUpload ID="FileUploadXray" runat="server" EnableViewState="True" Width="400px" /></span></td>
                                <td style="width: 100px"><span>
                                    <asp:Button ID="Button_File_save" runat="server" Text="Save Image" /></span></td>
                            </tr>
                            <tr>
                                <td style="width: 100px"><span>
                        <asp:Label ID="Label_message" runat="server" ForeColor="Blue" Width="223px"></asp:Label></span></td>
                                <td style="width: 100px"><span></span>
                                </td>
                            </tr>
                        </table>
                        <span>
              <asp:SqlDataSource ID="SqlDataSourceXray" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                      InsertCommand="Rd_insert_MRI_description"
                      ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" InsertCommandType="StoredProcedure" UpdateCommand="UPDATE Rd_Xray_Report SET Xray_Description = @Xray_Description
Where ((YearlyNo = @YearlyNo) and (RegNo = @RegNo) and (Xray_ID = @XRay_ID))">
                <InsertParameters>
                  <asp:QueryStringParameter Name="RegNo" QueryStringField="regno" />
                  <asp:QueryStringParameter Name="YearlyNo" QueryStringField="PayID" />
                  <asp:QueryStringParameter Name="Pt_Test_ID" QueryStringField="RID" Type="Int32" />
                  <asp:ControlParameter ControlID="TextBoxXrayReport" Name="MRI_Description" PropertyName="Text"
                              Type="String" />
                    <asp:QueryStringParameter Name="PRadiologyID" QueryStringField="Radiology_Id" Type="Int32" />
                  </InsertParameters>
                <UpdateParameters>
                  <asp:ControlParameter ControlID="TextBoxXrayReport" Name="Xray_Description" PropertyName="Text" />
                  <asp:QueryStringParameter Name="YearlyNo" QueryStringField="payId" />
                  <asp:QueryStringParameter Name="RegNo" QueryStringField="reg_no" />
                  <asp:QueryStringParameter Name="XRay_ID" QueryStringField="Xray_ID" />
                  </UpdateParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    DeleteCommand="DELETE FROM Pt_MRI_Images WHERE (Table_ID = @Table_ID)" ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>"
                    SelectCommand="SELECT Pt_MRI_Images.Table_ID, Pt_MRI_Images.RegNo, Pt_MRI_Images.YearlyNo, Radiology.RadiologyName, Radiology.RID, Pt_MRI_Images.Pt_test_Id FROM Pt_MRI_Images INNER JOIN Radiology ON Pt_MRI_Images.Pt_test_Id = Radiology.RID WHERE (Pt_MRI_Images.RegNo = @RegNo) AND (Pt_MRI_Images.YearlyNo = @YearlyNo) AND (Pt_MRI_Images.Pt_test_Id = @Pt_test_id)">
                    <DeleteParameters>
                        <asp:ControlParameter ControlID="GridView4" Name="Table_ID" PropertyName="SelectedValue" />
                    </DeleteParameters>
                    <SelectParameters>
                        <asp:QueryStringParameter Name="RegNo" QueryStringField="Regno" />
                        <asp:QueryStringParameter Name="YearlyNo" QueryStringField="payid" />
                        <asp:QueryStringParameter Name="Pt_test_id" QueryStringField="RID" />
                    </SelectParameters>
                </asp:SqlDataSource>
              </span>
            </td>
                </tr>
          <tr>
            <td height="25" align="right" valign="middle" style="width: 247px"><span  style="width: 143px">&nbsp;</span></td>
                <td rowspan="2" valign="top" style="width: 831px; text-align: center;"><span style="width: 100px">
                  &nbsp;</span><br />
                    <ighedit:WebHtmlEditor ID="TextBoxXrayReport" runat="server" Width="649px" Visible="False">
                        <Toolbar>
                            <ighedit:ToolbarImage runat="server" Type="DoubleSeparator" />
                            <ighedit:ToolbarButton runat="server" Type="Bold" />
                            <ighedit:ToolbarButton runat="server" Type="Italic" />
                            <ighedit:ToolbarButton runat="server" Type="Underline" />
                            <ighedit:ToolbarButton runat="server" Type="Strikethrough" />
                            <ighedit:ToolbarImage runat="server" Type="Separator" />
                            <ighedit:ToolbarButton runat="server" Type="Subscript" />
                            <ighedit:ToolbarButton runat="server" Type="Superscript" />
                            <ighedit:ToolbarImage runat="server" Type="Separator" />
                            <ighedit:ToolbarButton runat="server" Type="Cut" />
                            <ighedit:ToolbarButton runat="server" Type="Copy" />
                            <ighedit:ToolbarButton runat="server" Type="Paste" />
                            <ighedit:ToolbarImage runat="server" Type="Separator" />
                            <ighedit:ToolbarButton runat="server" Type="Undo" />
                            <ighedit:ToolbarButton runat="server" Type="Redo" />
                            <ighedit:ToolbarImage runat="server" Type="Separator" />
                            <ighedit:ToolbarButton runat="server" Type="JustifyLeft" />
                            <ighedit:ToolbarButton runat="server" Type="JustifyCenter" />
                            <ighedit:ToolbarButton runat="server" Type="JustifyRight" />
                            <ighedit:ToolbarButton runat="server" Type="JustifyFull" />
                            <ighedit:ToolbarImage runat="server" Type="Separator" />
                            <ighedit:ToolbarButton runat="server" Type="Indent" />
                            <ighedit:ToolbarButton runat="server" Type="Outdent" />
                            <ighedit:ToolbarImage runat="server" Type="Separator" />
                            <ighedit:ToolbarButton runat="server" Type="UnorderedList" />
                            <ighedit:ToolbarButton runat="server" Type="OrderedList" />
                            <ighedit:ToolbarImage runat="server" Type="Separator" />
                            <ighedit:ToolbarDialogButton runat="server" Type="InsertRule">
                                <Dialog InternalDialogType="InsertRule" />
                            </ighedit:ToolbarDialogButton>
                            <ighedit:ToolbarImage runat="server" Type="RowSeparator" />
                            <ighedit:ToolbarImage runat="server" Type="DoubleSeparator" />
                            <ighedit:ToolbarDialogButton runat="server" Type="FontColor">
                                <Dialog BackColor="#ECE9D8" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px"
                                    Font-Names="sans-serif" Font-Size="8pt" ForeColor="Black" />
                            </ighedit:ToolbarDialogButton>
                            <ighedit:ToolbarDialogButton runat="server" Type="FontHighlight">
                                <Dialog BackColor="#ECE9D8" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px"
                                    Font-Names="sans-serif" Font-Size="8pt" ForeColor="Black" />
                            </ighedit:ToolbarDialogButton>
                            <ighedit:ToolbarDialogButton runat="server" Type="SpecialCharacter">
                                <Dialog InternalDialogType="SpecialCharacterPicker" Type="InternalWindow" />
                            </ighedit:ToolbarDialogButton>
                            <ighedit:ToolbarMenuButton runat="server" Type="InsertTable">
                                <Menu Width="80px">
                                    <ighedit:HtmlBoxMenuItem runat="server" Act="TableProperties">
                                        <Dialog InternalDialogType="InsertTable" />
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
                                        <Dialog InternalDialogType="CellProperties" />
                                    </ighedit:HtmlBoxMenuItem>
                                    <ighedit:HtmlBoxMenuItem runat="server" Act="TableProperties">
                                        <Dialog InternalDialogType="ModifyTable" />
                                    </ighedit:HtmlBoxMenuItem>
                                </Menu>
                            </ighedit:ToolbarMenuButton>
                            <ighedit:ToolbarButton runat="server" Type="ToggleBorders" />
                            <ighedit:ToolbarImage runat="server" Type="Separator" />
                            <ighedit:ToolbarButton runat="server" Type="InsertLink" />
                            <ighedit:ToolbarButton runat="server" Type="RemoveLink" />
                            <ighedit:ToolbarImage runat="server" Type="Separator" />
                            <ighedit:ToolbarButton runat="server" RaisePostback="True" Type="Save" />
                            <ighedit:ToolbarUploadButton runat="server" Type="Open">
                                <Upload Filter="*.htm,*.html,*.asp,*.aspx" Height="350px" Mode="File" Width="500px" />
                            </ighedit:ToolbarUploadButton>
                            <ighedit:ToolbarButton runat="server" Type="Preview" />
                            <ighedit:ToolbarImage runat="server" Type="Separator" />
                            <ighedit:ToolbarDialogButton runat="server" Type="FindReplace">
                                <Dialog InternalDialogType="FindReplace" />
                            </ighedit:ToolbarDialogButton>
                            <ighedit:ToolbarDialogButton runat="server" Type="InsertBookmark">
                                <Dialog InternalDialogType="InsertBookmark" />
                            </ighedit:ToolbarDialogButton>
                            <ighedit:ToolbarUploadButton runat="server" Type="InsertImage">
                                <Upload Height="420px" Width="500px" />
                            </ighedit:ToolbarUploadButton>
                            <ighedit:ToolbarUploadButton runat="server" Type="InsertFlash">
                                <Upload Filter="*.swf" Height="440px" Mode="Flash" Width="500px" />
                            </ighedit:ToolbarUploadButton>
                            <ighedit:ToolbarUploadButton runat="server" Type="InsertWindowsMedia">
                                <Upload Filter="*.asf,*.wma,*.wmv,*.wm,*.avi,*.mpg,*.mpeg,*.m1v,*.mp2,*.mp3,*.mpa,*.mpe,*.mpv2,*.m3u,*.mid,*.midi,*.rmi,*.aif,*.aifc,*.aiff,*.au,*.snd,*.wav,*.cda,*.ivf"
                                    Height="400px" Mode="WindowsMedia" Width="500px" />
                            </ighedit:ToolbarUploadButton>
                            <ighedit:ToolbarDialogButton runat="server" Type="Help">
                                <Dialog InternalDialogType="Text" />
                            </ighedit:ToolbarDialogButton>
                            <ighedit:ToolbarButton runat="server" Type="CleanWord" />
                            <ighedit:ToolbarButton runat="server" Type="WordCount" />
                            <ighedit:ToolbarButton runat="server" Type="PasteHtml" />
                            <ighedit:ToolbarMenuButton runat="server" Type="Zoom">
                                <Menu Width="180px">
                                    <ighedit:HtmlBoxMenuItem runat="server" Act="Zoom25">
                                    </ighedit:HtmlBoxMenuItem>
                                    <ighedit:HtmlBoxMenuItem runat="server" Act="Zoom50">
                                    </ighedit:HtmlBoxMenuItem>
                                    <ighedit:HtmlBoxMenuItem runat="server" Act="Zoom75">
                                    </ighedit:HtmlBoxMenuItem>
                                    <ighedit:HtmlBoxMenuItem runat="server" Act="Zoom100">
                                    </ighedit:HtmlBoxMenuItem>
                                    <ighedit:HtmlBoxMenuItem runat="server" Act="Zoom200">
                                    </ighedit:HtmlBoxMenuItem>
                                    <ighedit:HtmlBoxMenuItem runat="server" Act="Zoom300">
                                    </ighedit:HtmlBoxMenuItem>
                                    <ighedit:HtmlBoxMenuItem runat="server" Act="Zoom400">
                                    </ighedit:HtmlBoxMenuItem>
                                    <ighedit:HtmlBoxMenuItem runat="server" Act="Zoom500">
                                    </ighedit:HtmlBoxMenuItem>
                                    <ighedit:HtmlBoxMenuItem runat="server" Act="Zoom600">
                                    </ighedit:HtmlBoxMenuItem>
                                </Menu>
                            </ighedit:ToolbarMenuButton>
                            <ighedit:ToolbarButton runat="server" Type="TogglePositioning" />
                            <ighedit:ToolbarButton runat="server" Type="BringForward" />
                            <ighedit:ToolbarButton runat="server" Type="SendBackward" />
                            <ighedit:ToolbarImage runat="server" Type="RowSeparator" />
                            <ighedit:ToolbarImage runat="server" Type="DoubleSeparator" />
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
                                    <ighedit:ToolbarDropDownItem runat="server" Act="Greeting" />
                                    <ighedit:ToolbarDropDownItem runat="server" Act="Signature" />
                                </Items>
                            </ighedit:ToolbarDropDown>
                        </Toolbar>
                        <DialogStyle BackColor="#ECE9D8" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px"
                            Font-Names="sans-serif" Font-Size="8pt" ForeColor="Black" />
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
                                <Dialog InternalDialogType="CellProperties" />
                            </ighedit:HtmlBoxMenuItem>
                            <ighedit:HtmlBoxMenuItem runat="server" Act="TableProperties">
                                <Dialog InternalDialogType="ModifyTable" />
                            </ighedit:HtmlBoxMenuItem>
                            <ighedit:HtmlBoxMenuItem runat="server" Act="InsertImage">
                            </ighedit:HtmlBoxMenuItem>
                        </RightClickMenu>
                    </ighedit:WebHtmlEditor>
                    &nbsp;<br />
                  <span style="vertical-align: middle; text-align: center">&nbsp; <br />
                      <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                          <ContentTemplate>
                              <table>
                                  <tr>
                                      <td style="width: 100px">
                    <asp:Button ID="btnSave" runat="server" Text="Save Description" Width="143px" Visible="False" /></td>
                                      <td style="width: 100px">
                      <asp:Button ID="Button1" runat="server" Text="View Report" Visible="False" /></td>
                                      <td style="width: 100px">
                      <asp:Button ID="Button_Complete" runat="server" Text="Complete For Deliver" Width="175px" Visible="False" /></td>
                                  </tr>
                              </table>
                              <asp:Label ID="Label_Description" runat="server" ForeColor="Blue"></asp:Label>
                          </ContentTemplate>
                      </asp:UpdatePanel>
                      &nbsp; &nbsp;&nbsp; &nbsp;<br />
                    <span style="height: 30px">
                    </span><span style="height: 30px">
                    </span><span style="height: 30px">
                    </span>
                    <asp:SqlDataSource ID="SqlDataSourceUpdate" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                          ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" UpdateCommand="UPDATE Rd_MRI_Report SET MRI_Description = @MRI_Description
Where ((YearlyNo = @YearlyNo) and (RegNo = @RegNo) and (Pt_Test_ID= @Pt_Test_ID))">
                      <UpdateParameters>
                        <asp:QueryStringParameter Name="YearlyNo" QueryStringField="payId" />
                        <asp:QueryStringParameter Name="RegNo" QueryStringField="regno" />
                        <asp:ControlParameter ControlID="HiddenFieldDiscription" Name="MRI_Description" PropertyName="Value" />
                        <asp:QueryStringParameter Name="Pt_Test_ID" QueryStringField="RID" />
                      </UpdateParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSourceUpdateStatus" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                          ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" UpdateCommand="UPDATE Pt_Radiology_LabTest SET Status = 'Done' WHERE (RegNo = @RegNo) AND (PRadiologyID = @Pt_Test_ID) AND (PayID = @YearlyNo)">
                      <UpdateParameters>
                        <asp:QueryStringParameter Name="YearlyNo" QueryStringField="payId" />
                        <asp:QueryStringParameter Name="RegNo" QueryStringField="regno" />
                        <asp:QueryStringParameter Name="Pt_Test_ID" QueryStringField="Radiology_Id" />
                      </UpdateParameters>
                    </asp:SqlDataSource>
                    <asp:HiddenField ID="HiddenFieldDiscription" runat="server" />
                      <asp:Label ID="LabelPulse" runat="server" CssClass="text_boxtitle" Visible="False"></asp:Label><asp:Label ID="LabelBP" runat="server" CssClass="text_boxtitle" Visible="False"></asp:Label><asp:Label ID="LabelBPLow" runat="server" CssClass="text_boxtitle" Visible="False"></asp:Label><asp:Label ID="Label1" runat="server"  Text="mm/gh" Visible="False"></asp:Label><asp:Label ID="LabelRR" runat="server" CssClass="text_titles_bold" Visible="False"></asp:Label><br />
                      <asp:Label ID="Label3" runat="server"  Text="per min." Visible="False"></asp:Label><asp:Label ID="LabelTemp" runat="server" CssClass="text_titles_bold" Visible="False"></asp:Label><asp:Label ID="Label4" runat="server"  Text="F" Visible="False"></asp:Label>
                      <asp:Label ID="Label2" runat="server"  Text="bpm" Visible="False"></asp:Label>
                      <asp:Button ID="ButtonUpdate" runat="server" Text="Update Report" Width="122px" Visible="False" /></span></td>
                </tr>
          <tr>
            <td style="height: 107px; width: 247px;"></td>
                </tr>
          <tr>
            <td height="47" style="width: 247px"></td>
                <td style="width: 831px">&nbsp;<asp:Label CssClass="text_titles_bold" ID="Bodypart" runat="server" Text="Body Part" Width="340px" Visible="False"></asp:Label><asp:Label  ID="LabelXray" runat="server" Width="264px" Visible="False"></asp:Label><asp:Label CssClass="text_titles_bold" ID="projec" runat="server" Text="Projection" Visible="False" Width="329px"></asp:Label><asp:Label  ID="labelpro" runat="server" Width="253px" Visible="False"></asp:Label></td>
                </tr>
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          </table></td>
          </tr>
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
    </table></td>
    <td width="32" valign="top" class="right_border" ><img src="images1/img_border_right.gif" width="23" height="15" alt=""/></td>
  </tr>
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_bottom.gif" width="1003" height="24" alt=""/></td>
  </tr>
</table>
<script type="text/javascript" src="images1/flash_01.js">function Button1_onclick() {

}

</script>
</form>
</body>
</html>