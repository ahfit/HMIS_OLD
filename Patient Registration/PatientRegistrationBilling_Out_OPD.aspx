<%@ Page Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true"
    CodeFile="PatientRegistrationBilling_Out_OPD.aspx.cs" Inherits="Patient_Registration_PatientRegistrationBilling_Out"
    Title="Patient Registration" %>
     
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .lightbox_bg
        {
            background-color: #F9DDE2; /*#4AAECE;/*#333333;*/
            height: 54%; /*left: 0;*/ /*opacity: 0.86;*/
            position: absolute; /*top: 0;*/
            width: 44%;
            z-index: 5000;
            padding: 91px;
            left: 30px;
            top: 131px;
            border-radius: 5px;
            border: 1px solid #5C604D;
        }
        
        .lightbox_bg:hover
        {
            -moz-box-shadow: 0 0 5px rgba(0,0,0,0.5);
            -webkit-box-shadow: 0 0 5px rgba(0,0,0,0.5);
           <%-- box-shadow: 0 0 5px rgba(0,0,0,0.5);--%>
        }
        
        .heading
        {
            text-align: right;
            font-weight: bold;
            font-size: 11px;
        }
        
        .lightbox_Left
        {
            background-color: #FFFFFF;
            border: 8px solid #000000;
            border-radius: 10px;
            display: block;
            height: 420px;
            left: 28px;
            padding: 10px;
            position: absolute;
            top: 140px;
            width: 614px;
            z-index: 9999;
        }
        
        
        .pnlSelectServices
        {
            background-color: white;
            width: 625px;
            height: 400px;
            left: 50px;
            top: 120px;
            position: fixed;
        }
        
        .pnlSelectServices
        {
            background-color: #FFFFFF;
            border: 1px solid #DBDEDF;
            height: 428px;
            left: 29px;
            position: fixed;
            top: 120px;
            width: 660px;
            border-radius: 5px;
        }
        .pnlSelectServices:hover
        {
            -moz-box-shadow: 0 0 5px rgba(0,0,0,0.5);
            -webkit-box-shadow: 0 0 5px rgba(0,0,0,0.5);
            box-shadow: 0 0 5px rgba(0,0,0,0.5); /*box-shadow: 10px 10px 5px #888888;*/
        }
        
        
        .rowStyle
        {
            height: 30px;
        }
        .style1
        {
            text-align: right;
            font-weight: bold;
            font-size: 11px;
            width: 80px;
        }
    </style>

    <script type="text/javascript">
        function ClientItemSelected(sender, e) {
            $get("<%=hfNameId.ClientID %>").value = e.get_value();
        } 
    </script>

    <script type="text/javascript">

        $(document).ready(function () {
            $('.captxt').bind('keyup', function () {
                var val = $(this).val().toUpperCase()
                $(this).val(val);
            });


            $('[id$="CheckBoxListRoom"]').change(function () {
                $("[id$='hdnBedId']").val($("[id$='CheckBoxListRoom'] :checked").val());
            });


        });



    </script>
    <script type="text/javascript" language="javascript">

        function txtChange(a) {

            var txt = "";
            var flag = "";

        }
        function show(a) {


            var rbl_prefix = "";
            var rbl_prefix_value = rbl_prefix.getElementsByTagName('input');
            var rbl_r = document.getElementById("<%=RBLrelation.ClientID%>");
            var rbl_r_value = rbl_r.getElementsByTagName('input');

            var sex = document.getElementById("<%=sex.ClientID%>");

            sex.value = 1;
            rbl_r_value[0].checked = true

            if (rbl_prefix_value[1].checked) {

                sex.value = 2;

                rbl_r_value[1].checked = true;

            }

            if (rbl_prefix_value[2].checked) {
                sex.value = 2;
                rbl_r_value[2].checked = true;
            }
        }


        function checkrequiredrfname() {

            if (document.getElementById("ctl00_ContentPlaceHolder1_textboxpfname").value.length == 0) {
                alert("Enter patient name");
                document.getElementById("ctl00_ContentPlaceHolder1_textboxpfname").focus();
                return false;
            }
            if (document.getElementById("ctl00_ContentPlaceHolder1_textboxrfname").value.length == 0) {
                alert("Enter relation name");
                document.getElementById("ctl00_ContentPlaceHolder1_textboxrfname").focus();
                return false;
            }
            if (document.getElementById("ctl00_ContentPlaceHolder1_WebDateTimeEdit_DOB").value.length == 0) {
                alert("Enter DOB");
                document.getElementById("ctl00_ContentPlaceHolder1_WebDateTimeEdit_DOB").focus();
                return false;
            }

            return true;
        }

        function ForAge() {
            var age;
            age = document.getElementById("ctl00_ContentPlaceHolder1_textboxage").value;
            if (age - 0 == age) {
                if ((age >= 1) && (age <= 150)) {
                }
                else {
                    //  alert("Enter Correct Age");
                    document.getElementById("ctl00_ContentPlaceHolder1_textboxage").focus();
                    return false;
                }
            }
            else {
                alert("Must Enter Integer ");
                document.getElementById("ctl00_ContentPlaceHolder1_textboxage").focus();
                return false;
            }
        }


        function showAgedob(val) {
            ForAge()

            var age = document.getElementById('<%=textboxage.ClientID%>').value;


            var date;
            date = igedit_getById('<%=WebDateTimeEdit_DOB.ClientID%>').getText();
            if (date != "") {

                var year_type = document.getElementById('<%=DropDownListBIndicator.ClientID%>').value;
                var edit_date = document.getElementById('<%=WebDateTimeEdit_DOB.ClientID%>');

                var strDate = new Date();

                var date_val;

                if (year_type == "Years") {

                    strDate.setFullYear(strDate.getFullYear() - age);


                }
                else if (year_type == "Months") {
                    strDate.setMonth(strDate.getMonth() + 1 - age);

                }
                else if (year_type == "Days") {
                    strDate.setDate(strDate.getDate() - age);

                }
                else if (year_type == "Hours") {
                    strDate.setHours(date_val = strDate.getHours() - age);

                }

                igedit_getById('<%=WebDateTimeEdit_DOB.ClientID%>').setText(strDate.getDate() + "/" + (strDate.getMonth() + 1) + "/" + strDate.getFullYear());

            }
            else {
                var year_type = document.getElementById('<%=DropDownListBIndicator.ClientID%>').value;
                var edit_date = document.getElementById('<%=WebDateTimeEdit_DOB.ClientID%>');

                var strDate = new Date();

                var date_val;

                if (year_type == "Years") {

                    strDate.setFullYear(strDate.getFullYear() - age);


                }
                else if (year_type == "Months") {
                    strDate.setMonth(strDate.getMonth() + 1 - age);

                }
                else if (year_type == "Days") {
                    strDate.setDate(strDate.getDate() - age);

                }
                else if (year_type == "Hours") {
                    strDate.setHours(date_val = strDate.getHours() - age);

                }




                igedit_getById('<%=WebDateTimeEdit_DOB.ClientID%>').setText(strDate.getDate() + "/" + (strDate.getMonth() + 1) + "/" + strDate.getFullYear());
            }
        }

        function changeYear() {

            var age = document.getElementById('<%=textboxage.ClientID%>').value;
            var date;
            date = igedit_getById('<%=WebDateTimeEdit_DOB.ClientID%>').getText();
            var year_type = document.getElementById('<%=DropDownListBIndicator.ClientID%>').value;
            var edit_date = document.getElementById('<%=WebDateTimeEdit_DOB.ClientID%>');

            var strDate = new Date();

            var date_val;

            if (year_type == "Years") {

                strDate.setFullYear(strDate.getFullYear() - age);


            }
            else if (year_type == "Months") {
                strDate.setMonth(strDate.getMonth() + 1 - age);

            }
            else if (year_type == "Days") {
                strDate.setDate(strDate.getDate() - age);

            }
            else if (year_type == "Hours") {
                strDate.setHours(date_val = strDate.getHours() - age);

            }


            igedit_getById('<%=WebDateTimeEdit_DOB.ClientID%>').setText(strDate.getDate() + "/" + (strDate.getMonth() + 1) + "/" + strDate.getFullYear());

        }
        function showAgedobfocus() {


            var age = document.getElementById('<%=textboxage.ClientID%>').value;
            var year_type = document.getElementById('<%=DropDownListBIndicator.ClientID%>').value;
            var val = igedit_getById('<%=WebDateTimeEdit_DOB.ClientID%>').getText();
            var mytool_array = val.split("/");

            val = mytool_array[1] + "/" + mytool_array[0] + "/" + mytool_array[2];
            var date = new Date(val);

            if (age == "") {
                if (date != "" && date != "Invalid Date") {
                    var date1 = new Date();

                    var ageval = document.getElementById('<%=textboxage.ClientID%>');
                    if (year_type == "Years") {
                        ageval.value = Math.floor((date1 - date) / ((24 * 60 * 60 * 1000) * 30 * 12));
                    }
                    else if (year_type == "Months") {
                        ageval.value = Math.floor((date1 - date) / ((24 * 60 * 60 * 1000) * 30));
                    }
                    else if (year_type == "Days") {
                        ageval.value = Math.floor((date1 - date) / ((24 * 60 * 60 * 1000)));
                    }
                }
            }

            else if (date != "") {
                if (date != "Invalid Date") {

                    var date1 = new Date();
                    var ageval = document.getElementById('<%=textboxage.ClientID%>');
                    if (year_type == "Years") {
                        ageval.value = Math.floor((date1 - date) / ((24 * 60 * 60 * 1000) * 30 * 12));
                    }
                    else if (year_type == "Months") {
                        ageval.value = Math.floor((date1 - date) / ((24 * 60 * 60 * 1000) * 30));
                    }
                    else if (year_type == "Days") {
                        ageval.value = Math.floor((date1 - date) / ((24 * 60 * 60 * 1000)));
                    }
                }
            }


        }


        function showAgeyear(val) {
            //  alert("hello");

        } 
    </script>
    <script src="../SpryAssets/mycollaps.js" type="text/javascript"></script>
    <link href="../SpryAssets/mycollaps.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../css_hacims/maskito.js"></script>
    <script src="../css_hacims/ck.js" type="text/javascript"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            $("#ctl00_ContentPlaceHolder1_textboxmcode").mask("9999-9999999");


