<%@ Page Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true"
    CodeFile="PatientRegistrationBilling_Out.aspx.cs" Inherits="Patient_Registration_PatientRegistrationBilling_Out"
    Title="Untitled Page" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
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
            box-shadow: 0 0 5px rgba(0,0,0,0.5);
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
        .auto-style1 {
            color: brown;
            font-size: 11px;
            font-weight: bold;
            text-align: right;
            height: 5px;
            width: 23%;
            border-bottom: 1px dotted #ccc;
            margin: 8px;
            padding: 5px;
        }
        .auto-style2 {
            color: brown;
            font-size: 11px;
            font-weight: bold;
            text-align: right;
            border-bottom: 1px dotted #ccc;
            margin: 8px;
            padding: 5px;
        }
    </style>
    <script type="text/javascript">
        function ClientItemSelected2(sender, e) {
            $get("<%=hfItemCode.ClientID %>").value = e.get_value();
         }
    </script>
     <script type="text/javascript">
         function openWin(url) {
             var myWindow = window.open(url, "_blank", "width=1px, height=1px");

             setTimeout(function () { myWindow.close() }, 5000);
         }
</script>
    <script type="text/javascript">

        $(document).ready(function () {
            $('#ctl00_ContentPlaceHolder1_LinkButton1').click(function () {

                return checkrequiredrfname();
                return false;

            });
        });
 
 

    </script>
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
    <script type="text/javascript">
        //
        // $(document).ready(function(){  
        //	   $("#ctl00_ContentPlaceHolder1_Checkbox_CopyAdd").removeAttr('checked');
        //	    
        //		 $("#ctl00_ContentPlaceHolder1_textboxage").val()==0;
        //		 $("#ctl00_ContentPlaceHolder1_textboxmcode").val()==0;
        //	 
        //	 
        //	   
        //            $("input#ctl00_ContentPlaceHolder1_Checkbox_CopyAdd").bind("click",function(){
        //                if($("input#ctl00_ContentPlaceHolder1_Checkbox_CopyAdd:checked").length)
        //                {
        //                    $("#ctl00_ContentPlaceHolder1_TextBox_House_Ot").val($("#ctl00_ContentPlaceHolder1_textboxHouseNo").val());
        //					 $("#ctl00_ContentPlaceHolder1_TextBox_Street_OT").val($("#ctl00_ContentPlaceHolder1_textboxstreetaddress").val());
        //					  
        //					   
        //					    $("#ctl00_ContentPlaceHolder1_country_ot").val($("#ctl00_ContentPlaceHolder1_country").val());
        //						 $("#ctl00_ContentPlaceHolder1_Province_ot").val($("#ctl00_ContentPlaceHolder1_Province").val());
        //						 
        //						  $("#ctl00_ContentPlaceHolder1_district_ot").css("display","none");
        //					  $("#ctl00_ContentPlaceHolder1_tehsil_ot").css("display","none");
        //						  $("#ctl00_ContentPlaceHolder1_district_ot_txt").css("display","block");
        //					  $("#ctl00_ContentPlaceHolder1_tehsil_ot_txt").css("display","block");
        //						  $("#ctl00_ContentPlaceHolder1_district_ot_txt").val($("#ctl00_ContentPlaceHolder1_district").find(":selected").text());
        //					   $("#ctl00_ContentPlaceHolder1_tehsil_ot_txt").val($("#ctl00_ContentPlaceHolder1_tehsil").find(":selected").text());
        //					
        //					 
        //                }
        //                else
        //                {
        //                    $("#ctl00_ContentPlaceHolder1_TextBox_House_Ot").val("");
        //					$("#ctl00_ContentPlaceHolder1_TextBox_Street_OT").val("");
        //				 
        //				 
        //					$("#ctl00_ContentPlaceHolder1_country_ot").val("");
        //					$("#ctl00_ContentPlaceHolder1_Province_ot").val("");
        //					$("#ctl00_ContentPlaceHolder1_district_ot").val("");
        //					$("#ctl00_ContentPlaceHolder1_tehsil_ot").val("");
        //					 $("#ctl00_ContentPlaceHolder1_district_ot").css("display","block");
        //					  $("#ctl00_ContentPlaceHolder1_tehsil_ot").css("display","block");
        //					 $("#ctl00_ContentPlaceHolder1_district_ot_txt").css("display","none");
        //					  $("#ctl00_ContentPlaceHolder1_tehsil_ot_txt").css("display","none");
        //					 
        //                }
        //            });
        //        }
        //    );   
        //</script>
    <script language="javascript" type="text/javascript">
        function RunEXE(prog) {
            alert(prog);
            var oShell = new ActiveXObject("WScript.Shell");
            alert("asdasas");
            oShell.Run('"' + prog + '"', 1);
            alert("asdasas");
        }
    </script>
    <script type="text/javascript" language="javascript">

        function txtChange(a) {

            var txt = document.getElementById("<%=TextBox_CNIC_No.ClientID%>");
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

            if (document.getElementById("ctl00_ContentPlaceHolder1_textboxpfname").value.length == 0) {
                alert("Enter first name");
                document.getElementById("ctl00_ContentPlaceHolder1_textboxpfname").focus();
                return false;
            }
            if (document.getElementById("ctl00_ContentPlaceHolder1_textboxplname").value.length == 0) {
                alert("Enter last name");
                document.getElementById("ctl00_ContentPlaceHolder1_textboxplname").focus();
                return false;
            }
            if (document.getElementById("ctl00_ContentPlaceHolder1_textboxrfname").value.length == 0) {
                alert("Enter relation first name");
                document.getElementById("ctl00_ContentPlaceHolder1_textboxrfname").focus();
                return false;
            }
            if (document.getElementById("ctl00_ContentPlaceHolder1_WebDateTimeEdit_DOB").value.length == 0) {
                alert("Enter DOB");
                document.getElementById("ctl00_ContentPlaceHolder1_WebDateTimeEdit_DOB").focus();
                return false;
            }
                        if (document.getElementById("ctl00_ContentPlaceHolder1_textboxmcode").value.length == 0) {
                            alert("Enter contact number");
                            document.getElementById("ctl00_ContentPlaceHolder1_textboxmcode").focus();
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
    <script src="../SpryAssets/mycollaps.js" type="text/javascript"></script>
    <link href="../SpryAssets/mycollaps.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../css_hacims/maskito.js"></script>
    <script src="../css_hacims/ck.js" type="text/javascript"></script>
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
    <script type="text/javascript">
        var xPos, yPos;
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_beginRequest(BeginRequestHandler);
        prm.add_endRequest(EndRequestHandler);
        function BeginRequestHandler(sender, args) {
            xPos = $get('scrollDiv').scrollLeft;
            yPos = $get('scrollDiv').scrollTop;
        }
        function EndRequestHandler(sender, args) {
            $get('scrollDiv').scrollLeft = xPos;
            $get('scrollDiv').scrollTop = yPos;
        }
    </script>
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
            <td style="width: 55%; vertical-align: top;">
                <div class="bxmain" style="width: 99%; margin-bottom: 4px;">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td>
                                Reg #:
                            
                            
                                
                                <asp:TextBox ID="txtRegistrationNo" TabIndex="1" runat="server" ></asp:TextBox>
                                
                                Mobile #:
                                    

                                 <asp:TextBox ID="TextBoxMobile" TabIndex="1" runat="server" MaxLength="11" 
                                    Style="background-color: #f9dde2;" ValidationGroup="s" ></asp:TextBox>
                                    
                             
                              <span style="font-size: 10pt; color: #d92542">*</span>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBoxMobile"
                                                  ValidationGroup="s"  ErrorMessage="*Enter Valid Contact No."></asp:RequiredFieldValidator>
                            <span style="font-size: 10pt; color: #d92542;">
                                <asp:Label ID="Label1" runat="server" ForeColor="Red" Text="Enter Mobile #"
                                    Visible="False"></asp:Label>
                            </span>
                                    
                             
                              
                                <br />
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" 
                                runat="server" ControlToValidate="TextBoxMobile"
                                              ValidationGroup="s"      
                                 ValidationExpression="\d{4}-\d{7}"
                                                    ></asp:RegularExpressionValidator>
                            </td>

                            <td>
                                <asp:Button ID="btnRegistrationSearch" TabIndex="2" runat="server" CausesValidation="false"
                                    Text="Search " OnClick="btnRegistrationSearch_Click" />
                                <asp:Label ID="Label3" runat="server" ForeColor="Red"></asp:Label>
                                <asp:HiddenField ID="HiddenField_UpdateRegNo" runat="server" />
                                </td>
                                
                            </td>
                            <td>
                            </td>
                        </tr>
        <tr>
        
              <td runat="server" style="margin-top:5px" id="divRegistration"  colspan="5" align="center">
                    <div id="divClose"   class="bxmain" style="width: 99%; margin-bottom: 4px; margin-top: 10px;text-align: center;">
                            <asp:HiddenField ID="hfRegNo" runat="server" />
                   <%--type="image" src="../images_hacims/icon_delete.gif"--%>
                        <div runat="server"  style="text-align:center;padding-bottom:10px;">    <input type="button" value="Close"   onclick="myfunction()"  class="btn_hacims"  /></div>
                            <asp:GridView ID="gvdPatient" runat="server" AutoGenerateColumns="false" EmptyDataText="No Record Found" EmptyDataRowStyle-ForeColor="Maroon" EmptyDataRowStyle-Font-Size="X-Large" EmptyDataRowStyle-Font-Bold="true">
                                <Columns>
                                    <asp:TemplateField HeaderText="MR #">   
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkRegNo" runat="server" Text='<%# Eval("RegNo") %>' CommandArgument='<%# Eval("RegNo") %>' OnClick="lnkRegNo_Click" CausesValidation="false"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:BoundField DataField="PatientName" HeaderText="Patient Name" />
                                    <asp:BoundField DataField="Relation" HeaderText="Relation" />
                                    <asp:BoundField DataField="RelationName" HeaderText="Relation Name" />
                                    <%--<asp:BoundField DataField="AdmissionDate" HeaderText="Admission Date" />--%>
                                </Columns>
                            </asp:GridView>
                        </div>
              </td>
          </tr>
                    </table>
                </div>
                <div class="bxmain" style="width: 99%; margin-bottom: 4px;">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" >
                        <tr class="rowStyle">
                            <td class="heading">
                                <p style="text-align: center;">Title :</p>
                            </td>
                            <td style="width: 18em;">
                                <asp:RadioButtonList ID="RBLprefix" TabIndex="3" runat="server" RepeatLayout="Flow"
                                    RepeatDirection="Horizontal">
                                    <asp:ListItem Selected="True">Mr.</asp:ListItem>
                                    <asp:ListItem>Miss</asp:ListItem>
                                  
                                    <asp:ListItem>Mrs.</asp:ListItem>
                                  
                                    <asp:ListItem>B/O</asp:ListItem>
                                    <asp:ListItem>B</asp:ListItem>

                                     <asp:ListItem>Mas</asp:ListItem>
                                  
                                </asp:RadioButtonList>
                            </td>
                            <td style="text-align: right;" colspan="2">
                                &nbsp;
                                <asp:RadioButtonList ID="RadioButtonList_Type" runat="server" RepeatLayout="Flow"
                                    RepeatColumns="2" RepeatDirection="Horizontal" Visible="False">
                                    <asp:ListItem Selected="True">Paid</asp:ListItem>
                                    <asp:ListItem>Free</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                            <td>
                                <span class="marks"></span>&nbsp;
                            </td>
                        </tr>
                        <tr class="rowStyle">
                            <td class="heading">
                                First Name :
                            </td>
                            <td>
                                <asp:TextBox AccessKey="n" ID="textboxpfname" Style="background-color: #f9dde2;"
                                runat="server" TabIndex="4" MaxLength="20" SkinID="captxt" ></asp:TextBox>
                            </td>
                            <td align="right" class="heading"  colspan="2">CNIC #:</td>
                            
                            <td>
                                <asp:TextBox ID="TextBox_CNIC_No" runat="server" MaxLength="15" TabIndex="7" onkeypress= "txtChange(this)"></asp:TextBox>
                                <asp:HiddenField
                                    ID="HiddenField_Cnic_flag" runat="server" />
                               
                            </td>
                            
                        </tr>
                        <tr class="rowStyle" style="display: none;">
                            <td>
                                Middle Name :
                            </td>
                            <td>
                                <asp:TextBox ID="textboxpmname" runat="server" MaxLength="12" class="input_txt"
                                    SkinID="captxt"></asp:TextBox>
                               <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" Display="dynamic"
                                    ControlToValidate="textboxpmname" ValidationGroup="s55" ErrorMessage="Enter Valid Middle Name" ValidationExpression="[A-Z a-z]*"></asp:RegularExpressionValidator>
                           --%> </td>
                            <td align="right" colspan="2">
                                <strong>Nationality :</strong></td>
                            <td>
                                <asp:DropDownList ID="DropDownList_Nationality" runat="server" DataSourceID="SqlDataSource_Nationality"
                                    DataTextField="Nationality_Name" DataValueField="Nationality_ID" AccessKey="g"
                                    AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr class="rowStyle">
                            <td class="heading">
                                Last Name :</td>
                            <td style="width:215px;">
                                <asp:TextBox ID="textboxplname" TabIndex="5" runat="server" MaxLength="20" SkinID="captxt" Visible="true" 
                                    class="input_txt" Style="background-color:white;"></asp:TextBox>
                                
                            </td>
                            <td class="heading" colspan="2">
                                <strong>DOB :
                            </strong>
                            </td>
                            <td style="min-width: 215px;">
                                <igtxt:WebDateTimeEdit ID="WebDateTimeEdit_DOB" TabIndex="8" runat="server" style="height: 1.5em;background-color: #f9dde2;" Width="85px"
                                    Culture="en-GB">
                                </igtxt:WebDateTimeEdit>
                                <span style="font-size: 10pt; color: #d92542">*</span><asp:HiddenField ID="HiddenField_DOB" runat="server" />
                                <asp:TextBox AccessKey="a" ID="textboxage" TabIndex="8" runat="server" AutoCompleteType="disabled" Style="height: 1.5em; background-color: #f9dde2;" ValidationGroup = "s"
                                    Width="28px" MaxLength="3"></asp:TextBox>
                                <asp:DropDownList ID="DropDownListBIndicator" TabIndex="9" runat="server" Width="70px"
                                    AccessKey="y">
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
                               <p> Contact # :</p>
                            </td>
                            <td style="width:215px;">
                                <%--<span class="marks">*</span>&nbsp;--%>
                                
                                <asp:TextBox ID="textboxmcode" TabIndex="6" runat="server" MaxLength="11" 
                                    Style="background-color: #f9dde2;" ValidationGroup="s" ></asp:TextBox>
                                    
                             
                              <span style="font-size: 10pt; color: #d92542">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator_textboxmcode" runat="server" ControlToValidate="textboxmcode"
                                                  ValidationGroup="s"  ErrorMessage="*Enter Valid Contact No."></asp:RequiredFieldValidator>
                            <span style="font-size: 10pt; color: #d92542;">
                                <asp:Label ID="Label_Mobile" runat="server" ForeColor="Red" Text="Enter Mobile #"
                                    Visible="False"></asp:Label>
                            </span>
                                    
                             
                              
                                <br />
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator_textboxmcode" 
                                runat="server" ControlToValidate="textboxmcode"
                                              ValidationGroup="s"      
                                 ValidationExpression="\d{4}-\d{7}"
                                                    ></asp:RegularExpressionValidator>
                            </td><%--<asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="textboxplname"
                                    ErrorMessage="Enter Valid Last Name" ValidationExpression="[A-Za-z]*" Display="None"
                                    ValidationGroup="s">
                                    </asp:RegularExpressionValidator>--%>
                            <td class="heading" colspan="2">
                                Patient Gender :
                            </td>
                            <td style="min-width: 215px;">
                                <asp:DropDownList ID="sex" TabIndex="9" runat="server" DataSourceID="SexSource"
                                    DataTextField="Gender" DataValueField="Gender_ID" Style="width: 200px;height: 1.5em;" 
                                    AccessKey="g">
                                    <asp:ListItem Selected="True" Value="M">Male</asp:ListItem>
                                    <asp:ListItem Value="F">Female</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr class="rowStyle" style="Display:none";>
                            <td class="heading">
                                Middle Name :</td>
                            <td>
                                <%--<span style="font-size: 10pt; color: #d92542">*
                                    <asp:Label ID="Label_Mobile" runat="server" ForeColor="Red" Text="Enter Mobile or Phone #"
                                        Visible="False"></asp:Label>--%>
                                </span>
                                <asp:TextBox ID="textboxrmname" runat="server" SkinID="captxt" MaxLength="12"></asp:TextBox>
                                <br />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" Display="Dynamic"
                                    ControlToValidate="textboxrmname" ErrorMessage="Enter Valid Relation Middle Name"
                                    ValidationExpression="[A-Z a-z]*"></asp:RegularExpressionValidator>
                            </td>
                            <td class="heading" colspan="2">
                                &nbsp;</td>
                            <td valign="top">
                                &nbsp;</td>
                        </tr>
                         <tr class="rowStyle">
                            <td class="heading">
                                &nbsp;Relation :</td>
                            <td>
                                <asp:RadioButtonList ID="RBLrelation"  runat="server" RepeatLayout="Flow"
                                    RepeatDirection="Horizontal">
                                    <asp:ListItem Selected="True">S/O</asp:ListItem>
                                    <asp:ListItem>D/O</asp:ListItem>
                                    
                                    <asp:ListItem>W/O</asp:ListItem>
                                    
                                </asp:RadioButtonList>
                            </td>

                            
                            <td>
                                    <asp:DropDownList ID="DropDownList_Religion" 
    runat="server" DataSourceID="SqlDataSource_religion"
                                    DataTextField="Religion_name" 
    DataValueField="Religion_ID" AccessKey="g" Visible="False">
                                    </asp:DropDownList>
                                    <br />
                                    <asp:CheckBox ID="CheckBox_Same_as_Above" runat="server" 
                                        OnCheckedChanged="CheckBox_Same_as_Above_CheckedChanged" Text="Next Of Kin" 
                                        Visible="false" />
                                <asp:Panel ID="Panel1" runat="server" Visible="false">
                                    <br />
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr class="rowStyle">
                            <td class="heading">
                                &nbsp;First Name :</td>
                            <td colspan="2">
                                <asp:TextBox ID="textboxrfname" TabIndex="11" Style="background-color: #f9dde2;"
                                    MaxLength="20" runat="server" SkinID="captxt"></asp:TextBox>
                                <%--<span style="font-size: 10pt; color: #d92542">*</span><br />
                                <span class="marks">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="dynamic"
                                        ControlToValidate="textboxrfname" ErrorMessage="*"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" Display="dynamic"
                                        ControlToValidate="textboxrfname" ErrorMessage="Enter Valid Relation First Name"
                                        ValidationExpression="[A-Za-z]*" ValidationGroup="s"></asp:RegularExpressionValidator>
                                </span>--%>
                            </td>
                            <td align="right" class="heading" >
                                Last Name :
                            
                            </td>
                            <td>
                                <asp:TextBox ID="textboxrlname" TabIndex="12" runat="server" Visible="true" MaxLength="20"
                                    class="input_txt" SkinID="captxt" 
                                    OnTextChanged="textboxrlname_TextChanged"></asp:TextBox>
                                <br />
                               <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="textboxrlname"
                                    ErrorMessage="Enter Valid Relation Last Name" ValidationExpression="[A-Za-z]*" Display="Dynamic"
                                    ValidationGroup="s55">
                                </asp:RegularExpressionValidator>--%>
                            </td>
                        </tr>
                       
                        <tr class="rowStyle">
                            <td class="heading" style="width: 80px;">
                                Address 1:</td>
                            <td colspan="4">
                                <asp:TextBox ID="txtAddress" TabIndex="13" style="height: 2em; width: 564px;" runat="server" SkinID="captxt"></asp:TextBox>
                            </td>
                        </tr>
                       
                    </table>
                </div>
                <div class="bxmain" style="width: 99%; margin-bottom: 4px;">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="auto-style1">
                                <p>Center: </p>
                            </td>
                            <td  style="height: 42px">
                                <%--<asp:UpdatePanel ID="Up_Dept" runat ="server">
                                    <ContentTemplate>--%>
                                <asp:DropDownList AccessKey="d" ID="DDLDepartment" runat="server" AutoPostBack="true" 
                                    DataSourceID="SqlDataSourceDepartment"  DataTextField="Dept_Name"
                                    DataValueField="Dept_ID" Width="150px" OnSelectedIndexChanged="DDLDepartment_SelectedIndexChanged" OnTextChanged="DDLDepartment_TextChanged">
                                    <asp:ListItem Value="6">Emergency</asp:ListItem>
                                </asp:DropDownList></td>
                                       <%-- </ContentTemplate>
                                    </asp:UpdatePanel>--%>
                                <%-- <asp:UpdatePanel ID="Up_SubDepartment" runat ="server">
                                    <ContentTemplate>--%>
                            <td  class="heading" style="height: 42px"> <p style="margin-left: 1em;">Department:</p></td>  
                            <td> <asp:DropDownList ID="DropDownList1" runat="server" TabIndex="14" DataSourceID="SqlDataSource_SubDept"
                                    Width="140px" DataTextField="SubDept_Name" DataValueField="SubDept_Id" 
                                    AutoPostBack="True" 
                                    onselectedindexchanged="DropDownList1_SelectedIndexChanged">
                                </asp:DropDownList>
                                </td>
                            <td class="heading"><p style=" margin-left: 1em;">Doctor:</p></td>
                                  <td width="20%" style="height:5px;">
                                    <asp:DropDownList ID="DropDownList_Employee_name" runat="server" TabIndex="15"
                                    DataTextField="Employee Name" DataValueField="EmpID" 
                                    Width="140px" AutoPostBack="True" 
                                   >
                                </asp:DropDownList>
                                      </td>
                            </tr>
                        
                              <tr>
                                  

                                 
                                        <%--</ContentTemplate>
                                    </asp:UpdatePanel>--%>
                               
                                        <td class="auto-style2" >
                                            Refer&nbsp;Doctor:
                                        </td>
                                        <td>
                                            <asp:TextBox ID="TextBox_refer_other" runat="server" style="width: 12.7em;"></asp:TextBox>
                                             <asp:AutoCompleteExtender ID="aceItems" runat="server" ServiceMethod="SearchItems"
                                        MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                                        TargetControlID="TextBox_refer_other" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected2"
                                CompletionListCssClass="AutoExtender" CompletionListItemCssClass="AutoExtenderList" 
                        CompletionListHighlightedItemCssClass="AutoExtenderHighlight">
                                    </asp:AutoCompleteExtender>
<asp:HiddenField ID="hfItemCode" runat="server" />

                                        </td>
                                           <td class="heading" >
                                                File #:
                                           </td>
                                        <td>
                                      <asp:TextBox ID="TextBox_Room_No" runat="server" TabIndex="16" style="width: 12em;"></asp:TextBox>

                                        </td>
                                <td>
                                    <asp:RadioButtonList ID="RadioButtonList_Patient_Type" TabIndex="21" runat="server"
                                    DataValueField="Patient_type_Cat" DataTextField="Patient_type_Cat" AutoPostBack="True"
                                    RepeatLayout="Flow" RepeatDirection="Horizontal" Width="456px">
                                </asp:RadioButtonList>

                                </td>
                                  <td>
                                      &nbsp;
                                  </td>
                                  </tr>
                                    
                               <%-- <b>Room:</b>--%>
                                
                                
                                <asp:Label ID="LbL_Mg" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                            </td>
                        </tr>
                        <tr class="rowStyle">
                            <td class="heading">
                                Patient Type:
                            </td>
                            <td  style="height: 44px">
                                <div style="width: 90%; margin: auto; margin-left: -2px;">
                                    <asp:DropDownList ID="rblPatientType_Sub" TabIndex="16" runat="server" AutoPostBack="True"
                                        DataSourceID="SQL_Patient_Type_Sub" DataTextField="Patient_type" DataValueField="Patient_type_id"
                                        RepeatDirection="Horizontal" Style="font-size: 11px;" Visible="true" RepeatLayout="Flow"
                                        Height="20px" RepeatColumns="20" 
                                        OnSelectedIndexChanged="rblPatientType_Sub_SelectedIndexChanged">
                                    </asp:DropDownList>
                              
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr class="rowStyle" style="display:none">
                                            <td colspan="4">
                                                <asp:Panel ID="pnlPanelPatient" runat="server" style="display:none" Width="100%">
                                                    <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                                                        <tr ID="td_RegistrationType" runat="server" visible="False">
                                                            <td align="right" width="30%">
                                                                Type :
                                                            </td>
                                                            <td>
                                                                <asp:RadioButtonList ID="rblRegistrationType" runat="server" 
                                                                    AutoPostBack="True" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                                                    <asp:ListItem Selected="True" Value="Self">Self</asp:ListItem>
                                                                    <asp:ListItem Value="Dependent">Dependent</asp:ListItem>
                                                                </asp:RadioButtonList>
                                                                <asp:DropDownList ID="ddlEmp_Patient" runat="server" AutoPostBack="True" 
                                                                    Visible="False">
                                                                </asp:DropDownList>
                                                                <asp:DropDownList ID="ddlRelation" runat="server" AutoPostBack="True" 
                                                                    DataSourceID="SQL_Insert_Dependents" DataTextField="Relation" 
                                                                    DataValueField="Relation_ID" Visible="False">
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
                                                        <tr ID="td_Insurer" runat="Server" visible="False">
                                                            <td align="right">
                                                                Insurer :
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="DropDownList_Parties" runat="server" AutoPostBack="True" 
                                                                    DataSourceID="SqlDataSource_parties" DataTextField="Party_Name" 
                                                                    DataValueField="Party_Id">
                                                                </asp:DropDownList>
                                                                <asp:SqlDataSource ID="SqlDataSource_parties" runat="server" 
                                                                    ConnectionString="<%$ ConnectionStrings:PatientBilllingConnectionString %>" SelectCommand="SELECT     Parties.Party_Id, Parties.Party_Name
FROM         Parties INNER JOIN
                      Patient_Billing_Party ON Parties.Party_Id = Patient_Billing_Party.Billing_Party_Id
WHERE     (Patient_Billing_Party.Patient_Type_Id = @Party_Type_Id)
order by Party_Name">
                                                                    <SelectParameters>
                                                                        <asp:ControlParameter ControlID="rblPatientType_Sub" Name="Party_Type_Id" 
                                                                            PropertyName="SelectedValue" />
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
                                                            </td>
                                                        </tr>
                                                        <tr ID="td_Employee_Designation" runat="Server" visible="False">
                                                            <td align="right">
                                                                Employee Designation :
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlDesignation" runat="server" 
                                                                    DataSourceID="dsDesignations" DataTextField="Party_Desg_Name" 
                                                                    DataValueField="Party_Desg_ID">
                                                                </asp:DropDownList>
                                                                <asp:SqlDataSource ID="dsDesignations" runat="server" 
                                                                    ConnectionString="<%$ ConnectionStrings:PatientBilllingConnectionString %>" 
                                                                    ProviderName="<%$ ConnectionStrings:PatientBillingConnectionString.ProviderName %>" 
                                                                    SelectCommand="Select_Party_Designation" SelectCommandType="StoredProcedure">
                                                                   <%-- <SelectParameters>
                                                                        <asp:ControlParameter ControlID="DropDownList_Parties" Name="Party_id" 
                                                                            PropertyName="SelectedValue" Type="Int32" />
                                                                    </SelectParameters>--%>
                                                                </asp:SqlDataSource>
                                                                <asp:SqlDataSource ID="dsEmployeeDependents" runat="server" 
                                                                    ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>" 
                                                                    ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" 
                                                                    SelectCommand="SELECT EmployeeDependents.Reg_No, EmployeeDependents.Party_Desg_Name, EmployeeDependents.Party_Name, EmployeeDependents.Prefix, EmployeeDependents.PFName, EmployeeDependents.PMName, EmployeeDependents.PLName, EmployeeDependents.Relation, EmployeeDependents.RFName, EmployeeDependents.RMName, EmployeeDependents.RLName, EmployeeDependents.Gender, EmployeeDependents.Emp_No, EmployeeDependents.RegistrationType, Patient.CNIC, Patient.MobilePhone FROM EmployeeDependents INNER JOIN Patient ON EmployeeDependents.Reg_No = Patient.RegNo WHERE (EmployeeDependents.Emp_No = @Emp_No) AND (EmployeeDependents.Party_Id = @Party_ID) AND (EmployeeDependents.Party_Desg_ID = @Party_Desg_ID) ORDER BY EmployeeDependents.RegistrationType DESC">
                                                                    <SelectParameters>
                                                                        <asp:ControlParameter ControlID="txtEmployeeNo" Name="Emp_No" 
                                                                            PropertyName="Text" />
                                                                        <asp:ControlParameter ControlID="DropDownList_Parties" Name="Party_ID" 
                                                                            PropertyName="SelectedValue" />
                                                                        <asp:ControlParameter ControlID="ddlDesignation" Name="Party_Desg_ID" 
                                                                            PropertyName="SelectedValue" />
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
                                                                <asp:Button ID="btnSearchEmployee" runat="server" CausesValidation="False" 
                                                                    Text="Search" ToolTip="Click to search Employee" ValidationGroup="none" />
                                                                <asp:Button ID="Button_Clear" runat="server" Text="Clear" Visible="False" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" style="height: 18px">
                                                            </td>
                                                            <td style="height: 18px">
                                                                <asp:Button ID="btnFingerPrint" runat="server" 
                                                                    OnClientClick="RunEXE('D:\\New Finger Print\\bin\\FingerprintReader.exe')" 
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
                             <td class="auto-style2">
                                Remarks:
                            </td>
                            <td colspan="3">
                                <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" Width="347px" height="50px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr style="display:none">
                            <td class="auto-style2">
                                Patient Type:
                            </td>
                            <td>
                                <asp:DropDownList style="width: 10.7em;" ID="ddlPatientType" TabIndex="17" runat="server" >
                                    <asp:ListItem>IPD</asp:ListItem>
                                    <asp:ListItem Value="OPD" Selected="True"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                           
    </tr>
       
                        <tr >
                            <td class="auto-style2" colspan="2">
                                <asp:Panel ID="Panel3" runat="server" Width="100%" Visible="false">
                    <ul id="CollapsiblePanel3" style="width: 265%;margin-top: -22px;">
                        <li>
                            <h1 class="h1" style=" text-align: left;">
                                <span>Enter Corporate Details</span></h1>
                        </li>
                        <li>
                            <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                                <tr runat="server" id="Tr1" visible="False">
                                    <td align="right" width="30%">
                                        Type :
                                    </td>
                                    <td>
                                        <asp:RadioButtonList ID="RadioButtonList1" RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            runat="server" AutoPostBack="True">
                                            <asp:ListItem Value="Self" Selected="True">Self</asp:ListItem>
                                            <asp:ListItem Value="Dependent">Dependent</asp:ListItem>
                                        </asp:RadioButtonList>
                                        <asp:DropDownList ID="DropDownList3" runat="server" TabIndex="35" 
                                            AutoPostBack="True">
                                        </asp:DropDownList>
                                        <asp:DropDownList ID="DropDownList4" runat="server" TabIndex="35" Visible="False" DataSourceID="SQL_Insert_Dependents"
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
                                <tr runat="Server" id="Tr2">
                                    <td align="right">
                                        Insurer :
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="DropDownList5" runat="server" DataValueField="Party_Id"
                                            DataTextField="Party_Name" OnSelectedIndexChanged="DropDownList5_SelectedIndexChanged" DataSourceID="SqlDataSource_parties" AutoPostBack="True" Width="200px">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:PatientBilllingConnectionString %>"
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
                                <tr runat="Server" id="Tr3" >
                                    <td align="right">
                                        Employee Designation :
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="DropDownList6" runat="server" DataValueField="Party_Desg_ID"
                                            DataTextField="Party_Desg_Name" DataSourceID="dsDesignations" Width="200px">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" SelectCommand="Select_Party_Designation"
                                            ConnectionString="<%$ ConnectionStrings:PatientBilllingConnectionString %>" ProviderName="<%$ ConnectionStrings:PatientBillingConnectionString.ProviderName %>"
                                            SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="DropDownList_Parties" Name="Party_id" PropertyName="SelectedValue"
                                                    Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <asp:SqlDataSource ID="SqlDataSource4" runat="server" SelectCommand="SELECT EmployeeDependents.Reg_No, EmployeeDependents.Party_Desg_Name, EmployeeDependents.Party_Name, EmployeeDependents.Prefix, EmployeeDependents.PFName, EmployeeDependents.PMName, EmployeeDependents.PLName, EmployeeDependents.Relation, EmployeeDependents.RFName, EmployeeDependents.RMName, EmployeeDependents.RLName, EmployeeDependents.Gender, EmployeeDependents.Emp_No, EmployeeDependents.RegistrationType, Patient.CNIC, Patient.MobilePhone FROM EmployeeDependents INNER JOIN Patient ON EmployeeDependents.Reg_No = Patient.RegNo WHERE (EmployeeDependents.Emp_No = @Emp_No) AND (EmployeeDependents.Party_Id = @Party_ID) AND (EmployeeDependents.Party_Desg_ID = @Party_Desg_ID) ORDER BY EmployeeDependents.RegistrationType DESC"
                                            ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>" ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>">
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
                                        <asp:TextBox ID="TextBox1" runat="server" ToolTip="Enter Employee Number"></asp:TextBox>
                                        <asp:Button ID="Button1" runat="server" Text="Search" CausesValidation="False"
                                            ToolTip="Click to search Employee"></asp:Button>
                                        <asp:Button ID="Button2" runat="server" Text="Clear" Visible="False" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                    </td>
                                    <td>
                                        <asp:Button ID="Button3" runat="server" Text="Finger Print" OnClientClick="RunEXE('D:\\New Finger Print\\bin\\FingerprintReader.exe')"
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
                                &nbsp;</td>
                           
    </tr>
       
                    </table>
      <div class="bxmain" style="width: 70%; margin-bottom: 4px; text-align: center;  border: none;">
                    <asp:Label ID="lblErrorMsg" ForeColor="Red" Font-Bold="true" runat="Server" Text=""></asp:Label>
                   
                    <asp:Button  ID="btnSaveInformation" TabIndex="24" Text="Save Information" OnClick="btnSaveInformation_Click"
                        runat="Server" Visible="False" />
                    <asp:Button style="float: left;margin-left: 8em;" ID="btn_Refresh" runat="server" onclick="btn_Refresh_Click" 
                        Text="Refresh" />
                    <asp:Panel ID="pnlPaymentButton" runat="server">
                        <asp:Button ID="btnMakePayment" 
                            OnClick="btnMakePayment_Click" 
                            runat="server" 
                            Text="Save & Forward to Make Payment" TabIndex="22" 
                            >
                        </asp:Button>
                    </asp:Panel>
                </div>
                </div>
              
                
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
            </td>
            <td style="border-left: 2px solid gray; vertical-align: top; width: 50%;padding-left:5px;">
                <table width="100%">
                    <tbody>
                        <tr>
                            <td>
                                <asp:Label ID="lblMsg" Font-Bold="true" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <!-- Add Services -->
                <!-- End Add Services -->
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
                            <table class="tbl_form" cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tbody>
                                    <tr>
                                        <td style="width: 53px" align="right">
                                            <asp:DropDownList ID="DropDownList2" runat="server" DataValueField="Asc_id" DataTextField="Asc_Name"
                                                DataSourceID="SqlDataSource_Packages" AutoPostBack="True" TabIndex="18" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                        <td align="left">
                                            Search Services :
                                        </td>
                                        <td>
                                            <asp:TextBox ID="TextBox_Search_Service" runat="server" CssClass="input_txt" 
                                                Width="200px" ontextchanged="TextBox_Search_Service_TextChanged" 
                                                AutoPostBack="True" TabIndex="19"></asp:TextBox>
                                             <cc1:AutoCompleteExtender ID="AutoComplete_Complaint" runat="server" CompletionInterval="10"
                                            CompletionSetCount="12" EnableCaching="true" UseContextKey="true" MinimumPrefixLength="3"
                                            ServiceMethod="SearchServices"  TargetControlID="TextBox_Search_Service">
                                        </cc1:AutoCompleteExtender>

                                            <asp:Label ID="LabelAmountError" runat="server" CssClass="err" Visible="False"></asp:Label>
                                            <br />
                                        </td>
                                        <td style="width:100px;">
                                            
                                        </td>
                                    </tr>                                    
                                    <tr>
                                        <td align="right" style="width: 53px">
                                            &nbsp;</td>
                                        <td align="left">
                                            &nbsp;</td>
                                        <td align="center">
                                            <asp:Button ID="btnSearchTest" runat="server" CausesValidation="False" 
                                                OnClick="btnSearchTest_Click" TabIndex="20" Text="Search" />
                                            <asp:HiddenField ID="HiddenFieldServiceDate" runat="server" />
                                        </td>
                                        <td style="width:100px;">
                                            &nbsp;</td>
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
                                                                        
                                </tbody>
                            </table>
                            <div style="background: white 0px 0px; overflow: auto; margin-top: 5px; height: 200px;
                                border: 1px solid Silver;" id="scrollDiv">
                                <asp:DataList ID="DataListServices" runat="Server" DataSourceID="SqlDataSource_For_Grid"
                                    Width="100%" TabIndex="21" 
                                    >
                                    <HeaderTemplate>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <div style="width: 90%; margin: auto; margin-top: 2px;">
                                            <div style="float: left;">
                                                <asp:LinkButton ID="lnkServiceName" OnClick="lnkServiceName_Click" 
                                                    runat="Server" __designer:wfdid="w1" CommandArgument='<%# Eval("S_ID") %>' 
                                                    Text='<%# Eval("S_Name") %>'></asp:LinkButton>
                                                    <%--__designer:wfdid="w1"--%>
                                                   
                                                
                                                <asp:HiddenField ID="hfldEdit_Status" runat="Server" Value='<%# Eval("Edit_Status") %>' __designer:wfdid="w2"></asp:HiddenField>
                                                    <%----%>
                                                    
                                                <asp:HiddenField ID="hfldS_Category" runat="Server" Value='<%# Eval("S_Category") %>'  __designer:wfdid="w3"  ></asp:HiddenField>
                                                    <%----%>
                                                <asp:HiddenField ID="hfdactualamount" runat="Server" Value='<%# Eval("S_Amount") %>'  __designer:wfdid="w3"  ></asp:HiddenField>
                                                
                                            </div>
                                            

                                            <div style="float: right;">
                                                
                                                <asp:TextBox ID="txtQty" runat="server" Text="1" TextMode="Number" SkinID="intdata"  Width="50px" />
                                                <asp:TextBox ID="TextBox_Amount" ReadOnly="true" runat="server" Text='<%# Eval("PanelAmount") %>' Width="50px"  designer:wfdid="w4">
                                                </asp:TextBox>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:DataList>
                            </div>
                            <div style="text-align: center; width: 100%; margin-top: 5px;display:none;">
                                <asp:Button ID="btnCloseAddService" OnClick="btnCloseAddService_Click" runat="Server"
                                    Text="Close" CausesValidation="false"></asp:Button>
                                Selected Services
                            </div>
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
                                         <asp:HiddenField ID="hfdactualamoutss" runat="server" Value='<%# Bind("Payment_Status") %>'   >
                                            </asp:HiddenField>
                                              <asp:Label ID="lblDID" runat="Server" Text='<%#Eval("Doctor_ID") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Services">
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("ServiceName") %>'></asp:Label>
                                             
                                               <asp:HiddenField ID="HiddenField_Doctor_ID" runat="server" Value='<%# Bind("Doctor_ID", "{0}") %>'>
                                            </asp:HiddenField>
                                            <asp:HiddenField ID="HiddenField2" runat="server" Visible="False" Value='<%# Bind("ServiceID") %>'>
                                            </asp:HiddenField>
                                            <asp:HiddenField ID="HiddenFieldpnlstatus1" runat="server" >
                                            </asp:HiddenField>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Actual Amount">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAcamount" runat="Server" Text='<%#Eval("Payment_Status") %>'></asp:Label>
                                        </ItemTemplate>
                                        
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Charges">
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

         
                                    <asp:TemplateField >
                                        <ItemTemplate>
                                            <asp:DropDownList ID="DropDownList_Doctor" runat="server" Width="100px" DataValueField="EmpID"
                                                DataTextField="Name" DataSourceID="SqlDataSource_Doctor_Charges" >
                                            </asp:DropDownList>
                                            <cc1:ListSearchExtender ID="ListSearchExtender1" runat="server" TargetControlID="DropDownList_Doctor">
                                            </cc1:ListSearchExtender>
                                            <br />
                                           
                                            <asp:SqlDataSource ID="SqlDataSource_Doctor_Charges" runat="server" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                                SelectCommand="SELECT ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS Name, Employee.EmpID, Doctor_Service.Service_ID FROM Doctor_Service INNER JOIN Employee ON Doctor_Service.Doctor_ID = Employee.EmpID WHERE (Doctor_Service.Service_ID = @Service_ID) "
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
            </td>
            <!--end EHSAN-->
        </tr>
    </table>
    <asp:SqlDataSource ID="SexSource" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        SelectCommand="SELECT Gender_ID, Gender FROM Gender"></asp:SqlDataSource>
   
    <asp:SqlDataSource ID="SqlDataSource_religion" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT [Religion_ID], [Religion_name] FROM [Religion]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Nationality" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT [Nationality_ID], [Nationality_Name] FROM [Nationality]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQL_Patient_Type_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        ProviderName="System.Data.SqlClient" SelectCommand="SELECT     *&#13;&#10;FROM         Patient_Type AS pt INNER JOIN&#13;&#10;                      Patient_Type_HospitalWise AS pth ON pt.ID = pth.Patient_Type_Id&#13;&#10;WHERE   (pth.Hospital_Id = @Hospital_Id) and pt.Active = 'True' ">
        <SelectParameters>
            <asp:SessionParameter Name="Hospital_Id" SessionField="HospitalID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand=" SELECT DISTINCT Department.Dept_Name, Department.Dept_ID FROM Department 
  inner join Reception_Dept RD on RD.Reception_Dept_Id=Department.Dept_ID
   WHERE Reception_Dept_Id=@SeDept">
        <SelectParameters>
            <asp:SessionParameter SessionField="Dept_ID" Name="SeDept" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_SubDept" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        
        SelectCommand="select SubDepartment.SubDept_Name,SubDepartment.SubDept_Id FROM SubDepartment where SubDept_Type=1   ORDER BY SubDept_Name ">
      <%--  <SelectParameters>
            <asp:ControlParameter ControlID="DDLDepartment" Name="Dept_Id" PropertyName="SelectedValue" />
        </SelectParameters>--%>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Employee" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
        SelectCommand="Select_Consultant_By_SubDept_Walkin" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="Dept_type" PropertyName="SelectedValue" />
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
            <asp:Parameter DefaultValue="0" Name="S_Category" />
            <asp:Parameter DefaultValue="0" Name="Reg_No" />
            <asp:Parameter DefaultValue="0" Name="Yearly_No" />
            <asp:Parameter DefaultValue="0" Name="ASP_ID" />
            <asp:Parameter DefaultValue="0" Name="Hospital_Id" />
            <asp:Parameter DefaultValue="0" Name="Patient_Type_Id" />
            <asp:Parameter DefaultValue="OPD" Name="IPD_OPD" />
            <asp:Parameter DefaultValue="0" Name="Billing_Party_Id" />            
        </SelectParameters>
        <InsertParameters>
            <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" Type="String" />
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
            <asp:SessionParameter Name="empid" SessionField="Emp_ID" Type="Int32" />
            <asp:ControlParameter Name="S_ID" Type="Int32" ControlID="HiddenField_SID" PropertyName="Value" />
            <asp:ControlParameter Name="Amount" Type="Int32" ControlID="HiddenField_amount" PropertyName="Value" />
             <asp:Parameter DefaultValue="0" Name="PanelAmount" />

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
               
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Packages" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT '0' AS Asc_id, ' All' AS Asc_Name UNION SELECT CONVERT (varchar, Asc_id) AS Asc_id, Asc_Name FROM Admin_Service_Category where Admin_Service_Category.Active=1 order by Asc_Name">
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
            <asp:ControlParameter ControlID="RBLprefix" Name="Prefix" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="textboxpfname" Name="RelativeFName" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="textboxpmname" Name="RelativeMName" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="textboxplname" Name="RelativeLName" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="RBLrelation" Name="RelativeRType" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="textboxrfname" Name="RelativeRFName" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="textboxrmname" Name="RelativeRMName" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="textboxrlname" Name="RelativeRLName" PropertyName="Text"
                Type="String" />
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
            <asp:ControlParameter ControlID="DropDownList1" DefaultValue="%" Name="S_Category"
                PropertyName="SelectedValue" Size="10" />
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
            <asp:Parameter Name="Amount" Type="Int32" />
            <asp:Parameter DefaultValue="0" Name="Payment_Status" Type="Int16" />
            <asp:Parameter Name="SubDept_ID" Type="Int32" />
            <asp:Parameter Name="Dept_ID" Type="Int32" />
            <asp:Parameter Name="sdatetime"  Type="DateTime" />
            <asp:Parameter Name="Qty" Type="Double" />
            <asp:Parameter Direction="Output" Name="msg" Size="100" Type="String" />
            <asp:Parameter Name="Refer_By_ID" Type="Int32" />
            <asp:Parameter Name="Refer_From_Other" Type="String" />
            <asp:Parameter DefaultValue="0" Name="PanelAmount" />
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
            <asp:ControlParameter ControlID="RBLprefix" Name="Prefix" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="HiddenFieldPFName" Name="PFName" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="HiddenFieldPMName" Name="PMName" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="RBLrelation" Name="Relation" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="textboxrfname" Name="RFName" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="textboxrmname" Name="RMName" PropertyName="Text"
                Type="String" />
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
            <asp:ControlParameter ControlID="HiddenField_mobile_no" 
                Name="MobilePhone" PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="HiddenField_CNIC" Name="CNIC" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="HiddenField_DOB" Name="DateOfBirth" PropertyName="Value"
                Type="DateTime" />
            <asp:ControlParameter ControlID="DropDownListBIndicator" Name="AgeType" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="txtAddress" DefaultValue="" Name="HouseNo" 
                PropertyName="Text" />
            <asp:ControlParameter ControlID="HiddenFieldPLName" Name="PLName" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="textboxrlname" Name="RLName" PropertyName="Text"
                Type="String" />
            <asp:Parameter DefaultValue="0" Name="Passport_No" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_PatientTYpeName" Name="Patient_Type"
                PropertyName="Value" Type="String" />
            <asp:Parameter DefaultValue="0" Name="Email_address" Type="String" />
            <asp:ControlParameter ControlID="HiddenField_Party_ID" Name="party_ID" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList_Religion" Name="Religion" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList_Nationality" Name="Nationality" PropertyName="SelectedValue"
                Type="Int32" />
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
 
</asp:Content>
