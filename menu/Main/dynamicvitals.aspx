<%@ page language="VB" autoeventwireup="false" inherits="dynamicvitals, App_Web_rbfdm1yf" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="Paragma" content="no-cache"/>

<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />


<script language ="javascript" type="text/javascript" >
function View_ToolTip(def)
{
window.status =def; document.getElementById("HiddenField1").value ;
//alert(def);//document.getElementById(abc).value);
//document.getElementById(tooltip).value;//document.getElementById("HiddenFieldToolTIp").value ;
}

function Remove_ToolTip(tooltip)
{
window.status = "" ;//document.getElementById("HiddenFieldToolTIp").value 
}

function InsertValues(a)
{
//alert("hello")
//document.getElementById("HiddenFieldnewid").value=""
document.getElementById("hiddenfieldvalues").value=""
if (document.getElementById("HiddenFieldmaingroup").value== 5)
{
cigritevalue("a1");
}
    var a = 2;
    var b= document.getElementById("mytable").all;//all;//childNodes
   // var abc = document.getElementById("HiddenFieldSubTypeID").value
 //  alert(document.getElementById("mytable").innerHTML());
   // var dd = abc.split(";")
var status = false;

   var count =0;
        for(var i =0; i< b.length;i++)
    {
          if(b[i].value ==null)
          {

          }
          else
          { 
         
            if((b[i].nodeName =="SELECT") || (b[i].nodeName =="INPUT")|| (b[i].nodeName =="TEXTAREA"))
            {
                if(b[i].type=="checkbox" )
                {
                if(b[i].checked ==true)
                {
                             
                    document.getElementById("hiddenfieldvalues").value+=b[i].value+";"
                    document.getElementById("hiddenfieldvaluesid").value+=b[i].id+";"
           
                }
                else
                {
                    document.getElementById("hiddenfieldvalues").value+=" "+";"
                    document.getElementById("hiddenfieldvaluesid").value+=b[i].id+";"
               
                    
                }
        
                }//if(b[i].type=="checkbox" )
                else if(b[i].type=="radio" )
                {
                       if(b[i].checked ==true)
                {
                             
                    document.getElementById("hiddenfieldvalues").value+=b[i].value+";"
                    document.getElementById("hiddenfieldvaluesid").value+=b[i].id+";"
           
                }
                else
                {
                         
                    document.getElementById("hiddenfieldvalues").value+=" "+";"
                    document.getElementById("hiddenfieldvaluesid").value+=b[i].id+";"
             
               
                    
                }
             
                }//if(b[i].type=="radio" )
                else
                {
                       // alert(b[i].type); 
                    //if(b[i].nodeName =="SELECT")
                    if(b[i].type =="select-one")
                    {
                    
                         if(b[i].id==54)
                         {
                         //document.getElementById ("HiddenFieldcigritepacks").value=0;
                         //document.getElementById ("HiddenFieldcigritepacks").value =document.getElementById("54").value;
                         // alert(document.getElementById("54").value);
                         }
                          if(b[i].id==82)
                         {
                         
                         // alert(document.getElementById("82").value);
                         //document.getElementById ("HiddenFieldcigritepacks").value =(document.getElementById ("HiddenFieldcigritepacks").value*document.getElementById("82").value)/20;
                         
                         }
                     }
                      
         
                     document.getElementById("hiddenfieldvalues").value+=b[i].value+";"
                     document.getElementById("hiddenfieldvaluesid").value+=b[i].id+";"
                     
                     count++;
                }//other than (b[i].nodeName =="SELECT") || (b[i].nodeName =="INPUT")|| (b[i].nodeName =="TEXTAREA")
        }//end if(b[i].nodeName =="SELECT") || (b[i].nodeName =="INPUT")|| (b[i].nodeName =="TEXTAREA")
          
      
        }//else b[i].value ==null)
    }//for end
//alert("heelllo");
//alert(document.getElementById("hiddenfieldlabels").value);
//alert(document.getElementById("hiddenfieldvalues").value);
//alert(document.getElementById("hiddenfieldvaluesid").value);
//var b = 

//alert(document.getElementById("hiddenfieldvalues").value);
}//function end


