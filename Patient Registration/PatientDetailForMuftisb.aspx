<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="PatientDetailForMuftisb.aspx.cs" Inherits="Patient_Registration_PatientDetailForMuftisb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <%--<link href="Urducss.css" rel="stylesheet" />
    <script type="text/javascript" src="jqueryUedu.js"></script>--%>
  
    <link href="../Scripts/UrduEditor.css" rel="stylesheet" />
    <link href="keyboard.css" rel="stylesheet" />

    <style type="text/css">
        
    </style>

    <script type="text/javascript" src="../Scripts/jquery-3.1.min.js"></script>
    <script type="text/javascript" src="../Scripts/jquery.UrduEditor.js"></script>
    <script type="text/javascript" src="Keyboard.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {            
             
            $('input').UrduEditor("16px");
        }
            );

        function printDiv() {

            var divToPrint = document.getElementById('DivIdToPrint');

            var newWin = window.open('', 'Print-Window');

            newWin.document.open();

            newWin.document.write('<html><body onload="window.print()">' + divToPrint.innerHTML + '</body></html>');

            newWin.document.close();

            setTimeout(function () { newWin.close(); }, 10);

        }



    </script>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   




<div id="DivIdToPrint" class="container" style="text-align: right;font-size:17px;font-weight:bold;">
  <h2>کوائف مریض برائے علاج معالجہ</h2>
         
  <table class="table table-bordered">
  
    <tbody>
      <tr>
        <td colspan="2"><asp:Label ID="lblDate" runat="server"></asp:Label></td>
        <td>تاریخ</td>
        <td style="text-align: center; width: 1em;" colspan="5"> <b> Alkhidmat Foundation Pakistan </b></td>
        <td colspan="2">
            <asp:Label ID="lblMr" runat="server"></asp:Label>
        </td>
        <td>ایم آر</td>
      </tr>
      <tr>
        <td colspan="11" > <b> ذاتی کوائف </b></td>
       
      </tr>
      <tr>
        <td colspan="2"><asp:TextBox cssclass="aligntextForUrdr" runat="server" ID="txtCast"></asp:TextBox></td>
        <td colspan="1">برادری</td>
        <td colspan="2"><asp:Label ID="lblRelationName" runat="server"></asp:Label></td>
        <td colspan="2">ولدیت / زوجیت </td>
       <td colspan="2"><asp:Label ID="lblName" runat="server"></asp:Label></td>
        <td colspan="2">درخواست کنندہ</td>
      </tr>

         <tr>
        <td colspan="2"><asp:TextBox cssclass="aligntextForUrdr" runat="server" ID="txtOccupation"></asp:TextBox></td>
        <td colspan="2">پیشہ</td>
        <td colspan="2"><asp:Label ID="lblAddress" runat="server"></asp:Label></td>
        <td colspan="2">شہر / گائوں </td>
        <td colspan="2"><asp:Label ID="lblDateofBirth" runat="server"></asp:Label></td>
        <td style="width:113px;" colspan="1">عمر/ تاریخ پیدائش</td>
      </tr>

       <tr>
        <td colspan="4"><asp:Label ID="lblIDCard" runat="server"></asp:Label></td>
        <td colspan="2">شناختی کارڈ نمبر </td>
        <td colspan="3"><asp:Label ID="lblReceiptNo" runat="server"></asp:Label></td>
        <td colspan="2">رابطہ نمبر</td>
      </tr>

        <tr>
            <td colspan="11"><b>زیر کفالت افراد:</b></td>
        </tr>

       <tr>
           <td><asp:TextBox cssclass="aligntextForUrdr" Width="100px" ID="txtSon" runat="server"></asp:TextBox></td>
        <td>بیٹے </td>
        <td><asp:TextBox cssclass="aligntextForUrdr" Width="120px" ID="txtdau" runat="server"></asp:TextBox></td>
        <td>بیٹیاں</td>
        <td><asp:TextBox  cssclass="aligntextForUrdr" Width="120px" ID="txtBrotherSister" runat="server"></asp:TextBox></td>
        <td> بہن</td>
        <td><asp:TextBox  cssclass="aligntextForUrdr" Width="120px" ID="txtbro" runat="server"></asp:TextBox></td>
        <td>بھائ </td>
        <td><asp:TextBox cssclass="aligntextForUrdr" Width="120px" ID="txtParent" runat="server"></asp:TextBox></td>
        <td>والدہ</td>
        <td><asp:TextBox cssclass="aligntextForUrdr" Width="35px" ID="txtfa" runat="server"></asp:TextBox> والد</td>
               
      </tr>

        <tr>
        
             <td colspan="10"><asp:TextBox cssclass="aligntextForUrdr" Width="100px" ID="txtOther" runat="server"></asp:TextBox></td>
        <td>دیگر</td>
         <td style="display:none"><asp:TextBox cssclass="aligntextForUrdr" Width="120px" ID="txtDaughter" runat="server"></asp:TextBox></td>
        <td style="display:none">بیٹیاں</td>
         
        </tr>
        
       <tr>
        <td style="height:50px; width:auto;" colspan="11" > 
       <asp:TextBox ID="txtboxDegar" runat="server" TextMode="MultiLine" Height="50px" Width="100%" style="background-color: rgb(153, 255, 153);"></asp:TextBox>
            </td>
      </tr>

     

      <tr>
        <td colspan="11"><b> :درخواست کنندہ کے اثاثہ جات <b></td>
       
      </tr>

      <tr>
        <td colspan="2"><asp:TextBox cssclass="aligntextForUrdr" Width="120px" ID="txtDepositCommite" runat="server"></asp:TextBox></td>
        <td>جمع شدہ کمیٹی</td>
         <td><asp:TextBox cssclass="aligntextForUrdr" Width="120px" ID="txtGoats" runat="server"></asp:TextBox></td>
        <td>مویشی</td>
        <td  colspan="2"><asp:TextBox cssclass="aligntextForUrdr" Width="120px" ID="txtJewellery" runat="server"></asp:TextBox></td>
        <td>زیوات</td>
        <td colspan="2"><asp:TextBox cssclass="aligntextForUrdr" Width="120px" ID="txtSavings" runat="server"></asp:TextBox></td>
        <td> جمع پونجی </td>
      </tr>

       <tr>
        <td colspan="2"><asp:DropDownList ID="ddlLandType" runat="server" cssclass="aligntextForUrdr" Width="120px">
            <asp:ListItem>کوئی نہیں</asp:ListItem>
            <asp:ListItem>زرعی</asp:ListItem>
            <asp:ListItem>نہری</asp:ListItem>
            <asp:ListItem>کاپ</asp:ListItem>
            <asp:ListItem>بنجر</asp:ListItem>
                        </asp:DropDownList></td>
        <td> زمین </td>
         <td style="display:none"><asp:TextBox cssclass="aligntextForUrdr" Width="120px" ID="txtCows" runat="server"></asp:TextBox></td>
        <td style="display:none"> بھینس / گائے  </td>
        <td  colspan="2"><asp:TextBox cssclass="aligntextForUrdr" Width="120px" ID="txtReceiveDebt" runat="server"></asp:TextBox></td>
        <td> وصولی قرض </td>
        <td colspan="2"><asp:TextBox cssclass="aligntextForUrdr" Width="120px" ID="txtMonthlyIncome" runat="server"></asp:TextBox></td>
        <td> ماہانہ آمدن </td>
      </tr>

       <tr>
        <td colspan="2"><asp:TextBox cssclass="aligntextForUrdr" Width="120px" ID="txtLand" runat="server"></asp:TextBox></td>
        <td>  زمین  </td>
         <td><asp:TextBox cssclass="aligntextForUrdr" Width="120px" ID="txtOtherAssets" runat="server"></asp:TextBox></td>
        <td> دیگر </td>
        <td  colspan="2"><asp:TextBox cssclass="aligntextForUrdr" Width="120px" ID="txtVehicle" runat="server"></asp:TextBox></td>
        <td> موٹر سائیکل /گاڑی </td>
        <td colspan="2"><asp:TextBox cssclass="aligntextForUrdr" Width="120px" ID="txtShopHouse" runat="server"></asp:TextBox></td>
        <td> دکان / مکان </td>
      </tr>

        <tr>
        <td colspan="11"> <b> :درخواست کنندہ کے اخراجات </b></td>
       
      </tr>

       <tr>
        <td colspan="2">
            <asp:TextBox cssclass="aligntextForUrdr" ID="txtUtilityBills" runat="server" Width="120px"></asp:TextBox>
           </td>
        <td> یوٹیلٹی بلز  </td>
         <td>
             <asp:TextBox cssclass="aligntextForUrdr" ID="txtHouseRent" runat="server" Width="120px"></asp:TextBox>
           </td>
        <td> گھر کا کرایہ </td>
        <td  colspan="2">
            <asp:TextBox cssclass="aligntextForUrdr" ID="txtReceivedCommite" runat="server" Width="120px"></asp:TextBox>
           </td>
        <td> وصول شدہ کمیٹی </td>
        <td colspan="2">
            <asp:TextBox cssclass="aligntextForUrdr" ID="txtPayings" runat="server" Width="120px"></asp:TextBox>
           </td>
        <td> ادائیگی ادھار<span style="font-family:Arial;color:#000000;font-size:10pt;font-weight:400;font-style:normal;text-decoration:none;">ر</span> </td>
      </tr>

        <tr>
        <td colspan="2">
            <asp:TextBox cssclass="aligntextForUrdr" ID="txtOtherExpences" runat="server" Width="120px"></asp:TextBox>
            </td>
        <td> دیگر  </td>
         <td>
             <asp:TextBox cssclass="aligntextForUrdr" ID="txtPlotRent" runat="server" Width="120px"></asp:TextBox>
            </td>
        <td> پلاٹ کا کرایہ  </td>
        <td  colspan="2">
            <asp:TextBox cssclass="aligntextForUrdr" ID="txtShopRent" runat="server" Width="120px"></asp:TextBox>
            </td>
        <td> دکان کا کرایہ  </td>
        <td colspan="2">
            <asp:TextBox cssclass="aligntextForUrdr" ID="txtPendingInstallment" runat="server" Width="120px"></asp:TextBox>
            </td>
        <td> واجب قسط  </td>
      </tr>

        <tr>
        <td colspan="11" style="text-aligntextForUrdr: center;"><b>  :اقرار نامہ <b></td>
       
      </tr>

      <tr>
        <td colspan="11" style="text-aligntextForUrdr: center;">  میں ـــ ـــ ـــ ـــ ـــ ــــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ اللہ تعالیٰ کو حاضر و ناظر جان کر حلفیہ بیان دیتا / دیتی ھوں کہ مندرجہ بالا کوائف جو کہ میں نے ھسپتال ھذا کو فراھم کیے ہیں، یہ بلکل درست ھیں نیز یہ کہ میں ھاشمی / سادات یا قادیانی فرقے سے تعلق نہیں رکھتا / رکھتی ھوں۔ نیز یہ کہ میں شریعت کے بیان کردہ احکام کی روشنی میں زکوۃ کا / کی شرعی طور پر مستحق ہوں۔ نیز یہ کہ میں ھسپتال انتظامیہ کو اجازت دیتا / دیتی ہوں کہ جب تک میں زیر علاج ہوں ھسپتال انتظامیہ کی طرف سے مقرر کردہ نمائندہ میری طرف سے اصحاب خیر سے زکوۃ و صدقات واجبہ (رقم / اشیاء) وصول کر کے زکوۃ کنسلٹنٹ کی ھدایات کی روشنی میں میرے یا دیگر مریضوں کے علاج معالجے میں استعمال کریں۔ یا ھسپتال ھذا کی ملکیت میں دے دیں تاکہ یہاں کے مستحق زکوۃ مریضوں کے براہ راست اخراجات میں استعمال کی جا سکیں۔ نیز یہ کہ اگر میں شرعی طور پر زکوۃ کا مستحق نہ رہا تو میں ادارہ ھذا کو خود مطلع کروں گا۔  </td>
       
      </tr>

       <tr>
        <td colspan="11" style="text-aligntextForUrdr: left; height:100px;"> <br /><br /><br /><br /><br /><b>  دستخط / انگوٹھے کا نشان:  ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ </b> </td>
       
      </tr>


      <%--<tr>
        
        <td colspan="7" rowspan="3" style="text-aligntextForUrdr: left;"> <b> صرف دفتری استعمال کہ لئے <b>  </td>
        <td colspan="2"><asp:DropDownList ID="ddlCharityFund" runat="server" cssclass="aligntextForUrdr" Width="100px">
            <asp:ListItem>کلی</asp:ListItem>
            <asp:ListItem>جزوی</asp:ListItem>
                        </asp:DropDownList></td>
        <td  colspan="2"> چیرٹی فنڈ  </td>
       
      </tr>--%>

       <%--<tr>
        
       <td colspan="2"><asp:DropDownList ID="ddlZakatFund" runat="server" cssclass="aligntextForUrdr" Width="100px">
            <asp:ListItem>کلی</asp:ListItem>
            <asp:ListItem>جزوی</asp:ListItem>
                        </asp:DropDownList></td>
        <td  colspan="2"> زکوۃ فنڈ   </td>
      </tr>--%>

        <tr>
        
       <td colspan="10" style="text-aligntextForUrdr: left;"><asp:DropDownList ID="ddlPatientType" runat="server" Width="100px" DataSourceID="SQL_Patient_Type_Sub" DataTextField="Patient_type" DataValueField="Patient_Type_Id">
                        </asp:DropDownList></td>
        <td > زکوۃ کوڈ   </td>
      </tr>

        <tr>
        <td colspan="11     "> <b>  زکوۃ آفیسر ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ </b>  </td>
      </tr>

       <tr>

       <td colspan="7"> <b>  زکوۃ کنسلٹنٹ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ  </b></td>
        <td colspan="4"> <b>  تاریخ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ ـــ </b> </td>
        
      </tr>
        
       <tr>
            <td colspan="10">
           <asp:TextBox ID="Z_O_C" runat="server" TextMode="MultiLine" Height="100px" Width="100%" style="background-color: rgb(153, 255, 153);"></asp:TextBox>
            </td>
            </td>
        <td> زکوۃ کنسلٹنٹ آفیسر کمینٹس  </td>
       </tr>        
    </tbody>
  </table>
    <div>
        
         <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn_hacims" OnClick="btnReset_Click"/>
         
         
            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn_hacims" OnClick="btnSave_Click"/>
                <asp:Button ID="btnPrint" runat="server" class="btn btn-default" Text="Print" OnClick="btnPrint_Click"/>
        <asp:Button ID="Reverify" runat="server" class="btn btn-default" Text="Reverify" Onclick="btnReverify_Click"/>
                <asp:Label ID="lblMessage" runat="server"></asp:Label>             
    </div>
    <asp:HiddenField ID="HfRegNo" runat="server"/>
    <asp:HiddenField ID="HfStatus" runat="server"/>
    <asp:HiddenField ID="hfYearlyNo" runat="server"/>
    <asp:SqlDataSource ID="SQL_Patient_Type_Sub" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>" 
        SelectCommand="SELECT pt.Patient_type, pt.ID, pt.Active, pt.Patient_type_Cat, pth.Hospital_Id, pth.Patient_Type_Id, pth.Dependent_Allow, pth.Panel_Company FROM Patient_Type AS pt INNER JOIN Patient_Type_HospitalWise AS pth ON pt.ID = pth.Patient_Type_Id
         WHERE (pth.Hospital_Id = @Hospital_Id) AND (pt.Active = 'True') AND pt.ID not in (1005,1006) ORDER BY pt.Priority">
        <SelectParameters>
            <asp:SessionParameter Name="Hospital_Id" SessionField="HospitalID" />
        </SelectParameters>
    </asp:SqlDataSource>
</div>

 

</asp:Content>

