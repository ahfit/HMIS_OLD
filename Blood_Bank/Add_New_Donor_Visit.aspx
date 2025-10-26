<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage_admin.master" inherits="BloodDonorRegistration, App_Web_ob4gay25" enableeventvalidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style type="text/css">
    .input_txt {
        width: 135px;
    }
</style>

<script type ="text/javascript"  language="javascript">
    function show(a) {

        document.form1.RBLrelation_0.checked = true

        if (document.form1.RBLprefix_1.checked) {

            document.form1.RBLrelation_1.checked = true
        }

        if (document.form1.RBLprefix_2.checked) {

            document.form1.RBLrelation_2.checked = true
        }
    }

    function resetform() {
        document.form1.reset();
        document.getElementById("dropdownlistdiagnosis").focus();
    }

    function showFocus(a) {
        document.getElementById("dropdownlistdiagnosis").disabled = true;
    }

    function showFocus1(a) {
        if (a.value.length != 0) {
            document.getElementById("dropdownlistdiagnosis").disabled = true;
        }
        else {
            document.getElementById("dropdownlistdiagnosis").disabled = false;
        }
    }
    function checkrequiredname(a) {
        var PFName = document.getElementById("textboxpfname").value;
        var PMName = document.getElementById("textboxpmname").value;
        var RFName = document.getElementById("textboxrfname").value;
        var RMName = document.getElementById("textboxrmname").value;
        if (document.getElementById("textboxpfname").value.length == 0) {
            alert("Enter first name");
            document.getElementById("textboxpfname").focus();
            return false;
        }
        if (document.getElementById("textboxrfname").value.length == 0) {
            alert("Enter Relation first name");
            document.getElementById("textboxrfname").focus();
            return false;
        }
        if (document.getElementById("textboxage").value.length == 0) {
            alert("Enter Age");
            document.getElementById("textboxage").focus();
            return false;
        }
        if (PFName - 0 == PFName) {
            alert("Enter the Correct Patient First Name");
            document.getElementById("textboxpfname").focus();
            return false;
        }
        if ((PMName.length - 0) != 0) {
            if (PMName - 0 == PMName) {
                alert("Enter the Correct Patient Middle Name");
                document.getElementById("textboxpmname").focus();
                return false;
            }
        }

        if (RFName - 0 == RFName) {
            alert("Enter the Correct Patient Relation First Name");
            document.getElementById("textboxrfname").focus();
            return false;
        }
        if ((RMName.length - 0) != RMName) {
            if (RMName - 0 == RMName) {
                alert("Enter the Correct Patient Relation Middle Name");
                document.getElementById("textboxrmname").focus();
                return false;
            }
        }
        return ForAge();

    }
    function checkrequiredrfname(a) {
        if (document.getElementById("textboxrfname").value.length == 0) {
            //alert("Enter first name");
            //document.getElementById("txtrfname").focus();
        }
    }

    function ForAge() {
        var age;
        age = document.getElementById("textboxage").value;
        if (age - 0 == age) {
            if ((age >= 1) && (age <= 150)) {
            }
            else {
                alert("Enter Correct Age");
                document.getElementById("textboxage").focus();
                return false;
            }
        }
        else {
            alert("Must Enter Integer ");
            document.getElementById("textboxage").focus();
            return false;
        }
    }
    function ForName() {
        alert("Hello");


    }
</script>

<body onLoad="getList(this)">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">




