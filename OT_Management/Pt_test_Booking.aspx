<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Pt_test_Booking.aspx.vb" Inherits="Pt_test_Booking" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Indus Lab</title>

<link href="css/css_reset.css" 	  rel="stylesheet" type="text/css" media="screen, projection"/>
<link href="css/css_elements.css" rel="stylesheet" type="text/css" media="screen, projection"/>
<!--[if IE]><link rel="stylesheet" href="css/css_ie.css" type="text/css" media="screen, projection"><![endif]-->
<link href="css/dropdown/dropdown.css" media="all" rel="stylesheet" type="text/css" />
<link href="css/dropdown/default.advanced.css" media="all" rel="stylesheet" type="text/css" />

<!--[if lt IE 7]>
<script type="text/javascript" src="css/js/jquery/jquery.js"></script>
<script type="text/javascript" src="css/js/jquery/jquery.dropdown.js"></script>
<![endif]-->
<style type="text/css">

.input_txt{height:22px;}

</style>

    <script language="javascript" type ="text/javascript" >
    function Other_Charges()
    {
    //window.open("Other_Charges.aspx","Mywindow","height=400,width=400");
    document.getElementById("DIV_Other").style.display="block";
    return false;
    }
    
    function Other_Charges_Done()
    {
       document.getElementById("DIV_Other").style.display="none";
    return false;
    }
    
    
    </script>

<script language="javascript" src="css/js/highlight.js"></script>
</head>




<body><form id="form1" runat = "server">

<div class="container">

<div class="header"><img src="images/lab_header.jpg" width="954" height="95" alt="MyLab" />
   <asp:Label ID="LabelHeader" runat="server" Text="Label"></asp:Label>
</div>

<div id="menubg" >
    <asp:Panel ID="PanelMenu" runat="server">
        <asp:Label ID="LabelMenu" runat="server"></asp:Label></asp:Panel></div>

<div class="content">
<span class="lab_top"></span>


<span class="rightside_main">
<h2><span> Main User Area&nbsp;&raquo;<span>Test Booking</span></span></h2>
<div class="content_all">


<asp:ScriptManager ID="ScriptManager2" runat="server">
                        <Services>
                       <asp:ServiceReference Path="AutoComplete.asmx" />
                        </Services>
                
                </asp:ScriptManager>


 <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                          <ContentTemplate>
                      <iframe id="holder1"  frameborder="0" name="holder1" scrolling="no" src="PatientBasicInfo_Iframe_New.aspx" style="width:100%; height:50px">
                      </iframe>
					 </ContentTemplate>
                      </asp:UpdatePanel>
<table>
 <tr>
                                      <td colspan="5" align="center" ><asp:Label ID="Label_VisitNo" runat="server" CssClass="err_box" ></asp:Label></td>
                                    </tr></table>
<asp:UpdatePanel ID="UpdatePanel6" runat="server">
                            <ContentTemplate>

<fieldset style="background-color:#f5f5f5;" >
                       <table width="100%" class="tbl_4" >
                                    <br style="line-height:5px;" />
                                   
      <tr>
                                        <td width="15%" align="right" >
                                        
                                            <strong>Registration No :&nbsp;</strong></td>
                                        <td width="30%" >
                                            <asp:TextBox ID="TextBox_RegNo" runat="server" CssClass="input_txt" ></asp:TextBox>
                        <asp:Button ID="Button_RegNo_Search" runat="server" Text="Search" CssClass="btn_1"  />
                        <asp:Label ID="Label3" runat="server" ></asp:Label></td>
                                        <td width="9%" align="right" >                                        </td>
                                        <td width="46%" colspan="2" >
                        <asp:Label ID="Label_Message" runat="server" CssClass="err"  ></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td align="right" >
                                            <strong>Referred By :&nbsp;</strong></td>
                                      <td >
                            <asp:DropDownList ID="DropDownList_Reffer" runat="server" DataSourceID="SqlDataSource_Reffer"
                                DataTextField="Reffered_Name" DataValueField="Reffer_ID" Width="177px" CssClass="dropdown" >                            </asp:DropDownList>
                            <asp:DropDownList ID="DropDownList_Lab" runat="server" DataSourceID="SqlDataSource_Lab"
                              DataTextField="Dept_Name" DataValueField="Dept_ID" Width="177px" CssClass="dropdown" AutoPostBack="True" Visible="False" > </asp:DropDownList></td>
                                        <td align="right" >
                                            <strong>Consultant :&nbsp;</strong></td>
                                        <td colspan="2" >
                            <asp:DropDownList ID="DropDownList_Consultant" runat="server" DataSourceID="SqlDataSource_Consultant"
                                DataTextField="Consultanat_Name" DataValueField="Consultanat_ID" CssClass="dropdown" >                            </asp:DropDownList><asp:TextBox ID="TextBox_Consultant" runat="server" CssClass="input_txt" Width="71px" style="height:20px;"></asp:TextBox>
                            <asp:Button ID="Button_Search_Consultant" runat="server" Text="Search" CssClass="btn_1" /></td>
                                    </tr>
                                    <tr>
                                        
                                      <td align="right" ><strong>Sample Collect by :&nbsp;</strong></td>
                                        <td align="left" ><asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal" style="font-family:tahoma; font-size:11px;">
                                          <asp:ListItem Selected="True">In lab.</asp:ListItem>
                                          <asp:ListItem>From Patient</asp:ListItem>
                                          <asp:ListItem>Sample To Come</asp:ListItem>
                                        </asp:RadioButtonList></td>
                                        <td colspan="2" >&nbsp;</td>
                                    </tr>
