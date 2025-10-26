  <%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage_admin.master" inherits="BloodDonorRegistration, App_Web_k10uyj0r" enableeventvalidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <style type="text/css">
    .input_txt {
        width: 150px;
    }

        .input_txt:focus {
            width: 150px;
        }

    .drop_date {
        width: 152px;
    }
</style>

<script type ="text/javascript"  language="javascript">
    function show(a) {

        document.form1.RBLrelation_0.checked = true

        if (document.form1.RBLprefix_1.checked) {

            document.form1.RBLrelation_1.checked = true
        }

        if (document.form1.RBLprefix_2.checked) {

            document.form1.RBLrelation_2.checked = true
        }
    }

    function resetform() {
        document.form1.reset();
        document.getElementById("dropdownlistdiagnosis").focus();
    }

    function showFocus(a) {
        document.getElementById("dropdownlistdiagnosis").disabled = true;
    }

    function showFocus1(a) {
        if (a.value.length != 0) {
            document.getElementById("dropdownlistdiagnosis").disabled = true;
        }
        else {
            document.getElementById("dropdownlistdiagnosis").disabled = false;
        }
    }
    function checkrequiredname(a) {
        var PFName = document.getElementById("textboxpfname").value;
        var PMName = document.getElementById("textboxpmname").value;
        var RFName = document.getElementById("textboxrfname").value;
        var RMName = document.getElementById("textboxrmname").value;
        if (document.getElementById("textboxpfname").value.length == 0) {
            alert("Enter first name");
            document.getElementById("textboxpfname").focus();
            return false;
        }
        if (document.getElementById("textboxrfname").value.length == 0) {
            alert("Enter Relation first name");
            document.getElementById("textboxrfname").focus();
            return false;
        }
        if (document.getElementById("textboxage").value.length == 0) {
            alert("Enter Age");
            document.getElementById("textboxage").focus();
            return false;
        }
        if (PFName - 0 == PFName) {
            alert("Enter the Correct Patient First Name");
            document.getElementById("textboxpfname").focus();
            return false;
        }
        if ((PMName.length - 0) != 0) {
            if (PMName - 0 == PMName) {
                alert("Enter the Correct Patient Middle Name");
                document.getElementById("textboxpmname").focus();
                return false;
            }
        }

        if (RFName - 0 == RFName) {
            alert("Enter the Correct Patient Relation First Name");
            document.getElementById("textboxrfname").focus();
            return false;
        }
        if ((RMName.length - 0) != RMName) {
            if (RMName - 0 == RMName) {
                alert("Enter the Correct Patient Relation Middle Name");
                document.getElementById("textboxrmname").focus();
                return false;
            }
        }
        return ForAge();

    }
    function checkrequiredrfname(a) {
        if (document.getElementById("textboxrfname").value.length == 0) {
            alert("Enter first name");
            document.getElementById("txtrfname").focus();
        }
    }

    function ForAge() {
        var age;
        age = document.getElementById("textboxage").value;
        if (age - 0 == age) {
            if ((age >= 1) && (age <= 150)) {
            }
            else {
                alert("Enter Correct Age");
                document.getElementById("textboxage").focus();
                return false;
            }
        }
        else {
            alert("Must Enter Integer ");
            document.getElementById("textboxage").focus();
            return false;
        }
    }
    function ForName() {
        alert("Hello");


    }
</script>

