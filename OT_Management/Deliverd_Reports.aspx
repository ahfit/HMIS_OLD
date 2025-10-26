<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Deliverd_Reports.aspx.vb" Inherits="Deliverd_Reports" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Lahore General Hospital</title>
<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
<script language ="javascript" type ="text/javascript" >
function Validation()
{
        var PFName = document.getElementById("textboxrfname").value;
        var PMName = document.getElementById("textboxrmname").value;
        var RFName = document.getElementById("textboxrffname").value;
        var RMName = document.getElementById("textboxrfmname").value;
        if(PFName.length==0)  
        {      
            alert("Please Enter Patient Relative  First Name");
            document.getElementById("textboxrfname").focus();
            return false;
        } 
        if(RFName.length==0)  
        {      
            alert("Please Enter Patient Relative  First Name");
            document.getElementById("textboxrffname").focus();
            return false;
        }
        if(PFName.length!=0)  
        {      
            for (i=0;i<PFName.length;i++)
            {
                if(PFName.charAt(i)>=0 || PFName.charAt(i)<=9)
                {
                alert("Integer not allowed in Patient Relative  First Name");
                document.getElementById("textboxrfname").focus();
                return false;
                }
            }
        }    
        if(PMName.length!=0)        
        {
            for (i=0;i<PMName.length;i++)
            {
                if(PMName.charAt(i)>=0 || PMName.charAt(i)<=9)
                {
                alert("Integer not allowed in Patient Relative  First Name");
                document.getElementById("textboxrmname").focus();
                return false;
                }
            }
        }    
        if(RFName.length!=0)        
        {
            for (i=0;i<RFName.length;i++)
            {
                if(RFName.charAt(i)>=0 || RFName.charAt(i)<=9)
                {
                alert("Integer not allowed in Patient Relative  First Name");
                document.getElementById("textboxrffname").focus();
                return false;
                }
            }
        }
        if(RMName.length!=0)        
        {
            for (i=0;i<RMName.length;i++)
            {
                if(RMName.charAt(i)>=0 || RMName.charAt(i)<=9)
                {
                alert("Integer not allowed in Patient Relative  First Name");
                document.getElementById("textboxrfmname").focus();
                return false;
                }
            }
        } 
}
function getQueryVariable(variable,variable1) 
{
var TCID; 
var regno;
var yearlyno;
var query = window.location.search.substring(1); 
var vars = query.split("&"); 
    for (var i=0;i<vars.length;i++) 
    { 
   var  pair = vars[i].split("="); 
        if (pair[0] == variable) 
        { 
        regno = pair[1]
        } 
    } 
     var querys = window.location.search.substring(1); 
var varss = querys.split("&"); 
    for (var i=0;i<varss.length;i++) 
    { 
     var pairs = varss[i].split("="); 
        if (pairs[0] == variable1) 
        { 
        yearlyno = pairs[1]
        } 
    } 
    var TGID =document.getElementById("HiddenField_TG_ID").value;
     
    var b= document.getElementById("GridView1").all;
    
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
                    var D_ID = Left(b[i].id,16) + "HiddenFieldTCID";
                    TCID = document.getElementById(D_ID).value; 
                }
                }
            }
          }  
         }    
   
    window.open("testpagepathology.aspx?RegNo=" + regno + "&YearlyNo=" + yearlyno+"&TGID="+TCID,"Mywindow","");
    return false;
} 

function Right(str, n)
{
    if (n <= 0)
       return "";
    else if (n > String(str).length)
       return str;
    else 
    {
       var iLen = String(str).length;
       return String(str).substring(iLen, iLen - n);
    }
}

function Left(str, n)
{
	if (n <= 0)
	    return "";
	else if (n > String(str).length)
	    return str;
	else
	    return String(str).substring(0,n);
}


</script>
</head>

