<%-- Author name Imran Ahmed Awan --%>
<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Report_Reciver.aspx.vb" Inherits="Report_Reciver" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
    <script language ="javascript" type ="text/javascript" >
    function Check_Validates()
    {
    
    ////////////////////////////  Receiver Name validation ///////////////////////
    
        if(document.getElementById("textboxrfname").value.length==0)
        {
        alert("Enter Receiver First Name");
        document.getElementById("textboxrfname").focus();
        return false;
        }
//        if(document.getElementById("textboxrmname").value.length==0)
//        {
//        alert("Enter Receiver Middle Name");
//        document.getElementById("textboxrmname").focus();
//        return false;
//        }
        //if(document.getElementById("textboxrlname").value.length==0)
        //{
        //alert("Enter Receiver Last Name");
        //document.getElementById("textboxrlname").focus();
        //return false;
        //}
        if(document.getElementById("textboxrfname").value -0 ==document.getElementById("textboxrfname").value)
        {
        alert("Enter the Correct Patient First Name");
        document.getElementById("textboxrfname").focus();
        return false;
        }
//        if(document.getElementById("textboxrmname").value-0==document.getElementById("textboxrmname").value)        
//        {
//        alert("Enter the Correct Patient First Name");
//        document.getElementById("textboxrmname").focus();
//        return false;
//        }
        
        /////////////////////// Receiver Relative Mame Validation ////////////////// 
        
        if(document.getElementById("textboxrffname").value.length==0)
        {
        alert("Enter Receiver Relative First Name");
        document.getElementById("textboxrffname").focus();
        return false;
        }
//        if(document.getElementById("textboxrfmname").value.length==0)
//        {
//        alert("Enter Receiver Relative Middle Name");
//        document.getElementById("textboxrfmname").focus();
//        return false;
//        }
        //if(document.getElementById("textboxrflname").value.length==0)
        //{
        //alert("Enter Receiver Last Name");
        //document.getElementById("textboxrflname").focus();
        //return false;
        //}
        if(document.getElementById("textboxrffname").value -0 ==document.getElementById("textboxrffname").value)
        {
        alert("Enter the Correct Patient First Name");
        document.getElementById("textboxrffname").focus();
        return false;
        }        
        /////////////////////// Receiver Comptuerized National ID card Validation ////////////////// 
        
        if((document.getElementById("TextBox_RCINIC1").value.length !=0) || (document.getElementById("TextBox_RCNIC2").value.length !=0) || (document.getElementById("TextBox_RCINC3").value !=0))
            {
            if(document.getElementById("TextBox_RCINIC1").value -0 !=document.getElementById("TextBox_RCINIC1").value) 
                 {
                 alert("Enter the Correct Patient Computerized National ID");
                 document.getElementById("TextBox_RCINIC1").focus();
                 return false;
                 } 
            if(document.getElementById("TextBox_RCINIC1").value.length !=5) 
                 {
                 alert("Enter the Correct Patient Computerized National ID");
                 document.getElementById("TextBox_RCINIC1").focus();
                 return false;
                 }         
           if(document.getElementById("TextBox_RCNIC2").value -0 !=document.getElementById("TextBox_RCNIC2").value)
                 {
                 alert("Enter the Correct Patient Computerized National ID");
                 document.getElementById("TextBox_RCNIC2").focus();
                 return false;
                 } 
           if(document.getElementById("TextBox_RCNIC2").value.length !=7)
                 {
                 alert("Enter the Correct Patient Computerized National ID");
                 document.getElementById("TextBox_RCNIC2").focus();
                 return false;
                 }         
           if(document.getElementById("TextBox_RCINC3").value -0 !=document.getElementById("TextBox_RCINC3").value)
                 {
                 alert("Enter the Correct Patient Computerized National ID");
                 document.getElementById("TextBox_RCINC3").focus();
                 return false;
                 } 
          if(document.getElementById("TextBox_RCINC3").value.length !=1)
                 {
                 alert("Enter the Correct Patient Computerized National ID");
                 document.getElementById("TextBox_RCINC3").focus();
                 return false;
                 } 
          }    
    }
    
    </script>

</head>