<script type="text/javascript" src="CommanMJAJAXLibrary.js"></script>
<script type="text/javascript">
    var object1 = createXmlObject();
    var argsName;
    var argsValue;

    function getList(from) {
        if (from.value == null) {
            var Selectioncategory = 'country';
            argsName = "cc";
            argsValue = "ALL";
        }
        else if (from.name == 'country') {
            var Selectioncategory = 'Province';
            argsName = "pp";
            argsValue = from.value;
        }
        else if (from.name == 'Province') {
            var Selectioncategory = 'district';
            argsName = "dd";
            argsValue = from.value;
        }
        else if (from.name == 'district') {
            var Selectioncategory = 'tehsil';
            argsName = "tt";
            argsValue = from.value;
            document.getElementById('textboxphonecode').value = from.value;

        }

        /////////////////////////////////////////////////////////////////////////      
        if (object1) {

            object1.open("GET", "http://" + location.host + "/mayo1/Hfindaddress.ashx?a=" + argsName + "&b=" + argsValue, false);
            object1.onreadystatechange = function () {
                if (object1.readyState == LOADING) {
                    document.getElementById('wait').style.display = "block";
                    var mark = document.getElementById('wait');
                    mark.style.left = event.clientX;
                    mark.style.top = event.clientY;

                }
                if (object1.readyState == COMPLETE) {
                    document.getElementById('wait').style.display = "none";

                    var values = object1.responseXML;
                    var nodes = values.selectNodes("//root/collection");
                    var i = 0;
                    var countryList = document.getElementById(Selectioncategory);

                    while (i < countryList.length) {
                        document.getElementById(Selectioncategory).removeChild(countryList[0]);
                    }
                    while (i < nodes.length) {
                        var newoption = document.createElement('option');
                        countryList.options.add(newoption);
                        newoption.text = nodes[i].selectSingleNode("name/text()").nodeValue;
                        newoption.value = nodes[i].selectSingleNode("code/text()").nodeValue;



                        i++;
                    }

                }
            }
            object1.send("SomeDataToSend");
        }
        ///////////////////////////////////////////////////////////////////////////////////////////////
        if (from.value == null) {
            countryList = document.getElementById('country');
            getList(countryList);
        } else if (from.name == 'country') {
            ProvinceyList = document.getElementById('Province');
            getList(ProvinceyList);
        } else if (from.name == 'Province') {
            ProvinceyList = document.getElementById('district');
            getList(ProvinceyList);
        }

        ///////////////////////////////////////////////////////////////////////////////////////////////  
        document.getElementById('HiddenField_country').value = document.getElementById('country').value;
        document.getElementById('HiddenField_province').value = document.getElementById('Province').value;
        document.getElementById('HiddenField_district').value = document.getElementById('district').value;
        document.getElementById('HiddenField_tehsil').value = document.getElementById('tehsil').value;
    }
    function setit(a) {
        document.getElementById('HiddenField_tehsil').value = document.getElementById('tehsil').value;
    }
    function TABLE1_onclick() {

    }

</script>
<div class="bxmain inner_content" style="width:100%">
            <h2><span style="font-size: 25px !important">Register New Donor</span></h2>
    </div>
<h1 class="h1"><span>Previous History</span></h1>
<div class="bxmain" style="width:100%">


