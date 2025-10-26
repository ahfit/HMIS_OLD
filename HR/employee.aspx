<%@ page language="VB" autoeventwireup="true" masterpagefile="~/hacims_masterpage_admin.master" inherits="employee"  CodeFile="employee.aspx.vb"
    enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>





<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7DD5C3163F2CD0CB"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI" tagprefix="asp" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
      <script src="../SpryAssets/mycollaps.js" type="text/javascript"></script>
    <link href="../SpryAssets/mycollaps.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../css_hacims/maskito.js"></script>
    <script src="../css_hacims/ck.js" type="text/javascript"></script>
    <script type="text/JavaScript">
        $(document).ready(function () {

            calculate_age();
            $("#ctl00_ContentPlaceHolder1_TextBox_mobile_No").val() == "";

            $("#ctl00_ContentPlaceHolder1_TextBox_mobile_No").mask("9999-9999999");
            $("#ctl00_ContentPlaceHolder1_txtEmgMobile").val() == "";

            $("#ctl00_ContentPlaceHolder1_txtEmgMobile").mask("9999-9999999");

            //Salary Panel

            $("#stext,#sbtn").hide();

            $("input[name='ctl00$ContentPlaceHolder1$checkBoxIsConsultant']").change(function () {
                $("#stext,#sbtn").toggle();

            });



        })
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

        function validateEmail(emailField) {
            var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;

            if (reg.test(emailField.value) == false) {
                alert('Invalid Email Address');
                return false;
            }

            return true;

        }




        function calculate_age() {
            //debugger;

            var birth_day = document.getElementById('<%=TextBox_DOB_day.ClientID %>').value;
            var birth_month = document.getElementById('<%=TextBox_DOB_Month.ClientID %>').value;
            var birth_year = document.getElementById('<%=TextBox_DOB_Year.ClientID %>').value;
            today_date = new Date();
            today_year = today_date.getFullYear();
            today_month = today_date.getMonth();
            today_day = today_date.getDate();
            age = today_year - birth_year;

            if (today_month < (birth_month - 1)) {
                age--;
            }
            if (((birth_month - 1) == today_month) && (today_day < birth_day)) {
                age--;
            }

            document.getElementById('<%=lblAge.ClientID %>').innerHTML = age;

            if (age < 18) {

                document.getElementById('<%=underAge.ClientID %>').innerHTML = "Under Age";
            }
            else {
                document.getElementById('<%=underAge.ClientID %>').innerHTML = "";
            }

         <%--   if (age < 18) {
                var result = str.fontcolor("green");
               
                document.getElementById('<%=lblAge.ClientID %>').innerHTML.fontcolor = 'blue';
                document.getElementById("lblAge").innerHTML = result;

            }--%>

        }
    </script>

    <script type="text/javascript" language="javascript">

        function txtChange(a) {

            var txt = document.getElementById("<%=TextBox_CNIC.ClientID%>");
            var flag = document.getElementById("<%=HiddenField_Cnic_flag.ClientID%>");

            if (flag.value <= txt.value.length) {
                if (txt.value.length == 5) {
                    txt.value = txt.value + "-";

                }
                if (txt.value.length == 13) {
                    txt.value = txt.value + "-";

                }
            }
            flag.value = txt.value.length

        }

 </script>


        <script type="text/javascript">
            function checkCNIC() {
                //alert($("#<% =TextBox_CNIC.ClientID %>").val());
                $.ajax({

                    type: "POST",
                    url: "Employee.aspx/checkCNIC",
                    data: "{cnicNo: '" + $("#<% =TextBox_CNIC.ClientID %>").val() + "' }",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: onSuccess,
                    failure: function (AjaxResponse) {
                        document.getElementById("lblCNIC").innerHTML = AjaxResponse.d;
                    }
                });

                function onSuccess(AjaxResponse) {
                    var msg = AjaxResponse.d;
                    if (msg != "ok") {
                        $("span[id$='lblCNIC']").text(msg);
                        $("span[id$='lblCNIC']").css('color', 'red');

                        //alert(AjaxResponse.d);
                        $("input[id$='TextBox_CNIC']").css('color', 'red');
                        //$("[id$='TextBox_CNIC_No']").focus();
                    }
                    else {
                        $("span[id$='lblCNIC']").text('');
                        $("span[id$='lblCNIC']").css('color', 'black');
                        $("input[id$='TextBox_CNIC']").css('color', 'black');
                    }

                }
            }

 </script>


   
           <script type="text/javascript">
               function checkMobileNo() {
                   //alert("Start");
                   $.ajax({

                       type: "POST",
                       url: "Employee.aspx/checkMobileNo",
                       data: "{mobileNo: '" + $("#<% =TextBox_mobile_No.ClientID %>").val() + "' }",
                       contentType: "application/json; charset=utf-8",
                       dataType: "json",
                       success: onSuccess,
                       failure: function (AjaxResponse) {
                           $("span[id$='Label_Mobile']").text(AjaxResponse.d);
                       }
                   });

                   function onSuccess(AjaxResponse) {
                       var msg = AjaxResponse.d;
                       if (msg != "ok") {
                           $("span[id$='Label_Mobile']").text(msg);
                           $("span[id$='Label_Mobile']").css('color', 'red');
                           alert(msg);
                           $("input[id$='textboxmcode']").css('color', 'red');
                           //$("[id$='TextBox_CNIC_No']").focus();
                       }
                       else {
                           $("span[id$='Label_Mobile']").text('');
                           $("span[id$='Label_Mobile']").css('color', 'black');
                           $("input[id$='textboxmcode']").css('color', 'black');
                       }

                   }
               }

 </script>
    <script type="text/javascript">
        function ValidateAlpha(evt) {
            var keyCode = (evt.which) ? evt.which : evt.keyCode
            if ((keyCode < 65 || keyCode > 90) && (keyCode < 97 || keyCode > 123) && keyCode != 32)

                return false;
            return true;
        }

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode
            return !(charCode > 31 && (charCode < 48 || charCode > 57));
        }



    </script>

    <style type="text/css">
        .LinkStyle {
            padding-right: 10px;
            padding-left: 5px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <script src="validate.js" type="text/javascript"></script>
    <asp:HiddenField ID="HiddenFieldPage_Name" runat="server" />
    <asp:HiddenField ID="HiddenFieldPage" runat="server" />
 <asp:Label ID="LabelDoctorName" runat="server" Visible="false" ></asp:Label> <asp:Label ID="Label_SubDepartment" runat="server"  Text="Label_SubDepartment" Visible="False"></asp:Label>
 <asp:Label ID="LabelDate" runat="server" Visible="false" ></asp:Label>
    <asp:Label ID="Label_message" runat="server" CssClass="err" ></asp:Label>
<div class="bxmain inner_content" style="width:100%;">

      <div class="" style="text-align:left; width:100%;background-color:transparent; border:none; font-weight:bold;">
<h2><span>  <asp:Label ID="lblheading" runat="server" text="Employee Creation"></asp:Label></span> </h2>
</div>
    <br />
    <asp:Label ID="LblInvalidDate" runat="server" CssClass="err"></asp:Label>
    <asp:Label ID="Label1" runat="server" CssClass="err"></asp:Label>
    
    <%--ehsan code start--%>
    <div align="center">
        <div class="bxmain inner_content" style="width: 100%;  margin-top: -2em;">
            <h2>
                <span>Employee Additional Information</span></h2>
            <%-- style="width:100%;"--%>
            <br />
            <asp:HyperLink ID="hlnkEmployeeEducation" runat="Server" Text="Education" CssClass="LinkStyle"
                Target="_blank" NavigateUrl="~/hr/Education.aspx?PName=Education&MName=Edit Employee&Emp_Id=0"
                Visible="false"></asp:HyperLink>
            <asp:HyperLink ID="hlnkEmployeeCertifications" runat="Server" Text="Certification"
                CssClass="LinkStyle" Target="_blank" NavigateUrl="~/hr/Certification.aspx?PName=Certifications&MName=Edit Employee&Emp_Id=0"
                Visible="false"></asp:HyperLink>
            <asp:HyperLink ID="hlnkEmployeeSkills" runat="Server" Text="Skills" CssClass="LinkStyle"
                Target="_blank" NavigateUrl="~/hr/skills.aspx?PName=Skills&MName=Edit Employee&Emp_Id=0"
                Visible="false"></asp:HyperLink>
            <asp:HyperLink ID="hlnkAdditionalInfo" runat="Server" Text="Additional Info" CssClass="LinkStyle"
                Target="_blank" NavigateUrl="~/hr/Additional_Info.aspx?PName=Additional Info&MName=Edit Employee&Emp_Id=0"
                Visible="false"></asp:HyperLink>
            <asp:HyperLink ID="hlnkEmployeeRelationship" runat="Server" Text="Relationship" CssClass="LinkStyle"
                Target="_blank" NavigateUrl="~/hr/ADD_relationship.aspx?PName=Relationship&MName=Edit Employee&Emp_Id=0"
                Visible="false"></asp:HyperLink>
            <asp:HyperLink ID="hlnkEmployeeDocuments" runat="Server" Text="Documents" CssClass="LinkStyle"
                Target="_blank" NavigateUrl="~/hr/attach_Documents_Server.aspx?PName=Documents&MName=Edit Employee&Emp_Id=0"
                Visible="false"></asp:HyperLink>
            <asp:HyperLink ID="hlnkEmployeeExperience" runat="Server" Text="Experience" CssClass="LinkStyle"
                Target="_blank" NavigateUrl="~/hr/Experience.aspx?PName=Documents&MName=Edit Employee&Emp_Id=0"
                Visible="false"></asp:HyperLink>
        </div>
        <%--ehsan code End--%>
        <div class="bxmain inner_content" style="width: 100%;">
            <h2>
                <span>General Information</span></h2>
             <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                <tr>
                    <td width="50%" align="right">
            <table width="100%" border="0" align="right" cellspacing="0" cellpadding="0" class="tbl_form" style="    margin-right: -18%;">
              
                <tr>
                    <td width="19%" align="right">
                        Title :&nbsp;
                    </td>
                    <td>
                        <asp:RadioButtonList CssClass="radlist" ID="prefix" AutoPostBack="true" RepeatDirection="Horizontal" OnSelectedIndexChanged="prefix_SelectedIndexChanged"
                            runat="server">
                            <asp:ListItem Value="Mr." Selected="True">Mr.</asp:ListItem>
                            <asp:ListItem Value="Ms.">Ms.</asp:ListItem>
                            <asp:ListItem Value="Dr">Dr.</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>

                 
                </tr>
                <tr>
                    <td align="right">
                        Employee No :&nbsp;
                    </td>
                    <td >
                        <span style="color: #ff0000">
                            <asp:TextBox ID="TextBox_Emp_Number" runat="server" TextMode="Number" CssClass="input_txt" AutoPostBack="True"></asp:TextBox>
                            <asp:Label ID="Label5" runat="server" Font-Bold="True" ForeColor="#FF0066"></asp:Label>
                        </span>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox_Emp_Number"
                            ErrorMessage=""></asp:RequiredFieldValidator>--%>
                        <%-- ehsan code start--%>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="TextBox_Emp_Number"
                            ErrorMessage="Must enter number" Operator="DataTypeCheck" Type="Integer"></asp:CompareValidator>
                        <%-- ehsan code end--%>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        First Name :&nbsp;
                    </td>
                    <td>
                        <asp:TextBox ID="txtEFName" runat="server" CssClass="input_txt" Style="background-color: #f9dde2;"
                            SkinID="captxt" onKeyPress="return ValidateAlpha(event);" required></asp:TextBox>
                        <span style="color: #ff0000">*</span>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtEFName"
                            ErrorMessage="*">*</asp:RequiredFieldValidator>
                    </td>
                  
                </tr>
                <tr>
                    <td align="right">
                        Middle Name :&nbsp;
                    </td>
                    <td>
                        <asp:TextBox ID="txtEMName" runat="server" CssClass="input_txt" SkinID="captxt" onKeyPress="return ValidateAlpha(event);" ></asp:TextBox>
                    </td>

                    
                </tr>
                <tr>
                    <td align="right">
                        Last Name :&nbsp;
                    </td>
                    <td>
                        <asp:TextBox ID="TxtELName" runat="server" CssClass="input_txt" SkinID="captxt" Style="background-color: #f9dde2;" onKeyPress="return ValidateAlpha(event);" required></asp:TextBox>
                        <span style="color: #ff0000">* </span>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="TxtELName"
                            ErrorMessage="*">*</asp:RequiredFieldValidator>
                    </td>

                   
                </tr>
                <tr>
                    <td align="right">
                        Attach Picture :&nbsp;
                    </td>
                    <td>
                        <asp:FileUpload ID="FileUpload_image"  runat="server" Width="80px" style="margin-left: 1em;" />
                        <asp:Button ID="Button_attach_pic" style="height: 2em; margin-top: -1.8em; margin-left: 9em;" runat="server" CausesValidation="False" Text="Attach"
                            CssClass="btn1" />
                        <asp:HiddenField ID="HiddenField_ImageAttached" runat="server" Value="0" />
                    </td>

                     
                </tr>
              
                <tr>
                    <td align="right">
                        Gender :&nbsp;
                    </td>
                    <td>
                        <asp:DropDownList DataSourceID="SqlDataSourceGender" DataTextField="Gender" DataValueField="Gender_ID"
                            ID="Dropdownlistsex" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
              
                    <tr id="trContractStartDate" runat="server" style="display:none;">
                        <td align="right">Contract Start Date :
                        </td>
                        <td>
                            <igsch:WebDateChooser ID="ContractSdate" runat="server">
                            </igsch:WebDateChooser>

                                <asp:HiddenField ID="HiddenField_ContractSdate" runat="server" />
                       

                        </td>

                     
                    </tr>
                
                <tr>
                    
                    <td>
                        <asp:TextBox ID="TextBox_Emp_No" runat="server" CssClass="input_txt" Visible="False"></asp:TextBox>
                 
                    </td>
                </tr>
            </table>
                        </td>
                    <td width="50%" align="center">
             <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form" style="margin-left: 12%;">
              
                <tr>
                      <td width="19%" align="right">
                    </td>
                    <td>
                        <asp:RadioButtonList CssClass="radlist" ID="RadioButtonList1" RepeatDirection="Horizontal"
                            runat="server">
                            <asp:ListItem Selected="True">S/O</asp:ListItem>
                            <asp:ListItem>D/O</asp:ListItem>
                            <asp:ListItem>W/O</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>

                     <td >
                        &nbsp;<asp:ImageButton ID="ImageButton1" runat="server"
                            Style="    border-style: Inset; height: 80px; width: 70px;border-width: 0px;margin-left: -15em;position: absolute;" BorderStyle="Inset" ImageUrl="~/images/PictureFrame.png" />
                    </td>
                   
                </tr>
                <tr style="display:none">
                    <td align="right">
                        Employee No :&nbsp;
                    </td>
                    <td >
                        <span style="color: #ff0000">
                            <asp:TextBox ID="TextBox1" runat="server" TextMode="Number" CssClass="input_txt" AutoPostBack="True"></asp:TextBox>
                            <asp:Label ID="Label7" runat="server" Font-Bold="True" ForeColor="#FF0066"></asp:Label>
                        </span>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox_Emp_Number"
                            ErrorMessage=""></asp:RequiredFieldValidator>--%>
                        <%-- ehsan code start--%>
                        <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="TextBox_Emp_Number"
                            ErrorMessage="Must enter number" Operator="DataTypeCheck" Type="Integer"></asp:CompareValidator>
                        <%-- ehsan code end--%>
                    </td>
                </tr>
                <tr>
                     <td align="right">
                        Relation First Name :&nbsp;
                    </td>
                    <td>
                        <asp:TextBox ID="TextBoxRFName" Style="background-color: #f9dde2;" CssClass="input_txt" runat="server" SkinID="captxt" onKeyPress="return ValidateAlpha(event);" required></asp:TextBox>
                        <span style="color: #ff0000">*
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBoxRFName"
                                ErrorMessage="*">*</asp:RequiredFieldValidator>
                        </span>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Relation Middle Name :&nbsp;
                    </td>
                    <td>
                        <asp:TextBox ID="TextBoxRMName" CssClass="input_txt" runat="server" SkinID="captxt" onKeyPress="return ValidateAlpha(event);"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                     <td align="right">
                        Relation Last Name :&nbsp;
                    </td>
                    <td>
                        <asp:TextBox ID="TextBoxRLName" Style="background-color: #f9dde2;" runat="server" CssClass="input_txt" SkinID="captxt" onKeyPress="return ValidateAlpha(event);"  required></asp:TextBox>
                        <span style="color: #ff0000">*
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBoxRLName"
                                ErrorMessage="*">*</asp:RequiredFieldValidator>
                        </span>
                    </td>
                </tr>
                <tr>
                   <td align="right">
                        Employee Type :&nbsp;
                    </td>
                    <td>
                        <asp:DropDownList  ID="DropDownList_Type" OnSelectedIndexChanged="DropDownList_Type_SelectedIndexChanged" runat="server" DataSourceID="SqlDataSource_emp_Type"
                            DataTextField="Type" DataValueField="Employee_Type_ID" AutoPostBack="True">
                        </asp:DropDownList>
                    </td>
                </tr>
              
               <tr id="trContractEndDate" runat="server" style="display:none;">
                      <td align="left">Contract End Date :
                        </td>
                        <td>
                            <igsch:WebDateChooser ID="ContractEdate" runat="server">
                            </igsch:WebDateChooser>
                               <asp:HiddenField ID="HiddenField_ContractEdate" runat="server" />
                        </td>
               </tr>
            </table>
                     </td>

                </tr>
                 </table>
        </div>
        <br />

        <div class="bxmain inner_content"style="width: 100%;    margin-top: -1em;">
            <h2>
                <span>Basic Information</span></h2>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                <tr>
                    <td width="50%">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="38%" align="right">
                                    Date Of Birth :
                                </td>
                                <td width="62%">
                                    <asp:Label ID="Label6" runat="server" Text="DAY     - MONTH -    YEAR" ForeColor="red"></asp:Label>
                                    <br />
                                    <asp:TextBox ID="TextBox_DOB_day" runat="server" CssClass="input_txt" Width="35px" onblur="calculate_age();" MaxLength="2" SkinID="intdata" required></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" id="reqDay" controltovalidate="TextBox_DOB_day" errormessage="Day" />
                                    -
                                    <asp:TextBox ID="TextBox_DOB_Month" runat="server" CssClass="input_txt" Width="25px" onblur="calculate_age();" MaxLength="2" SkinID="intdata" required></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" id="reqMonth" controltovalidate="TextBox_DOB_Month" errormessage="Month" />
                                    -
                                    <asp:TextBox ID="TextBox_DOB_Year" runat="server" CssClass="input_txt" Width="121px" onblur="calculate_age();" MaxLength="4" SkinID="intdata" required></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" id="reqYear" controltovalidate="TextBox_DOB_Year" errormessage="Year" />
                                    &nbsp;&nbsp; Age : <asp:Label ID="lblAge" runat="server" Text="0"></asp:Label> &nbsp; Years
                                    <asp:Label ID="underAge" runat="server" ForeColor="Red" Text=""></asp:Label>

                                </td>
                            </tr>
                             <tr>
                                <td align="right" width="38%">
                                    Place of birth :
                                </td>
                                <td>
                                    <asp:DropDownList AutoPostBack="True" DataSourceID="SqlDataSource_place_of_birth0"
                                        DataTextField="DistrictName" DataValueField="DistrictCode" ID="DropDownList_place_of_birth"
                                        OnSelectedIndexChanged="DropDownList_place_of_birth_SelectedIndexChanged" runat="server">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Marital Status :
                                </td>
                                <td>
                                    <asp:RadioButtonList CssClass="radlist" ID="RadioButtonList_marital_status" RepeatDirection="Horizontal"
                                        RepeatLayout="Flow" runat="server" TabIndex="9">
                                        <asp:ListItem Selected="True">Single</asp:ListItem>
                                        <asp:ListItem>Married</asp:ListItem>
                                        <%-- <asp:ListItem>Widow</asp:ListItem>
          <asp:ListItem>Divorced</asp:ListItem>--%>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                           
                           
                            <tr>
                                <td width="38%" align="right">
                                    CNIC No. :
                                </td>
                                <td width="62%">
                                 <%--  <igtxt:WebMaskEdit ID="TextBox_CNIC"  runat="server" InputMask="#####-#######-#">
                                    </igtxt:WebMaskEdit>--%>

                                     <asp:TextBox ID="TextBox_CNIC" Style="background-color: #f9dde2;" runat="server" MaxLength="15" TabIndex="8" onkeypress="txtChange(this)" onblur="checkCNIC()" SkinID="intdata"></asp:TextBox>
                                    <span style="color: #ff0000">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator42" runat="server" ControlToValidate="TextBox_CNIC"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                        </span> 
                                    
                                    
                                     <asp:HiddenField  ID="HiddenField_Cnic_flag" runat="server" />
                                      <asp:Label ID="lblCNIC" runat="server" Text=""></asp:Label>
                                    <span style="color: #ff0000">
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="TextBox_CNIC"
                                            ErrorMessage="Please Enter CNIC No">*</asp:RequiredFieldValidator></span>
                                </td>
                            </tr>
                            <tr>
                                <td width="38%" align="right">
                                    CNIC Expiry :
                                </td>


                                     <td>
                                    <igsch:WebDateChooser style="width:200px" ID="WebDateChooser_NICExpiry" runat="server">
                                    <CalendarLayout Culture="English (United Kingdom)"> </CalendarLayout>
                                    </igsch:WebDateChooser>
                                         <asp:Label ID ="LblMg" runat="server" Text="dd/MM/yyyy" ForeColor="Red"></asp:Label>
                                    <asp:HiddenField ID="HiddenField_NICExpiry" runat="server" />
                                </td>


                            </tr>
                            <tr>
                                <td width="38%" align="right">
                                    Blood Group :
                                </td>
                                <td width="62%">
                                    <asp:DropDownList ID="ddlBloodGroup" runat="server">
                                        <asp:ListItem Text="Nill" Value="Nill" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="A +ve" Value="A +ve" ></asp:ListItem>
                                        <asp:ListItem Text="B +ve" Value="B +ve"></asp:ListItem>
                                        <asp:ListItem Text="O +ve" Value="O +ve"></asp:ListItem>
                                        <asp:ListItem Text="AB +ve" Value="AB +ve"></asp:ListItem>
                                        <asp:ListItem Text="A -ve" Value="A -ve"></asp:ListItem>
                                        <asp:ListItem Text="B -ve" Value="B -ve"></asp:ListItem>
                                        <asp:ListItem Text="O -ve" Value="O -ve"></asp:ListItem>
                                        <asp:ListItem Text="AB -ve" Value="AB -ve"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="50%" valign="top">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                             <tr>
                                <td align="right">
                                    Nationality :
                                </td>
                                <td>
                                    <asp:DropDownList DataSourceID="SqlDataSource_Nationality" DataTextField="Nationality_Name"
                                        DataValueField="Nationality_ID" ID="DropDownList_nationality" runat="server">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            
                                 <tr>
                                <td align="right">
                                   Other Nationality :
                                </td>
                                <td>
                                    <asp:DropDownList DataSourceID="SqlDataSource_Nationality" DataTextField="Nationality_Name"
                                        DataValueField="Nationality_ID" ID="DropDownList_nationality_other" runat="server">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                           
                            <tr>
                                <td align="right">
                                    Religion :
                                </td>
                                <td>
                                    <asp:DropDownList DataSourceID="SqlDataSource_religion" DataTextField="Religion_name"
                                        DataValueField="Religion_ID" ID="DropDownList_religion" runat="server">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Domicile :
                                </td>
                                <td>
                                    <asp:DropDownList DataSourceID="SqlDataSource_place_of_birth" DataTextField="DistrictName"
                                        DataValueField="DistrictCode" ID="DropDownList_Domicile" runat="server">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Passport No :
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBox_Passport_no" CssClass="input_txt" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                             <tr>
                                <td align="right">
                                    Language Known :
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBox_language" runat="server" CssClass="input_txt"></asp:TextBox>
                                </td>
                            </tr>
                            
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <br />
        <div class="bxmain inner_content" style="width: 100%;    margin-top: -1em;">
            <h2>
                <span>Address Information</span></h2>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                <tr>
                    <td width="50%" valign="top">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <%--  <tr>
        <td width="38%" align="right">CNIC No. : </td>
        <td width="62%">
        <igtxt:webmaskedit id="TextBox_CNIC" runat="server" inputmask="#####-#######-#"></igtxt:webmaskedit>
          <span style="color: #ff0000"><asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="TextBox_CNIC"
        ErrorMessage="Please Enter CNIC No">*</asp:RequiredFieldValidator></span></td>
      </tr>--%>
                            
                            <tr>
                                <td align="right" width="38%">
                                    Home Phone :
                                </td>
                                <td width="62%">
                                    <asp:TextBox ID="txthp1" runat="server" Width="35px" CssClass="input_txt">0092</asp:TextBox>
                                    -
                                    <asp:TextBox ID="txthp2" runat="server" Width="25px" CssClass="input_txt">21</asp:TextBox>
                                    -
                                    <asp:TextBox ID="txthp3" MaxLength="7" runat="server" CssClass="input_txt" Width="121px" onkeypress="return isNumberKey(event);"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Mobile No :
                                </td>
                                

                                      <td style="width:215px;">
                               
                            
                                    <asp:TextBox ID="TextBox_mobile_No"   onblur="checkMobileNo();" runat="server" CssClass="input_txt"></asp:TextBox>
                               
                                        <asp:Label ID="Label_Mobile" runat="server" ForeColor="Red" Text=""></asp:Label>   
                                           </td>


                              
                            </tr>
                            
                            <tr>
                                <td align="right">
                                    Office Phone :
                                </td>
                                <td>
                                    <asp:TextBox ID="txtop1" runat="server" Width="35px" CssClass="input_txt">0092</asp:TextBox>
                                    -
                                    <asp:TextBox ID="txtop2" runat="server" CssClass="input_txt" Width="25px">21</asp:TextBox>
                                    -
                                    <asp:TextBox ID="txtop3" MaxLength="7" runat="server" CssClass="input_txt" Width="121px" onkeypress="return isNumberKey(event);"></asp:TextBox>
                                </td>
                            </tr>
                            
                            <tr>
                                <td align="right">
                                    Email Address :
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBox_email" runat="server" CssClass="input_txt" onblur="validateEmail(this);"></asp:TextBox>
                               
                                     <asp:RegularExpressionValidator ID="RegularExpressionForMail" ControlToValidate="TextBox_email" runat="server" ErrorMessage="Invalid Mail Address" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                            
                                     </td>
                               </tr>
                            <tr>
                                <td align="right">
                                    Emergency Contact # :
                                </td>
                                <td>
                                    <asp:TextBox ID="txtEmgMobile" runat="server" CssClass="input_txt"></asp:TextBox>
                                </td>
                               </tr>
                            <tr>
                                <td align="right">
                                    Emergency Contact Name :
                                </td>
                                <td>
                                    <asp:TextBox ID="txtEmgName" runat="server" CssClass="input_txt"  onKeyPress="return ValidateAlpha(event);"></asp:TextBox>
                                </td>
                               </tr>
                        </table>
                    </td>
                    <td width="50%" valign="top">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align="right" width="38%">
                                    District Name :
                                </td>
                                <td width="62%">
                                    <asp:DropDownList ID="DropDownList_dist_ID" runat="server" DataSourceID="SqlDataSource_dest_ID"
                                        DataTextField="DistrictName" DataValueField="DistrictCode" AutoPostBack="True">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Tehsil Name :
                                </td>
                                <td>
                                    <asp:DropDownList ID="DropDownList_teh_ID" runat="server" DataSourceID="SqlDataSource_tehsil_ID"
                                        DataTextField="TehsilName" DataValueField="TehsilCode">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Permanent Address :
                                </td>
                                <td>
                                    <asp:TextBox Style="background-color: #f9dde2;" ID="homeadd" runat="server" CssClass="input_txt" TextMode="MultiLine" required></asp:TextBox>
                                   <span style="color: #ff0000">*</span>
                                      <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="homeadd"
                                            ErrorMessage="*"></asp:RequiredFieldValidator></span>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Present Address :
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBox_present_address" runat="server" CssClass="input_txt" TextMode="MultiLine"></asp:TextBox>
                                <asp:LinkButton ID="LinkButton1" CausesValidation="false" runat="server" OnClick="LinkButton1_Click" Visible="false">Same as Above</asp:LinkButton></span>
                                     </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Office Address :
                                </td>
                                <td>
                                    <asp:TextBox ID="officeadd" runat="server" CssClass="input_txt" TextMode="MultiLine"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <br />
        <asp:Label ID="Label4" runat="server"></asp:Label>
        <asp:SqlDataSource ID="SqlDataSource_place_of_birth" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
            SelectCommand="SELECT DistrictCode, DistrictName, Priority FROM DISTRICT  ORDER BY Priority,DistrictName">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_place_of_birth0" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
            SelectCommand="SELECT DistrictCode, DistrictName, Priority FROM DISTRICT  ORDER BY Priority,DistrictName">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_religion" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
            SelectCommand="SELECT [Religion_ID], [Religion_name] FROM [Religion]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_Nationality" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
            SelectCommand="SELECT [Nationality_ID], [Nationality_Name] FROM [Nationality]">
        </asp:SqlDataSource>
        <div class="bxmain inner_content"style="width: 100%;    margin-top: -1em;">
            <h2>
                <span>Employment Information</span></h2>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                <tr>
                    <td width="50%" valign="top">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr style="display:none;">
                                <%--<td align="right">Join Date : </td>--%>
                                <td>
                                    <asp:TextBox ID="txtday" runat="server" CssClass="input_txt" Width="35px" Visible="false"></asp:TextBox>
                                    -
                                    <asp:TextBox ID="txtmonth" runat="server" CssClass="input_txt" Width="25px" Visible="false"></asp:TextBox>
                                    -
                                    <asp:TextBox ID="txtyear" runat="server" Width="66px" CssClass="input_txt" Visible="false"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td width="38%" align="right">
                                    Designation :
                                </td>
                                <td width="62%">
                                    <asp:DropDownList DataTextField="Designation_Name" DataValueField="Designation_ID"
                                        ID="DropDownListdesignation" runat="server" DataSourceID="SqlDataSourceDesignation"
                                        TabIndex="4" AutoPostBack="True">
                                    </asp:DropDownList>
                                    <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/Administrator/Basic Data Management/designation.aspx?PName=Employee Designations&amp;MName=Human Resource"
                                        Target="_blank" Visible="true">Add</asp:HyperLink>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    D.O.J :
                                </td>
                                <td>
                                    <%--  <CalendarLayout Culture="English (United Kingdom)">
                                    </CalendarLayout>--%>
                                    <igsch:WebDateChooser  style="width:200px" ID="WebDateChooser_CurretDesigJoinDate" runat="server" >
                                  <CalendarLayout Culture="English (United Kingdom)"> </CalendarLayout>
                                    </igsch:WebDateChooser>
                                    <asp:Label ID="LblMgDOJ" runat="server" ForeColor="Red" Text="dd/MM/yyyy"></asp:Label>
                                    <asp:HiddenField ID="HiddenField_Current_Designation_JoinDate" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    NTN #:
                                </td>
                                <td>
                                    <asp:TextBox style="width:200px" ID="txtNTNNo" runat="Server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <%-- <td align="right">Profession:</td>--%>
                                <td>
                                    <asp:DropDownList ID="ddlProfession" DataSourceID="SqlDataSourceProfession" DataTextField="Profession_Name"
                                        DataValueField="Profession_Code" AppendDataBoundItems="true" runat="Server" Visible="false">
                                        <asp:ListItem Text=" --- Select --- " Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Designation Detail :
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBox_Designation_Detail" runat="server" CssClass="input_txt"
                                        Height="50px" TextMode="MultiLine"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    GP Fund No :
                                </td>
                                <td>
                                    <asp:TextBox ID="txtGPFund" runat="server" CssClass="input_txt"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Provident Fund No :
                                </td>
                                <td>
                                    <asp:TextBox ID="txtProvFundNo" runat="server" CssClass="input_txt"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    EOBI No :
                                </td>
                                <td>
                                    <asp:TextBox ID="txtEOBINo" runat="server" CssClass="input_txt" ></asp:TextBox>
                                </td>


                            </tr>
                            
                            <tr>
                                <td align="right">
                                </td>
                                <td>
                                    &nbsp;<asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Administrator/Basic%20Data%20Management/SubDept.aspx"
                                        Target="_blank" Visible="False">Add Division</asp:HyperLink>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="50%" valign="top">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="38%" align="right">
                                    Grade (I-IX) :
                                </td>
                                <td width="62%">
                                     <asp:DropDownList ID="Dropdownlistpayscale" runat="server">
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
                                        <asp:ListItem>22</asp:ListItem> 
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr style="display:none">
                                <td align="right">
                                    Gross Salary
                                </td>
                                <td>
                                    <asp:TextBox ID="txtGrossSalary" runat="server" ReadOnly="true" Enabled="false"></asp:TextBox>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <%--<td width="38%" align="right">Grade (1-21) :</td>
        <td width="62%">--%>
                                <asp:DropDownList ID="Dropdownlistpayscale0" runat="server" Visible="false">
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
                                </asp:DropDownList>
                    </td>
                </tr>
                <tr style="display:none;">
                    <%--<td align="right">Service Start Date :</td>--%>
                    <td>
                        <asp:TextBox ID="TextBox_service_satart_Date_day" runat="server" CssClass="input_txt"
                            Width="35px" Visible="false"></asp:TextBox>
                        -
                        <asp:TextBox ID="TextBox_Service_Start_Date_month" runat="server" CssClass="input_txt"
                            Width="25px" Visible="false"></asp:TextBox>
                        -
                        <asp:TextBox ID="TextBox_service_Start_Date_Year" runat="server" CssClass="input_txt"
                            Width="66px" Visible="false"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td width="38%" align="right">
                        Hospital :
                    </td>
                    <td width="62%">
                        <asp:DropDownList DataTextField="Hospital_Name" DataValueField="Hospital_ID" ID="DropdownlistHospital"
                            runat="server" DataSourceID="SqlDataSourceHospital" AutoPostBack="True" TabIndex="5">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td width="38%" align="right">
                        Department :
                    </td>
                    <td width="62%">
                        <asp:DropDownList DataTextField="Dept_Name" DataValueField="Dept_ID" ID="Dropdownlistdepartment"
                            runat="server" DataSourceID="SqlDataSourceDepartment" AutoPostBack="True" TabIndex="5">
                        </asp:DropDownList>
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Administrator/Basic%20Data%20Management/department.aspx?PName=Departments/Divisions&amp;MName=Human Resource"
                            Target="_blank" Visible="false">Add</asp:HyperLink>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Sub Department :
                    </td>
                    <td>
                        <asp:DropDownList ID="DropDownListSubDepartment" runat="server" DataSourceID="SqlDataSource_Division"
                            DataTextField="SubDept_Name" DataValueField="SubDept_Id" TabIndex="6" AutoPostBack="True">
                        </asp:DropDownList>
                        <asp:HyperLink ID="HyperLink6" runat="server" NavigateUrl="~/Administrator/Basic%20Data%20Management/SubDept.aspx?PName=Section/Subdepartment&amp;MName=Human Resource"
                            Target="_blank" Visible="false">Add</asp:HyperLink>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Shift:
                    </td>
                    <td>
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="Sds_shift" DataTextField="Shift"
                            DataValueField="Shift_ID">
                        </asp:DropDownList>
                    </td>
                    <asp:SqlDataSource ID="Sds_shift" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                        SelectCommand="SELECT ShiftName [Shift],ShiftID Shift_ID FROM Admin_Shift"></asp:SqlDataSource>
                </tr>
                <tr>
                    <td align="right">
                        Salary Mode :</td>
                    <td>
                        <asp:DropDownList ID="DropDownList_SalaryType" runat="server">
                            <asp:ListItem>Cash</asp:ListItem>
                            <asp:ListItem>Bank Transfer</asp:ListItem>
                            <asp:ListItem>Cheuqe</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <asp:CheckBox ID="checkBoxIsConsultant"  OnCheckedChanged="checkBoxIsConsultant_CheckedChanged"   runat="server" Text="Is Consultant" />
                                        
                          </td>                                           

                </tr>
                <tr style="display:none">
                        <asp:Panel ID="panelSalary" runat="server" >

                                <td id="stext">
                                    Salary Sharing :
                                </td>
                                <td id="sbtn">
                                    <asp:RadioButtonList ID="rbsalarysharing" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes"> Yes</asp:ListItem>
                                           <asp:ListItem Value="No" Selected="True"> No</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>

                                    </asp:Panel>

                </tr>
                  <tr style="display:none">
                       <td align="right">
                        Rotation Type :</td>                     
               
                                <td>
                                    <asp:DropDownList ID="RotationType" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Fixed"> Fixed </asp:ListItem>
                                           <asp:ListItem Value="Rotation (M / E / N)" > Rotation (M / E / N) </asp:ListItem>
                                        <asp:ListItem Value="Rotation (M  / N)" > Rotation (M  / N) </asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                        </tr> 


            </table>
            <asp:DropDownList DataTextField="Section_Name" DataValueField="Section_ID" ID="DropDownList_section"
                runat="server" DataSourceID="SqlDataSource_section" AutoPostBack="True" TabIndex="5"
                Visible="False">
            </asp:DropDownList>
            <asp:HyperLink ID="HyperLink5" runat="server" NavigateUrl="~/Administrator/Basic%20Data%20Management/Section.aspx"
                Target="_blank" Visible="False">Add Section</asp:HyperLink></td> </tr> </table>
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
            <asp:Button ID="ButtonSave" runat="server" Text="Save" CssClass="btn1" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnRefresh" runat="server" Text="Reset" CausesValidation="False"
                Width="85px" />
            <%-- <div style="width:100%;">  
    
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
    
    </div> --%><!--end Skills Div-->
            <br />
        </div>
        <br />
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
        <asp:Label ID="Label2" runat="server" CssClass="err"></asp:Label>
        <asp:Label ID="Label3" runat="server" CssClass="err"></asp:Label><br />
       <%-- <asp:RequiredFieldValidator ControlToValidate="homeadd" CssClass="err" Display="Dynamic"
            ErrorMessage="Please Enter Home Address"  ID="RequiredFieldValidatorHomeAdd" runat="server"></asp:RequiredFieldValidator>
       --%> <asp:RequiredFieldValidator ControlToValidate="txtEFName" CssClass="err" Display="Dynamic"
            ErrorMessage="Please Enter First Name" ID="RequiredFieldValidatorPFName" runat="server"></asp:RequiredFieldValidator><asp:SqlDataSource
                ID="SqlDataSourceDesignation" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                SelectCommand="Select 'N/A' AS Designation_Name, 0 AS Designation_ID UNION SELECT Designation_Name, Designation_ID FROM Designation ORDER BY Designation_Name asc">
            </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceGender" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            SelectCommand="SELECT Gender_ID, Gender FROM Gender" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceHospital" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            SelectCommand="SELECT     Hospital_ID, Hospital_Name
FROM         Hospital" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            SelectCommand="SELECT     Dept_Name, Dept_ID, Hospital_ID
FROM         Department
WHERE     (Hospital_ID = @Hospital_ID)
ORDER BY Dept_Name" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropdownlistHospital" Name="Hospital_ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            InsertCommand="HR_Insert_Employee_Info" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
            InsertCommandType="StoredProcedure"
              UpdateCommandType="StoredProcedure"
            UpdateCommand="HR_Update_Employee_Info">
           
            

            <UpdateParameters>
                <asp:ControlParameter ControlID="prefix" Name="Prefix" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="txtEFName" Name="EFName" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtEMName" Name="EMName" PropertyName="Text" />
                <asp:ControlParameter ControlID="TxtELName" Name="ELName" PropertyName="Text" />
                <asp:ControlParameter ControlID="HiddenField_Current_Designation_JoinDate" Name="JoinDate" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenFieldCNIC" Name="CNIC" PropertyName="Value" />
                <asp:ControlParameter ControlID="DropDownListdesignation" Name="DesignationID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="Dropdownlistpayscale" Name="PayScale" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="HiddenFieldHomePhone" Name="HPhoneNo" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenFieldOfficePhone" Name="OphoneNo" PropertyName="Value" />
                <asp:ControlParameter ControlID="officeadd" Name="OfficeAdd" PropertyName="Text" />
                <asp:ControlParameter ControlID="homeadd" Name="HomeAdd" PropertyName="Text" />
                <asp:ControlParameter ControlID="Dropdownlistsex" Name="SexID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="DeptID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="DropDownListSubDepartment" Name="SubDeptId" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="TextBoxRFName" Name="RFName" PropertyName="Text" DefaultValue="." />
                <asp:ControlParameter ControlID="TextBoxRMName" Name="RMName" PropertyName="Text" DefaultValue="." />
                <asp:ControlParameter ControlID="TextBoxRLName" Name="RLName" PropertyName="Text" DefaultValue="." />

                    <asp:ControlParameter ControlID="rbsalarysharing" Name="SalarySharing" PropertyName="SelectedValue" />
                   <asp:ControlParameter ControlID="DropDownList_nationality_other" Name="OtherNationality" PropertyName="SelectedValue" />
                
              <%--  <asp:ControlParameter ControlID="HiddenField_ContractSdate" Name="ContractSDate"
                PropertyName="Value" Type="DateTime" />--%>

               <%--    <asp:ControlParameter ControlID="HiddenField_ContractEdate" Name="ContractEDate"
                    PropertyName="Value" Type="DateTime" />--%>

                <asp:ControlParameter ControlID="HiddenField_DOB" Name="DateOfBirth" PropertyName="Value" />
                <%--<asp:SessionParameter Name="ServiceStartDate" SessionField="EJDate" />--%>
                <asp:SessionParameter Name="Entry_Employee_ID" SessionField="emp_ID" />
                <asp:ControlParameter ControlID="TextBox_email" Name="email_address" PropertyName="Text" />
                <asp:ControlParameter ControlID="TextBox_present_address" Name="Present_address"
                    PropertyName="Text" DefaultValue="." />
                <asp:ControlParameter ControlID="TextBox_mobile_No" Name="Mobile_Number" PropertyName="Text" />
                <asp:ControlParameter ControlID="DropDownList_place_of_birth" Name="Place_of_birth"
                    PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="RadioButtonList_marital_status" Name="Marital_Status"
                    PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="DropDownList_religion" Name="Religion" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="DropDownList_nationality" Name="Nationality" PropertyName="SelectedValue" />
                
               
                <asp:ControlParameter ControlID="TextBox_Passport_no" Name="Passport_No" PropertyName="Text" />
                <asp:ControlParameter ControlID="DropDownList_Domicile" Name="Domicile" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="TextBox_language" Name="Language_Known" PropertyName="Text" />
                <asp:ControlParameter ControlID="DropDownList_dist_ID" Name="dist_ID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="DropDownList_teh_ID" Name="tech_ID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="DropDownList_section" Name="Section_ID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="TextBox_Designation_Detail" Name="Designation_Detail"
                    PropertyName="Text" />
                <asp:ControlParameter ControlID="TextBox_Emp_No" Name="Emp_No" PropertyName="Text" />
                <asp:QueryStringParameter Name="EmpID" QueryStringField="emp_ID" />
                 <asp:QueryStringParameter Name="ExEmployee" QueryStringField="rj" />


                <%--<asp:ControlParameter ControlID="TextBox_EmpNumber" Name="Emp_Offical_Number" PropertyName="Text" />--%>
               <%-- <asp:ControlParameter ControlID="HiddenField_MainDesigId" Name="Promoted_Designation_Main_Id"
                    PropertyName="Value" />--%>
                <asp:ControlParameter ControlID="Dropdownlistpayscale0" Name="Employee_Scale" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ddlProfession" Name="Profession_Code" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="txtNTNNo" Name="NTN" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtGPFund" Name="GP_Fund_No" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtProvFundNo" Name="Prov_Fund_No" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtEOBINo" Name="EOBI_No" PropertyName="Text" />
                <asp:ControlParameter ControlID="RadioButtonList1" Name="Relation" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="checkBoxIsConsultant" Name="Is_Consultant" 
                    PropertyName="Checked" />
                     <asp:ControlParameter ControlID="DropDownList_SalaryType" Name="SalaryType" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="DropDownList_Type" Name="Employee_Type_ID" 
                    PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ddlBloodGroup" Name="BloodGroup" PropertyName="SelectedValue" />
              
                   <asp:ControlParameter ControlID="HiddenField_NICExpiry" Name="CNICExpiry" PropertyName="Value" />

                <asp:ControlParameter ControlID="txtEmgName" Name="EmgContactPerson" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtEmgMobile" Name="EmgMobileNo" PropertyName="Text" />
                <asp:ControlParameter ControlID="RotationType" Name="RotationType" PropertyName="SelectedValue" Type="String" />
                <asp:ControlParameter ControlID="DropDownList1" Name="Shift_Id" PropertyName="SelectedValue"
                    Type="Int32" />
            </UpdateParameters>
       
            
            
            <InsertParameters>
                <asp:ControlParameter ControlID="TextBox_Emp_Number" Name="EmpNo" PropertyName="Text" />
                <asp:ControlParameter ControlID="prefix" Name="Prefix" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="txtEFName" DefaultValue="" Name="EFName" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtEMName" DefaultValue="" Name="EMName" PropertyName="Text" />
                <asp:ControlParameter ControlID="TxtELName" Name="ELName" PropertyName="Text" />
                <asp:ControlParameter ControlID="HiddenField_Current_Designation_JoinDate" Name="JoinDate"
                    PropertyName="Value"  />
                 <%--  <asp:ControlParameter ControlID="HiddenField_ContractSdate" Name="ContractSDate"
                    PropertyName="Value" Type="DateTime" />

                   <asp:ControlParameter ControlID="HiddenField_ContractEdate" Name="ContractEDate"
                    PropertyName="Value" Type="DateTime" />--%>

                
                 <asp:ControlParameter ControlID="rbsalarysharing" Name="SalarySharing" PropertyName="SelectedValue" />
                   <asp:ControlParameter ControlID="DropDownList_nationality_other" Name="OtherNationality" PropertyName="SelectedValue" />


            
                <asp:ControlParameter ControlID="HiddenFieldCNIC" Name="CNIC" PropertyName="Value" />
                <asp:ControlParameter ControlID="DropDownListdesignation" Name="DesignationID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="Dropdownlistpayscale" Name="PayScale" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="HiddenFieldHomePhone" Name="HPhoneNo" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenFieldOfficePhone" Name="OphoneNo" PropertyName="Value" />
                <asp:ControlParameter ControlID="officeadd" Name="OfficeAdd" PropertyName="Text" />
                <asp:ControlParameter ControlID="homeadd" Name="HomeAdd" PropertyName="Text" />
                <asp:ControlParameter ControlID="Dropdownlistsex" Name="SexID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="DeptID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="DropDownListSubDepartment" Name="SubDeptId" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="HiddenField_Employee_ID" Direction="Output" Name="EmpID"
                    PropertyName="Value" Type="Int32" Size="90000" />
                <asp:ControlParameter ControlID="TextBoxRFName" Name="RFName" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBoxRMName" Name="RMName" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBoxRLName" Name="RLName" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="HiddenField_DOB" Name="DateOfBirth" PropertyName="Value"/>
                <%--<asp:ControlParameter ControlID="HiddenFieldStartDate" Name="ServiceStartDate" PropertyName="Value"
                    Type="DateTime" />--%>
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
              <asp:ControlParameter ControlID="DropDownList_Type" Name="Employee_Type_ID" 
                    PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="TextBox_Designation_Detail" Name="Designation_Detail"
                    PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="TextBox_Emp_No" Name="Emp_No" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_Emp_Number" Name="Emp_Offical_Number" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="HiddenField_Current_Designation_JoinDate" Name="Last_Promotion_Date"
                    PropertyName="Value"  />

                <asp:ControlParameter ControlID="Dropdownlistpayscale0" Name="Employee_Scale" PropertyName="SelectedValue"
                    Type="Int32" />
                <asp:ControlParameter ControlID="txtNTNNo" Name="NTN" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="ddlProfession" Name="Profession_Code" PropertyName="SelectedValue"
                    Type="Int32" />
                <asp:ControlParameter ControlID="txtGPFund" Name="GP_Fund_No" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="txtProvFundNo" Name="Prov_Fund_No" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="txtEOBINo" Name="EOBI_No" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="RadioButtonList1" Name="Relation" PropertyName="SelectedValue"
                    Type="String" />
                <asp:SessionParameter Name="Admin_ID" SessionField="EMP_ID" Type="Int32" />
                <asp:ControlParameter ControlID="DropDownList1" Name="Shift_Id" PropertyName="SelectedValue"
                    Type="Int32" />
                <asp:ControlParameter ControlID="checkBoxIsConsultant" DefaultValue="0"  Name="Is_Consultant" PropertyName="Checked" Type="Boolean" />
                <asp:ControlParameter ControlID="DropDownList_SalaryType" Name="SalaryType"  PropertyName="SelectedValue" Type="String" />         
                  <asp:ControlParameter ControlID="HiddenField_NICExpiry" Name="CNICExpiry" PropertyName="Value" />
                 <asp:ControlParameter ControlID="txtEmgName" Name="EmgContactPerson" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtEmgMobile" Name="EmgMobileNo" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="ddlBloodGroup" Name="BloodGroup" PropertyName="SelectedValue" Type="String" />
                <asp:ControlParameter ControlID="RotationType" Name="RotationType" PropertyName="SelectedValue" Type="String" />
                 
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenFieldCNIC" runat="server" />
        <asp:HiddenField ID="HiddenFieldHomePhone" runat="server" />
        <asp:HiddenField ID="HiddenFieldOfficePhone" runat="server" />
        <asp:SqlDataSource ID="SqlDataSource_Division" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            SelectCommand="SELECT SubDept_Name, SubDept_Id FROM SubDepartment WHERE (Dept_Id = @Dept_Id)"
            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
            <SelectParameters>
                <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="Dept_Id" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceProfession" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
            SelectCommand="SELECT Profession_Name, Profession_Code FROM Admin_Employee_Profession Order by Profession_Name">
        </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenField_age" runat="server" />
        <asp:HiddenField ID="HiddenField_DOB" runat="server" />        
        <asp:HiddenField ID="HiddenFieldEmp_id" runat="server" Value="0" />

          <asp:HiddenField ID="HiddenFieldEx_Emp" runat="server" Value="0" />

        <asp:HiddenField ID="HiddenFieldDateofBirth" runat="server" />
        <asp:HiddenField ID="HiddenFieldStartDate" runat="server" />
        <asp:HiddenField ID="HiddenField_Employee_ID" runat="server" />
        <asp:SqlDataSource ID="SqlDataSource_dest_ID" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
            SelectCommand="SELECT DistrictCode, DistrictName, Priority FROM DISTRICT  ORDER BY Priority,DistrictName">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_tehsil_ID" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
            SelectCommand="SELECT [TehsilCode], [TehsilName] FROM [TEHSIL] WHERE ([districtCode] = @districtCode)">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList_dist_ID" Name="districtCode" PropertyName="SelectedValue"
                    Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_emp_Type" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            SelectCommand="Select 0 AS Employee_Type_ID, 'N/A' AS Type union Select [Employee_Type_ID], [Type] FROM [Employee_Type]"></asp:SqlDataSource>
        <br />
        <asp:SqlDataSource ID="SqlDataSource_section" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            SelectCommand="SELECT [Section_ID], [Section_Name], [Division_ID] FROM [Section] WHERE ([Division_ID] = @Division_ID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownListSubDepartment" Name="Division_ID" PropertyName="SelectedValue"
                    Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:RegularExpressionValidator ControlToValidate="txthp3" CssClass="err" Display="Dynamic"
            ErrorMessage="Enter Valid Home Phone No." ID="RegularExpressionValidatorHPhoneNO"
            runat="server" ValidationExpression="\d{7}"></asp:RegularExpressionValidator>
        <asp:RegularExpressionValidator ControlToValidate="txtop3" CssClass="err" ErrorMessage="Enter Valid Phone No."
            ID="RegularExpressionValidatorHphone" runat="server" ValidationExpression="\d{7}"></asp:RegularExpressionValidator>
      <%--  <asp:RangeValidator ControlToValidate="txtday" CssClass="err" Display="Dynamic" ErrorMessage="Enter Valid Day"
            ID="RangeValidatorDay" MaximumValue="31" MinimumValue="01" runat="server" Type="Integer"></asp:RangeValidator>--%>
        <%--<asp:RangeValidator ControlToValidate="txtmonth" CssClass="err" Display="Dynamic"
            ErrorMessage="Enter Valid Month" ID="RangeValidatorMonth" MaximumValue="12" MinimumValue="01"
            runat="server" Type="Integer"></asp:RangeValidator>
        <asp:RangeValidator ControlToValidate="txtyear" CssClass="err" ErrorMessage="Enter Valid Year"
            ID="RangeValidatorYear" MinimumValue="1950" runat="server"></asp:RangeValidator>--%>
        <br />
    </div>
    <div width="100%" align="center">
        <div class="bxmain inner_content"style="width: 100%;  margin-top: -6.5em;">
            <h2>
                <span>Employee Additional Information</span></h2>
            <%-- style="width:100%;"--%>
            <br />
            <asp:HyperLink ID="hlnkEmployeeEducation1" runat="Server" Text="Education" CssClass="LinkStyle"
                Target="_blank" NavigateUrl="~/hr/Education.aspx?PName=Education&MName=Edit Employee&Emp_Id=0"
                Visible="false"></asp:HyperLink>
            <asp:HyperLink ID="hlnkEmployeeCertifications1" runat="Server" Text="Certification"
                CssClass="LinkStyle" Target="_blank" NavigateUrl="~/hr/Certification.aspx?PName=Certifications&MName=Edit Employee&Emp_Id=0"
                Visible="false"></asp:HyperLink>
            <asp:HyperLink ID="hlnkEmployeeSkills1" runat="Server" Text="Skills" CssClass="LinkStyle"
                Target="_blank" NavigateUrl="~/hr/skills.aspx?PName=Skills&MName=Edit Employee&Emp_Id=0"
                Visible="false"></asp:HyperLink>
            <asp:HyperLink ID="hlnkAdditionalInfo1" runat="Server" Text="Additional Info" CssClass="LinkStyle"
                Target="_blank" NavigateUrl="~/hr/Additional_Info.aspx?PName=Additional Info&MName=Edit Employee&Emp_Id=0"
                Visible="false"></asp:HyperLink>
            <asp:HyperLink ID="hlnkEmployeeRelationship1" runat="Server" Text="Relationship" CssClass="LinkStyle"
                Target="_blank" NavigateUrl="~/hr/ADD_relationship.aspx?PName=Relationship&MName=Edit Employee&Emp_Id=0"
                Visible="false"></asp:HyperLink>
            <asp:HyperLink ID="hlnkEmployeeDocuments1" runat="Server" Text="Documents" CssClass="LinkStyle"
                Target="_blank" NavigateUrl="~/hr/attach_Documents_Server.aspx?PName=Documents&MName=Edit Employee&Emp_Id=0"
                Visible="false"></asp:HyperLink>
            <asp:HyperLink ID="hlnkEmployeeExperience1" runat="Server" Text="Experience" CssClass="LinkStyle"
                Target="_blank" NavigateUrl="~/hr/Experience.aspx?PName=Documents&MName=Edit Employee&Emp_Id=0"
                Visible="false"></asp:HyperLink>
        </div>
</asp:Content>
