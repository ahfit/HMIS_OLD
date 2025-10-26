<%@ control language="VB" autoeventwireup="false" inherits="CalendarControls, App_Web_rbfdm1yf" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />

<asp:TextBox id="TextBox1" runat="server"  CssClass="d-active_small" Width="145px" ReadOnly="True"></asp:TextBox>
  <INPUT type="button" value="..." onclick="OnClick()"><br>
<div id="divCalendar" style="display : none; POSITION: absolute">
    
<igsch:WebCalendar ID="Calendar1" runat="server" Height="86px" Width="121px" style="visibility: visible">
    <Layout AllowNull="False" NextMonthImageUrl="ig_cal_blueN0.gif" PrevMonthImageUrl="ig_cal_blueP0.gif"
        ShowFooter="False" TitleFormat="Month" ShowTitle="False">
        <TodayDayStyle BackgroundImage="ig_cal_blue1.gif" />
        <FooterStyle BackgroundImage="ig_cal_blue2.gif" Font-Size="8pt" ForeColor="#505080"
            Height="16pt" />
        <SelectedDayStyle BackgroundImage="ig_cal_blue2.gif" ForeColor="White" />
        <DayStyle BackgroundImage="ig_cal_blue3.gif" BorderColor="SteelBlue" BorderStyle="Solid"
            BorderWidth="1px" />
        <NextPrevStyle BackgroundImage="ig_cal_blue1.gif" />
        <OtherMonthDayStyle ForeColor="SlateGray" />
        <DayHeaderStyle BackgroundImage="ig_cal_blue2.gif" Font-Bold="True" Font-Size="8pt"
            ForeColor="#606090" Height="1pt" />
        <TitleStyle BackColor="#CCDDFF" BackgroundImage="ig_cal_blue1.gif" Font-Bold="True"
            Font-Size="10pt" ForeColor="#505080" Height="18pt" />
        <CalendarStyle BackColor="#CCDDFF" BorderColor="SteelBlue" BorderStyle="Solid" BorderWidth="1px"
            Font-Bold="False" Font-Italic="False" Font-Names="Verdana" Font-Overline="False"
            Font-Size="9pt" Font-Strikeout="False" Font-Underline="False" Height="86px"
            Width="121px">
        </CalendarStyle>
    </Layout>
    <AutoPostBack ValueChanged="True" />
</igsch:WebCalendar>
&nbsp;</div>
<script>
function OnClick()
{
  if( divCalendar.style.display == "none")
    divCalendar.style.display = "";
  else
   divCalendar.style.display = "none";
}
</script>