<body onLoad="getList(this)">

     <style type="text/css">
         .style1 {
             text-align: center;
         }
     </style>
     <%--<style type="text/css">
         .auto-style5 {
             width: 2%;
         }

         .auto-style6 {
             width: 3%;
         }

         .auto-style7 {
             width: 45%;
         }

         .auto-style8 {
             width: 150px;
         }

         .auto-style9 {
             width: 24%;
         }

         .auto-style10 {
             width: 25%;
         }

         .auto-style11 {
             width: 14%;
         }

         .auto-style12 {
             width: 126px;
         }

         .auto-style13 {
             width: 8%;
         }

         .auto-style14 {
             width: 9%;
         }
     </style>
     <style type="text/css">
         .auto-style1 {
             width: 191px;
         }
         .auto-style2 {
             width: 50px;
         }
         .auto-style3 {
             width: 300px;
         }
         .auto-style4 {
             width: 53px;
         }
     </style>--%>

    <script type="text/javascript">
        $(document).ready(function () {
            $("textboxpfname").on(keyup,function () {
                $(this).value = $(this).value.toUpperCase();
            });

        });
    </script>
     <%--<style type="text/css">
         .auto-style1 {
             width: 495px;
         }
         .auto-style2 {
             width: 485px;
         }
         .auto-style3 {
             width: 477px;
         }
         .auto-style4 {
             width: 473px;
         }
         .auto-style5 {
             width: 150px;
         }
         .auto-style8 {
             width: 150px;
         }
     </style>--%>
     <%--<style type="text/css">
         .auto-style1 {
             width: 495px;
         }
         .auto-style2 {
             width: 484px;
         }
         .auto-style3 {
             width: 483px;
         }
         .auto-style4 {
             width: 474px;
         }
         .auto-style5 {
             width: 150px;
         }
     </style>--%>
     <style type="text/css">
         .auto-style1 {
             width: 497px;
         }
         .auto-style2 {
             width: 482px;
         }
         .auto-style3 {
             width: 453px;
         }
         .auto-style4 {
             width: 444px;
         }
         .auto-style5 {
             width: 150px;
         }
     </style>
     <style type="text/css">
         .auto-style1 {
             width: 180px;
         }
     </style>
     <style type="text/css">
         .auto-style1 {
             width: 246px;
         }
     </style>
     <style type="text/css">
         .auto-style1 {
             width: 250px;
         }
     </style>
     <style type="text/css">
         .auto-style1 {
             color: #CC0000;
         }
     </style>
     <style type="text/css">
         .auto-style1 {
             width: 446px;
         }
         .auto-style2 {
             width: 434px;
         }
         .auto-style3 {
             width: 420px;
         }
         .auto-style4 {
             width: 417px;
         }
         .auto-style5 {
             width: 413px;
         }
         .auto-style6 {
             width: 409px;
         }
         .auto-style7 {
             width: 289px;
         }
     </style>
     <style type="text/css">
         .auto-style1 {
             width: 434px;
         }
         .auto-style2 {
             width: 422px;
         }
         .auto-style3 {
             width: 411px;
         }
         .auto-style4 {
             width: 409px;
         }
         .auto-style5 {
             width: 401px;
         }
         .auto-style6 {
             width: 398px;
         }
         .auto-style7 {
             width: 230px;
         }
     </style>
     <style type="text/css">
         .auto-style1 {
             color: #0066FF
         }
         .auto-style2 {
             font-size: 20px;
             color: #0066FF;
         }
     </style>
     <style type="text/css">
         .auto-style1 {
             color: #0066FF;
         }
     </style>
  </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h3 class="auto-style2">Donor Information</h3>
    <div class="blood_wrap">  
        <div class="bxmain inner_content" style=" width:100%; color: #FF0000;">          
<table border="0" cellspacing="0" cellpadding="0" class="tbl_form" >
  <tr>
    <td align="right" class="auto-style5"><span > Patient Name : </span></td>
    <td>
      <asp:RadioButtonList ID="RBLprefix" runat="server" RepeatLayout="Flow" 
                        RepeatDirection="Horizontal"   TabIndex="1" AutoPostBack="True" OnSelectedIndexChanged="RBLprefix_SelectedIndexChanged">
        <asp:ListItem Selected="True">Mr.</asp:ListItem>
        <asp:ListItem>Miss</asp:ListItem>
        <asp:ListItem>Mrs.</asp:ListItem>
      </asp:RadioButtonList>
    </td>
    <td align="right" visible="false"><%--Reg No :--%></td>
    <td width="16%">&nbsp;
        <asp:Label ID="Label_Registration_No" runat="server" CssClass="red" 
            Visible="False"></asp:Label>
    </td>

  </tr>
  <tr>
    <td align="right" class="auto-style5"><span style="font-size:14px">First Name :</span></td>
    <td><asp:TextBox ID="textboxpfname"  runat="server"  TabIndex="3" CssClass="input_txt" 
            BackColor="White"></asp:TextBox>
