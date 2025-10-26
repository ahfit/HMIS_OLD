<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MRI_Radiology_test_Price.aspx.vb" Inherits="MRI_Radiology_test_Price" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
<script language ="javascript" type ="text/javascript" >
function Check_Validation()
{
    if (document.getElementById("TextBox_Grand_discount").value == "")
    {
    alert("Pleaze Enter The Discount");
    document.getElementById("TextBox_Grand_discount").focus();
    return false;
    }
    if (document.getElementById("TextBox_Grand_discount").value - 0 != document.getElementById("TextBox_Grand_discount").value)
    {
    alert("Pleaze Enter Only Integer ");
    document.getElementById("TextBox_Grand_discount").focus();
    return false;
    }    
}


</script>
</head>

<body>
<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_top.gif" width="1003" height="24" alt=""/></td>
  </tr>
  <tr>
    <td width="23" rowspan="2" valign="top" class="left_border"><img src="images1/img_border_left.gif" width="23" height="15" alt="" /></td>
    <td width="976" height="447" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
        <td height="97" colspan="2" valign="top"><iframe 
      src="tabs.aspx" name="holder" width="957" marginwidth="0" height="97" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
          </tr>
      
      
      <tr>
        <td width="21" valign="top" style="height: 25px"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="955" valign="middle" class="text_lables3" style="text-align: left; width: 924px; height: 25px;">
              Recieve Amount          </td>
          </tr>
      <tr>
        <td height="325" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="mainframe_bg1">
          <!--DWLayoutTable-->
          <tr>
            <td width="20" rowspan="8" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" alt="" /></td>
                  <td height="10" valign="top" style="width: 936px; height: 10px;"><img src="images1/img_spacer2.gif" width="2" height="10" alt="" /></td>
                  <td width="20" rowspan="8" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" alt="" /></td>
                </tr>
          <tr>
            <td height="10" style="width: 936px"></td>
                </tr>
          <tr>
            <td height="35"
                    valign="top" style="width: 936px"><asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="SqlDataSourceForGrid" Width="916px" DataKeyNames="PRadiologyID">
              <FooterStyle CssClass="GridPager"></FooterStyle>
              <Columns>
                <asp:BoundField DataField="RegNo" SortExpression="RegNo" HeaderText="Registration No"></asp:BoundField>
                <asp:BoundField DataField="PayID" SortExpression="PayID" HeaderText="Yearly No"></asp:BoundField>
                <asp:BoundField DataField="RadiologyName" HeaderText="Test Name" SortExpression="RadiologyName" />
                <asp:BoundField DataField="Date" HeaderText="Date of Reg." SortExpression="Date" />
                <asp:BoundField DataField="Time" HeaderText="Time of Reg." SortExpression="Time" />
                <asp:BoundField DataField="Fee" SortExpression="Fee" HeaderText="Fee (Rs.)"></asp:BoundField>
                <asp:TemplateField HeaderText="Discount (Rs.)" Visible="False">
                  <ItemTemplate> &nbsp;
                    <asp:TextBox id="TextBox_Discount" runat="server" Width="36px" >0</asp:TextBox>
                    <asp:HiddenField id="HiddenFieldPrice" runat="server" Value='<%# Eval("Fee", "{0}") %>'></asp:HiddenField>
                    <asp:HiddenField id="HiddenField_RID" runat="server" Value='<%# Bind("RID", "{0}") %>'></asp:HiddenField>
                    </ItemTemplate>
                    </asp:TemplateField>
                <asp:BoundField DataField="RID" HeaderText="RID" SortExpression="RID" Visible="False" />
                </Columns>
              <RowStyle CssClass="GridItem"></RowStyle>
              <HeaderStyle CssClass="GridHeader"></HeaderStyle>
              <AlternatingRowStyle CssClass="GridAltItem"></AlternatingRowStyle>
              </asp:GridView></td>
                </tr>
          <tr>
            <td height="25" align="center"
                    valign="middle" style="width: 936px"><span  style="text-align: center; width: 922px; height: 13px;"><br />
              Grand Discount :
              <asp:TextBox ID="TextBox_Grand_discount" runat="server" AutoPostBack="True" Width="113px" BackColor="#FFFFFF" >0</asp:TextBox>
                        <asp:DropDownList ID="DropDownList_Discount_Type" runat="server" AutoPostBack="True">
                            <asp:ListItem>Rs.</asp:ListItem>
                            <asp:ListItem>%age</asp:ListItem>
                        </asp:DropDownList>
                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; Grand Total :&nbsp;
              <asp:TextBox ID="TextBox_Grand_total" runat="server" ReadOnly="True" Width="113px" BackColor="#FFFFFF"></asp:TextBox>
              Rs.</span></td>
                </tr>
          <tr>
            <td align="center" height="25" style="width: 936px" valign="middle">              <asp:Label ID="Label_Message" runat="server" ForeColor="Red" Width="312px"></asp:Label></td>
                </tr>
          <tr>
            <td align="center"
                    valign="top" style="width: 936px; height: 35px;" dir="ltr"><span  style="text-align: center; width: 922px; height: 13px;">
              <br />
              <asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT Pt_Radiology_LabTest.RegNo, Pt_Radiology_LabTest.PayID, CONVERT (varchar, Pt_Radiology_LabTest.DateTime, 107)  as Date ,  CONVERT (varchar, Pt_Radiology_LabTest.DateTime, 108) AS [Time], Pt_Radiology_LabTest.RID, Radiology.RadiologyName, Radiology.Fee, Pt_Radiology_LabTest.PRadiologyID FROM Pt_Radiology_LabTest INNER JOIN Radiology ON Pt_Radiology_LabTest.RID = Radiology.RID WHERE (Pt_Radiology_LabTest.PayID = @YearlyNo) AND (Pt_Radiology_LabTest.RegNo = @RegNo) AND (Pt_Radiology_LabTest.Status = 'Not Done')" insertcommand="INSERT INTO Pt_Radiology_for_MRI(Reg_No, Yearly_No, RID, total_fee, Discount, fee_paid, Main_ID) VALUES (@Reg_No, @Yearly_No, @RID, @total_fee, @Discount, @fee_paid, @main_id)" DeleteCommand="DELETE FROM PatientsLabTest WHERE (PTestID = @PTestID)">
                <SelectParameters>
                  <asp:SessionParameter SessionField="YearlyNo" Name="YearlyNo"></asp:SessionParameter>
                  <asp:SessionParameter SessionField="RegistrationNo" Name="RegNo"></asp:SessionParameter>
                  </SelectParameters>
                <InsertParameters>
                  <asp:SessionParameter SessionField="RegistrationNo" Name="Reg_No"></asp:SessionParameter>
                  <asp:SessionParameter SessionField="YearlyNo" Name="Yearly_No"></asp:SessionParameter>
                  <asp:ControlParameter PropertyName="Value" Name="RID" ControlID="HiddenField_Radiology_ID"></asp:ControlParameter>
                  <asp:ControlParameter PropertyName="Value" Name="total_fee" ControlID="HiddenField_Total_Fee"></asp:ControlParameter>
                  <asp:ControlParameter PropertyName="Value" Name="Discount" ControlID="HiddenField_Discount"></asp:ControlParameter>
                  <asp:ControlParameter PropertyName="Value" Name="fee_paid" ControlID="HiddenField_Fee_Paid"></asp:ControlParameter>
                  <asp:ControlParameter ControlID="HiddenFieldMain_ID" Name="main_id" PropertyName="Value" />
                  </InsertParameters>
                <DeleteParameters>
                  <asp:ControlParameter ControlID="GridView5" Name="PTestID" PropertyName="SelectedValue" />
                  </DeleteParameters>
                </asp:SqlDataSource>
              <asp:HiddenField ID="HiddenField_Appointment_Date" runat="server" />
              <asp:HiddenField ID="HiddenFieldAppointment_Time" runat="server" />
              <asp:HiddenField ID="HiddenField_Report_Date" runat="server" />
              <asp:HiddenField ID="HiddenField_Radiology_ID" runat="server" />
              <asp:HiddenField ID="HiddenField_Total_Fee" runat="server" />
              <asp:HiddenField ID="HiddenField_Discount" runat="server" />
              <asp:HiddenField ID="HiddenField_Fee_Paid" runat="server" />
              <asp:HiddenField ID="HiddenFieldMain_ID" runat="server" />
              <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString12 %>"
                    InsertCommand="INSERT INTO MRI_Finance(Main_ID, TOtal_Discount, Total_Paid, Total_AMount) VALUES (@Main_ID, @TOtal_Discount, @Total_Paid, @Total_AMount)"
                    ProviderName="<%$ ConnectionStrings:LGHConnectionString12.ProviderName %>" SelectCommand="SELECT     Pt_Radiology_LabTest.RegNo, Pt_Radiology_LabTest.PayID, CONVERT(varchar, Pt_Radiology_LabTest.DateTime, 107) AS Date, CONVERT(varchar, 
                      Pt_Radiology_LabTest.DateTime, 108) AS Time, Pt_Radiology_LabTest.RID, Radiology.RadiologyName, Radiology.Fee
