<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="employeex, App_Web_gtm21hdb" enableeventvalidation="false" theme="theme_hacims" viewstateencryptionmode="Never" maintainscrollpositiononpostback="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7DD5C3163F2CD0CB"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>


<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">


<script type="text/JavaScript">

function checkrequiredfield(a)
{
var txtEFName=document.getElementById("txtEFName").value;
var txtEMName=document.getElementById("txtEMName").value;
var txtELName=document.getElementById("TxtELName").value;
 if(document.getElementById("txtEFName").value.length==0)
        {
        alert("Enter first name");
        document.getElementById("txtEFName").focus();
        return false;
        }
    else 
        {
        for (i=0;i<txtEFName.length;i++)
          {
           if(txtEFName.charAt(i)>=0 || txtEFName.charAt(i)<=9)
           {
            alert("Integer not allowed in Employee First Name");
            document.getElementById("txtEFName").focus();
            return false;
           }
          }
        }
     if(document.getElementById("txtEMName").value.length!=0)
        {
        for (i=0;i<txtEMName.length;i++)
          {
          if(txtEMName.charAt(i)>=0 || txtEMName.charAt(i)<=9)
           {
            alert("Integer not allowed in Employee Middle Name");
            document.getElementById("txtEMName").focus();
            return false;
           }
          }
        }
      if(document.getElementById("TxtELName").value.length!=0)
        {
        for (i=0;i<txtELName.length;i++)
          {
          if(txtELName.charAt(i)>=0 || txtELName.charAt(i)<=9)
           {
            alert("Integer not allowed in Employee Last Name");
            document.getElementById("TxtELName").focus();
            return false;
           }
          }
        }
}
</script>

    <style type="text/css">
        .LinkStyle
        {
            padding-right:10px;
            padding-left:5px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



<br />
<asp:Label ID="LblInvalidDate" runat="server" CssClass="err" ></asp:Label>
<asp:Label ID="Label1" runat="server" CssClass="err"></asp:Label>
<asp:Label ID="Label_message" runat="server" CssClass="err" ></asp:Label>
                        

 

<div class="bxmain"><h2><span>General Information</span></h2>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td width="19%" align="right">Title :&nbsp;</td>
    <td  ><asp:RadioButtonList CssClass="radlist" ID="prefix" RepeatDirection="Horizontal" runat="server" >
      <asp:ListItem Selected="True">Mr.</asp:ListItem>
      <asp:ListItem>Miss</asp:ListItem>
      <asp:ListItem>Mrs.</asp:ListItem>
      <asp:ListItem>Dr.</asp:ListItem>
    </asp:RadioButtonList></td>
    <td width="17%" rowspan="13" align="center" valign="top">&nbsp;<asp:ImageButton 
            ID="ImageButton1" runat="server" Height="100px" Width="85px" 
            style="margin-right:10px;" BorderStyle="Inset" 
            ImageUrl="~/images/PictureFrame.png"  />     </td>
  </tr>
  <tr>
    <td align="right">Employee No :&nbsp;</td>
    <td>
      <span style="color: #ff0000">
        <asp:TextBox ID="TextBox_Emp_Number" runat="server" CssClass="input_txt" 
            ></asp:TextBox>
        *</span>
      <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox_Emp_Number"
        ErrorMessage="*">*</asp:RequiredFieldValidator>
        <asp:Label ID="Label5" runat="server" Font-Bold="True" ForeColor="#FF0066"></asp:Label>
      </td>
    </tr>
  
   <tr>
    <td align="right">First Name :&nbsp;</td>
    <td><asp:TextBox ID="txtEFName" runat="server"  CssClass="input_txt" ></asp:TextBox>
      <span style="color: #ff0000">*</span>
      <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtEFName"
            ErrorMessage="*">*</asp:RequiredFieldValidator></td>
    </tr>
  
   <tr>
    <td align="right"> Middle Name :&nbsp;</td>
    <td><asp:TextBox ID="txtEMName" runat="server" CssClass="input_txt" ></asp:TextBox></td>
    </tr>
  
  <tr>
    <td align="right">Last Name :&nbsp;</td>
    <td><asp:TextBox ID="TxtELName" runat="server"  CssClass="input_txt" ></asp:TextBox>
      <span style="color: #ff0000">* </span>
      <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="TxtELName"
              ErrorMessage="*">*</asp:RequiredFieldValidator></td>
    </tr>
  
  <tr>
    <td align="right">Attach Picture :&nbsp;</td>
    <td>

<asp:FileUpload ID="FileUpload_image" runat="server" Width="200px" />
      <asp:Button ID="Button_attach_pic" runat="server" CausesValidation="False" Text="Attach" CssClass="btn1" />
        <asp:HiddenField ID="HiddenField_ImageAttached" runat="server" Value="0" />
      </td>
    </tr>
  
  <tr>
    <td align="right">&nbsp;</td>
    <td>

        &nbsp;</td>
    </tr>
  
  <tr>
    <td align="right">Gender :&nbsp;</td>
    <td><asp:DropDownList  DataSourceID="SqlDataSourceGender" DataTextField="Gender" DataValueField="Gender_ID" ID="Dropdownlistsex" runat="server" ></asp:DropDownList></td>
    </tr>
  
    <tr>
    <td align="right"> Father First Name :&nbsp;</td>
    <td><asp:TextBox ID="TextBoxRFName" CssClass="input_txt"  runat="server"></asp:TextBox>
      <span style="color: #ff0000">*
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1"
        runat="server" ControlToValidate="TextBoxRFName" ErrorMessage="*">*</asp:RequiredFieldValidator>
      </span></td>
    </tr>
  
    <tr>
    <td align="right"> Father Middle Name :&nbsp;</td>
    <td><asp:TextBox id="TextBoxRMName" CssClass="input_txt"  runat="server" ></asp:TextBox></td>
    </tr>
  
    <tr>
    <td align="right">Father Last Name :&nbsp;</td>
    <td><asp:TextBox id="TextBoxRLName" runat="server" CssClass="input_txt" ></asp:TextBox>
      <span style="color: #ff0000">*
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3"
              runat="server" ControlToValidate="TextBoxRLName" ErrorMessage="*">*</asp:RequiredFieldValidator>
      </span></td>
    </tr>
  
  <tr>
    <td align="right">Employee Type :&nbsp;</td>
    <td><asp:DropDownList ID="DropDownList_Type" runat="server" DataSourceID="SqlDataSource_emp_Type"
        DataTextField="Type" DataValueField="Employee_Type_ID" Width="154px" 
            AutoPostBack="True"> </asp:DropDownList></td>
    </tr>
  

    <tr>
        <td align="right">
            Employee Machine Code :&nbsp;</td>
        <td>
            <asp:TextBox ID="TextBox_Emp_No" runat="server" CssClass="input_txt" 
                ></asp:TextBox>
            &nbsp;<span class="dim">(If Any)</span></td>
    </tr>
  

</table>


</div>

<br />


<div class="bxmain"><h2><span>Basic Information</span></h2>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form"> 
  <tr>
    <td width="50%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="38%" align="right">Date Of Birth : </td>
        <td width="62%"><asp:TextBox ID="TextBox_DOB_day" runat="server" CssClass="input_txt" Width="35px"></asp:TextBox>
          -
          <asp:TextBox ID="TextBox_DOB_Month" runat="server" CssClass="input_txt"  Width="25px"></asp:TextBox>
          -
          <asp:TextBox ID="TextBox_DOB_Year" runat="server" CssClass="input_txt"  Width="66px"></asp:TextBox></td>
      </tr>
      <tr>
        <td align="right">Marital Status : </td>
        <td><asp:RadioButtonList CssClass="radlist" ID="RadioButtonList_marital_status" RepeatDirection="Horizontal" RepeatLayout="Flow" runat="server" TabIndex="9">
          <asp:ListItem Selected="True">Single</asp:ListItem>
          <asp:ListItem>Married</asp:ListItem>
          <asp:ListItem>Widow</asp:ListItem>
          <asp:ListItem>Divorced</asp:ListItem>
        </asp:RadioButtonList></td>
      </tr>
      <tr>
        <td align="right">Nationality : </td>
        <td><asp:DropDownList DataSourceID="SqlDataSource_Nationality" DataTextField="Nationality_Name" DataValueField="Nationality_ID" ID="DropDownList_nationality" runat="server"   > </asp:DropDownList></td>
      </tr>
      <tr>
        <td align="right">Language Known :</td>
        <td><asp:TextBox id="TextBox_language" runat="server" CssClass="input_txt"  ></asp:TextBox></td>
      </tr>
    </table></td>
    <td width="50%" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="right" width="38%">Place of birth :</td>
        <td><asp:DropDownList  AutoPostBack="True" 
                DataSourceID="SqlDataSource_place_of_birth0" DataTextField="DistrictName"  
                DataValueField="DistrictCode" ID="DropDownList_place_of_birth" 
                OnSelectedIndexChanged="DropDownList_place_of_birth_SelectedIndexChanged" 
                runat="server"> </asp:DropDownList>
                                                  </td>
      </tr>
      <tr>
        <td align="right">Religion :</td>
        <td><asp:DropDownList DataSourceID="SqlDataSource_religion" DataTextField="Religion_name" DataValueField="Religion_ID" ID="DropDownList_religion"  runat="server" ></asp:DropDownList></td>
      </tr>
      <tr>
        <td align="right">Passport No :</td>
        <td><asp:TextBox id="TextBox_Passport_no" CssClass="input_txt"  runat="server" ></asp:TextBox></td>
      </tr>
      <tr>
        <td align="right">Domicile :</td>
        <td><asp:DropDownList DataSourceID="SqlDataSource_place_of_birth" DataTextField="DistrictName" DataValueField="DistrictCode" ID="DropDownList_Domicile" runat="server"  > </asp:DropDownList></td>
      </tr>
    </table></td>
  </tr>
</table>
</div>
<br />

<div class="bxmain"><h2><span>Address Information</span></h2>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td width="50%" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="38%" align="right">CNIC No. : </td>
        <td width="62%">
        <igtxt:webmaskedit id="TextBox_CNIC" runat="server" inputmask="#####-#######-#"></igtxt:webmaskedit>
          <span style="color: #ff0000"><asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="TextBox_CNIC"
        ErrorMessage="Please Enter CNIC No">*</asp:RequiredFieldValidator></span></td>
      </tr>
      <tr>
        <td align="right">District Name : </td>
        <td><asp:DropDownList ID="DropDownList_dist_ID" runat="server" DataSourceID="SqlDataSource_dest_ID"
                                      DataTextField="DistrictName" DataValueField="DistrictCode"   AutoPostBack="True"> </asp:DropDownList></td>
      </tr>
      <tr>
        <td align="right">Home Phone :</td>
        <td><asp:TextBox ID="txthp1" runat="server" Width="35px" CssClass="input_txt" >0092</asp:TextBox>
          -
          <asp:TextBox ID="txthp2" runat="server" Width="25px" CssClass="input_txt" >21</asp:TextBox>
          -
          <asp:TextBox ID="txthp3" runat="server" CssClass="input_txt"  Width="66px" ></asp:TextBox></td>
      </tr>
      <tr>
        <td align="right">Mobile No :</td>
        <td><asp:TextBox ID="TextBox_mobile_No" runat="server" CssClass="input_txt" ></asp:TextBox></td>
      </tr>
      <tr>
        <td align="right">Office Phone :</td>
        <td><asp:TextBox ID="txtop1" runat="server" Width="35px" CssClass="input_txt" >0092</asp:TextBox>
          -
          <asp:TextBox ID="txtop2" runat="server" CssClass="input_txt"  Width="25px" >21</asp:TextBox>
          -
          <asp:TextBox ID="txtop3" runat="server" CssClass="input_txt" Width="66px"></asp:TextBox></td>
      </tr>
      <tr>
        <td align="right">Email Address :</td>
        <td><asp:TextBox ID="TextBox_email" runat="server"  CssClass="input_txt"></asp:TextBox></td>
      </tr>
      </table></td>
    <td width="50%" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="right">Tehsil Name : </td>
        <td><asp:DropDownList ID="DropDownList_teh_ID" runat="server" DataSourceID="SqlDataSource_tehsil_ID"
                                      DataTextField="TehsilName" DataValueField="TehsilCode" > </asp:DropDownList></td>
      </tr>
      <tr>
        <td align="right">Permanent Address : </td>
        <td><asp:TextBox ID="homeadd" runat="server" CssClass="input_txt"  ></asp:TextBox>
          <span style="color: #ff0000">*<asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">Same as Above</asp:LinkButton></span></td>
      </tr>
      <tr>
        <td align="right">Present Address :</td>
        <td><asp:TextBox ID="TextBox_present_address" runat="server" CssClass="input_txt" ></asp:TextBox></td>
      </tr>
      <tr>
        <td align="right">Office Address :</td>
        <td><asp:TextBox ID="officeadd" runat="server" CssClass="input_txt" ></asp:TextBox></td>
      </tr>
      </table></td>
  </tr>
</table></div>
<br />
<asp:Label ID="Label4" runat="server" ></asp:Label>





                          <asp:SqlDataSource ID="SqlDataSource_place_of_birth" 
        runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                              
        SelectCommand="SELECT DistrictCode, DistrictName, ProvinceCode, Priority FROM DISTRICT ">
                          </asp:SqlDataSource>





                          <asp:SqlDataSource ID="SqlDataSource_place_of_birth0" 
        runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                              
        
        SelectCommand="SELECT DistrictCode, DistrictName, Priority FROM DISTRICT  WHERE (Priority &lt;&gt; 221) or (Priority is null)  ORDER BY DistrictName">
                          </asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSource_religion" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                              SelectCommand="SELECT [Religion_ID], [Religion_name] FROM [Religion]"></asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSource_Nationality" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                              SelectCommand="SELECT [Nationality_ID], [Nationality_Name] FROM [Nationality]"></asp:SqlDataSource>

<div class="bxmain"><h2><span>Employment Information</span></h2>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td width="50%" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="right">Join Date : </td>
        <td><asp:TextBox ID="txtday" runat="server" CssClass="input_txt" Width="35px" ></asp:TextBox>
          -
          <asp:TextBox ID="txtmonth" runat="server" CssClass="input_txt" Width="25px"></asp:TextBox>
          -
          <asp:TextBox ID="txtyear" runat="server" Width="66px" CssClass="input_txt" ></asp:TextBox></td>
      </tr>
      <tr>
        <td width="38%" align="right">Designation :</td>
        <td width="62%"><asp:DropDownList  
                        DataTextField="Designation_Name" DataValueField="Designation_ID" ID="DropDownListdesignation" runat="server" DataSourceID="SqlDataSourceDesignation" TabIndex="4" AutoPostBack="True"> </asp:DropDownList>
          <asp:HyperLink ID="HyperLink3" runat="server" 
                NavigateUrl="~/Administrator/Basic Data Management/designation.aspx?PName=Employee Designations&amp;MName=Human Resource" 
                Target="_self" Visible="False">Add Designation</asp:HyperLink></td>
      </tr>
      <tr>
        <td align="right">Date Currnt Designation Joined :</td>
        <td>
            <igsch:WebDateChooser ID="WebDateChooser_CurretDesigJoinDate" runat="server" 
                >
            </igsch:WebDateChooser>
            <asp:HiddenField ID="HiddenField_Current_Designation_JoinDate" runat="server" />
          </td>
      </tr>
      <tr>
        <td align="right">NTN #:</td>
        <td>
            <asp:TextBox ID="txtNTNNo" runat="Server"></asp:TextBox>
          </td>
      </tr>
      <tr>
        <td align="right">Profession:</td>
        <td>
            <asp:DropDownList ID="ddlProfession" 
                DataSourceID="SqlDataSourceProfession" 
                DataTextField="Profession_Name"
                DataValueField="Profession_Code"
                AppendDataBoundItems="true"
                runat="Server">
                <asp:ListItem Text=" --- Select --- "
                    Value="0"></asp:ListItem>    
            </asp:DropDownList>
          </td>
      </tr>
      <tr>
        <td align="right">Designation Detail :</td>
        <td><asp:TextBox ID="TextBox_Designation_Detail" runat="server" CssClass="input_txt" Height="50px" TextMode="MultiLine"
        Width="90%"></asp:TextBox></td>
      </tr>
      <tr>
        <td align="right">GP Fund No :</td>
        <td><asp:TextBox ID="txtGPFund" runat="server" CssClass="input_txt" 
        Width="90%"></asp:TextBox></td>
      </tr>
      <tr>
        <td align="right">Provident Fund No :</td>
        <td><asp:TextBox ID="txtProvFundNo" runat="server" CssClass="input_txt"  
        Width="90%"></asp:TextBox></td>
      </tr>
      <tr>
        <td align="right">EOBI No :</td>
        <td><asp:TextBox ID="txtEOBINo" runat="server" CssClass="input_txt" 
        Width="90%"></asp:TextBox></td>
      </tr>
      <tr>
        <td align="right"></td>
        <td>
            &nbsp;<asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Administrator/Basic%20Data%20Management/SubDept.aspx" Target="_blank" Visible="False">Add Division</asp:HyperLink></td>
      </tr>
    </table></td>
    <td width="50%" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="38%" align="right">Grade (I-IX) :</td>
        <td width="62%"><asp:DropDownList   ID="Dropdownlistpayscale" runat="server" >
          <asp:ListItem>I</asp:ListItem>
          <asp:ListItem>II</asp:ListItem>
          <asp:ListItem>III</asp:ListItem>
            <asp:ListItem>IV</asp:ListItem>
            <asp:ListItem>V</asp:ListItem>
            <asp:ListItem>VI</asp:ListItem>
            <asp:ListItem>VII</asp:ListItem>
            <asp:ListItem>VIII</asp:ListItem>
            <asp:ListItem>IX</asp:ListItem>
        </asp:DropDownList></td>
      </tr>
      <tr>
        <td width="38%" align="right">Grade (1-21) :</td>
        <td width="62%"><asp:DropDownList   ID="Dropdownlistpayscale0" runat="server" >
          <asp:ListItem>1</asp:ListItem>
          <asp:ListItem>2</asp:ListItem>
          <asp:ListItem>3</asp:ListItem>
            <asp:ListItem>4</asp:ListItem>
            <asp:ListItem>5</asp:ListItem>
            <asp:ListItem>6</asp:ListItem>
            <asp:ListItem>7</asp:ListItem>
            <asp:ListItem>8</asp:ListItem>
            <asp:ListItem>9</asp:ListItem>
            <asp:ListItem>10</asp:ListItem>
            <asp:ListItem>11</asp:ListItem>
            <asp:ListItem>12</asp:ListItem>
            <asp:ListItem>13</asp:ListItem>
            <asp:ListItem>14</asp:ListItem>
            <asp:ListItem>15</asp:ListItem>
            <asp:ListItem>16</asp:ListItem>
            <asp:ListItem>17</asp:ListItem>
            <asp:ListItem>18</asp:ListItem>
            <asp:ListItem>19</asp:ListItem>
            <asp:ListItem>20</asp:ListItem>
            <asp:ListItem>21</asp:ListItem>
        </asp:DropDownList></td>
      </tr>
      <tr>
        <td align="right">Service Start Date :</td>
        <td><asp:TextBox ID="TextBox_service_satart_Date_day" runat="server" CssClass="input_txt" Width="35px"></asp:TextBox>
          -
          <asp:TextBox ID="TextBox_Service_Start_Date_month" runat="server" CssClass="input_txt" Width="25px"></asp:TextBox>
          -
          <asp:TextBox ID="TextBox_service_Start_Date_Year" runat="server" CssClass="input_txt" Width="66px"></asp:TextBox></td>
      </tr>
      <tr>
        <td width="38%" align="right"> Division :</td>
        <td width="62%"><asp:DropDownList   DataTextField="Dept_Name"  DataValueField="Dept_ID" ID="Dropdownlistdepartment" runat="server" DataSourceID="SqlDataSourceDepartment" AutoPostBack="True" TabIndex="5"> </asp:DropDownList>
          <asp:HyperLink ID="HyperLink1" runat="server" 
                NavigateUrl="~/Administrator/Basic%20Data%20Management/department.aspx?PName=Departments/Divisions&amp;MName=Human Resource" 
                Target="_self" Visible="False">Add Division</asp:HyperLink></td>
      </tr>
      <tr>
        <td align="right">Section :</td>
        <td><asp:DropDownList ID="DropDownListSubDepartment" runat="server"  
                        DataSourceID="SqlDataSource_Division" DataTextField="SubDept_Name" 
                DataValueField="SubDept_Id" 
TabIndex="6" AutoPostBack="True"> </asp:DropDownList>
            
          <asp:HyperLink ID="HyperLink6" runat="server" 
                NavigateUrl="~/Administrator/Basic%20Data%20Management/SubDeptAdd.aspx?PName=Section/Subdepartment&amp;MName=Human Resource" 
                Target="_self" Visible="False">Add Section</asp:HyperLink>
            
                                </td>
      </tr>
        <tr>
            <td align="right">
            </td>
            <td>
                &nbsp;</td>
        </tr>
    </table><asp:DropDownList   DataTextField="Section_Name"  DataValueField="Section_ID" ID="DropDownList_section" runat="server" DataSourceID="SqlDataSource_section" AutoPostBack="True" TabIndex="5" Visible="False"> </asp:DropDownList>
          <asp:HyperLink ID="HyperLink5" runat="server" NavigateUrl="~/Administrator/Basic%20Data%20Management/Section.aspx"
        Target="_blank" Visible="False">Add Section</asp:HyperLink></td>
  </tr>
</table>
<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="ButtonSave" runat="server" Text="Save" CssClass="btn1" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Button ID="btnRefresh" runat="server" Text="Reset" 
        CausesValidation="False" Width="85px" />
     
     <div style="width:100%;">  
    
    <asp:HyperLink ID="hlnkEmployeeEducation" 
        runat="Server" 
        Text="Education" CssClass="LinkStyle"
        Target="_blank"
        NavigateUrl="~/hr/Education.aspx?PName=Education&MName=Edit Employee&Emp_Id=0"
        Visible="false"></asp:HyperLink>
    
    <asp:HyperLink ID="hlnkEmployeeCertifications" 
        runat="Server" 
        Text="Certification" CssClass="LinkStyle"
        Target="_blank"
        NavigateUrl="~/hr/Certification.aspx?PName=Certifications&MName=Edit Employee&Emp_Id=0"
        Visible="false"></asp:HyperLink>
        
    <asp:HyperLink ID="hlnkEmployeeSkills" 
        runat="Server" 
        Text="Skills" CssClass="LinkStyle"
        Target="_blank"
        NavigateUrl="~/hr/skills.aspx?PName=Skills&MName=Edit Employee&Emp_Id=0"
        Visible="false"></asp:HyperLink>
       
    <asp:HyperLink ID="hlnkAdditionalInfo" 
        runat="Server" 
        Text="Additional Info" CssClass="LinkStyle"
        Target="_blank"
        NavigateUrl="~/hr/Additional_Info.aspx?PName=Additional Info&MName=Edit Employee&Emp_Id=0"
        Visible="false"></asp:HyperLink>
    
    <asp:HyperLink ID="hlnkEmployeeRelationship" 
        runat="Server" 
        Text="Relationship" CssClass="LinkStyle"
        Target="_blank"
        NavigateUrl="~/hr/ADD_relationship.aspx?PName=Relationship&MName=Edit Employee&Emp_Id=0"
        Visible="false"></asp:HyperLink>
    
    <asp:HyperLink ID="hlnkEmployeeDocuments" 
        runat="Server" 
        Text="Documents" CssClass="LinkStyle"
        Target="_blank"
        NavigateUrl="~/hr/attach_Documents_Server.aspx?PName=Documents&MName=Edit Employee&Emp_Id=0"
        Visible="false"></asp:HyperLink>
        
       <asp:HyperLink ID="hlnkEmployeeExperience" 
        runat="Server" 
        Text="Experience" CssClass="LinkStyle"
        Target="_blank"
        NavigateUrl="~/hr/Experience.aspx?PName=Documents&MName=Edit Employee&Emp_Id=0"
        Visible="false"></asp:HyperLink>
    
    </div> 
    
<br />
</div><br />

<br />
<%--<div class="bxmain">

    <table class="style1">
        <tr>
            <td>
                Current Designation :</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>

</div>--%>
 <asp:Label ID="Label2" runat="server" CssClass="err" ></asp:Label>
<asp:Label ID="Label3" runat="server" CssClass="err" ></asp:Label><br />

 <asp:RequiredFieldValidator ControlToValidate="homeadd" CssClass="err"
                Display="Dynamic" ErrorMessage="Please Enter Home Address" ID="RequiredFieldValidatorHomeAdd" runat="server"></asp:RequiredFieldValidator>

                            <asp:RequiredFieldValidator ControlToValidate="txtEFName" CssClass="err"
                Display="Dynamic" ErrorMessage="Please Enter First Name" ID="RequiredFieldValidatorPFName" runat="server"></asp:RequiredFieldValidator><asp:SqlDataSource ID="SqlDataSourceDesignation" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="SELECT Designation_Name, Designation_ID FROM Designation ORDER BY Min_PayScale DESC"> </asp:SqlDataSource>
                      <asp:SqlDataSource ID="SqlDataSourceGender" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="SELECT Gender_ID, Gender FROM Gender" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"></asp:SqlDataSource>
                      <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="SELECT [Dept_Name], [Dept_ID] FROM [Department] ORDER BY [Dept_Name]" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"></asp:SqlDataSource>
                      <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        InsertCommand="HR_Insert_Employee_Info"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" InsertCommandType="StoredProcedure">
                        <InsertParameters>
                            <asp:ControlParameter ControlID="prefix" Name="Prefix" 
                                PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="txtEFName" DefaultValue="" Name="EFName" 
                                PropertyName="Text" />
                            <asp:ControlParameter ControlID="txtEMName" DefaultValue="" Name="EMName" 
                                PropertyName="Text" />
                            <asp:Parameter Name="Relation" DefaultValue="" Type="String" />
                            <asp:Parameter Name="Employee_Type_Id" DefaultValue="" Type="Int32" />


                            
                            
                            <asp:ControlParameter ControlID="TxtELName" Name="ELName" PropertyName="Text" />
                          <asp:SessionParameter Name="JoinDate" SessionField="EJDate" />
                          <asp:ControlParameter ControlID="HiddenFieldCNIC" Name="CNIC" PropertyName="Value" />
                            <asp:ControlParameter ControlID="DropDownListdesignation" Name="DesignationID" 
                                PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="Dropdownlistpayscale" Name="PayScale" 
                                PropertyName="SelectedValue" />
                          <asp:ControlParameter ControlID="HiddenFieldHomePhone" Name="HPhoneNo" PropertyName="Value" />
                          <asp:ControlParameter ControlID="HiddenFieldOfficePhone" Name="OphoneNo" PropertyName="Value" />
                            <asp:ControlParameter ControlID="officeadd" Name="OfficeAdd" 
                                PropertyName="Text" />
                            <asp:ControlParameter ControlID="homeadd" Name="HomeAdd" PropertyName="Text" />
                            <asp:ControlParameter ControlID="Dropdownlistsex" Name="SexID" 
                                PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="DeptID" 
                                PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="DropDownListSubDepartment" Name="SubDeptId" 
                                PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="HiddenField_Employee_ID" Direction="Output" 
                                Name="EmpID" PropertyName="Value" Type="Int32" Size="90000" />
                            <asp:ControlParameter ControlID="TextBoxRFName" Name="RFName" PropertyName="Text"
                                Type="String" />
                            <asp:ControlParameter ControlID="TextBoxRMName" Name="RMName" PropertyName="Text"
                                Type="String" />
                            <asp:ControlParameter ControlID="TextBoxRLName" Name="RLName" PropertyName="Text"
                                Type="String" />
                            <asp:ControlParameter ControlID="HiddenField_DOB" Name="DateOfBirth" PropertyName="Value"
                                Type="DateTime" />
                            <asp:ControlParameter ControlID="HiddenFieldStartDate" Name="ServiceStartDate" PropertyName="Value"
                                Type="DateTime" />
                            <asp:SessionParameter Name="Entry_Employee_ID" SessionField="emp_ID" Type="Int32" />
                            <asp:ControlParameter ControlID="TextBox_email" Name="email_address" PropertyName="Text"
                                Type="String" />
                            <asp:ControlParameter ControlID="TextBox_present_address" Name="Present_address"
                                PropertyName="Text" Type="String" />
                            <asp:ControlParameter ControlID="TextBox_mobile_No" Name="Mobile_Number" PropertyName="Text"
                                Type="String" />
                            <asp:ControlParameter ControlID="DropDownList_place_of_birth" Name="Place_of_birth"
                                PropertyName="SelectedValue" Type="Int32" />
                            <asp:ControlParameter ControlID="RadioButtonList_marital_status" Name="Marital_Status"
                                PropertyName="SelectedValue" Type="String" />
                            <asp:ControlParameter ControlID="DropDownList_religion" Name="Religion" PropertyName="SelectedValue"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="DropDownList_nationality" Name="Nationality" PropertyName="SelectedValue"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="TextBox_Passport_no" Name="Passport_No" PropertyName="Text"
                                Type="String" />
                            <asp:ControlParameter ControlID="DropDownList_Domicile" Name="Domicile" PropertyName="SelectedValue"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="TextBox_language" Name="Language_Known" PropertyName="Text"
                                Type="String" />
                            <asp:ControlParameter ControlID="DropDownList_dist_ID" Name="dist_ID" PropertyName="SelectedValue"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="DropDownList_teh_ID" Name="tech_ID" PropertyName="SelectedValue"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="DropDownList_section" Name="Section_ID" PropertyName="SelectedValue"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="DropDownList_Type" Name="Employee_Type" PropertyName="SelectedValue"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="TextBox_Designation_Detail" Name="Designation_Detail"
                                PropertyName="Text" Type="String" />
                            <asp:ControlParameter ControlID="TextBox_Emp_No" Name="Emp_No" PropertyName="Text"
                                Type="String" />
                            <asp:ControlParameter ControlID="TextBox_Emp_Number" Name="Emp_Offical_Number" 
                                PropertyName="Text" Type="String" />
                            <asp:ControlParameter ControlID="HiddenField_Current_Designation_JoinDate" 
                                Name="Last_Promotion_Date" PropertyName="Value" Type="DateTime" />
                            <asp:ControlParameter ControlID="Dropdownlistpayscale0" Name="Employee_Scale" 
                                PropertyName="SelectedValue" Type="Int32" />
                            <asp:ControlParameter ControlID="txtNTNNo" Name="NTN" 
                                PropertyName="Text" Type="String" />
                            <asp:ControlParameter ControlID="ddlProfession" Name="Profession_Code" 
                                PropertyName="SelectedValue" Type="Int32" />
                            <asp:ControlParameter ControlID="txtGPFund" Name="GP_Fund_No" 
                                PropertyName="Text" Type="String" />
                            <asp:ControlParameter ControlID="txtProvFundNo" Name="Prov_Fund_No" 
                                PropertyName="Text" Type="String" />
                            <asp:ControlParameter ControlID="txtEOBINo" Name="EOBI_No" 
                                PropertyName="Text" Type="String" />
                        </InsertParameters>
                      </asp:SqlDataSource>
                      <asp:HiddenField ID="HiddenFieldCNIC" runat="server" />
                      <asp:HiddenField ID="HiddenFieldHomePhone" runat="server" />
                      <asp:HiddenField ID="HiddenFieldOfficePhone" runat="server" />
                      <asp:SqlDataSource ID="SqlDataSource_Division" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    
            SelectCommand="SELECT SubDept_Name, SubDept_Id FROM SubDepartment WHERE (Dept_Id = @Dept_Id)" 
            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
                        <SelectParameters>
                          <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="Dept_Id" 
                                PropertyName="SelectedValue" />
                        </SelectParameters>
                      </asp:SqlDataSource>
                      <asp:SqlDataSource ID="SqlDataSourceProfession" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="SELECT Profession_Name, Profession_Code FROM Admin_Employee_Profession Order by Profession_Name"> </asp:SqlDataSource>
                          <asp:HiddenField ID="HiddenField_age" runat="server" />
                          <asp:HiddenField ID="HiddenField_DOB" runat="server" />
                          <asp:HiddenField ID="HiddenFieldEmp_id" runat="server" Value="0" />
                          <asp:HiddenField ID="HiddenFieldDateofBirth" runat="server" />
                          <asp:HiddenField ID="HiddenFieldStartDate" runat="server" />
<asp:HiddenField ID="HiddenField_Employee_ID" runat="server" />

                          <asp:SqlDataSource ID="SqlDataSource_dest_ID" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                              SelectCommand="SELECT [DistrictCode], [DistrictName] FROM [DISTRICT] ORDER BY [DistrictName]">
                          </asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSource_tehsil_ID" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                              SelectCommand="SELECT [TehsilCode], [TehsilName] FROM [TEHSIL] WHERE ([districtCode] = @districtCode)">
                              <SelectParameters>
                                  <asp:ControlParameter ControlID="DropDownList_dist_ID" Name="districtCode" PropertyName="SelectedValue"
                                      Type="Int32" />
                              </SelectParameters>
                          </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_emp_Type" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT [Employee_Type_ID], [Type] FROM [Employee_Type]"></asp:SqlDataSource>
    <br />
    <asp:SqlDataSource ID="SqlDataSource_section" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT [Section_ID], [Section_Name], [Division_ID] FROM [Section] WHERE ([Division_ID] = @Division_ID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListSubDepartment" Name="Division_ID" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>


<asp:RegularExpressionValidator
                ControlToValidate="txthp3" CssClass="err" Display="Dynamic" ErrorMessage="Enter Valid Home Phone No." ID="RegularExpressionValidatorHPhoneNO" runat="server"
                ValidationExpression="\d{7}"></asp:RegularExpressionValidator>

<asp:RegularExpressionValidator
                ControlToValidate="txtop3" CssClass="err" ErrorMessage="Enter Valid Phone No." ID="RegularExpressionValidatorHphone" runat="server" ValidationExpression="\d{7}"></asp:RegularExpressionValidator>
<asp:RangeValidator ControlToValidate="txtday" CssClass="err"
                Display="Dynamic" ErrorMessage="Enter Valid Day" ID="RangeValidatorDay" MaximumValue="31" MinimumValue="01" runat="server" Type="Integer"></asp:RangeValidator>
<asp:RangeValidator ControlToValidate="txtmonth" CssClass="err"
                Display="Dynamic" ErrorMessage="Enter Valid Month" ID="RangeValidatorMonth" MaximumValue="12" MinimumValue="01" runat="server" Type="Integer"></asp:RangeValidator>
<asp:RangeValidator ControlToValidate="txtyear" CssClass="err"
                ErrorMessage="Enter Valid Year" ID="RangeValidatorYear" MinimumValue="1950" runat="server"></asp:RangeValidator>
<br />
 



 </asp:Content>