<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Reception_Main, App_Web_ybbpntbq" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">


 
<script language="JavaScript">
function Page_Name()
{
     var page_url=document.getElementById("HiddenFieldPage_Name").value;
     var page=document.getElementById("HiddenFieldPage").value;
     changeIframeSrc('holder1',page_url,page);
     //Focus();
}
function calcHeight1()
{ 
  var the_height1=
    document.getElementById('holder1').contentWindow.
      document.body.scrollHeight;


  document.getElementById('holder1').height=
      the_height1;
}

</script>

<script type="text/javascript">
// <![CDATA[

function changeIframeSrc(id, url, text)
 { //alert(url);
     document.getElementById("Text1").value=text; 
    if (!document.getElementById) return;
    var el = document.getElementById(id);
    if (el && el.src) {
        el.src = url;
        return false;
    }
    return true;
}
// ]]>

//function Focus()
//{
//document.getElementById("holder1").focus();onload="Page_Name()"

//}
</script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:HiddenField ID="HiddenFieldPage_Name" runat="server" />
    <asp:HiddenField ID="HiddenFieldPage" runat="server" />
   
 

<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td  valign="top" class="leftnav"><ul class="tabs_left">
<li><a href=Employee_Basic_info_edit.aspx  onclick="return changeIframeSrc('holder1', this.href, this.innerHTML)">Personal Information</a></li>
<li><a href=Certification.aspx onclick="return changeIframeSrc('holder1', this.href, this.innerHTML)">Certifications</a></li>
<li><a href=Professional_Courses.aspx onclick="return changeIframeSrc('holder1', this.href, this.innerHTML)">Professional Courses</a></li>
<li><a href=Workshops_Seminar.aspx onclick="return changeIframeSrc('holder1', this.href, this.innerHTML)">Workshop/Seminar</a></li>
<li><a href=Education.aspx onclick="return changeIframeSrc('holder1', this.href, this.innerHTML)">Education</a></li>
<li><a href=skills.aspx onclick="return changeIframeSrc('holder1', this.href, this.innerHTML)">Skills</a></li>
<li><a href=Additional_Info.aspx onclick="return changeIframeSrc('holder1', this.href, this.innerHTML)">Additional Information</a></li>
<li><a href=Job_Experience.aspx onclick="return changeIframeSrc('holder1', this.href, this.innerHTML)">Job Experience</a></li>
<li><a href=Other_Documents.aspx onclick="return changeIframeSrc('holder1', this.href, this.innerHTML)">Other Documents</a></li>
<li><a href=change_name.aspx onclick="return changeIframeSrc('holder1', this.href, this.innerHTML)">Change Name of DOC.</a></li>
<li><a href=Search_Documents.aspx onclick="return changeIframeSrc('holder1', this.href, this.innerHTML)">Search Documents</a></li>


</ul></td>
      <td style="width:auto;" valign="top">
        
 

<iframe src="Application.aspx" name="holdit2" width="98%" marginwidth="0" height="400" marginheight="0" 
scrolling="No" frameborder="0" id="holder1" onload="calcHeight1();" allowtransparency="true"></iframe>

 
 
 
  <br />
  <br /></td>
    </tr>
  </table>


 


 


   
        





 </asp:Content>