//    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div>
        <asp:UpdateProgress ID="UpdateProgress_search" runat="server" DisplayAfter="0">
            <ProgressTemplate>
                <div style="margin-top: 5px; font-size: 11px; position: absolute; margin-top: -29px;">
                    <img id="Img1" src="~/Images_hacims/process.gif" alt="" runat="server" />
                    <span style="margin-left: 5px; color: #999999; display: inline-block; margin-top: 5px;
                        float: right;">Processing your request. Please wait.... </span>
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
    </div>
    <table width="100%">
        <tr>
            <td style="width: 50%; vertical-align: top;">
                <div style="display:none" class="bxmain inner_content" style="width: 99%;">
                    <h2>
                        <span>Search Patient</span></h2>
                    <table width="100%">
                        <tr class="rowStyle">
                            <td class="heading" width="15%;">
                                Registration # :
                            </td>
                            <td>
                                <asp:TextBox ID="txtRegistrationNo" TabIndex="1" runat="server"></asp:TextBox>
                                &nbsp;
                                <asp:Button ID="btnRegistrationSearch" TabIndex="2" runat="server" CausesValidation="false"
                                    Text="Search " OnClick="btnRegistrationSearch_Click" />
                                <asp:Label ID="Label3" runat="server" ForeColor="Red"></asp:Label>
                                <asp:HiddenField ID="HiddenField_UpdateRegNo" runat="server" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="bxmain inner_content" style="width: 99%;">
                    <h2>
                        <span>Patient Information</span></h2>
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td width="50%" align="left" valign="top">
                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                    <tr class="rowStyle">
                                        <td class="heading">
                                            Patient Name :
                                        </td>
                                        <td>
                                            <asp:TextBox AccessKey="n" ID="textboxpfname" Style="background-color: #f9dde2;"
                                                runat="server" TabIndex="3" MaxLength="20" SkinID="captxt"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr class="rowStyle">
                                        <td class="heading">
                                            Relation :
                                        </td>
                                        <asp:HiddenField ID="hdnBedId" runat="server"  />
                                        <td>
                                            <asp:RadioButtonList ID="RBLrelation" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal"
                                                TabIndex="4">
                                                <asp:ListItem Selected="True">S/O</asp:ListItem>
                                                <asp:ListItem>D/O</asp:ListItem>
                                                <asp:ListItem>W/O</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr class="rowStyle">
                                        <td class="heading">
                                            Relation Name :
                                        </td>
                                        <td>
                                            <asp:TextBox ID="textboxrfname" TabIndex="5"  MaxLength="20"
                                                runat="server" SkinID="captxt"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="50%" align="right" valign="top">
                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                    <tr class="rowStyle">
                                        <td class="heading">
                                            DOB :
                                        </td>
                                        <td>
                                            <igtxt:WebDateTimeEdit ID="WebDateTimeEdit_DOB" runat="server" Width="85px" Culture="en-GB"
                                                Style="background-color: #f9dde2;">
                                            </igtxt:WebDateTimeEdit>
                                            <span style="font-size: 10pt; color: #d92542">*</span><asp:HiddenField ID="HiddenField_DOB"
                                                runat="server" />
                                            <asp:TextBox AccessKey="a" ID="textboxage" runat="server" AutoCompleteType="disabled"
                                                Style="background-color: #f9dde2;" ValidationGroup="s" Width="28px" MaxLength="3"
                                                TabIndex="6"></asp:TextBox>
                                            <asp:DropDownList ID="DropDownListBIndicator" runat="server" Width="70px" AccessKey="y">
                                                <asp:ListItem Selected="True">Years</asp:ListItem>
                                                <asp:ListItem>Months</asp:ListItem>
                                                <asp:ListItem>Days</asp:ListItem>
                                                <asp:ListItem>Hours</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" Display="dynamic"
                                                ControlToValidate="textboxage" ErrorMessage="Enter Valid Age" ValidationExpression="[0-9]*">
                                            </asp:RegularExpressionValidator>
                                        </td>
                                    </tr>
                                    <tr class="rowStyle">
                                        <td class="heading">
                                            Gender :
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="sex" TabIndex="7" runat="server" DataSourceID="SexSource" DataTextField="Gender"
                                                DataValueField="Gender_ID" Width="100px" AccessKey="g">
                                                <asp:ListItem Selected="True" Value="M">Male</asp:ListItem>
                                                <asp:ListItem Value="F">Female</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr class="rowStyle">
                                        <td class="heading">
                                            Contact # :
                                        </td>
                                        <td>
                                            <asp:TextBox ID="textboxmcode" TabIndex="8" runat="server" MaxLength="11"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr class="rowStyle">
                            <td colspan="2" class="heading">
                                <table width="100%">
                                    <tr class="rowStyle">
                                        <td class="heading" width="15%">
                                            Address :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtAddress" TabIndex="9" Width="391px" runat="server" SkinID="captxt"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr class="rowStyle">
                                        <td class="heading" width="15%">
                                            Admit By :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="TextBoxDiagnosis" runat="server" Width="391px" SkinID="captxt"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="bxmain inner_content" style="width: 99%; margin-bottom: 4px;">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr class="rowStyle">
                            <td class="heading" width="16%" valign="top">
                                Department :
                            </td>
                            <td colspan="3">
                               <%-- <asp:UpdatePanel ID="upnlDept" runat="server">
                                    <ContentTemplate>--%>
                                        <asp:DropDownList Enabled="false" AccessKey="d" ID="DDLDepartment" TabIndex="10" runat="server" DataSourceID="SqlDataSourceDepartment"
                                            DataTextField="Dept_Name" DataValueField="Dept_ID" Width="140px" AutoPostBack="True"
                                            OnSelectedIndexChanged="DDLDepartment_SelectedIndexChanged">
                                        </asp:DropDownList>
                                        <asp:DropDownList ID="DropDownList1" Enabled="false" runat="server" TabIndex="11" DataSourceID="SqlDataSource_SubDept"
                                            Width="140px" DataTextField="SubDept_Name" DataValueField="SubDept_Id" AutoPostBack="False"
                                            OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                                        </asp:DropDownList>
                                        <asp:DropDownList ID="DropDownList_Employee_name" runat="server" TabIndex="15" DataSourceID="SqlDataSource_Employee"
                                            DataTextField="Employee Name" DataValueField="EmpID" Width="140px" AutoPostBack="True"
                                            Visible="false">
                                        </asp:DropDownList>
                                        <asp:RadioButtonList ID="RadioButtonList_Patient_Type" TabIndex="21" runat="server"
                                            DataValueField="Patient_type_Cat" DataTextField="Patient_type_Cat" AutoPostBack="True"
                                            RepeatLayout="Flow" RepeatDirection="Horizontal" Width="456px">
                                        </asp:RadioButtonList>
                                        <br />
                                        <asp:Label ID="LbL_Mg" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                        <asp:Label ID="lblErrorMsg" ForeColor="Red" Font-Bold="true" runat="Server" Text=""></asp:Label><br />
                                        <asp:Button ID="btnSaveInformation" TabIndex="24" Text="Save Information" OnClick="btnSaveInformation_Click"
                                            runat="Server" Visible="False" />
                                   <%-- </ContentTemplate>
                                </asp:UpdatePanel>--%>
                            </td>
                        </tr>
                    </table>
                </div>
                       <div id="divRoom" class="bxmain inner_content" runat="server" visible="false" style="width: 99%; margin-bottom: 4px;">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr class="rowStyle">
                            <td class="heading" width="16%" valign="top">
                               Assign Beds  :
                            </td>
                            <td colspan="3">
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                       <asp:RadioButtonList ID="CheckBoxListRoom" runat="server" CssClass="chklist" DataSourceID="SqlDataSourceRoomBed"
            DataTextField="Bed_No" DataValueField="Bed_No" RepeatDirection="Horizontal"
            Visible="true" RepeatColumns="15">
        </asp:RadioButtonList>
        <asp:Timer ID="Timer1" runat="server" OnTick="GetTime" Interval="30000" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>

                                <asp:Button ID="btnBedStatus" OnClick="btnBedStatus_Click"  runat="server" Text="Bed Status"/>
                            </td>

                            

                        </tr>
                    </table>
                </div>
                <div id="div1" visible="false" class="bxmain inner_content" runat="server"   style="width: 99%; margin-bottom: 4px;">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr class="rowStyle">
                            <td class="heading" width="16%" valign="top">
                               Patient Type  :
                            </td>
                            <td colspan="3">                              
                                       <asp:RadioButtonList ID="radiobtnListPatientType" runat="server" CssClass="chklist" DataSourceID="SqlDataSourcePatientType"
            DataTextField="Patient_type" DataValueField="ID" RepeatDirection="Horizontal"
            Visible="true" RepeatColumns="15" onselectedindexchanged="RadioButtonList1_SelectedIndexChanged">
        </asp:RadioButtonList>        
                            </td>

                            

                        </tr>
                    </table>
                </div>








               <%--SELECT Ward_Beds.ward_Id, Ward_Beds.Bed_No, Ward_Beds.Bed_Status FROM admin_Hospital_Wards INNER JOIN SubDepartment ON admin_Hospital_Wards.SubDept_Id = SubDepartment.SubDept_Id INNER JOIN Ward_Beds ON admin_Hospital_Wards.Ward_id = Ward_Beds.ward_Id WHERE (admin_Hospital_Wards.Ward_id =106 ) AND (Ward_Beds.Bed_Status = 0)--%>
               
         <asp:SqlDataSource ID="SqlDataSourceRoomBed" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT Ward_Beds.ward_Id, Ward_Beds.Bed_No, Ward_Beds.Bed_Status FROM admin_Hospital_Wards INNER JOIN Ward_Beds ON admin_Hospital_Wards.Ward_id = Ward_Beds.ward_Id WHERE (admin_Hospital_Wards.Ward_id =62 ) AND (Ward_Beds.Bed_Status = 0)">
        
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePatientType" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="select ID,Patient_type from Patient_type where Active=1">
        
    </asp:SqlDataSource>
    

    <div style="text-align:center">
                <asp:Button ID="btnAddServices" runat="server" Text="Add Services" 
                    onclick="btnAddServices_Click"  />
                    
                        <asp:Button ID="btnMakePayment" OnClick="btnMakePayment_Click" runat="server" Text="Register"
                            TabIndex="15" />
                        <asp:Button ID="btn_Refresh" runat="server" OnClick="btn_Refresh_Click" Text="Clear" />
                    
         </div>           
                <table>
                    <tr class="rowStyle">
                        <td colspan="4" style="height: 44px">
                            <div style="width: 90%; margin: auto;">
                                <asp:RadioButtonList ID="rblPatientType_Sub" TabIndex="16" runat="server" AutoPostBack="false"
                                    DataSourceID="SQL_Patient_Type_Sub" DataTextField="Patient_type" DataValueField="Patient_type_id"
                                    RepeatDirection="Horizontal" Style="font-size: 11px;" Visible="true" RepeatLayout="Flow"
                                    Height="20px" RepeatColumns="7" OnSelectedIndexChanged="rblPatientType_Sub_SelectedIndexChanged">
                                </asp:RadioButtonList>
                                <br />
                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                    <tr class="rowStyle">
                                        <td colspan="4">
                                            <asp:Panel ID="pnlPanelPatient" runat="server" Visible="false" Width="100%">
                                                <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                                                    <tr id="td_RegistrationType" runat="server" visible="False">
                                                        <td align="right" width="30%">
                                                            Type :
                                                        </td>
                                                        <td>
                                                            <asp:RadioButtonList ID="rblRegistrationType" runat="server" AutoPostBack="True"
                                                                RepeatDirection="Horizontal" RepeatLayout="Flow">
                                                                <asp:ListItem Selected="True" Value="Self">Self</asp:ListItem>
                                                                <asp:ListItem Value="Dependent">Dependent</asp:ListItem>
                                                            </asp:RadioButtonList>
                                                            <asp:DropDownList ID="ddlEmp_Patient" runat="server" AutoPostBack="True" Visible="False">
                                                            </asp:DropDownList>
                                                            <asp:DropDownList ID="ddlRelation" runat="server" AutoPostBack="True" DataSourceID="SQL_Insert_Dependents"
                                                                DataTextField="Relation" DataValueField="Relation_ID" Visible="False">
                                                                <asp:ListItem>Son</asp:ListItem>
                                                                <asp:ListItem>Daughter</asp:ListItem>
                                                                <asp:ListItem>Father</asp:ListItem>
                                                                <asp:ListItem>Mother</asp:ListItem>
                                                                <asp:ListItem>Wife</asp:ListItem>
                                                                <asp:ListItem>Husband</asp:ListItem>
                                                                <asp:ListItem>Brother</asp:ListItem>
                                                                <asp:ListItem>Sister</asp:ListItem>
                                                                <asp:ListItem>Other</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr id="td_Insurer" runat="Server" visible="False">
                                                        <td align="right">
                                                            Insurer :
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="DropDownList_Parties" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_parties"
                                                                DataTextField="Party_Name" DataValueField="Party_Id">
                                                            </asp:DropDownList>
                                                            <asp:SqlDataSource ID="SqlDataSource_parties" runat="server" ConnectionString="<%$ ConnectionStrings:PatientBilllingConnectionString %>"
                                                                SelectCommand="SELECT     Parties.Party_Id, Parties.Party_Name
