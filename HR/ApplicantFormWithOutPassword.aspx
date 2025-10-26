<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master"
    AutoEventWireup="true" CodeFile="ApplicantFormWithOutPassword.aspx.cs" Inherits="HR_ApplicantFormWithOutPassword" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7DD5C3163F2CD0CB"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../HR/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="../HR/jquery-1.12.3.js" type="text/javascript"></script>
    <script src="../HR/jquery-ui.js" type="text/javascript"></script>
    <style type="text/css">
        .width
        {
            width: 50px;
            text-overflow: ellipsis;
        }
        
        .style2
        {
            width: 25%;
            text-align: left;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {

            $('[id$="gpa"]').hide();


//            $('[id$="Attempts"]').blur(function () {

//                //                if ($(this).val() >= "2") {

//                //                    

//                //                    var obtained = $('[id$="txtObtainCgpa"]').val();
//                //                    var total = $('[id$="txtTotalCgpa"]').val();
//                //                    var res = obtained * 100 / total;

//                //                    $('[id$="txtboxPercentage"]').val(res - 1);
//                //                }
//                //                else {
//                var obtained = $('[id$="txtObtainCgpa"]').val();
//                var total = $('[id$="txtTotalCgpa"]').val();
//                var res = obtained * 100 / total;

//                $('[id$="txtboxPercentage"]').val(res);

//                //  }


//            });

            $('[id$="chkboxSelect"]').on('click', function () {

                var res = $('[id$="chkboxSelect"]').is(":checked");
                if (res == true) {
                    $('[id$="gpa"]').show();
                    $('[id$="marks"]').hide();

                }
                else {
                    $('[id$="gpa"]').hide();
                    $('[id$="marks"]').show();
                }
            });
            $('[id$="txtTotalCgpa"], [id$="txtObtainCgpa"]').blur(function () {

                var obtained = $('[id$="txtObtainCgpa"]').val();
                var total = $('[id$="txtTotalCgpa"]').val();

                if (obtained > total) {
                    alert("Obtain cgpa can't be greater than total cgpa");
                    $('[id$="txtboxPercentage"]').val("0");
                    $('[id$="txtObtainCgpa"]').val("0");
                    $('[id$="txtTotalCgpa"]').val("0");
                    return false;

                }
                else {
                    var percentage = obtained * 100 / total;
//                    if ($('[id$="Attempts"]').val() >= 2) {
//                        $('[id$="txtboxPercentage"]').val(parseFloat(percentage) - 1);
//                    }
//                    else {
                        $('[id$="txtboxPercentage"]').val(percentage);
                    //}
                }



            });



            $('[id$="btnSaveQualification"]').click(function () {
                if (parseInt($('[id$="txtboxObtainedMarks"]').val()) > parseInt($('[id$="txtboxTotalMarks"]').val())) {
                    alert("Obtainde Marks can not be greater then total Marks" + $('[id$="txtboxObtainedMarks"]').val() + ' ' + $('[id$="txtboxTotalMarks"]').val());

                    return false;
                }
                //               else
                //                   return true;
            });




            $('[id$="txtboxObtainedMarks"], [id$="txtboxTotalMarks"]').blur(function () {

                var obtained = $('[id$="txtboxObtainedMarks"]').val();
                var total = $('[id$="txtboxTotalMarks"]').val();

                var percentage = obtained / total * 100;

                $('[id$="txtboxPercentage"]').val(percentage);

            });

        });
     
    </script>
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

                $('[id$="txtboxExperience"]').val(Yeardiff + " Year ," + Monthdiff + " Month ");
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
            padding-right: 10px;
            padding-left: 5px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br />
    <asp:Label ID="LblInvalidDate" runat="server" CssClass="err"></asp:Label>
    <asp:Label ID="Label1" runat="server" CssClass="err"></asp:Label>
    <asp:Label ID="Label_message" runat="server" CssClass="err"></asp:Label>
    <%--ehsan code start--%>
    <div width="100%" align="center">
        <div class="bxmain">
            <h2>
                <span>Application Form</span></h2>
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
        <div class="bxmain">
            <h2>
                <span>General Information</span></h2>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                <%--  <tr>
                    <td align="right">
                        Advertisement :&nbsp;
                    </td>
                    <td>
                        <asp:DropDownList ID="DDL_Advertisement" runat="server" autopostback="true" OnSelectedIndexChanged="DDL_Advertisement_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Post :&nbsp;
                    </td>
                    <td>
                        <asp:DropDownList ID="GridViewPosts" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>--%>
                <tr align="right" style="width: 100px; height: 30px">
                    <td colspan="2" align="center">
                        <div style="margin: 0 0 5px 25px">
                            <h3>
                                Application History
                            </h3>
                        </div>
                        <div style="height: 150px; overflow-y: scroll; border: solid; margin-bottom: 10px;
                            border-color: ActiveBorder; margin-left: 20px">
                            <asp:GridView ID="gvPost" runat="server" Width="90%" AutoGenerateColumns="false">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr#">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Advertisement Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAdvertise" runat="server" Text='<%#Bind("Ad_Title") %>'></asp:Label>
                                            <%--<asp:HiddenField ID="hdnAdvertise" runat="server"  />--%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Post Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPost" runat="server" Text='<%#Bind("Title") %>'></asp:Label>
                                            <%--<asp:HiddenField ID="hdnAdvertise" runat="server" />
                                            --%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%-- <asp:TemplateField HeaderText="Select Post">
                                    <ItemTemplate>
                                       <asp:CheckBox ID="CheckBox1" runat="server"   />
                                    </ItemTemplate>
                                </asp:TemplateField>--%>
                                    <asp:TemplateField HeaderText="Delete Post">
                                        <ItemTemplate>
                                            <asp:Button ID="btnDeletePost" CommandName='<%# Bind("Apply_For_Id") %>' runat="server"
                                                Text="Delete" OnClick="btnDeletePost_Click" />
                                            <%--<asp:Button ID="btnDelete" CommandArgument='<%#Bind("Apply_For_Id") %>' runat="server" Text="Delete" OnClick="Button3_Click"  />--%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td align="center">
                        <asp:Button ID="btnConfirmPostId" runat="server" Text="Apply For Post" OnClick="btnConfirmPostId_Click1" />
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                        <asp:Label ID="lblMsSearch" runat="server" CssClass="err"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="19%" align="right">
                        Search :&nbsp;
                    </td>
                    <td>
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="input_txt"></asp:TextBox>
                        <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Search" />
                    </td>
                </tr>
                <tr>
                    <td width="19%" align="right">
                        Title :&nbsp;
                    </td>
                    <td>
                        <asp:RadioButtonList CssClass="radlist" ID="prefix" RepeatDirection="Horizontal"
                            runat="server">
                            <asp:ListItem Selected="True">Mr.</asp:ListItem>
                            <asp:ListItem>Miss</asp:ListItem>
                            <asp:ListItem>Mrs.</asp:ListItem>
                            <asp:ListItem>Dr.</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                    <td width="17%" rowspan="13" align="center" valign="top">
                        &nbsp;<asp:ImageButton ID="ImageButton1" runat="server" Height="100px" Width="85px"
                            Style="margin-right: 10px;" BorderStyle="Inset" ImageUrl="~/images/PictureFrame.png" />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        First Name :&nbsp;
                    </td>
                    <td>
                        <asp:TextBox ID="txtEFName" runat="server" CssClass="input_txt"></asp:TextBox>
                        <span style="color: #ff0000">*</span>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="mainApp"
                            ControlToValidate="txtEFName" ErrorMessage="*">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Middle Name :&nbsp;
                    </td>
                    <td>
                        <asp:TextBox ID="txtEMName" runat="server" CssClass="input_txt"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Last Name :&nbsp;
                    </td>
                    <td>
                        <asp:TextBox ID="TxtELName" runat="server" CssClass="input_txt"></asp:TextBox>
                        <span style="color: #ff0000">* </span>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="mainApp"
                            runat="server" ControlToValidate="TxtELName" ErrorMessage="*">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Attach Picture :&nbsp;
                    </td>
                    <td>
                        <asp:FileUpload ID="FileUpload_image" runat="server" Width="200px" />
                        <asp:Button ID="Button_attach_pic" runat="server" CausesValidation="False" Text="Attach"
                            CssClass="btn1" OnClick="Button_attach_pic_Click" />
                        <asp:HiddenField ID="HiddenField_ImageAttached" runat="server" Value="0" />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
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
                <tr>
                    <td width="19%" align="right">
                    </td>
                    <td>
                        <asp:RadioButtonList CssClass="radlist" ID="Relation" RepeatDirection="Horizontal"
                            runat="server">
                            <asp:ListItem Selected="True">S/O</asp:ListItem>
                            <asp:ListItem>D/O</asp:ListItem>
                            <asp:ListItem>W/O</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Relation First Name :&nbsp;
                    </td>
                    <td>
                        <asp:TextBox ID="TextBoxRFName" CssClass="input_txt" runat="server"></asp:TextBox>
                        <span style="color: #ff0000">
                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1"
        runat="server" ControlToValidate="TextBoxRFName" ErrorMessage="*">*</asp:RequiredFieldValidator>--%>
                        </span>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Relation Middle Name :&nbsp;
                    </td>
                    <td>
                        <asp:TextBox ID="TextBoxRMName" CssClass="input_txt" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Relation Last Name :&nbsp;
                    </td>
                    <td>
                        <asp:TextBox ID="TextBoxRLName" runat="server" CssClass="input_txt"></asp:TextBox>
                        <span style="color: #ff0000">
                            <%--    <asp:RequiredFieldValidator ID="RequiredFieldValidator3"
              runat="server" ControlToValidate="TextBoxRLName" ErrorMessage="*">*</asp:RequiredFieldValidator>--%>
                        </span>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        &nbsp;
                    </td>
                    <td>
                        <asp:TextBox ID="TextBox_Emp_No" runat="server" CssClass="input_txt" Visible="False"></asp:TextBox>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </div>
        <br />
        <div class="bxmain">
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
                                    <br />
                                    <span style="color: Red">
                                        <igsch:WebDateChooser Width="180px" runat="server" ID="DOB">
                                        </igsch:WebDateChooser>
                                        *</span>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="mainApp"
                                        runat="server" ControlToValidate="DOB" ErrorMessage="*">*</asp:RequiredFieldValidator>
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
                                    Language Known :
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBox_language" runat="server" CssClass="input_txt"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="50%" valign="top">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
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
                                <td width="38%" align="right">
                                    CNIC No. :
                                </td>
                                <td width="62%">
                                    <asp:TextBox ID="TextBox_CNIC" MaxLength="13" runat="server" SkinID="intdata"></asp:TextBox>
                                    <%--<igtxt:WebMaskEdit ID="TextBox_CNIC" runat="server" InputMask="#####-#######-#">
                                    </igtxt:WebMaskEdit>--%>
                                    <span style="color: #ff0000">*
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ValidationGroup="mainApp"
                                            runat="server" ControlToValidate="TextBox_CNIC" ErrorMessage="Please Enter CNIC No">*</asp:RequiredFieldValidator></span>
                                </td>
                            </tr>
                            <tr runat="server" id="srchResultHeader">
                                <td width="38%" align="right" style="display: none;">
                                    Password :
                                </td>
                                <td width="62%">
                                    <asp:TextBox Visible="false" ID="txt_Password" Text="abc123" runat="server"></asp:TextBox>
                                    <%--<igtxt:WebMaskEdit ID="TextBox_CNIC" runat="server" InputMask="#####-#######-#">
                                    </igtxt:WebMaskEdit>--%>
                                    <%-- <span  style="color: #ff0000;display:none;">*
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="mainApp"
                                            runat="server" ControlToValidate="txt_Password" ErrorMessage="Please Enter Password">*</asp:RequiredFieldValidator></span>--%>
                                    <asp:Label ID="lblWarn" runat="server" ForeColor="Red"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <br />
        <div class="bxmain">
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
                                <td align="right">
                                    District Name :
                                </td>
                                <td>
                                    <asp:DropDownList ID="DropDownList_dist_ID" runat="server" DataSourceID="SqlDataSource_dest_ID"
                                        DataTextField="DistrictName" DataValueField="DistrictCode" AutoPostBack="True">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Home Phone :
                                </td>
                                <td>
                                    <asp:TextBox ID="txthp" runat="server" CssClass="input_txt"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Mobile No :
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBox_mobile_No" MaxLength="11" SkinID="intdata" runat="server"
                                        CssClass="input_txt"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="mainApp"
                                        ControlToValidate="TextBox_mobile_No" ErrorMessage="*">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Email Address :
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBox_email" runat="server" CssClass="input_txt"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="50%" valign="top">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
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
                                    <asp:TextBox ID="homeadd" runat="server" CssClass="input_txt"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Present Address :
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBox_present_address" runat="server" CssClass="input_txt"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <div style="text-align: center;">
            <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" /><%--ValidationGroup="mainApp"--%>
            <span style="padding-left: 15px;">
                <asp:Label ID="lblMessage" Visible="false" runat="server" ForeColor="DarkGreen" Font-Bold="true"
                    Text="Data Is Save SuccessFully"></asp:Label></span>
        </div>
        <div>
            <asp:Label ID="lblPassword" Visible="false" runat="server" ForeColor="Red" Font-Bold="true"
                Text="Your Current Password=abc@123"></asp:Label>
            <asp:LinkButton ID="lnkpasword" Text="changePassword" Visible="false" runat="server"
                OnClick="lnkpasword_Click"></asp:LinkButton>
            <%--<asp:LinkButton ID="lnkpassword" Text="Change Password" OnClick="lnkpassword_Click" Visible="false" runat="server"></asp:LinkButton>--%>
        </div>
        <div runat="server" id="appDetails" class="bxmain">
            <h2>
                Add Experience and Qualification</h2>
            <br />
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                <tr>
                    <td>
                        <asp:GridView AutoGenerateColumns="false" ID="gvdApplicantInfo" runat="server" Width="100%">
                            <Columns>
                                <asp:BoundField HeaderText="Name" DataField="Name" />
                                <asp:BoundField HeaderText="CNIC" DataField="CNIC" />
                                <asp:BoundField HeaderText="email_address" DataField="email_address" />
                                <asp:BoundField HeaderText="Mobile_Number" DataField="Mobile_Number" />
                                <%-- <asp:BoundField HeaderText="Present_address" DataField="Present_address" />--%>
                                <asp:TemplateField HeaderText="Present address">
                                    <ItemTemplate>
                                        <div style="width: 70px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis">
                                            <%# Eval("Present_address")%>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--<asp:BoundField HeaderText="DistrictName" DataField="DistrictName" />--%>
                                <asp:TemplateField HeaderText="Qualification">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkbtnQualification" runat="server" OnClick="lnkbtnQualification_Click"
                                            Text="Qualification"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Formal Training">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkbtnFormalTraining" runat="server" OnClick="lnkbtnFormalTraining_Click"
                                            Text="Formal Training"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Reserach Paper">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkbtnReserachPaper" OnClick="lnkbtnReserachPaper_Click" runat="server"
                                            Text="Reserach Paper"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Countries Visited">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkbtnCountriesVisited" OnClick="lnkbtnCountriesVisited_Click"
                                            runat="server" Text="Countries Visited"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Experience">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkbtnExperience" OnClick="lnkbtnExperience_Click" runat="server"
                                            Text="Experience"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                    <asp:Button runat="server" ID="btnReport" Text="Print Form" OnClick="btnReport_Click"
                        Visible="false" />
                    </td>
                </tr>
                </tr>
            </table>
        </div>
    </div>
    <asp:Panel ID="panel" runat="server" Visible="false" CssClass="lightbox_bg">
        <div class="lightbox">
            <div style="display: inline; float: left; width: 100%;" class="bxmain inner_content">
                <h2>
                    <span>Qualification</span></h2>
                <table>
                    <tr style="line-height: 1.5;">
                        <td class="style2" style="font-weight: bold; text-align: right;">
                            Certificate/Degree
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlQulaification" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td style="padding-left: 20px; font-weight: bold; text-align: right" class="style2">
                            <asp:Label ID="lblBoardUniversity" runat="server" Text="Board/University"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtboxInstitue" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="line-height: 1.5;">
                        <td class="style2" style="font-weight: bold; text-align: right;">
                            Exam. With year of passing
                        </td>
                        <td>
                            <asp:TextBox ID="txtboxYear" SkinID="intdata" runat="server"></asp:TextBox>
                        </td>
                        <td style="padding-left: 20px; font-weight: bold; text-align: right" class="style2">
                            Division/ Distinction
                        </td>
                        <td>
                            <asp:TextBox ID="DivisionDistinction" SkinID="intdata" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="style2" style="font-weight: bold; text-align: right;">
                            Attempts
                        </td>
                        <td>
                            <asp:TextBox ID="Attempts" SkinID="intdata" runat="server"></asp:TextBox>
                        </td>
                        <td style="padding-left: 20px; font-weight: bold; text-align: right" class="style2">
                            % Marks Obtained
                        </td>
                        <td>
                            <asp:TextBox ID="txtboxPercentage" SkinID="intdata" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="chkboxSelect"  runat="server" Text="Is Cgpa" />
                        </td>
                    </tr>
                    <tr id="marks">
                        <td class="style2" style="font-weight: bold; text-align: right;">
                            Total Marks
                        </td>
                        <td>
                            <asp:TextBox ID="txtboxTotalMarks" SkinID="intdata" runat="server"></asp:TextBox>
                        </td>
                        <td style="padding-left: 20px; font-weight: bold; text-align: right" class="style2">
                            Marks Obtained
                        </td>
                        <td>
                            <asp:TextBox ID="txtboxObtainedMarks" SkinID="intdata" runat="server"></asp:TextBox>
                        </td>
                        <%--<asp:CompareValidator ID="validator" runat="server" ControlToValidate="txtboxTotalMarks" ValidationGroup="mainApp" ControlToCompare="txtboxObtainedMarks" Operator="LessThan" ErrorMessage="Enter Correct Marks"></asp:CompareValidator>                                          --%>
                    </tr>
                    <tr id="gpa" runat="server">                        
                            <td class="style2" style="font-weight: bold; text-align: right;">
                                Total Cgpa
                            </td>
                            <td>
                                <asp:TextBox ID="txtTotalCgpa" SkinID="intdata" runat="server"></asp:TextBox>
                            </td>
                            <td style="padding-left: 20px; font-weight: bold; text-align: right" class="style2">
                                 Obtained Cgpa
                            </td>
                            <td>
                                <asp:TextBox ID="txtObtainCgpa" SkinID="intdata" runat="server"></asp:TextBox>
                            </td>                        
                    </tr>
                    <tr style="line-height: 3;">
                        <td colspan="">
                            &nbsp;
                        </td>
                        <td style="padding-left: 20px; text-align: center" colspan="2">
                            <asp:Button ID="btnSaveQualification" runat="server" Text="Save"
                                OnClick="btnSaveQualification_Click" />
                            <asp:Button ID="btnClose" runat="server" Text="Close" OnClick="btnClose_Click" />
                            <%-- <span style="padding-left:20px;"><asp:Label ID="lblmessagemain" runat="server" Text="Data is Save Successfully" Visible="false" ForeColor="Green" Font-Bold="true"></asp:Label></span>--%>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="10">
                            <asp:GridView ID="gvdQualification" AutoGenerateColumns="false" runat="server" Width="100%">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imagebtn" runat="server" CommandArgument='<%# Eval("ID") %>'
                                                ImageUrl="~/Images/delete.png" OnClick="imagebtn_Click" OnClientClick="return Confirm('Do you want to delete this record?');"
                                                Width="16" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderText="Name" DataField="Name" />
                                    <asp:BoundField HeaderText="Degree" DataField="Qualification_Name" />
                                    <asp:BoundField HeaderText="Institue" DataField="Institute" />
                                    <asp:BoundField HeaderText="Year" DataField="year" />
                                    <asp:BoundField HeaderText="Total Marks" DataField="TotalMarks" />
                                    <asp:BoundField HeaderText="Obtained Marks" DataField="ObtainedBy" />
                                    <asp:BoundField HeaderText="Percentage" DataField="percentage" />
                                    <asp:BoundField HeaderText="Attempts" DataField="Attempts" />
                                </Columns>
                            </asp:GridView>
                            <br />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </asp:Panel>
    <asp:Panel ID="panelforpost" runat="server" Visible="false" CssClass="lightbox_bg">
        <div class="lightbox">
            <div style="display: inline; float: left; width: 100%;" class="bxmain inner_content">
                <h2>
                    <span>Select Post</span></h2>
                <table>
                    <tr style="line-height: 1.5;">
                        <td class="style2" style="font-weight: bold; text-align: right;">
                            Advertisement
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlAdvertiseforpost" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlAdvertiseforpost_SelectedIndexChanged">
                            </asp:DropDownList>
                            <%--<asp:DropDownList ID="ddlAdvertiseforpost" runat="server" OnSelectedIndexChanged="ddlAdvertise_SelectedIndexChanged"></asp:DropDownList>--%>
                        </td>
                    </tr>
                    <tr style="line-height: 1.5;">
                        <td class="style2" style="font-weight: bold; text-align: right;">
                            Post
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlPost" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr style="line-height: 1.5;">
                        <td class="style2" style="font-weight: bold; text-align: right;">
                            <asp:Button ID="btnSavePost" runat="server" Text="Save" OnClick="btnSavePost_Click" />
                            <asp:Label ID="SuccessMessage" runat="server" ForeColor="Green"></asp:Label>
                        </td>
                        <td class="style2" style="font-weight: bold">
                            &nbsp;
                            <asp:Button ID="btnPostClose" runat="server" Text="Close" OnClick="btnClosePost_Click" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </asp:Panel>
    <asp:Panel ID="panelReserachPaper" runat="server" Visible="false" CssClass="lightbox_bg">
        <div class="lightbox">
            <div style="display: inline; float: left; width: 100%;" class="bxmain inner_content">
                <h2>
                    <span>Reserach Paper</span></h2>
                <table>
                    <tr style="line-height: 1.5;">
                        <td class="style2" style="font-weight: bold; text-align: right;">
                            Title Of ReserachPapaer
                        </td>
                        <td>
                            <asp:TextBox ID="RPTitleOfReserachPapaer" runat="server"></asp:TextBox>
                        </td>
                        <td style="padding-left: 20px; font-weight: bold; text-align: right" class="style2">
                            <asp:Label ID="Label3" runat="server" Text="Journal Name"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="RPJournalName" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="line-height: 1.5;">
                        <td class="style2" style="font-weight: bold; text-align: right;">
                            Publication Date
                        </td>
                        <td>
                            <asp:TextBox ID="RPPublicationDate" TextMode="Date" runat="server"></asp:TextBox>
                        </td>
                        <td style="padding-left: 20px; font-weight: bold; text-align: right" class="style2">
                            Principle/Co-Author
                        </td>
                        <td>
                            <asp:TextBox ID="RPPrincipleCoAuthor" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="line-height: 3;">
                        <td colspan="">
                            &nbsp;
                        </td>
                        <td style="padding-left: 20px; text-align: center" colspan="2">
                            <asp:Button ID="RPbtnSaveQualification" runat="server" Text="Save" OnClick="RPbtnSaveQualification_Click" />
                            <asp:Button ID="RPClose" runat="server" Text="Close" OnClick="RPClose_Click" />
                            <%-- <span style="padding-left:20px;"><asp:Label ID="lblmessagemain" runat="server" Text="Data is Save Successfully" Visible="false" ForeColor="Green" Font-Bold="true"></asp:Label></span>--%>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="10">
                            <asp:GridView ID="ReserachPaperPGrid" runat="server" AutoGenerateColumns="false"
                                Width="100%">
                                <Columns>
                                    <asp:BoundField DataField="Name" HeaderText="Name" />
                                    <asp:BoundField DataField="ReserachPaperName" HeaderText="Paper Name" />
                                    <asp:BoundField DataField="NameOfJournal" HeaderText="Journal Name" />
                                    <asp:BoundField DataField="PublicationDate" HeaderText="Date" />
                                    <asp:BoundField DataField="PrincipleOrCoAuthor" HeaderText="Principle/Co-Author" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="ReserachPaperPimagebtn" runat="server" CommandArgument='<%# Eval("ID") %>'
                                                ImageUrl="~/Images/delete.png" OnClick="ReserachPaperPimagebtn_Click" OnClientClick="return Confirm('Do you want to delete this record?');"
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
    <asp:Panel ID="PanelEmploymentRecord" runat="server" Visible="false" CssClass="lightbox_bg">
        <div class="lightbox">
            <div style="display: inline; float: left; width: 100%;" class="bxmain inner_content">
                <h2>
                    <span>Reserach Paper</span></h2>
                <table>
                    <tr style="line-height: 1.5;">
                        <td class="style2" style="font-weight: bold; text-align: right;">
                            Title Of ReserachPapaer
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                        </td>
                        <td style="padding-left: 20px; font-weight: bold; text-align: right" class="style2">
                            <asp:Label ID="Label4" runat="server" Text="Journal Name"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="line-height: 1.5;">
                        <td class="style2" style="font-weight: bold; text-align: right;">
                            Publication Date
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
                        </td>
                        <td style="padding-left: 20px; font-weight: bold; text-align: right" class="style2">
                            Principle/Co-Author
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="line-height: 3;">
                        <td colspan="">
                            &nbsp;
                        </td>
                        <td style="padding-left: 20px; text-align: center" colspan="2">
                            <asp:Button ID="Button1" runat="server" Text="Save" OnClick="RPbtnSaveQualification_Click" />
                            <asp:Button ID="Button2" runat="server" Text="Close" OnClick="RPClose_Click" />
                            <%-- <span style="padding-left:20px;"><asp:Label ID="lblmessagemain" runat="server" Text="Data is Save Successfully" Visible="false" ForeColor="Green" Font-Bold="true"></asp:Label></span>--%>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="10">
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="true" Width="100%">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="ReserachPaperPimagebtn" runat="server" CommandArgument='<%# Eval("Qualification_Id") %>'
                                                ImageUrl="~/Images/delete.png" OnClick="ReserachPaperPimagebtn_Click" OnClientClick="return Confirm('Do you want to delete this record?');"
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
    <asp:Panel ID="PanelFormalTraining" runat="server" Visible="false" CssClass="lightbox_bg">
        <div class="lightbox">
            <div style="display: inline; float: left; width: 100%;" class="bxmain inner_content">
                <h2>
                    <span>Formal Training</span></h2>
                <table>
                    <tr style="line-height: 1.5;">
                        <td class="style2" style="font-weight: bold; text-align: right;">
                            Institute
                        </td>
                        <td>
                            <asp:TextBox ID="FTInstitute" runat="server"></asp:TextBox>
                        </td>
                        <td style="padding-left: 20px; font-weight: bold; text-align: right" class="style2">
                            <asp:Label ID="Label2" runat="server" Text="Training Type"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="FTTrainingType" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="line-height: 1.5;">
                        <td class="style2" style="font-weight: bold; text-align: right;">
                            Period From
                        </td>
                        <td>
                            <asp:TextBox ID="FTPeriodFrom" TextMode="Date" runat="server"></asp:TextBox>
                        </td>
                        <td style="padding-left: 20px; font-weight: bold; text-align: right" class="style2">
                            Period To
                        </td>
                        <td>
                            <asp:TextBox ID="FTPeriodTo" TextMode="Date" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="style2" style="font-weight: bold; text-align: right;">
                            Certificate/Diploma Obtained
                        </td>
                        <td>
                            <asp:TextBox ID="FTCertificateDiplomaObtained" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="line-height: 3;">
                        <td colspan="">
                            &nbsp;
                        </td>
                        <td style="padding-left: 20px; text-align: center" colspan="2">
                            <asp:Button ID="btnSaveFormalTraining" runat="server" Text="Save" OnClick="btnSaveFormalTraining_Click" />
                            <asp:Button ID="btnCloseFormalTraining" runat="server" Text="Close" OnClick="btnCloseFormalTraining_Click" />
                            <%-- <span style="padding-left:20px;"><asp:Label ID="lblmessagemain" runat="server" Text="Data is Save Successfully" Visible="false" ForeColor="Green" Font-Bold="true"></asp:Label></span>--%>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="10">
                            <asp:GridView ID="FormalTrainingGrid" runat="server" AutoGenerateColumns="false"
                                Width="100%">
                                <Columns>
                                    <asp:BoundField DataField="Name" HeaderText="Name" />
                                    <asp:BoundField DataField="Institute" HeaderText="Institute" />
                                    <asp:BoundField DataField="CertificateDiplomaObtained" HeaderText="Diploma" />
                                    <asp:BoundField DataField="PeriodFrom" HeaderText="Period From" />
                                    <asp:BoundField DataField="PeriodTo" HeaderText="Period To" />
                                    <asp:BoundField DataField="TrainingType" HeaderText="Training Type" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imagebtnFormalTraining" runat="server" CommandArgument='<%# Eval("ID") %>'
                                                ImageUrl="~/Images/delete.png" OnClick="imagebtnFormalTraining_Click" OnClientClick="return Confirm('Do you want to delete this record?');"
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
    <asp:Panel ID="panelExperience" runat="server" Visible="false" CssClass="lightbox_bg">
        <div class="lightbox">
            <div style="display: inline; float: left; width: 100%;" class="bxmain inner_content">
                <h2>
                    <span>Employment Record </span>
                </h2>
                <table>
                    <tr style="line-height: 1.5;">
                        <td class="style2" style="font-weight: bold; text-align: right;">
                            Institute/Organization Name
                        </td>
                        <td colspan="">
                            <asp:TextBox ID="ERtxtboxInstitute" runat="server"></asp:TextBox>
                        </td>
                        <td style="padding-left: 20px; text-align: right; font-weight: bold;" class="style2">
                            Designation
                        </td>
                        <td>
                            <asp:TextBox ID="ERtxtboxDesignation" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="line-height: 1.5;">
                        <td class="style2" style="font-weight: bold; text-align: right;">
                            Period From
                        </td>
                        <td>
                            <asp:TextBox ID="ERtxtboxPeriodFrom" TextMode="Date" runat="server"></asp:TextBox>
                        </td>
                        <td class="style2" style="font-weight: bold; text-align: right; padding-left: 20px">
                            Period To
                        </td>
                        <td>
                            <asp:TextBox ID="ERtxtboxPeriodTo" TextMode="Date" runat="server"></asp:TextBox>
                        </td>
                        <%--<td class="style2" style="font-weight:bold;padding-left:20px">
                 Experience</td>
            <td>
                <asp:TextBox ID="txtboxExperien" runat="server"></asp:TextBox>
            </td>--%>
                    </tr>
                    <tr>
                        <td style="padding-left: 20px; text-align: right; font-weight: bold;" class="style2">
                            BPS
                        </td>
                        <td>
                            <asp:DropDownList ID="ERtxtboxBPS" runat="server" Visible="true">
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
                        <td class="style2" style="font-weight: bold; text-align: right; padding-left: 20px">
                            Job Description
                        </td>
                        <td>
                            <asp:TextBox ID="ERtxtboxJobDescription" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 20px; text-align: right; font-weight: bold;" class="style2">
                            Nature of Job
                        </td>
                        <td>
                            <asp:DropDownList ID="ERddlNatureOfJob" runat="server">
                                <asp:ListItem Text="Permanent" Value="Permanent"></asp:ListItem>
                                <asp:ListItem Text="Temporary" Value="Temporary"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td class="style2" style="font-weight: bold; text-align: right; padding-left: 20px">
                            Experience
                        </td>
                        <td>
                            <asp:TextBox ID="txtbxExperience" SkinID="intdata" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="line-height: 3;">
                        <td colspan="">
                            &nbsp;
                        </td>
                        <td style="padding-left: 20px; text-align: center" colspan="2">
                            <asp:Button ID="btnSaveExperience" runat="server" Text="Save" OnClick="btnSaveExperience_Click" />
                            <asp:Button ID="btnCloseExperience" runat="server" Text="Close" OnClick="btnCloseExperience_Click" />
                            <%-- <span style="padding-left:20px;"><asp:Label ID="lblmessagemain" runat="server" Text="Data is Save Successfully" Visible="false" ForeColor="Green" Font-Bold="true"></asp:Label></span>--%>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="10">
                            <asp:GridView ID="gvdForExperience" runat="server" AutoGenerateColumns="false" Width="100%">
                                <Columns>
                                    <asp:BoundField DataField="Name" HeaderText="Name" />
                                    <asp:BoundField DataField="CompanyName" HeaderText="Company Name" />
                                    <asp:BoundField DataField="Designation" HeaderText="Designation" />
                                    <asp:BoundField DataField="BPS" HeaderText="BPS" />
                                    <asp:BoundField DataField="JobNature" HeaderText="Job Nature" />
                                    <asp:BoundField DataField="DateFrom" HeaderText="Date From" />
                                    <asp:BoundField DataField="DataTo" HeaderText="Data To" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imagebtn" runat="server" CommandArgument='<%# Eval("ID") %>'
                                                ImageUrl="~/Images/delete.png" OnClick="imagebtnExperience_Click" OnClientClick="return Confirm('Do you want to delete this record?');"
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
    <asp:Panel ID="panelChangePassword" runat="server" Visible="false" CssClass="lightbox_bg">
        <div class="lightbox">
            <div style="display: inline; float: left; width: 100%;" class="bxmain inner_content">
                <h2>
                    <span>Change Password</span></h2>
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form">
                    <tr>
                        <td align="right">
                            New Password :
                        </td>
                        <td>
                            <asp:TextBox ID="TextBoxPassword" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:CompareValidator ControlToCompare="TextBoxPassword" ControlToValidate="TextBoxRePassword"
                                CssClass="err" Display="Dynamic" ErrorMessage="New Password And Confirm Password Faild are Not Same"
                                ID="CompareValidatorCheckPassword" runat="server" Width="280px"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Confirm Password :
                        </td>
                        <td>
                            <asp:TextBox ID="TextBoxRePassword" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ControlToValidate="TextBoxRePassword" CssClass="err"
                                Display="Dynamic" ErrorMessage="Enter Re- Password" ID="RequiredFieldValidatorRePassword"
                                runat="server"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            &nbsp;
                        </td>
                        <td>
                            <asp:Button ID="ButtonUpdatePassword" runat="server" Text="Update" OnClick="ButtonUpdatePassword_Click" />
                            <asp:Button Text="Close" CausesValidation="false" ID="btnCloseChangePasswordPanel"
                                OnClick="btnCloseChangePasswordPanel_Click" runat="server" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </asp:Panel>
    <asp:Panel ID="PanelCountriesVisited" runat="server" Visible="false" CssClass="lightbox_bg">
        <div class="lightbox">
            <div style="display: inline; float: left; width: 100%;" class="bxmain inner_content">
                <h2>
                    <span>Country Visited </span>
                </h2>
                <table>
                    <tr style="line-height: 1.5;">
                        <td class="style2" style="font-weight: bold; text-align: right;">
                            Country Name
                        </td>
                        <td colspan="">
                            <asp:TextBox ID="CCountryName" runat="server"></asp:TextBox>
                        </td>
                        <td style="padding-left: 20px; font-weight: bold;" class="style2">
                            Duration
                        </td>
                        <td>
                            <asp:TextBox ID="CDuration" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="line-height: 1.5;">
                        <td class="style2" style="font-weight: bold; text-align: right;">
                            Purpose Of Visit
                        </td>
                        <td>
                            <asp:TextBox ID="CpurposeOfVisit" runat="server"></asp:TextBox>
                        </td>
                        <%--<td class="style2" style="font-weight:bold;padding-left:20px">
                 Experience</td>
            <td>
                <asp:TextBox ID="txtboxExperien" runat="server"></asp:TextBox>
            </td>--%>
                    </tr>
                    <tr style="line-height: 3;">
                        <td colspan="">
                            &nbsp;
                        </td>
                        <td style="padding-left: 20px; text-align: center" colspan="2">
                            <asp:Button ID="btnCountrySave" runat="server" Text="Save" OnClick="btnCountrySave_Click" />
                            <asp:Button ID="btnCountryClose" runat="server" Text="Close" OnClick="btnCountryClose_Click" />
                            <%-- <span style="padding-left:20px;"><asp:Label ID="lblmessagemain" runat="server" Text="Data is Save Successfully" Visible="false" ForeColor="Green" Font-Bold="true"></asp:Label></span>--%>
                        </td>
                    </tr>
                    <%--  <tr>
                        
           <asp:Label ID="lblPassword" Visible="false" runat="server" ForeColor="Red" Font-Bold="true"
                    Text="Your Current Password=abc@123"></asp:Label>

        <asp:LinkButton ID="lnkpassword" Text="Change Password" OnClick="lnkpassword_Click" Visible="false" runat="server"></asp:LinkButton>
              
                    </tr>--%>
                    <tr>
                        <td colspan="10">
                            <asp:GridView ID="CountryGird" runat="server" AutoGenerateColumns="true" Width="100%">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imagebtnCountryVisit" runat="server" CommandArgument='<%# Eval("ID") %>'
                                                ImageUrl="~/Images/delete.png" OnClick="imagebtnCountryVisit_Click" OnClientClick="return Confirm('Do you want to delete this record?');"
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
    <asp:SqlDataSource ID="SqlDataSource_place_of_birth0" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
        SelectCommand="SELECT DistrictCode, DistrictName, ProvinceCode, Priority FROM DISTRICT ">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceGender" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT Gender_ID, Gender FROM Gender" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_emp_Type" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT [Employee_Type_ID], [Type] FROM [Employee_Type]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Nationality" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
        SelectCommand="SELECT [Nationality_ID], [Nationality_Name] FROM [Nationality]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_religion" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
        SelectCommand="SELECT [Religion_ID], [Religion_name] FROM [Religion]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_place_of_birth" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
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
