<%@ page language="C#" autoeventwireup="true" inherits="Radiology_XrayDescription1, App_Web_3j2dqz20" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
 <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title></title>
<link href="images/lgh_001.css" rel="stylesheet" type="text/css">
<link href="images/lgh_003.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
body {
	background-color: #FFFFFF;
}
-->
</style></head>

<body >
<script type="text/javascript" src="CommanMJAJAXLibrary.js">
////
</script>
<script type="text/javascript">
var object1= createXmlObject();
var argsName;
var argsValue;

function getList(from)
{

 document.getElementById('text').childNodes[0].nodeValue="";
 document.getElementById('wait').childNodes[0].nodeValue="please wait instaling";
    if(from.name =='ListBox_bodypart'){
    var Selectioncategory='ListBox_projections';
    argsName="xray";
    argsValue=from.value;
 
    document.getElementById('text').innerHTML="...";
    document.getElementById('picDiv').innerHTML="...";
    
    document.getElementById('markButton').style.display="none";
    document.getElementById('acknowledgment').style.display="none";
   }
   else{
     var Selectioncategory='text';
    argsName="characteristics";
    argsValue=from.value;
   }
    
  /////////////////////////////////////////////////////////////////////////      
        if(object1)
        {
        
            object1.open("GET","http://"+location.host+"/telemedicine/Patient_Treatment/xrayhandler.ashx?a="+argsName+"&b="+argsValue,false);
                object1.onreadystatechange=function()
                {
                              if(object1.readyState==COMPLETE)
                    {
                    document.getElementById('wait').childNodes[0].nodeValue="";
                            
                        var values=object1.responseXML;
                        var nodes = values.selectNodes("//root/collection"); 
                        var i=0;
                        var j=0;
                        var countryList = document.getElementById(Selectioncategory);
                        
                        if(Selectioncategory=='ListBox_projections')
                        {
                            while(i<countryList.length)
				            {
				            document.getElementById(Selectioncategory).removeChild(countryList[0]);
				            }
				        }else if(Selectioncategory=='text')
				        {
				            var str="<ul>";
				            
				        }
				        
                            while(i<nodes.length)
                            {
                                if(Selectioncategory=='ListBox_projections'){
                                
                                var newoption = document.createElement('option');
					            countryList.options.add(newoption);
					            newoption.text=nodes[i].selectSingleNode("name/text()").nodeValue;
					         
					            newoption.value=nodes[i].selectSingleNode("code/text()").nodeValue;
					           
					            }else
					            {
					            
					              
					           str+="<li>"+nodes[i].selectSingleNode("name/text()").nodeValue+"</li>";
					            }
					            i++;
                            }
                            
                            if(Selectioncategory=='text')
				        {
				            str+="</ul>";
				            document.getElementById('text').innerHTML=str;
				            getImages(from);
				        }
                    }
                }
            object1.send("SomeDataToSend");
            
        }
    ///////////////////////////////////////////////////////////////////////////////////////////////
   
    ///////////////////////////////////////////////////////////////////////////////////////////////        
}
function getImages(from)
{
    document.getElementById('markButton').style.display="block";
    document.getElementById('acknowledgment').style.display="block";
    document.getElementById('acknowledgment').childNodes[0].nodeValue="";
    document.getElementById('wait').childNodes[0].nodeValue="please wait instaling";
    
var argsName="image";
var argsValue=from.value;
      if(object1)
        {
            object1.open("GET","http://"+location.host+"/telemedicine/Patient_Treatment/xrayhandler.ashx?a="+argsName+"&b="+argsValue,false);
            object1.onreadystatechange=function()
               {
                   if(object1.readyState==COMPLETE)
                    {
                      document.getElementById('wait').childNodes[0].nodeValue="";
                        var values=object1.responseXML;
                        var nodes = values.selectNodes("//root/collection"); 
                        var i=0;
                        
                        var str="";
                        while(i<nodes.length)
                            {
                               str+="<img src='XRay_Images/"+nodes[i].selectSingleNode("name/text()").nodeValue+ "' />";
					            i++;
				             }
				         document.getElementById('picDiv').innerHTML=str;
                    }
                }
            object1.send("SomeDataToSend");
            
        }
    ///////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////        
}

function MarkXRay()
{
var reg=document.getElementById('HiddenField_Reg_No').value;
var yearly=document.getElementById('HiddenField_Yearly_No').value;
var xray=document.getElementById('ListBox_projections').value;
//alert(xray);
var empID= document.getElementById('HiddenField_emp_id').value;
document.getElementById('wait').childNodes[0].nodeValue="please wait instaling";
//alert(reg+" "+yearly+" "+xray);

      if(object1)
        {
            object1.open("GET","http://"+location.host+"/telemedicine/Patient_Treatment/XRayInsertionHandler.ashx?a="+reg+"&b="+yearly+"&c="+xray+"&d="+empID,false);
            object1.onreadystatechange=function()
               {
                   if(object1.readyState==COMPLETE)
                    {
                        document.getElementById('wait').childNodes[0].nodeValue="";
                        var values=object1.responseXML;
                        var nodes = values.selectNodes("//root/acknowlegment"); 
                        var i=0;
                        while(i<nodes.length)
                            {
                               document.getElementById('acknowledgment').childNodes[0].nodeValue=nodes[i].selectSingleNode("text()").nodeValue;
					            i++;
				             }
				        }
                }
            object1.send("SomeDataToSend");
            
        }
    ///////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////        
}

function text_onclick() {

}

