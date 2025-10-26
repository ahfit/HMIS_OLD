<%@ Page Language="VB" AutoEventWireup="false" CodeFile="login.aspx.vb" Inherits="login" EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

   

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <!--Styles -->
    <link href="css_hacims/class_reset.css" rel="stylesheet" type="text/css" media="screen, projection" />
    <link href="css_hacims/class_content.css" rel="stylesheet" type="text/css" media="screen, projection" />
    <!--[if IE]><link rel="stylesheet" href="css_hacims/content_ie.css" type="text/css" media="screen, projection"/><![endif]-->
    <link rel="icon" href="images_hacims/favicon.ico" />
    <link rel="shortcut icon" href="images_hacims/favicon.ico" />
    <!--Scripts-->


    <script type="text/javascript" language="javascript">

        function setfocus1() {
            document.getElementById("txtusername").focus();
        }
    </script>
    <style>
        .bg{
            min-width: 20em;
	margin:0;
	color:#6a6f8c;
	background:url(./images_hacims/back.jpg);
    background-repeat: no-repeat;
    background-position: center;
    background-size: cover;
    width: 100%;
    height: 100%;
	font:600 16px/18px 'Open Sans',sans-serif;
}
*,:after,:before{box-sizing:border-box}
.clearfix:after,.clearfix:before{content:'';display:table}
.clearfix:after{clear:both;display:block}
a{color:inherit;text-decoration:none}

.login-wrap{
	width:100%;
	margin:auto;
	max-width:525px;
	min-height:700px;
	position:relative;
	/*background:url(../images_hacims/NewFolder1/medical.jpg) no-repeat center;*/
	/*box-shadow:0 12px 15px 0 rgba(0,0,0,.24),0 17px 50px 0 rgba(0,0,0,.19);*/
}
.login-html{
	width: 92%;
    height: 77%;
    position: absolute;
    padding: 90px 70px 50px 70px;
    background: rgba(40,57,101,.9);
}
.login-html .sign-in-htm,
.login-html .sign-up-htm{
	top:0;
	left:0;
	right:0;
	bottom:0;
	position:absolute;
	transform:rotateY(180deg);
	backface-visibility:hidden;
	transition:all .4s linear;
}
.login-html .sign-in,
.login-html .sign-up,
.login-form .group .check{
	display:none;
}
.login-html .tab,
.login-form .group .label,
.login-form .group .button{
	text-transform:uppercase;
}
.login-html .tab{
	font-size:22px;
	margin-right:15px;
	padding-bottom:5px;
	margin:0 15px 10px 0;
	display:inline-block;
	
}
.login-html .sign-in:checked + .tab,
.login-html .sign-up:checked + .tab{
	color:#fff;
	border-color:#1161ee;
}
.login-form{
	min-height:345px;
	position:relative;
	perspective:1000px;
	transform-style:preserve-3d;
}
.login-form .group{
	margin-bottom:15px;
}
.login-form .group .label,
.login-form .group .input,
.login-form .group .button{
	width:100%;
	color:#fff;
	display:block;
}
.login-form .group .input,
.login-form .group .button{
	border:none;
	padding:15px 20px;
	
	background:rgba(255,255,255,.1);
}
.login-form .group input[data-type="password"]{
	text-security:circle;
	-webkit-text-security:circle;
}
.login-form .group .label{
	color:white;
	font-size:12px;
}
.login-form .group .button{
	background:#1161ee;
}
.login-form .group label .icon{
	width:15px;
	height:15px;
	border-radius:2px;
	position:relative;
	display:inline-block;
	background:rgba(255,255,255,.1);
}
.login-form .group label .icon:before,
.login-form .group label .icon:after{
	content:'';
	width:10px;
	height:2px;
	background:#fff;
	position:absolute;
	transition:all .2s ease-in-out 0s;
}
.login-form .group label .icon:before{
	left:3px;
	width:5px;
	bottom:6px;
	transform:scale(0) rotate(0);
}
.login-form .group label .icon:after{
	top:6px;
	right:0;
	transform:scale(0) rotate(0);
}
.login-form .group .check:checked + label{
	color:#fff;
}
.login-form .group .check:checked + label .icon{
	background:#1161ee;
}
.login-form .group .check:checked + label .icon:before{
	transform:scale(1) rotate(45deg);
}
.login-form .group .check:checked + label .icon:after{
	transform:scale(1) rotate(-45deg);
}
.login-html .sign-in:checked + .tab + .sign-up + .tab + .login-form .sign-in-htm{
	transform:rotate(0);
}
.login-html .sign-up:checked + .tab + .login-form .sign-up-htm{
	transform:rotate(0);
}

