<%@ page language="VB" autoeventwireup="false" inherits="Portal_msview, App_Web_ppbttiod" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Shaikh Zayed Medical Complex</title>

<link href="css/class_reset.css" rel="stylesheet" 	 type="text/css" />
<link href="css/class_elements.css" rel="stylesheet" type="text/css" />
<!--[if IE]><link rel="stylesheet" href="css/class_ie.css" type="text/css" media="screen, projection"><![endif]-->
<!--[if lte IE 6]><script type="text/javascript" src="css/js/fixn.js"></script><![endif]-->


<link rel="icon" href="favicon.ico" type="image/x-icon">

<link href="menu/style-office-1.css" rel="stylesheet" type="text/css"/>



<style type="text/css"> 
* html legend { margin:0px 0px 0px 0; padding:0; }


 .Grid_new { 
	border:solid 1px #bbcce1; 
	border-collapse:collapse; 
	background-color:#FFFFF; 
} 
.Grid_new th { 
	border:solid 1px #bbcce1; 
	border-bottom:0px; 
	border-collapse:collapse; 
	font-family:tahoma; 
	padding: 0px; 
	font-size:11px; 
	height:25px; 
	background-position:bottom; 
	padding-left:5px; 
	background-color:#cfe2f5; font-weight:bold; 
} 

.Grid_new td{ 
	border:solid 1px #bbcce1;  
	border-collapse:collapse; 
	font-family:tahoma; 
	padding: 3px; 
	font-size:11px; 
	height:15px; 
	border-top:0px; 
	background-color:#FFFFF; 
	text-align:left;
} 

