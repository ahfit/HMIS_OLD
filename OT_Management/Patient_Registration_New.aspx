<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Patient_Registration_New.aspx.vb" MasterPageFile="~/hacims_masterpage_admin.master" Inherits="Patient_Registration_New" EnableEventValidation="false" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

<script type ="text/javascript"  language="javascript">
function main(a)
{
}
function show(a)
{
    document.form1.sex.value=1
    document.form1.RBLrelation_0.checked=true

    if(document.form1.RBLprefix_1.checked)
        {
        document.form1.sex.value=2
        document.form1.RBLrelation_1.checked=true
        }

    if(document.form1.RBLprefix_2.checked)
        {
        document.form1.sex.value=2
        document.form1.RBLrelation_2.checked=true
        }
}

function resetform() 
{
    document.form1.reset();
    document.getElementById("dropdownlistdiagnosis").focus(); 
}

function showFocus(a)
{
    document.getElementById("dropdownlistdiagnosis").disabled =true;
}

function showFocus1(a)
{
    if(a.value.length!=0)
        {
        document.getElementById("dropdownlistdiagnosis").disabled =true;
        }
    else
        {
        document.getElementById("dropdownlistdiagnosis").disabled =false;
        }
}
function showAge(a)
{
   
}
function showAge1(a)
{

}
function make_date_of_birth()
{

}
//function requirment()
//{
//    alert("asdasdas");
//    if (document.getElementById("TextBox_Address").value.length==0)
//    {
//        alert("Enter the Address Information");        
//        document.getElementById("TextBox_Address").focus();
//        return false;
//    }
//}
function checkrequiredname(a)
{
        var PFName = document.getElementById("TextBox_Pt_FName").value;
//        var PMName = document.getElementById("TextBox_Pt_MName").value;
//        var RFName = document.getElementById("textbox_Rel_FName").value;
//        var RMName = document.getElementById("textbox_Rel_Mname").value;
   
    if(document.getElementById("TextBox_Pt_FName").value.length==0)
        {
        alert("Enter first name");
        document.getElementById("TextBox_Pt_FName").focus();
        return false;
        }
    if(document.getElementById("textboxage").value.length!=0)
        {
            var Pt_Age = document.getElementById("textboxage").value ;
           if((Pt_Age-0)!= Pt_Age)
                {
                alert("Only Integer Are Allowed");
                document.getElementById("textboxage").focus();
               return false;
                }
                
           else if((Pt_Age >= 1) &&  (Pt_Age <= 150))
                { 
                }
           else
                {
                alert("Enter Correct Age");
                document.getElementById("textboxage").focus();
                //alert(false)
                return false;
                }
        }
    if(("0" in PFName) || ("1" in PFName) || ("2" in PFName) || ("3" in PFName) || ("4" in PFName) || ("5" in PFName) || ("6" in PFName) || ("7" in PFName) || ("8" in PFName) || ("9" in PFName))
        {
        alert("Intger Are Not Allowed In The First Name");
        }
    if(PFName -0 ==PFName)
        {
        alert("Enter the Correct Patient First Name");
        document.getElementById("TextBox_Pt_FName").focus();
        return false;
        }
        if((PMName.length-0) != 0)
        {
                if(PMName -0 ==PMName) 
                {
                alert("Enter the Correct Patient Middle Name");
                document.getElementById("TextBox_Pt_MName").focus();
                return false;
                }        
        }
     
 return ForAge();

}
function checkrequiredrfname(a)
{
    if(document.getElementById("textbox_Rel_FName").value.length==0)
        {

        }
}

function ForAge()
{

}
function ForName()
{
alert("Hello");
  
   
}
function Age_DateofBirth()
{
alert("Hello");
}
</script>


 <body onLoad="getList(this)">
 
 </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 
<script type="text/javascript" src="CommanMJAJAXLibrary.js"></script>
<script type="text/javascript">
var object1= createXmlObject();
var argsName;
var argsValue;