FROM         Pt_Radiology_LabTest INNER JOIN
                      Radiology ON Pt_Radiology_LabTest.RID = Radiology.RID
WHERE     (Pt_Radiology_LabTest.PayID = @YearlyNo) AND (Pt_Radiology_LabTest.RegNo = @RegNo) AND (Pt_Radiology_LabTest.Status = 'Not Done')
">
                <SelectParameters>
                  <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                  <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                  </SelectParameters>
                <InsertParameters>
                  <asp:ControlParameter ControlID="HiddenFieldMain_ID" Name="Main_ID" PropertyName="Value" />
                  <asp:ControlParameter ControlID="HiddenField2" Name="TOtal_Discount" PropertyName="Value" />
                  <asp:ControlParameter ControlID="HiddenField3" Name="Total_Paid" PropertyName="Value" />
                  <asp:ControlParameter ControlID="HiddenField1" Name="Total_AMount" PropertyName="Value" />
                  </InsertParameters>
                </asp:SqlDataSource>
              <asp:HiddenField ID="HiddenField1" runat="server" />
              <asp:HiddenField ID="HiddenField3" runat="server" />
              <asp:HiddenField ID="HiddenField2" runat="server" />
              <asp:SqlDataSource ID="SqlDataSource_aPPONTMENT" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString12 %>"
                    InsertCommand="INSERT INTO MRI_Save_Patient_Next_App(Reg_no, Yearly_No, Next_App_Date, Next_App_Time, Report_Deliverd) VALUES (@Reg_no, @Yearly_No, @Next_App_Date, @Next_App_Time, @Report_Deliverd)"
                    ProviderName="<%$ ConnectionStrings:LGHConnectionString12.ProviderName %>" SelectCommand="SELECT     Pt_Radiology_LabTest.RegNo, Pt_Radiology_LabTest.PayID, CONVERT(varchar, Pt_Radiology_LabTest.DateTime, 107) AS Date, CONVERT(varchar, 
                      Pt_Radiology_LabTest.DateTime, 108) AS Time, Pt_Radiology_LabTest.RID, Radiology.RadiologyName, Radiology.Fee
