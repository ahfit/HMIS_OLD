
<%@ page language="VB" autoeventwireup="false" CodeFile="Update_Patient_For_User.aspx.vb"  masterpagefile="~/hacims_masterpage_admin.master" 
    inherits="Update_Patient_For_User" 
    enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
 
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<script runat="server">

    Protected Sub fmvPatientInfo_PreRender(sender As Object, e As EventArgs)

    End Sub
</script>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script type="text/javascript">


    $(document).ready(function () {
        $(".captxt").keydown(function (event) {
         
            if (!(event.keyCode == 8
        || event.keyCode == 46
		|| event.keyCode == 9
		 || event.keyCode == 190
        || (event.keyCode >= 35 && event.keyCode <= 40)
         
 		|| (event.keyCode >= 65 && event.keyCode <= 90)
        )
        ) {
                event.preventDefault();
            }



        });
    });

</script>


<script type ="text/javascript"  language="javascript">

function getList_ot(from)
{
    if(from.value==null)
    {
    var Selectioncategory='ctl00_ContentPlaceHolder1_country_ot';
    argsName="cc";
    argsValue="ALL";
    }
        else if(from.name =='ctl00_ContentPlaceHolder1_country_ot')
        {
        var Selectioncategory='ctl00_ContentPlaceHolder1_Province_ot';
        argsName="pp";
        argsValue=from.value;
         document.getElementById('ctl00_ContentPlaceHolder1_textboxphonecode_ot').value=from.value;
        }
            else if(from.name =='ctl00_ContentPlaceHolder1_Province_ot')
        {
        var Selectioncategory='ctl00_ContentPlaceHolder1_district_ot';
        argsName="dd";
        argsValue=from.value;
         document.getElementById('ctl00_ContentPlaceHolder1_textboxphonecode_ot').value=from.value;
        }
         else if(from.name =='ctl00_ContentPlaceHolder1_district_ot')
        {
        var Selectioncategory='ctl00_ContentPlaceHolder1_tehsil_ot';
        argsName="tt";
        argsValue=from.value;
       
        
        }
        
    ///////////////////////////////////////////////////////////////////////////////////////////////
    if(from.value==null)
    {
    countryList= document.getElementById('ctl00_ContentPlaceHolder1_country_ot');
    getList_ot(countryList);
    }else if(from.name =='ctl00_ContentPlaceHolder1_country_ot')
    {
     ProvinceyList= document.getElementById('ctl00_ContentPlaceHolder1_Province_ot');
    getList_ot(ProvinceyList);
    }else if(from.name =='ctl00_ContentPlaceHolder1_Province_ot')
    {
    ProvinceyList= document.getElementById('ctl00_ContentPlaceHolder1_district_ot');
    getList_ot(ProvinceyList);
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////  
    document.getElementById('ctl00_ContentPlaceHolder1_HiddenField_country_ot').value= document.getElementById('ctl00_ContentPlaceHolder1_country_ot').value;
    document.getElementById('ctl00_ContentPlaceHolder1_HiddenField_province_ot').value= document.getElementById('ctl00_ContentPlaceHolder1_Province_ot').value;
    document.getElementById('ctl00_ContentPlaceHolder1_HiddenField_district_ot').value= document.getElementById('ctl00_ContentPlaceHolder1_district_ot').value;
    document.getElementById('ctl00_ContentPlaceHolder1_HiddenField_tehsil_ot').value= document.getElementById('ctl00_ContentPlaceHolder1_tehsil_ot').value;     
}
function setit_ot(a)
{
 document.getElementById('ctl00_ContentPlaceHolder1_HiddenField_tehsil_ot').value= document.getElementById('ctl00_ContentPlaceHolder1_tehsil').value;   
}



function main(a)
{
    //var Pt_Age = document.getElementById("ctl00_ContentPlaceHolder1_textboxage").value ;
//    if (Pt_Age == "")
//        {
//        alert("Enter Age");
//        document.getElementById("textboxage").focus();
//        alert(false)
//        return false;        
//        }
//     else
//        {
//            if((Pt_Age-0)!= Pt_Age)
//                {
//                alert("Only Integer Are Allowed");
//                document.getElementById("textboxage").focus();
//                alert(false)
//                return false;
//                }
//                
//           else if((Pt_Age >= 1) &&  (Pt_Age <= 150))
//                { 
//                }
//            else
//                {
//                alert("Enter Correct Age");
//                document.getElementById("textboxage").focus();
//                alert(false)
//                return false;
//                }
//        }
}
function show(a)
{
  
  
  var rbl_prefix =document.getElementById("<%=RBLprefix.ClientID%>");
  var rbl_prefix_value =  rbl_prefix.getElementsByTagName('input');
  var rbl_r =document.getElementById("<%=RBLrelation.ClientID%>");
  var rbl_r_value =  rbl_r.getElementsByTagName('input');
  
  var sex =document.getElementById("<%=sex.ClientID%>");
  
  sex.value=1;
    rbl_r_value[0].checked=true

    if(rbl_prefix_value[1].checked)
        {
  
           sex.value=2;
  
            rbl_r_value[1].checked=true;
            
        }

    if(rbl_prefix_value[2].checked)
        {
            sex.value=2;
        rbl_r_value[2].checked=true;
        }
}

function show_ot(a)
{
  
  
  var rbl_prefix =document.getElementById("<%=RBLprefix_ot.ClientID%>");
  var rbl_prefix_value =  rbl_prefix.getElementsByTagName('input');
 
  var rbl_r =document.getElementById("<%=RadioButtonList1_ot.ClientID%>");
  var rbl_r_value =  rbl_r.getElementsByTagName('input');
  
  
  
  
  var val =document.getElementById("<%=DropDownListRelationwithPatient_ot.ClientID%>");
  
  val.value="Son";
    rbl_r_value[0].checked=true;

    if(rbl_prefix_value[1].checked)
        {
  
           val.value="Daughter";
  
            rbl_r_value[1].checked=true;
            
        }

    if(rbl_prefix_value[2].checked)
        {
            val.value="Wife";
        rbl_r_value[1].checked=true;
        }
}

function resetform() 
{
    document.form1.reset();
    document.getElementById("ctl00_ContentPlaceHolder1_dropdownlistdiagnosis").focus(); 
}

function showFocus(a)
{
    document.getElementById("ctl00_ContentPlaceHolder1_dropdownlistdiagnosis").disabled =true;
}

function showFocus1(a)
{
    if(a.value.length!=0)
        {
        document.getElementById("ctl00_ContentPlaceHolder1_dropdownlistdiagnosis").disabled =true;
        }
    else
        {
        document.getElementById("ctl00_ContentPlaceHolder1_dropdownlistdiagnosis").disabled =false;
        }
}
function showAge(a)
{
    //document.getElementById("WebDateTimeEditDOB").disabled =true;
}
function showAge1(a)
{

}
function make_date_of_birth()
{

}

function checkrequiredname(a)
{
//        var PFName = document.getElementById("ctl00_ContentPlaceHolder1_textboxpfname").value;
//        var PMName = document.getElementById("ctl00_ContentPlaceHolder1_textboxpmname").value;
//        var PLName = document.getElementById("ctl00_ContentPlaceHolder1_textboxplname").value;
//        var RFName = document.getElementById("ctl00_ContentPlaceHolder1_textboxrfname").value;
//        var RMName = document.getElementById("ctl00_ContentPlaceHolder1_textboxrmname").value;
//        var RLName = document.getElementById("ctl00_ContentPlaceHolder1_textboxrlname").value;
//    if(document.getElementById("ctl00_ContentPlaceHolder1_textboxpfname").value.length==0)
//        {
//        alert("Enter first name");
//        document.getElementById("ctl00_ContentPlaceHolder1_textboxpfname").focus();
//        return false;
//        }
//    else 
//        {
//        for (i=0;i<PFName.length;i++)
//          {
//          if(PFName.charAt(i)>=0 || PFName.charAt(i)<=9)
//           {
//            alert("Integer not allowed in Patient First Name");
//            document.getElementById("ctl00_ContentPlaceHolder1_textboxpfname").focus();
//            return false;
//           }
//          }
//        }
//     if(document.getElementById("ctl00_ContentPlaceHolder1_textboxpmname").value.length!=0)
//        {
//        for (i=0;i<PMName.length;i++)
//          {
//          if(PMName.charAt(i)>=0 || PMName.charAt(i)<=9)
//           {
//            alert("Integer not allowed in Patient Middle Name");
//            document.getElementById("ctl00_ContentPlaceHolder1_textboxpmname").focus();
//            return false;
//           }
//          }
//        }
//     if(document.getElementById("ctl00_ContentPlaceHolder1_textboxplname").value.length!=0)
//        {
//        for (i=0;i<PLName.length;i++)
//          {
//          if(PLName.charAt(i)>=0 || PLName.charAt(i)<=9)
//           {
//            alert("Integer not allowed in Patient Last Name");
//            document.getElementById("ctl00_ContentPlaceHolder1_textboxplname").focus();
//            return false;
//           }
//          }
//        }
//   if(document.getElementById("ctl00_ContentPlaceHolder1_textboxrfname").value.length==0)
//        {
//        alert("Enter Relation first name");
//        document.getElementById("ctl00_ContentPlaceHolder1_textboxrfname").focus();
//        return false;
//        }
//    else 
//        {
//        for (i=0;i<RFName.length;i++)
//          {
//          if(RFName.charAt(i)>=0 || RFName.charAt(i)<=9)
//           {
//            alert("Enter the Correct Relation First Name");
//            document.getElementById("ctl00_ContentPlaceHolder1_textboxrfname").focus();
//            return false;
//           }
//          }
//        }
//    if(document.getElementById("ctl00_ContentPlaceHolder1_textboxrmname").value.length!=0)
//        {
//        for (i=0;i<RMName.length;i++)
//          {
//          if(RMName.charAt(i)>=0 || RMName.charAt(i)<=9)
//           {
//            alert("Integer not allowed in Patient Relation Middle Name");
//            document.getElementById("ctl00_ContentPlaceHolder1_textboxrmname").focus();
//            return false;
//           }
//          }
//        } 
//    if(document.getElementById("ctl00_ContentPlaceHolder1_textboxrlname").value.length!=0)
//        {
//        for (i=0;i<RLName.length;i++)
//          {
//          if(RLName.charAt(i)>=0 || RLName.charAt(i)<=9)
//           {
//            alert("Integer not allowed in Patient Relation Last Name");
//            document.getElementById("ctl00_ContentPlaceHolder1_textboxrlname").focus();
//            return false;
//           }
//          }
//        } 
//    if(document.getElementById("ctl00_ContentPlaceHolder1_textboxage").value.length==0)
//        {
//        alert("Enter Age");
//        document.getElementById("ctl00_ContentPlaceHolder1_textboxage").focus();
//        return false;
//        }
//    if(PFName -0 ==PFName)
//        {
//        alert("Enter the Correct Patient First Name");
//        document.getElementById("ctl00_ContentPlaceHolder1_textboxpfname").focus();
//        return false;
//        }
//        if((PMName.length-0) != 0)
//        {
//                if(PMName -0 ==PMName) 
//                {
//                alert("Enter the Correct Patient Last Name");
//                document.getElementById("ctl00_ContentPlaceHolder1_textboxpmname").focus();
//                return false;
//                }        
//        }
//    
//    if(RFName -0 ==RFName)
//        {
//        alert("Enter the Correct Patient Relation First Name");
//        document.getElementById("ctl00_ContentPlaceHolder1_textboxrfname").focus();
//        return false;
//        }
//    if((RMName.length-0) !=RMName)
//        {
//               if(RMName -0 ==RMName) 
//                {
//                alert("Enter the Correct Patient Relation Last Name");
//                document.getElementById("ctl00_ContentPlaceHolder1_textboxrmname").focus();
//                return false;
//                } 
//        }
//  if((document.getElementById("ctl00_ContentPlaceHolder1_textboxnic1").value.length !=0) || (document.getElementById("ctl00_ContentPlaceHolder1_textboxnic2").value.length !=0) || (document.getElementById("ctl00_ContentPlaceHolder1_textboxnic3").value !=0))
//  {
//    if(document.getElementById("ctl00_ContentPlaceHolder1_textboxnic1").value -0 !=document.getElementById("ctl00_ContentPlaceHolder1_textboxnic1").value) 
//        {
//         alert("Enter the Correct Patient Computerized National ID");
//         document.getElementById("ctl00_ContentPlaceHolder1_textboxnic1").focus();
//         return false;
//        } 
//    if(document.getElementById("ctl00_ContentPlaceHolder1_textboxnic1").value.length !=5) 
//        {
//         alert("Enter the Correct Patient Computerized National ID");
//         document.getElementById("ctl00_ContentPlaceHolder1_textboxnic1").focus();
//         return false;
//        }         
//    if(document.getElementById("ctl00_ContentPlaceHolder1_textboxnic2").value -0 !=document.getElementById("ctl00_ContentPlaceHolder1_textboxnic2").value)
//        {
//         alert("Enter the Correct Patient Computerized National ID");
//         document.getElementById("ctl00_ContentPlaceHolder1_textboxnic2").focus();
//         return false;
//        } 
//    if(document.getElementById("ctl00_ContentPlaceHolder1_textboxnic2").value.length !=7)
//        {
//         alert("Enter the Correct Patient Computerized National ID");
//         document.getElementById("ctl00_ContentPlaceHolder1_textboxnic2").focus();
//         return false;
//        }         
//    if(document.getElementById("ctl00_ContentPlaceHolder1_textboxnic3").value -0 !=document.getElementById("ctl00_ContentPlaceHolder1_textboxnic3").value)
//        {
//         alert("Enter the Correct Patient Computerized National ID");
//         document.getElementById("ctl00_ContentPlaceHolder1_textboxnic3").focus();
//         return false;
//        } 
//    if(document.getElementById("ctl00_ContentPlaceHolder1_textboxnic3").value.length !=1)
//        {
//         alert("Enter the Correct Patient Computerized National ID");
//         document.getElementById("ctl00_ContentPlaceHolder1_textboxnic3").focus();
//         return false;
//        } 
//    }    
//    if(document.getElementById("ctl00_ContentPlaceHolder1_textboxphonecode").value -0 != document.getElementById("ctl00_ContentPlaceHolder1_textboxphonecode").value)
//        {
//         alert("Enter the Correct Patient Phone City Code");
//         document.getElementById("ctl00_ContentPlaceHolder1_textboxphonecode").focus();
//         return false;
//        }     
//    if(document.getElementById("ctl00_ContentPlaceHolder1_textboxphoneno").value -0 !=document.getElementById("ctl00_ContentPlaceHolder1_textboxphoneno").value)
//        {
//         alert("Enter the Correct Patient Phone No.");
//         document.getElementById("ctl00_ContentPlaceHolder1_textboxphoneno").focus();
//         return false;
//        }  
//    if(document.getElementById("ctl00_ContentPlaceHolder1_textboxHouseNo").value -0 !=document.getElementById("ctl00_ContentPlaceHolder1_textboxHouseNo").value)
//        {
//         alert("Enter the Correct Patient House NO.");
//         document.getElementById("ctl00_ContentPlaceHolder1_textboxHouseNo").focus();
//         return false;
//        }    
// if(document.getElementById("ctl00_ContentPlaceHolder1_textboxzipcode").value.length !=0)
// {       
//    if(document.getElementById("ctl00_ContentPlaceHolder1_textboxzipcode").value -0 !=document.getElementById("ctl00_ContentPlaceHolder1_textboxzipcode").value)
//        {
//         alert("Enter the Correct Patient Postal Code");
//         document.getElementById("ctl00_ContentPlaceHolder1_textboxzipcode").focus();
//         return false;
//        }  
//    if(document.getElementById("ctl00_ContentPlaceHolder1_textboxzipcode").value.length !=5) 
//        {
//         alert("Enter the Correct Patient Postal Code ");
//         document.getElementById("ctl00_ContentPlaceHolder1_textboxzipcode").focus();
//         return false;
//        }  
//   }
//if((document.getElementById("ctl00_ContentPlaceHolder1_textboxmcode").value.length !=0) ||(document.getElementById("ctl00_ContentPlaceHolder1_textboxmno").value.length !=0))  
//{          
//    if(document.getElementById("ctl00_ContentPlaceHolder1_textboxmcode").value -0 !=document.getElementById("ctl00_ContentPlaceHolder1_textboxmcode").value)
//        {
//         alert("Enter the Correct Patient Mobile Code");
//         document.getElementById("ctl00_ContentPlaceHolder1_textboxmcode").focus();
//         return false;
//        } 
//    if(document.getElementById("ctl00_ContentPlaceHolder1_textboxmcode").value.length !=4) 
//        {
//         alert("Enter the Correct Patient Mobile Code ");
//         document.getElementById("ctl00_ContentPlaceHolder1_textboxmcode").focus();
//         return false;
//         var MCOde =document.getElementById("ctl00_ContentPlaceHolder1_textboxmcode").value; 
//         alert(MCOde);   
//       }     
//    if(document.getElementById("ctl00_ContentPlaceHolder1_textboxmcode").value.length ==4) 
//       {
//           var MCOde =document.getElementById("ctl00_ContentPlaceHolder1_textboxmcode").value; 
//           if(MCOde.charAt(0)!=0) 
//            {
//            alert("Enter the Correct Patient Mobile Code ");
//            document.getElementById("ctl00_ContentPlaceHolder1_textboxmcode").focus();
//            return false;
//            }   
//       }  
//    if(document.getElementById("ctl00_ContentPlaceHolder1_textboxmno").value -0 !=document.getElementById("ctl00_ContentPlaceHolder1_textboxmno").value)
//        {
//         alert("Enter the Correct Patient Mobile No. ");
//         document.getElementById("ctl00_ContentPlaceHolder1_textboxmno").focus();
//         return false;
//        }                     
//    if(document.getElementById("ctl00_ContentPlaceHolder1_textboxmno").value.length !=7) 
//        {
//         alert("Enter the Correct Patient Mobile No. ");
//         document.getElementById("ctl00_ContentPlaceHolder1_textboxmno").focus();
//         return false;
//        }         
//}        
// return ForAge();

}
function checkrequiredrfname(a)
{
    if(document.getElementById("ctl00_ContentPlaceHolder1_textboxrfname").value.length==0)
        {
        //alert("Enter first name");
        //document.getElementById("txtrfname").focus();
        }
}

function ForAge()
{
    var age;
    age = document.getElementById("ctl00_ContentPlaceHolder1_textboxage").value;
    if(age - 0 == age)
        {
        if((age >= 1) &&  (age <= 150))
            { 
            }
        else
            {
            alert("Enter Correct Age");
            document.getElementById("ctl00_ContentPlaceHolder1_textboxage").focus();
            return false;
            }
        }
    else
    {
    alert("Must Enter Integer ");
    document.getElementById("ctl00_ContentPlaceHolder1_textboxage").focus();
    return false; 
    }  
}
function ForName()
{
alert("Hello"); 
}
function Age_DateofBirth()
{
alert("Hello");
}

function showAgedob(val)
{
    
 var age =document.getElementById('<%=textboxage.ClientID%>').value;
var date;
date=igedit_getById('<%=WebDateTimeEdit_DOB.ClientID%>').getText();
 if (date == "")
{


}
else
{
    var year_type=document.getElementById('<%=DropDownListBIndicator.ClientID%>').value;
    var edit_date=document.getElementById('<%=WebDateTimeEdit_DOB.ClientID%>');
    
var strDate = new Date();

var date_val;

    if (year_type=="Years")
    {
    
    strDate.setFullYear( strDate.getFullYear () - age);
    
    
    }
    else if(year_type=="Months")
    {
    strDate.setMonth ( strDate.getMonth() + 1  - age);
    
    }
    else if(year_type=="Days")
    {
    strDate.setDate(strDate.getDate() - age);
     
    }
   else if(year_type=="Hours")
    {
         strDate.setHours(date_val=strDate.getHours()   - age);
     
    }
  

    igedit_getById('<%=WebDateTimeEdit_DOB.ClientID%>').setText(strDate.getDate() +"/"+(strDate.getMonth()+1) +"/"+strDate.getFullYear() );
}
  }
  
function changeYear()
{
    
 var age =document.getElementById('<%=textboxage.ClientID%>').value;
var date;
date=igedit_getById('<%=WebDateTimeEdit_DOB.ClientID%>').getText();
    var year_type=document.getElementById('<%=DropDownListBIndicator.ClientID%>').value;
    var edit_date=document.getElementById('<%=WebDateTimeEdit_DOB.ClientID%>');
    
var strDate = new Date();

var date_val;

    if (year_type=="Years")
    {
    
    strDate.setFullYear( strDate.getFullYear () - age);
    
    
    }
    else if(year_type=="Months")
    {
    strDate.setMonth ( strDate.getMonth() + 1  - age);
    
    }
    else if(year_type=="Days")
    {
    strDate.setDate(strDate.getDate() - age);
     
    }
   else if(year_type=="Hours")
    {
         strDate.setHours(date_val=strDate.getHours()   - age);
     
    }
  

    igedit_getById('<%=WebDateTimeEdit_DOB.ClientID%>').setText(strDate.getDate() +"/"+(strDate.getMonth()+1) +"/"+strDate.getFullYear() );

}

function showAgedobfocus()
{


    var age =document.getElementById('<%=textboxage.ClientID%>').value;
    var year_type=document.getElementById('<%=DropDownListBIndicator.ClientID%>').value;
var val =igedit_getById('<%=WebDateTimeEdit_DOB.ClientID%>').getText();
var mytool_array=val.split("/");
  
    val=mytool_array[1]+"/"+mytool_array[0]+"/"+mytool_array[2];
    var date = new Date(val);

if (age=="")
{
 if (date != "" && date != "Invalid Date")
{
var date1 = new Date();

var ageval =document.getElementById('<%=textboxage.ClientID%>');
if (year_type=="Years")
{
ageval.value =  Math.floor((date1  - date)/((24*60*60*1000)*30*12));
}
else if (year_type=="Months")
{
    ageval.value =  Math.floor((date1  - date)/((24*60*60*1000)*30));
}
else if (year_type=="Days")
{
    ageval.value =  Math.floor((date1  - date)/((24*60*60*1000)));
}
}
}

else if (date != "") 
{
if (date != "Invalid Date")
{

var date1 = new Date();
var ageval =document.getElementById('<%=textboxage.ClientID%>');
if (year_type=="Years")
{
    ageval.value =  Math.floor((date1  - date)/((24*60*60*1000)*30*12));
}
else if (year_type=="Months")
{
    ageval.value =  Math.floor((date1  - date)/((24*60*60*1000)*30));
}
else if (year_type=="Days")
{
    ageval.value =  Math.floor((date1  - date)/((24*60*60*1000)));
}
}
}

}






function showAgeyear(val)
{
alert("hello");

} 
</script>

 
<script src="../SpryAssets/mycollaps.js" type="text/javascript"></script>
<link href="../SpryAssets/mycollaps.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="../css_hacims/maskito.js"></script>
    
<script type="application/javascript">

$(document).ready(function () { 

 

  
  
   $("#ctl00_ContentPlaceHolder1_textboxmcode").mask("9999-9999999");
   $("#ctl00_ContentPlaceHolder1_textboxmcode_ot").mask("9999-9999999");
   
    $("#ctl00_ContentPlaceHolder1_textboxphoneno").mask("9999-9999999");
	 $("#ctl00_ContentPlaceHolder1_textboxphoneno_ot").mask("9999-9999999");
   
   
   $("#ctl00_ContentPlaceHolder1_textboxnic1").mask("99999-9999999-9");
   
 
   $("#ctl00_ContentPlaceHolder1_textboxnic1_ot").mask("99999-9999999-9");
    
 
});

</script> 
    
 

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


<script type="text/javascript" src="../CommanMJAJAXLibrary.js"></script>
<script type="text/javascript">
var object1= createXmlObject();
var argsName;
var argsValue;
//function getList(from)
//{
//    if(from.value==null)
//    {
//    var Selectioncategory='country';
//    argsName="cc";
//   argsValue="ALL";
//   document.getElementById('ctl00_ContentPlaceHolder1_textboxphonecode').value=from.value;
//   }
//       else if(from.name =='country')      
//         {
//        var Selectioncategory='Province';
//        argsName="pp";
//        argsValue=from.value;
//        document.getElementById('ctl00_ContentPlaceHolder1_textboxphonecode').value=from.value;
//        }
//            else if(from.name =='Province')
//        {
//        var Selectioncategory='district';
//        argsName="dd";
//        argsValue=from.value;
//        document.getElementById('ctl00_ContentPlaceHolder1_textboxphonecode').value=from.value;
//        }
//         else if(from.name =='district')
//        {
//        var Selectioncategory='tehsil';
//       argsName="tt";
//       argsValue=from.value;
//        document.getElementById('ctl00_ContentPlaceHolder1_textboxphonecode').value=from.value;
//        }
//        
////  /////////////////////////////////////////////////////////////////////////      
////        if(object1)
////        {
////        
////            object1.open("GET","http://203.175.76.250/szh/Hfindaddress.ashx?a="+argsName+"&b="+argsValue,false);
////            object1.onreadystatechange=function()
////                {
////                    if(object1.readyState==LOADING)

////			        {
////			            document.getElementById('wait').style.display="block";
////			            var mark = document.getElementById('wait');
////                        mark.style.left=event.clientX;
////                        mark.style.top=event.clientY;
////                        
////			        }
////			        
////                    if(object1.readyState==COMPLETE)
////                    {
////                        //alert(object1.readyState);
////                        document.getElementById('wait').style.display="none";
////                        var values=object1.responseXML;
////                        var nodes = values.selectNodes("//root/collection"); 
////                        //alert(values);
////                        var i=0;
////                        var countryList = document.getElementById(Selectioncategory);
////                       
////                        while(i<countryList.length)
////				        {
////				        document.getElementById(Selectioncategory).removeChild(countryList[0]);
////				        }
////                            while(i<nodes.length)
////                            {
////                                var newoption = document.createElement('option');
////					            countryList.options.add(newoption);
////					            newoption.text=nodes[i].selectSingleNode("name/text()").nodeValue;
////					            newoption.value=nodes[i].selectSingleNode("code/text()").nodeValue;
////                                i++;
////                            }
////                            
////                    }
////                }
////            object1.send("SomeDataToSend");
////        }
////    ///////////////////////////////////////////////////////////////////////////////////////////////
//    if(from.value==null)
//    {
//    countryList= document.getElementById('ctl00_ContentPlaceHolder1_country');
//   getList(countryList);
//    }else if(from.name =='country')
//    {
//     ProvinceyList= document.getElementById('ctl00_ContentPlaceHolder1_Province');
//    getList(ProvinceyList);
//    }else if(from.name =='Province')
//    {
//    ProvinceyList= document.getElementById('ctl00_ContentPlaceHolder1_district');
//    getList(ProvinceyList);
//    }
//    
////    ///////////////////////////////////////////////////////////////////////////////////////////////  
//    document.getElementById('ctl00_ContentPlaceHolder1_HiddenField_country').value= document.getElementById('ctl00_ContentPlaceHolder1_country').value;
//    document.getElementById('ctl00_ContentPlaceHolder1_HiddenField_province').value= document.getElementById('ctl00_ContentPlaceHolder1_Province').value;
//    document.getElementById('ctl00_ContentPlaceHolder1_HiddenField_district').value= document.getElementById('ctl00_ContentPlaceHolder1_district').value;
//    document.getElementById('ctl00_ContentPlaceHolder1_HiddenField_tehsil').value= document.getElementById('ctl00_ContentPlaceHolder1_tehsil').value;     
//}
function setit(a)
{
 document.getElementById('ctl00_ContentPlaceHolder1_HiddenField_tehsil').value= document.getElementById('ctl00_ContentPlaceHolder1_tehsil').value;   
}
</script>


 
 
 


<asp:ScriptManager ID="ScriptManager1" runat="server">
<Services>
                    <asp:ServiceReference Path="../autocomplete.asmx" />
             </Services>
    </asp:ScriptManager>
              <cc1:AutoCompleteExtender ID="AutoComplete_PFName" runat="server" CompletionInterval="10"
                      CompletionSetCount="12" EnableCaching="true" MinimumPrefixLength="3" ServiceMethod="GetCompletionList"
                      ServicePath="../AutoComplete.asmx" TargetControlID="textboxpfname">
              </cc1:AutoCompleteExtender>
              <cc1:AutoCompleteExtender ID="autoComplete_RFName" runat="server" CompletionInterval="10"
                      CompletionSetCount="12" EnableCaching="true" MinimumPrefixLength="3" ServiceMethod="GetCompletionList"
                      ServicePath="../AutoComplete.asmx" TargetControlID="textboxrfname">
              </cc1:AutoCompleteExtender>
               <cc1:AutoCompleteExtender ID="AutoComplete_PMName" runat="server" CompletionInterval="10"
                      CompletionSetCount="12" EnableCaching="true" MinimumPrefixLength="3" ServiceMethod="GetCompletionList"
                      ServicePath="../AutoComplete.asmx" TargetControlID="textboxpmname">
              </cc1:AutoCompleteExtender>
              <cc1:AutoCompleteExtender ID="AutoComplete_RMName" runat="server" CompletionInterval="10"
                      CompletionSetCount="12" EnableCaching="true" MinimumPrefixLength="3" ServiceMethod="GetCompletionList"
                      ServicePath="../AutoComplete.asmx" TargetControlID="textboxrmname">
              </cc1:AutoCompleteExtender>
    <asp:SqlDataSource ID="SqlDataSourcePatientType" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="SELECT Patient_Type_ID, Patient_Type FROM Patient_type WHERE (Active = 1)"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_parties" runat="server" ConnectionString="<%$ ConnectionStrings:PatientBilllingConnectionString %>"
        
        SelectCommand="SELECT Parties.Party_Id, Parties.Party_Name FROM Parties LEFT OUTER JOIN Patient_Billing_Party ON Parties.Party_Id = Patient_Billing_Party.Billing_Party_Id">
    </asp:SqlDataSource>
            <%-- <cc1:AutoCompleteExtender ID="AutoComplete_PFName" runat="server" CompletionInterval="10"
                      CompletionSetCount="12" EnableCaching="true" MinimumPrefixLength="3" ServiceMethod="GetCompletionList"
                      ServicePath="AutoComplete.asmx" TargetControlID="textboxpfname">                  </cc1:AutoCompleteExtender>
                  <ajaxToolkit:AutoCompleteExtender ID="autoComplete_RFName" runat="server" CompletionInterval="10"
                      CompletionSetCount="12" EnableCaching="true" MinimumPrefixLength="3" ServiceMethod="GetCompletionList"
                      ServicePath="AutoComplete.asmx" TargetControlID="textboxrfname">                  </cc1:AutoCompleteExtender>
              <cc1:AutoCompleteExtender ID="AutoComplete_PMName" runat="server" CompletionInterval="10"
                      CompletionSetCount="12" EnableCaching="true" MinimumPrefixLength="3" ServiceMethod="GetCompletionList"
                      ServicePath="AutoComplete.asmx" TargetControlID="textboxpmname">              </cc1:AutoCompleteExtender>
              <cc1:AutoCompleteExtender ID="AutoComplete_RMName" runat="server" CompletionInterval="10"
                      CompletionSetCount="12" EnableCaching="true" MinimumPrefixLength="3" ServiceMethod="GetCompletionList"
                      ServicePath="AutoComplete.asmx" TargetControlID="textboxrmname">            
                        </cc1:AutoCompleteExtender>--%>

                        
<h1 class="h1" style="display:none"><span>General Information</span></h1>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form"style="display:none" >
            
              <tr>
               <td align="right" width="15%"  >Patient Type :</td>
                <td  >
                    <asp:RadioButtonList ID="RadioButtonList_Patient_Type" runat="server" DataSourceID="SqlDataSourcePatientType" DataTextField="Patient_Type" DataValueField="Patient_Type" RepeatColumns="6" RepeatLayout="Flow" AutoPostBack="True" Enabled="False">
                    </asp:RadioButtonList> 
                    <asp:DropDownList ID="DropDownList_Parties" runat="server" DataSourceID="SqlDataSource_parties"
                        DataTextField="Party_Name" DataValueField="Party_Id" Visible="False" Width="180px">
                    </asp:DropDownList>
                    <asp:RadioButtonList ID="RadioButtonList_Type" runat="server"  RepeatLayout="Flow"
                        RepeatColumns="2" RepeatDirection="Horizontal" Visible="False" >
                        <asp:ListItem Selected="True">Paid</asp:ListItem>
                        <asp:ListItem>Free</asp:ListItem>
                    </asp:RadioButtonList></td>
              
              
              
              
              </tr>
    <tr>
        <td align="right" colspan="2" style="text-align: left">
            <asp:Panel ID="Panel2" runat="server">
                <table>
                    <tr>
                        <td style="width: 154px; text-align: right">
                            Type :</td>
                        <td style="width: 365px">
                            <asp:RadioButtonList ID="rblRegistrationType" runat="server" RepeatDirection="Horizontal"
                                RepeatLayout="Flow" Enabled="False">
                                <asp:ListItem Selected="True" Value="Self">Self</asp:ListItem>
                                <asp:ListItem Value="Dependent">Dependent</asp:ListItem>
                            </asp:RadioButtonList></td>
                    </tr>
                    <tr>
                        <td style="width: 154px; text-align: right">
                            Insurer :</td>
                        <td style="width: 365px">
                            <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_parties"
                                DataTextField="Party_Name" DataValueField="Party_Id" Enabled="False">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:PatientBilllingConnectionString %>"
                                SelectCommand="SELECT Parties.Party_Id, Parties.Party_Name FROM Parties INNER JOIN Patient_Billing_Party ON Parties.Party_Id = Patient_Billing_Party.Billing_Party_Id">
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 154px; text-align: right">
                            Employee Designation :</td>
                        <td style="width: 365px">
                            <asp:DropDownList ID="ddlDesignation" runat="server" DataSourceID="dsDesignations"
                                DataTextField="Party_Desg_Name" DataValueField="Party_Desg_ID" Enabled="False">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="dsDesignations" runat="server" ConnectionString="<%$ ConnectionStrings:PatientBillingConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:PatientBillingConnectionString.ProviderName %>"
                                SelectCommand="SELECT Party_Desg_ID, Party_Desg_Name FROM Party_Designations ORDER BY Party_Desg_Name">
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="dsEmployeeDependents" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                                SelectCommand="SELECT Reg_No, Party_Desg_Name, Party_Name, Prefix, PFName, PMName, PLName, Relation, RFName, RMName, RLName, Gender, Emp_No, RegistrationType FROM EmployeeDependents WHERE (Emp_No = @Emp_No) AND (Party_Id = @Party_ID) AND (Party_Desg_ID = @Party_Desg_ID)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="txtEmployeeNo" Name="Emp_No" PropertyName="Text" />
                                    <asp:ControlParameter ControlID="DropDownList_Parties" Name="Party_ID" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="ddlDesignation" Name="Party_Desg_ID" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 154px; text-align: right">
                            Principal Employee # :</td>
                        <td style="width: 365px">
                            <asp:TextBox ID="txtEmployeeNo" runat="server" ToolTip="Enter Employee Number" Enabled="False"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:GridView ID="grdEmployeeDependents" runat="server" AutoGenerateColumns="False"
                                DataSourceID="dsEmployeeDependents" EmptyDataText="Please Register Employee First"
                                Width="98%">
                                <Columns>
                                    <asp:TemplateField HeaderText="MR. #" SortExpression="Reg_No">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRegNo" runat="server"></asp:Label>
                                            <asp:HiddenField ID="hfRegNo" runat="server" Value='<%# Eval("Reg_No") %>' />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Reg_No") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Patient">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPatientName" runat="server"></asp:Label>
                                            <asp:HiddenField ID="hfPrefix" runat="server" Value='<%# Eval("Prefix") %>' />
                                            <asp:HiddenField ID="hfPFName" runat="server" Value='<%# Eval("PFName") %>' />
                                            <asp:HiddenField ID="hfPMName" runat="server" Value='<%# Eval("PMName") %>' />
                                            <asp:HiddenField ID="hfPLName" runat="server" Value='<%# Eval("PLName") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Relation">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRelation" runat="server"></asp:Label>
                                            <asp:HiddenField ID="hfRelation" runat="server" Value='<%# Eval("Relation") %>' />
                                            <asp:HiddenField ID="hfRFName" runat="server" Value='<%# Eval("RFName") %>' />
                                            <asp:HiddenField ID="hfRMName" runat="server" Value='<%# Eval("RMName") %>' />
                                            <asp:HiddenField ID="hfRLName" runat="server" Value='<%# Eval("RLName") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Party_Desg_Name" HeaderText="Employee Designation" SortExpression="Party_Desg_Name" />
                                    <asp:BoundField DataField="Party_Name" HeaderText="Party" SortExpression="Party_Name" />
                                    <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
                                    <asp:BoundField DataField="Emp_No" HeaderText="Emp #" SortExpression="Emp_No" />
                                    <asp:TemplateField HeaderText="Registration Type" SortExpression="RegistrationType">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRegistrationType" runat="server" Text='<%# Bind("RegistrationType") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("RegistrationType") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblRelationWith" runat="server"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 154px">
                        </td>
                        <td style="width: 365px">
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </td>
    </tr>
               
          

    </table>
  
    
  <div id="wait" style="position:absolute; left: 231px; top: 232px;">
<img src="../images/loading.gif" width="16" height="1" style="display:none;" />
</div>   
 <table width="100%" border="0" cellspacing="0" cellpadding="0" style="display:none">
  <tr>
    <td> <h1 class="h1" style="width:98%;"><span>Patient Information</span></h1></td>
    <td><h1 class="h1"><span >Relation Information</span></h1>  </td>
  </tr>
</table>
   
 
  
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form" style="display:none">
        <tr>
                <td  width="15%" align="right" >Title :</td>
                <td width="35%"  ><asp:RadioButtonList ID="RBLprefix" runat="server"  RepeatLayout="Flow" 
                        RepeatDirection="Horizontal"  TabIndex="6">
                  <asp:ListItem >Mr.</asp:ListItem>
                                    <asp:ListItem>Miss</asp:ListItem>
                                  
                                    <asp:ListItem>Mrs.</asp:ListItem>
                                  
                                    <asp:ListItem>B/O</asp:ListItem>
                                    <asp:ListItem>B</asp:ListItem>

                                     <asp:ListItem>Mas</asp:ListItem>
                </asp:RadioButtonList></td>
                <td width="15%" align="right" >Relation :</td>
                <td width="36%" ><asp:RadioButtonList ID="RBLrelation" runat="server" RepeatLayout="Flow" 
                        RepeatDirection="Horizontal"
                        TabIndex="9">
                  <asp:ListItem Selected="True">S/O</asp:ListItem>
                  <asp:ListItem>D/O</asp:ListItem>
                  <asp:ListItem>W/O</asp:ListItem>
                </asp:RadioButtonList></td>
</tr>
              <tr>
                <td  align="right" >First Name :</td>
                        <td  >
                            <asp:TextBox AccessKey="n"  ID="textboxpfname" style="background-color:
                        #f9dde2; text-transform:uppercase; " runat="server" TabIndex="7" MaxLength="12" 
                                SkinId="captxt"></asp:TextBox><span class="marks">*</span>          
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="textboxpfname"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                        <%--    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="textboxpfname"
                                ErrorMessage="Enter Valid First Name" ValidationExpression="[A-Za-z]*"></asp:RegularExpressionValidator>--%></td>
                        
                        <td  align="right" >First Name :</td>
                        <td >
                            <asp:TextBox   ID="textboxrfname" 
                                style="background-color:#f9dde2; text-transform:uppercase; " MaxLength="12" 
                                runat="server" TabIndex="10"  SkinId="captxt"  ></asp:TextBox><span class="marks">*
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="textboxrfname"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                           <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="textboxrfname"
                                ErrorMessage="Enter Valid Relation First Name" ValidationExpression="[A-Za-z]*"></asp:RegularExpressionValidator>--%></span></td>
      </tr>
              <tr>
                <td  align="right"  >Middle Name :</td>
                        <td ><asp:TextBox  ID="textboxpmname" style="background-color:#f9dde2; text-transform:uppercase; " MaxLength="12" runat="server" TabIndex="8"    
                         SkinId="captxt" ></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="textboxpmname"
                                ErrorMessage="Enter Valid Middle Name" ValidationExpression="[A-Z a-z]*"></asp:RegularExpressionValidator></td>
                        <td  align="right"  >Middle Name :</td>
                        <td  ><asp:TextBox    ID="textboxrmname" style="background-color:#f9dde2; text-transform:uppercase; " MaxLength="12" runat="server" TabIndex="11" SkinId="captxt"
                       ></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="textboxrmname"
                                ErrorMessage="Enter Valid Relation Middle Name" ValidationExpression="[A-Z a-z]*"></asp:RegularExpressionValidator></td>
      </tr>
                <tr>
                    <td align="right"   >
                        Last Name :</td>
                    <td   >
                        <asp:TextBox  ID="textboxplname" style="background-color:#f9dde2; text-transform:uppercase; " MaxLength="12" runat="server" Visible="true"    
                         SkinId="captxt" TabIndex="8" ></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="textboxplname"
                            ErrorMessage="Enter Valid Last Name" ValidationExpression="[A-Za-z]*"></asp:RegularExpressionValidator></td>
                    <td align="right"   >
                        Last Name :                                       </td>
                    <td   >
                        <asp:TextBox  ID="textboxrlname" style="background-color:#f9dde2; text-transform:uppercase; " MaxLength="12" runat="server" Visible="true"    
                       SkinId="captxt" TabIndex="11" ></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="textboxrlname"
                            ErrorMessage="Enter Valid Relation Last Name" ValidationExpression="[A-Za-z]*"></asp:RegularExpressionValidator></td>
                </tr>
              <tr>
                <td  align="right" >
                    DOB :</td>
                        <td >
                             
                            <igtxt:webdatetimeedit id="WebDateTimeEdit_DOB" runat="server"  TabIndex="12"    Culture="English (United Kingdom)" style="background-color:#f9dde2; width:85px;"></igtxt:webdatetimeedit>
                                    
                            <span style="font-size: 10pt; color: #d92542">*</span><asp:HiddenField ID="HiddenField_DOB" runat="server" />
                            <asp:TextBox AccessKey="a"  ID="textboxage" runat="server" TabIndex="12"   Width="29px" MaxLength="3" ></asp:TextBox><asp:DropDownList  ID="DropDownListBIndicator" runat="server" Width="70px" AccessKey="y" TabIndex="13">
                            <asp:ListItem Selected="True">Years</asp:ListItem>
                            <asp:ListItem>Months</asp:ListItem>
                            <asp:ListItem>Days</asp:ListItem>
                            <asp:ListItem>Hours</asp:ListItem>
                          </asp:DropDownList>
                            
                             
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ControlToValidate="textboxage"
                                ErrorMessage="Enter Valid Age" ValidationExpression="[0-9]*"></asp:RegularExpressionValidator></td>
                       
                       
                       <td  align="right"  >
                           Patient Gender :</td>
                        <td valign="top" ><asp:DropDownList ID="sex" runat="server"  DataSourceID="SexSource"
                      DataTextField="Gender" DataValueField="Gender_ID"   AccessKey="g" TabIndex="14">
                          <asp:ListItem Selected="True" Value="M">Male</asp:ListItem>
                          <asp:ListItem Value="F">Female</asp:ListItem>
                        </asp:DropDownList> <asp:Panel ID="Panel1" runat="server" Height="20px" Visible="false" Width="125px">
                </asp:Panel>    </td>
                       
                        
      </tr>
    <tr>
        <td align="right">
            Religion :</td>
        <td>
            <asp:DropDownList ID="DropDownList_Religion" runat="server" AccessKey="g" DataSourceID="SqlDataSource_religion"
                DataTextField="Religion_name" DataValueField="Religion_ID" TabIndex="14"  >
                <asp:ListItem Selected="True" Value="M">Male</asp:ListItem>
                <asp:ListItem Value="F">Female</asp:ListItem>
            </asp:DropDownList></td>
        <td align="right">
            Nationality :</td>
        <td valign="top">
            <asp:DropDownList ID="DropDownList_Nationality" runat="server" AccessKey="g" DataSourceID="SqlDataSource_Nationality"
                DataTextField="Nationality_Name" DataValueField="Nationality_ID" TabIndex="14"
                >
                <asp:ListItem Selected="True" Value="M">Male</asp:ListItem>
                <asp:ListItem Value="F">Female</asp:ListItem>
            </asp:DropDownList></td>
    </tr>
    <tr>
        <td align="right">
            Attach Picture :</td>
      <td>
            <asp:FileUpload ID="FileUpload_image" runat="server" />
        <asp:Button ID="Button_attach_pic" runat="server" CausesValidation="False" 
                Text="Attach" />
                
                <div style="position: absolute; margin-left: 260px; margin-top:-165px;">
                <asp:Image ID="Image_Pic" runat="server"   ImageUrl="~/images_hacims/picplace.jpg"
                    Height="112px" Width="94px" Style="border: none;"   />
  </div>
          </td>
        <td align="right">
        </td>
        <td valign="top">&nbsp;</td>
    </tr>
             
             

    </table>
    
   <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                        SelectCommand="SELECT Pt_Cast FROM Patient_Cast"></asp:SqlDataSource>
                    <asp:HiddenField ID="HiddenFieldCast" runat="server" />                &nbsp;&nbsp;
    <asp:HiddenField ID="HiddenField_Amount" runat="server" />
    
    <asp:HiddenField ID="HiddenField_S_ID" runat="server" />
                            <asp:DropDownList ID="DropDownListCast" runat="server" 
                                DataSourceID="SqlDataSource2" DataTextField="Pt_Cast" DataValueField="Pt_Cast"
                                Width="124px" TabIndex="15" Visible="False">                            </asp:DropDownList>
                            <asp:TextBox ID="TextBoxCast" runat="server" CssClass="input_txt" Width="100px" Visible="False"></asp:TextBox> 
    
   

 


  <%--<asp:UpdatePanel ID="up2" runat="server"  ><ContentTemplate>--%>
                  <asp:FormView ID="fmvPatientInfo" runat="server" HorizontalAlign="Left" Width="100%"
                    DataSourceID="dsPatientInfo" DataKeyNames="RegNo">
                    <ItemTemplate>
                        <div id="p_info" class="patient-info" style="min-height: 20px; line-height: 22px;">
                            <ul style="margin-left: 10px;">
                                <li style="display: inline;"><span class="age" style="display: inline;">MR # &nbsp;<span
                                    class="reg"><strong><asp:Label ID="RegistrationNo" ToolTip="Patient Registration Number"
                                        runat="server" Text='<%# Eval("RegNo") %>'></asp:Label></strong></span><span class="splt">|</span>
                                    <span class="name-p">
                                         <asp:Label ID="Label1" runat="server" ToolTip="Patient Name" Text='<%# Eval("Prefix", "{0}") %>'></asp:Label>
                                        <asp:Label ID="PatientNameLabel" runat="server" ToolTip="Patient Name" Text='<%# Eval("PFName", "{0}") %>'></asp:Label>
                                       

                                    </span><span class="relation">&nbsp;<asp:Label ID="RelationLabel" ToolTip="Patient Relation"
                                        runat="server" Text='<%# Bind("Relation", "{0}") %>'></asp:Label>&nbsp;</span>
                                    <strong>
                                        <asp:Label ID="RelationNameLabel" ToolTip="Patient Relation Name" runat="server"
                                            Text='<%# Eval("RELATIONNAME", "{0}") %>'></asp:Label></strong><span class="splt">|
                                                <span style="color: #333333">Age :</span></span> <span class="age" style="display: inline;">
                                                    <asp:Label ID="AgeLabel" ToolTip="Patient Age" runat="server" Text='<%# Bind("Age") %>'></asp:Label>
                                                    Year(s)<span class="splt">|</span><asp:Label ID="LabelDateofBirth" ToolTip="Patient Date of Birth"
                                                        runat="server" Text='<%# Eval("DateOfBirth") %>' Visible="False"></asp:Label><span
                                                            class="splt"></span><asp:Label ID="LabelGender" ToolTip="Patient Gender" runat="server"
                                                                Text='<%# Eval("Gender", "{0}") %>'></asp:Label></span>
                                    <asp:Label ID="Label_Address" Visible="false" ToolTip="Patient Address" runat="server"
                                        Text='<%# Bind("Address", "{0}") %>'></asp:Label> </li>
                            </ul>
                               <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("Prefix", "{0}") %>' />
                            <asp:HiddenField ID="HiddenField_Pfname" runat="server" Value='<%# Eval("pfname", "{0}") %>' />
                            <asp:HiddenField ID="HiddenField_Pmname" runat="server" Value='<%# Eval("pmname", "{0}") %>' />
                            <asp:HiddenField ID="HiddenField_Plname" runat="server" Value='<%# Eval("PLName") %>' />
                            <asp:HiddenField ID="HF_Pt_Type" runat="server" Value='<%# Eval("Patient_Type") %>' />
                            
                        </div>

                        <br />
                        <br />
                        </SPAN>
                    </ItemTemplate>
                </asp:FormView>
        <asp:SqlDataSource ID="dsPatientInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                    SelectCommand="SELECT Patient.RegNo, ISNULL(Patient.Prefix, ' ') AS prefix, ISNULL(Patient.PFName, ' ') AS pfname, ISNULL(Patient.PMName, ' ') AS pmname, ISNULL(Patient.PLName, ' ') AS PLName, UPPER(Patient.Relation) AS Relation, UPPER(ISNULL(Patient.RFName, ' ')) + ' ' + UPPER(ISNULL(Patient.RMName, ' ')) + ' ' + UPPER(ISNULL(Patient.RLName, ' ')) AS RELATIONNAME, CONVERT (varchar, DATEDIFF(dd, Patient.DateOfBirth, GETDATE()) / 365) + '  Years  ' + CONVERT (varchar, DATEDIFF(dd, Patient.DateOfBirth, GETDATE()) % 365 / 30) + '  M  ' + CONVERT (varchar, DATEDIFF(dd, Patient.DateOfBirth, GETDATE()) % 365 % 30) + '  D' AS Age, UPPER(Gender.Gender) AS Gender, CONVERT (varchar, Patient.DateOfBirth, 107) AS DateOfBirth, Patient.CNIC, CONVERT (varchar, Patient.DateOfBirth, 107) AS DateOfBirth, ISNULL(Patient.House_No, '') + ' ' + ISNULL(Patient.StreetAddress, ' ') + ' ' + ISNULL(Patient.Colony, ' ') + ' ' + ISNULL(Tehsil.TehsilName, '') AS Address, Patient.Patient_Type FROM Patient LEFT OUTER JOIN Gender ON Patient.SexID = Gender.Gender_ID LEFT OUTER JOIN Tehsil ON Patient.TehsilCode = Tehsil.TehsilCode WHERE (Patient.RegNo = @RegNo)">
                    <SelectParameters>
                        <asp:SessionParameter Name="RegNo" SessionField="registrationno" />
                    </SelectParameters>
                </asp:SqlDataSource>

 
 <ul id="CollapsiblePanel2" style="margin-top: 70px;">     
<li><h1 class="h1" style="margin:.67em 0"><span>Address Information</span></h1></li>  
<li>  
 
  
  
<TABLE class="tbl_form" cellSpacing=0 cellPadding=0 width="100%" border=0>
  
    <TR>
      <TD align="right">CNIC # :</TD>
      <TD>
      <asp:TextBox id="textboxnic1" tabIndex=19 runat="server" ></asp:TextBox>
      
        <asp:Label ID="Label3" runat="server"   ForeColor="Red" Text="Enter Valid CNIC"
        Visible="False"></asp:Label>
        <asp:Label ID="Label_CNIC" runat="server"  ForeColor="Red" Visible="False"></asp:Label></TD>

        <TD align="right" >
          Contact # :</TD>
      <TD>
           <asp:TextBox id="textboxmcode" tabIndex=21 runat="server"   ></asp:TextBox>
          
          <asp:SqlDataSource ID="SqlDataSourceUpdate" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
            ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" UpdateCommand="Update_PatientInfo"
            UpdateCommandType="StoredProcedure" CancelSelectOnNullParameter="False">
         
        </asp:SqlDataSource></TD>

            <TD align="right"  >
          Address 1 :</TD>
        <td rowspan="2">
            <asp:TextBox ID="textboxHouseNo" runat="server" CssClass="input_txt" Height="50px"
                TabIndex="23" TextMode="MultiLine"></asp:TextBox></td>

              <TD align="right" >
          Address 2 :</TD>
        <td rowspan="2">
            <asp:TextBox ID="textboxstreetaddress" runat="server" CssClass="input_txt" Height="50px"
                TabIndex="26" TextMode="MultiLine"></asp:TextBox> </td>

         <UpdateParameters>
           
            <asp:ControlParameter ControlID="textboxstreetaddress" Name="StreetAddress" PropertyName="Text"
                    Type="String" />
          
           <asp:ControlParameter ControlID="HiddenField_mobile_no" Name="MobilePhone" PropertyName="Value"
                    Type="String" />
            <asp:ControlParameter ControlID="HiddenField_CNIC" Name="CNIC" PropertyName="Value"
                    Type="String" />
           
            <asp:ControlParameter ControlID="textboxHouseNo" Name="HouseNo" PropertyName="Text" />
          
          </UpdateParameters>
      <TD  width="15%" align="right" style="display:none">
          Country : 
      </TD>
      <TD style="display:none"><asp:UpdatePanel ID="UpdatePanel1" runat="server">
          <ContentTemplate>
            <asp:DropDownList id="country" tabIndex=20 runat="server" 
                  DataValueField="CountryCode" DataTextField="CountryName" 
                  DataSourceID="SqlDataSource3" AutoPostBack="True" > </asp:DropDownList>
            <asp:SqlDataSource id="SqlDataSource3" runat="server" 
                  SelectCommand="select 0 as [CountryCode],'' as [CountryName]union SELECT [CountryCode], [CountryName] FROM [Country]" 
                  ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"></asp:SqlDataSource>
          </ContentTemplate>
        </asp:UpdatePanel>
        <asp:TextBox id="textboxprovince2" runat="server" Width="99px" Visible="False"></asp:TextBox> 
      </TD>
    </TR>
    <TR>
      
      <TD align="right" style="display:none" >
          Province : 
      </TD>
      <TD  style="display:none"><asp:UpdatePanel ID="UpdatePanel2" runat="server">
          <ContentTemplate>
            <asp:DropDownList id="Province" tabIndex=22 runat="server" 
                  DataValueField="ProvinceCode" DataTextField="ProvinceName" 
                  DataSourceID="SqlDataSource4" AutoPostBack="True"   
                  OnSelectedIndexChanged="Province_SelectedIndexChanged"> </asp:DropDownList>
            <asp:SqlDataSource id="SqlDataSource4" runat="server" SelectCommand="select 0  as ProvinceCode,'' as ProvinceName union SELECT ProvinceCode, ProvinceName FROM Province 
WHERE(CountryCode =@CountryCode)" 
                  ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>">
              <SelectParameters>
                <asp:ControlParameter ControlID="country" Name="CountryCode" PropertyName="SelectedValue" />
              </SelectParameters>
            </asp:SqlDataSource>
          </ContentTemplate>
        </asp:UpdatePanel></TD>
    </TR>
    <TR>
  
      <TD align="right" style="display:none" >
          District : 
      </TD>
      <TD  style="display:none"><asp:UpdatePanel ID="UpdatePanel3" runat="server">
          <ContentTemplate>
            <asp:DropDownList id="district" tabIndex=24 runat="server" 
                  DataValueField="DistrictCode" DataTextField="DistrictName" 
                  DataSourceID="SqlDataSource5" AutoPostBack="True"   
                  OnSelectedIndexChanged="district_SelectedIndexChanged"> </asp:DropDownList>
            <asp:SqlDataSource id="SqlDataSource5" runat="server" SelectCommand="SELECT 0 AS  DistrictCode,''AS DistrictName UNION SELECT DistrictCode,DistrictName FROM DISTRICT 
WHERE (ProvinceCode = @ProvinceCode)" 
                  ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>">
              <SelectParameters>
                <asp:ControlParameter ControlID="Province" Name="ProvinceCode" PropertyName="SelectedValue" />
              </SelectParameters>
            </asp:SqlDataSource>
            <asp:TextBox id="textboxTehsil2" runat="server" Width="92px" Visible="False"></asp:TextBox>
          </ContentTemplate>
        </asp:UpdatePanel></TD>
    </TR>
    <TR>
      <TD align="right" ></TD>
      <TD align="right" style="display:none" >
          City : 
      </TD>
      <TD style="display:none"><asp:UpdatePanel ID="UpdatePanel4" runat="server">
          <ContentTemplate>
            <asp:DropDownList id="tehsil" tabIndex=25 runat="server" 
                  DataValueField="TehsilCode" DataTextField="TehsilName" 
                  DataSourceID="SqlDataSource6"  > </asp:DropDownList>
            <asp:SqlDataSource id="SqlDataSource6" runat="server" SelectCommand="SELECT 0 AS TehsilCode,'' as TehsilName union SELECT TehsilCode,TehsilName FROM TEHSIL 
WHERE (districtCode =@districtCode)" 
                  ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>">
              <SelectParameters>
                <asp:ControlParameter ControlID="district" Name="districtCode" PropertyName="SelectedValue" />
              </SelectParameters>
            </asp:SqlDataSource>
            <asp:TextBox id="textboxDistrict2" runat="server" Width="98px" Visible="False"></asp:TextBox>
          </ContentTemplate>
        </asp:UpdatePanel>
          
          
         </TD>
    </TR>
    <TR>

      <TD align="right" style="display:none"> Email   :  </TD>
      <TD  style="display:none"><asp:TextBox ID="TextBox_Email_Address" runat="server"  TabIndex="27"></asp:TextBox> 
          <asp:TextBox id="textboxzipcode" tabIndex=28 runat="server"  MaxLength="5" Visible="False"></asp:TextBox>
      
        <asp:RegularExpressionValidator ID="RegularExpressionValidator9" runat="server" ControlToValidate="textboxzipcode"
        ErrorMessage="Enter Valid Postal Code" ValidationExpression="[0-9]*"></asp:RegularExpressionValidator> 
          <asp:TextBox id="textboxcolony" tabIndex=26 runat="server" Visible="False" ></asp:TextBox> 
      </TD>
    </TR>
    <TR>
      <TD align="right" ></TD>
      <TD align="right"  style="display:none">Passport # :</TD>
      <TD  style="display:none">  <asp:TextBox id="TextBox_passport_No" tabIndex=28 runat="server" ></asp:TextBox> 
          <asp:UpdatePanel ID="UpdatePanel5" runat="server">
          <ContentTemplate >
            
            <asp:TextBox id="textboxphoneno" tabIndex=29 runat="server" Visible="False"   ></asp:TextBox>
            
            <asp:RegularExpressionValidator id="RegularExpressionValidator8" runat="server" ErrorMessage="Enter Valid Phone No" ControlToValidate="textboxphoneno" ValidationExpression="[0-9]*"></asp:RegularExpressionValidator>
          </ContentTemplate>
        </asp:UpdatePanel></TD>
    </TR>
   
 
</TABLE>

   </li></ul>
 <%-- </ContentTemplate> </asp:UpdatePanel>           --%>
 <ul id="CollapsiblePanel1" style="display:none">     
<li><h1 class="h1"><span>Next of Kin Information</span></h1></li>  
<li> 

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td width="15%" align="right" >Title :</td>
    <td width="35%" ><asp:RadioButtonList ID="RBLprefix_ot" runat="server" 
                        RepeatDirection="Horizontal" TabIndex="29" 
            RepeatLayout="Flow" >
      <asp:ListItem Selected="True">Mr.</asp:ListItem>
      <asp:ListItem>Miss</asp:ListItem>
      <asp:ListItem>Mrs.</asp:ListItem>
      <asp:ListItem>Dr.</asp:ListItem>
    </asp:RadioButtonList></td>
    <td width="15%" align="right" >Relation with patient :</td>
    <td width="35%" ><asp:DropDownList ID="DropDownListRelationwithPatient_ot" 
            runat="server"  TabIndex="31" AutoPostBack="True">
      <asp:ListItem>Son</asp:ListItem>
      <asp:ListItem>Daughter</asp:ListItem>
      <asp:ListItem>Father</asp:ListItem>
      <asp:ListItem>Mother</asp:ListItem>
      <asp:ListItem>Wife</asp:ListItem>
      <asp:ListItem>Husband</asp:ListItem>
      <asp:ListItem>Brother</asp:ListItem>
      <asp:ListItem>Sister</asp:ListItem>
      <asp:ListItem>Other</asp:ListItem>
    </asp:DropDownList>
    <asp:TextBox ID="TextBox_refrence_id_ot" runat="server" Visible="False" 
            Width="59px" TabIndex="32"></asp:TextBox></td>
  </tr>
  <tr>
    <td align="right">Gender :</td>
    <td><asp:RadioButtonList ID="RadioButtonList1_ot" runat="server" RepeatLayout="Flow"  
                        RepeatColumns="2" TabIndex="30">
      <asp:ListItem Selected="True">Male</asp:ListItem>
      <asp:ListItem>Female</asp:ListItem>
    </asp:RadioButtonList>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="RadioButtonList1_ot"
                        ErrorMessage="*"></asp:RequiredFieldValidator></td>
    <td align="right">First Name :</td>
    <td><asp:TextBox ID="textboxpfname_ot" runat="server" BackColor="White" 
            SkinId="captxt"  MaxLength="12" 
                       
                        TabIndex="33"></asp:TextBox>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator10" runat="server"
            ControlToValidate="textboxpfname_ot" ErrorMessage="Enter Valid Next of Kin First Name"
            ValidationExpression="[A-Za-z]*"></asp:RegularExpressionValidator>
        <span style="font-size: 10pt; color: #d92542"></span></td>
  </tr>
  <tr>
    <td align="right">Middle Name :</td>
    <td><asp:TextBox ID="textboxpmname_ot" runat="server"  TabIndex="34" MaxLength="12" 
            SkinId="captxt"></asp:TextBox>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator11" runat="server"
            ControlToValidate="textboxpmname_ot" ErrorMessage="Enter Valid Next of Kin Middle Name"
            ValidationExpression="[A-Z a-z]*"></asp:RegularExpressionValidator></td>
    <td align="right">Last Name :</td>
    <td> <asp:TextBox ID="textboxplname_ot" runat="server"  Visible="true"  
            TabIndex="35" SkinId="captxt" MaxLength="12"></asp:TextBox>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator12" runat="server"
            ControlToValidate="textboxplname_ot" ErrorMessage="Enter Valid Next of Kin Last Name"
            ValidationExpression="[A-Za-z]*"></asp:RegularExpressionValidator></td>
  </tr>

</table>



   <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td width="15%" align="right">CNIC # :</td>
    <td width="35%">
    <asp:TextBox ID="textboxnic1_ot" runat="server" TabIndex="36" ></asp:TextBox>
       
    </td>
    <td width="15%" align="right">Country :</td>

    <td width="35%">
                <asp:DropDownList ID="country_ot" runat="server" AutoPostBack="True"  
                        DataSourceID="SqlDataSource_Country_ot" 
            DataTextField="CountryName" DataValueField="CountryCode"
                         TabIndex="37"> </asp:DropDownList>
    <asp:SqlDataSource ID="SqlDataSource_Country_ot" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                        
                    
                    
            SelectCommand="select 0 as [CountryCode],'' as [CountryName]union SELECT [CountryCode], [CountryName] FROM [Country]"></asp:SqlDataSource>
            </td>
  </tr>
  <tr>
    <td align="right">Mobile # :</td>
    <td>
        <asp:UpdatePanel ID="UpdatePanel6" runat="server">
            <ContentTemplate>
                <asp:TextBox id="textboxmcode_ot"   runat="server" MaxLength="11" 
                    TabIndex="38"  ></asp:TextBox>
            </ContentTemplate>
        </asp:UpdatePanel>
    </td>
    <td align="right">Province :</td>
    <td>
        <asp:UpdatePanel ID="UpdatePanel7" runat="server">
            <ContentTemplate>
      <asp:DropDownList ID="Province_ot" runat="server" AutoPostBack="True"  
                        DataSourceID="SqlDataSource_Province_ot" DataTextField="ProvinceName" DataValueField="ProvinceCode"
                        TabIndex="39"  > </asp:DropDownList>
      <asp:TextBox ID="textboxprovince2_ot" runat="server" Visible="False" Width="99px"></asp:TextBox>
      <asp:SqlDataSource ID="SqlDataSource_Province_ot" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="select 0  as ProvinceCode,'' as ProvinceName union SELECT ProvinceCode, ProvinceName FROM Province 
WHERE(CountryCode =@CountryCode)">
        <SelectParameters>
          <asp:ControlParameter ControlID="country_ot" Name="CountryCode" PropertyName="SelectedValue" />
        </SelectParameters>
      </asp:SqlDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
  </td>
  </tr>
  <tr>
    <td align="right" >House No. :</td>
    <td >
        <asp:UpdatePanel ID="UpdatePanel8" runat="server">
            <ContentTemplate>
                <asp:TextBox ID="TextBox_House_Ot" runat="server" TabIndex="40"></asp:TextBox>
            </ContentTemplate>
        </asp:UpdatePanel>
    </td>
    <td align="right" >District :<td >
        <asp:UpdatePanel ID="UpdatePanel9" runat="server">
            <ContentTemplate>
                <asp:DropDownList id="district_ot" tabIndex=41 runat="server" AutoPostBack="True" 
                    DataValueField="DistrictCode" DataTextField="DistrictName" 
                    DataSourceID="SqlDataSource_District_ot">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource_District_ot" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" SelectCommand="SELECT 0 AS  DistrictCode,''AS DistrictName UNION SELECT DistrictCode,DistrictName FROM DISTRICT 
WHERE (ProvinceCode = @ProvinceCode)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="Province" Name="ProvinceCode" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </td>
  </tr>
  <tr>
    <td align="right" >
        Phone # :</td>
    <td >
<asp:TextBox id="textboxphoneno_ot" tabIndex=42 runat="server"  ></asp:TextBox>
    
     
    </td>
    <td align="right" >Tehsil : </td>
    <td >
        <asp:UpdatePanel ID="UpdatePanel10" runat="server">
            <ContentTemplate>
                <asp:DropDownList id="tehsil_ot" tabIndex=43 runat="server"   DataValueField="TehsilCode" 
                    DataTextField="TehsilName" DataSourceID="SqlDataSource_Tehsil_ot" Width="150px" 
                    OnSelectedIndexChanged="tehsil_ot_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource_Tehsil_ot" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
                    SelectCommand="SELECT TehsilCode, TehsilName FROM TEHSIL WHERE (districtCode = @districtCode)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="district_ot" Name="districtCode" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
                        </td>
  </tr>
       <tr>
           <td align="right" >
               Town / Village :</td>
           <td >
               <asp:TextBox ID="textboxTown_ot" runat="server"   TabIndex="44"></asp:TextBox></td>
           <td align="right" >
               Sector / Street / Block :</td>
           <td >
               <asp:TextBox ID="TextBox_Street_OT" runat="server"  TabIndex="45"  ></asp:TextBox></td>
       </tr>
  <tr>
    <td align="right"></td>
    <td>
        </td>
    <td align="right"></td>
    <td><asp:HiddenField ID="HiddenField_country_ot" runat="server" Value="12" />
      <asp:TextBox ID="textboxrlname_ot" runat="server"  Visible="False"  TabIndex="43"></asp:TextBox>
        <asp:TextBox ID="textboxrmname_ot" runat="server" 
                        TabIndex="42"  Visible="False"></asp:TextBox>
      <asp:HiddenField ID="HiddenField_province_ot" runat="server" Value="12" />
      <asp:TextBox ID="textboxrfname_ot" runat="server"  
                        TabIndex="41"  Visible="False"></asp:TextBox>
    <asp:RadioButtonList ID="RBLrelation_ot" runat="server" 
                         RepeatDirection="Horizontal" RepeatLayout="Flow" 
                        TabIndex="40" Visible="False">
      <asp:ListItem Selected="True">S/O</asp:ListItem>
      <asp:ListItem>D/O</asp:ListItem>
      <asp:ListItem>W/O</asp:ListItem>
    </asp:RadioButtonList>
      <asp:HiddenField ID="HiddenField_district_ot" runat="server" Value="12" />
      <asp:HiddenField ID="HiddenField_tehsil_ot" runat="server" Value="12" />
      <asp:HiddenField ID="HiddenField_Emp_Id_ot" runat="server" />
      <asp:HiddenField ID="HiddenField_Dept_Id_ot" runat="server" />
        
      <asp:HiddenField ID="HiddenFieldNIC_ot" runat="server" />
      <asp:HiddenField ID="HiddenField_RegistrationNo" runat="server" />
      <asp:HiddenField ID="HiddenField_mobile_Phone" runat="server" />
    <asp:HiddenField ID="HiddenField_phone_ot" runat="server" />
        <asp:HiddenField ID="HiddenField_cnic" runat="server" />
    </td>
  </tr>
 
</table> 
</li>
</ul>
    <asp:Label ID="Label4" runat="server"></asp:Label><br />
<div align="center">
   

    <asp:Button ID="Button_ot" runat="server" CssClass="btn2" 
        Text="Update Next of Kin" Visible="False" /> <asp:Button
        ID="Button_Update" runat="server" CssClass="btn2" Text="Update" 
        TabIndex="46" /> 
    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="report_print" 
        Visible="False"><span></span>Update & Print</asp:LinkButton>
    <asp:Button ID="Button_Cancel" runat="server" Text="Cancel" /></div><br />

            
            <asp:SqlDataSource ID="PatientSaveRecord2" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                                InsertCommand="PatientRegistration2" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>"
                                SelectCommandType="StoredProcedure">
                                <InsertParameters>
                                    <asp:FormParameter FormField="RBLprefix" Name="Prefix" Type="String" />
                                    <asp:FormParameter FormField="textboxpfname" Name="PFName" Type="String" />
                                    <asp:FormParameter FormField="textboxpmname" Name="PMName" Type="String" />
                                    <asp:FormParameter FormField="textboxplname" Name="PLName" Type="String" />
                                    <asp:FormParameter FormField="rblrelation" Name="Relation" Type="String" />
                                    <asp:FormParameter FormField="textboxrfname" Name="RFName" Type="String" />
                                    <asp:FormParameter FormField="textboxrmname" Name="RMName" Type="String" />
                                    <asp:FormParameter FormField="textboxrlname" Name="RLName" Type="String" />
                                    <asp:FormParameter FormField="sex" Name="sexID" Type="Int32" />
                                    <asp:FormParameter FormField="textboxage" Name="Age" Type="Int32" />
                                    <asp:SessionParameter Name="RegDateTime" SessionField="DT" Type="DateTime" />
                                    <asp:FormParameter FormField="country" Name="CountryCode" Type="Int32" />
                                    <asp:FormParameter FormField="province" Name="ProvinceID" Type="Int32" />
                                    <asp:FormParameter FormField="district" Name="DistrictID" Type="Int32" />
                                    <asp:FormParameter FormField="tehsil" Name="Tehsil" Type="Int32" />
                                    <asp:FormParameter FormField="textboxzipcode" Name="Zipcode" Type="Decimal" />
                                    <asp:FormParameter FormField="textboxstreetaddress" Name="StreetAddress" Type="String" />
                                    <asp:FormParameter FormField="textboxcolony" Name="Colony" Type="String" />
                                    <asp:SessionParameter Name="HomePhone" SessionField="PHP" Type="String" />
                                    <asp:SessionParameter Name="MobilePhone" SessionField="PMP" Type="String" />
                                    <asp:SessionParameter Name="DateOfBirth" SessionField="DOB" Type="DateTime" />
                                    <asp:FormParameter FormField="textboxprovince2" Name="OtherProvince" Type="String" />
                                    <asp:FormParameter FormField="textboxdistrict2" Name="Otherdistrict" Type="String" />
                                    <asp:FormParameter FormField="textboxtehsil2" Name="OtherTehsil" Type="String" />
                                </InsertParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="PatientSaveRecord" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                                InsertCommand="PatientRegistration" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>">
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
                                    <asp:Parameter Direction="InputOutput" Name="paymentid" Type="Decimal" />
                                </InsertParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                SelectCommand="SELECT DISTINCT Department.Dept_Name, Department.Dept_ID FROM Reception_Dept INNER JOIN Department ON Reception_Dept.Dept_Id = Department.Dept_ID WHERE (Reception_Dept.Reception_Status = 1)">
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="districtsource" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                SelectCommand="SELECT [DistrictCode], [DistrictName] FROM [DISTRICT] WHERE ([ProvinceCode] = @ProvinceCode) order by priority">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="Province" Name="ProvinceCode" PropertyName="SelectedValue"
                                        Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="TehsilSource" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                                SelectCommand="SELECT [TehsilCode], [TehsilName] FROM [TEHSIL] WHERE ([districtCode] = @districtCode)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="district" Name="districtCode" PropertyName="SelectedValue"
                                        Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="Provincesource" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                                SelectCommand="SELECT [ProvinceName], [ProvinceCode] FROM [Province] WHERE ([CountryCode] = @CountryCode)">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="3" Name="CountryCode" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="Countrysorce" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                                SelectCommand="SELECT CountryName, CountryCode FROM Country ORDER BY CountryName"></asp:SqlDataSource>
                            <asp:SqlDataSource ID="SexSource" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                                SelectCommand="SELECT Gender_ID, Gender FROM Gender"></asp:SqlDataSource>
                            <asp:SqlDataSource ID="printinfosave" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                                InsertCommand="INSERT INTO [Print] (EmpID, PrintDateTime, RegNo) &#13;&#10;VALUES (@EmpID, @PrintDateTime, @RegNo)"
                                ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>">
                                <InsertParameters>
                                    <asp:SessionParameter Name="EmpID" SessionField="UserID" />
                                    <asp:SessionParameter Name="PrintDateTime" SessionField="PDT" />
                                    <asp:SessionParameter Name="RegNo" SessionField="PRegNoForDetail" />
                                </InsertParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString  %>"
                                InsertCommandType="StoredProcedure" SelectCommand="PatientRegistration12" SelectCommandType="StoredProcedure">                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSourceDiagnosis" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                                SelectCommand="SELECT Diagnosis FROM Diagnosis ORDER BY Diagnosis"></asp:SqlDataSource>
                            <asp:HiddenField ID="HiddenField_country" runat="server" Value="12" />
                            <asp:HiddenField ID="HiddenField_province" runat="server" Value="12" />
      <img alt="" src="wt.GIF" style="display:none;" />
    &nbsp;&nbsp;&nbsp;
    <asp:SqlDataSource ID="SqlDataSource_info_ot" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        InsertCommand="Update_OT_PatientRelative_Undertaking" InsertCommandType="StoredProcedure"
        ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:ControlParameter ControlID="RBLprefix_ot" Name="Prefix" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="textboxpfname_ot" Name="RelativeFName" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="textboxpmname_ot" Name="RelativeMName" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="textboxplname_ot" Name="RelativeLName" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="RBLrelation_ot" Name="RelativeRType" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="textboxrfname_ot" Name="RelativeRFName" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="textboxrmname_ot" Name="RelativeRMName" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="textboxrlname_ot" Name="RelativeRLName" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="HiddenFieldNIC_ot" Name="NIC" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="country_ot" Name="Country" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="Province_ot" Name="Province" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="district_ot" Name="District" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="tehsil_ot" Name="Tehsil" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_phone_no_ot" Name="PhoneNo" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="RadioButtonList1_ot" Name="Sex" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="DropDownListRelationwithPatient_ot" Name="RelationWithPatient"
                PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="HiddenField_RegistrationNo" Name="PatientRegNo"
                PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="HiddenField_mobile_Phone" Name="Mobile_Phone" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="textboxTown_ot" Name="Town" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="TextBox_House_Ot" Name="House_No" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="TextBox_Street_OT" Name="Street" PropertyName="Text"
                Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
                            <asp:HiddenField ID="HiddenField_district" runat="server" Value="12" />
                            <asp:HiddenField ID="HiddenField_tehsil" runat="server" Value="12" />
                            
                            <asp:HiddenField ID="HiddenFieldComplaint" runat="server" />
                     



<script type="text/javascript">
<!--
var CollapsiblePanel1 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel1", {contentIsOpen:false});
var CollapsiblePanel2 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel2", {contentIsOpen:true});
//-->
</script>

    <asp:HiddenField ID="HiddenFieldPFName" runat="server" />
    <asp:HiddenField ID="HiddenFieldPMName" runat="server" />
    <asp:HiddenField ID="HiddenFieldPLName" runat="server" />
    <asp:HiddenField ID="HiddenField_phone_no" runat="server" />
    <asp:HiddenField ID="HiddenField_mobile_no" runat="server" />
    <asp:HiddenField ID="HiddenField_phone_no_ot" runat="server" />
    <asp:HiddenField ID="HiddenField_Party_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_PatientType" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Patient_Services" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
        SelectCommand="SELECT * FROM [Patient_Services]" UpdateCommand="Change_Patient_Type" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:SessionParameter Name="Reg_No" SessionField="registrationNO" />
            <asp:SessionParameter Name="Yearly_No" SessionField="yearlyno" />
            <asp:SessionParameter Name="deptID" SessionField="dept_id" Type="Int32" />
            <asp:SessionParameter Name="subDeptID" SessionField="SubDeptID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_religion" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT [Religion_ID], [Religion_name] FROM [Religion]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Nationality" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT [Nationality_ID], [Nationality_Name] FROM [Nationality]"></asp:SqlDataSource>

  </asp:Content>