<body>
<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_top.gif" width="1003" height="24"  alt="" /></td>
  </tr>
  <tr>
    <td width="23" height="634" valign="top" class="left_border"><img src="images1/img_border_left.gif" width="23" height="15"  alt="" /></td>
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
                Report Delivered</td>
          </tr>
      <tr>
        <td height="452" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="mainframe_bg1">
          <!--DWLayoutTable-->
          <tr>
            <td width="20" rowspan="6" valign="top"><img src="images1/img_spacer.gif" width="20" height="2"  alt="" /></td>
                  <td width="917" height="10" valign="top"><img src="images1/img_spacer2.gif" width="2" height="10"  alt="" /></td>
                  <td width="20" rowspan="6" valign="top"><img src="images1/img_spacer.gif" width="20" height="2"  alt="" /></td>
                </tr>
          <tr>
            <td height="35" valign="top"><asp:GridView ID="GridView_MRI" runat="server" AutoGenerateColumns="False"
            DataKeyNames="PRadiologyID" DataSourceID="SqlDataSource_Grid" EmptyDataText="sdfsadfasdfasdf"
            Width="100%" >
              <Columns>
              <asp:BoundField DataField="RegNo" SortExpression="RegNo" HeaderText="Registration No."></asp:BoundField>
              <asp:BoundField DataField="PayID" SortExpression="PayID" HeaderText="Yearly No."></asp:BoundField>
              <asp:BoundField DataField="RSGName" SortExpression="RSGName" HeaderText="Group Name" Visible="False"></asp:BoundField>
              <asp:BoundField DataField="RadiologyName" SortExpression="RadiologyName" HeaderText="Area of Scan"></asp:BoundField>
              <asp:BoundField ReadOnly="True" DataField="PRadiologyID" InsertVisible="False" SortExpression="PRadiologyID" HeaderText="PRadiologyID" Visible="False"></asp:BoundField>
              <asp:BoundField DataField="RID" SortExpression="RID" HeaderText="RID" Visible="False"></asp:BoundField>
              <asp:TemplateField>
                <ItemTemplate>
                  <asp:CheckBox ID="CheckBox1" runat="server" />            
                  <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("RID", "{0}") %>' />
                </ItemTemplate>
              </asp:TemplateField>
              </Columns>
              <HeaderStyle CssClass="GridHeader"></HeaderStyle>
              <AlternatingRowStyle CssClass="GridAltItem"></AlternatingRowStyle>
            </asp:GridView>
              <asp:SqlDataSource ID="SqlDataSource_Grid" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
            ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT     RadiologySubGroup.RSGName, Radiology.RadiologyName, Pt_Radiology_LabTest.PayID, Pt_Radiology_LabTest.PRadiologyID, 
                      Pt_Radiology_LabTest.RID, Pt_Radiology_LabTest.RegNo
FROM         Radiology INNER JOIN
                      Pt_Radiology_LabTest ON Radiology.RID = Pt_Radiology_LabTest.RID INNER JOIN
                      RadiologySubGroup ON Radiology.RSGID = RadiologySubGroup.RSGID 
 WHERE (Pt_Radiology_LabTest.PayID = @PayID) AND (Pt_Radiology_LabTest.RegNo = @RegNo) AND (Pt_Radiology_LabTest.Status = 'Done')