</table>
       </fieldset>                     </ContentTemplate>
                        </asp:UpdatePanel>
                   

<div id="mainleft">

<asp:UpdatePanel ID="UpdatePanel5" runat="server">
                            <ContentTemplate>

  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_4" style="margin-top:8px;">
  <tr>
    <td width="20%" align="right">Code :&nbsp;</td>
    <td width="80%"><asp:TextBox ID="TextBox_test_Code" runat="server" AutoPostBack="True" CssClass="input_txt" Width="175px" ></asp:TextBox></td>
  </tr>
  <tr>
    <td align="right">Name :&nbsp;</td>
    <td><asp:TextBox ID="TextBox_Name" runat="server" AutoPostBack="True" OnTextChanged="TextBox_Name_TextChanged" CssClass="input_txt" Width="175px"></asp:TextBox></td>
  </tr>
  <tr>
    <td align="right">Group :&nbsp;</td>
<td><asp:DropDownList ID="DropDownList_Test_Group" runat="server" AutoPostBack="True" CssClass="dropdown" Width="175px"
                            DataSourceID="SqlDataSource_Test_Group" DataTextField="TGName" DataValueField="TGID"
                            >
                        </asp:DropDownList></td>
  </tr>
</table>
 </ContentTemplate>
</asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                            <ContentTemplate>
<div style="width:97%; margin:0px; margin-left:10px; height:300px; overflow:scroll; overflow-x:hidden; overflow-y:scroll; vertical-align:top;">
                 
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="tbl_1"
                            DataKeyNames="TB_ID" DataSourceID="SqlDataSource_For_Test_Grid" Width="100%">
                            <Columns>
                                <asp:BoundField DataField="TB_Code" HeaderText="Code" SortExpression="TB_Code" />
                                <asp:ButtonField DataTextField="TB_Name" Text="Test Name" CommandName="Select" HeaderText="Test" />
                                <asp:TemplateField HeaderText="Price" SortExpression="Public_Price">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Public_Price") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("New_Rate", "{0}") %>'></asp:Label><br />
                                        <asp:HiddenField ID="HiddenField_Sample" runat="server" Value='<%# Bind("Specimen_Required_By_Test", "{0}") %>' />
                                        <asp:HiddenField ID="HiddenField_Name" runat="server" Value='<%# Bind("TB_Name", "{0}") %>' />
                                        <asp:HiddenField ID="HiddenField_Rate" runat="server" Value='<%# Bind("New_Rate", "{0}") %>' /><asp:HiddenField ID="HiddenField_ID" runat="server" Value='<%# Bind("TB_ID", "{0}") %>' />
                                        <asp:HiddenField ID="HiddenField_Day" runat="server" Value='<%# Bind("Test_Day", "{0}") %>' />
                                        <asp:HiddenField ID="HiddenField_Time" runat="server" Value='<%# Bind("Test_Time", "{0}") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="MG_ID" HeaderText="MG_ID" SortExpression="MG_ID" Visible="False" />
                                <asp:BoundField DataField="TB_ID" HeaderText="TB_ID" InsertVisible="False" ReadOnly="True"
                                    SortExpression="TB_ID" Visible="False" />
                            </Columns>
                            <RowStyle CssClass="GridItem" /><HeaderStyle CssClass="GridHeader" />
                           <AlternatingRowStyle CssClass="GridAltItem" />
                        </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource_For_Test_Grid" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="Test_Search" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="TextBox_test_Code" DefaultValue=" " Name="TB_Code"
                                        PropertyName="Text" />
                                    <asp:ControlParameter ControlID="DropDownList_Test_Group" DefaultValue="" Name="MG_ID"
                                        PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="TextBox_Name" DefaultValue=" " Name="TB_Name" PropertyName="Text"
                                        Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                       </ContentTemplate>
                        </asp:UpdatePanel>  &nbsp;
