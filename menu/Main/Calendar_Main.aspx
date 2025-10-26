<%@ page language="VB" autoeventwireup="false" inherits="Calendar_Main, App_Web_rbfdm1yf" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>

<%@ Register Assembly="Infragistics2.WebUI.WebSchedule.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="ig_sched" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    
    <script language ="javascript" type ="text/javascript" >
    function Visible_Subject_Div(time)
    {
        document.getElementById("DIV_SUbject").style.visibility="visible";
        document.getElementById("DIV_SUbject").style.left=window.status=event.clientX+20;
        document.getElementById("DIV_SUbject").style.top=window.status=event.clientY-20;
        document.getElementById("TextBox_Start_Time").value = document.getElementById("HiddenField_Start_Date").value + " " + time; //
        document.getElementById("HiddenField_Start_Time").value= time;
        return false;
    }
    function Visible_Subject_Update_Div_New()
    {
        document.getElementById("DIV_SUbject").style.visibility="visible";
        document.getElementById("DIV_SUbject").style.left=window.status=event.clientX+20;
        document.getElementById("DIV_SUbject").style.top=window.status=event.clientY-20;
        return false;
    }     
    function Visible_Subject_Update_Div(Subject,Location,Start_TIme,End_Time,Start_Date)
    {
        document.getElementById("DIV_SUbject").style.visibility="visible";
        document.getElementById("DIV_SUbject").style.left=window.status=event.clientX+20;
        document.getElementById("DIV_SUbject").style.top=window.status=event.clientY-20;
        document.getElementById("TextBox_Start_Time").value = document.getElementById("HiddenField_Start_Date").value ;
        document.getElementById("TextBox_Subject").value=Subject;
        document.getElementById("TextBox_Location").value=Location;
        //document.getElementById("TextBox_Start_Time").value
        document.getElementById("TextBox_End_Time").value=End_Time;
        //document.getElementById("HiddenField_Start_Time").value= time;
        return false;
    }    
    function Hide_Subject_Div()
    {
        document.getElementById("DIV_SUbject").style.visibility="hidden";
        Reset_Div();
        return false;
    }
    
    function Reset_Div()
    {
        document.getElementById("TextBox_Start_Time").value="";
        document.getElementById("TextBox_Subject").value="";
        document.getElementById("TextBox_Location").value="";
        document.getElementById("TextBox_Subject").value="";
    }
    function Validation()
    {
        if(document.getElementById("TextBox_Subject").value.length==0)
            {
            alert("Enter Subject");
            document.getElementById("TextBox_Subject").focus();
            return false;
            }
        if(document.getElementById("TextBox_Location").value.length==0)
            {
            alert("Enter Location");
            document.getElementById("TextBox_Location").focus();
            return false;
            }            
    }
    </script>

<link href="images/sheet_blue.css" rel="stylesheet" type="text/css" />
<link href="images/sheet_form.css" rel="stylesheet" type="text/css" />


<script src="images/highlight.js" type="text/javascript"></script>

<style type="text/css">
body{background-image:none; margin-top:0px; }
html{background-image:none;} 

</style>


</head>
<body>


    <form id="form1" runat="server">

<div id="forms_items" class="forms_items_calendar" >

<ul class="form_ul">

<li class="form_li"><asp:Label ID="Label2" runat="server" CssClass="err" ></asp:Label></li><br />
<br />


<li class="form_li"><label class="label_calendar">Select Date : </label>

<igsch:webdatechooser id="WebDateChooser1" runat="server" value="" Width="249" Style="margin-left:-100px;">
<ExpandEffects Type="Slide"></ExpandEffects>
<CalendarLayout PrevMonthImageUrl="ig_cal_blueP0.gif" TitleFormat="Month" AllowNull="False" NextMonthImageUrl="ig_cal_blueN0.gif" ShowYearDropDown="False" ShowMonthDropDown="False">
<TodayDayStyle BackgroundImage="ig_cal_blue1.gif"></TodayDayStyle>
<FooterStyle BackgroundImage="ig_cal_blue2.gif" ForeColor="#505080" Height="16pt" Font-Size="8pt"></FooterStyle>
<SelectedDayStyle BackgroundImage="ig_cal_blue2.gif" ForeColor="White"></SelectedDayStyle>
<DayStyle BackgroundImage="ig_cal_blue3.gif" BorderStyle="Solid" BorderWidth="1px" BorderColor="SteelBlue"></DayStyle>
<NextPrevStyle BackgroundImage="ig_cal_blue1.gif"></NextPrevStyle>
<OtherMonthDayStyle ForeColor="SlateGray"></OtherMonthDayStyle>
<DayHeaderStyle BackgroundImage="ig_cal_blue2.gif" ForeColor="#606090" Height="1pt" Font-Size="8pt" Font-Bold="True"></DayHeaderStyle>
<TitleStyle BackgroundImage="ig_cal_blue1.gif" ForeColor="#505080" BackColor="#CCDDFF" Height="18pt" Font-Size="10pt" Font-Bold="True"></TitleStyle>
<CalendarStyle BorderStyle="Solid" BorderWidth="1px" BorderColor="SteelBlue" BackColor="#CCDDFF" Font-Italic="False" Font-Size="9pt" Font-Names="Verdana" Font-Strikeout="False" Font-Underline="False" Font-Overline="False" Font-Bold="False"></CalendarStyle>
</CalendarLayout><AutoPostBack ValueChanged="True"></AutoPostBack></igsch:webdatechooser></li>

