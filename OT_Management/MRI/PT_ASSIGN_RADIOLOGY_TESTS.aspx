<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PT_ASSIGN_RADIOLOGY_TESTS.aspx.vb" Inherits="PT_ASSIGN_RADIOLOGY_TESTS" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .style1
        {
            font-family: Verdana;
            font-size: 11px;
            font-weight: bold;
            color: #000000;
            text-decoration: none;
        }
        .style2
        {
            font-family: Verdana;
            font-size: 11px;
            font-weight: normal;
            color: #000000;
            text-decoration: none;
            width: 198px;
        }
        .style3
        {
            font-family: Verdana;
            font-size: 11px;
            font-weight: bold;
            color: #000000;
            text-decoration: none;
            width: 172px;
        }
    </style>
    <script language ="javascript" type ="text/javascript" >
    function abc()
    {
    alert("fdsfs");
    }
    function Validate()
    {
    var Report_After_Days = document.getElementById("TextBox_next_Date").value 
        if(Report_After_Days - 0 == Report_After_Days )
        {
            if (Report_After_Days>21)
            {
            alert("Enter Less Then 21");
            return false;
            }
        }
        else
        {
        alert("Enter Integer Only");
        return false; 
        
        }
    }
    </script>
</head>

<body>
<form id="form1" runat = "server">
<div ><asp:ScriptManager ID="ScriptManager1" runat="server">
              </asp:ScriptManager>
<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_top.gif" width="1003" height="24" alt="" /></td>
  </tr>
  <tr>
    <td width="23" height="550" valign="top" class="left_border"><img src="images1/img_border_left.gif" width="23" height="15"  alt="" /></td>
    <td width="957" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <tr>
        <td height="97" colspan="2" valign="top"><iframe 
      src="tabs.aspx" name="holder" width="957" marginwidth="0" height="97" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
        </tr>
      
      
      <tr>
        <td width="19" height="25" valign="top">&nbsp;</td>
          <td width="929" valign="middle" class="text_lables3">
              Select Test
          </td>
        </tr>
      <tr>
        <td height="428" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="mainframe_bg1">
          <tr>
            <td width="20" rowspan="5" valign="top"><img src="images1/img_spacer.gif" width="20" height="2"  alt="" /></td>
                  <td width="917" height="10" valign="top"><img src="images1/img_spacer2.gif" width="2" height="10"  alt="" /></td>
                  <td width="20" rowspan="5" valign="top"><img src="images1/img_spacer.gif" width="20" height="2"  alt="" /></td>
              </tr>
          <tr>
            <td height="145" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0"  >
                    <tr>
                <td colspan="4" align="center" valign="middle" style="height: 22px">
                            <asp:RadioButtonList ID="RadioButtonList_Type" runat="server" AutoPostBack="True"
                        RepeatDirection="Horizontal" Width="337px">
                        <asp:ListItem Selected="True" Value="Plain">Plain</asp:ListItem>
                        <asp:ListItem Value="Contrast">Contrast</asp:ListItem>
                    </asp:RadioButtonList></td>
                      </tr>
                <tr>
                    <td align="left" class="text_lables3" colspan="4" style="height: 23px" valign="middle">
                        Area of Scan</td>
                </tr>
                <tr>
                    <td align="center" colspan="4" height="35" style="text-align: left" valign="middle">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                        <asp:CheckBoxList ID="CheckBoxListForRadiologySG" runat="server" CssClass="text_titles_bold"
                            DataSourceID="SqlDataSourceRadiologyForEnteries" DataTextField="RadiologyName"
                            DataValueField="RID" RepeatColumns="5" Width="862px">                        </asp:CheckBoxList>
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<strong> </strong><span style="font-size: 10pt; font-family: Arial">
                                    <strong>Add New Area of Scan :</strong>
                                    <asp:TextBox ID="TextBox_new_Area" runat="server"></asp:TextBox><strong> 
                                &nbsp;Fee :
                                    </strong>
                                    <asp:TextBox ID="TextBox_Fee" runat="server"></asp:TextBox><strong> &nbsp;</strong><asp:Button
                                        ID="Button_save_new_area" runat="server" OnClick="Button_save_new_area_Click"
                                        Text="Save" Width="70px" /></span>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        &nbsp;
                    </td>
                </tr>
              
              
                        </table>
                &nbsp; &nbsp;
            </td>
                </tr>
          <tr>
            <td align="right" valign="top"></td>
          </tr>
          <tr>
            <td height="254" valign="top">
                <table>
                    <tr>
                        <td ><span>
                     
                            <asp:Panel ID="Panel1" runat="server" Height="50px" Visible="False" Width="125px">
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                    <ContentTemplate>
                                <asp:CheckBoxList ID="CheckBoxList1" runat="server" CssClass="text_titles_bold" DataSourceID="SqlDataSource1"
                                    DataTextField="Med_Name" DataValueField="Med_Code" RepeatColumns="3" Width="808px">
                                </asp:CheckBoxList>&nbsp;
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </asp:Panel></span>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 853px; ">
                            <table border="0" cellpadding="0" cellspacing="0"  
                                 width="100%">
                                <tr>
                                    <td  style="height: 42px" width="183"><span>
                                        &nbsp;<asp:Label ID="Label5" runat="server" Text="Appointment Date"></asp:Label>&nbsp; : &nbsp;</span></td>
                                    <td style="width: 198px; height: 42px; text-align: left"><span>
                                        <igsch:WebDateChooser ID="WebDateChooser1" runat="server" AllowNull="False">
                                        </igsch:WebDateChooser></span>
                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                                    SelectCommand="SELECT Med_Name, Med_Code FROM Medicines" InsertCommand="INSERT INTO Radiology(RGID, RadiologyName, Fee, RSGID) VALUES (17, @RadiologyName, @Fee, 37)">
                                    <InsertParameters>
                                        <asp:ControlParameter ControlID="TextBox_new_Area" Name="RadiologyName" PropertyName="Text" />
                                        <asp:ControlParameter ControlID="TextBox_Fee" Name="Fee" PropertyName="Text" />
                                    </InsertParameters>
                                </asp:SqlDataSource>
                                    </td>
                                    <td  style="width: 172px; height: 42px"><span>
                                        <asp:Label ID="Label4" runat="server" Text=" Appointment Time "></asp:Label> &nbsp;</span></td><td>Hour :
                                                                    <asp:DropDownList ID="DropDownList_Hr" runat="server">
                                                                        <asp:ListItem>08</asp:ListItem>
                                                                        <asp:ListItem>09</asp:ListItem>
                                                                        <asp:ListItem>10</asp:ListItem>
                                                                        <asp:ListItem>11</asp:ListItem>
                                                                        <asp:ListItem>12</asp:ListItem>
                                                                        <asp:ListItem>13</asp:ListItem>
                                                                        <asp:ListItem>14</asp:ListItem>
                                                                        <asp:ListItem>15</asp:ListItem>
                                                                        <asp:ListItem>16</asp:ListItem>
                                                                        <asp:ListItem>17</asp:ListItem>
                                                                        <asp:ListItem>18</asp:ListItem>
                                                                    </asp:DropDownList>
