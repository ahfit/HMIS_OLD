<%@ page language="VB" autoeventwireup="false" inherits="Administrator_Check_query, App_Web_plqsd34j" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Lahore General Hospital</title>
<link href="../images1/st_sheet_01.css" rel="stylesheet" type="text/css" />


<script language="javascript" type = "text/javascript" >
function Query()
    {
//     var i ="_1";
//     alert(document.getElementById("RadioButtonList1" + i).value);
//        if ((document.getElementById("RadioButtonList1_0").checked) == true)
//        {
//        alert("true");
//        }
//         else
//        {
//        alert("true123");
//        }
//    var Operator1 =document.getElementById ("HiddenFieldOperater1").value ;
//    var value1 = document.getElementById ("HiddenFieldValue1").value ;
//   
//    var Run_Query= document.getElementById ("HiddenFieldMain").value ;
//   
//   document.getElementById ("HiddenFieldPhysicalExam").value = "where (Payment.PayID in (Select yearlyno from Pt_dmc_Phy_SaveRecord where (Payment.PayID=Pt_dmc_Phy_SaveRecord.yearlyno)and (Pt_dmc_Phy_SaveRecord.e_id=" + document.getElementById("DropDownListElement").value + ")and (Pt_dmc_Phy_SaveRecord.exam_result" + document.getElementById ("RadioButtonList1").text  + "'" + + "')))"
//   
//    Run_Query = Run_Query + document.getElementById ("HiddenFieldPhysicalExam").value; 
//     alert(Run_Query);
Require_Values();
      return false;
   }
    function Require_Values()
    {
//    alert(document.getElementById("HiddenFieldCount").value);
    var value1;
    var operator1;
    var value2; 
          for(var i=0;i<3;i++)
       {
            if(document.getElementById ("RadioButtonList1_"+i).checked == true)
            {
              operator1 =document.getElementById ("RadioButtonList1_"+i).value + " ";
              if (i ==0)
                 { 
                 value1 ="'" + document.getElementById ("TextBoxEqual1").value + "'"; 
                 value2 =document.getElementById ("TextBoxEqual1").value; 
                 }
                  if (i ==1)
                 { 
                 value1 ="'%" + document.getElementById ("TextBoxLike1").value + "%'"; 
                 value2 =document.getElementById ("TextBoxLike1").value ;
                 }
                  if (i ==2)
                 { 
                 value1 = " " + document.getElementById ("TextBoxGreater1").value + " "; 
                 value2 =document.getElementById ("TextBoxGreater1").value ; 
                 }
                  if (i ==3)
                 { 
                 value1 = " " + document.getElementById ("TextBoxLess1").value + " "; 
                 value2 = document.getElementById ("TextBoxLess1").value ;
                 }
             }
         } 
      var Run_Query= document.getElementById ("HiddenFieldMain").value ;
      var Run_Query1= document.getElementById ("HiddenFieldMain").value + '#';
      //alert("This is var1" + Run_Query1);
               if ((document.getElementById("HiddenFieldCount").value == 0) && (document.getElementById ("DropDownListCategory_Name").value =='Histories'))
                    {
                    document.getElementById ("HiddenFieldHistory").value =" Where(Payment.PayID in (Select yearlyno from Pt_history_SaveRecord where (Payment.PayID=Pt_history_SaveRecord.yearlyno)and (Pt_history_SaveRecord.e_code=" + document.getElementById("DropDownListElement").value + ")and (Pt_history_SaveRecord.ev_code " + operator1 + value1 + ")))";     
                    Run_Query = Run_Query + document.getElementById ("HiddenFieldHistory").value;
                    Run_Query1 = Run_Query1 + document.getElementById ("HiddenFieldHistory").value + "#"; 
                    document.getElementById ("HiddenFieldvalue1").value = document.getElementById ("HiddenFieldvalue1").value + Run_Query;
                    document.getElementById ("HiddenFieldTest").value = document.getElementById ("HiddenFieldTest").value + Run_Query1;
                   //  alert("This is var1" + document.getElementById ("HiddenFieldTest").value);
                    }    
               if ((document.getElementById("HiddenFieldCount").value == 0) && (document.getElementById ("DropDownListCategory_Name").value =='Physical Examination'))
                    {
                    document.getElementById ("HiddenFieldPhysicalExam").value = " where (Payment.PayID in (Select yearlyno from Pt_dmc_Phy_SaveRecord where (Payment.PayID=Pt_dmc_Phy_SaveRecord.yearlyno)and (Pt_dmc_Phy_SaveRecord.e_id=" + document.getElementById("DropDownListElement").value + ")and (Pt_dmc_Phy_SaveRecord.exam_result " + operator1 + value1 + ")))";
                    Run_Query = Run_Query + document.getElementById ("HiddenFieldPhysicalExam").value; 
                    Run_Query1 = Run_Query1 + document.getElementById ("HiddenFieldPhysicalExam").value + "#"; 
                    document.getElementById ("HiddenFieldvalue1").value = document.getElementById ("HiddenFieldvalue1").value + Run_Query;
                    document.getElementById ("HiddenFieldTest").value = document.getElementById ("HiddenFieldTest").value + Run_Query1;
                    }
    
                        if ((document.getElementById("HiddenFieldCount").value != 0) && (document.getElementById ("DropDownListCategory_Name").value =='Histories'))
                             {
                             document.getElementById ("HiddenFieldHistory").value =" and(Payment.PayID in (Select yearlyno from Pt_history_SaveRecord where (Payment.PayID=Pt_history_SaveRecord.yearlyno)and (Pt_history_SaveRecord.e_code=" + document.getElementById("DropDownListElement").value + ")and (Pt_history_SaveRecord.ev_code " + operator1 + value1 + ")))";     
                             //Run_Query = Run_Query + document.getElementById ("HiddenFieldHistory").value; 
                             Run_Query =  document.getElementById ("HiddenFieldHistory").value; 
                             Run_Query1 = document.getElementById ("HiddenFieldHistory").value + "#"; 
                             document.getElementById ("HiddenFieldvalue1").value = document.getElementById ("HiddenFieldvalue1").value + Run_Query;
                             document.getElementById ("HiddenFieldTest").value = document.getElementById ("HiddenFieldTest").value + Run_Query1;
                             }
                        if ((document.getElementById("HiddenFieldCount").value != 0) && (document.getElementById ("DropDownListCategory_Name").value =='Physical Examination'))
                            {
                            document.getElementById ("HiddenFieldPhysicalExam").value = " and (Payment.PayID in (Select yearlyno from Pt_dmc_Phy_SaveRecord where (Payment.PayID=Pt_dmc_Phy_SaveRecord.yearlyno)and (Pt_dmc_Phy_SaveRecord.e_id=" + document.getElementById("DropDownListElement").value + ")and (Pt_dmc_Phy_SaveRecord.exam_result " + operator1 + value1 + ")))";
                            //Run_Query = Run_Query + document.getElementById ("HiddenFieldPhysicalExam").value; 
                            Run_Query = document.getElementById ("HiddenFieldPhysicalExam").value;
                            Run_Query1 = document.getElementById ("HiddenFieldPhysicalExam").value + "#";  
                            document.getElementById ("HiddenFieldvalue1").value = document.getElementById ("HiddenFieldvalue1").value + Run_Query;
                            document.getElementById ("HiddenFieldTest").value = document.getElementById ("HiddenFieldTest").value + Run_Query1;
                            }
                            var Myform = document.form1 ;
                            //document.write (Run_Query1 );
                            
                            document.getElementById("HiddenField1").value = document.getElementById("HiddenField1").value  + " Examination Type " + document.getElementById ("DropDownListCategory_Name").value + " Element Name " + Myform.DropDownListElement.options[Myform.DropDownListElement.selectedIndex].text + " " +  operator1 + " "+  value2 + "#";
                            //alert(document.getElementById("HiddenField1").value);
   //Run_Query = Run_Query + document.getElementById ("HiddenFieldPhysicalExam").value; 
   //document.getElementById ("HiddenFieldvalue1").value = document.getElementById ("HiddenFieldvalue1").value + Run_Query;
   //alert(Run_Query);
   //alert(document.getElementById ("HiddenFieldvalue1").value);
   //alert(document.getElementById ("HiddenFieldTest").value);
    document.getElementById("HiddenFieldCount").value= (document.getElementById("HiddenFieldCount").value) + 1;
    //alert(document.getElementById("HiddenFieldCount").value);
   }         
      



