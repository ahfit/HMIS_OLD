<%@ page language="VB" autoeventwireup="false" inherits="forgotpassword, App_Web_uj03ztnp" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
 
 
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>
</title>


 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 <!--Styles -->
<link href="css_hacims/class_reset.css"   rel="stylesheet"   type="text/css" media="screen, projection" />
<link href="css_hacims/class_content.css" rel="stylesheet"   type="text/css" media="screen, projection" />
<!--[if IE]><link rel="stylesheet" href="css_hacims/content_ie.css" type="text/css" media="screen, projection"/><![endif]-->
<link rel="icon" href="images_hacims/favicon.ico"/>
<link rel="shortcut icon" href="images_hacims/favicon.ico"/>
<!--Scripts-->

  
<style type="text/css">

#container {width:944px; }
#content_login {  width:100%;  border:#a5b9c6 solid 1px; -webkit-border-radius: 6px; -moz-border-radius:6px; 
border-radius: 6px;  -webkit-box-shadow: 0px 0px 3px #bbc5ce; -moz-box-shadow: 0px 0px 3px #bbc5ce; box-shadow:0px 0px 3px #bbc5ce; background-color:#FFF;        }

fieldset {border:#999999 solid 1px; padding:10px; width:270px; -webkit-border-radius: 6px; -moz-border-radius:6px; 
border-radius: 6px; float:left; margin-left:12px; clear:right; margin-bottom:25px; margin-top:15px;   }

</style>


<script language="javascript" type="text/javascript">
 function check(a)
{

if (document.getElementById("TextBox_user_Name").value == "")
{

alert("Enter User Name:");

return false ;

}
else
{
alert ("Your Password Has been sent on your email Address:");

return true;
} 
}
</script>

 </head>
 
 <body>
  
  <form id="form1" runat ="server" >
         
         <div id="container">
  <div id="header">
    <div id="logininfo">
      <ul>
        <li class="welcome">Welcome!<span>Guest</span></li>
        <li class="datet"><asp:Label ID="LabelDate" runat="server" style="color:#0155a6;"></asp:Label></li>
      </ul>
    </div>
    <div id="navigation"  style="margin-right:12px;" >
    <div class="posmenu"  >
    <ul class="navigation_link" style="margin-right:12px; margin-left:25px;" >
	<li ><a href="login.aspx" title="User Login"   >User Login</a></li>
    <li ><a href="abouthacims.aspx" title="About Hacims" >About HACIMS</a></li>
  	<li ><a href="usermanual.aspx" title="User Manual">User Manual</a></li>
    <li style="background:none;" ><a href="contactinfo.aspx" title="Contact Information">Contact Information</a></li>
    </ul>
    </div> 
    </div><!--navigation END-->
  </div>
  <!--header END-->
  
  <div id="content_login" style="min-height:392px;"> 
   <h1 class="h1" style="width:98%; margin-left:8px;"><span>Forgot Password</span></h1>
   
   <div style="margin-left:10px; margin-right:10px; line-height:18px;">
         
       <%--<asp:ScriptManager ID="ScriptManager2" runat="server">
       </asp:ScriptManager>--%>
            <asp:ScriptManager ID="ScriptManager1" runat="server"> </asp:ScriptManager>
               <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                <ContentTemplate>
          
                       
            <div class="bxmain">    
              <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td align="right" width="40%">User Name :</td>
    <td><asp:TextBox ID="TextBox_user_Name" runat="server"   AutoPostBack="True" OnTextChanged="TextBox_user_Name_TextChanged" ></asp:TextBox>
                  <span class="red">*</span>
                  <asp:RequiredFieldValidator
    ID="RequiredFieldValidator_userName" runat="server" ControlToValidate="TextBox_user_Name"
    ErrorMessage="Enter User Name" Display="Dynamic"></asp:RequiredFieldValidator>
                  <asp:Label ID="Label_UserName"
        runat="server" CssClass="usern" Visible="false"></asp:Label></td>
  </tr>
</table>
  
   </div>             
                   
                </ContentTemplate>
              </asp:UpdatePanel>
            <br />

       <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="40%">&nbsp;</td>
    <td>  <asp:Button ID="Submit" runat="server" Text="Send"/></td>
  </tr>
</table>
      
            
              
      </div>
  
  </div>
  <!--content END-->
  <div id="footer"><span><a href="#"  title="HACIMS - Design &amp; Developed by Oratier Technologies (Pvt.) Ltd." target="_blank">&copy; 2012  -  All rights reserved.</a></span></div>
</div>
<!--container END-->
 
</form>
</body>
</html>