">
                <SelectParameters>
                  <asp:QueryStringParameter Name="PayID" QueryStringField="PayID" />
                  <asp:QueryStringParameter Name="RegNo" QueryStringField="RegNo" />
                </SelectParameters>
              </asp:SqlDataSource>
              <asp:HiddenField ID="HiddenFieldRID" runat="server" />
              <br /></td>
                </tr>
          <tr>
            <td height="114" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0"  >
                <!--DWLayoutTable-->
                <tr>
                  <td width="175" height="5"></td>
                  <td width="250"></td>
                  <td width="175"></td>
                  <td width="309"></td>
                  <td width="9"></td>
                </tr>
                <tr>
                  <td height="25" align="right" valign="middle" ><span class="MsoNormal" style="margin: 0in 0in 0pt">Receiver First Name :&nbsp;</span></td>
                  <td valign="middle"><span style="width: 163px; height: 25px">
                    <asp:TextBox ID="TextBoxRFName" runat="server" TabIndex="1"></asp:TextBox>
                  </span></td>
                  <td align="right" valign="middle" ><span style="width: 194px; height: 26px">Relation First Name :&nbsp;</span></td>
                  <td colspan="2" valign="middle"><span style="width: 163px; height: 26px">
                    <asp:TextBox ID="TextBoxRFFName" runat="server" TabIndex="7"></asp:TextBox>
                  </span></td>
                </tr>
                <tr>
                  <td height="25" align="right" valign="middle" ><span style="width: 200px; height: 25px">Receiver Last Name :&nbsp;</span></td>
                  <td valign="middle"><span style="width: 161px; height: 25px">
                    <asp:TextBox ID="TextBoxRMName" runat="server" TabIndex="2"></asp:TextBox>
                  </span></td>
                  <td align="right" valign="middle" ><span  style="text-align: right"><strong>Relation Last Name :</strong>&nbsp;</span></td>
                  <td colspan="2" valign="middle"><span style="width: 161px; height: 26px">
                    <asp:TextBox ID="TextBoxRFMName" runat="server" TabIndex="8"></asp:TextBox>
                  </span></td>
                </tr>
                <tr>
                  <td height="25" align="right" valign="middle" ><span class="text_boxtitle">CNIC No.  :&nbsp;</span></td>
                  <td valign="middle"><span style="width: 163px; height: 22px">
                    <asp:TextBox ID="TextBox_RCINIC1" runat="server" MaxLength="5" Width="35px" TabIndex="3"></asp:TextBox>
                    -
                    <asp:TextBox
                        ID="TextBox_RCNIC2" runat="server" MaxLength="7" Width="55px" TabIndex="4"></asp:TextBox>
                    -
                    <asp:TextBox
                            ID="TextBox_RCINC3" runat="server" MaxLength="1" Width="20px" TabIndex="5"></asp:TextBox>
                  </span></td>
                  <td align="right" valign="middle" ><strong>Description :&nbsp;</strong></td>
                  <td rowspan="2" valign="top"><span style="width: 163px; height: 26px">
                    <asp:TextBox ID="TextBoxDescription" runat="server" TextMode="MultiLine" Width="148px" TabIndex="9"></asp:TextBox>
                  </span></td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td height="25" align="right" valign="middle" ><span class="text_boxtitle">Relation :&nbsp;</span></td>
                  <td valign="middle"><asp:RadioButtonList ID="RadioButtonList_Relation" runat="server" CssClass="text_titles_bold"
                            Height="1px" RepeatDirection="Horizontal" Width="153px" TabIndex="6">
                    <asp:ListItem Selected="True">S/O</asp:ListItem>
                    <asp:ListItem>D/O</asp:ListItem>
                    <asp:ListItem>W/O</asp:ListItem>
                  </asp:RadioButtonList></td>
                  <td align="right" valign="middle" ><!--DWLayoutEmptyCell-->&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td height="7"></td>
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                </tr>
                        </table></td>
            </tr>
          <tr>
            <td height="13" align="right" valign="top"><span style="width: 895px"><img src="images1/img_shedow.gif" width="249" height="13"  alt="" /></span></td>
            </tr>
          <tr>
            <td height="35" align="center" valign="middle"><span style="height: 51px">
              <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>" ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" UpdateCommand="UPDATE Pt_Radiology_LabTest SET Status = @Status WHERE (PayID = @Payid) AND (RegNo = @regno) AND (RID = @rid)">
                <UpdateParameters>
                  <asp:Parameter DefaultValue="Delivered" Name="Status" />
                  <asp:QueryStringParameter DefaultValue="" Name="Payid" QueryStringField="Payid" />
                  <asp:QueryStringParameter Name="regno" QueryStringField="RegNo" />
                  <asp:ControlParameter ControlID="HiddenFieldRID" Name="rid" PropertyName="Value" />
                </UpdateParameters>
              </asp:SqlDataSource>
              <asp:Button ID="ButtonSave" runat="server" Text="Save"  Width="150px" TabIndex="10" />              
            </span></td>
            </tr>
          <tr>
            <td height="245" valign="top"><asp:TextBox ID="TextBoxRLName" runat="server" Visible="False"></asp:TextBox>
              <asp:TextBox ID="TextBoxRFLName" runat="server" Visible="False"></asp:TextBox></td>
          </tr>
          
          
          
          
          
          
          
          

          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          </table></td>
          </tr>
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
    </table></td>
    <td width="32" valign="top" class="right_border" ><img src="images1/img_border_right.gif" width="23" height="15"  alt="" /></td>
  </tr>
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_bottom.gif" width="1003" height="24"  alt="" /></td>
  </tr>
</table>
<script type="text/javascript" src="images1/flash_01.js"></script>
</form>
</body>
</html>