&nbsp;Min :
                                                                    <asp:DropDownList ID="DropDownList_MIn" runat="server">
                                                                        <asp:ListItem>00</asp:ListItem>
                                                                        <asp:ListItem>15</asp:ListItem>
                                                                        <asp:ListItem>30</asp:ListItem>
                                                                        <asp:ListItem>45</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </td>
                                </tr>
                                <tr>
                                    <td class="style1" width="183"><span>
                                        <asp:Label ID="Label3" runat="server" Text=" Report After Test"></asp:Label>&nbsp; :&nbsp;</span>
                                    </td>
                                    <td class="style2" style="text-align: left"><span>
                                        <asp:TextBox ID="TextBox_next_Date" runat="server" Width="146px">0</asp:TextBox>
                                        Days</span></td>
                                    <td align="right" class="style3" valign="middle">
                                    </td>
                                    <td style="text-align: left" width="418">
                                        <span>
                                        <igtxt:WebDateTimeEdit ID="WebDateTimeEdit1" runat="server" EditModeFormat="t"
                                            Nullable="False" Width="146px" Fields="2008-2-12-8-0-0-0" 
                                            MinValue="2008-02-12" Visible="False">
                                           
                                            <ClientSideEvents ValueChange="abc">
                                           
                                            </ClientSideEvents>
                                        </igtxt:WebDateTimeEdit></span>
                                        </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 853px; text-align: center; height: 24px;">
                            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                <ContentTemplate>
                                    <table style="width: 541px">
                                        <tr>
                                            <td style="width: 100px"><span>
                <asp:Button ID="BTNcheckAll" runat="server" Text="Check All" UseSubmitBehavior="False" CssClass="bt1upnew" /></span></td>
                                            <td style="width: 100px"><span>
                                                <asp:Button ID="BtnUncheckAll" runat="server" Text="UnCheck All" UseSubmitBehavior="False" CssClass="bt1upnew" /></span></td>
                                            <td style="width: 100px"><span>
                                                <asp:Button ID="btnAdd" runat="server" Text="Submit" UseSubmitBehavior="False" CssClass="bt1upnew" /></span></td>
                                            <td style="width: 100px"><span>
                                                <asp:Button
                    ID="ButtonReport" runat="server" Text="View Report" CssClass="bt1upnew" Visible="False" /></span></td>
                                            <td style="width: 100px"><span>
                                                <asp:Button
                    ID="Button_Next" runat="server" Text="Next" CssClass="bt1upnew" OnClick="Button_Next_Click" Visible="False" /></span></td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table><span>
                <asp:SqlDataSource ID="SqlDataSourceRadiologyGroup" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    SelectCommand="SELECT [TGName], [TGID] FROM [TestGroup]"></asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource_aPPONTMENT" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString12 %>"
                    InsertCommand="INSERT INTO MRI_Save_Patient_Next_App(Reg_no, Yearly_No, Next_App_Date, Next_App_Time, Report_Deliverd, Category) VALUES (@Reg_no, @Yearly_No, @Next_App_Date, @Next_App_Time, @Report_Deliverd, @Category)"
                    ProviderName="<%$ ConnectionStrings:LGHConnectionString12.ProviderName %>" SelectCommand="SELECT     Pt_Radiology_LabTest.RegNo, Pt_Radiology_LabTest.PayID, CONVERT(varchar, Pt_Radiology_LabTest.DateTime, 107) AS Date, CONVERT(varchar, &#13;&#10;                      Pt_Radiology_LabTest.DateTime, 108) AS Time, Pt_Radiology_LabTest.RID, Radiology.RadiologyName, Radiology.Fee&#13;&#10;FROM         Pt_Radiology_LabTest INNER JOIN&#13;&#10;                      Radiology ON Pt_Radiology_LabTest.RID = Radiology.RID&#13;&#10;WHERE     (Pt_Radiology_LabTest.PayID = @YearlyNo) AND (Pt_Radiology_LabTest.RegNo = @RegNo) AND (Pt_Radiology_LabTest.Status = 'Not Done')&#13;&#10;">
                    <SelectParameters>
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                        <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:SessionParameter Name="Reg_no" SessionField="RegistrationNo" />
                        <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" />
                        <asp:ControlParameter ControlID="HiddenField_Appointment_Date" Name="Next_App_Date"
                            PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenFieldAppointment_Time" Name="Next_App_Time"
                            PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenField_Report_Date" Name="Report_Deliverd"
                            PropertyName="Value" />
                        <asp:ControlParameter ControlID="RadioButtonList_Type" Name="Category" PropertyName="SelectedValue" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSourceRadiologySubGroup" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    SelectCommand="SELECT     RSGID, RSGName, Fee, RGID&#13;&#10;FROM         RadiologySubGroup&#13;&#10;where RSGID = 37&#13;&#10;order by Priority">
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSourceRadiologyForEnteries" runat="server" ConnectionString="<%$ ConnectionStrings:MRIConnectionString %>"
                    SelectCommand="SELECT RadiologyName, RID FROM Radiology WHERE (RSGID = 37) ORDER BY Priority">
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenFieldRadiologySubGroup" runat="server" />
                <asp:HiddenField ID="HiddenField_Appointment_Date" runat="server" />
                <asp:HiddenField ID="HiddenFieldAppointment_Time" runat="server" />
                <asp:HiddenField ID="HiddenField_Report_Date" runat="server" />
                <asp:SqlDataSource ID="SqlDataSourceforRadiologySG" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    SelectCommand="SELECT [TID], [TestName] FROM [Test] WHERE ([TSGID] = @TSGID)"></asp:SqlDataSource>
                    <asp:DataList ID="DataListRadiology" runat="server" CssClass="link1" DataKeyField="RSGID"
                        DataSourceID="SqlDataSourceRadiologySubGroup" RepeatDirection="Horizontal" Width="800px" Visible="False">
                        <ItemTemplate>
                            <span class="text_info1">
                                <asp:Label ID="RSGIDLabel" runat="server" Text='<%# Eval("RSGID") %>' Visible="False"></asp:Label>
                                <asp:Label ID="RSGNameLabel" runat="server" Text='<%# Eval("RSGName") %>' Visible="False"></asp:Label>
                                <br />
                                <asp:LinkButton ID="SelectButton" runat="server" CommandName="Select" Text='<%# Eval("RSGName") %>'></asp:LinkButton>
                                <br />
                            </span>
                        </ItemTemplate>
                        <ItemStyle CssClass="GridAltItem" />
                    </asp:DataList>
            </span>
                <asp:Label ID="Label2" runat="server" CssClass="text_labels" Width="399px"></asp:Label><asp:Label
                    ID="labelGName" runat="server" CssClass="text_labels" Width="313px"></asp:Label><asp:Label
                        ID="Label1" runat="server" CssClass="text_labels"></asp:Label></td>
          </tr>
          <tr>
            <td height="9"></td>
          </tr>
          

          
          
          
          
          
          
          
          
          
          
          
          

          
          
          
          
          
          


          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          

          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          </table></td>
          </tr>
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
    </table></td>
    <td width="33" valign="top" class="right_border" ><img src="images1/img_border_right.gif" width="23" height="15"  alt="" /></td>
  </tr>
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_bottom.gif" width="1003" height="24"  alt="" /></td>
  </tr>
  
  <tr>
    <td height="1"></td>
    <td></td>
    <td></td>
  </tr>
</table>
<script type="text/javascript" src="images1/flash_01.js"></script></div>
</form>
</body>
</html>