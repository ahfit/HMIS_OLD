<%@ page language="VB" autoeventwireup="false" inherits="portal_doctormain, App_Web_rbfdm1yf" maintainscrollpositiononpostback="true" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>
</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Shaikh Zayed Medical Complex</title>

<link href="../css/class_reset.css" rel="stylesheet" 	 type="text/css" />
<link href="../css/class_elements.css" rel="stylesheet" type="text/css" />

<script alt ="" src="SpryAssets/new_spry/SpryCollapsiblePanel.js" type="text/javascript"></script>
<link href="SpryAssets/new_spry/SpryCollapsiblePanel.css" rel="stylesheet" type="text/css" />

<script src="SpryAssets/new_spry/SpryTabbedPanels.js" type="text/javascript"></script>
<link href="SpryAssets/new_spry/SpryTabbedPanels.css" rel="stylesheet" type="text/css" />
<link href="css/main.css" rel="stylesheet" type="text/css" />
<!--[if IE]><link rel="stylesheet" href="css/class_ie.css" type="text/css" media="screen, projection"><![endif]-->
<!--[if lte IE 6]><script type="text/javascript" src="css/js/fixn.js"></script><![endif]-->


<link rel="icon" href="../favicon.ico" type="image/x-icon">

<link href="menu/style-office-1.css" rel="stylesheet" type="text/css"/>



<style type="text/css"> 
* html legend { margin:0px 0px 0px 0; padding:0; }

