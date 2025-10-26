<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Ai_diagnosis_Main.aspx.vb" Inherits="Ai_diagnosis_Main" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
 <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Lahore General Hospital</title>
<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />

</head>

<body>
<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_top.gif" width="1003" height="24" /></td>
  </tr>
  <tr>
    <td width="23" height="550" valign="top" class="left_border"><img src="images1/img_border_left.gif" width="23" height="15" /></td>
    <td width="957" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
        <td height="97" colspan="2" valign="top"><iframe 
      src="tabs.aspx" name="holder" width="957" marginwidth="0" height="157" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
      </tr>
      
      <tr>
        <td width="19" height="25" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td width="929" valign="middle" class="text_lables3">
              Diagnosis Research</td>
        </tr>
      <tr>
        <td height="428" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="mainframe_bg13">
          <!--DWLayoutTable-->
          <tr>
            <td width="20" rowspan="2" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td height="10" colspan="2" valign="top"><img src="images1/img_spacer2.gif" width="2" height="10" /></td>
                  <td width="20" rowspan="2" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
              </tr>
          <tr>
            <td height="131" colspan="2" dir="ltr">
                <table>
                    <tr>
                        <td style="width: 151px; height: 21px; text-align: right;">
                            </td>
                        <td dir="ltr" style="width: 253px; height: 21px">
                            </td>
                    </tr>
                </table>
                <table border="0" cellpadding="0" cellspacing="0"  
                     width="100%">
                    <!--DWLayoutTable-->
                    <tr>
                        <td align="right"  style="height: 37px; text-align: right"
                            valign="middle" width="156">
                            <strong>
                            Disease Name :&nbsp; </strong>
                        </td>
                        <td style="font-size: 12pt; font-family: Times New Roman; height: 37px" valign="middle"
                            width="207">
                            <asp:DropDownList ID="DropDownListDisease" runat="server" DataSourceID="SqlDataSourceDisease"
                                DataTextField="Disease_Name" DataValueField="ID" Width="180px" Css AutoPostBack="True">
                            </asp:DropDownList></td>
                        <td align="right" colspan="2" style="font-size: 12pt; font-family: Times New Roman;
                            height: 37px" valign="middle">
                        </td>
                        <td style="font-size: 12pt; font-family: Times New Roman; height: 37px" valign="middle"
                            width="223">
                        </td>
                    </tr>
                    <tr>
                        <td align="right"  style="height: 37px; text-align: right"
                            valign="middle" width="156">
                            <strong>Select Category :&nbsp; </strong>
                        </td>
                        <td style="font-size: 12pt; font-family: Times New Roman; height: 37px" valign="middle"
                            width="207">
                            <asp:DropDownList ID="DropDownListCategory_Name" runat="server" AutoPostBack="True"
                                Css Width="180px">
                                <asp:ListItem>Histories</asp:ListItem>
                                <asp:ListItem>Physical Examination</asp:ListItem>
                                <asp:ListItem>Investigations</asp:ListItem>
                            </asp:DropDownList></td>
                        <td align="right" colspan="2" style="font-size: 12pt; font-family: Times New Roman;
                            height: 37px" valign="middle">
                            &nbsp;Main Group :&nbsp;</td>
                        <td style="font-size: 12pt; font-family: Times New Roman; height: 37px" valign="middle"
                            width="223">
                            <asp:DropDownList ID="DropDownListMainGroup" runat="server" AutoPostBack="True" Css
                                Width="180px">
                            </asp:DropDownList></td>
                    </tr>
                    <tr style="font-size: 12pt; font-family: Times New Roman">
                        <td align="right"  style="height: 30px" valign="middle">
                            Element Name :&nbsp;</td>
                        <td colspan="2" style="height: 30px" valign="middle">
                            <asp:DropDownList ID="DropDownListElement" runat="server" AutoPostBack="True" Css
                                Width="180px">
                            </asp:DropDownList>
                        </td>
                        <td colspan="2" dir="ltr" style="height: 30px" valign="middle">
                            <span style="height: 34px">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span>
                        </td>
                    </tr>
                    <tr>
                        <td align="right"  dir="ltr" height="30" valign="middle">
                        </td>
                        <td colspan="2" dir="ltr" valign="middle">
                            <table>
                                <tr>
                                    <td rowspan="5" style="width: 52px">
                                        <asp:RadioButtonList ID="RadioButtonList1" runat="server" Height="124px" Width="53px">
                                            <asp:ListItem>=</asp:ListItem>
                                            <asp:ListItem>Like</asp:ListItem>
                                            <asp:ListItem>&gt;</asp:ListItem>
                                            <asp:ListItem>&lt;</asp:ListItem>
                                        </asp:RadioButtonList></td>
                                    <td style="width: 133px; height: 29px">
                                        <asp:TextBox ID="TextBoxEqual1" runat="server" Width="115px"></asp:TextBox></td>
                                    <td style="width: 99px; height: 29px">
                                    </td>
                                    <td rowspan="5" style="width: 45px">
                                        <asp:RadioButtonList ID="RadioButtonList2" runat="server" Height="124px" Width="53px" Visible="False">
                                            <asp:ListItem>=</asp:ListItem>
                                            <asp:ListItem>Like</asp:ListItem>
                                            <asp:ListItem>&gt;</asp:ListItem>
                                            <asp:ListItem>&lt;</asp:ListItem>
                                        </asp:RadioButtonList></td>
                                    <td style="width: 124px; height: 29px">
                                        <asp:TextBox ID="TextBoxEqual2" runat="server" Width="115px" Visible="False"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td style="width: 133px; height: 18px">
                                        <asp:TextBox ID="TextBoxLike1" runat="server" Width="115px"></asp:TextBox></td>
                                    <td rowspan="2" style="width: 99px; text-align: center">
                                        <asp:DropDownList ID="DropDownListOperater" runat="server" Css Width="60px" Visible="False">
                                            <asp:ListItem>And</asp:ListItem>
                                            <asp:ListItem>Or</asp:ListItem>
                                            <asp:ListItem>None</asp:ListItem>
                                        </asp:DropDownList></td>
                                    <td style="width: 124px; height: 18px">
                                        <asp:TextBox ID="TextBoxLike2" runat="server" Width="115px" Visible="False"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td style="width: 133px; height: 18px">
                                        <asp:TextBox ID="TextBoxGreater1" runat="server" Width="115px"></asp:TextBox></td>
                                    <td style="width: 124px; height: 18px">
                                        <asp:TextBox ID="TextBoxGreater2" runat="server" Width="115px" Visible="False"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td style="width: 133px; height: 18px">
                                        <asp:TextBox ID="TextBoxLess1" runat="server" Width="115px"></asp:TextBox></td>
                                    <td style="width: 99px; height: 18px">
                                    </td>
                                    <td style="width: 124px; height: 18px">
                                        <asp:TextBox ID="TextBoxLess2" runat="server" Width="115px" Visible="False"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td style="width: 133px; height: 10px">
                                    </td>
                                    <td style="width: 99px; height: 10px">
                                    </td>
                                    <td style="width: 124px; height: 10px">
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td colspan="2" dir="ltr" valign="middle">
                        </td>
                    </tr>
                    <tr>
                        <td height="0">
                        </td>
                        <td style="text-align: center">
                            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                            &nbsp; &nbsp;
                            <asp:Button ID="ButtonSave" runat="server" Text="Save" Width="100px" CssClass="bt2up" /></td>
                        <td width="70">
                        </td>
                        <td width="57">
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="SqlDataSourceForGridView" Width="100%">
                    <FooterStyle CssClass="GridPager" />
                    <Columns>
                        <asp:BoundField DataField="Examination_type" HeaderText="Examination Type" SortExpression="Examination_type" />
                        <asp:BoundField DataField="MG_Name" HeaderText="Main Group Name" SortExpression="MG_Name" />
                        <asp:BoundField DataField="e_Name" HeaderText="Element Name" SortExpression="e_Name" />
                        <asp:BoundField DataField="OPerator" HeaderText="OPerator" SortExpression="OPerator" />
                        <asp:BoundField DataField="Value" HeaderText="Value" SortExpression="Value" />
                        <asp:BoundField DataField="Disease_Category" HeaderText="Disease Category" SortExpression="Disease_Category" />
                    </Columns>
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSourceForGridView" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    DeleteCommand="DELETE FROM admin_history_Elements WHERE (e_Code = @e_Code)" ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>"
                    SelectCommand="Admin_View_Dmc_Disease" SelectCommandType="StoredProcedure" UpdateCommand="UPDATE admin_History_Elements SET e_Name = @e_Name, e_Field_Type = @e_Field_Type WHERE (e_Code = @e_code)">
                    <DeleteParameters>
                        <asp:ControlParameter ControlID="GridView1" Name="e_Code" PropertyName="SelectedValue" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="HiddenFieldename" Name="e_Name" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenFieldfieldtype" Name="e_Field_Type" PropertyName="Value" />
                        <asp:ControlParameter ControlID="GridView1" Name="e_code" PropertyName="SelectedValue" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownListCategory_Name" Name="Examination_Type"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="DropDownListDisease" Name="Disease_Id" PropertyName="SelectedValue"
                            Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />
                <asp:SqlDataSource ID="SqlDataSourceMainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>"></asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSourceElement" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>"></asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    InsertCommand="Admin_Insert_AI_Dioagnosis_Sub" InsertCommandType="StoredProcedure"
                    ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>">
                    <InsertParameters>
                        <asp:ControlParameter ControlID="DropDownListCategory_Name" Name="Type" PropertyName="SelectedValue"
                            Type="String" />
                        <asp:ControlParameter ControlID="HiddenFieldDisease" Name="AI_ID" PropertyName="Value"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="DropDownListMainGroup" Name="Main_Group" PropertyName="SelectedValue"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="DropDownListElement" Name="Element_ID" PropertyName="SelectedValue"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="HiddenFieldOperator" Name="Operator" PropertyName="Value"
                            Type="String" />
                        <asp:ControlParameter ControlID="HiddenFieldValue" Name="Value" PropertyName="Value"
                            Type="String" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenFieldDisease" runat="server" />
                <asp:SqlDataSource ID="SqlDataSourceDisease" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT Disease_Name, ID FROM Admin_DMC_Disease">
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenFieldExam_Type" runat="server" />
                <asp:HiddenField ID="HiddenField2" runat="server" /><asp:HiddenField ID="HiddenFieldOperator" runat="server" />
                <asp:HiddenField ID="HiddenFieldValue" runat="server" />
            </td>
          </tr>
          
          
          
          

          

          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          

          
          
          
          
          
          


          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          

          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          </table></td>
          </tr>
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
    </table></td>
    <td width="33" valign="top" class="right_border" ><img src="images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_bottom.gif" width="1003" height="24" /></td>
  </tr>
  
  <tr>
    <td height="1"></td>
    <td></td>
    <td></td>
  </tr>
</table>
<script type="text/javascript" src="images1/flash_01.js"></script>
</form>
</body>
</html>