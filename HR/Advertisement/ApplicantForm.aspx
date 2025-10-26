<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="HR_ApplicantForm, App_Web_sbolykjk" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7DD5C3163F2CD0CB"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>


<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script src="jquery-1.12.3.js" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function () {
        var dateFrom = $('[id$="txtboxDateFrom"]').val();
        var sdfg = new Date(dateFrom);
        var dateEnd = new Date($('[id$="txtboxDateTo"]').val());
        var datediff = dateEnd - dateFrom;


        $('[id$="txtboxDateTo"]').blur(function () {
            var dateFrom = $('[id$="txtboxDateFrom"]').val();
            dateFrom = new Date(dateFrom);
            var dateEnd = new Date($('[id$="txtboxDateTo"]').val());
            var Yeardiff = dateEnd.getFullYear() - dateFrom.getFullYear();
            var Monthdiff = dateEnd.getMonth() - dateFrom.getMonth();
            var Daydiff = dateEnd.getDay() - dateFrom.getDay();
           
            $('[id$="txtboxExperience"]').val(Yeardiff + " Year ," +  Monthdiff+" Month " );
        }
        )

    });
</script>

<script type="text/JavaScript">

    function checkrequiredfield(a) {
        var txtEFName = document.getElementById("txtEFName").value;
        var txtEMName = document.getElementById("txtEMName").value;
        var txtELName = document.getElementById("TxtELName").value;
        if (document.getElementById("txtEFName").value.length == 0) {
            alert("Enter first name");
            document.getElementById("txtEFName").focus();
            return false;
        }
        else {
            for (i = 0; i < txtEFName.length; i++) {
                if (txtEFName.charAt(i) >= 0 || txtEFName.charAt(i) <= 9) {
                    alert("Integer not allowed in Employee First Name");
                    document.getElementById("txtEFName").focus();
                    return false;
                }
            }
        }
        if (document.getElementById("txtEMName").value.length != 0) {
            for (i = 0; i < txtEMName.length; i++) {
                if (txtEMName.charAt(i) >= 0 || txtEMName.charAt(i) <= 9) {
                    alert("Integer not allowed in Employee Middle Name");
                    document.getElementById("txtEMName").focus();
                    return false;
                }
            }
        }
        if (document.getElementById("TxtELName").value.length != 0) {
            for (i = 0; i < txtELName.length; i++) {
                if (txtELName.charAt(i) >= 0 || txtELName.charAt(i) <= 9) {
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
                        

 <%--ehsan code start--%>
 <div width="100%" align="center">

 
     <div class ="bxmain" ><h2><span>Application Form</span></h2> <%-- style="width:100%;"--%>
    <br />
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



 <%--ehsan code End--%>

<div class="bxmain"><h2><span>General Information</span></h2>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">

    <tr>
    <td align="right">Advertisement :&nbsp;</td>
    <td><asp:DropDownList ID="DDL_Advertisement" runat="server" 
            onselectedindexchanged="DDL_Advertisement_SelectedIndexChanged"></asp:DropDownList></td>
     
    </tr>
     <tr>
    <td align="right">Post :&nbsp;</td>
    <td><asp:DropDownList ID="DD_Posts" runat="server"></asp:DropDownList></td>
     
    </tr>
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
      <asp:Button ID="Button_attach_pic" runat="server" CausesValidation="False" 
            Text="Attach" CssClass="btn1" onclick="Button_attach_pic_Click" />
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
   <td width="19%" align="right"></td>
    <td  ><asp:RadioButtonList CssClass="radlist" ID="Relation" RepeatDirection="Horizontal" runat="server" >
      <asp:ListItem Selected="True">S/O</asp:ListItem>
      <asp:ListItem>D/O</asp:ListItem>
      <asp:ListItem>W/O</asp:ListItem>
     
    </asp:RadioButtonList></td>
  
  </tr>
    <tr>
    <td align="right"> Relation First Name :&nbsp;</td>
    <td><asp:TextBox ID="TextBoxRFName" CssClass="input_txt"  runat="server"></asp:TextBox>
      <span style="color: #ff0000">
        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1"
        runat="server" ControlToValidate="TextBoxRFName" ErrorMessage="*">*</asp:RequiredFieldValidator>--%>
      </span></td>
    </tr>
  
    <tr>
    <td align="right"> Relation Middle Name :&nbsp;</td>
    <td><asp:TextBox id="TextBoxRMName" CssClass="input_txt"  runat="server" ></asp:TextBox></td>
    </tr>
  
    <tr>
    <td align="right">Relation Last Name :&nbsp;</td>
    <td><asp:TextBox id="TextBoxRLName" runat="server" CssClass="input_txt" ></asp:TextBox>
      <span style="color: #ff0000"> 
    <%--    <asp:RequiredFieldValidator ID="RequiredFieldValidator3"
              runat="server" ControlToValidate="TextBoxRLName" ErrorMessage="*">*</asp:RequiredFieldValidator>--%>
      </span></td>
    </tr>
  
 
  

    <tr>
        <td align="right" >
            &nbsp;</td>
        <td>
            <asp:TextBox ID="TextBox_Emp_No" runat="server" CssClass="input_txt" Visible="False" 
                ></asp:TextBox>
            &nbsp;</td>
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
        <td width="62%">
         <asp:Label ID="Label6" runat="server" Text="DAY     - MONTH -    YEAR" ForeColor = "red"></asp:Label>
         <br />
        <asp:TextBox ID="TextBox_DOB_day" runat="server" CssClass="input_txt" Width="35px"></asp:TextBox>
          -
          <asp:TextBox ID="TextBox_DOB_Month" runat="server" CssClass="input_txt"  Width="25px"></asp:TextBox>
          -
          <asp:TextBox ID="TextBox_DOB_Year" runat="server" CssClass="input_txt"  Width="66px"></asp:TextBox>
           
          </td>
      </tr>
      <tr>
        <td align="right">Marital Status : </td>
        <td><asp:RadioButtonList CssClass="radlist" ID="RadioButtonList_marital_status" RepeatDirection="Horizontal" RepeatLayout="Flow" runat="server" TabIndex="9">
          <asp:ListItem Selected="True">Single</asp:ListItem>
          <asp:ListItem>Married</asp:ListItem>
         <%-- <asp:ListItem>Widow</asp:ListItem>
          <asp:ListItem>Divorced</asp:ListItem>--%>
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
        <td align="right">Domicile :</td>
        <td><asp:DropDownList DataSourceID="SqlDataSource_place_of_birth" DataTextField="DistrictName" DataValueField="DistrictCode" ID="DropDownList_Domicile" runat="server"  > </asp:DropDownList></td>
      </tr>
       <tr>
        <td width="38%" align="right">CNIC No. : </td>
        <td width="62%">
        <igtxt:webmaskedit id="TextBox_CNIC" runat="server" inputmask="#####-#######-#"></igtxt:webmaskedit>
          <span style="color: #ff0000">
          <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="TextBox_CNIC"
        ErrorMessage="Please Enter CNIC No">*</asp:RequiredFieldValidator></span></td>--%>
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
    <%--  <tr>
        <td width="38%" align="right">CNIC No. : </td>
        <td width="62%">
        <igtxt:webmaskedit id="TextBox_CNIC" runat="server" inputmask="#####-#######-#"></igtxt:webmaskedit>
          <span style="color: #ff0000"><asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="TextBox_CNIC"
        ErrorMessage="Please Enter CNIC No">*</asp:RequiredFieldValidator></span></td>
      </tr>--%>
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
      </table></td>
  </tr>
</table></div>
<div style="text-align:center;">
<asp:Button ID="btnSave" runat="server" Text="Save" onclick="btnSave_Click" />
</div>


<div runat="server" id="appDetails" class="bxmain"><h2>Add Experience and Qualification</h2><br />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td> 
     <asp:GridView AutoGenerateColumns="false" ID="gvdApplicantInfo" runat="server" Width="100%">
     <Columns>
     <asp:BoundField HeaderText="Name" DataField="Name" />
     <asp:BoundField HeaderText="CNIC" DataField="CNIC" />
     <asp:BoundField HeaderText="email_address" DataField="email_address" />
     <asp:BoundField HeaderText="Mobile_Number" DataField="Mobile_Number" />
     <asp:BoundField HeaderText="Present_address" DataField="Present_address" />
     <asp:BoundField HeaderText="DistrictName" DataField="DistrictName" />
     
      <asp:TemplateField HeaderText="Qualification">
     <ItemTemplate>
     <asp:LinkButton ID="lnkbtnQualification" runat="server" OnClick="lnkbtnQualification_Click" Text="Qualification"></asp:LinkButton>
     </ItemTemplate>
     </asp:TemplateField>

      

     <asp:TemplateField HeaderText="Experience">
     <ItemTemplate>
     <asp:LinkButton ID="lnkbtnExperience"  OnClick="lnkbtnExperience_Click" runat="server" Text="Experience"></asp:LinkButton>
     </ItemTemplate>
     </asp:TemplateField>

     </Columns>
     
     </asp:GridView>
     
      
   </td>
  </tr>
</table>
</div>

</div>

        <asp:Panel ID="panel" runat="server" Visible="false"  CssClass="lightbox_bg">
        <div class ="lightbox">
        <div  style="display:inline;float:left;width:100%;"  class="bxmain inner_content">
        <h2><span>Qualification</span></h2>
        <table>
        <tr style="line-height:1.5;">
            <td class="style2" style="font-weight:bold;text-align:right;">
                    Degree</td>
            <td colspan="">
                <asp:TextBox ID="txtboxDegreeName" runat="server"></asp:TextBox>
            </td>
            <td style="padding-left:20px;font-weight:bold;" class="style2" >
            Institue
                </td>
            <td>
                <asp:TextBox ID="txtboxInstitue" runat="server"></asp:TextBox>                                        
            </td>

            <td style="padding-left:20px;font-weight:bold;" class="style2" >
            Year
                </td>
            <td>
                <asp:TextBox ID="txtboxYear" runat="server"></asp:TextBox>                                        
            </td>
        </tr>
        <tr style="line-height:1.5;">
            <td class="style2" style="font-weight:bold;text-align:right;">
            Total
                </td>
            <td>
                <asp:TextBox ID="txtboxTotal" runat="server"></asp:TextBox>                                                                     
            </td>
            <td class="style2" style="font-weight:bold;padding-left:20px">
                 Obtained </td>
            <td>
                <asp:TextBox ID="txtboxObtained" runat="server"></asp:TextBox>
            </td>
            <td class="style2" style="font-weight:bold;padding-left:20px">
                 %</td>
            <td>
                <asp:TextBox ID="txtboxPercentage" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr style="line-height:3;">
            <td colspan="2">
                &nbsp;</td>
            <td style="padding-left:20px;text-align:center" colspan="2">
                <asp:Button ID="btnSaveQualification" runat="server" Text="Save" onclick="btnSaveQualification_Click" />
                <asp:Button ID="btnClose" runat="server" Text="Close" onclick="btnClose_Click" />
               <%-- <span style="padding-left:20px;"><asp:Label ID="lblmessagemain" runat="server" Text="Data is Save Successfully" Visible="false" ForeColor="Green" Font-Bold="true"></asp:Label></span>--%>
            </td>
        </tr>
                
                <tr>
                    <td colspan="10">
                        <asp:GridView ID="gvdQualification" runat="server" AutoGenerateColumns="true" 
                            Width="100%">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imagebtn" runat="server" 
                                            CommandArgument='<%# Eval("ID") %>' ImageUrl="~/Images/delete.png" 
                                            OnClick="imagebtn_Click" 
                                            OnClientClick="return Confirm('Do you want to delete this record?');" 
                                            Width="16" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <br />
                    </td>
                </tr>
            </caption>
    </table>
    </div>
    </div>
    </asp:Panel>




      <asp:Panel ID="panelExperience" runat="server" Visible="false"  CssClass="lightbox_bg">
        <div class ="lightbox">
        <div  style="display:inline;float:left;width:100%;"  class="bxmain inner_content">
        <h2><span>Experience</span></h2>
        <table>
        <tr style="line-height:1.5;">
            <td class="style2" style="font-weight:bold;text-align:right;">
                    Company Name</td>
            <td colspan="">
                <asp:TextBox ID="txtboxCompany" runat="server"></asp:TextBox>
            </td>
            <td style="padding-left:20px;font-weight:bold;" class="style2" >
            Designation
                </td>
            <td>
                <asp:TextBox ID="txtboxDesignation" runat="server"></asp:TextBox>                                        
            </td>

            
        </tr>
        <tr style="line-height:1.5;">
            <td class="style2" style="font-weight:bold;text-align:right;">
            Date From
                </td>
            <td>
                <asp:TextBox ID="txtboxDateFrom" TextMode="Date" runat="server"></asp:TextBox>                                                                     
            </td>
            <td class="style2" style="font-weight:bold;padding-left:20px">
                 Date To </td>
            <td>
                <asp:TextBox ID="txtboxDateTo" TextMode="Date" runat="server"></asp:TextBox>
            </td>
            
            <%--<td class="style2" style="font-weight:bold;padding-left:20px">
                 Experience</td>
            <td>
                <asp:TextBox ID="txtboxExperien" runat="server"></asp:TextBox>
            </td>--%>
        </tr>
        <tr>
        <td style="padding-left:20px;font-weight:bold;" class="style2" >
            Experience
                </td>
            <td>
                <asp:TextBox ID="txtboxExperience" runat="server"></asp:TextBox>                                        
            </td>
        </tr>
        <tr style="line-height:3;">
            <td colspan="2">
                &nbsp;</td>
            <td style="padding-left:20px;text-align:center" colspan="2">
                <asp:Button ID="btnSaveExperience" runat="server" Text="Save" onclick="btnSaveExperience_Click" />
                <asp:Button ID="btnCloseExperience" runat="server" Text="Close" onclick="btnCloseExperience_Click" />
               <%-- <span style="padding-left:20px;"><asp:Label ID="lblmessagemain" runat="server" Text="Data is Save Successfully" Visible="false" ForeColor="Green" Font-Bold="true"></asp:Label></span>--%>
            </td>
        </tr>            
                <tr>
                    <td colspan="10">
                        <asp:GridView ID="gvdForExperience" runat="server" AutoGenerateColumns="true" 
                            Width="100%">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imagebtn" runat="server" 
                                            CommandArgument='<%# Eval("ID") %>' ImageUrl="~/Images/delete.png" 
                                            OnClick="imagebtnExperience_Click" 
                                            OnClientClick="return Confirm('Do you want to delete this record?');" 
                                            Width="16" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <br />
                    </td>
                </tr>
            
    </table>
    </div>
    </div>
    </asp:Panel>













<asp:SqlDataSource ID="SqlDataSource_place_of_birth0" 
        runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                              
        SelectCommand="SELECT DistrictCode, DistrictName, ProvinceCode, Priority FROM DISTRICT ">
                          </asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceGender" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="SELECT Gender_ID, Gender FROM Gender" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"></asp:SqlDataSource>

                        <asp:SqlDataSource ID="SqlDataSource_emp_Type" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT [Employee_Type_ID], [Type] FROM [Employee_Type]"></asp:SqlDataSource>

         <asp:SqlDataSource ID="SqlDataSource_Nationality" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                              SelectCommand="SELECT [Nationality_ID], [Nationality_Name] FROM [Nationality]"></asp:SqlDataSource>
                              <asp:SqlDataSource ID="SqlDataSource_religion" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                              SelectCommand="SELECT [Religion_ID], [Religion_name] FROM [Religion]"></asp:SqlDataSource>

                               <asp:SqlDataSource ID="SqlDataSource_place_of_birth" 
        runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                              
        SelectCommand="SELECT DistrictCode, DistrictName, ProvinceCode, Priority FROM DISTRICT ">
                          </asp:SqlDataSource>
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

</asp:Content>

