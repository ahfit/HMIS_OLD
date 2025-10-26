<%@ page language="VB" autoeventwireup="false" inherits="Registration, App_Web_ah1wcbj4" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
<link href="images/employee.css" rel="stylesheet" type="text/css" />
<script language="javascript">
function openthis(a)
{
 window.location=a;
 }
 function validate()
 {
    if (document.getElementById("TextBox_employeeName").value == "")
    {
        document.getElementById("HiddenField_status").value = false; 
        alert("Enter Applicant Name")
    }  
    if(document.getElementById("TextBox_father_Name").value == "" )
    {
        document.getElementById("HiddenField_status").value = false; 
        alert("Enter Applicant Father Name")
    }
    if(document.getElementById("TextBox_address").value == "" )
    {
        document.getElementById("HiddenField_status").value = false; 
        alert("Enter Applicant Address")
    }
 
   
     if(document.getElementById("TextBox_email").value == "" )
    {
        document.getElementById("HiddenField_status").value = false; 
    alert("Enter Applicant Email Address")
    }
    if(document.getElementById("TextBox_passward").value == "" )
    {
        document.getElementById("HiddenField_status").value = false; 
        alert("Enter Password")
    
    }
     
 
 
 }
</script>

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
        <td height="65" colspan="2" valign="top"><iframe 
      src="tabs.aspx" name="holder" width="957" marginwidth="0" height="157" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
      </tr>
      <tr>
        <td width="19" height="25" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td width="938" valign="middle" class="text_lables3">Personal Information 
            <asp:SqlDataSource ID="SqlDataSource_JOB" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>" DeleteCommand="DELETE FROM [Employee_Basic_info] WHERE [Employee_ID] = @Employee_ID" InsertCommand="INSERT INTO [Employee_Basic_info] ( [Employee_Name], [Father_Name], [Date_of_Birth], [NIC_No], [Gender],[Martial_Status], [Address], [City], [Province], [Postal_Code], [Country], [Nationality], [Telephone], [Mobile], [Fax], [Company], [Company_URL], [Personal_URL], [Passport], [Domicile], [Email], [Password]) VALUES ( @Employee_Name, @Father_Name, @Date_of_Birth, @NIC_No, @Gender,@Martial_Status, @Address, @City, @Province, @Postal_Code, @Country, @Nationality, @Telephone, @Mobile, @Fax, @Company, @Company_URL, @Personal_URL, @Passport, @Domicile, @Email, @Password)" SelectCommand="SELECT [Employee_ID], [Employee_Name], [Father_Name], [Date_of_Birth], [NIC_No], [Gender], [Address], [City], [Province], [Postal_Code], [Country], [Nationality], [Telephone], [Mobile], [Fax], [Company], [Company_URL], [Personal_URL], [Passport], [Domicile], [Email], [Password] FROM [Employee_Basic_info]">
              <DeleteParameters>
                <asp:Parameter Name="Employee_ID" Type="Int32" />
              </DeleteParameters>
              <InsertParameters>
                <asp:ControlParameter ControlID="TextBox_employeeName" Name="Employee_Name" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_father_Name" Name="Father_Name" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="HiddenField_Date_of_Birth" Name="Date_of_Birth"
                    PropertyName="Value" Type="DateTime" />
                <asp:ControlParameter ControlID="HiddenField_nic" Name="NIC_No" PropertyName="Value"
                    Type="String" />
                <asp:ControlParameter ControlID="DropDownList_gender" Name="Gender" PropertyName="SelectedValue"
                    Type="String" />
                  <asp:ControlParameter ControlID="DropDownList_status" Name="Martial_Status"
                      PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="TextBox_address" Name="Address" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_city" Name="City" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="TextBox_province" Name="Province" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_postal_Code" Name="Postal_Code" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="DropDownList_country" Name="Country" PropertyName="SelectedValue"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_nationality" Name="Nationality" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_telephone" Name="Telephone" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_mobile" Name="Mobile" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_fax" Name="Fax" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="TextBox_company" Name="Company" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_company_URL" Name="Company_URL" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_Personal_URL" Name="Personal_URL" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_passport" Name="Passport" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_domicile" Name="Domicile" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_email" Name="Email" PropertyName="Text"
                    Type="String" />
                  <asp:ControlParameter ControlID="TextBox_passward" Name="Password" PropertyName="Text" />
              </InsertParameters>
            </asp:SqlDataSource>
              &nbsp;
          </td>
        </tr>
      <tr>
        <td height="462" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
          <!--DWLayoutTable-->
          <tr>
            <td width="20" rowspan="4" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td width="917" height="10" valign="top"><img src="images1/img_spacer2.gif" width="2" height="10" /></td>
                <td width="20" rowspan="4" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                </tr>
          <tr>
            <td height="10"></td>
            </tr>
          <tr>
            <td height="765" valign="top">   <fieldset class="fieldset1">
  <legend>New Registration</legend>
  <ol>