<span class="red"> *</span>
  <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="textboxpfname"
                    ErrorMessage="*"></asp:RequiredFieldValidator></td>

    <td align="right" class="auto-style4"><span style="font-size:14px">Last Name : </span></td>
    <td style="width:33%"><asp:TextBox ID="textboxplname" runat="server" CssClass="input_txt"    
                        Visible="true" TabIndex="5"></asp:TextBox>
<%--<span class="red"> *</span>--%>
  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="textboxplname"
                    ErrorMessage="*">
                    </asp:RequiredFieldValidator>--%>
                    </td>
  </tr>
  <tr>
    <td align="right" class="auto-style5" ><span style="font-size:14px">Age : </span></td>
    <td class="auto-style6">
      <asp:TextBox ID="textboxage" runat="server"   CssClass="input_txt"     Width="78px"  AccessKey="a" TabIndex="10" ></asp:TextBox>
     
               <span class="red">*</span>  <span style="font-size:10px;">Years</span>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="textboxage"
                    ErrorMessage="*"></asp:RequiredFieldValidator>
     </td>
    <td align="right"><span style="font-size:14px">Gender : </span></td>
    <td>
      <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatLayout="Flow" 
                    RepeatColumns="2" TabIndex="11">
        <asp:ListItem Selected="True">Male</asp:ListItem>
        <asp:ListItem>Female</asp:ListItem>
      </asp:RadioButtonList>
    </td>

  </tr>
    <tr>
        <td align="right" class="auto-style5"><span style="font-size:14px">Occupation : </span></td>
        <td>
      <asp:TextBox ID="TextBox_Occupation" runat="server" CssClass="input_txt" TabIndex="13" ></asp:TextBox>
        </td>
        <td align="right" style="width:20%"><span style="font-size:14px">Donor Type :</span> 
        </td>
        <td>
      <asp:DropDownList ID="DropDownList_type_of_donor" runat="server"   
                    DataSourceID="SqlDataSource_Type_Of_Donor" DataTextField="Type_Of_Donor" DataValueField="Type_Of_Donor" TabIndex="12" AutoPostBack="True" OnSelectedIndexChanged="DropDownList_type_of_donor_SelectedIndexChanged"  Width="152px"> </asp:DropDownList>
        </td>
    </tr>

      <tr>
          
    <td align="right" class="auto-style5">
<%--<span class="red"> *</span>
<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="TextBox_Occupation"
                    ErrorMessage="*"></asp:RequiredFieldValidator>--%>
    </td>
        <td >
            </td>
    <td align="right">
       <asp:Label ID="Label_ReferenceNo" runat="server" Text="Reference No:" Visible="false"></asp:Label>
    </td>
    <td> 
      <asp:TextBox ID="TextBox_refrence_id" runat="server"  TabIndex="13"  
            CssClass="input_txt" OnTextChanged="TextBox_refrence_id_TextChanged" 
            Visible="false"></asp:TextBox>
        <asp:Label ID="Label_Alert" runat="server" ForeColor="Red" Text="Enter Patient Reg No."
                Visible="false"></asp:Label>
    </td>
  </tr>
    <tr>
        <td class="auto-style5"></td>
        <td></td>
        <td align="right" style = "display:none">Sample No : </td>
        <td>
            <asp:Label ID="Label_sample_No" runat="server"  CssClass="red" Visible="False"></asp:Label>
        </td>
    </tr>

</table>
        </div>
<br />

<div class="bxmain inner_content" style="width:100%;">
    <h2 class="auto-style1">Personal Info</h2>