<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  
    <tr>
        <td align="right" width="16%">
            Reg. No. :</td>
        <td width="16%">
      <asp:Label ID="Label_Registration_No" runat="server" Text="" Width="143px" CssClass="red"></asp:Label></td>
        <td align="right" >
            Sample No. :</td>
        <td width="16%">
      <asp:Label ID="Label_sample_No" runat="server" Text=""  CssClass="red"></asp:Label></td>
        <td align="right" width="16%">
            &nbsp;</td>
        <td align="right" width="16%">
            &nbsp;</td>
        <td align="right" width="16%">
            &nbsp;</td>
        <td width="16%">
      </td>
    </tr>
  
  <tr>
    <td width="16%" align="right">Date &nbsp;:</td>
    <td width="16%">
       <igsch:WebDateChooser ID="WebDateChooser1" runat="server">
        </igsch:WebDateChooser>
        <asp:HiddenField ID="HiddenField_PeriviousDate" runat="server" />
      <span style="font-size:9px; color:#333333;;">MM,DD, YYYY</span></td>
    <td width="16%" align="right" >Place &nbsp;:</td>
    <td width="16%">
      <asp:TextBox ID="TextBox_previous_place" runat="server"  CssClass="input_txt"
                        TabIndex="23" ></asp:TextBox>
    </td>
    <td align="right">Donor Type :</td>
    <td width="16%" align="left">
        <asp:DropDownList ID="DropDownList_type_of_donor" runat="server"  Width="138px"
                    DataSourceID="SqlDataSource_Type_Of_Donor" DataTextField="Type_Of_Donor" DataValueField="Type_Of_Donor" TabIndex="12" AutoPostBack="True" OnSelectedIndexChanged="DropDownList_type_of_donor_SelectedIndexChanged"> </asp:DropDownList>
    </td>
    <td width="16%" align="right"><asp:Label ID="Label_ReferenceNo" runat="server" Text="Reference No:" Visible="False"></asp:Label></td>
    <td width="16%"><asp:SqlDataSource ID="SqlDataSource_Type_Of_Donor" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                SelectCommand="SELECT [Type_Of_Donor] FROM [Donor_Type]" ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>"></asp:SqlDataSource>
      <asp:TextBox ID="TextBox_refrence_id" runat="server"  TabIndex="2"  CssClass="input_txt" AutoPostBack="True" OnTextChanged="TextBox_refrence_id_TextChanged" Visible="False"    ></asp:TextBox>
      <asp:Label ID="Label_Alert" runat="server" ForeColor="Red" Text="Enter Patient Reg No."
                Visible="False"></asp:Label></td>
  </tr>
  <tr>
    <td align="right">Dizziness &nbsp;:</td>
    <td>
      <asp:CheckBox ID="CheckBox_previous_Dizziness" runat="server" TabIndex="25" />      
    </td>
    <td align="right">Fainting &nbsp;:&nbsp;</td>
    <td>&nbsp;<asp:CheckBox ID="CheckBox_previous_fainting" runat="server" TabIndex="24" /></td>
    <td align="right">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td>&nbsp;
            <asp:SqlDataSource ID="SqlDataSource_info" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>" InsertCommand="BloodBank_insert_New_Donor" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>">
                <InsertParameters>
                    <asp:ControlParameter ControlID="Label_Registration_No" DefaultValue="" Name="Donor_Registration_No"
                        PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="DropDownList_type_of_donor" DefaultValue="" Name="Type_Of_Donor"
                        PropertyName="SelectedValue" Type="String" />
                    <asp:SessionParameter DefaultValue="" Name="Emp_Id" SessionField="Emp_Id" Type="Int32" />
                    <asp:ControlParameter ControlID="Label_sample_No" DefaultValue="" Name="Sample_No"
                        PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="TextBox_refrence_id" Name="Ref_Patient_Reg_No" PropertyName="Text"
                        Type="String" />
                    <asp:ControlParameter ControlID="HiddenField_PeriviousDate" Name="Previous_Date" PropertyName="Value"
                        Type="DateTime" />
                    <asp:ControlParameter ControlID="TextBox_previous_place" Name="Previous_Place" PropertyName="Text"
                        Type="String" />
                    <asp:ControlParameter ControlID="CheckBox_previous_fainting" Name="Previous_Fainting"
                        PropertyName="Checked" Type="Boolean" />
                    <asp:ControlParameter ControlID="CheckBox_previous_Dizziness" Name="Previous_Dizziness"
                        PropertyName="Checked" Type="Boolean" />
                    <asp:ControlParameter ControlID="HiddenField_Pt_YearlyNo" Name="Pt_YearlyNo" PropertyName="Value"
                        Type="Int32" />
                    <asp:ControlParameter ControlID="HiddenField_Pt_RegNo" DefaultValue="" Name="Pt_RegNo"
                        PropertyName="Value" Type="String" />
                    <asp:Parameter DefaultValue="Assesment" Name="Decision" Type="String" />
                </InsertParameters>
            </asp:SqlDataSource>
            </td>
  </tr>
</table>    
</div>
<div class="bxmain" style="width:100%">