<div align="right" style="margin-right:35px;"><asp:ImageButton ID="ImageButton_image" runat="server" Height="87px" Width="82px" /></div>
          
   
          <li><label>Attach Applicant Picture&nbsp;:</label><asp:FileUpload
      ID="FileUpload_image" runat="server" Width="178" /><asp:Button ID="Button_attach" runat="server" CssClass="bt1up"
          Text="Attach" /></li>
          
          <li><label>
              Applicant Name&nbsp;:</label><asp:TextBox ID="TextBox_employeeName" runat="server" CssClass="textbox_normal"  Width="250px" onactivate="this.className='textbox_focus';" ondeactivate="this.className='textbox_normal';"></asp:TextBox>&nbsp;
          </li>
          
          
          
          
          <li><label>Father Name&nbsp;:</label><asp:TextBox ID="TextBox_father_Name" runat="server" CssClass="textbox_normal"  Width="250px" onactivate="this.className='textbox_focus';" ondeactivate="this.className='textbox_normal';"></asp:TextBox>
  <label>Date of Birth&nbsp;:</label>
    <igsch:WebDateChooser ID="WebCalendar_Date_of_Birth" runat="server" Width="254px" NullDateLabel="1/1/1960"></igsch:WebDateChooser>
    <asp:HiddenField ID="HiddenField_Date_of_Birth" runat="server"/>
    
  </li>
    
  <li><label>
      CNIC No.&nbsp;:</label><asp:TextBox ID="TextBox_NIC1" runat="server"  CssClass="textbox_normal"  Width="55px" onactivate="this.className='textbox_focus';" ondeactivate="this.className='textbox_normal';" MaxLength="5"></asp:TextBox>
      -
      <asp:TextBox ID="TextBox_nic2" runat="server" MaxLength="7" Width="92px"></asp:TextBox>
      -
      <asp:TextBox ID="TextBox_nic3" runat="server" MaxLength="1" Width="14px"></asp:TextBox>&nbsp;<asp:HiddenField
          ID="HiddenField_nic" runat="server" />
  </li><li><label>Gender&nbsp;:</label> <asp:DropDownList ID="DropDownList_gender" runat="server" Width="254px">
    <asp:ListItem>Male</asp:ListItem><asp:ListItem>Female</asp:ListItem></asp:DropDownList></li>
						  
<li><label>Martial Status&nbsp;:</label><asp:DropDownList ID="DropDownList_status" runat="server" Width="254px">
    <asp:ListItem>Single</asp:ListItem>
    <asp:ListItem>Married</asp:ListItem>
