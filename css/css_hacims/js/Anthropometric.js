function CalcTemp()
{
var tempf = document.getElementById ("TextBox_Temp_F").value
tempf = (5/9)*(tempf-32);
document.getElementById ("TextBox_Temp_C").value= tempf;
document.getElementById("HiddenFieldTempc").value=tempf;
}
function CalcWeight()
{
var weightkg = document.getElementById("TextBox_Weight_kg").value;
weightkg = weightkg * 2.2046;
document.getElementById("TextBox_Weight_lb").value = weightkg;
//document.getElementByID("HiddenFieldlb").value==weightkg;
document.getElementById("HiddenFieldlb").value=weightkg; 

}
function CalcHeight()
{
//var heightinch = document.getElementById ("dropdownlist_height_inch").value;
//var heightfoot = document.getElementById ("DropDownList_height_foot").value;
//var height = heightfoot +"." +heightinch;
//height = height - 0;
////alert(heightfoot+"  "+heightinch)
////alert (height)
//height = height * 30.48006;
//var g_heightcm = height;
////alert(height)
document.getElementById("TextBoxheightinches").value=  (document.getElementById("TextBox_Heightcm").value)/30.48006;
var g_heightcm=(document.getElementById("TextBox_Heightcm").value);
var height=(document.getElementById("TextBox_Heightcm").value);
//=heightcmm/30.48006;
//alert(heightcmm);
document.getElementById ("TextBox_Heightcm").value = height;
var g_weight_kg =document.getElementById("TextBox_Weight_kg").value;
var bsa = (g_weight_kg* g_heightcm)/3600;
var bmi = g_weight_kg/ ((g_heightcm/100)*(g_heightcm/100));
//alert(bmi)
document.getElementById("HiddenFieldheightcm").value=height;
document.getElementById ("TextBox_BodyArea").value = bsa;
document.getElementById ("TextBox_Bodymass").value = bmi;
  document.getElementById("HiddenFieldbsa").value=bsa;
  document.getElementById("HiddenFieldbmi").value=bmi;
    
  var lbw = 0;
  var ibw = 0;
document.getElementById("HiddenFieldIdaelbodyweight").value=lbw;
document.getElementById("HiddenFieldleanbodyweight").value=ibw;
}
function verifyValidation()
{
//alert("dfsd");
var Verify_Validation;
var Final_prompt = "";
var Check_Counter=0;
if (document.getElementById("TextBox_Weight_kg").value.length==0)
{
Final_prompt= "Weight"; 
Check_Counter++;
}
if(document.getElementById("TextBox_Waist").value.length==0)
{
//alert("Waist");
Final_prompt= Final_prompt + ", Waist";
}
if(document.getElementById ("TextBox_headCircum").value.length==0)
{
Final_prompt= Final_prompt + ", Hip Circumference";
Check_Counter++;
}

if (document.getElementById("TextBox_Leanweight_lb").value.length==0)
{
Final_prompt= Final_prompt + ", Lean Body Weight";
Check_Counter++;
}
if (document.getElementById("TextBox_Headcircum").value.length==0)
{
Final_prompt= Final_prompt + ", Hip Circum";
Check_Counter++;
}
//if (document.getElementById("TextBox_ObesityScale").value.length==0)
//{
//Final_prompt= Final_prompt + ", Obesity Scale";
//Check_Counter++;
//}
if (document.getElementById("TextBox_BpHigh_Stand").value.length==0)
{
Final_prompt= Final_prompt + ", Blood Pressure Standing";
Check_Counter++;
}
if (document.getElementById("TextBox_BPLow_Stand").value.length==0)
{
Final_prompt= Final_prompt + ", Blood Pressure Stand";
Check_Counter++;
}

if (document.getElementById("TextBox_IdealBody_lbs").value.length==0)
{
Final_prompt= Final_prompt + ", Ideal Body Weight";
Check_Counter++;
}
if (document.getElementById("TextBox_Pulse").value.length==0)
{
Final_prompt= Final_prompt + ", Pulse";
Check_Counter++;
}
if (document.getElementById("TextBox_Resp_beats").value.length==0)
{
Final_prompt= Final_prompt + ", Breath";
Check_Counter++;
}

if ((document.getElementById("TextBox_bpHigh").value.length==0)||(document.getElementById("TextBox_bpHigh").value.length==0))
{
Final_prompt= Final_prompt + ", Blood Pressure";
Check_Counter++;
}
//if ((document.getElementById("Dropdownlist_height_foot").value.length==0)||(document.getElementById("Dropdownlist_height_Inch").value.length==0)) 
//{
//Final_prompt= Final_prompt + ", Hieght Of the Patient";
//Check_Counter++;
//}

if ((document.getElementById("TextBoxBp60").value.length==0)||(document.getElementById("TextBoxBp_60_Low").value.length==0))
{
Final_prompt= Final_prompt + ", Blood Pressure At 60" ;
Check_Counter++;
}
if (document.getElementById("DropDownList_Pulse_Rythm").value.length==0)
{
Final_prompt= Final_prompt + ", Pulse Rythm";
Check_Counter++;
}
//if (document.getElementById("DropDownList_resp_Pattern").value.length==0)
//{
//Final_prompt= Final_prompt + ", Respiration Pattern";
//Check_Counter++;
//}

//if (document.getElementById("DropDownList_Cufflocation").value.length==0)
//{
//Final_prompt= Final_prompt + ", Cuff Location";
//Check_Counter++;
//}
if (document.getElementById("DropDownList_BP_Patient_pos").value.length==0)
{
Final_prompt= Final_prompt + ", Patient Blood Pressure Position";
Check_Counter++;
}
if (document.getElementById("DropDownList_BloodType").value.length==0)
{
Final_prompt= Final_prompt + ", Patient Blood type";
Check_Counter++;
}
//alert("Waist");
if (document.getElementById("TextBoxFBS").value.length==0)
{
Final_prompt= Final_prompt + ", Patient Blood Glucose Fasting";
Check_Counter++;
}
if (document.getElementById("TextBox2hrpp").value.length==0)
{
Final_prompt= Final_prompt + ", Patient Glucose Random";
Check_Counter++;
}
  //Verify_Validation=  confirm('" ' + Final_prompt + ' "' + " These Fields Are Empty, Do You Want To Proceed ",2);
//  alert(Verify_Validation,2);
//alert(Check_Counter);
  if(Check_Counter>0)
    {
    document.getElementById ("TextBoxMessage").value = "Some Fields Have Not Been Filled. Do You Want To Proceed Without Completing These Fields?";
    document.getElementById("ButtonYes").style.visibility  = "visible";
    document.getElementById("ButtonNo").style.visibility  = "visible";
    document.getElementById("Check_Table").style.visibility  = "visible";
    document.getElementById("TextBoxMessage").focus();
    document.getElementById("Table1").style.visibility  = "Hidden";
    document.getElementById("ButtonSave").style.visibility  = "Hidden";
     return false;
    }
    else if (Check_Counter==0)
    {
    //document.getElementById("HiddenFieldCheck").value = 1;
    }
  
}
function Check_No()
{
document.getElementById("Table1").style.visibility  = "visible";
document.getElementById("Check_Table").style.visibility  = "Hidden";
document.getElementById("ButtonYes").style.visibility  = "Hidden";
document.getElementById("ButtonNo").style.visibility  = "Hidden";
document.getElementById("ButtonSave").style.visibility  = "visible";

return false;
}

function Claculate_Waist()
{
    if(document.getElementById ("TextBox_headCircum").value.length==0)
    {
    document.getElementById("TextBox_headCircum").focus();
    }
    else
    {
        if(document.getElementById ("TextBox_Waist").value.length==0)
        {
        document.getElementById("TextBox_Waist").focus();
        }
        else
        {
        document.getElementById ("TextBox_Assoc_disease").value = document.getElementById ("TextBox_Waist").value  / document.getElementById("TextBox_headCircum").value;  
        }
    }  
}
function Change_Waist()
{
document.getElementById("TextBox_headCircum").focus();
}

//////////////////////////// function for the Postural Drop (Blood Pressure) //////////////////
function Postural_Drop()
{
    var sit= document.getElementById("TextBox_Bphigh").value;
    var stand = document.getElementById("TextBox_BPHigh_Stand").value;
    document.getElementById("TextBox_Postural_Drop").value = sit - stand ;
    document.getElementById("HiddenFieldposturaldrop").value=document.getElementById("TextBox_Postural_Drop").value
}
//////////////////////////////////////////////////////////////////////////////////////////////