<div class="bxmain" style="width:100%;">
<table border="0" cellspacing="0" cellpadding="0" class="tbl_form" >
  <tr>
    <td align="right" class="auto-style1" ><span style="font-size:14px">CNIC # :</span>
        </td>
    <td class="auto-style3">
         <asp:TextBox ID="textboxnic" runat="server" MaxLength="13" Text="" CssClass="input_txt"     Width="152px"  TabIndex="14" ></asp:TextBox>
      </td>
    <td align="right" class="auto-style2" ><span style="font-size:14px">Country:</span></td>
    <td >
      <asp:DropDownList ID="country" runat="server"   AutoPostBack="True"  
            Width="152px" DataSourceID="SqlDataSource3" DataTextField="CountryName" 
            DataValueField="CountryCode" 
            OnSelectedIndexChanged="country_SelectedIndexChanged" TabIndex="16" > </asp:DropDownList>
      <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    SelectCommand="select 0 as [CountryCode],'' as [CountryName] union SELECT [CountryCode], [CountryName] FROM [Country]"></asp:SqlDataSource>
      </td>
    <td align="right" class="auto-style4"></td>
    <td > 
        
    </td>
  </tr>
  <tr>
    <td align="right" class="auto-style1"><span style="font-size:14px">Province: </span></td>
    <td class="auto-style3">
        <asp:DropDownList ID="Province" runat="server" 
                       TabIndex="17" AutoPostBack="True" DataSourceID="SqlDataSource4"  Width="152px" DataTextField="ProvinceName"
             DataValueField="ProvinceCode" OnSelectedIndexChanged="Province_SelectedIndexChanged"> </asp:DropDownList>
      <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    SelectCommand=" SELECT ProvinceCode, ProvinceName FROM Province WHERE(CountryCode =@CountryCode)">
        <SelectParameters>
          <asp:ControlParameter ControlID="country" Name="CountryCode" PropertyName="SelectedValue" />
        </SelectParameters>
      </asp:SqlDataSource>
      <asp:TextBox ID="textboxprovince2" runat="server" Visible="False"></asp:TextBox>
      <%--<asp:DropDownList ID="district" runat="server" TabIndex="18" AutoPostBack="True" DataSourceID="SqlDataSource5" 
          DataTextField="DistrictName" Width="152px" DataValueField="DistrictCode" OnSelectedIndexChanged="district_SelectedIndexChanged"> </asp:DropDownList>
      <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    SelectCommand="SELECT DistrictCode,DistrictName FROM DISTRICT WHERE (ProvinceCode = @ProvinceCode)">
        <SelectParameters>
          <asp:ControlParameter ControlID="Province" Name="ProvinceCode" PropertyName="SelectedValue" />
        </SelectParameters>
      </asp:SqlDataSource>
        <br />--%>
    </td>
       <td align="right" class="auto-style4" >&nbsp;<span style="font-size:14px">District:</span></td>
    <td >
        <asp:DropDownList ID="district" runat="server" TabIndex="18" AutoPostBack="True" DataSourceID="SqlDataSource5" 
          DataTextField="DistrictName" Width="152px" DataValueField="DistrictCode" OnSelectedIndexChanged="district_SelectedIndexChanged"> </asp:DropDownList>
      <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    SelectCommand="SELECT DistrictCode,DistrictName FROM DISTRICT WHERE (ProvinceCode = @ProvinceCode)">
        <SelectParameters>
          <asp:ControlParameter ControlID="Province" Name="ProvinceCode" PropertyName="SelectedValue" />
        </SelectParameters>
      </asp:SqlDataSource>
        <br />
   
      <br />
    </td>
    <td align="right" style="display:none" class="auto-style2">&nbsp;Tehsil   : </td>
    <td style="display:none">
      <asp:DropDownList ID="tehsil" runat="server"  Width="152px"   TabIndex="19" DataSourceID="SqlDataSource6" DataTextField="TehsilName" DataValueField="TehsilCode" AutoPostBack="True"> </asp:DropDownList>
      <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    SelectCommand=" SELECT TehsilCode,TehsilName FROM TEHSIL ">
        <SelectParameters>
          <asp:ControlParameter ControlID="district" Name="districtCode" PropertyName="SelectedValue" />
        </SelectParameters>
      </asp:SqlDataSource>
    </td>
   
  </tr>

    <tr style="display:none">
    <td align="right" style="display:none" class="auto-style1">Relation Name :</td>
    <td style="display:none" class="auto-style3">
      <asp:RadioButtonList ID="RBLrelation" runat="server" 
                       RepeatDirection="Horizontal" RepeatLayout="Flow"
                        TabIndex="6">
        <asp:ListItem Selected="True">S/O</asp:ListItem>
        <asp:ListItem>D/O</asp:ListItem>
        <asp:ListItem>W/O</asp:ListItem>
      </asp:RadioButtonList>
    </td>
    <td align="right" class="auto-style2">&nbsp;</td>
    <td>&nbsp;</td>
    <td align="right" class="auto-style4">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right" style="display:none" class="auto-style1">First Name : </td>
    <td style="display:none" class="auto-style3"><asp:TextBox ID="textboxrfname" runat="server"  CssClass="input_txt"      TabIndex="7"></asp:TextBox>