<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
    
  <tr>
    <td width="15%" align="right">Patient Title : </td>
    <td width="16%">
      <asp:RadioButtonList ID="RBLprefix" runat="server" RepeatLayout="Flow" 
                        RepeatDirection="Horizontal"   TabIndex="1" AutoPostBack="True" OnSelectedIndexChanged="RBLprefix_SelectedIndexChanged">
        <asp:ListItem Selected="True">Mr.</asp:ListItem>
        <asp:ListItem>Miss</asp:ListItem>
        <asp:ListItem>Mrs.</asp:ListItem>
      </asp:RadioButtonList>
    </td>
    <td width="16%" align="right"></td>
    <td width="16%">&nbsp;
        </td>
    <td width="16%">&nbsp;</td>
    <td width="16%"><asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="BloodBankPages.aspx">Back</asp:HyperLink></td>
  </tr>
  <tr>
    <td align="right">First Name :</td>
    <td><asp:TextBox ID="textboxpfname"  runat="server"  TabIndex="3" CssClass="input_txt"     BackColor="White"></asp:TextBox>
<span class="red">*</span>
  <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="textboxpfname"
                    ErrorMessage="*"></asp:RequiredFieldValidator></td>
    <td align="right">Middle Name :</td>
    <td>
      <asp:TextBox ID="textboxpmname" runat="server"    
                       CssClass="input_txt"      TabIndex="4"></asp:TextBox>
    </td>
    <td align="right">Last Name : </td>
    <td style="width:20%"><asp:TextBox ID="textboxplname" runat="server" CssClass="input_txt"    
                        Visible="true" TabIndex="5"></asp:TextBox>
<span class="red">*</span>
  <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="textboxplname"
                    ErrorMessage="*"></asp:RequiredFieldValidator></td>
  </tr>
  <tr>
    <td align="right">Relation Title :</td>
    <td>
      <asp:RadioButtonList ID="RBLrelation" runat="server" 
                       RepeatDirection="Horizontal" RepeatLayout="Flow"
                        TabIndex="6">
        <asp:ListItem Selected="True">S/O</asp:ListItem>
        <asp:ListItem>D/O</asp:ListItem>
        <asp:ListItem>W/O</asp:ListItem>
      </asp:RadioButtonList>
    </td>
    <td align="right">&nbsp;</td>
    <td>&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right">First Name : </td>
    <td><asp:TextBox ID="textboxrfname" runat="server"  CssClass="input_txt"      TabIndex="7"></asp:TextBox>
<span class="red">*</span>
  <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="textboxrfname"
                    ErrorMessage="*"></asp:RequiredFieldValidator></td>
    <td align="right">Middle Name : </td>
    <td>
      <asp:TextBox ID="textboxrmname" runat="server"   Font-Names="Verdana"
                     CssClass="input_txt"      TabIndex="8"></asp:TextBox>
    </td>
    <td align="right">Last Name : </td>
    <td>
      <asp:TextBox ID="textboxrlname" runat="server"    
                     CssClass="input_txt"      Visible="true" TabIndex="9"></asp:TextBox>
<span class="red">*</span>
<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="textboxrlname"
                    ErrorMessage="*"></asp:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td align="right">Age : </td>
    <td>
      <asp:TextBox ID="textboxage" runat="server"   CssClass="input_txt"     Width="78px"  AccessKey="a" TabIndex="10" ></asp:TextBox>
      &nbsp;
                <span class="red">*</span>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="textboxage"
                    ErrorMessage="*"></asp:RequiredFieldValidator>
      Years</td>
    <td align="right">Gender : </td>
    <td>
      <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatLayout="Flow" 
                    RepeatColumns="2" TabIndex="11">
        <asp:ListItem Selected="True">Male</asp:ListItem>
        <asp:ListItem>Female</asp:ListItem>
      </asp:RadioButtonList>
     <span class="red">*</span>
      <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="RadioButtonList1"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
    </td>
    <td align="right">&nbsp;
        </td>
    <td>&nbsp;
        </td>
  </tr>
  <tr>
    <td align="right">Occupation : </td>
    <td>
      <asp:TextBox ID="TextBox_Occupation" runat="server" CssClass="input_txt"      TabIndex="13" ></asp:TextBox>