</asp:DropDownList>&nbsp; </li>
    
    
    
    <li><label>Address&nbsp;:</label><asp:TextBox ID="TextBox_address" runat="server" CssClass="textbox_normal"  Width="250px" onactivate="this.className='textbox_focus';" ondeactivate="this.className='textbox_normal';"></asp:TextBox>
      </li><li><label>City&nbsp;:</label><asp:TextBox ID="TextBox_city" runat="server" CssClass="textbox_normal"  Width="250px" onactivate="this.className='textbox_focus';" ondeactivate="this.className='textbox_normal';"></asp:TextBox>
    </li><li><label>Province&nbsp;:</label><asp:TextBox ID="TextBox_province" runat="server" CssClass="textbox_normal"  Width="250px" onactivate="this.className='textbox_focus';" ondeactivate="this.className='textbox_normal';"></asp:TextBox>
    </li><li><label>Domicile&nbsp;:</label>
            <asp:TextBox ID="TextBox_domicile" runat="server" CssClass="textbox_normal"  Width="250px" onactivate="this.className='textbox_focus';" ondeactivate="this.className='textbox_normal';"></asp:TextBox>&nbsp;
        </li><li><label>Country&nbsp;:</label><asp:DropDownList ID="DropDownList_country" runat="server" DataSourceID="SqlDataSource2"
                        DataTextField="CountryName" DataValueField="CountryCode" Width="254px"></asp:DropDownList></li>
  <li><label>Nationality&nbsp;:</label><asp:TextBox ID="TextBox_nationality" runat="server" CssClass="textbox_normal"  Width="250px" onactivate="this.className='textbox_focus';" ondeactivate="this.className='textbox_normal';"></asp:TextBox></li>
  <li><label>Phone&nbsp;:</label><asp:TextBox ID="TextBox_telephone" runat="server" CssClass="textbox_normal"  Width="250px" onactivate="this.className='textbox_focus';" ondeactivate="this.className='textbox_normal';"></asp:TextBox>
      </li><li><label>Mobile&nbsp;:</label><asp:TextBox ID="TextBox_mobile" runat="server" CssClass="textbox_normal"  Width="250px" onactivate="this.className='textbox_focus';" ondeactivate="this.className='textbox_normal';"></asp:TextBox>
    </li><li><label>Fax&nbsp;:</label><asp:TextBox ID="TextBox_fax" runat="server" CssClass="textbox_normal"  Width="250px" onactivate="this.className='textbox_focus';" ondeactivate="this.className='textbox_normal';"></asp:TextBox>
    <asp:RegularExpressionValidator ID="RegularExpressionValidator_fax" runat="server"
        ControlToValidate="TextBox_fax" ErrorMessage="*" ValidationExpression="(\d{3}-\d{7})"></asp:RegularExpressionValidator></li>


  <li><label>Postal Code&nbsp;:</label><asp:TextBox ID="TextBox_postal_Code" runat="server" CssClass="textbox_normal"  Width="250px" onactivate="this.className='textbox_focus';" ondeactivate="this.className='textbox_normal';"></asp:TextBox>&nbsp;
    <asp:RegularExpressionValidator ID="RegularExpressionValidator_postalcode" runat="server"
        ControlToValidate="TextBox_postal_Code" ErrorMessage="*" ValidationExpression="\d{5}"></asp:RegularExpressionValidator></li><li><label>Passport No.&nbsp;:</label>
            <asp:TextBox ID="TextBox_passport" runat="server" CssClass="textbox_normal"  Width="250px" onactivate="this.className='textbox_focus';" ondeactivate="this.className='textbox_normal';"></asp:TextBox>&nbsp;
        </li>
  <li><label>E-mail&nbsp;:</label><asp:TextBox ID="TextBox_email" runat="server" CssClass="textbox_normal"  Width="250px" onactivate="this.className='textbox_focus';" ondeactivate="this.className='textbox_normal';"></asp:TextBox>&nbsp;
      <asp:RegularExpressionValidator ID="RegularExpressionValidator_email" runat="server"
          ControlToValidate="TextBox_email" ErrorMessage="*" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator></li><li><label>Password&nbsp;:</label><asp:TextBox ID="TextBox_passward" runat="server" TextMode="Password" CssClass="textbox_normal"  Width="250px" onactivate="this.className='textbox_focus';" ondeactivate="this.className='textbox_normal';"></asp:TextBox>
    <br>
  <br />
  </li>
  <li>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Button CssClass="buttonSubmit" ID="Button_Save" runat="server" Text="Save" onmousedown="this.className='buttonSubmit'" onmouseover="this.className='buttonSubmitHovered'" onmouseout="this.className='buttonSubmit'"/>
  
  <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
            SelectCommand="SELECT [CountryCode], [CountryName] FROM [Country]"></asp:SqlDataSource>
      <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
      <asp:HiddenField ID="HiddenField_Employee_ID" runat="server" /><asp:TextBox CssClass="textbox_normal" ID="TextBox_company" onactivate="this.className='textbox_focus';" ondeactivate="this.className='textbox_normal';" runat="server" Visible="False" Width="250px"></asp:TextBox><asp:TextBox CssClass="textbox_normal" ID="TextBox_company_URL" onactivate="this.className='textbox_focus';" ondeactivate="this.className='textbox_normal';" runat="server" Visible="False" Width="250px"></asp:TextBox><asp:TextBox CssClass="textbox_normal" ID="TextBox_Personal_URL" onactivate="this.className='textbox_focus';" ondeactivate="this.className='textbox_normal';" runat="server" Visible="False" Width="250px"></asp:TextBox>
      <asp:HiddenField ID="HiddenField_status" runat="server" />
  </li>
  </ol>
            </fieldset></td>
          </tr>
          <tr>
            <td height="20">&nbsp;</td>
          </tr>
          

          
          
          
          
          

          
          
          <!--DWLayoutTable-->
          
          

          
          
          
          
          
          
          
          
          
          
          
          

          

          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          

          
          
          
          
          
          


          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          

          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
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
<script type="text/javascript" src="images1/flash_01.js">function IMG1_onclick() {

}

</script>
</form>
</body>
</html>