<%--<span class="red"> *</span>
  <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="textboxrfname"
                    ErrorMessage="*"></asp:RequiredFieldValidator>--%></td>
    <td align="right" style="display:none" class="auto-style2">Middle Name : </td>
    <td style="display:none">
      <asp:TextBox ID="textboxrmname" runat="server"   Font-Names="Verdana"
                     CssClass="input_txt"      TabIndex="8"></asp:TextBox>
    </td>
    <td align="right" style="display:none" class="auto-style4">Last Name : </td>
    <td style="display:none">
      <asp:TextBox ID="textboxrlname" runat="server"    
                     CssClass="input_txt"      Visible="true" TabIndex="9"></asp:TextBox>
<%--<span class="red"> *</span>
<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="textboxrlname"
                    ErrorMessage="*"></asp:RequiredFieldValidator>--%>
    </td>
  </tr>

    <tr>
    <td align="Right" class="auto-style1">&nbsp;<span style="font-size:14px">Address :</span></td>
    <td class="auto-style3">
        <asp:TextBox ID="textboxHouseNo" runat="server" CssClass="input_txt" 
            TabIndex="20"></asp:TextBox>
      </td>
        <td class="AmountAlign">
            Phone&nbsp;#:
        </td>
        <td>
            <asp:TextBox ID="TextBox_Mob" runat="server" MaxLength="11" TabIndex="19"></asp:TextBox>
        </td>
    <td align="right" style ="display:none" class="auto-style2"><span style="font-size:14px">Phone No.    :</td>
    <td style='display:none'>
      <asp:TextBox ID="textboxcountrycode" runat="server"    
                      Width="30px"  >0092</asp:TextBox>
-<asp:TextBox ID="textboxphonecode" runat="server"  
                            Width="30px"  >42</asp:TextBox>
&nbsp;-<asp:TextBox ID="textboxphoneno" runat="server"
                                  MaxLength="7" Width="65px"  TabIndex="21"></asp:TextBox>
      </td>
    <td align="right" style ="display:none" class="auto-style4" >&nbsp;</td>
    <td align="right"  >
        &nbsp;</td>
  </tr>
</table>
</div>
 <div class="bxmain inner_content" style="width:100%;">
    <h1 class="h1"><span class="visit">Volunteer</span><h1/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
    <tr>
    <td align="right" align="left" class="auto-style7" ><span style="font-size:14px">Roll # :</span></td>
    <td width="16%" align="left">
        <asp:TextBox ID="TextBox_roll" runat="server" TabIndex="21" style="margin-left: 0px" Width="144px"></asp:TextBox></td>
        <td align="right" style="width:30%"><span style="font-size:14px">Class:</span></td>
        <td>
        <asp:TextBox ID="TextBox_class" runat="server" TabIndex="22" style="margin-left: 0px; text-align: right;" Width="140px"></asp:TextBox></td>
    
    </tr>
</table>

</div>

 <div class="bxmain inner_content" style="width:100%;">
<h1 class="h1"><span>Past Medical History</span></h1>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
    <tr>
    <td align="right" style="width:22%"><span style="font-size:14px">Past Medical History &nbsp;:</span></td>
    <td>
        <asp:TextBox ID="TextBox_PH" runat="server" TabIndex="23" Width="145px"></asp:TextBox>
        </td>
    </tr>
</table>
</div>