<span class="red">*</span>
<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="TextBox_Occupation"
                    ErrorMessage="*"></asp:RequiredFieldValidator>
    </td>
    <td align="right">&nbsp;
        </td>
    <td>&nbsp;
        </td>
    <td align="right">&nbsp; </td>
    <td>&nbsp;
        </td>
  </tr>
</table></div>
<br />


<div class="bxmain" style="width:100%">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td width="15%" align="right">CNIC # :</td>
    <td width="16%">
        <asp:TextBox ID="TextBox_CNIC" runat="server" visible="false"></asp:TextBox>
      <asp:TextBox ID="textboxnic1" runat="server" MaxLength="5" Text="" CssClass="input_txt"     Width="34px"  TabIndex="14" ></asp:TextBox>&nbsp;
<asp:TextBox
                        ID="textboxnic2" runat="server" MaxLength="7" CssClass="input_txt"     Width="57px"  TabIndex="15"></asp:TextBox>&nbsp;
<asp:TextBox
                            ID="textboxnic3" runat="server" MaxLength="1" CssClass="input_txt"     Width="15px"  TabIndex="16"></asp:TextBox>
    </td>
    <td width="16%" align="right">Country   :&nbsp;</td>
    <td width="16%">
      <asp:DropDownList ID="country" runat="server"  Width="138px" AutoPostBack="True" DataSourceID="SqlDataSource3" DataTextField="CountryName" DataValueField="CountryCode" OnSelectedIndexChanged="country_SelectedIndexChanged" Enabled="False" > </asp:DropDownList>
      <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    SelectCommand="SELECT CountryCode, CountryName FROM Country"></asp:SqlDataSource>
    </td>
    <td width="16%" align="right">Province   :&nbsp;</td>
    <td >
      <asp:DropDownList ID="Province" runat="server" CssClass="text_dropdown"
                      Width="138px" TabIndex="17" AutoPostBack="True" DataSourceID="SqlDataSource4" DataTextField="ProvinceName" DataValueField="ProvinceCode" OnSelectedIndexChanged="Province_SelectedIndexChanged" Enabled="False"> </asp:DropDownList>
      <asp:TextBox ID="textboxprovince2" runat="server" Visible="False"
                      Width="99px" ></asp:TextBox>
      <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    SelectCommand="SELECT ProvinceName, ProvinceCode FROM Province WHERE (CountryCode = @CountryCode) ORDER BY ProvinceName">
        <SelectParameters>
          <asp:ControlParameter ControlID="country" Name="CountryCode" PropertyName="SelectedValue" />
        </SelectParameters>
      </asp:SqlDataSource>
    </td>
  </tr>
  <tr>
    <td align="right">District   : </td>
    <td>
      <asp:DropDownList ID="district" runat="server" CssClass="text_dropdown"
                      Width="138px" TabIndex="18" AutoPostBack="True" DataSourceID="SqlDataSource5" DataTextField="DistrictName" DataValueField="DistrictCode" OnSelectedIndexChanged="district_SelectedIndexChanged" Enabled="False"> </asp:DropDownList>
      <br />
      <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    SelectCommand="SELECT DistrictName, DistrictCode, Dialing_Cod FROM DISTRICT WHERE (ProvinceCode = @ProvinceCode) ORDER BY DistrictName">
        <SelectParameters>
          <asp:ControlParameter ControlID="Province" Name="ProvinceCode" PropertyName="SelectedValue" />
        </SelectParameters>
      </asp:SqlDataSource>
    </td>
    <td align="right">Tehsil   : </td>
    <td>
      <asp:DropDownList ID="tehsil" runat="server" CssClass="text_dropdown" Width="138px" TabIndex="19" DataSourceID="SqlDataSource6" DataTextField="TehsilName" DataValueField="TehsilCode" AutoPostBack="True" Enabled="False"> </asp:DropDownList>
      <br />
      <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    SelectCommand="SELECT TehsilName, TehsilCode FROM TEHSIL WHERE (districtCode = @districtCode) ORDER BY TehsilName">
        <SelectParameters>
          <asp:ControlParameter ControlID="district" Name="districtCode" PropertyName="SelectedValue" />
        </SelectParameters>
      </asp:SqlDataSource>
    </td>
    <td align="right">Address : </td>
    <td >
      <asp:TextBox ID="textboxHouseNo" runat="server"    
                     CssClass="input_txt"      TabIndex="20" Enabled="False"></asp:TextBox>
