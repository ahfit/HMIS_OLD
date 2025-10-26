<%@ page language="VB" autoeventwireup="true" masterpagefile="~/hacims_masterpage_admin.master" CodeFile="~/Patient Registration/PatientRegistration_Out.aspx.vb" inherits="PatientRegistration_Card" enableeventvalidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>


<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %><asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%--<script type="text/javascript" src="../css_hacims/jquery.min.js"></script>--%>
    
    <script src="../Scripts/mycollaps.js" type="text/javascript"></script>
    <link href="../css_hacims/mycollaps.css" rel="stylesheet" type="text/css" />    
    <script src="../Scripts/ck.js" type="text/javascript"></script> 
    
    <script type="text/javascript">
        function openWin(url) {
            var myWindow = window.open(url, "_blank", "width=1px, height=1px");

            setTimeout(function () { myWindow.close() }, 2000);
        }
</script>
    <style type="text/css">
        .input_txt
        {
            width: 200px;
        }
        .drop_date
        {
            width: 202px;
        }
        
        .show
        {
            display: block;
        }
        .bxmain
        {
            margin-top: 0px;
        }
        .mtop
        {
            margin-top: -10px;
        }
        .style1
        {
            width: 8%;
        }
        
       .n_print
        {
            background: url(../images_hacims/img_btn_bg.png) bottom left repeat-x;
height: 28px;
width: auto;
cursor: pointer;
outline: none;
margin: 0px;
font-size: 15px;
line-height: 17pt;
font-weight: bold;
color: red;
padding-bottom: 2px;
font-family: Calibri;
border: #e1e1e1 solid 1px;
border-bottom: #e1e1e1 solid 0px;
-webkit-border-radius: 4px;
-moz-border-radius: 4px;

-webkit-box-shadow: #a8a8a8 0px 1px 1px;
-moz-box-shadow: #a8a8a8 0px 1px 1px;

padding-left: 20px;
padding-right: 20px;

border-radius: 4px;
box-shadow: #a8a8a8 0px 1px 1px;
behavior: url(PIEq.htc);
text-shadow: 1px 1px 0px #fff;
        }
        
       .n_print:focus
        {
            border:2px solid purple;
            color:Purple;
        }
        
    </style>
    
    <script type="text/javascript">

        $(document).ready(function () {

            $('#ctl00_ContentPlaceHolder1_Button_Clear').click(function () {

                $('input').val("");

                $('#ctl00_ContentPlaceHolder1_Button_Clear').val("Clear")

            });
        });
 
 

    </script>
    <script type="text/javascript">

        $(document).ready(function () {
            $('.captxt').bind('keyup', function () {
                var val = $(this).val().toUpperCase()
                $(this).val(val);
            });
        });




    </script>
    <script type="text/javascript">

        $(document).ready(function () {

            $("#ctl00_ContentPlaceHolder1_CheckBox_Same_as_Above").removeAttr('checked');
            $("#ctl00_ContentPlaceHolder1_textboxage").keydown(function () {
                var ag = $("#ctl00_ContentPlaceHolder1_textboxage:input").val();
                if (ag < 18) {
                    $("#ctl00_ContentPlaceHolder1_pnl_cnic").show();
                    $("#ctl00_ContentPlaceHolder1_CheckBox_Same_as_Above").attr('checked', 'checked');
                    copy1();
                }
                else {
                    $("#ctl00_ContentPlaceHolder1_pnl_cnic").hide();
                    $("#ctl00_ContentPlaceHolder1_CheckBox_Same_as_Above").removeAttr('checked');
                }



            })
            var ag2 = $("#ctl00_ContentPlaceHolder1_textboxage:input").val();
            if (ag2 < 18 && ag2 != 0) {
                $("#ctl00_ContentPlaceHolder1_pnl_cnic").show();
                $("#ctl00_ContentPlaceHolder1_CheckBox_Same_as_Above").attr('checked', 'checked');

            }

        });

 

    </script>
    <script type="text/javascript">

        $(document).ready(function () {
            $("#ctl00_ContentPlaceHolder1_checkbox_copyadd").removeAttr('checked');

            $("#ctl00_ContentPlaceHolder1_textboxage").val() == "";
            $("#ctl00_ContentPlaceHolder1_textboxmcode").val() == "";



            $("#ctl00_ContentPlaceHolder1_checkbox_copyadd").bind("click", function () {
                if ($("#ctl00_ContentPlaceHolder1_checkbox_copyadd:checked").length) {
                    $("#ctl00_ContentPlaceHolder1_TextBox_House_Ot").val($("#ctl00_ContentPlaceHolder1_textboxHouseNo").val());
                    $("#ctl00_ContentPlaceHolder1_TextBox_Street_OT").val($("#ctl00_ContentPlaceHolder1_textboxstreetaddress").val());


                    $("#ctl00_ContentPlaceHolder1_country_ot").val($("#ctl00_ContentPlaceHolder1_country").val());
                    $("#ctl00_ContentPlaceHolder1_Province_ot").val($("#ctl00_ContentPlaceHolder1_Province").val());

                    $("#ctl00_ContentPlaceHolder1_district_ot").css("display", "none");
                    $("#ctl00_ContentPlaceHolder1_tehsil_ot").css("display", "none");
                    $("#ctl00_ContentPlaceHolder1_district_ot_txt").css("display", "block");
                    $("#ctl00_ContentPlaceHolder1_tehsil_ot_txt").css("display", "block");
                    $("#ctl00_ContentPlaceHolder1_district_ot_txt").val($("#ctl00_ContentPlaceHolder1_district").find(":selected").text());
                    $("#ctl00_ContentPlaceHolder1_tehsil_ot_txt").val($("#ctl00_ContentPlaceHolder1_tehsil").find(":selected").text());


                }
                else {
                    $("#ctl00_ContentPlaceHolder1_TextBox_House_Ot").val("");
                    $("#ctl00_ContentPlaceHolder1_TextBox_Street_OT").val("");


                    $("#ctl00_ContentPlaceHolder1_country_ot").val("");
                    $("#ctl00_ContentPlaceHolder1_Province_ot").val("");
                    $("#ctl00_ContentPlaceHolder1_district_ot").val("");
                    $("#ctl00_ContentPlaceHolder1_tehsil_ot").val("");
                    $("#ctl00_ContentPlaceHolder1_district_ot").css("display", "block");
                    $("#ctl00_ContentPlaceHolder1_tehsil_ot").css("display", "block");
                    $("#ctl00_ContentPlaceHolder1_district_ot_txt").css("display", "none");
                    $("#ctl00_ContentPlaceHolder1_tehsil_ot_txt").css("display", "none");

                }
            });
        }
    );   
    </script>

    
    <script language="javascript" type="text/javascript">
        function RunEXE(prog) {
            //alert(prog);
            var oShell = new ActiveXObject("WScript.Shell");         
            oShell.Run('"' + prog + '"', 1);            
        }
    </script>
    <script type="text/javascript" language="javascript">

        function getList_ot(from) {
            if (from.value == null) {
                var Selectioncategory = 'ctl00_ContentPlaceHolder1_country_ot';
                argsName = "cc";
                argsValue = "ALL";
            }
            else
                if (from.name == 'ctl00_ContentPlaceHolder1_country_ot') {
                    var Selectioncategory = 'ctl00_ContentPlaceHolder1_Province_ot';
                    argsName = "pp";
                    argsValue = from.value;
                    document.getElementById('ctl00_ContentPlaceHolder1_textboxphonecode_ot').value = from.value;
                }
                else
                    if (from.name == 'ctl00_ContentPlaceHolder1_Province_ot') {
                        var Selectioncategory = 'ctl00_ContentPlaceHolder1_district_ot';
                        argsName = "dd";
                        argsValue = from.value;
                        document.getElementById('ctl00_ContentPlaceHolder1_textboxphonecode_ot').value = from.value;
                    }
                    else if (from.name == 'ctl00_ContentPlaceHolder1_district_ot') {
                        var Selectioncategory = 'ctl00_ContentPlaceHolder1_tehsil_ot';
                        argsName = "tt";
                        argsValue = from.value;


                    }

            ///////////////////////////////////////////////////////////////////////////////////////////////
            if (from.value == null) {
                countryList = document.getElementById('ctl00_ContentPlaceHolder1_country_ot');
                getList_ot(countryList);
            } else if (from.name == 'ctl00_ContentPlaceHolder1_country_ot') {
                ProvinceyList = document.getElementById('ctl00_ContentPlaceHolder1_Province_ot');
                getList_ot(ProvinceyList);
            } else if (from.name == 'ctl00_ContentPlaceHolder1_Province_ot') {
                ProvinceyList = document.getElementById('ctl00_ContentPlaceHolder1_district_ot');
                getList_ot(ProvinceyList);
            }

            ///////////////////////////////////////////////////////////////////////////////////////////////  
            document.getElementById('ctl00_ContentPlaceHolder1_HiddenField_country_ot').value = document.getElementById('ctl00_ContentPlaceHolder1_country_ot').value;
            document.getElementById('ctl00_ContentPlaceHolder1_HiddenField_province_ot').value = document.getElementById('ctl00_ContentPlaceHolder1_Province_ot').value;
            document.getElementById('ctl00_ContentPlaceHolder1_HiddenField_district_ot').value = document.getElementById('ctl00_ContentPlaceHolder1_district_ot').value;
            document.getElementById('ctl00_ContentPlaceHolder1_HiddenField_tehsil_ot').value = document.getElementById('ctl00_ContentPlaceHolder1_tehsil_ot').value;
        }
        function setit_ot(a) {
            document.getElementById('ctl00_ContentPlaceHolder1_HiddenField_tehsil_ot').value = document.getElementById('ctl00_ContentPlaceHolder1_tehsil').value;
        }



        function main(a) {

        }

        function txtChange(a) {

            var txt = document.getElementById("<%=textboxnic1.ClientID%>");
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


        function show(a) {


            var rbl_prefix = document.getElementById("<%=RBLprefix.ClientID%>");
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
            if (rbl_prefix_value[3].checked) {
                sex.value = 3;
                rbl_r_value[1].checked = true;
            }
            if (rbl_prefix_value[4].checked) {
                sex.value = 3;
                rbl_r_value[0].checked = true;
            }
        }

        function show_ot(a) {


            var rbl_prefix = document.getElementById("<%=RBLprefix_ot.ClientID%>");
            var rbl_prefix_value = rbl_prefix.getElementsByTagName('input');

            var rbl_r = document.getElementById("<%=RadioButtonList1_ot.ClientID%>");
            var rbl_r_value = rbl_r.getElementsByTagName('input');




            var val = document.getElementById("<%=DropDownListRelationwithPatient_ot.ClientID%>");

            val.value = "Son";
            rbl_r_value[0].checked = true;

            if (rbl_prefix_value[1].checked) {

                val.value = "Daughter";

                rbl_r_value[1].checked = true;

            }

            if (rbl_prefix_value[2].checked) {
                val.value = "Wife";
                rbl_r_value[1].checked = true;
            }
        }

        function resetform() {
            document.form1.reset();
            document.getElementById("ctl00_ContentPlaceHolder1_dropdownlistdiagnosis").focus();
        }

        function showFocus(a) {
            document.getElementById("ctl00_ContentPlaceHolder1_dropdownlistdiagnosis").disabled = true;
        }

        function showFocus1(a) {
            if (a.value.length != 0) {
                document.getElementById("ctl00_ContentPlaceHolder1_dropdownlistdiagnosis").disabled = true;
            }
            else {
                document.getElementById("ctl00_ContentPlaceHolder1_dropdownlistdiagnosis").disabled = false;
            }
        }
        function showAge(a) {
            //document.getElementById("WebDateTimeEditDOB").disabled =true;
        }
        function showAge1(a) {

        }

        function make_date_of_birth() {

        }

        

        function trimAll(sString) {
            while (sString.substring(0, 1) == ' ') {
                sString = sString.substring(1, sString.length);
            }
            while (sString.substring(sString.length - 1, sString.length) == ' ') {
                sString = sString.substring(0, sString.length - 1);
            }
            return sString;
        }

        function copy1() {
            //alert("yes" + document.getElementById("ctl00_ContentPlaceHolder1_DropDownListRelationwithPatient_ot").value );
            if (document.getElementById("ctl00_ContentPlaceHolder1_CheckBox_Same_as_Above").checked) {
                //alert("ok");

                document.getElementById("ctl00_ContentPlaceHolder1_textboxpfname_ot").value = document.getElementById("ctl00_ContentPlaceHolder1_textboxrfname").value
                document.getElementById("ctl00_ContentPlaceHolder1_textboxpmname_ot").value = document.getElementById("ctl00_ContentPlaceHolder1_textboxrmname").value
                document.getElementById("ctl00_ContentPlaceHolder1_textboxplname_ot").value = document.getElementById("ctl00_ContentPlaceHolder1_textboxrlname").value

            }
            else {
                //alert("No");
                document.getElementById("ctl00_ContentPlaceHolder1_textboxpfname_ot").value = "";
                document.getElementById("ctl00_ContentPlaceHolder1_textboxpmname_ot").value = "";
                document.getElementById("ctl00_ContentPlaceHolder1_textboxplname_ot").value = "";
            }
        }
        function radio1() {
            //alert("ok" + document.getElementsById("ctl00_ContentPlaceHolder1_RBLrelation") );
            var radio = document.getElementsById("ctl00_ContentPlaceHolder1_RBLrelation");
            for (var i = 0; i < radio.length; i++) {
                if (radio[i].checked) {
                    // alert("Selectd Value = "+ radio[i].value);
                }

            }
        }


        function checkrequiredrfname() {
         <%--   var mobile_No;
            var phoneNo;
            var check;
            debugger;
            mobile_No = igedit_getById('<%=textboxmcode.ClientID%>').getText();
            phoneNo = document.getElementById('<%=textboxphoneno.ClientID%>').value;
            check = document.getElementById('<%=HiddenField_flag.ClientID%>');

            mobile_No = $.trim(mobile_No);
            if (mobile_No.length == 12 || phoneNo.length == 7) {
                check.value = 0;

            }
            else {
                check.value = 1;

            }--%>                
                

                if (document.getElementById("ctl00_ContentPlaceHolder1_textboxpfname").value.length == 0) {
                    alert("Enter first name");
                    document.getElementById("ctl00_ContentPlaceHolder1_textboxpfname").focus();
                    return false;
                }

                if (document.getElementById("ctl00_ContentPlaceHolder1_textboxrfname").value.length == 0) {
                    alert("Enter relation first name");
                    document.getElementById("ctl00_ContentPlaceHolder1_textboxrfname").focus();
                    return false;
                }
                if (document.getElementById("ctl00_ContentPlaceHolder1_WebDateTimeEdit_DOB").value.length == 0) {
                    alert("Enter DOB");
                    document.getElementById("igtxtctl00_ContentPlaceHolder1_WebDateTimeEdit_DOB").focus();
                    return false;
                }                
                if (document.getElementById("ctl00_ContentPlaceHolder1_textboxmcode").value.length == 0) {
                    alert("Enter contact number");
                    document.getElementById("ctl00_ContentPlaceHolder1_textboxmcode").focus();
                    return false;
                }
                
                if (document.getElementById("ctl00_ContentPlaceHolder1_txtEmailAddress").value != "") {
                    var pattern = new RegExp(/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i);
                    if (!pattern.test(document.getElementById("ctl00_ContentPlaceHolder1_txtEmailAddress").value)) {
                        document.getElementById("ctl00_ContentPlaceHolder1_txtEmailAddress").focus();
                        alert("Enter valid email address");
                        return false;
                    }
                }

                if (confirm('Are you sure you want to Save and print?')) {
                    return true;
                }
                else {
                    return false;
                }
            
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
        function ForName() {
            //  alert("Hello");
        }
        function Age_DateofBirth() {
            // alert("Hello");
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

    <script type="text/javascript">

        $(document).ready(function () {


            $("#ctl00_ContentPlaceHolder1_textboxmcodeb").mask("9999-9999999");
            $("#ctl00_ContentPlaceHolder1_textboxmcode").mask("9999-9999999");
            $("#ctl00_ContentPlaceHolder1_textboxmcode_ot").mask("9999-9999999");

            $("#ctl00_ContentPlaceHolder1_textboxnic1b").mask("99999-9999999-9");
            $("#ctl00_ContentPlaceHolder1_textboxnic1").mask("99999-9999999-9");
            $("#ctl00_ContentPlaceHolder1_textboxnic1_ot").mask("99999-9999999-9");





            $(function () {
                $('input[id$=ctl00_ContentPlaceHolder1_textboxnic1b]').keyup(function () {
                    var txtClone = $(this).val();
                    $('input[id$=ctl00_ContentPlaceHolder1_textboxnic1_ot]').val(txtClone);
                });
            });

            $(function () {
                $('input[id$=ctl00_ContentPlaceHolder1_textboxmcodeb]').keyup(function () {
                    var txtClone = $(this).val();
                    $('input[id$=ctl00_ContentPlaceHolder1_textboxmcode_ot]').val(txtClone);
                });
            });

            $(function () {
                $('input[id$=ctl00_ContentPlaceHolder1_textboxmcodeb]').keyup(function () {
                    var txtClone = $(this).val();
                    $('input[id$=ctl00_ContentPlaceHolder1_textboxmcode]').val(txtClone);
                });
            });

        });
      
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
 
 <%--   <script type="text/javascript" src="../CommanMJAJAXLibrary.js"></script>--%>
    <script type="text/javascript">
        var object1 = createXmlObject();
        var argsName;
        var argsValue;
        //function getList(from)
        //{
        //    if(from.value==null)
        //    {
        //    var Selectioncategory='country';
        //    argsName="cc";
        //   argsValue="ALL";
        //   document.getElementById('ctl00_ContentPlaceHolder1_textboxphonecode').value=from.value;
        //   }
        //       else if(from.name =='country')      
        //         {
        //        var Selectioncategory='Province';
        //        argsName="pp";
        //        argsValue=from.value;
        //        document.getElementById('ctl00_ContentPlaceHolder1_textboxphonecode').value=from.value;
        //        }
        //            else if(from.name =='Province')
        //        {
        //        var Selectioncategory='district';
        //        argsName="dd";
        //        argsValue=from.value;
        //        document.getElementById('ctl00_ContentPlaceHolder1_textboxphonecode').value=from.value;
        //        }
        //         else if(from.name =='district')
        //        {
        //        var Selectioncategory='tehsil';
        //       argsName="tt";
        //       argsValue=from.value;
        //        document.getElementById('ctl00_ContentPlaceHolder1_textboxphonecode').value=from.value;
        //        }
        //        
        ////  /////////////////////////////////////////////////////////////////////////      
        ////        if(object1)
        ////        {
        ////        
        ////            object1.open("GET","http://203.175.76.250/szh/Hfindaddress.ashx?a="+argsName+"&b="+argsValue,false);
        ////            object1.onreadystatechange=function()
        ////                {
        ////                    if(object1.readyState==LOADING)

        ////			        {
        ////			            document.getElementById('wait').style.display="block";
        ////			            var mark = document.getElementById('wait');
        ////                        mark.style.left=event.clientX;
        ////                        mark.style.top=event.clientY;
        ////                        
        ////			        }
        ////			        
        ////                    if(object1.readyState==COMPLETE)
        ////                    {
        ////                        //alert(object1.readyState);
        ////                        document.getElementById('wait').style.display="none";
        ////                        var values=object1.responseXML;
        ////                        var nodes = values.selectNodes("//root/collection"); 
        ////                        //alert(values);
        ////                        var i=0;
        ////                        var countryList = document.getElementById(Selectioncategory);
        ////                       
        ////                        while(i<countryList.length)
        ////				        {
        ////				        document.getElementById(Selectioncategory).removeChild(countryList[0]);
        ////				        }
        ////                            while(i<nodes.length)
        ////                            {
        ////                                var newoption = document.createElement('option');
        ////					            countryList.options.add(newoption);
        ////					            newoption.text=nodes[i].selectSingleNode("name/text()").nodeValue;
        ////					            newoption.value=nodes[i].selectSingleNode("code/text()").nodeValue;
        ////                                i++;
        ////                            }
        ////                            
        ////                    }
        ////                }
        ////            object1.send("SomeDataToSend");
        ////        }
        ////    ///////////////////////////////////////////////////////////////////////////////////////////////
        //    if(from.value==null)
        //    {
        //    countryList= document.getElementById('ctl00_ContentPlaceHolder1_country');
        //   getList(countryList);
        //    }else if(from.name =='country')
        //    {
        //     ProvinceyList= document.getElementById('ctl00_ContentPlaceHolder1_Province');
        //    getList(ProvinceyList);
        //    }else if(from.name =='Province')
        //    {
        //    ProvinceyList= document.getElementById('ctl00_ContentPlaceHolder1_district');
        //    getList(ProvinceyList);
        //    }
        //    
        ////    ///////////////////////////////////////////////////////////////////////////////////////////////  
        //    document.getElementById('ctl00_ContentPlaceHolder1_HiddenField_country').value= document.getElementById('ctl00_ContentPlaceHolder1_country').value;
        //    document.getElementById('ctl00_ContentPlaceHolder1_HiddenField_province').value= document.getElementById('ctl00_ContentPlaceHolder1_Province').value;
        //    document.getElementById('ctl00_ContentPlaceHolder1_HiddenField_district').value= document.getElementById('ctl00_ContentPlaceHolder1_district').value;
        //    document.getElementById('ctl00_ContentPlaceHolder1_HiddenField_tehsil').value= document.getElementById('ctl00_ContentPlaceHolder1_tehsil').value;     
        //}
        function setit(a) {
            document.getElementById('ctl00_ContentPlaceHolder1_HiddenField_tehsil').value = document.getElementById('ctl00_ContentPlaceHolder1_tehsil').value;
        }
    </script>
    <cc1:AutoCompleteExtender ID="AutoComplete_PFName" runat="server" CompletionInterval="10"
        CompletionSetCount="12" EnableCaching="true" MinimumPrefixLength="3" ServiceMethod="GetCompletionList"
        ServicePath="../AutoComplete.asmx" TargetControlID="textboxpfname">
    </cc1:AutoCompleteExtender>
    <cc1:AutoCompleteExtender ID="autoComplete_RFName" runat="server" CompletionInterval="10"
        CompletionSetCount="12" EnableCaching="true" MinimumPrefixLength="3" ServiceMethod="GetCompletionList"
        ServicePath="../AutoComplete.asmx" TargetControlID="textboxrfname">
    </cc1:AutoCompleteExtender>
    <asp:SqlDataSource ID="SqlDataSourcePatientType" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="System.Data.SqlClient" SelectCommand="SELECT DISTINCT Patient_type_Cat FROM Patient_type WHERE (Active = 1) ORDER BY Patient_type_Cat DESC">
    </asp:SqlDataSource>
    <%--<asp:SqlDataSource ID="SQL_Patient_Type_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        ProviderName="System.Data.SqlClient" SelectCommand="SELECT     *&#13;&#10;FROM         Patient_Type AS pt INNER JOIN&#13;&#10;                      Patient_Type_HospitalWise AS pth ON pt.ID = pth.Patient_Type_Id&#13;&#10;WHERE   (pth.Hospital_Id = @Hospital_Id) and pt.Active = 'True' --AND (Patient_type_Cat = @Patient_type_Cat)">
        <SelectParameters>
            <asp:ControlParameter ControlID="RadioButtonList_Patient_Type" Name="Patient_type_Cat"
                PropertyName="SelectedValue" />
            <asp:SessionParameter Name="Hospital_Id" SessionField="HospitalID" />
        </SelectParameters>
    </asp:SqlDataSource>--%>
    <asp:SqlDataSource ID="SQL_Patient_Type_Sub" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>" 
        SelectCommand="SELECT     *&#13;&#10;FROM         Patient_Type AS pt INNER JOIN&#13;&#10;  Patient_Type_HospitalWise AS pth ON pt.ID = pth.Patient_Type_Id&#13;&#10; WHERE   (pth.Hospital_Id = @Hospital_Id) AND ISNULL(pt.Active,0)=1 ">
        <SelectParameters>
            <asp:SessionParameter Name="Hospital_Id" SessionField="HospitalID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQL_Insert_Dependents" runat="server" ConnectionString="<%$ ConnectionStrings:PatientBillingConnectionString %>"
        InsertCommand="INSERT_Panel_EMP_Patients" InsertCommandType="StoredProcedure"
        ProviderName="<%$ ConnectionStrings:PatientBillingConnectionString.ProviderName %>"
        SelectCommand="SELECT     Relation_ID, Relation&#13;&#10;FROM       Patient_Relation">
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
    <asp:HiddenField ID="hfPatient_RegNo" runat="server" />
    <asp:SqlDataSource ID="SQL_Patient_Info" runat="server" ConnectionString="<%$ ConnectionStrings:PatientBillingConnectionString %>"
        SelectCommand="SELECT     Patient.Prefix, Patient.PFName, Patient.PMName, Patient.PLName, Panel_EMP_Patients.Reg_No&#13;&#10;FROM         Panel_EMP_Patients INNER JOIN&#13;&#10;                      Patient ON Panel_EMP_Patients.Reg_No = Patient.RegNo&#13;&#10;WHERE     (Panel_EMP_Patients.Reg_No = Panel_EMP_Patients.Emp_Reg_No)">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQL_Patient_Dependent" runat="server" ConnectionString="<%$ ConnectionStrings:PatientBillingConnectionString %>"
        SelectCommand="SELECT     Patient.Prefix, Patient.PFName, Patient.PMName, Patient.PLName, Patient_Relation.Relation, Panel_EMP_Patients.Reg_No, Patient.Age, Parties.Party_Name, &#13;&#10;                      Party_Designations.Party_Desg_Name&#13;&#10;FROM         Patient_Relation RIGHT OUTER JOIN&#13;&#10;                      Panel_EMP_Patients INNER JOIN&#13;&#10;                      Patient ON Panel_EMP_Patients.Reg_No = Patient.RegNo INNER JOIN&#13;&#10;                      Parties ON Panel_EMP_Patients.Billing_Party_Id = Parties.Party_Id INNER JOIN&#13;&#10;                      Party_Designations ON Panel_EMP_Patients.Category_Id = Party_Designations.Party_Desg_ID ON &#13;&#10;                      Patient_Relation.Relation_ID = Panel_EMP_Patients.Emp_PT_Relation_Id&#13;&#10;WHERE     (Panel_EMP_Patients.Emp_Reg_No = @Emp_Reg_No) and  Panel_EMP_Patients.Emp_Reg_No <> Panel_EMP_Patients.Reg_No&#13;&#10;">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlEmp_Patient" Name="Emp_Reg_No" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <div id="wait" style="position: absolute; left: 231px; top: 232px;">
        <img alt="" src="../images/loading.gif" width="16" height="1" style="display: none;" />
    </div>
    <h1 class="h1" style="margin-top: 0;">
        <span>Patient Information</span></h1>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="50%" valign="top">
                <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                    <tr>
                        <td align="right" width="15%">
                            Title :
                        </td>
                        <td width="35%">
                            <asp:RadioButtonList ID="RBLprefix" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal"
                                TabIndex="6">
                                <asp:ListItem Selected="True">Mr.</asp:ListItem>
                                <asp:ListItem>Miss</asp:ListItem>
                                <asp:ListItem>Mrs.</asp:ListItem>
                                <asp:ListItem>B</asp:ListItem>
                                <asp:ListItem>Mas</asp:ListItem>
                                
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            First Name :
                        </td>
                        <td>
                            <asp:TextBox AccessKey="n" ID="textboxpfname" Style="background-color: #f9dde2;"
                                runat="server" TabIndex="7" SkinID="captxt" MaxLength="20">
                                </asp:TextBox>
                               <%-- <span class="marks">*</span>--%>
                           <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="textboxpfname"
                                ErrorMessage="*" ValidationGroup="s"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="textboxpfname"
                                ErrorMessage="Enter Valid First Name" ValidationExpression="[A-Za-z]*" ValidationGroup="s"></asp:RegularExpressionValidator>
--%>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Last Name :
                        </td>
                        <td>
                            <asp:TextBox ID="textboxplname" 
                                runat="server" TabIndex="14" SkinID="captxt" MaxLength="20">
                                                </asp:TextBox>
                                
                                 <%--SkinID="captxt"--%>
                               <%-- </asp:TextBox>--%>
                                <%--<span
                                    class="marks">
                                    </span>--%>
                                   <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="textboxplname"
                                ErrorMessage="Enter Valid Last Name" ValidationExpression="[A-Za-z]*" ValidationGroup="s">
                                </asp:RegularExpressionValidator>--%>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            &nbsp;</td>
                        <td>
                            &nbsp;
                            </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="bxmain" style="width: 99%; margin-bottom: 4px;">
                                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form">
                                    <tr>
                                        <td width="15%" align="right">
                                          
                                        </td>
                                        <td width="35%">
                                <asp:RadioButtonList ID="RBLrelation"  runat="server" RepeatLayout="Flow"
                                    RepeatDirection="Horizontal">
                                    <asp:ListItem Selected="True">S/O</asp:ListItem>
                                    <asp:ListItem>D/O</asp:ListItem>
                                    
                                    <asp:ListItem>W/O</asp:ListItem>
                                    
                                </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Father&nbsp; First Name :
                                        </td>
                                        <td>
                                            <asp:TextBox ID="textboxrfname" Style="background-color: #f9dde2;" MaxLength="20"
                                                runat="server" TabIndex="8" SkinID="captxt"></asp:TextBox>
                                           <%-- <span class="marks">*
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="textboxrfname"
                                                    ErrorMessage="*" ValidationGroup="s"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="textboxrfname"
                                                    ErrorMessage="Enter Valid Relation First Name" ValidationExpression="[A-Za-z]*"
                                                    ValidationGroup="s"></asp:RegularExpressionValidator>
                                            </span>--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                           Last Name : &nbsp;</td>
                                        <td>
                                            <asp:TextBox ID="textboxrlname" runat="server" MaxLength="20" class="input_txt"
                                                TabIndex="19" SkinID="captxt"></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="textboxrlname"
                                                ErrorMessage="Enter Valid Relation Last Name" ValidationExpression="[A-Za-z]*"
                                                ValidationGroup="s55"></asp:RegularExpressionValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                           Email : &nbsp;</td>
                                        <td>
                                            <asp:TextBox ID="txtEmailAddress" runat="server" MaxLength="50" class="input_txt"
                                                TabIndex="14" TextMode="Email" ValidationGroup="s"></asp:TextBox>
                                        <%--    <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" 
                                ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txtEmailAddress" 
                                ErrorMessage="Invalid Email Format"></asp:RegularExpressionValidator>--%>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmailAddress"
    ForeColor="Red" ValidationExpression="^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$"
    Display = "Dynamic" ErrorMessage = "Invalid email address"/>
<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmailAddress"
    ForeColor="Red" Display = "Dynamic"  />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="50%" valign="top">
                <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                    <tr>
                        <td align="right" class="style1">
                            DOB :
                        </td>
                        <div style=" display:none; position: absolute; margin-left: 350px; margin-top: 0px;">
                                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images_hacims/picplace.jpg"
                                    Height="112px" Width="94px" Style="border: none;" />
                                    <br />
                                            <asp:FileUpload ID="FileUpload_image" runat="server" TabIndex="-1" />
                            
                                <br />
                            
                            <asp:Button ID="Button_attach_pic" runat="server" CausesValidation="False" CssClass="btn1"
                                Text="Attach" TabIndex="-1" />
                                    <br />



                            </div>
                        <td width="35%">
                            <igtxt:WebDateTimeEdit ID="WebDateTimeEdit_DOB" runat="server" TabIndex="14" Width="85px"
                                Culture="English (United Kingdom)" Style="background-color: #f9dde2;">
                            </igtxt:WebDateTimeEdit>
                            <span style="font-size: 10pt; color: #d92542">*</span>
                            <asp:TextBox AccessKey="a" ID="textboxage" runat="server" AutoCompleteType="disabled"
                                TabIndex="9" Width="28px" MaxLength="2"></asp:TextBox>&nbsp;<asp:DropDownList ID="DropDownListBIndicator"
                                    runat="server" Width="70px" AccessKey="y" TabIndex="16">
                                    <asp:ListItem Selected="True">Years</asp:ListItem>
                                    <asp:ListItem>Months</asp:ListItem>
                                    <asp:ListItem>Days</asp:ListItem>
                                    <asp:ListItem>Hours</asp:ListItem>
                                </asp:DropDownList>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ControlToValidate="textboxage"
                                ErrorMessage="Enter Valid Age" ValidationExpression="[0-9]*"></asp:RegularExpressionValidator>
                            <%--<div style="position: absolute; margin-left: 250px; margin-top: 0px;">
                                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images_hacims/picplace.jpg"
                                    Height="112px" Width="94px" Style="border: none;" />
                                    <br />
                                            <asp:FileUpload ID="FileUpload_image" runat="server" TabIndex="-1" />
                            
                                <br />
                            
                            <asp:Button ID="Button_attach_pic" runat="server" CausesValidation="False" CssClass="btn1"
                                Text="Attach" TabIndex="-1" />
                                    <br />



                            </div>--%>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="style1">
                            Patient Gender :
                        </td>
                        <td width="35%">
                            <asp:DropDownList ID="sex" runat="server" DataSourceID="SexSource" DataTextField="Gender"
                                DataValueField="Gender_ID" Width="100px" AccessKey="g" TabIndex="17">
                                <asp:ListItem Selected="True" Value="M">Male</asp:ListItem>
                                <asp:ListItem Value="F">Female</asp:ListItem>
                                
                            </asp:DropDownList>
                            <asp:HiddenField ID="HiddenField_DOB" runat="server" />
                            <asp:Panel ID="Panel1" runat="server" Visible="false">
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="style1">
                            <asp:Label ID="lblCNIC" runat="server"></asp:Label>
                        </td>
                        <td width="35%">
                            <asp:UpdatePanel ID="UpdatePanel16" runat="server">
                                <ContentTemplate>
                                    <asp:TextBox ID="textboxnic1" TabIndex="10" runat="server" AutoPostBack="True" MaxLength="15"
                                        OnTextChanged="textboxnic1_TextChanged"></asp:TextBox>
                                    <asp:Label ID="Label_CNIC" runat="server" CssClass="showup" ForeColor="Red" Visible="False"></asp:Label>
                                    <asp:Label ID="Label3" runat="server" CssClass="showup" ForeColor="Red" Text="Enter Valid CNIC"
                                        Visible="False"></asp:Label>
                                    <asp:LinkButton ID="LinkButton_MRNo" runat="server" OnClick="LinkButton_MRNo_Click"></asp:LinkButton>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="style1">
                            Contact # :
                        </td>
                        <td width="35%">
                            <asp:TextBox ID="textboxmcode" runat="server" TabIndex="11" MaxLength="11" 
                                Style="background-color: #f9dde2;"></asp:TextBox>
                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator_textboxmcode" runat="server" ControlToValidate="textboxmcode"
                            
                                                          ValidationGroup="s"  ErrorMessage="Enter Valid Contact No."></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator_textboxmcode" 
                                runat="server" ControlToValidate="textboxmcode"
                                              ValidationGroup="s"      
                                 ValidationExpression="\d{4}-\d{7}"
                                                    ></asp:RegularExpressionValidator>--%>

                            <span style="font-size: 10pt; color: #d92542;">
                                <asp:Label ID="Label_Mobile" runat="server" ForeColor="Red" Text="Enter Mobile #"
                                    Visible="False"></asp:Label>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="style1">
                            City :</td>
                       <td>
                                <asp:DropDownList ID="ddlCity" runat="server"  Width="202px" OnSelectedIndexChanged="ddlCity_SelectedIndexChanged"  AutoPostBack="true"  ></asp:DropDownList>
                            </td>
                    </tr>
                    <tr>
                        <td align="right" class="style1">
                            Town :</td>
                        <td width="35%">
                            <asp:DropDownList ID="ddlTown" runat="server" Width="202px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="style1">
                            &nbsp;</td>
                        <td>
                            <asp:TextBox ID="textboxpmname" runat="server" TabIndex="8" MaxLength="12" class="input_txt"
                                SkinID="captxt" Visible="False"></asp:TextBox>
    <cc1:AutoCompleteExtender ID="AutoComplete_PMName" runat="server" CompletionInterval="10"
        CompletionSetCount="12" EnableCaching="true" MinimumPrefixLength="3" ServiceMethod="GetCompletionList"
        ServicePath="../AutoComplete.asmx" TargetControlID="textboxpmname">
    </cc1:AutoCompleteExtender>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="textboxpmname"
                                ErrorMessage="Enter Valid Middle Name" ValidationExpression="[A-Z a-z]*"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="style1">
                            &nbsp;</td>
                        <td width="35%">
                            &nbsp;&nbsp&nbsp;
                                            <asp:TextBox ID="textboxrmname" runat="server" TabIndex="12" SkinID="captxt" 
                                                MaxLength="12" Visible="False"></asp:TextBox>
    <cc1:AutoCompleteExtender ID="AutoComplete_RMName" runat="server" CompletionInterval="10"
        CompletionSetCount="12" EnableCaching="true" MinimumPrefixLength="3" ServiceMethod="GetCompletionList"
        ServicePath="../AutoComplete.asmx" TargetControlID="textboxrmname">
    </cc1:AutoCompleteExtender>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="textboxrmname"
                                                ErrorMessage="Enter Valid Relation Middle Name" ValidationExpression="[A-Z a-z]*"></asp:RegularExpressionValidator>
                            </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:Panel ID="pnl_cnic" runat="server" Width="100%" Style="display: none;">
                                <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                                    <tr>
                                        <td width="29%" align="right">
                                            Guardian CNIC :
                                        </td>
                                        <td width="71%">
                                            <asp:TextBox ID="textboxnic1b" TabIndex="19" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Guardian Contact # :
                                        </td>
                                        <td> 
                                            <asp:TextBox ID="textboxmcodeb" TabIndex="20" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <table width="100%">
                    <tr>
                        <td style="width:190px;text-align:right;">
                            Present Address  :
                        </td>
                        <td>
                            <asp:TextBox ID="textboxHouseNo" TabIndex="21" Width="900px" runat="server" TextMode="SingleLine"
                            MaxLength="250"  SkinID="captxt"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT Pt_Cast FROM Patient_Cast"></asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldCast" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Employee" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
        SelectCommand="Select_Consultant_By_SubDept" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="Dept_type" PropertyName="SelectedValue" />
            
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
                <asp:SqlDataSource ID="SQL_SMP_ID_Update" runat="server"></asp:SqlDataSource>
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
            <asp:Parameter Direction="InputOutput" Name="Main_ID_Out" Type="Decimal" />
            <asp:Parameter Name="Con_S_ID" Type="Int32" />
            <asp:Parameter Name="Con_S_Amount" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Amount" runat="server" />
    <asp:HiddenField ID="HiddenField_S_ID" runat="server" />
    <asp:HiddenField ID="hf_Party" runat="server" />
    <asp:DropDownList ID="DropDownListCast" runat="server" DataSourceID="SqlDataSource2"
        DataTextField="Pt_Cast" DataValueField="Pt_Cast" Width="124px" TabIndex="15"
        Visible="False">
    </asp:DropDownList>
    <asp:TextBox ID="TextBoxCast" runat="server" Width="100px" Visible="False"></asp:TextBox>
    <ul id="CollapsiblePanel2">
        <li>
            <h1 class="h1">
                <span>Address Information</span></h1>
        </li>
        <li>
            <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                <tr>
                    <td align="right" width="15%">
                        Religion :
                    </td>
                    <td width="35%">
                        <asp:DropDownList ID="DropDownList_Religion" runat="server" DataSourceID="SqlDataSource_religion"
                            DataTextField="Religion_name" DataValueField="Religion_ID" AppendDataBoundItems="true"
                            AccessKey="g" TabIndex="14">
                            <asp:ListItem Text="" Value="0"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:UpdatePanel ID="UpdatePanel_12" runat="server">
                            <ContentTemplate>
                                <asp:CheckBox ID="CheckBox_Same_as_Above" runat="server" Text="Next Of Kin" Visible="false"
                                    OnCheckedChanged="CheckBox_Same_as_Above_CheckedChanged"></asp:CheckBox>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                    <td align="right" width="15%">
                        Country :
                    </td>
                    <td width="35%">
                        <asp:UpdatePanel ID="UpdatePanel12" runat="server">
                            <ContentTemplate>
                                <asp:DropDownList ID="country" TabIndex="24" runat="server" DataValueField="CountryCode"
                                    DataTextField="CountryName" DataSourceID="SqlDataSource3" AutoPostBack="True">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource3" runat="server" SelectCommand="select 0 as [CountryCode],'' as [CountryName]union SELECT [CountryCode], [CountryName] FROM [Country]"
                                    ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"></asp:SqlDataSource>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:TextBox ID="textboxprovince2" runat="server" Width="99px" Visible="False"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                <td align="right">
                    &nbsp;</td>
                <td>
                            <asp:Label ID="lblTooLarge" runat="server" Text="Label" Visible="False"></asp:Label>
                            
                </td>
                </tr>
                <tr>
                    <td rowspan="3" align="right">
                        &nbsp;</td>
                    <td rowspan="3" valign="top">
                        
                    </td>
                    <td align="right">
                        Province :
                    </td>
                    <td>
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <asp:DropDownList ID="Province" runat="server" DataValueField="ProvinceCode" TabIndex="25"
                                    DataTextField="ProvinceName" DataSourceID="SqlDataSource4" AutoPostBack="True">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource4" runat="server" SelectCommand="select 0  as ProvinceCode,'' as ProvinceName union SELECT ProvinceCode, ProvinceName FROM Province 
WHERE(CountryCode =@CountryCode)"
                                    ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="country" Name="CountryCode" PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        District :
                    </td>
                    <td>
                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                            <ContentTemplate>
                                <asp:DropDownList ID="district" TabIndex="26" runat="server" DataValueField="DistrictCode"
                                    DataTextField="DistrictName" DataSourceID="SqlDataSource5" AutoPostBack="True">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource5" runat="server" SelectCommand="
SELECT 0 AS  DistrictCode,''AS DistrictName UNION SELECT DistrictCode,DistrictName FROM DISTRICT 
WHERE (ProvinceCode = @ProvinceCode)"
                                    ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="Province" Name="ProvinceCode" PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:TextBox ID="textboxTehsil2" runat="server" Width="92px" Visible="False"></asp:TextBox>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        City :
                    </td>
                    <td>
                        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                            <ContentTemplate>
                                <asp:DropDownList ID="tehsil" TabIndex="27" runat="server" DataValueField="TehsilCode"
                                    DataTextField="TehsilName" DataSourceID="SqlDataSource6">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource6" runat="server" SelectCommand="SELECT 0 AS TehsilCode,'' as TehsilName union SELECT TehsilCode,TehsilName FROM TEHSIL 
WHERE (districtCode =@districtCode)"
                                    ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="district" Name="districtCode" PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:TextBox ID="textboxDistrict2" runat="server" Width="98px" Visible="False"></asp:TextBox>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Permanent Address :
                    </td>
                    <td rowspan="2" valign="top">
                        <asp:TextBox ID="textboxstreetaddress" TabIndex="-1" runat="server" Height="50px"
                            TextMode="MultiLine" MaxLength="250"></asp:TextBox>
                    </td>
                    <td align="right">
                        Email :
                    </td>
                    <td>
                        <asp:TextBox ID="TextBox_Email_Address" runat="server"></asp:TextBox>
                        <asp:TextBox ID="textboxcolony" TabIndex="26" runat="server" Visible="False"></asp:TextBox>
                        <asp:ImageButton ID="IBtnLogOut" runat="server" Visible="false" ImageUrl="images/image_logout_up.gif">
                        </asp:ImageButton>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        &nbsp;
                    </td>
                    <td align="right">
                        <asp:Label ID="lblPassport" runat="server"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="TextBox_passport_No" TabIndex="18" runat="server"></asp:TextBox>
                        <asp:TextBox ID="textboxzipcode" TabIndex="28" runat="server" MaxLength="5" Visible="False"></asp:TextBox>
                        <asp:UpdatePanel ID="UpdatePanel5" runat="server" Visible="False">
                            <ContentTemplate>
                                <asp:TextBox ID="textboxcountrycode" runat="server" Width="30px" Enabled="False">0092</asp:TextBox>
                                -
                                <asp:TextBox ID="textboxphonecode" runat="server" Width="30px" Enabled="False">51</asp:TextBox>
                                -
                                <asp:TextBox ID="textboxphoneno" TabIndex="29" runat="server" Width="114px" Style="background-color: #f9dde2;"
                                    MaxLength="7"></asp:TextBox>
                                <span style="font-size: 10pt; color: #d92542">* </span>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                            Nationality :
                        </td>
                    <td valign="top">
                        &nbsp;
                            <asp:DropDownList ID="DropDownList_Nationality" runat="server" DataSourceID="SqlDataSource_Nationality"
                                DataTextField="Nationality_Name" DataValueField="Nationality_ID"
                                TabIndex="-1" AppendDataBoundItems="true">
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                            </asp:DropDownList>
                    </td>
                    <td align="right">
                        &nbsp;
                    </td>
                    <td>
                        <asp:CheckBox ID="checkbox_copyadd" runat="server" Text="Same for Next of Kin" />
                    </td>
                </tr>
            </table>
            <div style="display: none;">
                <igtxt:WebMaskEdit ID="textboxmcode1111" runat="server" InputMask="####-#######"
                    DataMode="RawText" Style="background-color: #f9dde2;">
                </igtxt:WebMaskEdit>
            </div>
        </li>
    </ul>
    <ul id="CollapsiblePanel1">
        <li>
            <h1 class="h1">
                <span>Next of Kin Information</span></h1>
        </li>
        <li>
            <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                <tr>
                    <td align="right" width="15%">
                        Gender :
                    </td>
                    <td width="35%">
                        <asp:RadioButtonList ID="RadioButtonList1_ot" runat="server" RepeatLayout="Flow"
                            RepeatDirection="Horizontal" TabIndex="37">
                            <asp:ListItem Selected="True">Male</asp:ListItem>
                            <asp:ListItem>Female</asp:ListItem>
                        </asp:RadioButtonList>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="RadioButtonList1_ot"
                            ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                    </td>
                    <td width="15%" align="right">
                        Address 1 :
                    </td>
                    <td width="35%" rowspan="2" valign="top">
                        <asp:UpdatePanel ID="UpdatePanel14" runat="server">
                            <ContentTemplate>
                                <asp:TextBox ID="textboxTown_ot" runat="server" Visible="False" MaxLength="250" TextMode="MultiLine"></asp:TextBox>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:UpdatePanel ID="UpdatePanel15" runat="server">
                            <ContentTemplate>
                                <asp:TextBox ID="TextBox_House_Ot" runat="server" Height="35px" TextMode="MultiLine"></asp:TextBox>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Title :
                    </td>
                    <td>
                        <asp:RadioButtonList ID="RBLprefix_ot" runat="server" RepeatDirection="Horizontal"
                            TabIndex="36" RepeatLayout="Flow">
                            <asp:ListItem Selected="True">Mr.</asp:ListItem>
                            <asp:ListItem>Miss</asp:ListItem>
                            <asp:ListItem>Mrs.</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                    <td align="right">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Relation &nbsp; &nbsp; with patient :
                    </td>
                    <td>
                        <asp:DropDownList ID="DropDownListRelationwithPatient_ot" runat="server" TabIndex="35"
                            AutoPostBack="True">
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
                        <asp:TextBox ID="TextBox_refrence_id_ot" runat="server" Visible="False" Width="59px"></asp:TextBox>
                    </td>
                    <td align="right">
                        Address 2 :
                    </td>
                    <td rowspan="2" valign="top">
                        <asp:UpdatePanel ID="UpdatePanel10" runat="server" Visible="False">
                            <ContentTemplate>
                                <asp:TextBox ID="textboxcountrycode_ot" runat="server" Width="30px" Enabled="False">0092</asp:TextBox>
                                -
                                <asp:TextBox ID="textboxphonecode_ot" TabIndex="53" runat="server" Width="30px" Enabled="False">51</asp:TextBox>
                                -
                                <asp:TextBox ID="textboxphoneno_ot" TabIndex="54" runat="server" Width="113px" MaxLength="7"></asp:TextBox>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:UpdatePanel ID="UpdatePanel13" runat="server">
                            <ContentTemplate>
                                <asp:TextBox ID="TextBox_Street_OT" runat="server" Height="45" TextMode="MultiLine"
                                    MaxLength="250"></asp:TextBox>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        First Name :
                    </td>
                    <td>
                        <asp:TextBox ID="textboxpfname_ot" runat="server" BackColor="White" MaxLength="12"
                            TabIndex="37" SkinID="captxt"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator10" runat="server"
                            ControlToValidate="textboxpfname_ot" ErrorMessage="Enter Valid Name" ValidationExpression="[A-Za-z]*"></asp:RegularExpressionValidator>
                        <span style="font-size: 10pt; color: #d92542"></span>
                    </td>
                    <td align="right">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Middle Name :
                    </td>
                    <td>
                        <asp:TextBox ID="textboxpmname_ot" runat="server" TabIndex="38" SkinID="captxt" MaxLength="12"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator11" runat="server"
                            ControlToValidate="textboxpmname_ot" ErrorMessage="Enter Valid Name" ValidationExpression="[A-Z a-z]*"></asp:RegularExpressionValidator>
                    </td>
                    <td align="right">
                        Country :
                    </td>
                    <td>
                        <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                            <ContentTemplate>
                                <asp:DropDownList ID="country_ot" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_Country_ot"
                                    DataTextField="CountryName" DataValueField="CountryCode" TabIndex="47">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource_Country_ot" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                                    
                                    SelectCommand="select 0 as [CountryCode],'' as [CountryName]union SELECT [CountryCode], [CountryName] FROM [Country]"></asp:SqlDataSource>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Last Name :
                    </td>
                    <td>
                        <asp:TextBox ID="textboxplname_ot" runat="server" Visible="true" MaxLength="12" TabIndex="39"
                            SkinID="captxt"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator12" runat="server"
                            ControlToValidate="textboxplname_ot" ErrorMessage="Enter Valid Name" ValidationExpression="[A-Za-z]*"></asp:RegularExpressionValidator>
                    </td>
                    <td align="right">
                        Province :
                    </td>
                    <td>
                        <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                            <ContentTemplate>
                                <asp:DropDownList ID="Province_ot" runat="server" AutoPostBack="True" CssClass="text_dropdown"
                                    DataSourceID="SqlDataSource_Province_ot" DataTextField="ProvinceName" DataValueField="ProvinceCode"
                                    TabIndex="48">
                                </asp:DropDownList>
                                <asp:TextBox ID="textboxprovince2_ot" runat="server" Visible="False" Width="99px"></asp:TextBox>
                                <asp:SqlDataSource ID="SqlDataSource_Province_ot" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                    SelectCommand="select 0  as ProvinceCode,'' as ProvinceName union SELECT ProvinceCode, ProvinceName FROM Province 
WHERE(CountryCode =@CountryCode)">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="country" Name="CountryCode" 
                                            PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        CNIC # :
                    </td>
                    <td>
                        <asp:TextBox ID="textboxnic1_ot" runat="server"></asp:TextBox>
                    </td>
                    <td align="right">
                        District :
                    </td>
                    <td>
                        <asp:UpdatePanel ID="UpdatePanel8" runat="server">
                            <ContentTemplate>
                                <asp:DropDownList ID="district_ot" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_District_ot"
                                    DataTextField="DistrictName" DataValueField="DistrictCode" TabIndex="49">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource_District_ot" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                                    SelectCommand="SELECT 0 AS  DistrictCode,''AS DistrictName UNION SELECT DistrictCode,DistrictName FROM DISTRICT 
WHERE (ProvinceCode = @ProvinceCode)">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="Province_ot" Name="ProvinceCode" PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:TextBox ID="district_ot_txt" Style="display: none;" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Contact # :
                    </td>
                    <td>
                        <asp:TextBox ID="textboxmcode_ot" runat="server"></asp:TextBox>
                    </td>
                    <td align="right">
                        City :
                    </td>
                    <td>
                        <asp:UpdatePanel ID="UpdatePanel9" runat="server">
                            <ContentTemplate>
                                <asp:DropDownList ID="tehsil_ot" runat="server" DataSourceID="SqlDataSource_Tehsil_ot"
                                    DataTextField="TehsilName" DataValueField="TehsilCode" TabIndex="50">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource_Tehsil_ot" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                                    SelectCommand="SELECT 0 AS TehsilCode,'' as TehsilName union SELECT TehsilCode,TehsilName FROM TEHSIL 
WHERE (districtCode =@districtCode)
">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="district" Name="districtCode" 
                                            PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:TextBox ID="tehsil_ot_txt" Style="display: none;" runat="server"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <div style="display: none;">
                <igtxt:WebMaskEdit ID="textboxnic1_ot1111" runat="server" InputMask="#####-#######-#">
                </igtxt:WebMaskEdit>
            </div>
            <div style="display: none;">
                <igtxt:WebMaskEdit ID="textboxmcode_ot11111" runat="server" InputMask="####-#######">
                </igtxt:WebMaskEdit>
            </div>
            <asp:HiddenField ID="HiddenField_country_ot" runat="server" Value="12" />
            <asp:TextBox ID="textboxrlname_ot" runat="server" Visible="False" Width="148px" TabIndex="43"></asp:TextBox>
            <asp:TextBox ID="textboxrmname_ot" runat="server" TabIndex="42" Width="148px" Visible="False"></asp:TextBox>
            <asp:HiddenField ID="HiddenField_province_ot" runat="server" Value="12" />
            <asp:TextBox ID="textboxrfname_ot" runat="server" TabIndex="41" Width="148px" Visible="False"></asp:TextBox>
            <asp:RadioButtonList ID="RBLrelation_ot" runat="server" RepeatDirection="Horizontal"
                RepeatLayout="Flow" TabIndex="40" Visible="False">
                <asp:ListItem Selected="True">S/O</asp:ListItem>
                <asp:ListItem>D/O</asp:ListItem>
                <asp:ListItem>W/O</asp:ListItem>
            </asp:RadioButtonList>
            <asp:HiddenField ID="HiddenField_district_ot" runat="server" Value="12" />
            <asp:HiddenField ID="HiddenField_tehsil_ot" runat="server" Value="12" />
            <asp:HiddenField ID="HiddenField_Emp_Id_ot" runat="server" />
            <asp:HiddenField ID="HiddenField_Dept_Id_ot" runat="server" />
            <asp:SqlDataSource ID="SqlDataSource_info_ot" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                InsertCommand="Insert_OT_PatientRelative_Undertaking" InsertCommandType="StoredProcedure"
                ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>">
                <InsertParameters>
                    <asp:ControlParameter ControlID="RBLprefix_ot" Name="Prefix" PropertyName="SelectedValue"
                        Type="String" />
                    <asp:ControlParameter ControlID="textboxpfname_ot" Name="RelativeFName" PropertyName="Text"
                        Type="String" />
                    <asp:ControlParameter ControlID="textboxpmname_ot" Name="RelativeMName" PropertyName="Text"
                        Type="String" />
                    <asp:ControlParameter ControlID="textboxplname_ot" Name="RelativeLName" PropertyName="Text"
                        Type="String" />
                    <asp:ControlParameter ControlID="RBLrelation_ot" Name="RelativeRType" PropertyName="SelectedValue"
                        Type="String" />
                    <asp:ControlParameter ControlID="textboxrfname_ot" Name="RelativeRFName" PropertyName="Text"
                        Type="String" />
                    <asp:ControlParameter ControlID="textboxrmname_ot" Name="RelativeRMName" PropertyName="Text"
                        Type="String" />
                    <asp:ControlParameter ControlID="textboxrlname_ot" Name="RelativeRLName" PropertyName="Text"
                        Type="String" />
                    <asp:ControlParameter ControlID="HiddenFieldNIC_ot" Name="NIC" PropertyName="Value"
                        Type="String" />
                    <asp:ControlParameter ControlID="country_ot" Name="Country" PropertyName="SelectedValue"
                        Type="Int32" />
                    <asp:ControlParameter ControlID="Province_ot" Name="Province" PropertyName="SelectedValue"
                        Type="Int32" />
                    <asp:Parameter Name="District" Type="Int32" />
                    <asp:Parameter Name="Tehsil" Type="Int32" />
                    <asp:ControlParameter ControlID="HiddenField_phone_ot" Name="PhoneNo" PropertyName="Value"
                        Type="String" />
                    <asp:ControlParameter ControlID="RadioButtonList1_ot" Name="Sex" PropertyName="SelectedValue"
                        Type="String" />
                    <asp:ControlParameter ControlID="DropDownListRelationwithPatient_ot" Name="RelationWithPatient"
                        PropertyName="SelectedValue" Type="String" />
                    <asp:ControlParameter ControlID="HiddenField_RegistrationNo" Name="PatientRegNo"
                        PropertyName="Value" Type="String" />
                    <asp:ControlParameter ControlID="HiddenField_mobile_Phone" Name="Mobile_Phone" PropertyName="Value" />
                    <asp:ControlParameter ControlID="textboxTown_ot" Name="Town" PropertyName="Text"
                        Type="String" />
                    <asp:ControlParameter ControlID="TextBox_House_Ot" Name="House_No" PropertyName="Text"
                        Type="String" />
                    <asp:ControlParameter ControlID="TextBox_Street_OT" Name="Street" PropertyName="Text"
                        Type="String" />
                    <asp:ControlParameter ControlID="textboxHouseNo" Name="Address" 
                        PropertyName="Text" Type="String" />
                </InsertParameters>
            </asp:SqlDataSource>
                <asp:SqlDataSource ID="dsPatient_Duplicate_Print" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>" UpdateCommand="UPDATE    Payment
SET              SMP_ID = @SMP_ID
WHERE     (PayID = @PayID)">
                    <UpdateParameters>
                        <asp:Parameter Name="SMP_ID" DefaultValue="0" />
                        <asp:SessionParameter Name="PayID" SessionField="PayID" DefaultValue="" />
                    </UpdateParameters>
                </asp:SqlDataSource>

            <asp:HiddenField ID="HiddenFieldNIC_ot" runat="server" />
            <asp:HiddenField ID="HiddenField_RegistrationNo" runat="server" />
            <asp:HiddenField ID="HiddenField_mobile_Phone" runat="server" />
            <asp:HiddenField ID="HiddenField_phone_ot" runat="server" />
            <asp:HiddenField ID="HiddenField_cnic" runat="server" />
        </li>
    </ul>
    <br />
    <h1 class="h1 mtop">
        <span>General Information</span></h1>
    
    
    <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
        
        <tr>
            <td width="50%" valign="top">
                <div class="bxmain" style="width: 98%;">
                   
                        
                    <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                        <tr>
                            <td align="right" width="15%">
                                Speciality/Dept :
                            </td>
                            <td>
                                <asp:DropDownList AccessKey="d" ID="DDLDepartment" runat="server" TabIndex="-1" AutoPostBack="True"
                                    Visible="false" DataSourceID="SqlDataSourceDepartment" DataTextField="Dept_Name"
                                    DataValueField="Dept_ID" Width="140px">
                                    <asp:ListItem Value="6">Emergency</asp:ListItem>
                                </asp:DropDownList>
                                <asp:DropDownList ID="DropDownList1" TabIndex="12" runat="server" DataSourceID="SqlDataSource_SubDept"
                                    Width="200px" DataTextField="SubDept_Name" DataValueField="SubDept_Id" AutoPostBack="True">
                                </asp:DropDownList>
                                <asp:DropDownList ID="DropDownList_Employee_name" TabIndex="12" runat="server" DataSourceID="SqlDataSource_Employee"
                                    DataTextField="Employee Name" DataValueField="EmpID" AutoPostBack="True" 
                                    Width="140px">
                                </asp:DropDownList>
                                <asp:TextBox ID="TextBox_Room_No" runat="server" TabIndex="24" Width="30px"></asp:TextBox>
                                <%--<asp:RadioButtonList ID="RadioButtonList_Patient_Type" runat="server" DataValueField="Patient_type_Cat"
                                DataTextField="Patient_type_Cat" DataSourceID="SqlDataSourcePatientType" AutoPostBack="True"
                                RepeatLayout="Flow" RepeatDirection="Horizontal"  OnSelectedIndexChanged="RadioButtonList_Patient_Type_SelectedIndexChanged">
                            </asp:RadioButtonList>--%>
                                <asp:RadioButtonList ID="RadioButtonList_Patient_Type"  runat="server" DataValueField="Patient_type_Cat"
                                    DataTextField="Patient_type_Cat" AutoPostBack="True" RepeatLayout="Flow" RepeatDirection="Horizontal"
                                    OnSelectedIndexChanged="RadioButtonList_Patient_Type_SelectedIndexChanged" 
                                    Width="456px" TabIndex="25">
                                </asp:RadioButtonList>
                                <br />
                                <asp:Label ID="LbL_Mg" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 18px; width: 70px;">
                                &nbsp;
                            </td>
                            <td align="left" style="height: 18px">
                                <asp:RadioButtonList ID="rblPatientType_Sub" runat="server" AutoPostBack="True" DataSourceID="SQL_Patient_Type_Sub"
                                    DataTextField="Patient_type" DataValueField="Patient_Type_Id" 
                                    RepeatDirection="Horizontal" TabIndex="25"
                                    Style="font-size: 11px;" RepeatLayout="Flow" Height="20px" 
                                    RepeatColumns="4">
                                </asp:RadioButtonList>
                                 &nbsp;
                                
                                <asp:DropDownList ID="ddlRate" runat="server"  
                                    TabIndex = "25" 
                                    DataSourceID="SqlDataSource_Consul_Rate" DataTextField="S_Amount"  AutoPostBack="true"
                                    DataValueField="Id" Height="20px" Width="69px">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource_Consul_Rate" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>" SelectCommand="SELECT        Admin_OPD_Slip_Rates.Id, Admin_OPD_Slip_Rates.S_Amount, Admin_OPD_Slip_Rates.Patient_Type_id, MapServiceswithDoctor.DeptID
FROM            Admin_OPD_Slip_Rates INNER JOIN
                         MapServiceswithDoctor ON Admin_OPD_Slip_Rates.Id = MapServiceswithDoctor.S_ID
WHERE        (Admin_OPD_Slip_Rates.Patient_Type_id = @Patient_Type_Id) AND (MapServiceswithDoctor.DoctorID = @DoctorID) AND (MapServiceswithDoctor.DeptID = @DeptID)
ORDER BY Admin_OPD_Slip_Rates.S_Amount ">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="rblPatientType_Sub" Name="Patient_Type_Id" 
                                            PropertyName="SelectedValue" />
                                       
                                        <asp:ControlParameter ControlID="DropDownList_Employee_name" Name="DoctorID" PropertyName="SelectedValue" />
                                        <asp:ControlParameter ControlID="DropDownList1" Name="DeptID" PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <br />
                                <br />
                            </td>
                             <td class="heading">
                               Checkup Type :
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlCheckupType" TabIndex="17" runat="server" >
                                    <asp:ListItem  Value="Emergency" Text="Emergency"></asp:ListItem>
                                    <asp:ListItem Value="Routine" Text="Routine" Selected="True"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                          
                   
                </div>
                <asp:Panel ID="pnlPanelPatient" runat="server" Width="100%" Visible="false" >
                    <ul id="CollapsiblePanel3" style="width: 98%;">
                        <li>
                            <h1 class="h1">
                                <span>Enter Details</span></h1>
                        </li>
                        <li>
                            <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                                <tr runat="server" id="td_RegistrationType" visible="False">
                                    <td align="right" width="30%">
                                        Type :
                                    </td>
                                    <td>
                                        <asp:RadioButtonList ID="rblRegistrationType" RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            runat="server" AutoPostBack="True">
                                            <asp:ListItem Value="Self" Selected="True">Self</asp:ListItem>
                                            <asp:ListItem Value="Dependent">Dependent</asp:ListItem>
                                        </asp:RadioButtonList>
                                        <asp:DropDownList ID="ddlEmp_Patient" runat="server" TabIndex="35" Visible="False"
                                            AutoPostBack="True">
                                        </asp:DropDownList>
                                        <asp:DropDownList ID="ddlRelation" runat="server" TabIndex="35" Visible="False" DataSourceID="SQL_Insert_Dependents"
                                            DataTextField="Relation" DataValueField="Relation_ID" AutoPostBack="True">
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
                                <tr runat="Server" id="td_Insurer" >
                                    <td align="right">
                                        Insurer :
                                    </td>       
                                    <td>
                                        <asp:DropDownList ID="DropDownList_Parties" runat="server" DataValueField="Party_Id"
                                            DataTextField="Party_Name" DataSourceID="SqlDataSource_parties" AutoPostBack="True">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDataSource_parties" runat="server" ConnectionString="<%$ ConnectionStrings:PatientBilllingConnectionString %>"
                                            SelectCommand="SELECT     Parties.Party_Id, Parties.Party_Name
FROM         Parties INNER JOIN
                      Patient_Billing_Party ON Parties.Party_Id = Patient_Billing_Party.Billing_Party_Id
WHERE     (Patient_Billing_Party.Patient_Type_Id = @Party_Type_Id)">
 <SelectParameters>
                                                <asp:ControlParameter ControlID="rblPatientType_Sub" Name="Party_Type_Id" 
                                                    PropertyName="SelectedValue" />
                                            </SelectParameters>

                                        </asp:SqlDataSource>
                                        <%--SELECT     Parties.Party_Id, Parties.Party_Name&#13;&#10;FROM         Parties INNER JOIN&#13;&#10;                      Patient_Billing_Party ON Parties.Party_Id = Patient_Billing_Party.Billing_Party_Id&#13;&#10;WHERE Parties.Party_Id IN (SELECT pd.Party_ID&#13;&#10;                             FROM Party_Designations pd)  &#13;&#10;&#13;&#10;--SELECT Parties.Party_Id, Parties.Party_Name FROM Parties INNER JOIN Patient_Billing_Party ON Parties.Party_Id = --Patient_Billing_Party.Billing_Party_Id--%>
                                    </td>
                                </tr>
                                <tr runat="Server" id="td_Employee_Designation" >
                                    <td align="right">
                                        Employee Designation :
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlDesignation" runat="server" DataValueField="Party_Desg_ID"
                                            DataTextField="Party_Desg_Name" DataSourceID="dsDesignations">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="dsDesignations" runat="server" SelectCommand="Select_Party_Designation"
                                            ConnectionString="<%$ ConnectionStrings:PatientBilllingConnectionString %>" ProviderName="<%$ ConnectionStrings:PatientBillingConnectionString.ProviderName %>"
                                            SelectCommandType="StoredProcedure">
                                           <%-- <SelectParameters>
                                                <asp:ControlParameter ControlID="DropDownList_Parties" Name="Party_id" PropertyName="SelectedValue"
                                                    Type="Int32" />
                                            </SelectParameters>--%>
                                        </asp:SqlDataSource>
                                        <asp:SqlDataSource ID="dsEmployeeDependents" runat="server" SelectCommand="SELECT EmployeeDependents.Reg_No, EmployeeDependents.Party_Desg_Name, EmployeeDependents.Party_Name, EmployeeDependents.Prefix, EmployeeDependents.PFName, EmployeeDependents.PMName, EmployeeDependents.PLName, EmployeeDependents.Relation, EmployeeDependents.RFName, EmployeeDependents.RMName, EmployeeDependents.RLName, EmployeeDependents.Gender, EmployeeDependents.Emp_No, EmployeeDependents.RegistrationType, Patient.CNIC, Patient.MobilePhone FROM EmployeeDependents INNER JOIN Patient ON EmployeeDependents.Reg_No = Patient.RegNo WHERE (EmployeeDependents.Emp_No = @Emp_No) AND (EmployeeDependents.Party_Id = @Party_ID) AND (EmployeeDependents.Party_Desg_ID = @Party_Desg_ID) ORDER BY EmployeeDependents.RegistrationType DESC"
                                            ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>" ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="txtEmployeeNo" Name="Emp_No" PropertyName="Text" />
                                                <asp:ControlParameter ControlID="DropDownList_Parties" Name="Party_ID" PropertyName="SelectedValue" />
                                                <asp:ControlParameter ControlID="ddlDesignation" Name="Party_Desg_ID" PropertyName="SelectedValue" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                                   <tr ID="ReferenceId" runat="Server" visible="False">
                                                            <td align="right">
                                                               Reference # :
                                                            </td>
                                                               <td>
                                                 <asp:TextBox ID="txtReference" runat="server" ToolTip="Enter Reference Number"></asp:TextBox>
                                                               </td>
                                                               </tr>



                                <tr>
                                    <td align="right" style="display: none">
                                        Principal Employee # :
                                    </td>
                                    <td style="display: none">
                                        <asp:TextBox ID="txtEmployeeNo" runat="server" ToolTip="Enter Employee Number"></asp:TextBox>
                                        <asp:Button ID="btnSearchEmployee" runat="server" Text="Search" CausesValidation="False"
                                            ToolTip="Click to search Employee"></asp:Button>
                                        <asp:Button ID="Button_Clear" runat="server" Text="Clear" Visible="False" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                    </td>
                                    <td>
                                        <asp:Button ID="btnFingerPrint" runat="server" Text="Finger Print" OnClientClick="RunEXE('D:\\New Finger Print\\bin\\FingerprintReader.exe')"
                                            Visible="False"></asp:Button>
                                    </td>
                                </tr>
                            </table>
                            <asp:GridView ID="grdEmployeeDependents" runat="server" DataSourceID="dsEmployeeDependents"
                                AutoGenerateColumns="False" EmptyDataText="Please Register Employee First" Width="98%"
                                Visible="False">
                                <Columns>
                                    <asp:TemplateField HeaderText="MR. #" SortExpression="Reg_No">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRegNo" runat="server"></asp:Label>
                                            <asp:HiddenField ID="hfRegNo" runat="server" Value='<%# Eval("Reg_No") %>' />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Reg_No") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Patient">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPatientName" runat="server"></asp:Label>
                                            <asp:HiddenField ID="hfPrefix" runat="server" Value='<%# Eval("Prefix") %>' />
                                            <asp:HiddenField ID="hfPFName" runat="server" Value='<%# Eval("PFName") %>' />
                                            <asp:HiddenField ID="hfPMName" runat="server" Value='<%# Eval("PMName") %>' />
                                            <asp:HiddenField ID="hfPLName" runat="server" Value='<%# Eval("PLName") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Relation">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRelation" runat="server"></asp:Label>
                                            <asp:HiddenField ID="hfRelation" runat="server" Value='<%# Eval("Relation") %>' />
                                            <asp:HiddenField ID="hfRFName" runat="server" Value='<%# Eval("RFName") %>' />
                                            <asp:HiddenField ID="hfRMName" runat="server" Value='<%# Eval("RMName") %>' />
                                            <asp:HiddenField ID="hfRLName" runat="server" Value='<%# Eval("RLName") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Party_Desg_Name" HeaderText="Employee Designation" SortExpression="Party_Desg_Name" />
                                    <asp:BoundField DataField="Party_Name" HeaderText="Party" SortExpression="Party_Name" />
                                    <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
                                    <asp:BoundField DataField="Emp_No" HeaderText="Emp #" SortExpression="Emp_No" />
                                    <asp:TemplateField HeaderText="Registration Type" SortExpression="RegistrationType">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRegistrationType" runat="server" Text='<%# Bind("RegistrationType") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("RegistrationType") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblRelationWith" runat="server"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="CNIC" SortExpression="CNIC">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("CNIC") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label_CNIC" runat="server" Text='<%# Bind("CNIC") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="MobilePhone" SortExpression="MobilePhone">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("MobilePhone") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label_Cell" runat="server" Text='<%# Bind("MobilePhone") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </li>
                    </ul>
                </asp:Panel>
                <%--<asp:GridView ID="GridView_Doctor_Services" runat="server" AutoGenerateColumns="False"
                    ShowHeader="False" DataKeyNames="DS_ID" DataSourceID="SqlDataSource_Doctor_Services"
                    Width="98%">
                    <Columns>
                        <asp:BoundField DataField="S_Name" HeaderText="Service Name" SortExpression="S_Name" />
                        <asp:BoundField DataField="Services Charges" HeaderText="Amount" SortExpression="Services Charges" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:CheckBox ID="CheckBox1" runat="server" />
                                <asp:HiddenField ID="HiddenField_amount" runat="server" Value='<%# Eval("[Services Charges]", "{0}") %>' />
                                <asp:HiddenField ID="HiddenField_S_ID" runat="server" Value='<%# Eval("S_ID", "{0}") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>--%>
                <asp:RadioButtonList ID="RadioButtonList_Type" runat="server" RepeatLayout="Flow"
                    RepeatColumns="2" RepeatDirection="Horizontal" Visible="False">
                    <asp:ListItem Selected="True">Paid</asp:ListItem>
                    <asp:ListItem>Free</asp:ListItem>
                </asp:RadioButtonList>
                <asp:TextBox ID="txtPanelEmp" runat="server" Visible="False"></asp:TextBox>
                <asp:Button ID="cmdPanelEmp" runat="server" Text="Panel Emp" Visible="False" />
            </td>
            <td width="50%" valign="top">
                <div class="bxmain" style="width: 99%;">
                    <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                        <tr>
                            <td align="right">
                                <asp:Label ID="Label1" runat="server" Text="Complaint :"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="DropDownListDiagnosis" runat="server" DataSourceID="SqlDataSourceDiagnosis"
                                    DataTextField="Diagnosis" DataValueField="Diagnosis" TabIndex="-1" 
                                    Width="200px">
                                </asp:DropDownList>
                                &nbsp;<asp:Label ID="Label2" runat="server" Text="Other :"></asp:Label>
                                <asp:TextBox ID="TextBoxDiagnosis" runat="server" AccessKey="f" CssClass="input_txt"
                                    TabIndex="28" Width="150px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Comments :
                            </td>
                            <td align="left">
                                <asp:TextBox ID="TextBoxSpecialCase" runat="server" class="input_txt" TabIndex="27"
                                    Width="90%"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
                <asp:GridView ID="gvDependents" runat="server" AutoGenerateColumns="False" DataSourceID="SQL_Patient_Dependent"
                    Width="587px">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr. #">
                            <ItemTemplate>
                                <%#Container.DataItemIndex + 1%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Name" SortExpression="Prefix">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Prefix") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblPrefix" runat="server" Text='<%# Bind("Prefix", "{0}") %>' Visible="False"></asp:Label>
                                <asp:Label ID="lblName" runat="server" Text=""></asp:Label>
                                <asp:Label ID="lblPFName" runat="server" Text='<%# Bind("PFName", "{0}") %>' Visible="False"></asp:Label>
                                <asp:Label ID="lblPMName" runat="server" Text='<%# Bind("PMName", "{0}") %>' Visible="False"></asp:Label>
                                <asp:Label ID="lblPLName" runat="server" Text='<%# Bind("PLName", "{0}") %>' Visible="False"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Relation" HeaderText="Relation" SortExpression="Relation" />
                        <asp:BoundField DataField="Age" HeaderText="Age" SortExpression="Age" />
                        <asp:BoundField DataField="Party_Name" HeaderText="Insurer" SortExpression="Party_Name" />
                        <asp:BoundField DataField="Party_Desg_Name" HeaderText="Employee Designation" SortExpression="Party_Desg_Name" />
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
    </table>
     
    

    

    <asp:Label ID="Label4" runat="server"></asp:Label><br />
    <div align="center">
        <asp:Button ID="ButtonSave" runat="server" CssClass="btn1" Text="Save" TabIndex="57"
            Width="100px" ValidationGroup="s" Visible="False" />
        <asp:Button ID="btn_Refresh" runat="server" Text="Refresh" />
        <asp:LinkButton ID="LinkButton1" runat="server" TabIndex="13" 
            CssClass="n_print" ValidationGroup="s" CausesValidation="True" OnClientClick="return checkrequiredrfname()"><span></span>Save & Print</asp:LinkButton>

        <asp:Button ID="Button2" runat="server" Text="Save & Print" UseSubmitBehavior="False"
            Visible="False" />
        <asp:Button ID="Button1" runat="server" Text="Old Save & Print" CssClass="btn2" TabIndex="59"
            Visible="False" />
        <asp:Button CssClass="btn1" ID="BTNDetail1" runat="server" TabIndex="60" Text="Other Details"
            CausesValidation="False" Visible="False" />
        <asp:HyperLink ID="Hyper_Services" runat="server" CssClass="n_print" 
            NavigateUrl="~/Patient%20Billing/Services_Page.aspx?regno=0&amp;payid=0" 
            Target="_blank">Assign Test</asp:HyperLink>
    </div>
    <asp:HiddenField ID="HiddenField_registration_date" runat="server" />
    <br />
    <asp:SqlDataSource ID="PatientSaveRecord2" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        InsertCommand="PatientRegistration2" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>"
        SelectCommandType="StoredProcedure">
        <InsertParameters>
            <asp:FormParameter FormField="RBLprefix" Name="Prefix" Type="String" />
            <asp:FormParameter FormField="textboxpfname" Name="PFName" Type="String" />
            <asp:FormParameter FormField="textboxpmname" Name="PMName" Type="String" />
            <asp:FormParameter FormField="textboxplname" Name="PLName" Type="String" />
            <asp:FormParameter FormField="rblrelation" Name="Relation" Type="String" />
            <asp:FormParameter FormField="textboxrfname" Name="RFName" Type="String" />
            <asp:FormParameter FormField="textboxrmname" Name="RMName" Type="String" />
            <asp:FormParameter FormField="textboxrlname" Name="RLName" Type="String" />
            <asp:FormParameter FormField="sex" Name="sexID" Type="Int32" />
            <asp:FormParameter FormField="textboxage" Name="Age" Type="Int32" />
            <asp:SessionParameter Name="RegDateTime" SessionField="DT" Type="DateTime" />
            <asp:FormParameter FormField="country" Name="CountryCode" Type="Int32" />
            <asp:FormParameter FormField="province" Name="ProvinceID" Type="Int32" />
            <asp:FormParameter FormField="district" Name="DistrictID" Type="Int32" />
            <asp:FormParameter FormField="tehsil" Name="Tehsil" Type="Int32" />
            <asp:FormParameter FormField="textboxzipcode" Name="Zipcode" Type="Decimal" />
            <asp:FormParameter FormField="textboxstreetaddress" Name="StreetAddress" Type="String" />
            <asp:FormParameter FormField="textboxcolony" Name="Colony" Type="String" />
            <asp:SessionParameter Name="HomePhone" SessionField="PHP" Type="String" />
            <asp:SessionParameter Name="MobilePhone" SessionField="PMP" Type="String" />
            <asp:SessionParameter Name="DateOfBirth" SessionField="DOB" Type="DateTime" />
            <asp:FormParameter FormField="textboxprovince2" Name="OtherProvince" Type="String" />
            <asp:FormParameter FormField="textboxdistrict2" Name="Otherdistrict" Type="String" />
            <asp:FormParameter FormField="textboxtehsil2" Name="OtherTehsil" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="PatientSaveRecord" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        InsertCommand="PatientRegistration" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:FormParameter FormField="rblprefix" Name="Prefix" Type="String" />
            <asp:FormParameter FormField="txtpfname" Name="PFName" Type="String" />
            <asp:FormParameter FormField="txtpmname" Name="PMName" Type="String" />
            <asp:FormParameter FormField="txtplname" Name="PLName" Type="String" />
            <asp:FormParameter FormField="rblrelation" Name="Relation" Type="String" />
            <asp:FormParameter FormField="txtrfname" Name="RFName" Type="String" />
            <asp:FormParameter FormField="txtrmname" Name="RMName" Type="String" />
            <asp:FormParameter FormField="txtrlname" Name="RLName" Type="String" />
            <asp:FormParameter FormField="sex" Name="sexID" Type="Int32" />
            <asp:FormParameter FormField="txtage" Name="Age" Type="Int32" />
            <asp:SessionParameter Name="RegDateTime" SessionField="DT" Type="DateTime" />
            <asp:FormParameter FormField="country" Name="CountryCode" Type="Int32" />
            <asp:FormParameter FormField="province" Name="ProvinceID" Type="Int32" />
            <asp:FormParameter FormField="district" Name="DistrictID" Type="Int32" />
            <asp:FormParameter FormField="tehsil" Name="Tehsil" Type="Int32" />
            <asp:FormParameter FormField="txtzipcode" Name="Zipcode" Type="Int32" />
            <asp:Parameter Name="House_No" Type="String" />
            <asp:FormParameter FormField="txtstreetaddress" Name="StreetAddress" Type="String" />
            <asp:FormParameter FormField="txtcolony" Name="Colony" Type="String" />
            <asp:SessionParameter Name="HomePhone" SessionField="PHP" Type="String" />
            <asp:SessionParameter Name="MobilePhone" SessionField="PMP" Type="String" />
            <asp:SessionParameter Name="nic" SessionField="nic" Type="String" />
            <asp:SessionParameter Name="DateOfBirth" SessionField="dob" Type="DateTime" />
            <asp:Parameter Direction="InputOutput" Name="NewRegNo" Type="String" />
            <asp:Parameter Name="DateTime" Type="DateTime" />
            <asp:Parameter Name="DeptID" Type="Int32" />
            <asp:Parameter Name="Status" Type="String" />
            <asp:Parameter Name="EmpID" Type="Int32" />
            <asp:Parameter Name="Diagonosis" Type="String" />
            <asp:Parameter Name="PatientType" Type="String" />
            <asp:Parameter Name="AgeType" Type="String" />
            <asp:Parameter Name="ReferFrom" Type="String" />
            <asp:Parameter Direction="InputOutput" Name="paymentid" Type="Decimal" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT Department.Dept_Name, Department.Dept_ID FROM Reception_Dept INNER JOIN Department ON Reception_Dept.Dept_Id = Department.Dept_ID WHERE (Reception_Dept.Reception_Status = 1)">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="districtsource" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT [DistrictCode], [DistrictName] FROM [DISTRICT] WHERE ([ProvinceCode] = @ProvinceCode) order by priority">
        <SelectParameters>
            <asp:ControlParameter ControlID="Province" Name="ProvinceCode" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="TehsilSource" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        SelectCommand="SELECT [TehsilCode], [TehsilName] FROM [TEHSIL] WHERE ([districtCode] = @districtCode)">
        <SelectParameters>
            <asp:ControlParameter ControlID="district" Name="districtCode" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Provincesource" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        SelectCommand="SELECT [ProvinceName], [ProvinceCode] FROM [Province] WHERE ([CountryCode] = @CountryCode)">
        <SelectParameters>
            <asp:Parameter DefaultValue="3" Name="CountryCode" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Countrysorce" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        SelectCommand="SELECT CountryName, CountryCode FROM Country ORDER BY CountryName">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SexSource" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        SelectCommand="SELECT Gender_ID, Gender FROM Gender"></asp:SqlDataSource>
    <asp:SqlDataSource ID="printinfosave" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        InsertCommand="INSERT INTO [Print] (EmpID, PrintDateTime, RegNo) &#13;&#10;VALUES (@EmpID, @PrintDateTime, @RegNo)"
        ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:SessionParameter Name="EmpID" SessionField="UserID" />
            <asp:SessionParameter Name="PrintDateTime" SessionField="PDT" />
            <asp:SessionParameter Name="RegNo" SessionField="PRegNoForDetail" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString  %>"
        InsertCommandType="StoredProcedure" SelectCommand="PatientRegistration12" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDiagnosis" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        SelectCommand="SELECT Diagnosis FROM Diagnosis ORDER BY Diagnosis"></asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_country" runat="server" Value="12" />
    <asp:HiddenField ID="HiddenField_province" runat="server" Value="12" />
    <%--Oehsan <img alt="" src="wt.GIF" style="display: none;" />--%>
    <asp:SqlDataSource ID="SqlDataSource_SubDept" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT '' as SubDept_Name ,0 as SubDept_Id  
	
	union  all

	select SubDepartment.SubDept_Name,SubDepartment.SubDept_Id 
	FROM SubDepartment 
	JOIN Department ON Department.Dept_ID=SubDepartment.Dept_Id
	WHERE SubDepartment.SubDept_Type = 1  AND Department.Hospital_ID=@HospitalId

	ORDER BY SubDept_Name ">
        <SelectParameters>
             <asp:SessionParameter Name="HospitalId" SessionField="hospitalid" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_district" runat="server" Value="12" />
    <asp:HiddenField ID="HiddenField_tehsil" runat="server" Value="12" />
    <asp:HiddenField ID="HiddenFieldComplaint" runat="server" />
    <script type="text/javascript">
<!--
        var CollapsiblePanel1 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel1", { contentIsOpen: false });
        var CollapsiblePanel2 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel2", { contentIsOpen: false });
        var cookies = Spry.Utils.Cookie("read", "CollapsiblePanel3ck");

        if (cookies == "true") {
            var CollapsiblePanel3 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel3", { contentIsOpen: true });
        } else { var CollapsiblePanel3 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel3", { contentIsOpen: false }); }

        Spry.Utils.addUnLoadListener(function () {
            Spry.Utils.Cookie("create", "CollapsiblePanel3ck", CollapsiblePanel3.isOpen());

        });
//-->
    </script>
    <asp:HiddenField ID="HiddenField_msg_Patient_Name" runat="server" />
    <asp:HiddenField ID="HiddenField_Msg_Mr_No" runat="server" />
    <asp:HiddenField ID="HiddenField_flag" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Patient_Appointment" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        DeleteCommand="Update [Patient_Appointment] set Status=2,Arrival_Time=getdate() WHERE [Appoinment_ID] = @Appoinment_ID"
        InsertCommand="PatientReg_Appointment" InsertCommandType="StoredProcedure" SelectCommand="SELECT [Appoinment_ID], [For_Doctor], [Complaint], [Appointmant_DateTime], [By_Emp_id], [Reg_No], [Booking_Datetime], [AppointmentNo], [Confirmed], [Pre_Appoinment_ID], [Priority], [Other], [Referred_by], [Appointment_Time], [Dept_ID], [Sub_Dept_ID], [Prefix], [District_Id], [S_ID], [RegNo], [Description], [Doctor_App_Slot_Id], [Status], [App_Type], [Email_Address], [PFName], [PMName], [PLName], [PatientAddress], [PhoneNo], [CellNo] FROM [Patient_Appointment]"
        UpdateCommand="UPDATE Patient_Appointment SET Reg_No = @Reg_no_new, Yearly_No = @Yearly_No WHERE (Appoinment_ID = @Appoinment_ID)">
        <DeleteParameters>
            <asp:ControlParameter ControlID="HiddenField_Appointment_ID" Name="Appoinment_ID"
                PropertyName="Value" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:SessionParameter Name="Reg_no_new" SessionField="RegistrationNo" />
            <asp:ControlParameter ControlID="HiddenField_Appointment_ID" Name="Appoinment_ID"
                PropertyName="Value" />
            <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenField_reg_no" Name="RegNo" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Prefix" Name="Prefix" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_PFName" Name="PFName" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_PMName" Name="PMName" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_PLName" Name="PLName" PropertyName="Value" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Appointment_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_Doctor_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_Cnic_flag" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_religion" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT [Religion_ID], [Religion_name] FROM [Religion]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Nationality" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        
        SelectCommand="select 0 as [Nationality_ID],'' as [Nationality_Name] union SELECT [Nationality_ID], [Nationality_Name] FROM [Nationality]">
    </asp:SqlDataSource>
    &nbsp; &nbsp; &nbsp;
    <br />
</asp:Content>