<body>
<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_top.gif" width="1003" height="24" /></td>
  </tr>
  <tr>
    <td width="23" rowspan="2" valign="top" class="left_border"><img src="images1/img_border_left.gif" width="23" height="15" /></td>
    <td width="957" height="421" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
        <td width="957" height="97" valign="top"><iframe 
      src="../tabs.aspx" name="holder" width="957" marginwidth="0" height="97" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
          </tr>
      <tr>
        <td height="302" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="mainframe_bg1">
          <!--DWLayoutTable-->
          <tr>
            <td width="20" rowspan="3" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td width="916" height="10" valign="top"><img src="images1/img_spacer2.gif" width="2" height="10" /></td>
                  <td width="20" rowspan="3" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                </tr>
          <tr>
            <td height="23" valign="top" class="text_lables3" ><span class="text_lables3">Deliver Reports</td>
              </tr>
          <tr>
            <td height="269" valign="top"><table width="916" border="0" cellpadding="0" cellspacing="0" style="text-align: left">
                <tr>
                    <td align="right"  colspan="4" style="height: 33px" valign="middle">
                        <iframe id="holder1" class="text_lables3" frameborder="0" name="holder1" scrolling="no"
                            src="PatientBasicInfo_Iframe.aspx" style="width: 916px; height: 50px" width="930">
                        </iframe>
                    </td>
                </tr>
              <tr>
                <td colspan="4" align="right" valign="middle"  style="height: 17px" ><span class="text_lables3">
                  <asp:Label ID="Label_Message" runat="server" ForeColor="Red" Width="884px"></asp:Label>
                    &nbsp;
                  </span></td>
                      </tr>
                <tr>
                    <td colspan="4">
                  <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_Grid"
            Width="100%" cssclass="Grid" DataKeyNames="TGID">
                    <Columns>
                      <asp:BoundField DataField="RegNo" SortExpression="RegNo" HeaderText="Registration No"></asp:BoundField>
                      <asp:BoundField DataField="PayID" SortExpression="YearlyNo" HeaderText="Visit No"></asp:BoundField>
                      <asp:BoundField DataField="TGName" SortExpression="TGName" HeaderText="Test Group Name"></asp:BoundField>
                      <asp:BoundField DataField="TestName" SortExpression="TestName" HeaderText="Test Name" Visible="False"></asp:BoundField>
                      <asp:BoundField DataField="ComponentName" SortExpression="ComponentName" HeaderText="Component Name" Visible="False"></asp:BoundField>
                      <asp:TemplateField>
                        <ItemTemplate>
                          <asp:CheckBox ID="CheckBox1" runat="server" />                      
                          <asp:HiddenField ID="HiddenFieldTCID" runat="server" Value='<%# Bind("TGID", "{0}") %>' />
                          <asp:HiddenField ID="HiddenField1" runat="server" />
                          <asp:HiddenField ID="HiddenFieldTID" runat="server" Value='<%# Eval("TGID", "{0}") %>' />
                          </ItemTemplate>
                            </asp:TemplateField>
                      <asp:BoundField ReadOnly="True" DataField="TCID" InsertVisible="False" Visible="False" SortExpression="TCID" HeaderText="TCID"></asp:BoundField>
                      </Columns>
                    <HeaderStyle CssClass="GridHeader"></HeaderStyle>
                    <AlternatingRowStyle CssClass="GridAltItem"></AlternatingRowStyle>
                    </asp:GridView>
                  <asp:SqlDataSource ID="SqlDataSource_Grid" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
            ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT PatientsLabTest.RegNo, PatientsLabTest.PayID, TestGroup.TGName, TestGroup.TGID&#13;&#10;FROM         TestComponent INNER JOIN&#13;&#10;                      Test ON TestComponent.TID = Test.TID INNER JOIN&#13;&#10;                      TestGroup ON Test.TGID = TestGroup.TGID INNER JOIN&#13;&#10;                      PatientsLabTest ON Test.TID = PatientsLabTest.TID&#13;&#10;WHERE     (PatientsLabTest.RegNo = @RegNo) AND (PatientsLabTest.PayID = @YearlyNo)  and (PatientsLabTest.Status = 'Delivered')">
                    <SelectParameters>
                      <asp:QueryStringParameter Name="RegNo" QueryStringField="RegNo" />
                      <asp:QueryStringParameter Name="YearlyNo" QueryStringField="YearlyNo" />
                      </SelectParameters>
                    </asp:SqlDataSource>
                    </td>
                </tr>
              </table>              <p align="center">
                &nbsp;<asp:LinkButton ID="LinkButtonReport" runat="server" CssClass="bt1downnew" Font-Underline="False"
                          Height="22px">View Report</asp:LinkButton>
                &nbsp;
                </td>
                </tr>
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          </table>
                      <asp:HiddenField ID="HiddenField_TID" runat="server" />
          <asp:HiddenField ID="HiddenField_TG_ID" runat="server" />
            <asp:HiddenField ID="HiddenField2" runat="server" />
        </td>
          </tr>
      
</table></td>
    <td width="32" rowspan="2" valign="top" class="right_border" ><img src="images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  <tr>
    <td height="0"></td>
  </tr>
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_bottom.gif" width="1003" height="24" /></td>
  </tr>
</table>
<script type="text/javascript" src="images1/flash_01.js"></script>
</form>
</body>
</html>