</script>
<form id="form1" runat = "server" >
    <table width="600" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <!--DWLayoutTable-->
  <tr>
    <td style="width: 6px"></td>
    <td align="center" style="width: 322px"><div id="wait" style="display:none;">.</div></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td style="width: 6px; height: 97px;"></td>
    <td colspan="2" valign="top" align="center" style="height: 97px">
        <div style="text-align: center">
            <table>
                <tr>
                    <td style="width: 131px" align="center">
                        <asp:ListBox CssClass="text_labels_two" DataTextField="Rd_body_part"
            DataValueField="Rd_body_part_id" Height="170px" ID="ListBox_bodypart" runat="server" Width="300px" DataSourceID="SqlDataSource1" style="list-style-position: outside; list-style-type: square"></asp:ListBox></td>
                    <td style="width: 60px">
                        <asp:ListBox CssClass="text_labels_two" Height="170px" ID="ListBox_projections" runat="server" Width="300px">
    </asp:ListBox></td>
                </tr>
            </table>
        </div>
    </td>
    <td style="height: 97px"></td>
  </tr>
  <tr>
    <td style="width: 6px;"></td>
    <td align="center" style="width: 322px;"></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td style="width: 6px"></td>
    <td colspan="2" valign="top" align="center"></td>
    <td></td>
  </tr>
  <tr>
    <td style="height: 5px; width: 6px;"></td>
    <td style="height: 5px; width: 322px;" align="center"><table style="width: 100%; height: 100%">
            <tr>
                <td style="width: 26px">
                 <div id="markButton" style="display:none">
        <input id="Button1" type="button" value="Mark It" onclick="MarkXRay()"/></div>
                        </td>
                <td style="width: 491px" align=left>
                <div id="acknowledgment" style="display:block">
        ...
        </div>
                </td>
            </tr>
        </table></td>
    <td style="height: 5px"></td>
    <td style="height: 5px"></td>
  </tr>
  
  <tr>
    <td height="32" style="width: 6px"></td>
    <td valign="top" align="center" style="width: 322px">
    <div  id="text" align="left" style="width: 600px" language="javascript" onclick="return text_onclick()">
   ...    </div>
    <div id="picDiv" align="center" style="width 600px">
        &nbsp;...
    </div>
    </td>
    <td align="left"></td>
    <td></td>
  </tr>
  <tr>
    <td style="height: 19px; width: 6px;"></td>
    <td style="height: 19px; width: 322px;" align="center">
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
             DataSourceID="SqlDataSourceXray" PageSize="4">
            <Columns>
                <asp:BoundField DataField="Rd_body_part" HeaderText="Body Part" SortExpression="Rd_body_part" />
                <asp:BoundField DataField="Projection" HeaderText="Projection" SortExpression="Projection" />
                <asp:BoundField DataField="Time_Stamp" HeaderText="Time_Stamp" SortExpression="Time_Stamp" />
                <asp:BoundField DataField="Expr1" HeaderText="Expr1" SortExpression="Expr1" Visible="False" />
                <asp:BoundField DataField="Reg_No" HeaderText="Reg_No" SortExpression="Reg_No" Visible="False" />
                <asp:BoundField DataField="Yearly_No" HeaderText="Yearly_No" SortExpression="Yearly_No"
                    Visible="False" />
            </Columns>
            <RowStyle CssClass="GridItem" />
            <HeaderStyle CssClass="GridHeader" />
            <AlternatingRowStyle CssClass="GridAltItem" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceXray" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
            ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT Pt_Xray.XRay_ID AS Expr1, Rd_xray_projections.Projections AS Projection, Pt_Xray.Reg_No, Pt_Xray.Yearly_No, Pt_Xray.Time_Stamp, Rd_body_part.Rd_body_part FROM Pt_Xray INNER JOIN Rd_xray_projections ON Pt_Xray.XRay_ID = Rd_xray_projections.Projection_ID INNER JOIN Rd_body_part ON Rd_xray_projections.Rd_Body_part_Id = Rd_body_part.Rd_body_part_id WHERE (Pt_Xray.Reg_No = @regno) AND (Pt_Xray.Yearly_No = @yearlyno)">
            <SelectParameters>
                <asp:SessionParameter Name="regno" SessionField="registrationNo" />
                <asp:SessionParameter Name="yearlyno" SessionField="YearlyNo" />
            </SelectParameters>
        </asp:SqlDataSource>
        
       
       </td>
    <td style="height: 19px"></td>
    <td style="height: 19px"></td>
  </tr>
  
  

  <tr>
    <td style="height: 180px; width: 6px;"></td>
    <td colspan="2" valign="top" style="height: 180px" align="center">
   
    </td>
    <td style="height: 180px" align="left"></td>
  </tr>
  <tr>
    <td height="17" style="width: 6px"></td>
    <td align="center" style="width: 322px">
    
    </td>
    <td> </td>
    <td></td>
  </tr>
  
  
  <tr>
    <td height="41" style="width: 6px"></td>
    <td colspan="2" valign="top" align="center"><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="Rd_Select_Body_Parts"
                SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="" Name="bodypart" QueryStringField="bodypart"
                Type="String" />
        </SelectParameters>
      </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenField_Reg_No" runat="server" />
        <asp:HiddenField ID="HiddenField_Yearly_No" runat="server" /><asp:HiddenField ID="HiddenField_emp_id" runat="server" />
        &nbsp; &nbsp; &nbsp; &nbsp;
      &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;</td>
    <td></td>
  </tr>
  <tr>
    <td height="15" style="width: 6px"></td>
    <td align="center" style="width: 322px"></td>
    <td></td>
    <td></td>
  </tr>
</table>
</form>

 

</body>
</html>