</div>

</div> 
<div id="mainmid">

<div style="width:97%; margin-left:10px; height:371px; overflow:scroll; overflow-x:hidden; overflow-y:scroll;">
                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                            <ContentTemplate>
                        <asp:GridView ID="GridView_TemP_Test" runat="server"
                            CssClass="tbl_2" Width="98%" ShowFooter="True">
                            <RowStyle CssClass="GridItem" />
                            <HeaderStyle CssClass="GridHeader" />
                            <AlternatingRowStyle CssClass="GridAltItem" />
                            <Columns>
                                <asp:ButtonField CommandName="Select" Text="Delete" />
                            </Columns>
                            <FooterStyle CssClass="GridHeader" />
                        </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
</div>





</div>

<div id="mainright">


<asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_4" >
  <tr><br />

    <td width="18%">&nbsp;&nbsp;
    <asp:Button ID="Button_Other_Charges" runat="server" OnClick="Button_Other_Charges_Click" OnClientClick="return Other_Charges()" Text="Other Charges" CssClass="btn_3" />&nbsp;</td>
    <td width="82%" align="left">&nbsp;
    <asp:Label ID="Label_other_Charges" runat="server" CssClass="err" >0</asp:Label></td>
  </tr>
</table>
                  
<table width="90%" border="0" cellspacing="0" cellpadding="0" class="tbl_4" style="margin:10px;">
 
  <tr>
    <td align="right"> Total :&nbsp;</td>
    <td>&nbsp;<asp:TextBox ID="TextBox_Grand_total" runat="server" BorderStyle="None" ReadOnly="True" CssClass="input_txt2" >0</asp:TextBox></td>
  </tr>
  <tr>
    <td align="right">Discount :&nbsp; </td>
<td>&nbsp;<asp:TextBox ID="TextBox_Grand_discount" runat="server" AutoPostBack="True" CssClass="input_txt" Width="50px" >0</asp:TextBox> <asp:DropDownList ID="DropDownList_Discount_Type" runat="server" AutoPostBack="True" Width="50px">
                                                <asp:ListItem>Rs.</asp:ListItem>
                                                <asp:ListItem>%age</asp:ListItem>
                                            </asp:DropDownList>
</td>
  </tr>
  <tr>
    <td align="right">Balance :&nbsp;</td>
    <td>&nbsp;<asp:TextBox ID="TextBox_Total_Price" runat="server" BorderStyle="None" CssClass="input_txt3"
 ReadOnly="true" >0</asp:TextBox></td>
  </tr>
</table>
                  
          

                                        

 

                                                


                                            
  
                                                
 </ContentTemplate>
                        </asp:UpdatePanel>




</div>



                           



                        




<div style="display:none;">
 
                        
Sample : <asp:TextBox ID="TextBox_Sample_number" runat="server" BorderStyle="None" CssClass="d-active"
                                        ReadOnly="True" Width="93px"></asp:TextBox>
                                        
Report Date :  <igsch:WebDateChooser ID="WebDateChooser1" runat="server" AllowNull="False" Value="">
                                        <CalendarLayout NextMonthImageUrl="ig_cal_blueN0.gif" PrevMonthImageUrl="ig_cal_blueP0.gif"
                                            ShowMonthDropDown="False" ShowYearDropDown="False" TitleFormat="Month">
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
                                                Font-Size="9pt" Font-Strikeout="False" Font-Underline="False">
                                            </CalendarStyle>
                                        </CalendarLayout>
                                    </igsch:WebDateChooser>
                                    
Collect After :  <asp:TextBox ID="TextBox_next_Date" runat="server" CssClass="d-active" Width="50px">0</asp:TextBox><asp:DropDownList ID="DropDownList1" runat="server" Width="67px">
                                        <asp:ListItem>Hours</asp:ListItem>
                                        <asp:ListItem>Days</asp:ListItem>
                                    </asp:DropDownList>
</div>                              
<br />

