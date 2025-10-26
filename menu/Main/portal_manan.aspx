<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>

<link rel="stylesheet" href="css/page.css" type="text/css"  media="screen, projection">
<link rel="stylesheet" href="css/reset.css" type="text/css"  media="screen, projection">
<link rel="stylesheet" href="css/print.css" type="text/css" media="print">
 
<!--[if IE]><link rel="stylesheet" href="css/ie.css" type="text/css" media="screen, projection"><![endif]-->
<link rel="icon" href="images/favicon.ico" type="image/x-icon">
<script src="SpryAssets/SpryCollapsiblePanel.js" type="text/javascript"></script>
<link href="SpryAssets/SpryCollapsiblePanel.css" rel="stylesheet" type="text/css" />

<script language="JavaScript">

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

/* Free code from dyn-web.com */

// Two choices for loading new pages into the iframe 

function changeIframeSrc(id, url) { 
    if (!document.getElementById) return;
    var el = document.getElementById(id);
    if (el && el.src) {
        el.src = url;
        return false;
    }
    return true;
}
// ]]>
</script>


</head>

<body>

<div id="allcontent" class="container">

<div id="name"   class="span-18 info_h">Welcome ! &nbsp;<span class="txt_black">Mr. Qammar Pervaiz Ch.</span></div>
<div id="date" 	 class="span-6 last date">Friday, May 23, 2008</div>
<div id="header" class="span-24 header_bg"></div>

<div id="toolbar" 	class="span-24 toolbar">
<ul>
<li><a href="#">Home</a></li>
<li><a href="#">About Us</a></li>
<li><a href="#">Gray Theme</a></li>
<li><a href="#">White Theme</a></li>
<li><a href="#">Contact Us</a></li>
</ul>
</div><!--toolbar End-->


<div id="column_1" class="span-5">

<div id="navigation" class="navigation">
<ul>
<li><a href="#">Home</a></li>
<li><a href="Pt_EMR/form_Pt_Presenting_Complaint_new.aspx?PayId=412381&RegNo=232197204029043036036085050036036092036036036064&cmo=cmo" onclick="return changeIframeSrc('holder1', this.href)">Presenting Complaints</a></li>
<li><a href="Pt_EMR/form_pt_History_Main_Heading.aspx" onclick="return changeIframeSrc('holder1', this.href)">History</a></li>
<li><a href="Pt_EMR/form_Pt_Physical_Examination_Main_Head.aspx" onclick="return changeIframeSrc('holder1', this.href)">Physical Examination</a></li>
<li><a href="Pt_EMR/form_Pt_Diagnosis.aspx" onclick="return changeIframeSrc('holder1', this.href)">Provisional Diagnosis</a></li>
<li><a href="Pt_EMR/form_xray.aspx" onclick="return changeIframeSrc('holder1', this.href)">Investigation</a></li>
<li><a href="Pt_EMR/form_Pt_Medication.aspx" onclick="return changeIframeSrc('holder1', this.href)">Treatment</a></li>
<li><a href="Pt_EMR/form_Patient_Discharge.aspx" onclick="return changeIframeSrc('holder1', this.href)">Disposal</a></li>
<li><a href="Pt_EMR/form_Pt_Info.aspx" onclick="return changeIframeSrc('holder1', this.href)">Patient Chart</a></li>
<li><a href="Pt_EMR/form_Call_to_Doctor.aspx" onclick="return changeIframeSrc('holder1', this.href)">Doctor Call</a></li>
<li><a href="LGH_Reports/form_MainReport.aspx" onclick="return changeIframeSrc('holder1', this.href)">Report</a></li>
<li><a href="LGH_Reports/form_Patient_Reports.aspx" onclick="return changeIframeSrc('holder1', this.href)">Print Reports</a></li>
<li><a href="Pt_EMR/form_patient_discharge.aspx" onclick="return changeIframeSrc('holder1', this.href)">Discharge Patients</a></li>
</ul>
</div>








</div><!--column_1 End-->



<div id="column_2" class="span-19 last">

<div id="CollapsiblePanel1" class="block_1" >

<h1 class="h1_1">Patient Information</h1>

<iframe src="form_basicinfo2.aspx" name="holdit" width="748" marginwidth="0" height="80" marginheight="0" 
scrolling="No" frameborder="0" id="holder2" allowtransparency="true"></iframe>

</div>

</div><!--column_2 End-->



<div id="column_3" class="span-19 last">

<div id="block_info_4" class="block_1">
<h1 class="h1_1">Patient Treatment</h1>

<iframe src="main.html" name="holdit2" width="748" marginwidth="0" height="100" marginheight="0" 
scrolling="No" frameborder="0" id="holder1" onload="calcHeight1();" allowtransparency="true"></iframe>

</div>

</div><!--column_3 End-->




<div id="footer" class="footer">Copyright 2008 - . All rights reserved.</div>

</div><!--allcontent End-->

<script type="text/javascript">var CollapsiblePanel1 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel1", {contentIsOpen:false});</script>


</body>
</html>