FROM         Pt_Radiology_LabTest INNER JOIN
                      Radiology ON Pt_Radiology_LabTest.RID = Radiology.RID
WHERE     (Pt_Radiology_LabTest.PayID = @YearlyNo) AND (Pt_Radiology_LabTest.RegNo = @RegNo) AND (Pt_Radiology_LabTest.Status = 'Not Done')
">
                <SelectParameters>
                  <asp:SessionParameter SessionField="YearlyNo" Name="YearlyNo"></asp:SessionParameter>
                  <asp:SessionParameter SessionField="RegistrationNo" Name="RegNo"></asp:SessionParameter>
                  </SelectParameters>
                <InsertParameters>
                  <asp:SessionParameter SessionField="RegistrationNo" Name="Reg_no"></asp:SessionParameter>
                  <asp:SessionParameter SessionField="YearlyNo" Name="Yearly_No"></asp:SessionParameter>
                  <asp:ControlParameter PropertyName="Value" Name="Next_App_Date" ControlID="HiddenField_Appointment_Date"></asp:ControlParameter>
                  <asp:ControlParameter PropertyName="Value" Name="Next_App_Time" ControlID="HiddenFieldAppointment_Time"></asp:ControlParameter>
                  <asp:ControlParameter PropertyName="Value" Name="Report_Deliverd" ControlID="HiddenField_Report_Date"></asp:ControlParameter>
                  </InsertParameters>
                </asp:SqlDataSource>
              <span style="height: 390px">
                <asp:Button ID="ButtonSave" runat="server" Text="Submit" UseSubmitBehavior="False" width="150px" />                <asp:Button ID="ButtonReport" runat="server" Text="View Report" UseSubmitBehavior="False" width="150px" Visible="False" />  </span></span></td>
                </tr>
          <tr>
            <td valign="top" style="width: 936px; height: 160px;"><table width="100%" border="0" cellpadding="0" cellspacing="0"    style="visibility: hidden">
              <!--DWLayoutTable-->
              <tr>
                <td style="height: 23px" width="183"></td>
                      <td colspan="2" style="height: 23px; text-align: left"></td>
                      <td style="height: 23px; text-align: left" width="418"></td>
                    </tr>
              <tr>
                <td width="183"  style="height: 42px" >&nbsp;Appointment Date&nbsp; : &nbsp;</td>
                      <td style="height: 42px; text-align: left; width: 198px;">&nbsp;</td>
                      <td  style="height: 42px; width: 172px;"> Appointment Time :&nbsp; </td>
                      <td width="418" style="height: 42px; text-align: left;"><igtxt:webdatetimeedit id="WebDateTimeEdit1" runat="server" DataMode="EditModeText" DisplayModeFormat="t" Nullable="False" EditModeFormat="t" Width="146px"></igtxt:webdatetimeedit>                      </td>
                    </tr>
              <!--DWLayoutTable-->
              <tr>
                <td width="183"  style="height: 23px"> Report After Test&nbsp; :&nbsp; </td>
                      <td  style="height: 23px; text-align: left; width: 198px;"><asp:TextBox ID="TextBox_next_Date" runat="server" Width="146px">4</asp:TextBox>
                        Days</td>
                      <td align="right" valign="middle"  style="width: 172px"> Grand Discount :&nbsp; </td>
                      <td style="height: 23px; text-align: left" width="418">&nbsp;<span >Rs.</span></td>
                    </tr>
              <tr>
                <td width="183"  style="height: 26px"> Description :&nbsp;</td>
                      <td style="height: 26px; text-align: left; width: 198px;"><asp:TextBox ID="TextBoxDescription" runat="server" Width="146px"></asp:TextBox></td>
                      <td align="right" valign="middle"  style="width: 172px" >&nbsp;</td>
                      <td align="left"  ><asp:TextBox ID="TextBox_Amount" runat="server" BorderStyle="None" ReadOnly="True"
                            Width="146px" Visible="False"></asp:TextBox>                      </td>
                    </tr>
              <tr>
                <td  style="height: 26px" width="183">&nbsp;</td>
                      <td align="left"  ><asp:TextBox ID="TextBox_Total_Discount" runat="server" BorderStyle="None" ReadOnly="True"
                            Width="146px" Visible="False"></asp:TextBox></td>
                      <td align="right" valign="middle"  style="width: 172px" ><strong>&nbsp;</strong> </td>
                      <td align="left"  ><asp:TextBox ID="TextBox_Total_Recieve" runat="server" BorderStyle="None" ReadOnly="True"
                            Width="146px" Visible="False"></asp:TextBox>                      </td>
                    </tr>
              <tr>
                <td align="center" colspan="4" style="text-align: left; height: 19px;" valign="middle"><asp:RangeValidator ControlToValidate="TextBox_next_Date" CssClass="text_lables_login"
                            Display="Dynamic" ErrorMessage="Enter Correct Days" ID="RangeValidator_days" MaximumValue="100" MinimumValue="0" runat="server"
                            Type="Integer"></asp:RangeValidator>
                  &nbsp;&nbsp; </td>
                    </tr>
              </table></td>
                </tr>
          <tr>
            <td ></td>
                </tr>
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          </table></td>
          </tr>
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
    </table></td>
    <td rowspan="2" valign="top" class="right_border" style="width: 33px" ><img src="images1/img_border_right.gif" width="23" height="15" alt="" /></td>
  </tr>
  <tr>
    <td height="0"></td>
  </tr>
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_bottom.gif" width="1003" height="24" alt="" /></td>
  </tr>
</table>
<script type="text/javascript" src="images1/flash_01.js"></script>
</form>
</body>
</html>