function cigritevalue(def)
{
window.status =def; 
document.getElementById("HiddenField1").value ;

 document.getElementById ("HiddenFieldcigritepacks").value =document.getElementById("54").value;


 document.getElementById ("HiddenFieldcigritepacks").value =(document.getElementById ("HiddenFieldcigritepacks").value*document.getElementById("82").value)/20;
document.getElementById("114").value=document.getElementById ("HiddenFieldcigritepacks").value ;

}
function b()
{
//alert( document.getElementById("mytable").innerHtml);
//alert("hello");
//alert(document.getElementById("mytable").innerHTML);
}
function a()
{

//alert( document.getElementById("mytable").innerHTML);

return getvalues()
//InsertValues("a");
//b();
//alert(document.getElementById("hiddenfieldlabels").value);
//alert(document.getElementById("hiddenfieldvalues").value);
//return true;
}

function getvalues()
{
   document.getElementById("HiddenFieldCheck").value = '';
   // alert(document.form1.length );
    var length_Form=document.form1.length ;
    var i;
    var form_control;
    var Check_Counter=0;
    var confirm_valid;
    var Radio_Old_Name='';
    var Radio_New_Name='';
    var Radio_Counter=0;
    var Radio_New_Value='';
    var Radio_Old_Value='';
    Check_Counter =0;
        for(i=0;i<length_Form;i++)
        {        
        form_control = document.form1.elements[i];
/////////////////////////////  Validation For THe TextBoxes     //   
            if((form_control.type == "text") && (form_control.value ==""))
            {   
            Check_Counter ++ ;  
            }
///////////////////////////  Validation For the CheckBoxes   //         
            else if(form_control.type == "checkbox") 
            {
                if(form_control.checked ==false)
                {
                Check_Counter ++;
                }
            }
//////////////////////////  Validation For the DropDownList   //         
            else if(form_control.type =="select-one")
            {
                if(form_control.value =="")
                {
                Check_Counter ++;
                }
            }
/////////////////////////  Validation For The Teatareas   //         
            else if(form_control.type =="textarea")
            {
                if(form_control.value =="")
                {
                Check_Counter ++;
                }
            }
//////////////////////  Validation For The RadioButtonList             
            else if (form_control.type =="radio")
            {
            Radio_New_Name= form_control.name
                if (Radio_New_Name != Radio_Old_Name)
                {
                Radio_Old_Value = form_control.checked;
                    if(form_control.checked == false)
                    {
                    Check_Counter ++; 
                    }
                }
                if (Radio_New_Name==Radio_Old_Name)
                {
                    if(form_control.checked == true)
                    {
                    Check_Counter --;
                    }
                }                
            Radio_Old_Name= form_control.name
            }         
        }
        //alert(Check_Counter);
    if (Check_Counter > 0)
    {
    
   // confirm_valid = confirm("Some Fields Have Not Been Filled. Do You Want To Proceed Without Completing These Fields?","yes","No");
   document.getElementById ("TextBox1").style.color ="Red";
    document.getElementById ("TextBox1").value = "Some Fields Have Not Been Filled. Do You Want To Proceed Without Completing These Fields?","yes","No";
    document.getElementById("ButtonYes").style.visibility  = "visible";
    document.getElementById("ButtonNo").style.visibility  = "visible";
    document.getElementById("Check_Table").style.visibility  = "visible";
    document.getElementById("TextBox1").focus();
    document.getElementById("Panel1").style.visibility  = "Hidden";
    document.getElementById("Button1").style.visibility  = "Hidden";
    Check_Counter =0;
     return false;
    }
    else if(Check_Counter ==0)
    {
    InsertValues("a");
    document.getElementById("HiddenFieldCheck").value = 1;
    }
   // if(confirm_valid==true)
   // {
   
  //  }
   // else if(confirm_valid==false)
 //   {
    //alert(confirm_valid + "Aun Abbas");
 //   }
    //return false;
}
function Check_No()
{
document.getElementById("Panel1").style.visibility  = "visible";
document.getElementById("Check_Table").style.visibility  = "Hidden";
document.getElementById("ButtonYes").style.visibility  = "Hidden";
document.getElementById("ButtonNo").style.visibility  = "Hidden";
document.getElementById("Button1").style.visibility  = "visible";
return false;
}
function Check_Yes()
{
document.getElementById("Button1").style.visibility  = "Hidden";
InsertValues("a");
}
</script>
</head>

