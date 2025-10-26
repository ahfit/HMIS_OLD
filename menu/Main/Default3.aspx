<%@ page language="VB" autoeventwireup="false" inherits="Default3, App_Web_ppbttiod" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    
    <script language="javascript" type="text/javascript">
       var xmlDoc = new ActiveXObject("Microsoft.XMLDOM"); 
       function main()
       {
        alert("sdfdfsf");
        loadXML('http://'+location.host+'/lgh/login.xml');
       }
          function loadXML(xmlFile) 
            { 
               xmlDoc.async="false"; 
               xmlDoc.onreadystatechange=verify; 
               xmlDoc.load(xmlFile); 
               xmlObj=xmlDoc.documentElement; 
               ReadContent(xmlObj)
            }   
          function verify() 
            { 
               // 0 Object is not initialized 
               // 1 Loading object is loading data 
               // 2 Loaded object has loaded data 
               // 3 Data from object can be worked with 
               // 4 Object completely initialized 
               if (xmlDoc.readyState != 4) 
                { 
                   return false; 
                } 
            }
            function ReadContent(tree)
            {
                var intNode,i;        
                var intCode,strValue;        
                if(tree.hasChildNodes())        
                {    
                                
                    var nodes=tree.childNodes(2).childNodes.length; 			                        
                    alert(nodes);
                    for(i=1;i<nodes;i++)               
                    {							                        
                        strValue=tree.childNodes(1).childNodes(i+1).text;                        
                        intValue=tree.childNodes(1).childNodes(i-1).text;                        
                        alert(strValue);
                        
                    }         
                }
            }
    </script>
</head>
<body onload="return main()">
    <form id="form1" runat="server">
    <div>
    <table id='Table_Phy_Exam' border='1' width ='850' style='text-align:left'>
    <span>
    <tr bgcolor='#ffcc66' font-size: 16pt; style='color: Black; font-weight: bold;'>
    <strong><td colspan='7' class='text_heading_01'>CBC</td></strong>
    </tr>
    </span>
    <span><tr bgcolor='#f8ffe0'></span>
    <span><td width ='10%' bgcolor='#ffccff' class='text_titles_01'></span>
    <span id="LabelT0020" style="display:inline-block;font-weight:bold;width:150px;">ESR</span>
    <span></span>
    <span><td width='10%' bgcolor='#ffccff' class='text_titles_01'>Apr 06, 2009 07:19:54<br /></span>
    <input name="TextBoxT0020" type="text" value="34" id="TextBoxT0020"  style="width:100px;" />
    <span  style="display:inline-block;width:50px;">
    <td width = 75' class ='text_titles_01'>Male:0-15 mm.hr,Female:0-20 mm.hr</td>
    </span>
    <span>
    </td></span>
    </table>
    </span>
    <span>
    <table id='Table1' border='1' width='850' style='text-align:left'>
    </span>
    <span>
    <tr bgcolor='#ffcc66' font-size: 16pt; style='color: Black; font-weight: bold;'>
    <strong>
    <td colspan='7' class='text_heading_01'>Absolute Values</td>
    </strong>
    </tr>
    </span>
    <span>
    <td class='text_titles_01'></span>
    <span>
    <td width ='10%' bgcolor='#ffccff' class='text_titles_01'>
    </span>
    <span id="LabelT0038" style="display:inline-block;font-weight:bold;width:150px;">RBC Count</span>
    <span>
    </td>
    </span>
    <span>
    <td width='10%' bgcolor='#ffccff' class='text_titles_01'>Apr 06, 2009 07:19:54<br />
    </span>
    <input name="TextBoxT0038" type="text" value="23" id="TextBoxT0038"  style="width:100px;" /><span  style="display:inline-block;width:50px;">
    <td width = 75' class ='text_titles_01'>4.2-5.9 millions/cmm</td>
    </span>
    <span>
    </td>
    </span>
    <span>
    </td>
    </span>
    <span>
    </table>
    </div>
    </form>
</body>
</html>