.hr{
	height:2px;
	margin: 42px 0 0px 0;
	background:rgba(255,255,255,.2);
}
.foot-lnk{
	text-align:center;
}
input:-webkit-autofill {
    border: 1px solid #ccc;
    -webkit-box-shadow: inset 0 0 0px 9999px white;
}

input:focus,
input:-webkit-autofill:focus {
    border-color: #66afe9;
    -webkit-box-shadow: inset 0 0 0px 9999px white,
                        0 0 8px rgba(102, 175, 233, 0.6);
}
    </style>

</head>
<body onload="setfocus1() highlight();">
    <div class="bg">
                  
                    <div class="nav nav-pills col-md-12 hidden-sm hidden-xs" style=" background:none;">
                               
                            <ul class="navigation_link" style="background:rgba(40,57,101,.9); height: 48px;padding: 12px; width:101%; font-kerning: none; text-align: center;">
                                <li><a href="login.aspx" title="User Login"> <strong>User Login</strong></a></li>
                                <li><a href="abouthacims.aspx" title="About Hacims">About HACIMS</a></li>
                                <li><a href="usermanual.aspx" title="User Manual">User Manual</a></li>
                                <li style="background: none;"><a href="contactinfo.aspx" title="Contact Information">Contact Information</a></li>
                            </ul>


                        
                    </div>
         <asp:Label ID="LabelDate" runat="server" Style="    float: right; margin-right: 2em;font-family: initial;font-size: 14px; color: #3c4b74;"></asp:Label>
    <div class="login-wrap" style="text-align:center">
	<div class="login-html" style="margin-top: 2em;  min-width: 29em;">
		<input id="tab-1" type="radio" name="tab" class="sign-in" checked>
            <label for="tab-1" class="tab" style=" margin-top: -3em;background: #3b4b740d; font-size: 14px;-align: left;color: black;">
                <img class="col-md-4 col-sm-4 col-xs-4" src="images_hacims/akhlong.png" width="270px;"/>
                    
             </label>
		<input  class="sign-up" class="col-md-12"><label for="tab-2" class="tab" > </label>
		<div class="login-form" style="margin-top: 1em;">
            <form id="form1" runat="server" autocomplete="off">
			<div class="sign-in-htm" style="margin-top:-1em">
				<div class="group">
					<label for="user" class="label">Username</label>
					<asp:TextBox ID="txtusername" runat="server" ValidationGroup="log" Style="font-size: large;     color: #3b4b74;background: white;height: 2.7em;text-align: center;border-radius: 3px;width: 18.7em;" AutoCompleteType="disabled"></asp:TextBox>
				</div>
				<div class="group">
					<label for="pass" class="label">Password</label>
					  <asp:TextBox ID="txtPassword"  Style="font-size: large;     color: #3b4b74;background: white;height: 2.7em;text-align: center;border-radius: 3px;width: 18.7em;" runat="server" ValidationGroup="log" MaxLength="40" TabIndex="0" TextMode="Password" CssClass="txtbox"></asp:TextBox>
                                        <asp:RegularExpressionValidator ValidationGroup="log" ID="Regex2" runat="server" ControlToValidate="txtPassword"
                                            ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$" Display="dynamic"
                                            ErrorMessage="**" ForeColor="Red" ToolTip="Minimum 8 characters atleast 1 Alphabet, 1 Number and 1 Special Character" />
                                        <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
				</div>
			
				<div class="group" style="margin-top: 1.3em;">
                     <asp:Button ID="btnLogin"  runat="server" ValidationGroup="log" CausesValidation="true" Style=" font-family: sans-serif;font-weight: 100;border: none;font-size: large; height: 2.5em;background: #1161ee;width: 19em; margin-top: 1em;padding: 0px; border-radius: 3px;color: white; box-shadow: none" Text="Log In" />
				</div>
				<div class="hr"><br />
                     <a href="forgotpassword.aspx" title="Forgot Password?" style="padding: 0.8em 1em; border-radius: 3px;color: white;font-size: 14px">Forgot Password?</a>
				 <p style="margin-top:13px"> <asp:Label ID="lblMessage" runat="server" Style=" text-align:center; font-size: 13px;font-family: -webkit-body;font-weight: bold; color: black;" CssClass="errmsg"></asp:Label></p>
                </div>
				
			</div>
                </form>
            
		</div>
		</div>
	</div>
        <div style="color: #3c4b74;  font-weight: 900;margin-left: 30em;"><span><a href="#" title="HACIMS - Design &amp; Developed by Megaplus Technologies" target="_blank">&copy; 2012  -  All rights reserved - MegaPlus Technologies</a></span></div>
</div>
   
</body>


</html>