legend{color:#820e60;}

A.tree_1{color:#003399; font-weight:bold; text-decoration:underline;}
A.tree_1:hover{color:#333; font-weight:bold; text-decoration:none;}

A.tree_2{color:#4e7d06; font-weight:normal; text-decoration:underline; background-image:url(images/nav-arrow-right-hover.gif); background-position:left; background-repeat:no-repeat; padding-left:15px;}
A.tree_2:hover{color:#0173ab; font-weight:bold; text-decoration:none;}

#c1 {width:300px;}
#c2 {width:310px;}
#c3 {width:300px;}
</style>

<script src="css/js/scripts/AC_RunActiveContent.js" type="text/javascript"></script>



</head>

<body ><form id="form1" runat="server">

<div id="bottom">
<div id="container">					

<div id="header">

<div id="logo_title"><a href="index.aspx"><img src="images/szmc_title_logo_app.gif" alt="HACIMS + { Sheikh Zayed Medical Complex, Lahore }" /></a><!--logo_title end--></div>
<div id="efct"><img src="images/szmc_eft.jpg" /></div>





<div id="nav_btns" >
<ul class="nav_btns">
<li><span><img src="images/szmc_key1.png" class="loginicon" width="15" height="14"    /></span><a href="login.aspx" class="link_login">Logout</a></li>
<li class="welcome"><span><img src="images/szmc_welcome.png" class="welcomeicon" width="13" height="16" /></span>Welcome ! <span class="name"><asp:Label ID="LabelDoctorName" runat="server"
        ></asp:Label>&nbsp;&nbsp;[ <asp:Label ID="Label_SubDepartment" runat="server"></asp:Label> ]</span></li>
<li class="date"><span ><img src="images/szmc_date.png" class="dateicon" width="9" height="11" /></span><asp:Label
            ID="LabelDate" runat="server"></asp:Label></li>
</ul>
<!--nav_btns end--></div>


<!--header end--></div>

<div id="page_border">

<div id="bar" align="left"> 	



<!--bar end--></div>


<div id="inner_content">				

<div id="main_col"> 	

<div class="mainbox">
<span class="mainboxtop"></span>
<span class="mid_data" style="height:570px;" >

<h1 class="heading_1">Administration &raquo; <span>MS Main Area</span></h1>
<br class="break"  />

<div id="c1">

<fieldset class="c1_fset" ><legend><strong>Budget Allocated</strong></legend>
<span>

</span>
</fieldset>

<fieldset class="c1_fset" ><legend><strong>Expenditure</strong></legend>
<span>
</span>
</fieldset>





<fieldset class="c1_fset" ><legend><strong>Receivable</strong></legend>
<span>
</span>
</fieldset>


<fieldset class="c1_fset" ><legend><strong>Bank Accounts</strong></legend>
<span>
</span>
</fieldset>



</div><!--c1 end-->
<div id="c2">

<fieldset class="c2_fset" ><legend><strong>Employee</strong></legend>
<span>



</span>
</fieldset>
<fieldset class="c2_fset" ><legend><strong>New Vacancies</strong></legend>
<span>
</span>
</fieldset>

<fieldset class="c2_fset" ><legend><strong>Transfer In / Transfer Out</strong></legend>
<span>
</span>
</fieldset>


</div><!--c2 end-->

<div id="c3">

<fieldset class="c3_fset" ><legend><strong>OPD</strong></legend>
<span>
<div align="center">
<script type="text/javascript">
AC_FL_RunContent( 'codebase','http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0','width','275','height','300','src','allcharts/FCF_Doughnut2D','quality','high','flashvars','&dataURL=data.xml&chartWidth=275&chartHeight=300','pluginspage','http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash','wmode','transparent','movie','allcharts/FCF_Doughnut2D' ); //end AC code
</script><noscript><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0" width="275" height="300">
  <param name="movie" value="allcharts/FCF_Doughnut2D.swf" />
  <param name="FlashVars" value="&amp;dataURL=data.xml&amp;chartWidth=275&amp;chartHeight=300" />
  <param name="quality" value="high" />
  <param name="wmode" value="transparent" />
  
  <embed src="allcharts/FCF_Doughnut2D.swf" width="275" height="300" quality="high" flashVars="&amp;dataURL=data.xml&amp;chartWidth=275&amp;chartHeight=300" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash" wmode="transparent"></embed>
</object>
</noscript></div>
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource2" Width="260px" Visible="False">
            <Columns>
                <asp:BoundField DataField="Dept_Name" HeaderText="Department Name" SortExpression="Dept_Name" />
                <asp:BoundField DataField="Male" HeaderText="Male" SortExpression="Male" />
                <asp:BoundField DataField="Female" HeaderText="Female" SortExpression="Female" />
            </Columns>
            <HeaderStyle CssClass="GridHeader" />
            <AlternatingRowStyle CssClass="GridAltItem" />
        </asp:GridView>
<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" SelectCommand="SELECT     ISNULL(female.female, 0) AS Female, isnull(male.male,0 )AS Male, Department.Dept_Name&#13;&#10;FROM         Department LEFT OUTER JOIN&#13;&#10;                          (SELECT     COUNT(Payment_1.PayID) AS male, Patient_1.SexID, Payment_1.DeptID&#13;&#10;                            FROM          Payment AS Payment_1 INNER JOIN&#13;&#10;                                                   Patient AS Patient_1 ON Patient_1.RegNo = Payment_1.RegNo&#13;&#10;                            WHERE      (Patient_1.SexID = 1) AND (DATEPART(dd, Payment_1.DateTime) = DATEPART(dd, GETDATE())) AND (DATEPART(mm, &#13;&#10;                                                   Payment_1.DateTime) = DATEPART(mm, GETDATE())) AND (DATEPART(yyyy, Payment_1.DateTime) = DATEPART(yyyy, GETDATE())) AND &#13;&#10;                                                   (Payment_1.DeptID <> 6) AND (Payment_1.DeptID <> 18)&#13;&#10;                            GROUP BY Patient_1.SexID, Payment_1.DeptID) AS male ON Department.Dept_ID = male.DeptID LEFT OUTER JOIN&#13;&#10;                          (SELECT     COUNT(Payment_1.PayID) AS female, Patient_1.SexID, Payment_1.DeptID&#13;&#10;                            FROM          Payment AS Payment_1 INNER JOIN&#13;&#10;                                                   Patient AS Patient_1 ON Patient_1.RegNo = Payment_1.RegNo&#13;&#10;                            WHERE      (Patient_1.SexID = 2) AND (DATEPART(dd, Payment_1.DateTime) = DATEPART(dd, GETDATE())) AND (DATEPART(mm, &#13;&#10;                                                   Payment_1.DateTime) = DATEPART(mm, GETDATE())) AND (DATEPART(yyyy, Payment_1.DateTime) = DATEPART(yyyy, GETDATE())) AND &#13;&#10;                                                   (Payment_1.DeptID <> 6) AND (Payment_1.DeptID <> 18)&#13;&#10;                            GROUP BY Patient_1.SexID, Payment_1.DeptID) AS female ON Department.Dept_ID = female.DeptID&#13;&#10;WHERE     (Department.Dept_ID <> 6) AND (Department.Dept_ID <> 18)&#13;&#10;GROUP BY female.female, male.male, Department.Dept_Name&#13;&#10;having  female.female > 0 or  male.male > 0">
    </asp:SqlDataSource>
</span>
</fieldset>
<fieldset class="c3_fset" ><legend><strong>Wards</strong></legend>
<span>

</span>
</fieldset>

<fieldset class="c3_fset" ><legend><strong>Radiology</strong></legend>
<span>
</span>
</fieldset>

<fieldset class="c3_fset" ><legend><strong>Pathology</strong></legend>
<span> <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" Width="100%">
            <Columns>
                <asp:TemplateField HeaderText="Total Test Assign" SortExpression="TotalTestAssign">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("TotalTestAssign") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("TotalTestAssign") %>' Visible="False"></asp:Label>
                        <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Select" Font-Underline="False"
                            PostBackUrl="http://imran/pathology/Pathology Reports/Today_Patient_Report_MS.aspx"
                            Text='<%# Bind("TotalTestAssign") %>'></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Test Done" SortExpression="TestDone">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("TestDone") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("TestDone") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <HeaderStyle CssClass="GridHeader" />
            <AlternatingRowStyle CssClass="GridAltItem" />
        </asp:GridView> <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" SelectCommand="SELECT     COUNT(DISTINCT PatientsLabTest.PayID) AS [TotalTestAssign],[Test_Done].Expr1 as [TestDone]&#13;&#10;FROM         PatientsLabTest CROSS JOIN&#13;&#10;                          (SELECT     COUNT(YearlyNo) AS Expr1, DATEPART(dd, GETDATE()) AS Day&#13;&#10;                            FROM          Path_PatientTestResult_Main&#13;&#10;                            WHERE      (DATEPART(dd, trDate) = DATEPART(dd, GETDATE())) and (DATEPART(mm, trDate) = DATEPART(mm, GETDATE())) and (DATEPART(yyyy, trDate) = DATEPART(yyyy, GETDATE()))) AS [Test_Done]&#13;&#10;WHERE     (DATEPART(dd, PatientsLabTest.DateTime) = DATEPART(dd, GETDATE())) and (DATEPART(mm, PatientsLabTest.DateTime) = DATEPART(mm, GETDATE())) and (DATEPART(yyyy, PatientsLabTest.DateTime) = DATEPART(yyyy, GETDATE())) &#13;&#10;GROUP BY [Test_Done].Expr1">
    </asp:SqlDataSource>
</span>
</fieldset>



</div><!--c3 end-->








<br />
<br class="break"/>

</span>
<span class="mainboxbottom"></span>

<!--mainbox end--></div>
<!--main_col end--></div>





<!--inner_content end--></div>

<!--page_border end--></div>

<div id="footer"> 

<span>Powered by <a href="http://www.e-government.gov.pk/" target="_blank" class="copyright">Electronic Government Directorate (EGD)</a> </span> 
<span class="ri"> &copy; Oratier Technologies (Pvt.) Ltd - All Rights Reserved.</span>

<!--footer end--></div>

<!--container end--></div>

<!--bottom end--></div>

</form>
</body>
</html>