FROM         Parties INNER JOIN
                      Patient_Billing_Party ON Parties.Party_Id = Patient_Billing_Party.Billing_Party_Id
WHERE     (Patient_Billing_Party.Patient_Type_Id = @Party_Type_Id)">
                                                                <SelectParameters>
                                                                    <asp:ControlParameter ControlID="rblPatientType_Sub" Name="Party_Type_Id" PropertyName="SelectedValue" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                        </td>
                                                    </tr>
                                                    <tr id="td_Employee_Designation" runat="Server" visible="False">
                                                        <td align="right">
                                                            Employee Designation :
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlDesignation" runat="server" DataSourceID="dsDesignations"
                                                                DataTextField="Party_Desg_Name" DataValueField="Party_Desg_ID">
                                                            </asp:DropDownList>
                                                            <asp:SqlDataSource ID="dsDesignations" runat="server" ConnectionString="<%$ ConnectionStrings:PatientBilllingConnectionString %>"
                                                                ProviderName="<%$ ConnectionStrings:PatientBillingConnectionString.ProviderName %>"
                                                                SelectCommand="Select_Party_Designation" SelectCommandType="StoredProcedure">
                                                                <SelectParameters>
                                                                    <asp:ControlParameter ControlID="DropDownList_Parties" Name="Party_id" PropertyName="SelectedValue"
                                                                        Type="Int32" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                            <asp:SqlDataSource ID="dsEmployeeDependents" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                                                                ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" SelectCommand="SELECT EmployeeDependents.Reg_No, EmployeeDependents.Party_Desg_Name, EmployeeDependents.Party_Name, EmployeeDependents.Prefix, EmployeeDependents.PFName, EmployeeDependents.PMName, EmployeeDependents.PLName, EmployeeDependents.Relation, EmployeeDependents.RFName, EmployeeDependents.RMName, EmployeeDependents.RLName, EmployeeDependents.Gender, EmployeeDependents.Emp_No, EmployeeDependents.RegistrationType, Patient.CNIC, Patient.MobilePhone FROM EmployeeDependents INNER JOIN Patient ON EmployeeDependents.Reg_No = Patient.RegNo WHERE (EmployeeDependents.Emp_No = @Emp_No) AND (EmployeeDependents.Party_Id = @Party_ID) AND (EmployeeDependents.Party_Desg_ID = @Party_Desg_ID) ORDER BY EmployeeDependents.RegistrationType DESC">
                                                                <SelectParameters>
                                                                    <asp:ControlParameter ControlID="txtEmployeeNo" Name="Emp_No" PropertyName="Text" />
                                                                    <asp:ControlParameter ControlID="DropDownList_Parties" Name="Party_ID" PropertyName="SelectedValue" />
                                                                    <asp:ControlParameter ControlID="ddlDesignation" Name="Party_Desg_ID" PropertyName="SelectedValue" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right" style="display: none">
                                                            Principal Employee # :
                                                        </td>
                                                        <td style="display: none">
                                                            <asp:TextBox ID="txtEmployeeNo" runat="server" ToolTip="Enter Employee Number"></asp:TextBox>
                                                            <asp:Button ID="btnSearchEmployee" runat="server" CausesValidation="False" Text="Search"
                                                                ToolTip="Click to search Employee" ValidationGroup="none" />
                                                            <asp:Button ID="Button_Clear" runat="server" Text="Clear" Visible="False" />

                                                                   <asp:TextBox Visible="false" ID="txtReference" runat="server" ToolTip="Enter Reference Number"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right" style="height: 18px">
                                                        </td>
                                                        <td style="height: 18px">
                                                            <asp:Button ID="btnFingerPrint" runat="server" OnClientClick="RunEXE('D:\\New Finger Print\\bin\\FingerprintReader.exe')"
                                                                Text="Finger Print" Visible="False" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlPatientType" TabIndex="17" runat="server" Visible="false">
                                <asp:ListItem>IPD</asp:ListItem>
                                <asp:ListItem Value="OPD" Selected="True"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </td>

           <%-- <td style="border-left: 2px solid gray; vertical-align: top; width: 50%; padding-left: 5px;">
                <table width="100%">
                    <tbody>
                        <tr>
                            <td>
                              
                            </td>
                        </tr>
                    </tbody>
                </table>
                </td>--%>
                </tr>
                </table>
                <!-- Add Services -->
                <!-- End Add Services -->
                  <asp:Label ID="lblMsg" Font-Bold="true" runat="server" Text=""></asp:Label>
                <asp:Panel ID="Panel2" runat="server">
                </asp:Panel>
                <asp:Panel ID="pnlServices" runat="Server">
                    <%--<asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>--%>
                    <%--</ContentTemplate>
                    </asp:UpdatePanel>--%>
                    <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>--%>
                    <table width="100%" style="display: none;">
                        <tbody>
                            <tr style="height: 30px;">
                                <td style="text-align: right">
                                </td>
                                <td style="width: 150px; text-align: center">
                                    <asp:Button ID="btnAddService" Visible="false" OnClick="btnAddService_Click" runat="Server"
                                        Text="Add Service" CausesValidation="false"></asp:Button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                   <asp:Panel ID="panelServices"   runat="server" Visible="false" CssClass="lightbox_bg">
        <div class="lightbox" style="overflow:auto; left: 77%;" >
            <div style="display: inline; float: left; width: 100%;" class="bxmain inner_content" >
                <h2>
                    <span>Add Services         </span></h2>
                    <table class="tbl_form" cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tbody>
                            <tr>
                                <td style="width: 53px" align="right">
                                    <asp:DropDownList ID="DropDownList2" runat="server" DataValueField="Asc_id" DataTextField="Asc_Name"
                                        DataSourceID="SqlDataSource_Packages" AutoPostBack="True" TabIndex="18" 
                                        Width="150px" onselectedindexchanged="DropDownList2_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                                <td align="left">
                                    Search Services :
                                </td>
                                <td>
                                <span style="z-index:9999999px;"  >    <asp:TextBox ID="TextBox_Search_Service" runat="server" CssClass="input_txt" Width="270px"
                                        OnTextChanged="TextBox_Search_Service_TextChanged" AutoPostBack="True" TabIndex="12"></asp:TextBox></span>

                                        <cc1:AutoCompleteExtender ID="Auto_Names_Extender" runat="server" ServiceMethod="SearchNames"
                        MinimumPrefixLength="3" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10" 
                         CompletionListCssClass="AutoExtender"
                            CompletionListItemCssClass="AutoExtenderList" ContextKey="0"  CompletionListHighlightedItemCssClass="AutoExtenderHighlight"
                        TargetControlID="TextBox_Search_Service" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected">
                    </cc1:AutoCompleteExtender> 
                    <asp:HiddenField ID="hfNameId" runat="server" />


                                    <asp:Button ID="btnSearchTest" runat="server" Visible="false" CausesValidation="False" OnClick="btnSearchTest_Click"
                                        TabIndex="13" Text="Search" />
                                        
                                        
                <asp:Button ID="btnClose" runat="server" CausesValidation="False" OnClick="btnClose_Click"
                                        TabIndex="13" Text="Add" />
                                    <asp:HiddenField ID="HiddenFieldServiceDate" runat="server" />
                                    <asp:Label ID="LabelAmountError" runat="server" CssClass="err" Visible="False"></asp:Label>
                                    <br />
                                </td>
                                <td style="width: 100px;">
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="width: 53px">
                                    &nbsp;
                                </td>
                                <td align="left">
                                    &nbsp;
                                </td>
                                <td align="center">
                                </td>
                                <td style="width: 100px;">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr style="display: none">
                                <td style="width: 53px" align="right">
                                    Date :
                                </td>
                                <td>
                                    <igsch:WebDateChooser ID="WebDateChooser1" runat="server" CssClass="drop_date" Width="202px"
                                        Format="Long">
                                    </igsch:WebDateChooser>
                                </td>
                            </tr>
                            <tr style="display: none">
                                <td style="width: 53px" align="right">
                                    Package :
                                </td>
                                <td>
                                    <asp:DropDownList ID="DropDownList_Admin_Service_Package" runat="server" DataValueField="ASP_ID"
                                        DataTextField="AP_Name" DataSourceID="SqlDataSource_Admin_Service_Package" AutoPostBack="True">
                                    </asp:DropDownList>
                                    <asp:Label ID="Label_Amount" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr style="display: none">
                                <td style="width: 53px" align="right">
                                    Refer By :
                                </td>
                                <td>
                                    <asp:DropDownList ID="DropDownList_Refer_By" runat="server" DataValueField="EmpID"
                                        DataTextField="Employee Name" DataSourceID="SqlDataSource_Refer_By">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr style="display: none">
                                <td style="width: 53px" align="right">
                                    Refer Other :
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBox_refer_other" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    </div>
                   
                       
                        <div>

                                                                <asp:GridView Style="margin-left: 0px" ID="GridView_Date_Wise" runat="server" CssClass="Grid_1"
                        Width="100%" DataKeyNames="ID,ServiceID" AutoGenerateColumns="False" OnPreRender="GridView_Date_Wise_PreRender"
                        ShowFooter="True">
                        <RowStyle CssClass="GridItem"></RowStyle>
                        <Columns>
                            <asp:TemplateField HeaderText="Sr. #">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="ServiceDateTime" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}"
                                SortExpression="Date"></asp:BoundField>
                            <asp:BoundField DataField="ServiceDateTime" HeaderText="Time" DataFormatString="{0:hh:mm:ss tt}" />
                            <asp:TemplateField SortExpression="TIme" Visible="false">
                                <ItemTemplate>
                                    <%--<asp:Label ID="Label1" runat="server" Text='<%# Bind("ServiceDateTime") %>'></asp:Label>--%>
                                    <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("Payment_Status", "{0}") %>'>
                                    </asp:HiddenField>
                                    <asp:HiddenField ID="HiddenFieldID" runat="server" Value='<%# Bind("ID", "{0}") %>'>
                                    </asp:HiddenField>
                                    <asp:HiddenField ID="HiddenField_Doctor_ID" runat="server" Value='<%# Bind("Doctor_ID", "{0}") %>'>
                                    </asp:HiddenField>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Services">
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("ServiceName") %>'></asp:Label>
                                    <asp:HiddenField ID="HiddenField2" runat="server" Visible="False" Value='<%# Bind("ServiceID") %>'>
                                    </asp:HiddenField>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Service Charges">
                                <ItemTemplate>
                                    <asp:Label ID="lblServiceCharges" runat="Server" Text='<%#Eval("ServiceCharges") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="lblTotalCharges" runat="Server" Text="0.00"></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <%--<asp:BoundField DataField="ServiceCharges" HeaderText="Charges" SortExpression="ServiceCharges">
                    <FooterStyle HorizontalAlign="Right"></FooterStyle>
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </asp:BoundField>--%>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:DropDownList ID="DropDownList_Doctor" runat="server" Width="100px" DataValueField="EmpID"
                                        DataTextField="Name" DataSourceID="SqlDataSource_Doctor_Charges">
                                    </asp:DropDownList>
                                    <cc1:ListSearchExtender ID="ListSearchExtender1" runat="server" TargetControlID="DropDownList_Doctor">
                                    </cc1:ListSearchExtender>
                                    <br />
                                    <asp:SqlDataSource ID="SqlDataSource_Doctor_Charges" runat="server" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                        SelectCommand="Select '' as Name, 0 as EmpId,0 as services_ID union SELECT ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS Name, Employee.EmpID, Doctor_Service.Service_ID FROM Doctor_Service INNER JOIN Employee ON Doctor_Service.Doctor_ID = Employee.EmpID WHERE (Doctor_Service.Service_ID = @Service_ID) "
                                        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="HiddenField_SID2" Name="Service_ID" PropertyName="Value" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Qty" HeaderText="Qty" SortExpression="Qty" Visible="False">
                            </asp:BoundField>
                            <asp:TemplateField Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="Label_day" runat="server"></asp:Label>
                                </ItemTemplate>
                                <FooterStyle HorizontalAlign="Right" Font-Strikeout="True"></FooterStyle>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgBtnDeleteService" CausesValidation="false" runat="Server"
                                        ImageUrl="~/images_hacims/icon_delete.gif" OnClick="imgBtnDeleteService_Click" />
                                    <asp:HiddenField ID="HiddenField_SID2" runat="server" Value='<%# Bind("ServiceID", "{0}") %>'>
                                    </asp:HiddenField>
                                    <asp:HiddenField ID="HiddenField_ServiceDateTime" runat="server" Value='<%# Bind("ServiceDateTime") %>'>
                                    </asp:HiddenField>
                                    <asp:HiddenField ID="HiddenField_Qty" runat="server" Value='<%# Bind("Qty") %>'>
                                    </asp:HiddenField>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:ButtonField CommandName="Cancel" ImageUrl="~/images_hacims/icon_delete.gif"
                    Text="Cancel" ButtonType="Image"></asp:ButtonField>--%>
                        </Columns>
                        <FooterStyle CssClass="myfooter"></FooterStyle>
                        <HeaderStyle CssClass="GridHeader"></HeaderStyle>
                        <AlternatingRowStyle CssClass="GridAltItem"></AlternatingRowStyle>
                    </asp:GridView>
                
                    </div>
                    
                      </div>

 

                    </asp:Panel>
                
                   

                    <%--</ContentTemplate>
                    </asp:UpdatePanel>--%>
                </asp:Panel>
                <asp:HiddenField ID="HiddenField_Party_ID" runat="server"></asp:HiddenField>
                <asp:HiddenField ID="HiddenField_Amount" runat="server"></asp:HiddenField>
                <asp:HiddenField ID="HiddenField_S_ID" runat="server"></asp:HiddenField>
                <asp:HiddenField ID="hf_Party" runat="server"></asp:HiddenField>
                <asp:HiddenField ID="HiddenField_msg_Patient_Name" runat="server"></asp:HiddenField>
                <asp:HiddenField ID="HiddenField_Msg_Mr_No" runat="server"></asp:HiddenField>
                <asp:HiddenField ID="HiddenField_flag" runat="server"></asp:HiddenField>
                <asp:HiddenField ID="HiddenFieldCast" runat="server"></asp:HiddenField>
                <asp:HiddenField ID="HiddenField_registration_date" runat="server"></asp:HiddenField>
                <asp:HiddenField ID="HiddenField_country" runat="server" Value="12"></asp:HiddenField>
                <asp:HiddenField ID="HiddenField_RegistrationNo" runat="server"></asp:HiddenField>
            
            <!--end EHSAN-->
        



    <asp:SqlDataSource ID="SexSource" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        SelectCommand="SELECT Gender_ID, Gender FROM Gender"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_religion" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT [Religion_ID], [Religion_name] FROM [Religion]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Nationality" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT [Nationality_ID], [Nationality_Name] FROM [Nationality]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQL_Patient_Type_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        ProviderName="System.Data.SqlClient" SelectCommand="SELECT     *