<body onload="MM_preloadImages('images1/img_btn_over.gif')" dir="ltr">
<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_top.gif" alt="" width="1003" height="24" /></td>
  </tr>
  
  
  <tr>
    <td width="23" height="550" valign="top" class="left_border"><img src="images1/img_border_left.gif" alt="" width="23" height="15" /></td>
    <td width="957" valign="top">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
        <td height="73" colspan="2" valign="bottom" bgcolor="#F4F4F4" ><iframe 
      src="tabs.aspx" name="holder" width="957" marginwidth="0" height="215" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
      </tr>
      
      
      <tr>
        <td width="19" height="25" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td width="929" valign="middle" class="text_lables3" ><span class="text_heading_02">
              <asp:Label ID="LabelDeptName" runat="server"></asp:Label>
              &gt;&gt; </span>Vitals</td>
        </tr>
        <div id ="a1" runat ="server">
      <tr>
        <td height="428" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
          <!--DWLayoutTable-->
          <tr>
            <td width="20" rowspan="9" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td width="917" valign="top" style="height: 10px; text-align: center;"><img src="images1/img_spacer2.gif" width="2" height="10" />
                      <asp:Label ID="Label_message" runat="server" ></asp:Label></td>
                  <td width="20" rowspan="9" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td>&nbsp;</td>
          </tr>
          <tr>
            <td valign="top" style="height: 44px"><table width="100%" border="0" cellpadding="0" cellspacing="0" >
              <!--DWLayoutTable-->
              <tr>
                <td height="23" valign="middle" class="text_nameheading" style="width: 280px">&nbsp;&nbsp;
                    <asp:Label ID="labelPName" runat="server" CssClass="text_boxtitle" Width="350px"></asp:Label></td>
                      <td width="149" align="right" valign="middle" >Date of Birth :&nbsp; </td>
                      <td width="163" valign="middle" >
                          <asp:Label ID="LabelDOB" runat="server" Width="140px"></asp:Label></td>
              <td width="116" align="right" valign="middle"><span >PIN No.  :&nbsp; </span></td>
              <td width="179" valign="middle"><span >
                  <asp:Label ID="LabelRegNo" runat="server" Text="Label" Width="127px"></asp:Label></span></td>
              </tr>
              <tr>
                <td valign="top" class="tabledotted_top" style="width: 280px; height: 25px">&nbsp;&nbsp;<span ><asp:Label ID="LabelPSex"
                            runat="server" CssClass="text_boxtitle"></asp:Label>,
                          <asp:Label ID="LabelPAge" runat="server" CssClass="text_boxtitle"></asp:Label> year </span></td>
                <td align="right" valign="middle" class="tabledotted_top" style="height: 25px"><span >N.I.C No.  :&nbsp;</span></td>
                <td valign="middle" class="tabledotted_top" style="height: 25px"><span >
                  <asp:Label ID="LabelCNIC" runat="server" Text="Label" Width="143px"></asp:Label></span></td>
              <td align="right" valign="middle" class="tabledotted_top" style="height: 25px"><span >&nbsp;</span></td>
              <td valign="middle" class="tabledotted_top" style="height: 25px"><span >&nbsp;
                  </span></td>
              </tr>
            </table></td>
            <td valign="top" style="height: 44px"></td>
                </tr>
          
          <tr>
            <td height="13" align="right" valign="top"><img src="images1/img_shedow.gif" width="249" height="13" /></td>
            <td>&nbsp;</td>
          </tr>
            <tr>
                <td style="height: 23px" valign="middle">
                    <asp:DataList ID="DataListtemplate" runat="server" DataKeyField="Template_id"
                DataSourceID="SqlDataSourceTemplate" RepeatColumns="5" Style="position: static"
                Width="896px" RepeatDirection="Horizontal">
                        <ItemTemplate>
                            <asp:LinkButton ID="SelectButton" runat="server" CommandName="Select" CssClass="login_link"
                                ForeColor="Blue" Style="position: static" Text='<%# Eval("Template_Name", "{0}") %>'></asp:LinkButton>
                        </ItemTemplate>
                        <SeparatorStyle BorderWidth="1px" CssClass="griditem" />
                    </asp:DataList><asp:SqlDataSource ID="SqlDataSourceTemplate" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                        SelectCommand="SELECT Admin_Assign_Template.Template_Id, Admin_Template.Template_Name FROM Admin_Assign_Template INNER JOIN Admin_Template ON Admin_Assign_Template.Template_Id = Admin_Template.Template_Id WHERE (Admin_Assign_Template.subdept_id = @subdeptid)&#13;&#10;and  (Admin_Assign_Template.dept_id = @deptid)">
                        <SelectParameters>
                            <asp:SessionParameter Name="subdeptid" SessionField="SubDeptID" />
                            <asp:SessionParameter Name="deptid" SessionField="dept_id" />
                        </SelectParameters>
                    </asp:SqlDataSource>                </td>
                <td>&nbsp;</td>
            </tr>
          
          <tr>
            <td valign="middle" style="height: 23px">
                &nbsp; Groups</td>
                <td>&nbsp;</td>
          </tr>
          
          <tr>
            <td valign="top" style="height: 186px"> <asp:DataList ID="DataListMainGroup" runat="server" DataKeyField="MG_Code"
                DataSourceID="SqlDataSourceMainGroup" RepeatColumns="5" Style="position: static"
                Width="896px" RepeatDirection="Horizontal">
              <ItemTemplate>
                <span class="login_link">&nbsp;
                <asp:LinkButton ID="SelectButton" runat="server" CommandName="Select" Style="position: static"
                        Text='<%# Eval("MG_Name", "{0}") %>' CssClass="login_link" ForeColor="Blue" ></asp:LinkButton>
                </span></ItemTemplate>
            </asp:DataList><asp:SqlDataSource ID="SqlDataSourceMainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                SelectCommand="SELECT DISTINCT Admin_Template_Vital_Elements.MainGroup_Id AS MG_Code, admin_Vital_MainGroup.MG_Name FROM Admin_Template_Vital_Elements INNER JOIN admin_Vital_MainGroup ON Admin_Template_Vital_Elements.MainGroup_Id = admin_Vital_MainGroup.MG_Code WHERE (Admin_Template_Vital_Elements.Template_Id = @template_id)"> 
                <SelectParameters>
                    <asp:ControlParameter ControlID="DataListtemplate" Name="template_id" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
              <asp:Label  Font-Bold="True" Font-Size="Medium" ID="LabelMainGroup" runat="server"></asp:Label>&nbsp;&nbsp;<br />
                <div id ="Check_Table" style="width: 895px; position: static;
                    height: 15px; text-align: center">
                <asp:TextBox ID="TextBox1" runat="server" BorderStyle="None" BorderWidth="0px"  ForeColor="white"  ReadOnly="True" Width="904px" style="text-align: center">.</asp:TextBox><br />
                    <asp:Button ID="ButtonYes" runat="server" Text="Yes" style="visibility: hidden" CssClass="bt1up" />
                    <asp:Button ID="ButtonNo" runat="server" Text="No" style="visibility: hidden" CssClass="bt1up" /></div>
              <asp:Panel ID="Panel1" runat="server" Height="50px" Width="850px" Css>
                  </asp:Panel>
                <asp:Panel ID="Panel2" runat="server" Height="50px" Width="300px">
                </asp:Panel>            </td>
            <td>&nbsp;</td>
          </tr>
            <tr>
            
                <td align="center" valign="middle" style="height: 57px">
                    <asp:GridView ID="GridView1" runat="server"  AllowPaging="True" AutoGenerateColumns="False" DataSourceID="SqlDataSourceForGrid">
                        <SelectedRowStyle CssClass="GridItem" />
                        <HeaderStyle CssClass="GridHeader" />
                        <AlternatingRowStyle CssClass="GridAltItem" />
                        <Columns>
                            <asp:BoundField DataField="MG_Name" HeaderText="Vital Group" SortExpression="MG_Name" />
                            <asp:BoundField DataField="e_Name" HeaderText="Vital Name" SortExpression="e_Name" />
                            <asp:BoundField DataField="ExamResult" HeaderText="Result" SortExpression="ExamResult" />
                            <asp:BoundField DataField="Date" HeaderText="Date" ReadOnly="True" SortExpression="Date" />
                            <asp:BoundField DataField="Time" HeaderText="Time" ReadOnly="True" SortExpression="Time" />
                            <asp:BoundField DataField="YearlyNo" HeaderText="YearlyNo" SortExpression="YearlyNo"
                                Visible="False" />
                            <asp:BoundField DataField="RegNo" HeaderText="RegNo" SortExpression="RegNo" Visible="False" />
                        </Columns>
                    </asp:GridView>
                    <br />
                    <asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT     admin_Vital_MainGroup.MG_Name, admin_Vital_Elements.e_Name, Pt_vital_SaveRecord.ExamResult,convert(varchar,Pt_vital_SaveRecord.DateTme,103) as [Date],  convert(varchar,Pt_vital_SaveRecord.DateTme,108) as [Time],&#13;&#10;                      Pt_vital_SaveRecord.YearlyNo, Pt_vital_SaveRecord.RegNo&#13;&#10;FROM         admin_Vital_MainGroup INNER JOIN&#13;&#10;                      admin_Vital_Elements ON admin_Vital_MainGroup.MG_Code = admin_Vital_Elements.MG_Code INNER JOIN&#13;&#10;                      Pt_vital_SaveRecord ON admin_Vital_Elements.e_Code = Pt_vital_SaveRecord.e_Code LEFT OUTER JOIN&#13;&#10;                      Admin_Vital_Methods ON admin_Vital_Elements.e_Code = Admin_Vital_Methods.Vital_Id&#13;&#10;WHERE     (Pt_vital_SaveRecord.YearlyNo = @YearlyNo) AND (Pt_vital_SaveRecord.RegNo = @RegNo)">
                        <SelectParameters>
                            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                            <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <br />
                    <asp:Button ID="Button1" runat="server" Text="Save" Width="150px"  />
                    <asp:Button ID="ButtonNext_Patient" runat="server" Text="Next Patient"
                        Width="150px" />
                    <span style="height: 50px">&nbsp;
                    <asp:SqlDataSource ID="SqlDataSourcehistory" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT admin_History_MainGroup.MG_Name, admin_History_Elements.e_Name, Pt_history_SaveRecord.ev_Code, Pt_history_SaveRecord.YearlyNo, Pt_history_SaveRecord.RegNo, CONVERT (varchar, Pt_history_SaveRecord.DateTme, 107) AS Date, CONVERT (varchar, Pt_history_SaveRecord.DateTme, 108) AS Time, Pt_history_SaveRecord.Emp_ID, admin_History_MainGroup.MG_Code, Pt_history_SaveRecord.ID FROM admin_History_Elements INNER JOIN admin_History_MainGroup ON admin_History_Elements.MG_Code = admin_History_MainGroup.MG_Code INNER JOIN Pt_history_SaveRecord ON admin_History_Elements.e_Code = Pt_history_SaveRecord.e_Code WHERE (Pt_history_SaveRecord.YearlyNo = @yearlyno) AND (Pt_history_SaveRecord.RegNo = @regno) ORDER BY admin_History_MainGroup.Priority, Pt_history_SaveRecord.DateTme" DeleteCommand="DELETE FROM Pt_history_SaveRecord WHERE (ID = @ID)">
                      <SelectParameters>
                        <asp:SessionParameter Name="yearlyno" SessionField="YearlyNo" Type="Decimal" />
                        <asp:SessionParameter Name="regno" SessionField="registrationNo" Type="String" />
                      </SelectParameters>
                      <DeleteParameters>
                        <asp:ControlParameter ControlID="GridView1" Name="ID" PropertyName="SelectedValue" />
                      </DeleteParameters>
                    </asp:SqlDataSource>
                    <asp:Button ID="Button612" runat="server" CssClass="bt1up" Text="Save12"     style="visibility: hidden"/>                    
                    </span></td>
                <td>&nbsp;</td>
            </tr>
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td height="83" valign="top"><asp:ImageButton ID="ImageButtonHome" runat="server" ImageUrl="images/image_bt_home.gif" Visible="false"/>
              <asp:ImageButton ID="ImageButtonBack" runat="server" ImageUrl="images/image_bt_back.gif"  Visible="false" />
              <asp:ImageButton ID="ImageButtonLogout" runat="server" ImageUrl="images/image_logout_up.gif"  Visible="false" />&nbsp;&nbsp;&nbsp;
                <asp:SqlDataSource ID="SqlDataSourceUpdate" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" UpdateCommand="UPDATE Forward_To_Sub_Dept SET dumypointer = NULL WHERE (Reg_No = @RegNO) AND (yearly_no = @yearlyNo) AND (status = 0) AND (request_type_id = 1)">
                    <UpdateParameters>
                        <asp:SessionParameter Name="RegNO" SessionField="registrationno" />
                        <asp:SessionParameter Name="yearlyNo" SessionField="yearlyno" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenFieldvalues" runat="server" />
                &nbsp;<br />
                <asp:HiddenField ID="HiddenFieldcigritepacks" runat="server" />
                <asp:HiddenField ID="HiddenFieldvaluesid" runat="server" />
          
              <asp:HiddenField ID="HiddenFieldlabels" runat="server" />