//            If RadioButtonList1.SelectedIndex = 0 Then
//                operator2 = "="
//                value2 = TextBoxEqual2.Text
//            ElseIf RadioButtonList1.SelectedIndex = 1 Then
//                operator2 = "Like"
//                value2 = TextBoxLike2.Text
//            ElseIf RadioButtonList2.SelectedIndex = 2 Then
//                operator2 = ">"
//                value2 = TextBoxGreater2.Text
//            ElseIf RadioButtonList2.SelectedIndex = 3 Then
//                operator2 = "<"
//                value2 = TextBoxLess2.Text
//            End If

   // }

</script>
</head>

<body  dir="ltr">

<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="../images1/img_border_top.gif" width="1003" height="24" /></td>
  </tr>
  <tr>
    <td width="23" height="550" valign="top" class="left_border"><img src="../images1/img_border_left.gif" width="23" height="15" /></td>
    <td width="957" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
        <td height="40" colspan="2" valign="top"><img src="../images1/top_header.jpg" width="957" height="100" /></td>
      </tr>
      <tr>
        <td height="25" colspan="2" align="right" valign="middle" class="lnks_bg"><a href="Check_query.aspx"  class="login_link">Refresh</a><span class="link_spliter">&nbsp;|&nbsp;</span><span class="link_spliter"><a href="../loginnew.aspx" class="login_link">Home</a><span class="link_spliter">&nbsp;|&nbsp;</span><span class="link_spliter"><a href="../hacims.aspx" class="login_link">About Hacims</a>&nbsp;|&nbsp;<a href="../helphacims.aspx" class="login_link">Help</a>&nbsp;|&nbsp;</span><a href="../login.aspx" class="login_link2">Logout</a>&nbsp;&nbsp;</td>
          </tr>
      <tr>
        <td width="20" height="32" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="937" valign="middle" class="text_heading_02">
                Administrator&gt;&gt; <span class="text_lables3">Select Patient By Query </span></td>
          </tr>
      
      
      
      
      
          <tr>
            <td height="453" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                <!--DWLayoutTable-->
                <tr>
                  <td width="20" rowspan="2" valign="top"><img src="../images1/img_spacer.gif" width="20" height="2" /></td>
                  <td width="917" height="10" valign="top"><img src="../images1/img_spacer2.gif" width="2" height="10" /></td>
                  <td width="20" rowspan="2" valign="top"><img src="../images1/img_spacer.gif" width="20" height="2" /></td>
                </tr>
                <tr>
                  <td height="449" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <!--DWLayoutTable-->
                      <tr>
                        <td width="1"></td>
                        <td width="916" height="68" valign="top" dir="ltr"><table width="100%" border="0" cellpadding="0" cellspacing="0"  >
                          <!--DWLayoutTable-->
                          <tr>
                            <td width="156" align="right" valign="middle"  style="text-align: right; height: 37px;"><strong>Select Category :&nbsp; </strong></td>
                              <td width="207" valign="middle" style="height: 37px"><asp:DropDownList AutoPostBack="True" Css ID="DropDownListCategory_Name" runat="server" Width="180px">
                                  <asp:ListItem>Histories</asp:ListItem>
                                  <asp:ListItem>Physical Examination</asp:ListItem>
                              </asp:DropDownList></td>
                              <td colspan="2" align="right"  valign="middle" style="height: 37px"><strong >&nbsp;Main Group :&nbsp;</strong></td>
                              <td width="223" valign="middle" style="height: 37px"><asp:DropDownList AutoPostBack="True" Css ID="DropDownListMainGroup" runat="server" Width="180px"> 
                              </asp:DropDownList></td>
                          </tr>
                          <tr>
                            <td align="right" valign="middle"  style="height: 30px">
                                Element Name :&nbsp;</td>
                              <td colspan="2" valign="middle" style="height: 30px">
                                  <asp:DropDownList AutoPostBack="True" Css ID="DropDownListElement" runat="server" Width="180px">
                                  </asp:DropDownList>
                              </td>
                              <td colspan="2" valign="middle" dir="ltr" style="height: 30px"><span style="height: 34px">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                              </span></td>
                            </tr>
                            <tr>
                                <td align="right"  height="30" valign="middle" dir="ltr">
                                </td>
                                <td colspan="2" valign="middle" dir="ltr" style="text-align: center">
                                    <table>
                                        <tr>
                                            <td rowspan="5" style="width: 52px">
                                                <asp:RadioButtonList ID="RadioButtonList1" runat="server" Height="124px" Width="53px">
                                                    <asp:ListItem Selected="True">=</asp:ListItem>
                                                    <asp:ListItem>Like</asp:ListItem>
                                                    <asp:ListItem>&gt;</asp:ListItem>
                                                    <asp:ListItem>&lt;</asp:ListItem>
                                                </asp:RadioButtonList></td>
                                            <td style="width: 133px; height: 29px">
                                                <asp:TextBox ID="TextBoxEqual1" runat="server" Width="115px"></asp:TextBox></td>
                                            <td style="width: 99px; height: 29px">
                                            </td>
                                            <td rowspan="5" style="width: 45px">
                                                <asp:RadioButtonList ID="RadioButtonList2" runat="server" Height="124px" Width="53px" Visible="False">
                                                    <asp:ListItem Selected="True">=</asp:ListItem>
                                                    <asp:ListItem>Like</asp:ListItem>
                                                    <asp:ListItem>&gt;</asp:ListItem>
                                                    <asp:ListItem>&lt;</asp:ListItem>
                                                </asp:RadioButtonList></td>
                                            <td style="width: 124px; height: 29px">
                                                <asp:TextBox ID="TextBoxEqual2" runat="server" Width="115px" Visible="False"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 133px; height: 18px">
                                                <asp:TextBox ID="TextBoxLike1" runat="server" Width="115px"></asp:TextBox></td>
                                            <td rowspan="2" style="width: 99px; text-align: center">
                                                <asp:DropDownList Css ID="DropDownListOperater" runat="server" Width="60px" Visible="False">
                                                    <asp:ListItem>And</asp:ListItem>
                                                    <asp:ListItem>Or</asp:ListItem>
                                                    <asp:ListItem>None</asp:ListItem>
                                                </asp:DropDownList></td>
                                            <td style="width: 124px; height: 18px">
                                                <asp:TextBox ID="TextBoxLike2" runat="server" Width="115px" Visible="False"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 133px; height: 18px">
                                                <asp:TextBox ID="TextBoxGreater1" runat="server" Width="115px"></asp:TextBox></td>
                                            <td style="width: 124px; height: 18px">
                                                <asp:TextBox ID="TextBoxGreater2" runat="server" Width="115px" Visible="False"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 133px; height: 18px">
                                                <asp:TextBox ID="TextBoxLess1" runat="server" Width="115px"></asp:TextBox></td>
                                            <td style="width: 99px; height: 18px">
                                            </td>
                                            <td style="width: 124px; height: 18px">
                                                <asp:TextBox ID="TextBoxLess2" runat="server" Width="115px" Visible="False"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 133px; height: 10px">
                                            </td>
                                            <td style="width: 99px; height: 10px"><asp:Button ID="ButtonNext" runat="server" Width="100px" Text="OK" CssClass="bt2up"/></td>
                                            <td style="width: 124px; height: 10px">
                                            </td>
                                        </tr>
                                    </table>
                                    &nbsp; &nbsp; &nbsp;
                                    <asp:Button ID="ButtonViewQuery" runat="server" Width="100px" Text="View Query" CssClass="bt2up"/>
                                <asp:Button ID="ButtonViewResult" runat="server" Width="100px" Text="View Result" CssClass="bt2up"/>
                                    <asp:Button ID="ButtonDelete" runat="server" Width="100px" Text="Delete Last" CssClass="bt2up"/></td>
                                <td colspan="2" dir="ltr" valign="middle">
                                </td>
                            </tr>
                          <tr>
                            <td height="0" style="height: 23px"></td>
                            <td style="text-align: center; height: 23px;">
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                            </td>
                            <td width="70" style="height: 23px"></td>
                            <td width="57" style="height: 23px"></td>
                            <td style="height: 23px"></td>
                            </tr>
                          
                          
                          
                          
                          
                          
                          
                        </table>
                            <asp:HiddenField ID="HiddenFieldTest" runat="server" value =""/>
                        </td>
                      </tr>
                      <tr>
                        <td height="13" colspan="2" align="right" valign="top"><img src="../images1/img_shedow.gif" width="249" height="13" /></td>
                      </tr>
                      <tr>
                        <td height="22" colspan="2" valign="top" dir="ltr">
                        </td>
                      </tr>
                      <tr>
                        <td colspan="2" valign="top" dir="ltr" style="height: 344px"><span style="text-align: center">
                          <asp:GridView ID="GridViewElementValues" runat="server" AutoGenerateColumns="True"
                        AutoGenerateDeleteButton="False"
                        Width="100%"  Visible="True">
                            <FooterStyle CssClass="GridPager" />                          
                            <RowStyle CssClass="GridItem" />
                            <HeaderStyle CssClass="GridHeader" />                          
                            <AlternatingRowStyle CssClass="GridAltItem" />
                          </asp:GridView>
                            <br />
                            <asp:GridView ID="GridViewCheck" runat="server"
                        Width="100%" >
                                <FooterStyle CssClass="GridPager" />
                                <RowStyle CssClass="GridItem" />
                                <HeaderStyle CssClass="GridHeader" />
                                <AlternatingRowStyle CssClass="GridAltItem" />
                            </asp:GridView>
                          <asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                DeleteCommand="DELETE FROM admin_history_ElementValue WHERE (ev_Code = @ev_Code)"
                ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>">
                            <DeleteParameters>
                              <asp:ControlParameter ControlID="GridViewElementValues" Name="ev_Code" PropertyName="SelectedValue" />
                            </DeleteParameters>
                          </asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>" ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>">
                          </asp:SqlDataSource><asp:SqlDataSource ID="SqlDataSourceMainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>" ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>">
                          </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSourceElement" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>" ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>"></asp:SqlDataSource>
                            <asp:HiddenField ID="HiddenFieldOperater1" runat="server" />
                        </span>
                            <asp:HiddenField ID="HiddenFieldValue1" runat="server" />
                            <asp:HiddenField ID="HiddenFieldMain" runat="server" Value ="abc"/><asp:HiddenField ID="HiddenFieldPhysicalExam" runat="server" Value ="abc"/>
                            <asp:HiddenField ID="HiddenFieldHistory" runat="server" Value ="abc"/>
                            <asp:HiddenField ID="HiddenFieldSelectExam" runat="server" Value ="abc"/><asp:HiddenField ID="HiddenFieldCount" runat="server" Value ="0"/>
                            <asp:HiddenField ID="HiddenField1" runat="server" />
                            &nbsp;
                        </td>
                      </tr>
                      
                      
                      
                      
                      
                      
                      

                      
                      
                      

                      
                      
                      
                      
                      
                      
                      

                      
                  </table></td>
                </tr>
                
                
                
                

                
                
                
                
                
                
                
                

          
          
          
          
          
          
            </table></td>
          </tr>
      
      
      
      
      
      
      
      
      
      
            
    </table></td>
    <td width="32" valign="top" class="right_border" ><img src="../images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  
  <tr>
    <td height="24" colspan="3" valign="top"><img src="../images1/img_border_bottom.gif" width="1003" height="24" /></td>
  </tr>
</table>
<script type="text/javascript" src="../images1/flash_01.js"></script>
</form>
</body>
</html>