FROM            Patient_Type AS pt INNER JOIN
                         Patient_Type_HospitalWise AS pth ON pt.ID = pth.Patient_Type_Id
WHERE        (pth.Hospital_Id = @Hospital_Id) AND (pt.Active = 'True') ">
        <SelectParameters>
            <asp:SessionParameter Name="Hospital_Id" SessionField="HospitalID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <%--SELECT DISTINCT Department.Dept_Name, Department.Dept_ID FROM Reception_Dept INNER JOIN Department ON Reception_Dept.Dept_Id = Department.Dept_ID WHERE (Reception_Dept.Reception_Status = 1)  AND (Reception_Dept.OPD_IPD='OPD') order by Dept_Name "--%>
    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT Department.Dept_Name, Department.Dept_ID FROM Reception_Dept INNER JOIN Department ON Reception_Dept.Dept_Id = Department.Dept_ID
 WHERE (Reception_Dept.Reception_Status = 1) ">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_SubDept" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT        SubDept_Name, SubDept_Id
FROM            SubDepartment
WHERE        (Dept_Id=@Dept_ID)and (SubDept_Type=2)
ORDER BY SubDept_Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLDepartment" Name="Dept_Id" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Employee" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
        SelectCommand="select 0 as EmpID ,' Self' as [Employee Name] union SELECT EmpID,ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS [Employee Name]
