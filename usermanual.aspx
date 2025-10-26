<%@ Page Language="VB" AutoEventWireup="false" Inherits="usermanual, App_Web_uj03ztnp" EnableEventValidation="false" Theme="theme_hacims" ViewStateEncryptionMode="Never" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>



    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <!--Styles -->
    <link href="css_hacims/class_reset.css" rel="stylesheet" type="text/css" media="screen, projection" />
    <link href="css_hacims/class_content.css" rel="stylesheet" type="text/css" media="screen, projection" />
    <!--[if IE]><link rel="stylesheet" href="css_hacims/content_ie.css" type="text/css" media="screen, projection"/><![endif]-->
    <link rel="icon" href="images_hacims/favicon.ico" />
    <link rel="shortcut icon" href="images_hacims/favicon.ico" />
    <!--Scripts-->


    <style type="text/css">
        #container {
            width: 944px;
        }

        #content_login {
            width: 100%;
            border: #a5b9c6 solid 1px;
            -webkit-border-radius: 6px;
            -moz-border-radius: 6px;
            border-radius: 6px;
            -webkit-box-shadow: 0px 0px 3px #bbc5ce;
            -moz-box-shadow: 0px 0px 3px #bbc5ce;
            box-shadow: 0px 0px 3px #bbc5ce;
            background-color: #FFF;
        }

        fieldset {
            border: #999999 solid 1px;
            padding: 10px;
            width: 270px;
            -webkit-border-radius: 6px;
            -moz-border-radius: 6px;
            border-radius: 6px;
            float: left;
            margin-left: 12px;
            clear: right;
            margin-bottom: 25px;
            margin-top: 15px;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div id="container">
            <div id="header">
                <div id="logininfo">
                    <ul>
                        <li class="welcome">Welcome!<span>Guest</span></li>
                        <li class="datet">
                            <asp:Label ID="LabelDate" runat="server" Style="color: #0155a6;"></asp:Label></li>
                    </ul>
                </div>
                <div id="navigation" style="margin-right: 12px;">
                    <div class="posmenu">
                        <ul class="navigation_link" style="margin-right: 12px; margin-left: 25px;">
                            <li><a href="login.aspx" title="User Login">User Login</a></li>

                            <li><a href="usermanual.aspx" title="User Manual" style="color: #01469e;">User Manual</a></li>

                        </ul>
                    </div>
                </div>
                <!--navigation END-->
            </div>
            <!--header END-->

            <div id="content_login" style="min-height: 392px;">
                <h1 class="h1" style="width: 98%; margin-left: 8px;"><span>User Manual</span></h1>

                <div style="margin-left: 10px; margin-right: 10px; line-height: 18px;">


                    <br />
                    <table class="diagnosis_list">
                        <tr>
                            <td>
                                <h3 style="margin-left:45px">OPD</h3>
                                <img src="HMISMenual/adobe-pdf-icon.png" alt="Alternate Text" width="100" height="100" onclick="downloadOPDMenual('HMISMenual/OPDUserManual.pdf')" style="cursor:pointer" />

                            </td>
                             <td>
                                <h3 style="margin-left:45px">IPD</h3>
                                <img src="HMISMenual/adobe-pdf-icon.png" alt="Alternate Text" width="100" height="100" onclick="downloadIPDMenual('HMISMenual/IPDUserManual.pdf')" style="cursor:pointer" />

                            </td>
                             <td>
                                <h3 style="margin-left:45px">HR</h3>
                                <img src="HMISMenual/adobe-pdf-icon.png" alt="Alternate Text" width="100" height="100" onclick="downloadHRMenual('HMISMenual/HRusermannaul.pdf')" style="cursor:pointer" />

                            </td>
                        </tr>
                        <tr>
                            <td>
                                <h3 style="margin-left:45px">Payroll</h3>
                                <img src="HMISMenual/adobe-pdf-icon.png" alt="Alternate Text" width="100" height="100" onclick="downloadPayrollMenual('HMISMenual/Payroll.pdf')" style="cursor:pointer" />

                            </td>
                             <td>
                                <h3 style="margin-left:45px">Duty Roster</h3>
                                <img src="HMISMenual/adobe-pdf-icon.png" alt="Alternate Text" width="100" height="100" onclick="downloaddutyRosterMenual('HMISMenual/DutyRosterUserManual.pdf')" style="cursor:pointer" />

                            </td>
                             <td>
                                <h3 style="margin-left:45px">Finance</h3>
                                <img src="HMISMenual/adobe-pdf-icon.png" alt="Alternate Text" width="100" height="100" onclick="downloadFinanceMenual('HMISMenual/Finance.pdf')" style="cursor:pointer" />

                            </td>
                        </tr>
                       
                      
                        <tr>
                            <td>
                                 <h3 style="margin-left:45px">Laboratory</h3>
                                <img src="HMISMenual/adobe-pdf-icon.png" alt="Alternate Text" width="100" height="100" onclick="downloadFinanceMenual('HMISMenual/laboratory.pdf')" style="cursor:pointer" />

                            </td>
                            <td>
                                <h3 style="margin-left:45px">Inventory</h3>
                                <img src="HMISMenual/adobe-pdf-icon.png" alt="Alternate Text" width="100" height="100" onclick="downloadFinanceMenual('HMISMenual/Inventory.pdf')" style="cursor:pointer" />

                            </td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                    <br />

                    <br />
                    <br />

                </div>

            </div>
            <!--content END-->
            <div id="footer"><span><a href="#" title="HACIMS - Design &amp; Developed by Oratier Technologies (Pvt.) Ltd." target="_blank">&copy; 2012  -  All rights reserved.</a></span></div>
        </div>
        <!--container END-->

    </form>
</body>
</html>

<script>
    var downloadOPDMenual = function (path) {
        window.open(path, '_blank')
    }
    var downloadIPDMenual = function (path) {
        window.open(path, '_blank')
    }
    var downloadHRMenual = function (path) {
        window.open(path, '_blank')
    }
    var downloadPayrollMenual = function (path) {
        window.open(path, '_blank')
    }
    var downloaddutyRosterMenual = function (path) {
        window.open(path, '_blank')
    }
    var downloadFinanceMenual = function (path) {
        window.open(path, '_blank')
    }
</script>