<span class="red">*</span>
<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="textboxHouseNo"
                    ErrorMessage="*"></asp:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td align="right">Phone No.    :&nbsp;</td>
    <td>
        <asp:TextBox ID="TextBox_Phone" runat="server" Enabled="False"></asp:TextBox>
      <asp:TextBox ID="textboxcountrycode" runat="server"    
                      Width="30px" Visible="False"  >0092</asp:TextBox>&nbsp;
<asp:TextBox ID="textboxphonecode" runat="server"  
                            Width="30px" Visible="False"  >42</asp:TextBox>&nbsp;
<asp:TextBox ID="textboxphoneno" runat="server"
                                  MaxLength="7" Width="43px"  TabIndex="21" Visible="False"></asp:TextBox>
<span class="red">*</span>
<asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="textboxphoneno"
                    ErrorMessage="*"></asp:RequiredFieldValidator>
    </td>
    <td align="right">&nbsp;</td>
    <td>&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td >&nbsp;</td>
  </tr>
</table>

</div>
    <br />
     <div align="center"><asp:Button ID="ButtonSave" runat="server" Text="Save" TabIndex="26" OnClick="ButtonSave_Click" /></div>
 

<asp:HiddenField ID="HiddenField_country" runat="server" Value="12" />
            <asp:HiddenField ID="HiddenField_province" runat="server" Value="12" />
            <asp:HiddenField ID="HiddenField_district" runat="server" Value="12" />
            <asp:HiddenField ID="HiddenField_tehsil" runat="server" Value="12" />
            <asp:HiddenField ID="HiddenField_Emp_Id" runat="server" />
            <asp:HiddenField ID="HiddenField_Dept_Id" runat="server" />
            <asp:HiddenField ID="HiddenField_Pt_YearlyNo" runat="server" />
   
            <asp:HiddenField ID="HiddenField_Request_Id" runat="server" />
            <asp:SqlDataSource ID="SqlDataSource_forward" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                InsertCommand="pt_InnerDepartment_PatientForward" InsertCommandType="StoredProcedure"
                ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>">
                <InsertParameters>
                    <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                    <asp:ControlParameter ControlID="Label_Registration_No" Name="RegNo" PropertyName="Text"
                        Type="String" />
                    <asp:ControlParameter ControlID="HiddenField_Emp_Id" Name="EmpID" PropertyName="Value"
                        Type="Int32" />
                    <asp:Parameter DefaultValue="0" Name="PayID" Type="Decimal" />
                    <asp:Parameter DefaultValue="17" Name="ToSubDept" Type="Int32" />
                    <asp:ControlParameter ControlID="HiddenField_Dept_Id" DefaultValue="" Name="SendingDept"
                        PropertyName="Value" Type="Int32" />
                    <asp:Parameter DefaultValue="6" Name="iRequestTypeTo" Type="Int32" />
                    <asp:Parameter DefaultValue="6" Name="iRequestTypeBy" Type="Int32" />
                </InsertParameters>
            </asp:SqlDataSource>
    
            <asp:HiddenField ID="HiddenField_NIC" runat="server" />
    <asp:HiddenField ID="HiddenField_Pt_RegNo" runat="server" />
<br />
<br />


 
 <div id="wait" style="position:absolute; left: 96px; top: 446px;">
<%--<img src="wt.GIF" />--%></div></asp:Content>