<div class="bxmain inner_content" style="width:100%;">
<h1 class="h1"><span>&nbsp;H/O Previous History</span></h1>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
   
  <tr>
    <td align="right" style="width:22%"><span style="font-size:14px">Date &nbsp;:</span></td>
    <td align="left">
        &nbsp;
      <span style="font-size:9px; color:#999;;">
          <igsch:webdatechooser id="WebDateChooser1" runat="server" 
            cssClass="drop_date"  Width="152px" TabIndex="24">
<CalendarLayout Culture="English (United Kingdom)"></CalendarLayout>

</igsch:webdatechooser>
          <asp:HiddenField ID="HiddenField_previous_date" runat="server" />
          dd mm yyyy</span></td>
      
    <td align="right"><span style="font-size:14px">Place &nbsp;:</span></td>
    <td align="left" style="width:33%">
      <asp:TextBox ID="TextBox_previous_place" runat="server"  CssClass="input_txt"
                        TabIndex="25" ></asp:TextBox>
    </td>
    
    
  </tr>
  <tr>
    <td align="right"><span style="font-size:14px">Dizziness &nbsp;:</span></td>
    <td class="auto-style14">
      <asp:CheckBox ID="CheckBox_previous_Dizziness" runat="server" TabIndex="27" />      
    </td>
      <td align="right" class="auto-style6"><span style="font-size:14px">Fainting &nbsp;:</span></td>
      <td width="16%">
      <asp:CheckBox ID="CheckBox_previous_fainting" runat="server" TabIndex="26" />      
    </td>
  </tr>
</table>
</div><br />

<div align="center">      
  <asp:Button ID="ButtonSave" runat="server" Text="Save" TabIndex="28" 
        OnClick="ButtonSave_Click" /></div>        
        <br />