</ul>


<div id="DIV_SUbject" style="z-index: 101; position: absolute; visibility: hidden; border:#999999 solid 3px; padding:7px; background-color:#FFFFFF;" >

<ul class="form_ul"  >
<li class="form_li"><label class="label_calendar">Subject : </label><asp:TextBox ID="TextBox_Subject" runat="server" Width="248px" CssClass="input_txt"></asp:TextBox></li>
<li class="form_li"><label class="label_calendar">Location : </label><asp:TextBox ID="TextBox_Location" runat="server" Width="248px" CssClass="input_txt"></asp:TextBox></li>
<li class="form_li"><label class="label_calendar">Start From : </label><asp:TextBox ID="TextBox_Start_Time" runat="server" ReadOnly="True" Width="248px" CssClass="input_txt"></asp:TextBox></li>
<li class="form_li"><label class="label_calendar">End At : </label><igtxt:WebDateTimeEdit id="WebDateTimeEdit1" CssClass="input_txt" runat="server" editmodeformat="t" nullable="False" width="248px"> </igtxt:WebDateTimeEdit></li>

<li class="form_li"><label class="label_calendar"></label><asp:Button ID="Button_Save" runat="server" Text="Save" OnClientClick ="return Validation()" CssClass="btn1" />
<asp:Button ID="Button_Cancel" runat="server" Text="Cancel" OnClientClick="return Hide_Subject_Div()" CssClass="btn1" />
    <asp:Button ID="Button4" runat="server" Text="Add Attendies" CssClass="btn1" /></li></ul>
</div>




<asp:HiddenField ID="HiddenField_Start_Time" runat="server" />
<asp:HiddenField ID="HiddenField_Start_Date" runat="server" /><asp:HiddenField ID="HiddenField_App_ID" runat="server" />



<asp:Panel ID="Panel1" runat="server" Visible="False" CssClass="panel_1">

<li class="form_li"><label class="label_calendar">Subject : </label><asp:TextBox ID="TextBox_Subject1" runat="server" Width="248px" CssClass="input_txt"></asp:TextBox></li>

<li class="form_li"><label class="label_calendar">Location : </label><asp:TextBox ID="TextBox_Location1" runat="server" Width="248px" CssClass="input_txt"></asp:TextBox></li>

<li class="form_li"><label class="label_calendar">Start From : </label><asp:TextBox ID="TextBox_Start_Time1" runat="server" ReadOnly="True" Width="248px" CssClass="input_txt"></asp:TextBox></li>

<li class="form_li"><label class="label_calendar">End At : </label><igtxt:WebDateTimeEdit id="Webdatetimeedit2" runat="server" CssClass="input_txt" editmodeformat="t" nullable="False" width="248px"> </igtxt:WebDateTimeEdit></li>

<li class="form_li"><label class="label_calendar"></label><asp:Button ID="Button1" runat="server" Text="Update" CssClass="btn1" />
													<asp:Button ID="Button2" runat="server" Text="Cancel" OnClientClick="return Hide_Subject_Update_Div()" CssClass="btn1"/>
													<asp:Button ID="Button3" runat="server" Text="Remove" OnClientClick="return Hide_Subject_Update_Div()" CssClass="btn1"/></li>

</asp:Panel>





                    <asp:Table ID="Table1" runat="server" CssClass="tbl_01" Width="95%">
                        <asp:TableRow runat="server">
                            <asp:TableCell runat="server"></asp:TableCell>
                            <asp:TableCell runat="server"></asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow runat="server">
                            <asp:TableCell runat="server"></asp:TableCell>
                            <asp:TableCell runat="server"></asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow runat="server">
                            <asp:TableCell runat="server"></asp:TableCell>
                            <asp:TableCell runat="server"></asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow runat="server">
                            <asp:TableCell runat="server"></asp:TableCell>
                            <asp:TableCell runat="server"></asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow runat="server">
                            <asp:TableCell runat="server"></asp:TableCell>
                            <asp:TableCell runat="server"></asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow runat="server">
                            <asp:TableCell runat="server"></asp:TableCell>
                            <asp:TableCell runat="server"></asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow runat="server">
                            <asp:TableCell runat="server"></asp:TableCell>
                            <asp:TableCell runat="server"></asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow runat="server">
                            <asp:TableCell runat="server"></asp:TableCell>
                            <asp:TableCell runat="server"></asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow runat="server">
                            <asp:TableCell runat="server"></asp:TableCell>
                            <asp:TableCell runat="server"></asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>



</div>

    </form>
</body>
</html>