body{ 

SCROLLBAR-FACE-COLOR: #e3e3e3; 

SCROLLBAR-HIGHLIGHT-COLOR: #fff; 
SCROLLBAR-SHADOW-COLOR: #ccc; 
SCROLLBAR-3DLIGHT-COLOR: #ccc; 
SCROLLBAR-ARROW-COLOR: #333; 
SCROLLBAR-TRACK-COLOR: #f2f2f2; 
SCROLLBAR-DARKSHADOW-COLOR: #9ea1a3; 
BACKGROUND-COLOR: #f3f3f3;

 }
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
A.tree_1{color:#003399; font-weight:bold; text-decoration:underline;}
A.tree_1:hover{color:#333; font-weight:bold; text-decoration:none;}

A.tree_2{color:#4e7d06; font-weight:normal; text-decoration:underline; background-image:url(images/nav-arrow-right-hover.gif); background-position:left; background-repeat:no-repeat; padding-left:15px;}
A.tree_2:hover{color:#0173ab; font-weight:bold; text-decoration:none;}

.mycalendar{border:#b2b2b2 solid 1px; width:200px;}
.mycalendar th {border:#b2b2b2 solid 1px; text-align:center; background-color:#d7eec3; font-weight:bold; font-size:9px;}
.mycalendar td {border:#b2b2b2 solid 1px; text-align:center;}
.mycalendar tr {border:#b2b2b2 solid 1px;}
.mycalendar a  {text-decoration:none; color:#003399;}
.mycalendar a:hover {text-decoration:none; color:#F48F20;}
.today{background-color:#87cefa; font-weight:bold;}

.doctor{ margin:0px; padding:0px; margin-bottom:-7px;}
.doctor ul { margin:0px; padding:0px; float:left;   }
.doctor li { list-style:none; color:#999999;  margin-top:5px; float:left; display:block;   }
.doctor .name { list-style:none; color:#0033FF; font-weight:bold;  float:left; clear:right; display:block; }
.doctor .pic {  }

h4{font-family:tahoma; font-weight:bold; color:#0033CC; font-size:11px; padding:0px; margin:0px; float:left; clear:right; } 
h2{font-family:tahoma; font-weight:normal; color:#999999; font-size:11px;  padding:0px; margin:0px; margin-top:5px; 
padding-bottom:15px; float:left; clear:both; } 

h3{padding:0px; margin:0px; float:right;  }  


#main{width:452px; margin:0 auto 0 auto; margin-top:5px; background-image:url(images/midbig.gif); background-position:top; background-repeat:repeat-y; }

.mytab_1 {margin:0px; padding:0px; padding:12px; }
.mytab_1 ul  { margin:0px; padding:0px; margin-left:-25px; }
.mytab_1 li { list-style:none; font-weight:normal; color:#333333; display:block; text-align:justify; margin-top:5px; border-bottom:#CCCCCC solid 1px; padding-bottom:7px; }
.mytab_1 li span { color:#1d96f3; font-weight:bold; }
.mytab_1 li .txt { color:#333; display:block; font-weight:normal; text-align:justify; margin-top:5px;    }
.mytab_1 li .txt_b { color:#333; display:block; font-weight:bold; text-align:justify; margin-top:5px;    }
.mytab_1 li .date { color:#999999; font-weight:normal; text-align:left; float:right; margin-top:-13px;     }



UL.blue1 {
	CLEAR: left; PADDING-RIGHT: 0px; MARGIN-TOP: 0px; PADDING-LEFT: 0px; FLOAT: left; PADDING-BOTTOM: 0px; MARGIN-LEFT: 5px; COLOR: #333; PADDING-TOP: 0px; FONT-FAMILY: tahoma; LIST-STYLE-TYPE: none; HEIGHT: 22px;  
}
UL.blue1 LI {
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FLOAT: left; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px;
}
UL.blue1 LI A {
	PADDING-RIGHT: 7px; PADDING-LEFT: 0px; FONT-WEIGHT: bold; FONT-SIZE: 11px; BACKGROUND: url(images/tb_normal.gif) no-repeat right top; FLOAT: left; PADDING-BOTTOM: 0px; COLOR: #fff; LINE-HEIGHT: 14px; MARGIN-RIGHT: 2px; PADDING-TOP: 4px; FONT-FAMILY: tahoma; HEIGHT: 22px; TEXT-DECORATION: none; outline: none; 
}
UL.blue1 LI A SPAN {
	PADDING-RIGHT: 7px; MARGIN-TOP: -4px; DISPLAY: block; BACKGROUND: url(images/tb_normal.gif) no-repeat left top; FLOAT: left; HEIGHT: 22px;
}
UL.blue1 LI A:hover {
	BACKGROUND: url(images/tb_hover.gif) no-repeat right top; COLOR: #333;
}
UL.blue1 LI A:hover SPAN {
	BACKGROUND: url(images/tb_hover.gif) no-repeat left top;
}
UL.blue1 LI.current A {
	BACKGROUND: url(images/tb_hover.gif) no-repeat right top; COLOR: #333;
}
UL.blue1 LI.current A SPAN {
	BACKGROUND: url(images/tb_hover.gif) no-repeat left top;
}

.hd{font-family:arial; font-size:13px; color:#4838e2; font-weight:bold; padding-left:15px; border-bottom:#CCCCCC solid 1px; display:block; padding-bottom:5px;   }




.mypanel {width:40%; position:absolute; border:#CCCCCC solid 3px; background-color:#FFFFFF; z-index:100; margin-top:-400px; margin-left:-400px;} 

</style>

<script language="javascript" type="text/javascript">
function showhide(id){
if (document.getElementById){
obj = document.getElementById(id);
if (obj.style.display == "none"){
obj.style.display = "";
} else {
obj.style.display = "none";
}
}
}




</script> 


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

  <asp:Label ID="LabelJavaMenu" runat="server"></asp:Label>

<!--bar end--></div>


<div id="inner_content">				

<div id="main_col"> 	

<div class="mainbox">
<span class="mainboxtop"></span>
<span class="mid_data">

<h1 class="heading_1">Administration &raquo; <span>Doctor Main Area<asp:ScriptManager
    ID="ScriptManager1" runat="server">
</asp:ScriptManager>
</span></h1>
<br class="break"  />

<div id="c1">

<fieldset class="c1_fset" ><legend><strong>Department</strong></legend>
<span>
Welcome to  a progressive, full service hospital offering advanced medical and surgical care as well as specialty support and outpatient services. Located in a Lahore, we are licensed for 272 beds, and admitted over 9,500 people for care and provided more than 111,000 visits for outpatient....
</span>
</fieldset>

<div id="col_1">

            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
            
</div>



<fieldset class="c1_fset" ><legend><strong>Doctor Call</strong></legend>
<span>
<asp:GridView ID="GridView_Doctor_Call" runat="server" Width="100%" AutoGenerateColumns="False" DataSourceID="SqlDataSource_DOCTOR_CALL" CssClass="Grid_new">
    <Columns>
        <asp:BoundField DataField="CallBY" HeaderText="Call BY" ReadOnly="True" SortExpression="CallBY" />
        <asp:BoundField DataField="CallByDepartment" HeaderText="Department" ReadOnly="True"
            SortExpression="CallByDepartment" />
        <asp:BoundField DataField="CallDate" HeaderText="Date" ReadOnly="True" SortExpression="CallDate" />
        <asp:BoundField DataField="CallTime" HeaderText="Time" ReadOnly="True" SortExpression="CallTime" />
    </Columns>
    <RowStyle CssClass="GridItem" />
    <AlternatingRowStyle CssClass="GridAltItem" />
</asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource_DOCTOR_CALL" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
        SelectCommand="Select_Doctor_Call_XML_New" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="" Name="Doctor_ID" SessionField="Emp_id" Type="Int32" />
            <asp:SessionParameter DefaultValue="Dept_id" Name="Call_To_Dept" SessionField="Dept_Id"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>


</span>
</fieldset>


<fieldset class="c1_fset" ><legend><strong>Duty Roster</strong></legend>
<span><asp:GridView ID="GridView_duty_Roster" runat="server" Width="100%" AutoGenerateColumns="False" DataSourceID="SqlDataSource_Duty_Roster" CssClass="Grid_new">
    <Columns>
        <asp:BoundField DataField="StartDuty_Date" HeaderText="Start Date" SortExpression="StartDuty_Date" />
        <asp:BoundField DataField="ENDDuty_Date" HeaderText="END Date" SortExpression="ENDDuty_Date" />
        <asp:BoundField DataField="Day_Name" HeaderText="Day" SortExpression="Day_Name" />
        <asp:BoundField DataField="ShiftName" HeaderText="Shift Name" SortExpression="ShiftName" />
        <asp:BoundField DataField="start_Time" HeaderText="Start Time" SortExpression="start_Time" />
        <asp:BoundField DataField="end_time" HeaderText="End Time" SortExpression="end_time" />
    </Columns>
    <HeaderStyle CssClass="GridHeader" />
    <RowStyle CssClass="GridItem" />
    <AlternatingRowStyle CssClass="GridAltItem" />
</asp:GridView>
 <asp:SqlDataSource ID="SqlDataSource_Duty_Roster" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDatainfoConnectionString %>"
        ProviderName="<%$ ConnectionStrings:BasicDatainfoConnectionString.ProviderName %>"
        SelectCommand="Select_Emp_Duty_Rouster" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" Type="Int32" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</span>
</fieldset>


<fieldset class="c1_fset" ><legend><strong>Calendar</strong></legend>
<span><iframe src="calendar_main.aspx" name="calendar" width="98%" marginwidth="0" height="225" marginheight="0" 
scrolling="yes" frameborder="0" id="calendar_1" allowtransparency="true"></iframe>
</span>
</fieldset>

</div><!--c1 end-->
<div id="c2">

<fieldset class="c2_fset" ><legend><strong>Calendar</strong></legend>
<span><asp:Calendar ID="Calendar2" runat="server" CssClass="mycalendar"  style="margin-left:17px;"><TodayDayStyle BackColor="LightSkyBlue" /></asp:Calendar><br style="line-height:5px;" />
</span>
</fieldset>
<fieldset class="c2_fset" ><legend><strong>Summary Report</strong></legend>
<span>
<asp:GridView ID="GridViewSummaryReport" runat="server" Width="100%" AutoGenerateColumns="False" CssClass="Grid_new">
    <Columns>
        <asp:BoundField DataField="Dept_Name" HeaderText="Department" SortExpression="Dept_Name">
            <ItemStyle Width="100px" />
        </asp:BoundField>
        <asp:BoundField DataField="ShiftName" HeaderText="Shift" SortExpression="ShiftName">
            <ItemStyle Width="50px" />
        </asp:BoundField>
        <asp:BoundField DataField="PatientCount" HeaderText="PatientCount" SortExpression="PatientCount">
            <ItemStyle Width="50px" />
        </asp:BoundField>
    </Columns>
    <RowStyle CssClass="GridItem" />
    <AlternatingRowStyle CssClass="GridAltItem" />
</asp:GridView>

</span>
</fieldset>
<fieldset class="c2_fset" ><legend><strong>Department</strong></legend>
<span><asp:Panel ID="Panel1" runat="server" CssClass="block_ul" Visible="False" ></asp:Panel>
<asp:TreeView ID="TreeView1" runat="server" ExpandDepth="1"   >
<ParentNodeStyle ></ParentNodeStyle>
<SelectedNodeStyle ></SelectedNodeStyle>
<RootNodeStyle CssClass="tree_1"  ></RootNodeStyle>
<LeafNodeStyle CssClass="tree_2" ></LeafNodeStyle>
<NodeStyle ></NodeStyle></asp:TreeView>

</span>
</fieldset>

<div id="main_box" style="background-image:url(images/mid_message.gif); background-position:top left; background-repeat:repeat-y;">

<span style="margin-top: 5px; display: block">
            <img src="images/top_message.gif" /></span>

        <div id="TabbedPanels1" class="TabbedPanels blue1">
            <ul class="TabbedPanelsTabGroup blue1">
                <li class="TabbedPanelsTab" tabindex="0"><a href="#"><span></span>Messages</a> </li>
                <li class="TabbedPanelsTab" tabindex="0"><a href="#"><span></span>Meetings</a> </li>
                <li class="TabbedPanelsTab" tabindex="0"><a href="#"><span></span>Reports</a> </li>
            </ul>
            <div class="TabbedPanelsContentGroup" style="margin-top: -4px; overflow-x: hidden;
                overflow: scroll; height: 259px">
                <div class="TabbedPanelsContent">
                    <asp:Label ID="Label_Message" runat="server" Text="Label"></asp:Label>
                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="link_web">New Message</asp:LinkButton></div>
                <div class="TabbedPanelsContent">
                    <asp:Label ID="LabelMeeting" runat="server" Text="Label"></asp:Label>
                    <asp:LinkButton ID="LinkButton2" runat="server" CssClass="link_web">New Meeting</asp:LinkButton></div>
                <div class="TabbedPanelsContent">
                    <asp:Label ID="LabelReport" runat="server" Text="Label"></asp:Label>
                </div>
            </div>
        </div>
        <span style="display: block; margin-bottom: 0px">
            <img src="images/bot_message.gif" /></span>
    </div>

<fieldset class="c2_fset" ><legend><strong>Orders</strong></legend>
    <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource1">
        <ItemTemplate>
            <asp:Label ID="Label6" runat="server" Visible="False"></asp:Label>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp;
            <asp:Label ID="Label3" runat="server" Text='<%# Eval("Date", "{0}") %>'></asp:Label><br />
            <asp:Label ID="Label2" runat="server" Text='<%# Eval("[Test Name]", "{0}") %>'></asp:Label>
            <asp:Label ID="Label4" runat="server" Text='<%# Eval("PFName", "{0}") %>' Visible="False"></asp:Label>
            <asp:Label ID="Label5" runat="server" Text='<%# Eval("PMName", "{0}") %>' Visible="False"></asp:Label>
            <asp:Label ID="Label1" runat="server" Text='<%# Eval("Prefix", "{0}") %>' Visible="False"
                Width="67px"></asp:Label>
        </ItemTemplate>
    </asp:DataList>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" SelectCommand="SELECT Patient.Prefix, Patient.PFName, Patient.PMName, Patient.PLName, Test_Booking.TB_Name AS [Test Name], Payment.PayID, CONVERT (varchar, Path_Result_Delivery.Report_Deliverd, 103) AS Date, Path_Result_Delivery.From_Dept_ID FROM Test_Booking_Services INNER JOIN Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID INNER JOIN Payment INNER JOIN Patient ON Payment.RegNo = Patient.RegNo ON Path_Result_Delivery.Yearly_No = Payment.PayID AND Path_Result_Delivery.Reg_no = Payment.RegNo INNER JOIN Test_Booking ON Test_Booking_Services.TB_ID = Test_Booking.TB_ID WHERE (Test_Booking_Services.Status = 6) AND (Path_Result_Delivery.From_Dept_ID = @Dept_ID)">
        <SelectParameters>
            <asp:SessionParameter Name="Dept_ID" SessionField="dept_id" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="Label7" runat="server"></asp:Label><span></span></fieldset>



</div><!--c2 end-->

<div id="c3">

<fieldset class="c3_fset" ><legend><strong>Picture</strong></legend>
<span>

<div align="center"><asp:ImageButton ID="ImageButton_employee_Picture" runat="server" Height="121px"
        Width="110px" ImageUrl="images/picture.jpg" /></div>
</span>
</fieldset>
<fieldset class="c3_fset" ><legend><strong>News &amp; Events</strong></legend>
<span>
<iframe id="news" src="news.html" width="222" height="222" frameborder="0" scrolling="no" allowtransparency="true"  ></iframe>
</span>
</fieldset>
    &nbsp;

</div><!--c3 end-->








<br />
<br class="break"/>
    &nbsp;<%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>
<asp:Panel ID="PanelMessage" runat="server"  Visible="False" CssClass="mypanel" >
<fieldset style="border:0px; border-top:#666666 solid 1px; " ><legend style="color:#3333FF;"><strong>Messages</strong></legend>
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td width="35%" align="right" ><strong> Message Text :&nbsp; </strong></td>
            <td width="65%" colspan="3" align="left">  <asp:TextBox ID="TextBoxMessageText" CssClass="input_txt" runat="server"></asp:TextBox></td>
  </tr>
        <tr>
            <td align="right" >
              <strong>Message Date :&nbsp; </strong></td>
            <td colspan="3" align="left"> <igsch:WebDateChooser ID="WebDateChooser1" runat="server" Width="184px">
                    <CalendarLayout Culture="English (United Kingdom)">                    </CalendarLayout>
                </igsch:WebDateChooser>            </td>
        </tr>
        <tr>
            <td align="right" ><strong>Message To :&nbsp;</strong></td>
            <td colspan="3" align="left">
                <asp:DropDownList ID="DropDownListDepartment" runat="server" AutoPostBack="True" 
                    DataSourceID="SqlDataSourceDept" DataTextField="Dept_Name" DataValueField="Dept_ID"
                    Width="184px">                </asp:DropDownList></td>
        </tr>
        <tr>
            <td colspan="4" align="left">
               <div style="height:200px; overflow:scroll; overflow-x:hidden; margin-left:10px; margin-top:10px; margin-bottom:7px;"> <asp:CheckBoxList ID="CheckBoxListEmployee" runat="server" DataSourceID="SqlDataSourceMessageTo"
                    DataTextField="Name" DataValueField="EmpID" RepeatColumns="2" RepeatDirection="Horizontal">
                 </asp:CheckBoxList>
               </div></td>
            </tr>
        
        <tr>
            <td colspan="4" align="center" style="height: 48px" >            
                <asp:Button ID="ButtonAdd" runat="server" Text="Add" CssClass="btn_1"   />                
            <asp:Button ID="ButtonSave" runat="server" CssClass="btn_1" Text="Save"  />                                <asp:Button ID="Button2" runat="server" Text="Close" CssClass="btn_1"/></td>
        </tr>
    </table>
    

</fieldset>
</asp:Panel>
       <%-- </ContentTemplate>
    </asp:UpdatePanel>--%>
   <%-- <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>--%>

<asp:Panel ID="PanelMeeting" runat="server" CssClass="mypanel"  Visible="False" >
<fieldset style="border:0px; border-top:#666666 solid 1px; "><legend style="color:#3333FF;"><strong>Meeting</strong></legend>
    <table  cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td width="22%" align="right" ><strong>
              Subject :&nbsp;</strong></td>
            <td >
                <asp:TextBox ID="TextBoxMeetingSub" runat="server" CssClass="input_txt" ></asp:TextBox></td>
        </tr>
        <tr>
            <td align="right" ><strong>
              Location :&nbsp;</strong></td>
            <td >
                <asp:TextBox ID="TextBoxMeetLoc" runat="server" CssClass="input_txt"></asp:TextBox>            </td>
        </tr>
        <tr>
            <td align="right" ><strong>
              Date :&nbsp;</strong></td>
            <td >
                <igsch:WebDateChooser ID="WebDateChooserMeetingDate" runat="server" Width="184px">                </igsch:WebDateChooser>                        </td>
        </tr>
        <tr>
            <td align="right" ><strong>
              Start Time :&nbsp;</strong></td>
            <td >
                <igtxt:WebDateTimeEdit ID="WebDateTimeEditMeetingStart" runat="server" EditModeFormat="t" Width="181px"  CssClass="input_txt" >                </igtxt:WebDateTimeEdit>                        </td>
        </tr>
        <tr>
            <td align="right" ><strong>
              End Time :&nbsp;</strong></td>
            <td >
                <igtxt:WebDateTimeEdit ID="WebDateTimeEditMeetingEnd" runat="server" EditModeFormat="t" Width="181px"  CssClass="input_txt">                </igtxt:WebDateTimeEdit>                        </td>
        </tr>
        <tr>
            <td align="right" ><strong>
              ChairPerson :&nbsp;</strong></td>
            <td s>
                <asp:DropDownList ID="DropDownListChairPerson" runat="server" DataSourceID="SqlDataSourceChairPerson"
                    DataTextField="Name" DataValueField="EmpID" Width="184px">                </asp:DropDownList></td>
        </tr>
        <tr>
            <td align="right" ><strong>
              Attendies :&nbsp;</strong></td>
            <td >
                <asp:DropDownList ID="DropDownListMeetingDept" runat="server" DataSourceID="SqlDataSourceDept"
                    DataTextField="Dept_Name" DataValueField="Dept_ID" Width="182px" AutoPostBack="True">                </asp:DropDownList></td>
        </tr>
        <tr>
            <td colspan="2" >   
            
            <div style="height:150px; overflow:scroll; overflow-x:hidden; margin-left:10px; margin-top:10px; margin-bottom:7px;">          
            <asp:CheckBoxList ID="CheckBoxListAttendies" runat="server" DataSourceID="SqlDataSourceAttendies"
                    DataTextField="Name" DataValueField="EmpID" RepeatColumns="2" >                </asp:CheckBoxList></div>
                    
                    
                    </td>
        </tr>
        <tr>
            <td colspan="2" align="center" >
            
                <asp:Button ID="ButtonAddAttendies" runat="server" Text="Add Addendies " CssClass="btn_2" />                
                <asp:Button ID="ButtonSaveMeeting" runat="server" Text="Save"  CssClass="btn_1"/>                
            <asp:Button ID="Button1" runat="server" Text="Close" CssClass="btn_1" /></td>
        </tr>
    </table>

    <asp:SqlDataSource ID="SqlDataSourceChairPerson" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT EmpID, ISNULL(Prefix, '') + ' ' + ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS Name FROM Employee ORDER BY Name">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceAttendies" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT EmpID, ISNULL(Prefix, '') + ' ' + ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS Name FROM Employee WHERE (DeptID = @DeptID) ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListMeetingDept" Name="DeptID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldMeetingAttendies" runat="server" />
    <asp:HiddenField ID="HiddenFieldMeetingDate" runat="server" />
    <asp:HiddenField ID="HiddenFieldStartTime" runat="server" />
    <asp:HiddenField ID="HiddenFieldEndTime" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourceInsert_MeetingMain" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        InsertCommand="Insert_Meeting_Main" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:ControlParameter ControlID="TextBoxMeetingSub" Name="Subject" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="TextBoxMeetLoc" Name="Location" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="HiddenFieldStartTime" Name="Start_Time" PropertyName="Value"
                Type="DateTime" />
            <asp:ControlParameter ControlID="HiddenFieldEndTime" Name="End_Time" PropertyName="Value"
                Type="DateTime" />
            <asp:ControlParameter ControlID="HiddenFieldMeetingDate" Name="Start_Date" PropertyName="Value"
                Type="DateTime" />
            <asp:ControlParameter ControlID="DropDownListChairPerson" Name="ChairmanShip_ID"
                PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Direction="Output" Name="Meeting_Id" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceIsert_MeetingSub" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" InsertCommand="Insert_Meeting_Sub" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenFieldMeetingAttendies" Name="Emp_ID" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="HiddenFieldMeetingID" Name="Meeting_ID" PropertyName="Value"
                Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldMeetingID" runat="server" />
    <asp:HiddenField ID="HiddenFieldAttendiesID" runat="server" />
</fieldset>
    </asp:Panel>
      <%--  </ContentTemplate>
    </asp:UpdatePanel>--%>
    &nbsp;



    <asp:SqlDataSource ID="SqlDataSourceMessageTo" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT EmpID, ISNULL(Prefix, '') + ' ' + ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS Name FROM Employee WHERE (DeptID = @DeptID) ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListDepartment" Name="DeptID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDept" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT Dept_ID, Dept_Name FROM Department"></asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldMessageToStr" runat="server" />
    <asp:HiddenField ID="HiddenFieldDate" runat="server" />
    <asp:HiddenField ID="HiddenFieldMessage_ID" runat="server" />
    <asp:HiddenField ID="HiddenFieldMessageTo" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourceInsert_Message_Main" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        InsertCommand="Insert_Emp_Message_Main" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:ControlParameter ControlID="TextBoxMessageText" Name="Msg_text" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="HiddenFieldDate" Name="Msg_Date" PropertyName="Value"
                Type="DateTime" />
            <asp:SessionParameter Name="By_Emp" SessionField="emp_id" Type="Int32" />
            <asp:Parameter DefaultValue="1" Name="Msg_Type" Type="Int32" />
            <asp:Parameter DefaultValue="" Direction="InputOutput" Name="Message_Id" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceInsert_Message_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        InsertCommand="Insert_Emp_Message_Sub" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenFieldMessage_ID" Name="Msg_Id" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="HiddenFieldMessageTo" DefaultValue="" Name="Emp_To"
                PropertyName="Value" Type="Int32" />
            <asp:Parameter DefaultValue="true" Name="Msg_Status" Type="Boolean" />
        </InsertParameters>
    </asp:SqlDataSource>
    </span><br />

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
<asp:label id ="LabelEnd" runat="server"></asp:label>
<script type="text/javascript">
<!--
var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1");
//-->
</script>
</body>
</html>