<asp:HiddenField ID="HiddenField_country" runat="server" Value="12" />
            <asp:HiddenField ID="HiddenField_province" runat="server" Value="12" />
            <asp:HiddenField ID="HiddenField_district" runat="server" Value="12" />
            <asp:HiddenField ID="HiddenField_tehsil" runat="server" Value="12" />
            <asp:HiddenField ID="HiddenField_Emp_Id" runat="server" />
            <asp:HiddenField ID="HiddenField_Dept_Id" runat="server" />
            <asp:HiddenField ID="HiddenField_Pt_YearlyNo" runat="server" />
            <asp:SqlDataSource ID="SqlDataSource_info" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>" InsertCommand="BloodBank_insert_donor_Info" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>">
                <InsertParameters>
                    <asp:ControlParameter ControlID="Label_Registration_No"  Name="Donor_Registration_No" PropertyName="Text" Type="String" />
                    
                    <asp:ControlParameter ControlID="RBLprefix"  Name="Prefix" PropertyName="SelectedValue" Type="String" />
                    
                    <asp:ControlParameter ControlID="textboxpfname" Name="First_Name" PropertyName="Text" Type="String" />
                    
                    <%--<asp:ControlParameter ControlID="textboxpmname" Name="Middle_Name" PropertyName="Text" Type="String" />--%>
                    
                    <asp:ControlParameter ControlID="textboxplname" Name="Last_Name" PropertyName="Text" Type="String" />
                    
                    <asp:ControlParameter ControlID="RBLrelation" Name="Relation" PropertyName="SelectedValue" Type="String" />
                    
                    <asp:ControlParameter ControlID="textboxrfname" Name="Relation_First_Name" PropertyName="Text" Type="String" />
                    
                    <%--<asp:ControlParameter ControlID="textboxrmname" Name="Relation_Middle_Name" PropertyName="Text" Type="String" />--%>
                    <asp:ControlParameter ControlID="textboxrlname" Name="Relation_Last_Name" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="textboxage" Name="Age" PropertyName="Text" Type="Int32" />
                    <asp:ControlParameter ControlID="RadioButtonList1" Name="Sex" PropertyName="SelectedValue" Type="String" />
                    
                    <asp:ControlParameter ControlID="DropDownList_type_of_donor"  Name="Type_Of_Donor" PropertyName="SelectedValue" Type="String" />
                    <asp:ControlParameter ControlID="country"  Name="Country_Code" PropertyName="SelectedValue" Type="Int32" />
                    
                    <asp:ControlParameter ControlID="Province" Name="Province_Code" PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="district" Name="District_Code" PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="tehsil" Name="Tehsil_Code" PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="textboxHouseNo" Name="Address" PropertyName="Text" Type="String" />

                    <asp:ControlParameter ControlID="TextBox_Occupation"  Name="Occupation" PropertyName="Text" Type="String" />
                   
                     <asp:ControlParameter ControlID="textboxphoneno"  Name="Phone" PropertyName="Text" Type="String" />
                     <asp:ControlParameter ControlID="HiddenField_NIC"  Name="NIC_No" PropertyName="Value" Type="String" />
                     <asp:ControlParameter ControlID="HiddenField_Emp_Id"  Name="Emp_Id" PropertyName="Value" Type="String" />
                    <asp:ControlParameter ControlID="Label_sample_No"  Name="Sample_No" PropertyName="Text" Type="String" />
                    <asp:QueryStringParameter Name="Ref_Patient_Reg_No" QueryStringField="Reg_NO" Type="String" />
                    <asp:ControlParameter ControlID="HiddenField_previous_date" Name="Previous_Date" PropertyName="Value" Type="DateTime" />
                    <asp:ControlParameter ControlID="TextBox_previous_place" Name="Previous_Place" PropertyName="Text" Type="String" />
                    
                    <asp:ControlParameter ControlID="CheckBox_previous_fainting" Name="Previous_Fainting"
                        PropertyName="Checked" Type="Boolean" />
                    <asp:ControlParameter ControlID="CheckBox_previous_Dizziness" Name="Previous_Dizziness"
                        PropertyName="Checked" Type="Boolean" />
                    <asp:ControlParameter ControlID="HiddenField_Pt_YearlyNo" Name="Pt_YearlyNo" PropertyName="Value"
                        Type="Int32" />
                    <asp:ControlParameter ControlID="HiddenField_Request_Id" Name="Request_Id" PropertyName="Value"
                        Type="Int32" />
                    <asp:ControlParameter ControlID="TextBox_refrence_id"  Name="Pt_RegNo" PropertyName="Text" Type="String" />
                    <asp:Parameter DefaultValue="Assesment/Bleed" Name="Decision" Type="String" />
                    <asp:ControlParameter ControlID="TextBox_roll" Name="Roll_No" 
                        PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="TextBox_class" Name="class" 
                        PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="TextBox_PH" Name="PM_History" 
                        PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="TextBox_Mob" Name="Mobile_No" 
                        PropertyName="Text" Type="String" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:HiddenField ID="HiddenField_Request_Id" runat="server" />
            <asp:SqlDataSource ID="SqlDataSource_forward" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                InsertCommand="pt_InnerDepartment_PatientForward" InsertCommandType="StoredProcedure"
                ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>">
                <InsertParameters>
                    <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                    <asp:ControlParameter ControlID="Label_Registration_No" Name="RegNo" PropertyName="Text"
                        Type="String" />
                    <asp:ControlParameter ControlID="HiddenField_Emp_Id" Name="EmpID" PropertyName="Value"
                        Type="String" />
                    <asp:Parameter DefaultValue="0" Name="PayID" Type="Decimal" />
                    <asp:Parameter DefaultValue="17" Name="ToSubDept" Type="Int32" />
                    <asp:ControlParameter ControlID="HiddenField_Dept_Id"  Name="SendingDept"
                        PropertyName="Value" Type="Int32" />
                    <asp:Parameter DefaultValue="6" Name="iRequestTypeTo" Type="Int32" />
                    <asp:Parameter DefaultValue="6" Name="iRequestTypeBy" Type="Int32" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource_Type_Of_Donor" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                SelectCommand="SELECT [Type_Of_Donor] FROM [Donor_Type]" ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>"></asp:SqlDataSource>
            <asp:HiddenField ID="HiddenField_NIC" runat="server" />
    <asp:HiddenField ID="HiddenField_Pt_RegNo" runat="server" />
<br />
</div>

  </asp:Content>