<%@ page language="VB" autoeventwireup="false" inherits="Admin_presenting_complaint, App_Web_rbfdm1yf" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
 <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="Paragma" content="no-cache"/>

<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
<script type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
function CheckBodyPart(a)
    {
    var a = document.getElementById("DropDownListComplaint").selectedIndex
    //alert(a+"SD")
    //alert(document.getElementById ("DropDownListComplaint").options[a].text+ "Hello1");
    //if (document.getElementById ("DropDownListComplaint").value== " ")
    if(document.getElementById ("DropDownListComplaint").options[a].text == "")//|| (document.getElementById ("DropDownListDuration").value == "") || ( document.getElementById ("TextBoxDuration").value == ""))
    {
    alert("Select The Compalaint Name ");
    return false;
       }
     if ((document.getElementById ("DropDownListDuration").value == "") || ( document.getElementById ("TextBoxDuration").value == ""))// || (document.getElementById ("DropDownListComplaint").value == ""))
       {
        alert("Enter Duration and Duration Time");
       return false;
       }
   
}

//-->
</script>
</head>

<body onload="MM_preloadImages('images1/img_btn_over.gif')" dir="ltr">
<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_top.gif" alt="" width="1003" height="24" /></td>
  </tr>
  
  
  <tr>
    <td width="23" height="478" valign="top" class="left_border"><img src="images1/img_border_left.gif" alt="" width="23" height="15" /></td>
    <td width="957" valign="top">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <!--DWLayoutTable-->
        <tr>
          <td height="73" colspan="2" valign="bottom" bgcolor="#F4F4F4" ><iframe 
      src="tabs.aspx" name="holder" width="957" marginwidth="0" height="215" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
        </tr>
        
        
        <tr>
          <td width="19" height="25" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="938" valign="middle" class="text_lables3" ><span style="font-size: 15pt; font-family: Arial">Presenting Complaints </span></td>
          </tr>
        <tr><div id ="a1" runat ="server">
          <td></td>
        <tr>
          <td height="277" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
            <!--DWLayoutTable-->
            <tr>
              <td width="20" rowspan="4" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td width="913" height="19" valign="top" style="height: 10px; text-align: center;"><img src="images1/img_spacer2.gif" width="2" height="10" />
                      <asp:Label ID="Label_message" runat="server" ></asp:Label></td>
                  <td width="20" rowspan="4" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td width="4">&nbsp;</td>
              </tr>
            <tr>
              <td height="198" valign="top">
			  
			  <table>
                <!--DWLayoutTable-->
                  <tr>
                      <td  style="height: 15px">
                      </td>
                      <td  style="height: 15px">
                          &nbsp;Add New Complaint :</td>
                      <td  style="height: 15px">
                          <asp:TextBox ID="TextBox_Presenting_Complaint" runat="server" Width="180px"></asp:TextBox></td>
                      <td  style="height: 15px">
                          </td>
                      <td  style="height: 15px">
                      </td>
                  </tr>
                  <tr>
                      <td>
                      </td>
                      <td >
                          </td>
                      <td  colspan="3">
                          </td>
                  </tr>
                <tr>
                  <td >&nbsp; &nbsp; &nbsp; </td>
                  <td ><strong ></strong></td>
                  <td >
                      <asp:Button ID="Button_Save_2" runat="server" Text="Save" Width="96px" /></td>
                  <td ></td>
                  <td ></td>
                </tr>
                  <tr>
                      <td style="height: 23px">
                      </td>
                      <td style="height: 23px">
                      </td>
                      <td style="height: 23px">
                      </td>
                      <td style="height: 23px">
                      </td>
                      <td style="height: 23px">
                      </td>
                  </tr>
                <tr>
                  <td  ></td>
                  <td  >
                      Select Complaint :</td>
                  <td dir="ltr"  >
                      <asp:DropDownList ID="DropDownList_Complaint" runat="server" DataSourceID="SqlDataSourceComplaint"
                          DataTextField="Complaint_Name" DataValueField="Complaint_ID" Width="186px">
                      </asp:DropDownList></td>
                  <td  ></td>
                  <td  ></td>
                </tr>
                  <tr>
                      <td >
                      </td>
                      <td >
                          Select Body Part :</td>
                      <td  colspan="3" dir="ltr">
                          <asp:CheckBoxList ID="CheckBoxList1" runat="server" DataSourceID="SqlDataSourceBodyPart"
                              DataTextField="pt_Main_Body_Part" DataValueField="pt_Main_Body_Part_ID" Width="710px" RepeatColumns="4" RepeatDirection="Horizontal">
                          </asp:CheckBoxList></td>
                  </tr>
                  <tr>
                      <td >
                      </td>
                      <td >
                      </td>
                      <td  colspan="3" dir="ltr">
                          <asp:Button ID="Button_Save" runat="server" Text="Save" Width="96px" /></td>
                  </tr>
              </table></td>
                <td>&nbsp;</td>
              </tr>
            <tr>
              <td height="71" valign="top"><span style="height: 324px">&nbsp;</span><span style="vertical-align: top; width: 908px; height: 538px; text-align: center"><asp:SqlDataSource ID="SqlDataSourceComplaint" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT Complaint_Name, Complaint_ID FROM Pt_Presenting_Complaint ORDER BY Pirority" InsertCommand="INSERT INTO Pt_Presenting_Complaint(Complaint_Name) VALUES (@Complaint_Name)"> 
                  <InsertParameters>
                      <asp:ControlParameter ControlID="TextBox_Presenting_Complaint" Name="Complaint_Name"
                          PropertyName="Text" />
                  </InsertParameters>
              </asp:SqlDataSource>
                  &nbsp;
              <asp:SqlDataSource ID="SqlDataSourceBodyPart" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT pt_Main_Body_Part_ID, pt_Main_Body_Part FROM Pt_Main_Body_Part ORDER BY Pirority">
              </asp:SqlDataSource>
              <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                InsertCommand="INSERT INTO pt_BodyPart_Maintain(Complain_Id, Pt_Main_Body_Part) VALUES (@Complain_Id, @Pt_Main_Body_Part)"
                ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>">
                  <InsertParameters>
                      <asp:ControlParameter ControlID="DropDownList_Complaint" Name="Complain_Id" PropertyName="SelectedValue" />
                      <asp:ControlParameter ControlID="HiddenFieldBodyPart" Name="Pt_Main_Body_Part" PropertyName="Value" />
                  </InsertParameters>
              </asp:SqlDataSource>
              <asp:HiddenField ID="HiddenFieldComplaint" runat="server" />
              <asp:HiddenField ID="HiddenFieldBodyPart" runat="server" />
              <asp:HiddenField ID="HiddenFieldSide" runat="server" />
              <asp:HiddenField ID="HiddenFieldZone" runat="server" />
              <asp:HiddenField ID="HiddenFieldDuration" runat="server" />
              <asp:HiddenField ID="HiddenFieldDurationTime" runat="server" />
              </span></td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td height="21">&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            
            
            
            
            
            
              <asp:HiddenField ID="HiddenFieldToolTIp" runat="server" Value="true" /><asp:HiddenField ID="HiddenField1" runat="server" Value="true" />
            
            
            
            </table></td>
          <!-- </div>-->
          </tr>
          </table></td>
    <td width="33" valign="top" class="right_border" style="width: 33px"><img src="images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_bottom.gif" alt="" width="1003" height="24" /></td>
  </tr>
</table>



</form>
     
          
       
      
      
      
      
      
      
      
      
      
      
      
      
      
   
    
</body>
</html>