function getList(from)
{
    if(from.value==null)
    {
    var Selectioncategory='country';
    argsName="cc";
    argsValue="ALL";
    }
        else if(from.name =='country')
        {
        var Selectioncategory='Province';
        argsName="pp";
        argsValue=from.value;
        }
            else if(from.name =='Province')
        {
        var Selectioncategory='district';
        argsName="dd";
        argsValue=from.value;
        }
         else if(from.name =='district')
        {
        var Selectioncategory='tehsil';
        argsName="tt";
        argsValue=from.value;
        document.getElementById('textboxphonecode').value=from.value;
        
        }
        
  /////////////////////////////////////////////////////////////////////////      
        if(object1)
        {
        
            object1.open("GET","http://"+location.host+"/Pathology/Hfindaddress.ashx?a="+argsName+"&b="+argsValue,false);
                object1.onreadystatechange=function()
                {
                    if(object1.readyState==LOADING)

			        {
			            document.getElementById('wait').style.display="block";
			            var mark = document.getElementById('wait');
                        mark.style.left=event.clientX;
                        mark.style.top=event.clientY;
                        
			        }
                    if(object1.readyState==COMPLETE)
                    {
                        document.getElementById('wait').style.display="none";
                        
                        var values=object1.responseXML;
                        var nodes = values.selectNodes("//root/collection"); 
                        var i=0;
                        var countryList = document.getElementById(Selectioncategory);
                       
                        while(i<countryList.length)
				        {
				        document.getElementById(Selectioncategory).removeChild(countryList[0]);
				        }
                            while(i<nodes.length)
                            {
                                var newoption = document.createElement('option');
					            countryList.options.add(newoption);
					            newoption.text=nodes[i].selectSingleNode("name/text()").nodeValue;
					            newoption.value=nodes[i].selectSingleNode("code/text()").nodeValue;
					          
                                
                                
                                i++;
                            }
                            
                    }
                }
            object1.send("SomeDataToSend");
        }
    ///////////////////////////////////////////////////////////////////////////////////////////////
    if(from.value==null)
    {
    countryList= document.getElementById('country');
    getList(countryList);
    }else if(from.name =='country')
    {
     ProvinceyList= document.getElementById('Province');
    getList(ProvinceyList);
    }else if(from.name =='Province')
    {
    ProvinceyList= document.getElementById('district');
    getList(ProvinceyList);
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////  
    document.getElementById('HiddenField_country').value= document.getElementById('country').value;
    document.getElementById('HiddenField_province').value= document.getElementById('Province').value;
    document.getElementById('HiddenField_district').value= document.getElementById('district').value;
    document.getElementById('HiddenField_tehsil').value= document.getElementById('tehsil').value;     
}
function setit(a)
{
 document.getElementById('HiddenField_tehsil').value= document.getElementById('tehsil').value;   
}
</script>


  <asp:ScriptManager ID="ScriptManager2" runat="server">
                        <Services>
                       <asp:ServiceReference Path="AutoComplete.asmx" />
                        </Services>
                
    </asp:ScriptManager>

<asp:Label ID="Label2" runat="server" CssClass="err" ></asp:Label>
 
<div class="bxmain">

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form"> 
  <tr>
    <td align="right">Title :&nbsp;</td>
    <td width="37%"><asp:RadioButtonList ID="RBLprefix" runat="server" 
                        RepeatDirection="Horizontal"  TabIndex="6" RepeatLayout="Flow">
      <asp:ListItem Selected="True">Mr.</asp:ListItem>
      <asp:ListItem>Miss</asp:ListItem>
      <asp:ListItem>Mrs.</asp:ListItem>
    </asp:RadioButtonList></td>
    <td width="13%" align="right">Patient Type :&nbsp;</td>
    <td width="37%">
      <asp:DropDownList ID="DropDownList_Pt_Type" runat="server" Width="136px" DataSourceID="SqlDataSource_Patient_type" DataTextField="Patient_type" DataValueField="Patient_type"> </asp:DropDownList>
    </td>
  </tr>
  <tr>
    <td align="right" style="height: 25px">First Name :&nbsp;</td>
    <td style="height: 25px"><asp:TextBox AccessKey="n" CssClass="input_txt" ID="TextBox_Pt_FName" runat="server" TabIndex="7" Width="175px" ></asp:TextBox>
      <asp:Label ID="Label6" runat="server" Text="*"></asp:Label></td>
    <td align="right" style="height: 25px">Last Name :&nbsp;</td>
    <td style="height: 25px"><asp:TextBox CssClass="input_txt" ID="TextBox_Pt_MName" runat="server" TabIndex="8"    
                        Width="134px"  ></asp:TextBox></td>
  </tr>
  <tr>
    <td align="right">Age :&nbsp;</td>
    <td><asp:TextBox AccessKey="a" CssClass="input_txt" ID="textboxage" runat="server" TabIndex="12"   Width="31px" OnTextChanged="textboxage_TextChanged" ></asp:TextBox>
      <asp:DropDownList ID="DropDownListBIndicator" runat="server" Width="65px" AccessKey="y" TabIndex="13" OnSelectedIndexChanged="DropDownListBIndicator_SelectedIndexChanged">
        <asp:ListItem Selected="True">Years</asp:ListItem>
        <asp:ListItem>Months</asp:ListItem>
        <asp:ListItem>Days</asp:ListItem>
        <asp:ListItem>Hours</asp:ListItem>
      </asp:DropDownList></td>
    <td align="right">Gender :&nbsp;</td>
    <td>
      <asp:DropDownList ID="DropDownList_Gender" runat="server"  DataSourceID="SqlDataSource_Gender"
                      DataTextField="Gender" DataValueField="Gender_ID" Width="136px" AccessKey="g" TabIndex="1114">
        <asp:ListItem Selected="True" Value="M">Male</asp:ListItem>
        <asp:ListItem Value="F">Female</asp:ListItem>
      </asp:DropDownList>
    </td>
  </tr>
  <tr>
    <td align="right">Phone No :&nbsp;</td>
    <td><asp:TextBox CssClass="input_txt" ID="textboxcountrycode" runat="server"    
                      Width="30px"  >0092</asp:TextBox>
-
  <asp:TextBox CssClass="input_txt" ID="textboxphonecode" runat="server"  
                            Width="30px" >42</asp:TextBox>
-
<asp:TextBox CssClass="input_txt" ID="textboxphoneno" MaxLength="7" runat="server" TabIndex="21" Width="90px"  ></asp:TextBox></td>
    <td align="right">Address :&nbsp;</td>
    <td>
        <asp:TextBox ID="TextBox_Address" runat="server" AutoPostBack="True" CssClass="input_txt"
            TabIndex="22"></asp:TextBox></td>
  </tr>

</table></div>
<br />

<div align="center"> <asp:Button ID="ButtonSave" runat="server" Text="Submit"  TabIndex="24" CssClass="btn1" Visible="False" />
    <asp:SqlDataSource ID="SqlDataSource_Patient_type" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        SelectCommand="Select_Patient_Type" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
</div>
 
<br />






<asp:Panel ID="Panel3" runat="server" >
<iframe id="holder1" class="text_lables3" frameborder="0" name="holder1" scrolling="no" src="../PatientBasicInfo_Iframe.aspx" style="height:50px" width="100%"> </iframe><br />

</asp:Panel>
<div class="bxmain">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form"> 

  <tr>
    <td align="right">Sample No :&nbsp;</td>
    <td width="37%" > <asp:TextBox ID="TextBox_Sample_number" runat="server" BorderStyle="None" CssClass="input_txt"
                                            ReadOnly="True" Width="93px"></asp:TextBox></td>
    <td width="13%"  align="right">Report Date :&nbsp; </td>
<td width="37%" >   <igsch:WebDateChooser ID="WebDateChooser1" runat="server" AllowNull="False" Value="">
                                            <CalendarLayout NextMonthImageUrl="../ig_cal_blueN0.gif" PrevMonthImageUrl="ig_cal_blueP0.gif"
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
                                                    Font-Size="9pt" Font-Strikeout="False" Font-Underline="False">                                                </CalendarStyle>
                                            </CalendarLayout>
                                        </igsch:WebDateChooser></td>
  </tr>


  <tr>
    <td align="right">Collect after :&nbsp;</td>
    <td> <asp:TextBox ID="TextBox_next_Date" runat="server" CssClass="input_txt" Width="50px">0</asp:TextBox>
                                        <asp:DropDownList ID="DropDownList1" runat="server" Width="67px"> <asp:ListItem>Hours</asp:ListItem>
                                            <asp:ListItem>Days</asp:ListItem>
                                        </asp:DropDownList></td>
    <td align="right">Type :&nbsp;</td>
<td> <asp:RadioButtonList ID="RadioButtonList_Type" runat="server" DataSourceID="SqlDataSource_Test_Type"
                                            DataTextField="Test_Type" DataValueField="Test_Type_ID" RepeatDirection="Horizontal" RepeatLayout="Flow"
                                            >
                                            <asp:ListItem Selected="True">Routine</asp:ListItem>
                                            <asp:ListItem>Start(Now)</asp:ListItem>
                                            <asp:ListItem>Urgent(Today)</asp:ListItem>
                                        </asp:RadioButtonList></td>
  </tr>
  
    <tr>
    <td align="right">Sample :&nbsp;</td>
<td> <asp:RadioButtonList ID="RadioButtonList_Sample" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" >
                                        <asp:ListItem Selected="True" Value="1">Received</asp:ListItem>
                                        <asp:ListItem Value="2">Sample To Come</asp:ListItem>
                                    </asp:RadioButtonList></td>
    <td align="right">&nbsp;</td>
    <td>
      </td>
  </tr>
    <tr>
        <td align="right">&nbsp;</td>
        <td><asp:DropDownList ID="DropDownList_Main_Group" runat="server" AutoPostBack="True"
                                    DataSourceID="SqlDataSource_Main_Group" DataTextField="TGName" DataValueField="TGID"
                                    Width="164px"> </asp:DropDownList>        </td>
        <td align="right">
        </td>
        <td>
        </td>
    </tr>
    <tr>
        <td align="right">&nbsp;</td>
        <td><asp:TextBox ID="TextBox6" runat="server" AutoPostBack="True" Width="32px" CssClass="input_txt" OnTextChanged="TextBox6_TextChanged"></asp:TextBox>
          <asp:TextBox ID="TextBox_Test" runat="server" AutoPostBack="True" Width="112px" CssClass="input_txt"></asp:TextBox>        </td>
        <td align="right">
        </td>
        <td>
        </td>
    </tr>
    
    

</table></div>
<br />
<div align="center"><asp:Button ID="BTNcheckAll" runat="server" CssClass="btn2" Text="Check All"
                                    Visible="False" /><asp:Button ID="BtnUncheckAll" runat="server" CssClass="btn2" Text="UnCheck All"
                                    Visible="False" />
   <asp:Button ID="btnAdd" runat="server" CssClass="btn1" Text="Save" />
            <asp:Button ID="Button6" runat="server" CssClass="btn2" OnClientClick="ViewReport()"
                                    Text="View Report" Visible="False" />
            <asp:Button ID="Button_Move_Next" runat="server" CssClass="btn2" Text="Move Next"
                                    Visible="False" /></div>
<br />
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="33%" align="left"><asp:GridView ID="GridView_Booking" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
                                    DataKeyNames="TB_ID" DataSourceID="SqlDataSource_Booking" Width="100%">
      <Columns>
      <asp:ButtonField CommandName="Select" DataTextField="TB_Name" HeaderText="Test Name " />
      <asp:TemplateField HeaderText="TB_Name" SortExpression="TB_Name" Visible="False">
        <EditItemTemplate>
          <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("TB_Name") %>'></asp:TextBox>
        </EditItemTemplate>
        <ItemTemplate>
          <asp:Label ID="Label3" runat="server" Text='<%# Bind("TB_Name") %>'></asp:Label>
          &nbsp; </ItemTemplate>
      </asp:TemplateField>
      <asp:TemplateField HeaderText="Group Name" SortExpression="TGName">
        <EditItemTemplate>
          <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("TGName") %>'></asp:TextBox>
        </EditItemTemplate>
        <ItemTemplate>
          <asp:Label ID="Label4" runat="server" Text='<%# Bind("TGName") %>'></asp:Label>
          <br />
          &nbsp; </ItemTemplate>
      </asp:TemplateField>
      <asp:BoundField DataField="TB_ID" HeaderText="TB_ID" InsertVisible="False" ReadOnly="True"
                                            SortExpression="TB_ID" Visible="False" />
      <asp:TemplateField HeaderText="Public Price" SortExpression="Public_Price">
        <EditItemTemplate>
          <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Public_Price") %>'></asp:TextBox>
        </EditItemTemplate>
        <ItemTemplate>
          <asp:Label ID="Label7" runat="server" Text='<%# Bind("Public_Price") %>'></asp:Label>
          <asp:HiddenField ID="HiddenField_TB_ID" runat="server" Value='<%# Bind("TB_ID", "{0}") %>' />
        </ItemTemplate>
      </asp:TemplateField>
      <asp:TemplateField HeaderText="Private Price" SortExpression="Private_Price" Visible="False">
        <EditItemTemplate>
          <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("Private_Price") %>'></asp:TextBox>
        </EditItemTemplate>
        <ItemTemplate>
          <asp:Label ID="Label8" runat="server" Text='<%# Bind("Private_Price") %>'></asp:Label>
          &nbsp; </ItemTemplate>
      </asp:TemplateField>
      </Columns>
      <RowStyle CssClass="GridItem" />
      <HeaderStyle CssClass="GridHeader" />    
      <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView></td>
    <td width="33%" align="left" style="padding-left:5px;" valign="top" ><asp:GridView ID="GridView_Services" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
                                    DataKeyNames="ID" DataSourceID="SqlDataSource_Booking_Service" Width="100%">
      <Columns>
      <asp:BoundField DataField="TB_Name" HeaderText="Name" SortExpression="TB_Name" />
      <asp:BoundField DataField="TGName" HeaderText="Group Name" SortExpression="TGName" />
      <asp:TemplateField HeaderText="Price" SortExpression="Public_Price">
        <EditItemTemplate>
          <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Public_Price") %>'></asp:TextBox>
        </EditItemTemplate>
        <ItemTemplate>
          <asp:Label ID="Label9" runat="server" Text='<%# Bind("Public_Price") %>'></asp:Label>
        </ItemTemplate>
      </asp:TemplateField>
      <asp:CommandField DeleteText="Cancel" ShowDeleteButton="True" />
      </Columns>
      <RowStyle CssClass="GridItem" />
      <HeaderStyle CssClass="GridHeader" />    
      <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView></td>
    <td width="33%" align="left" style="padding-left:5px;" valign="top" ><asp:TreeView ID="TreeView1" runat="server" > </asp:TreeView></td>
  </tr>
</table>
<br />

<br />

                                <asp:SqlDataSource ID="SqlDataSource_Booking" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                                    InsertCommand="INsert_Test_Booking_Services" InsertCommandType="StoredProcedure"
                                    ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="Select_TB_Name"
                                    SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DropDownList_Main_Group" Name="MG_ID" PropertyName="SelectedValue" />
                                        <asp:ControlParameter ControlID="HiddenField_Flag" DefaultValue="" Name="Flag" PropertyName="Value"
                                            Type="Boolean" />
                                        <asp:ControlParameter ControlID="TextBox_Test" DefaultValue="%%" Name="TB_Name" PropertyName="Text"
                                            Type="String" />
                                    </SelectParameters>
                                    <InsertParameters>
                                        <asp:SessionParameter DefaultValue="" Name="YearlyNo" SessionField="YearlyNo" />
                                        <asp:SessionParameter DefaultValue="" Name="RegNo" SessionField="registrationNo" />
                                        <asp:ControlParameter ControlID="HiddenField_TBID" DefaultValue="" Name="TB_ID" PropertyName="Value" />
                                        <asp:ControlParameter ControlID="RadioButtonList_Sample" Name="Status" PropertyName="SelectedValue"
                                            Type="Int32" />
                                        <asp:SessionParameter Name="Emp_ID" SessionField="Emp_ID" Type="Int32" />
                                        <asp:ControlParameter ControlID="HiddenFieldMain_ID" Name="Main_ID" PropertyName="Value"
                                            Type="Int32" />
                                    </InsertParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSource_Main_Group" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT TGID, TGName FROM TestGroup">
                                </asp:SqlDataSource>
                                <asp:HiddenField ID="HiddenField_TBID" runat="server" />
                                <asp:HiddenField ID="HiddenField_Flag" runat="server" />
                                
                                <br />

<asp:Label ID="labelGName" runat="server" CssClass="err" Font-Size="Medium" ></asp:Label><br />
                                
                                
<br />

                            <asp:SqlDataSource ID="SqlDataSource_Booking_Service" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                                DeleteCommand="DELETE FROM Test_Booking_Services WHERE (ID = @ID)" ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>"
                                SelectCommand="SELECT Test_Booking.TB_Name, TestGroup.TGName, Test_Booking_Services.ID, Test_Booking.Public_Price FROM Test_Booking_Services INNER JOIN Test_Booking ON Test_Booking_Services.TB_ID = Test_Booking.TB_ID INNER JOIN TestGroup ON Test_Booking.MG_ID = TestGroup.TGID INNER JOIN Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID WHERE (Path_Result_Delivery.Yearly_No = @YearlyNo) AND (Path_Result_Delivery.Reg_no = @RegNo)">
                                <SelectParameters>
                                    <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                                    <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                                </SelectParameters>
                                <DeleteParameters>
                                    <asp:ControlParameter ControlID="GridView_Services" Name="ID" PropertyName="SelectedValue" />
                                </DeleteParameters>
                            </asp:SqlDataSource>
<br />
<div align="center">
    &nbsp;</div>
                                    <br />
    &nbsp;<asp:Panel ID="Panel2" runat="server" Visible="False">

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">

  <tr>
    <td align="right">Payment :</td>
    <td><asp:TextBox ID="TextBox_Grand_total" runat="server" BorderStyle="None" BorderWidth="0px"
                                                CssClass="d-active" Font-Size="Large" ReadOnly="True" Width="64px">0</asp:TextBox></td>
  </tr>
  <tr>
    <td align="right">Discount :</td>
    <td> <asp:TextBox
                                    ID="TextBox_Grand_discount" runat="server" Width="54px" AutoPostBack="True">0</asp:TextBox>
                                    <asp:DropDownList ID="DropDownList_Discount_Type" runat="server" AutoPostBack="True">
                                                <asp:ListItem>Rs.</asp:ListItem>
                                                <asp:ListItem>%age</asp:ListItem>
      </asp:DropDownList></td>
  </tr>
  <tr>
    <td align="right">Total Price :</td>
    <td> <asp:TextBox ID="TextBox_Total_Price" runat="server" BorderStyle="None" BorderWidth="0px"
                                                Font-Size="Large" ReadOnly="true" Width="70px">0</asp:TextBox></td>
  </tr>
 
  

</table>


 

                                            

                                                 <asp:HiddenField ID="HiddenFieldTotalAmount" runat="server" />
                       
                                <asp:HiddenField ID="HiddenFieldTotalPaid" runat="server" />
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
                           
                           
                           
                            </asp:Panel>
                            
<asp:Panel ID="Panel1" runat="server"  Visible="False" > </asp:Panel>
                            
<asp:TextBox ID="TextBox5" runat="server" AutoPostBack="True" Width="113px" Visible="False">0</asp:TextBox>
                            <asp:Label ID="LabelRelation" runat="server" CssClass="text_boxtitle"></asp:Label><asp:Label
                                ID="LabelRName" runat="server" CssClass="text_boxtitle"></asp:Label><asp:Label
                                        ID="Label5" runat="server" Width="211px"></asp:Label><asp:DropDownList ID="DropDownList2"
                                            runat="server" AutoPostBack="True" DataSourceID="ForTestGroup" DataTextField="MSTG_Name"
                                            DataValueField="MS_TGID" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged"
                                            Visible="False" Width="240px">
                                        </asp:DropDownList><asp:SqlDataSource ID="ForTestGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                                            SelectCommand="SELECT     Test_Main_Sub_Grouping.MSTG_Name, Test_Main_Sub_Grouping.MS_TGID&#13;&#10;FROM         Test_Main_Sub_Grouping INNER JOIN&#13;&#10;                      TestGroup ON Test_Main_Sub_Grouping.TGID = TestGroup.TGID&#13;&#10;order by Test_Main_Sub_Grouping .priority asc&#13;&#10;">
                                        </asp:SqlDataSource>
                            <asp:TextBox ID="TextBoxDescription" runat="server" CssClass="d-active" Visible="False"
                                Width="198px"></asp:TextBox>
                            <asp:SqlDataSource ID="ForTestSubGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                                ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT isnull(TestSubGroup.TSGName,'') as TSGName, TestSubGroup.TSGID, &#13;&#10;isnull(TestGroup.TGName,'') as TGName &#13;&#10;FROM TestSubGroup INNER JOIN TestGroup ON TestSubGroup.TGID = TestGroup.TGID &#13;&#10;WHERE (TestSubGroup.MS_TGID = @TGID)&#13;&#10;order by TestSubGroup.Sort_order asc">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="Dropdownlist2" Name="TGID" PropertyName="SelectedValue"
                                        Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="ForTest" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                                SelectCommand="SELECT Test.TestName, Test.TID FROM Test INNER JOIN Test_Main_Sub_Grouping ON Test.TGID = Test_Main_Sub_Grouping.TGID WHERE (Test.Active = @Active) AND (Test_Main_Sub_Grouping.MS_TGID = @TGID) ">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropDownList2" DefaultValue="%%" Name="TGID" PropertyName="SelectedValue"
                                        Type="Int32" />
                                    <asp:Parameter DefaultValue="1" Name="Active" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:HiddenField ID="HiddenFieldTestSubGroup" runat="server" />
                            <asp:SqlDataSource ID="SqlDataSourcefortsetSG" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                                SelectCommand="SELECT [TID], [TestName] FROM [Test] WHERE ([TSGID] = @TSGID)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="HiddenField_for_test" Name="TSGID" PropertyName="Value"
                                        Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:HiddenField ID="HiddenField_for_test" runat="server" />
                            
<br />
  <asp:HiddenField ID="HiddenField_Sample_collection" runat="server" />
                            <asp:HiddenField ID="HiddenField_Report_Date" runat="server" />
                            <asp:HiddenField ID="HiddenFieldMain_ID" runat="server" />
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                                ProviderName="<%$ ConnectionStrings:LGHConnectionString12.ProviderName %>" SelectCommand="Select @PFNAME = PFNAME from patient">
                            </asp:SqlDataSource>
                            <asp:HiddenField ID="HiddenField2" runat="server" />
                            <asp:SqlDataSource ID="SqlDataSource_Test_Type" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT Test_Type, Test_Type_ID FROM Test_Type">
                            </asp:SqlDataSource>
                            <asp:HiddenField ID="HiddenFieldRegNo" runat="server" />
                            <asp:HiddenField ID="HiddenFieldYearlyNo" runat="server" />
<asp:Label ID="LabelDOB" runat="server" Visible="False" CssClass="err" ></asp:Label><asp:Label ID="LabelCNIC" runat="server" Visible="False" CssClass="err" ></asp:Label>
                                <br /><br />

<table width="100%" border="0" cellpadding="0" cellspacing="0"   style="display: none">
                  <tr>
                    <td width="175" height="5"></td>
                    <td width="250"></td>
                    <td width="175"></td>
                    <td width="314"></td>
                  </tr>
                <tr>
                    <td align="center" colspan="4" height="5">
                    </td>
                </tr>
                  <tr>
                    <td align="right" valign="middle" style="height: 25px"><strong >CNIC Number :&nbsp;</td>
                    <td valign="middle" style="height: 25px"><asp:TextBox CssClass="d-active_small" ID="textboxnic1" MaxLength="5" runat="server" Text="" Width="39px" class="d-active_small" onactivate="this.className='active_small';" ondeactivate="this.className='d-active_small';" ></asp:TextBox>
-
  <asp:TextBox CssClass="d-active_small"
                        ID="textboxnic2" MaxLength="7" runat="server" Width="54px" class="d-active_small" onactivate="this.className='active_small';" ondeactivate="this.className='d-active_small';"></asp:TextBox>
-
<asp:TextBox CssClass="d-active_small"
                            ID="textboxnic3" MaxLength="1" runat="server" Width="12px" class="d-active_small" onactivate="this.className='active_small';" ondeactivate="this.className='d-active_small';"></asp:TextBox></td>
                    <td align="right" valign="middle" style="height: 25px"><strong >Province :&nbsp;</td>
                    <td valign="middle" style="height: 25px"><span style="width: 260px">
                      <asp:DropDownList ID="Province" runat="server" 
                      Width="151px" TabIndex="15"> </asp:DropDownList>
                      <asp:TextBox CssClass="d-active_small" ID="textboxprovince2" runat="server" Visible="False"
                      Width="99px" ></asp:TextBox>
                    </span></td>
                  </tr>
                  <tr>
                    <td height="25" align="right" valign="middle"><strong >Country :&nbsp;</td>
                    <td valign="middle"><asp:DropDownList ID="country" runat="server"  Width="151px" > </asp:DropDownList></td>
                    <td align="right" valign="middle"><strong >Tehsil :&nbsp;</td>
                    <td valign="middle"><span style="width: 260px">
                      <asp:DropDownList ID="tehsil" runat="server"  Width="151px" TabIndex="17"> </asp:DropDownList>
                      <asp:TextBox CssClass="d-active_small" ID="textboxTehsil2" runat="server" Visible="False" Width="92px" ></asp:TextBox>
                    </span></td>
                  </tr>
                  <tr>
                    <td height="25" align="right" valign="middle"><strong >District :&nbsp;</td>
                    <td valign="middle"><asp:DropDownList ID="district" runat="server" 
                      Width="151px" TabIndex="16"> </asp:DropDownList>
                      <asp:TextBox CssClass="d-active_small" ID="textboxDistrict2" runat="server"    
                      Visible="False" Width="98px" ></asp:TextBox></td>
                    <td align="right" valign="middle"><strong >Street / Block :&nbsp;</td>
                    <td valign="middle"><span style="width: 260px">
                      <asp:TextBox CssClass="d-active_small" ID="textbox_Street_Address" runat="server" TabIndex="19" Width="146px" onactivate="this.className='active_small';"
                          ondeactivate="this.className='d-active_small';"></asp:TextBox>
                    </span></td>
                  </tr>
                  <tr>
                    <td height="25" align="right" valign="middle"><strong >Town / Village :&nbsp;</td>
                    <td valign="middle"><asp:TextBox CssClass="d-active_small" ID="textbox_Colony" runat="server" TabIndex="18"    
                      Width="146px" onactivate="this.className='active_small';" ondeactivate="this.className='d-active_small';"></asp:TextBox></td>
                    <td align="right" valign="middle"><strong >Postal Code :&nbsp;</td>
                    <td valign="middle"><span style="width: 260px">
                      <asp:TextBox CssClass="d-active_small" ID="textbox_Zip_Code"    
                      MaxLength="5" runat="server" Width="146px" onactivate="this.className='active_small';" ondeactivate="this.className='d-active_small';"></asp:TextBox>
                    </span></td>
                  </tr>
                  <tr>
                    <td height="25" align="right" valign="middle"><strong >House No. :&nbsp;</td>
                    <td valign="middle"><asp:TextBox CssClass="d-active_small" ID="textbox_House_No" runat="server" TabIndex="20"    
                      Width="146px" onactivate="this.className='active_small';" ondeactivate="this.className='d-active_small';"></asp:TextBox></td>
                    <td align="right" valign="middle"><strong >Mobile No. :&nbsp;</td>
                    <td valign="middle"><span style="width: 260px">
                      <asp:TextBox CssClass="d-active_small" ID="textboxmcode"    
                      MaxLength="4" runat="server" TabIndex="22" Width="49px" onactivate="this.className='active_small';" ondeactivate="this.className='d-active_small';" ></asp:TextBox>
-
<asp:TextBox CssClass="d-active_small" ID="textboxmno" MaxLength="7" runat="server" TabIndex="23" Width="77px" class="d-active_small" onactivate="this.className='active_small';" ondeactivate="this.className='d-active_small';"></asp:TextBox>
                    </span></td>
                  </tr>
                  <tr>
                    <td height="25" align="right" valign="middle"><strong >Phone No. :&nbsp;</td>
                    <td valign="middle">
                        &nbsp;-&nbsp; -
                    </td>
                    <td align="right" valign="middle">&nbsp;</td>
                    <td valign="middle">&nbsp;</td>
                  </tr>
                  <tr>
                    <td height="5"></td>
                    <td></td>
                    <td></td>
                    <td></td>
                  </tr>
    </table>
                
<asp:SqlDataSource ID="SqlDataSourceDiagnosis" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>" SelectCommand="SELECT Diagnosis FROM Diagnosis ORDER BY Diagnosis"></asp:SqlDataSource>
              <asp:HiddenField ID="HiddenField_country" runat="server" Value="12" />
              <asp:HiddenField ID="HiddenField_province" runat="server" Value="12" />
              <asp:HiddenField ID="HiddenField_district" runat="server" Value="12" />
                  &nbsp; &nbsp; &nbsp;
                  &nbsp; &nbsp;&nbsp;
<asp:HiddenField ID="HiddenField_tehsil" runat="server" Value="12" />
&nbsp;&nbsp;
<asp:TextBox CssClass="d-active_small"  Enabled="false" ID="TextBox_Pt_LName" runat="server" Visible="False"    
                        Width="146px" class="d-active_small" onactivate="this.className='active_small';" ondeactivate="this.className='d-active_small';"></asp:TextBox>
<br />
<asp:DropDownList  DataTextField="Diagnosis" DataValueField="Diagnosis" ID="DropDownListDiagnosis" runat="server" TabIndex="2" DataSourceID="SqlDataSourceDiagnosis" Visible="false" Width="96px"> </asp:DropDownList>
<asp:TextBox AccessKey="f" CssClass="d-active_small" ID="TextBox_Diagnosis" runat="server" TabIndex="3" Width="140px" onactivate="this.className='active_small';" ondeactivate="this.className='d-active_small';" Visible="false"></asp:TextBox>
<asp:RadioButtonList ID="RadioButtonListPType" runat="server" 
                    RepeatDirection="Horizontal" TabIndex="4" Visible="false">
  <asp:ListItem Selected="True">Routine</asp:ListItem>
  <asp:ListItem>Medical Legal</asp:ListItem>
  <asp:ListItem>Special</asp:ListItem>
</asp:RadioButtonList>&nbsp;
<span class="link_spliter">
<asp:TextBox ID="TextBox_PINNO" runat="server" AccessKey="f" CssClass="d-active_small"
                  onactivate="this.className='active_small';" ondeactivate="this.className='d-active_small';"
                  TabIndex="3" Width="92px" visible="False"></asp:TextBox>&nbsp;&nbsp;
</span>
<asp:TextBox CssClass="d-active_small" Enabled="false" ID="textbox_Rel_LName" runat="server" Visible="False"    
                      Width="146px" class="d-active_small" onactivate="this.className='active_small';" ondeactivate="this.className='d-active_small';"></asp:TextBox>
                  &nbsp;&nbsp;
<asp:ImageButton ID="IBtnLogOut" runat="server" ImageUrl="images/image_logout_up.gif" Visible="false" />              
              &nbsp;<span style="height: 13px">
              <asp:Label ID="Label1" runat="server" Font-Size="Medium"></asp:Label>&nbsp;</span>
              <asp:Button ID="BTNDetail1" runat="server" Text="Detail" CssClass="bt1up"     TabIndex="26" Visible="False"  />              
              &nbsp;
              <asp:Button ID="btnSavePrint" runat="server" Text="Save &amp; Print" CssClass="bt2up" onmousedown="this.className='bt2down'" onmouseover="this.className='bt2over'" onmouseout="this.className='bt2up'" TabIndex="25" Visible="False" />              
&nbsp;&nbsp;
           <span style="left: 59px; top: 82px; width: 693px; height: 1px;">
            <asp:SqlDataSource ID="PatientSaveRecord" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                  InsertCommand="PatientRegistration" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>"
                  SelectCommand="SELECT Dept_Name, Dept_ID FROM Department-- WHERE (Dept_ID = 6)">
              <InsertParameters>
                <asp:FormParameter FormField="rblprefix" Name="Prefix" Type="String" />
                <asp:FormParameter FormField="txtpfname" Name="PFName" Type="String" />
                <asp:FormParameter FormField="txtpmname" Name="PMName" Type="String" />
                <asp:FormParameter FormField="txtplname" Name="PLName" Type="String" />
                <asp:FormParameter FormField="rblrelation" Name="Relation" Type="String" />
                <asp:FormParameter FormField="txtrfname" Name="RFName" Type="String" />
                <asp:FormParameter FormField="txtrmname" Name="RMName" Type="String" />
                <asp:FormParameter FormField="txtrlname" Name="RLName" Type="String" />
                <asp:FormParameter FormField="sex" Name="sexID" Type="Int32" />
                <asp:FormParameter FormField="txtage" Name="Age" Type="Int32" />
                <asp:SessionParameter Name="RegDateTime" SessionField="DT" Type="DateTime" />
                <asp:FormParameter FormField="country" Name="CountryCode" Type="Int32" />
                <asp:FormParameter FormField="province" Name="ProvinceID" Type="Int32" />
                <asp:FormParameter FormField="district" Name="DistrictID" Type="Int32" />
                <asp:FormParameter FormField="tehsil" Name="Tehsil" Type="Int32" />
                <asp:FormParameter FormField="txtzipcode" Name="Zipcode" Type="Int32" />
                <asp:Parameter Name="House_No" Type="String" />
                <asp:FormParameter FormField="txtstreetaddress" Name="StreetAddress" Type="String" />
                <asp:FormParameter FormField="txtcolony" Name="Colony" Type="String" />
                <asp:SessionParameter Name="HomePhone" SessionField="PHP" Type="String" />
                <asp:SessionParameter Name="MobilePhone" SessionField="PMP" Type="String" />
                <asp:SessionParameter Name="nic" SessionField="nic" Type="String" />
                <asp:SessionParameter Name="DateOfBirth" SessionField="dob" Type="DateTime" />
                <asp:Parameter Direction="InputOutput" Name="NewRegNo" Type="String" />
                <asp:Parameter Name="DateTime" Type="DateTime" />
                <asp:Parameter Name="DeptID" Type="Int32" />
                <asp:Parameter Name="Status" Type="String" />
                <asp:Parameter Name="EmpID" Type="Int32" />
                <asp:Parameter Name="Diagonosis" Type="String" />
                <asp:Parameter Name="PatientType" Type="String" />
                <asp:Parameter Name="AgeType" Type="String" />
                <asp:Parameter Name="ReferFrom" Type="String" />
                
                  <asp:Parameter Name="to_sub_Dept" Type="Int32">
            </asp:Parameter>
            
                  <asp:Parameter Name="Patient_Type" Type="String">
            </asp:Parameter>
                <asp:Parameter Direction="InputOutput" Name="paymentid" Type="Decimal" />
              </InsertParameters>
            </asp:SqlDataSource>
                &nbsp;&nbsp;</span><span style="left: 59px; top: 82px; width: 693px; height: 1px;">
            <asp:SqlDataSource ID="SqlDataSource_Gender" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                  SelectCommand="SELECT Gender_ID, Gender FROM Gender"></asp:SqlDataSource>
<asp:HiddenField ID="HiddenFieldAge" runat="server" />
<asp:SqlDataSource ID="printinfosave" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                  InsertCommand="INSERT INTO [Print] (EmpID, PrintDateTime, RegNo) 
VALUES (@EmpID, @PrintDateTime, @RegNo)"
                  ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>">
  <InsertParameters>
    <asp:SessionParameter Name="EmpID" SessionField="UserID" />
    <asp:SessionParameter Name="PrintDateTime" SessionField="PDT" />
    <asp:SessionParameter Name="RegNo" SessionField="PRegNoForDetail" />
  </InsertParameters>
</asp:SqlDataSource>
                &nbsp;&nbsp;&nbsp;
                    <asp:RadioButtonList ID="RBLrelation" runat="server" 
                        Font-Names="verdana, arial, helvetica, sans-serif" RepeatDirection="Horizontal"
                        TabIndex="9" Width="172px" Visible="False">
                        <asp:ListItem Selected="True">S/O</asp:ListItem>
                        <asp:ListItem>D/O</asp:ListItem>
                        <asp:ListItem>W/O</asp:ListItem>
                </asp:RadioButtonList><asp:TextBox ID="TextBoxSpecialCase" runat="server" Width="146px" TabIndex="5" class="d-active_small" onactivate="this.className='active_small';" ondeactivate="this.className='d-active_small';" Visible="False"></asp:TextBox><asp:TextBox CssClass="d-active_small" Font-Names="Arial" ID="textbox_Rel_FName" runat="server" TabIndex="10"   Width="146px" onactivate="this.className='active_small';" ondeactivate="this.className='d-active_small';" Visible="False"></asp:TextBox><asp:DropDownList AccessKey="d" 
                      DataTextField="Dept_Name" DataValueField="Dept_ID" ID="DDLDepartment" runat="server" TabIndex="1" Width="151px" DataSourceID="PatientSaveRecord" Visible="False"> </asp:DropDownList><asp:TextBox CssClass="d-active_small"   Font-Names="Verdana" ID="textbox_Rel_Mname" runat="server" TabIndex="11"
                      Width="145px" onactivate="this.className='active_small';" ondeactivate="this.className='d-active_small';" Visible="False"></asp:TextBox></span>        
  
<script type="text/javascript" src="images1/flash_01.js">Sub TABLE1_onclick()

End Sub

</script>

<div id="wait" style="position:absolute; left: 822px; top: 82px; visibility: hidden;">
    &nbsp;</div>
<img src="wt.gif" width="50" height="50" alt="" style="visibility:hidden;"   />
  </asp:Content>