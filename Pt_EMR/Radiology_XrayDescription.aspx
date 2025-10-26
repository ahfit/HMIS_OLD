<%@ page language="C#" autoeventwireup="true" inherits="Radiology_XrayDescription, App_Web_jeeclgcn" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server" >
 <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
 
  <!--Styles -->
<link href="../css_hacims/class_reset.css"   rel="stylesheet"   type="text/css" media="screen, projection" />
<link href="../css_hacims/class_content.css" rel="stylesheet"   type="text/css" media="screen, projection" />
<!--[if IE]><link rel="stylesheet" href="../css_hacims/content_ie.css" type="text/css" media="screen, projection"/><![endif]-->
<link rel="icon" href="../images_hacims/favicon.ico"/>
<link rel="shortcut icon" href="../images_hacims/favicon.ico"/>
<!--Scripts-->
 <style  type="text/css" >
 
 body {background-color:none; background:none;}
 
 </style>
 
 </head>

<body >
<script type="text/javascript" src="../CommanMJAJAXLibrary.js">
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
        
            object1.open("GET","http://"+location.host+"/kih/xrayhandler.ashx?a="+argsName+"&b="+argsValue,false);
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
            object1.open("GET","http://"+location.host+"/kih/xrayhandler.ashx?a="+argsName+"&b="+argsValue,false);
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
                               str+="<img src='../XRay_Images/"+nodes[i].selectSingleNode("name/text()").nodeValue+ "' />";
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
var empID= document.getElementById('HiddenField_emp_id').value;
document.getElementById('wait').childNodes[0].nodeValue="please wait instaling";
//alert(reg+" "+yearly+" "+xray);

      if(object1)
        {
            object1.open("GET","http://"+location.host+"/kih/XRayInsertionHandler.ashx?a="+reg+"&b="+yearly+"&c="+xray+"&d="+empID,false);
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
<form id="form1" runat = "server">
<div id="wait" style="display:none;">.</div>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" width="50%"> <asp:ListBox DataTextField="Rd_body_part"
            DataValueField="Rd_body_part_id" Height="200px" ID="ListBox_bodypart"   runat="server" Width="98%" DataSourceID="SqlDataSource_Xray_MainParts" OnSelectedIndexChanged="ListBox_bodypart_SelectedIndexChanged" AutoPostBack="True" >
            </asp:ListBox></td>
    <td valign="top" width="50%">
        <asp:ListBox ID="ListBox_Xray_Projection" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_Rd_Xray" Width="98%"  Height="200px"
            DataTextField="Projections"  DataValueField="Projection_ID" OnSelectedIndexChanged="ListBox_Xray_Projection_SelectedIndexChanged">
        </asp:ListBox></td>
  </tr>
</table>

 
 <div id="markButton" style="display:none">
     </div>
                         
 <div id="acknowledgment" style="display:block">
 
 <asp:DataList ID="DataList_Characteristics" runat="server" DataSourceID="SqlDataSource_Characteristics"
         Width="98%">
         <ItemTemplate>
         <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="right" width="15%" style="border-bottom:#999 dotted 1px;  padding-bottom:15px; padding-top:15px;"><strong>Characteristics :&nbsp;</strong></td>
    <td style="border-bottom:#999 dotted 1px; padding-bottom:15px; padding-top:15px; padding-left:5px;" valign="top"><asp:Label ID="CharacteristicsLabel" runat="server" Text='<%# Eval("Characteristics") %>'></asp:Label></td>
  </tr>
</table>

             
      
             
         </ItemTemplate>
     </asp:DataList>
     <br />

     <div align="center"><asp:Button ID="Button_Mark" runat="server" OnClick="Button_Mark_Click" Text="Mark" /></div>

<br />
     <asp:DataList ID="DataList_Images" runat="server" DataSourceID="SqlDataSource_Images"
         Width="98%">
         <ItemTemplate>
              
          <asp:Image ID="Image1" runat="server"   ImageUrl='<%# Eval("images", "{0}") %>'
                   /><br />
         </ItemTemplate>
     </asp:DataList></div>
                 
 <div  id="text" align="left" style="width:98%" language="javascript" onclick="return text_onclick()">...</div>
 <div id="picDiv" align="center" style="width 98%">&nbsp;...</div>
     
  <asp:SqlDataSource ID="SqlDataSource_Xray_MainParts" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Admin_Rad_ConnectionString.ProviderName %>" SelectCommand="Rd_Select_Body_Parts"
                SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="" Name="bodypart" QueryStringField="bodypart"
                Type="String" />
        </SelectParameters>
      </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Characteristics" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Admin_Rad_ConnectionString.ProviderName %>"
        SelectCommand="RD_select_characteristics" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ListBox_Xray_Projection" Name="Projection_ID" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Insert_Images" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
        InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
        SelectCommand="Pt_insert_XRay" SelectCommandType="StoredProcedure" InsertCommand="Pt_insert_XRay">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_Reg_No" Name="Reg_No" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="HiddenField_Yearly_No" Name="Yearly_No" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="ListBox_Xray_Projection" Name="XRay_ID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:SessionParameter Name="Emp_ID" SessionField="Emp_Id" Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenField_Reg_No" Name="Reg_No" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="HiddenField_Yearly_No" Name="Yearly_No" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="ListBox_Xray_Projection" Name="XRay_ID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:SessionParameter Name="Emp_ID" SessionField="Emp_Id" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenField_Reg_No" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Images" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Admin_Rad_ConnectionString.ProviderName %>"
        SelectCommand="RD_select_Images" SelectCommandType="StoredProcedure" InsertCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ListBox_Xray_Projection" Name="Projection_ID" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenField_Yearly_No" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Rd_Xray" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Admin_Rad_ConnectionString.ProviderName %>"
        SelectCommand="RD_select_Xray" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ListBox_bodypart" Name="body_part_id" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_emp_id" runat="server" />
        <br />

</form>

 

</body>
</html>