FROM Employee 
WHERE Is_Consultant = 1 ">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="SubDeptId" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQL_Insert_Dependents" runat="server" ConnectionString="<%$ ConnectionStrings:PatientBillingConnectionString %>"
        InsertCommand="INSERT_Panel_EMP_Patients" InsertCommandType="StoredProcedure"
        ProviderName="<%$ ConnectionStrings:PatientBillingConnectionString.ProviderName %>"
        SelectCommand="SELECT     Relation_ID, Relation FROM Patient_Relation">
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenField_Msg_Mr_No" Name="Reg_No" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="DropDownList_Parties" Name="Billing_Party_Id" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter DefaultValue="0" ControlID="ddlRelation" Name="Emp_PT_Relation_Id"
                PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter DefaultValue="0" Name="Emp_Id" Type="Int32" />
            <asp:Parameter DefaultValue="1" Name="Status_Id" Type="Int32" />
            <asp:ControlParameter ControlID="ddlDesignation" DefaultValue="" Name="Category_Id"
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="hfPatient_RegNo" Name="Emp_Reg_No" PropertyName="Value"
                Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Grid2" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT     CASE WHEN Admin_Services.S_Category <> 4 THEN Admin_Services.S_Name ELSE '' END AS S_Name, &#13;&#10;Patient_Services.Amount AS S_Amount , CONVERT(varchar, &#13;&#10;                      Patient_Services.sdatetime, 107) AS Date, CONVERT(varchar, Patient_Services.sdatetime, 108) AS TIme, Patient_Services.ID, Patient_Services.Payment_Status, &#13;&#10;                      Admin_Services.S_ID, Patient_Services.Doctor_ID, CASE WHEN Admin_Services.S_Category = 4 THEN Admin_Services.S_Name ELSE '' END AS S_Name2, &#13;&#10;                      ISNULL(Patient_Services.Qty, 1) AS Qty&#13;&#10;FROM         Party_Ins_Services RIGHT OUTER JOIN&#13;&#10;                      Party_Medical_Services_Group LEFT OUTER JOIN&#13;&#10;                      Patient_Billing_Party ON Party_Medical_Services_Group.Party_Id = Patient_Billing_Party.Billing_Party_Id ON &#13;&#10;                      Party_Ins_Services.Party_Id = Party_Medical_Services_Group.Party_Id RIGHT OUTER JOIN&#13;&#10;                      Admin_Services INNER JOIN&#13;&#10;                      Patient_Services ON Admin_Services.S_ID = Patient_Services.S_ID ON Party_Medical_Services_Group.Reg_No = Patient_Services.RegNo AND &#13;&#10;                      Party_Medical_Services_Group.YearlyNo = Patient_Services.YearlyNo AND Party_Ins_Services.S_Id = Admin_Services.S_ID LEFT OUTER JOIN&#13;&#10;                      Test_Booking ON Admin_Services.S_ID = Test_Booking.S_Id  &#13;&#10;&#13;&#10; WHERE (Patient_Services.RegNo = @RegNo) AND (Patient_Services.YearlyNo = @YearlyNo)  and Patient_Services.Payment_Status=0 ORDER BY Date DESC, time DESC"
        DeleteCommand="DELETE FROM Patient_Services WHERE (ID = @ID) ">
        <SelectParameters>
            <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
        </SelectParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="HiddenField_ID" Name="ID" PropertyName="Value" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_For_Grid" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        CancelSelectOnNullParameter="False" SelectCommand="get_Services" InsertCommand="Insert_Patient_services"
        InsertCommandType="StoredProcedure" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource_For_Grid_Selected"
        OnSelecting="SqlDataSource_For_Grid_Selecting">
        <SelectParameters>
            <asp:Parameter DefaultValue="%" Name="S_Name" />            
            <asp:ControlParameter ControlID="DropDownList2" DefaultValue="0" Name="S_Category" 
                PropertyName="SelectedValue" Type="Int16" />
            <asp:Parameter DefaultValue="0" Name="Reg_No" />
            <asp:Parameter DefaultValue="0" Name="Yearly_No" />
            <asp:ControlParameter ControlID="DropDownList2" DefaultValue="0" Name="ASP_ID" 
                PropertyName="SelectedValue" />
            <%--<asp:Parameter DefaultValue="0" Name="Hospital_Id" />--%>
            <asp:Parameter DefaultValue="0" Name="Patient_Type_Id" />
                <asp:SessionParameter Name="Hospital_Id" SessionField="HospitalId" Type="String" />
            <asp:Parameter DefaultValue="OPD" Name="IPD_OPD" />
            <asp:Parameter DefaultValue="0" Name="Billing_Party_Id" />
        </SelectParameters>
        <InsertParameters>
            <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" Type="String" />
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
            <asp:SessionParameter Name="empid" SessionField="Emp_ID" Type="Int32" />
            <asp:ControlParameter Name="S_ID" Type="Int32" ControlID="HiddenField_SID" PropertyName="Value" />
            <asp:ControlParameter Name="Amount" Type="Int32" ControlID="HiddenField_amount" PropertyName="Value" />
            <asp:Parameter DefaultValue="0" Name="Payment_Status" Type="Int16" />
            <asp:SessionParameter Name="SubDept_ID" SessionField="SubDeptID" Type="Int32" />
            <asp:SessionParameter Name="Dept_ID" SessionField="dept_id" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenFieldServiceDate" Name="sdatetime" PropertyName="Value"
                Type="DateTime" />
            <asp:ControlParameter ControlID="HiddenField_Qty" Name="Qty" PropertyName="Value"
                Type="Double" />
            <asp:Parameter Direction="Output" Name="msg" Size="100" Type="String" />
            <asp:ControlParameter ControlID="DropDownList_Refer_By" Name="Refer_By_ID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_Refer_Other" Name="Refer_From_Other"
                PropertyName="Value" Type="String" />
            <asp:Parameter DefaultValue="0" Name="PatientValue" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Packages" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT '0' AS Asc_id, ' All' AS Asc_Name UNION SELECT CONVERT (varchar, Asc_id) AS Asc_id, Asc_Name 