<asp:UpdatePanel
                ID="UpdatePanel8" runat="server">
                <ContentTemplate>
<br />

<div align="center" style="clear:both;">        <br />
      <asp:Button ID="ButtonSave" runat="server" Text="Submit"  TabIndex="24"  CssClass="btn_3" />
    <asp:Button ID="Button_Report" runat="server" Text="Submit & Report"  TabIndex="24"  CssClass="btn_3" OnClick="Button_Report_Click" /></div>
                            <asp:SqlDataSource ID="SqlDataSource_Reffer" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT Reffered_Name, Reffer_ID FROM Reffered_By">
                            </asp:SqlDataSource>
                    &nbsp;
                            <asp:SqlDataSource ID="SqlDataSource_Consultant" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT Consultanat_ID, Consultanat_Name FROM Consultanat_Name WHERE (Consultanat_Name LIKE '%' + @Consultanat_Name + '%')">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="TextBox_Consultant" DefaultValue="%" Name="Consultanat_Name"
                                        PropertyName="Text" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                    
                <asp:SqlDataSource ID="SqlDataSource_Test_Group" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT TGName, TGID FROM TestGroup">
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenField_Sample_collection" runat="server" />
                <asp:HiddenField ID="HiddenField_Report_Date" runat="server" />
                <asp:HiddenField ID="HiddenFieldMain_ID" runat="server" />
                <asp:HiddenField ID="HiddenFieldTotalAmount" runat="server" />
                <asp:HiddenField ID="HiddenFieldTotalPaid" runat="server" />
                            <asp:SqlDataSource ID="SqlDataSource_Lab" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT Dept_Name, Dept_ID FROM Department">
                            </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenFieldTotal_Discount" runat="server" />
                <asp:SqlDataSource ID="SqlDataSourceInsertSub" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                    InsertCommand="Insert_Pathology_Test_Total_Amount" InsertCommandType="StoredProcedure"
                    ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="&#13;&#10;">
                    <InsertParameters>
                        <asp:ControlParameter ControlID="HiddenFieldMain_ID" Name="Main_ID" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenFieldTotal_Discount" Name="TOtal_Discount"
                            PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenFieldTotalPaid" Name="Total_Paid" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenFieldTotalAmount" Name="Total_AMount" PropertyName="Value" />
                    </InsertParameters>
                </asp:SqlDataSource>
                </ContentTemplate>
            </asp:UpdatePanel>
    <asp:HiddenField ID="HiddenField_YearlyNo" runat="server" />
    <asp:Label ID="Label2" runat="server" Width="245px"></asp:Label>
            
            <br />
   
    <div id="DIV_Other" style="width:300px; position: absolute; height:300px; z-index: 100; background-color: white; display:none; border:#999999 solid 3px; top:55%; left:41%; right:45%; bottom:25%; 
    
   
    ">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin:10px;" class="tbl_4">
  <tr>
    <td width="12%" align="right">Description : </td>
    <td width="88%"><asp:TextBox ID="TextBox_Description" runat="server" CssClass="input_txt" Width="200px"></asp:TextBox></td>
  </tr>
  <tr>
    <td align="right">  Rate :</td>
    <td><asp:TextBox ID="TextBox_Rate" runat="server" CssClass="input_txt" Width="200px"></asp:TextBox></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><asp:Button ID="Button_Save" runat="server" Text="Save" CssClass="btn_1"  /><asp:Button ID="Button_Done" runat="server" OnClientClick="Other_Charges_Done()" Text="Done" CssClass="btn_1" OnClick="Button_Done_Click" /></td>
  </tr>

  <tr>
    <td colspan="2">                        <br />

 <asp:GridView ID="GridView12" runat="server" Width="100%" CssClass="tbl_1">
                        <Columns>
                            <asp:CommandField SelectText="Delete" ShowSelectButton="True" />
                        </Columns>
                        <RowStyle CssClass="GridItem" />
                        <HeaderStyle CssClass="GridHeader" />
                        <AlternatingRowStyle CssClass="GridAltItem" />
                    </asp:GridView></td>
  </tr>



</table>
  
<br />

                    
</ContentTemplate>
        </asp:UpdatePanel>
                       

</div>


</div>


<span class="lab_bot"></span>

</div>

<span id="footer"><a href="#" target="_blank">Copyright &copy; 2008  All rights reserved.</a></span>



<script type="text/javascript" src="images1/flash_01.js">Sub TABLE1_onclick() End Sub </script>
</form>
</body>


</html>