<asp:HiddenField ID="HiddenFieldmaingroup" runat="server" />
                <asp:HiddenField ID="HiddenFieldflag" runat="server" Value="true" /><asp:HiddenField ID="HiddenFieldCheck" runat="server" Value="true" />
                <asp:SqlDataSource ID="SqlDataSourcevaluestest" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT e_Code, ev_Code FROM Pt_history_SaveRecord WHERE (YearlyNo = 199940) AND (RegNo = 'LGH/211220060011')">                </asp:SqlDataSource>
                <asp:Label ID="LabelHigh"
                            runat="server" CssClass="text_boxtitle" Font-Bold="True" ForeColor="#000033" Visible="False"></asp:Label><asp:Label ID="LabelPulse" runat="server" Width="140px" Font-Bold="True" Visible="False"></asp:Label><asp:Label ID="LabelLow" runat="server" CssClass="text_boxtitle" Font-Bold="True" Visible="False"></asp:Label><asp:Label ID="LabelRR" runat="server" Width="143px" Font-Bold="True" Visible="False"></asp:Label>
                <span class="tabletabs" style="height: 32px">
                <asp:Button ID="Button2" runat="server" Text="History" CssClass="bttab1" onmousedown="this.className='bttab1down'" onmouseover="this.className='bttab1over'" onmouseout="this.className='bttab1down'" Visible="false"/>                
                <asp:Button ID="Button3" runat="server" Text="Physical Exam." CssClass="bttab1" onmousedown="this.className='bttab1down'" onmouseover="this.className='bttab1over'" onmouseout="this.className='bttab1down'" Visible="false"/>                
                <asp:Button ID="Button4" runat="server" Text="Plan" CssClass="bttab1" onmousedown="this.className='bttab1down'" onmouseover="this.className='bttab1over'" onmouseout="this.className='bttab1down'" Visible="false"/>                
                <asp:Button ID="Button5" runat="server" Text="Trend" CssClass="bttab1" onmousedown="this.className='bttab1down'" onmouseover="this.className='bttab1over'" onmouseout="this.className='bttab1down'" Visible="false"/>                
                <asp:Button ID="Button6" runat="server" Text="Psychology" CssClass="bttab1" onmousedown="this.className='bttab1down'" onmouseover="this.className='bttab1over'" onmouseout="this.className='bttab1down'" Visible="false"/>                
                <asp:Button ID="ButtonPatientProfile" runat="server" CssClass="bttab1" onmousedown="this.className='bttab1down'"
                onmouseout="this.className='bttab1down'" onmouseover="this.className='bttab1over'"
                Text="Patient Profile" Visible="false" />                
                <asp:Button ID="ButtonPatientPastProfile" runat="server" CssClass="bttab1" onmousedown="this.className='bttab1down'"
                onmouseout="this.className='bttab1down'" onmouseover="this.className='bttab1over'"
                Text="Patient Past Profile" Visible="false" />                
                <asp:Button ID="ButtonEyeObs" runat="server" CssClass="bttab1" onmousedown="this.className='bttab1down'"
                onmouseout="this.className='bttab1down'" onmouseover="this.className='bttab1over'"
                Text="Eye Observation" Visible="false" />                </span></td>
            <td>&nbsp;</td>
          </tr>
          <asp:HiddenField ID="HiddenFieldToolTIp" runat="server" Value="true" /><asp:HiddenField ID="HiddenField1" runat="server" Value="true" />
          
      
            
          </table></td><!-- </div>-->
          </tr>
    </table>
        </td>
    <td width="33" valign="top" class="right_border" style="width: 33px"><img src="images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_bottom.gif" alt="" width="1003" height="24" /></td>
  </tr>

  <tr>
    <td height="1"></td>
    <td></td>
    <td></td>
  </tr>
</table>



</form>
     
          
       
      
      
      
      
      
      
      
      
      
      
      
      
      
   
    
</body>
</html>