FROM Admin_Service_Category 
 ORDER BY Asc_Name">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Admin_Service_Package" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT 0 AS ASP_ID, '' AS AP_Name UNION SELECT Admin_Service_Package.ASP_ID, Admin_Service_Package.AP_Name FROM Admin_Service_Package INNER JOIN Advance_Payment ON Admin_Service_Package.ASP_ID = Advance_Payment.ASP_ID WHERE (Advance_Payment.RegNo = @RegNo) AND (Advance_Payment.YearlyNo = @YearlyNo)">
        <SelectParameters>
            <asp:QueryStringParameter Name="RegNo" QueryStringField="regno" />
            <asp:QueryStringParameter Name="YearlyNo" QueryStringField="payid" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Refer_By" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT '' AS [Employee Name], 0 AS EmpID UNION SELECT ISNULL(Prefix, '') + ' ' + ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS [Employee Name], EmpID FROM Employee WHERE (Emp_Type = 'Consultant')">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_info_ot" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        InsertCommand="Insert_OT_PatientRelative_Undertaking" InsertCommandType="StoredProcedure"
        ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:Parameter Name="Prefix" Type="String" DefaultValue="" />
            <asp:ControlParameter ControlID="textboxpfname" Name="RelativeFName" PropertyName="Text"
                Type="String" />
            <asp:Parameter DefaultValue="&quot;&quot;" Name="RelativeMName" Type="String" />
            <asp:Parameter DefaultValue="&quot;&quot;" Name="RelativeLName" Type="String" />
            <asp:ControlParameter ControlID="RBLrelation" Name="RelativeRType" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="textboxrfname" Name="RelativeRFName" PropertyName="Text"
                Type="String" />
            <asp:Parameter DefaultValue="&quot;&quot;" Name="RelativeRMName" Type="String" />
            <asp:Parameter DefaultValue="&quot;&quot;" Name="RelativeRLName" Type="String" />
            <asp:Parameter Name="NIC" Type="String" />
            <asp:Parameter Name="Country" Type="Int32" />
            <asp:Parameter Name="Province" Type="Int32" />
            <asp:Parameter Name="District" Type="Int32" />
            <asp:Parameter Name="Tehsil" Type="Int32" />
            <asp:Parameter Name="PhoneNo" Type="String" />
            <asp:ControlParameter ControlID="RadioButtonList1" Name="Sex" PropertyName="SelectedValue"
                Type="String" />
            <asp:Parameter Name="RelationWithPatient" Type="String" />
            <asp:ControlParameter ControlID="HiddenField_RegistrationNo" Name="PatientRegNo"
                PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="HiddenField_mobile_Phone" Name="Mobile_Phone" PropertyName="Value" />
            <asp:ControlParameter ControlID="textboxTown" Name="Town" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TextBox_House" Name="House_No" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="TextBox_Street" Name="Street" PropertyName="Text"
                Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Doctor_Services" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        DeleteCommand="DELETE FROM Doctor_Service WHERE (DS_ID = @DS_ID)" InsertCommand="[Insert_Patient_services_and_Payment]"
        InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT Admin_Services.S_Name, Doctor_Service.Charges, Doctor_Service.Doctor_ID, Doctor_Service.DS_ID, Doctor_Service.Bank_Payment AS [Bank Charges], Admin_Services.S_Amount AS [Services Charges], Admin_Services.S_ID FROM Doctor_Service INNER JOIN Admin_Services ON Doctor_Service.Service_ID = Admin_Services.S_ID WHERE (Doctor_Service.Doctor_ID = @Doctor_ID) and Admin_Services.S_Name like '%Consultation%'">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_Employee_name" DefaultValue="" Name="Doctor_ID"
                PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="GridView1" Name="DS_ID" PropertyName="SelectedValue" />
        </DeleteParameters>
        <InsertParameters>
            <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" Type="String" />
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
            <asp:SessionParameter Name="empid" SessionField="Emp_ID" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_S_ID" Name="S_ID" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_Amount" Name="Amount" PropertyName="Value"
                Type="Int32" />
            <asp:Parameter DefaultValue="0" Name="Payment_Status" />
            <asp:SessionParameter DefaultValue="" Name="SubDept_ID" SessionField="SubDeptID"
                Type="Int32" />
            <asp:SessionParameter Name="Dept_ID" SessionField="dept_id" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList_Employee_name" Name="Doctor_ID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:SessionParameter Name="Hospital_Id" SessionField="HospitalId" Type="Int32" />
            <asp:ControlParameter ControlID="rblPatientType_Sub" DefaultValue="" Name="Patient_Type_Id"
                PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter DefaultValue="OPD" Name="IPD_OPD" Type="String" />
            <asp:ControlParameter ControlID="hf_Party" Name="Billing_Party_Id" PropertyName="Value"
                Type="Decimal" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="get_Services" InsertCommand="Insert_Patient_services" InsertCommandType="StoredProcedure"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="TextBox_Search_Service" DefaultValue="%" Name="S_Name"
                PropertyName="Text" />
            <asp:ControlParameter ControlID="DropDownList2" DefaultValue="0" Name="S_Category"
                PropertyName="SelectedValue" Size="10" Type="Int16" />
            <asp:QueryStringParameter Name="Reg_No" QueryStringField="regno" />
            <asp:QueryStringParameter Name="Yearly_No" QueryStringField="payid" />
            <asp:ControlParameter ControlID="DropDownList_Admin_Service_Package" DefaultValue=""
                Name="ASP_ID" PropertyName="SelectedValue" />
            <asp:SessionParameter Name="Hospital_Id" SessionField="PatientHospital_Id" Type="Int32" />
            <asp:SessionParameter Name="Patient_Type_Id" SessionField="Patient_type_Id" Type="Int32" />
            <asp:SessionParameter Name="IPD_OPD" SessionField="IPDOPD" Type="String" />
            <asp:SessionParameter Name="Billing_Party_Id" SessionField="PatientBillingParty_Id"
                Type="Decimal" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="RegNo" Type="String" />
            <asp:Parameter Name="YearlyNo" Type="String" />
            <asp:Parameter Name="empid" Type="Int32" />
            <asp:Parameter Name="S_ID" Type="Int32" />
            <asp:Parameter Name="Amount" />
            <asp:ControlParameter Name="PanelAmount" Type="Int32" ControlID="HiddenField_PanelAmount"  PropertyName="Value" /> 
            <asp:Parameter DefaultValue="0" Name="Payment_Status" Type="Int16" />
            <asp:Parameter Name="SubDept_ID" Type="Int32" />
            <asp:Parameter Name="Dept_ID" Type="Int32" />
            <asp:Parameter Name="sdatetime" Type="DateTime" />
            <asp:Parameter Name="Qty" Type="Double" />
            <asp:Parameter Direction="Output" Name="msg" Size="100" Type="String" />
            <asp:Parameter Name="Refer_By_ID" Type="Int32" />
            <asp:Parameter Name="Refer_From_Other" Type="String" />            
            <asp:Parameter DefaultValue="0" Name="DoctorId" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldPFName" runat="server" />
    <asp:HiddenField ID="HiddenFieldPMName" runat="server" />
    <asp:HiddenField ID="HiddenFieldPLName" runat="server" />
    <asp:HiddenField ID="HiddenField_phone_no" runat="server" />
    <asp:HiddenField ID="HiddenField_mobile_no" runat="server" />
    <asp:HiddenField ID="HiddenField_phone_no_ot" runat="server" />
    <asp:HiddenField ID="HiddenField4" runat="server" />
    <asp:HiddenField ID="HiddenField_PatientType" runat="server" />
    <asp:HiddenField ID="HiddenField_RegistrationNUmber" runat="server" />
    <asp:HiddenField ID="HiddenField_cnic" runat="server" />
    <asp:HiddenField ID="HiddenField_IPD_OPD" runat="server" />
    <asp:HiddenField ID="HiddenField_PanelAmount" runat="server"     Value="0" />
    <asp:UpdateProgress ID="updProgress" runat="server">
        <ProgressTemplate>
            <img alt="progress" src="../images/ajaxloader.gif" width="40PX" />
            Processing...</ProgressTemplate>
    </asp:UpdateProgress>
    <asp:HiddenField ID="HiddenField_PatientTYpeName" runat="server" />
    <asp:HiddenField ID="HiddenField_IsUpdate" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourceUpdate" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" UpdateCommand="Update_PatientInformation"
        UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenField_RegistrationNUmber" Name="RegNo" PropertyName="Value"
                Type="String" />
            <asp:Parameter DefaultValue="&quot;&quot;" Name="Prefix" Type="String" />
            <asp:ControlParameter ControlID="HiddenFieldPFName" Name="PFName" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="HiddenFieldPMName" Name="PMName" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="RBLrelation" Name="Relation" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="textboxrfname" Name="RFName" PropertyName="Text"
                Type="String" />
            <asp:Parameter DefaultValue="&quot;&quot;" Name="RMName" Type="String" />
            <asp:ControlParameter ControlID="sex" Name="SexID" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="textboxage" Name="Age" PropertyName="Text" Type="Int32" />
            <asp:Parameter DefaultValue="0" Name="CountryCode" Type="Int32" />
            <asp:Parameter DefaultValue="0" Name="ProvinceCode" Type="Int32" />
            <asp:Parameter DefaultValue="0" Name="DistrictCode" Type="Int32" />
            <asp:Parameter DefaultValue="0" Name="TehsilCode" Type="Int32" />
            <asp:Parameter DefaultValue="0" Name="Zipcode" Type="Decimal" />
            <asp:Parameter DefaultValue="0" Name="StreetAddress" Type="String" />
            <asp:Parameter DefaultValue="0" Name="Colony" Type="String" />
            <asp:Parameter DefaultValue="0" Name="HomePhone" Type="String" />
            <asp:ControlParameter ControlID="HiddenField_mobile_no" Name="MobilePhone" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="HiddenField_CNIC" Name="CNIC" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="HiddenField_DOB" Name="DateOfBirth" PropertyName="Value"
                Type="DateTime" />
            <asp:ControlParameter ControlID="DropDownListBIndicator" Name="AgeType" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="txtAddress" DefaultValue="" Name="HouseNo" PropertyName="Text" />
            <asp:ControlParameter ControlID="HiddenFieldPLName" Name="PLName" PropertyName="Value"
                Type="String" />
            <asp:Parameter DefaultValue="&quot;&quot;" Name="RLName" Type="String" />
            <asp:Parameter DefaultValue="0" Name="Passport_No" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_PatientTYpeName" Name="Patient_Type"
                PropertyName="Value" Type="String" />
            <asp:Parameter DefaultValue="0" Name="Email_address" Type="String" />
            <asp:ControlParameter ControlID="HiddenField_Party_ID" Name="party_ID" PropertyName="Value"
                Type="Int32" />
            <asp:Parameter DefaultValue="&quot;&quot;" Name="Religion" Type="Int32" />
            <asp:Parameter DefaultValue="&quot;Pakistani&quot;" Name="Nationality" Type="Int32" />
            <asp:ControlParameter ControlID="DDLDepartment" Name="DeptId" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList1" Name="To_Sub_Dept_id" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList_Employee_name" Name="DoctorId" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_IPD_OPD" Name="Patient_Type_IPD_OPD"
                PropertyName="Value" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="hdfTabindexCnt" runat="server" Value="0" />


     <asp:SqlDataSource ID="SqlDataSource_Update" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        UpdateCommand="UPDATE Ward_Beds SET Bed_Status = 1 WHERE (ward_Id = @ward_Id) AND (Bed_id = @Bed_ID)">
        <UpdateParameters>
            <asp:Parameter  Name="ward_Id" Type="Int32"   />
            <asp:Parameter  Name="Bed_ID" Type="Int32"  />
        </UpdateParameters>
    </asp:SqlDataSource>








</asp:Content>
