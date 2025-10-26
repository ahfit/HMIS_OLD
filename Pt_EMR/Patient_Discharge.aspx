<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage.master" inherits="Patient_Discharge, App_Web_p0fljamz" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.UltraWebTab.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebTab" TagPrefix="igtab" %>
<%@ Register Assembly="Infragistics2.WebUI.WebNavBar.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebNavBar" TagPrefix="ignavbar" %>
<%@ Register Assembly="Infragistics2.WebUI.UltraWebToolbar.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebToolbar" TagPrefix="igtbar" %>
<%@ Register Assembly="Infragistics2.WebUI.UltraWebGrid.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@ Register Assembly="Infragistics2.WebUI.UltraWebNavigator.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebNavigator" TagPrefix="ignav" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>


<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>





 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">



 
<script type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
    document.getElementById("3").value ="sda";
}
//-->
function Radio()
{
if (document.getElementById("RadioButtonList_Category_0").checked == true)
    {
      document.getElementById("TD1").style.visibility ="hidden";
    document.getElementById("RadioButtonList_Category_0").checked =true;
     document.getElementById("ButtonSave").value ="Discharge";
    return false;
    }
 else
 {
    document.getElementById("TD1").style.visibility ="visible"; //ButtonSave
    document.getElementById("ButtonSave").value ="Refer";
    return false; 
 }
}
function load()
{
alert("dsaas");
}
</script>
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
   
<!--<script src="../css_hacims/ck.js" type="text/javascript"></script>
<script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript"></script>
-->
<script>

$(document).ready(function(e) {
    
		 
	
	      //var pageheight = $(document).height();
		 // $('.slideLeftMenu').height(pageheight+100);
		  
		  $(document).on("click",".left_usermenu,#lightbox_bgm",function(e){
		  
		  	e.preventDefault();
			    
					 $('.slideLeftMenu').animate({width: 'toggle'},300);
					  
					  var ml = $('#lightbox_bgm').css('display');
						  
						if(ml=="none"){  $('#lightbox_bgm').fadeIn(300,function(){  });
						 	 
						}else {    $('#lightbox_bgm').fadeOut(300,function(){ }); 
					  
					    }					 
		    });
	
	
	
});



</script>



 </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div id="lightbox_bgm"></div>
<div class="slideLeftMenu"><div id="menuScroll"><asp:Label ID="LabelSideMenu" runat="server" Visible="true"></asp:Label></div></div>
<div class="main_bx">
         <ul class="mainpage_tabs">
         <li><a href="#" class="active" id="form_show">Form</a></li>
         <li><a href="#" id="remarks_show">Record</a></li>      
         </ul>
 		 <div class="pageContent">
		
        <asp:Panel ID="Panel1" runat="server"></asp:Panel>
        
 
 
 
 

<div class="bx_01" style="width:98%;">

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form">
  <!--DWLayoutTable-->
            <tr>
              <td align="left" style="width: 964px"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="25%" align="right" >Category : </td>
                  <td width="75%" >
                    <asp:RadioButtonList ID="RadioButtonList_Category" runat="server"
                              RepeatColumns="5" RepeatDirection="Horizontal" RepeatLayout="Flow" AutoPostBack="True">
                      <asp:ListItem Selected="True" Value="2">Follow Up</asp:ListItem>
                      <asp:ListItem Value="1">Discharge</asp:ListItem>
                      <asp:ListItem Value="3">Expired</asp:ListItem>
                      <asp:ListItem Value="4">Abscond/LAMA</asp:ListItem>
                      <asp:ListItem Value="0">Shift To Other Dept.</asp:ListItem>
                    </asp:RadioButtonList>
</td>
                </tr>
              </table>

               
                <asp:Panel ID="Panel_Department" runat="server" >
                <table  border="0" width="100%" cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="25%" align="right" ><span class="style1">
                      <asp:Label ID="Label_Refer_Dept" runat="server" Text="Refer to Department :  " ></asp:Label>
&nbsp;                    </span> </td>
                    <td width="75%" >
                      <asp:DropDownList AutoPostBack="True" 
                          DataTextField="Dept_Name" DataValueField="Dept_ID" ID="DropDownList_Department" runat="server" DataSourceID="SqlDataSourceDepartment" Width="411px"> </asp:DropDownList>

                    <asp:DropDownList 
                          DataTextField="SubDept_Name" DataValueField="SubDept_Id" ID="DropDownList_SubDepartment" runat="server" DataSourceID="SqlDataSource_subDept" Width="409px"> </asp:DropDownList></td>
                  </tr>
                </table></asp:Panel>
               
                <asp:Panel ID="Panel_Hospital" runat="server" >
                <table border="0" width="100%" cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="25%" align="right" ><span class="style2">
                      <asp:Label ID="Label_Hospital" runat="server" Text="Refer to other Hospital :" ></asp:Label>
&nbsp;                    </span> </td>
                    <td width="75%" >
                      <asp:TextBox CssClass="input_txt" ID="TextBox_Hospital" runat="server" Width="415px"></asp:TextBox>
                    </td>
                  </tr>
                </table></asp:Panel>
               
                <asp:Panel ID="Panel_Follow" runat="server" >
                <table border="0" width="100%" cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="25%" align="right" ><span class="style3">
                      <asp:Label ID="Label_FollowUp" runat="server" Text="Follow Up after :" ></asp:Label>
&nbsp;                    </span> </td>
                    <td width="75%" >
                      <asp:TextBox CssClass="input_txt" ID="TextBoxNext_Visit" runat="server" ></asp:TextBox>
                    Days</td>
                  </tr>
                </table></asp:Panel>
               
                <asp:Panel ID="Panel_Other" runat="server" >
                <table border="0" width="100%" cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="25%"  align="right" valign="top">
                        Treatment : </td>
                    <td  width="75%">
                      <asp:TextBox CssClass="input_txt" Height="60px" ID="TextBox_Other_Any" runat="server"
                                  TextMode="MultiLine" Width="75%" 
                                  ></asp:TextBox>&nbsp;&nbsp;<asp:LinkButton ID="LinkButton1" runat="server" CssClass="err" PostBackUrl="~/Pt_EMR/Pt_Death_Certificate.aspx"
                                              Visible="False" >Death Certificate</asp:LinkButton>
</td>
                  </tr>
                </table></asp:Panel>
                 
                  
                <table  cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                      <tr>
                          <td align="right" width="25%" >
                              Heading :</td>
                          <td >
                              <asp:DropDownList ID="DropDownList_Discharge_Heading" runat="server" AutoPostBack="True"
                                  DataSourceID="SqlDataSource_Discharge_Heading" DataTextField="Discharge_Headings"
                                  DataValueField="Discharge_Headings_Id" Width="300px">
                              </asp:DropDownList></td>
                      </tr>
                      <tr>
                          <td align="right" valign="top" >
                              Description:</td>
                          <td >
                              <asp:TextBox ID="TextBox_Description" runat="server" Height="100px" TextMode="MultiLine"
                                  Width="75%"></asp:TextBox></td>
                      </tr>
                      <tr>
                          <td >
                          </td>
                          <td >
                              <asp:Button ID="Button_Save" runat="server" Text="Save" /></td>
                      </tr>
                     
                      <tr>
                          <td colspan="2" >
                            <asp:DataList ID="DataList_Discharge_Headings" runat="server" DataSourceID="SqlDataSource_Discharge_Datalist" Width="100%">
                              <ItemTemplate>
                                <table  cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="98%">
                                  <tr>
                                    <td >
                                      <asp:Label ID="Discharge_HeadingLabel" runat="server" Font-Bold="True" Text='<%# Eval("Discharge_Heading") %>'></asp:Label></td>
                                   </tr>
                                  <tr>
                                    <td >
                                      <asp:Label ID="DescriptionLabel" runat="server" style="line-height:18px;" Text='<%# Eval("Description") %>'></asp:Label></td>
                                   </tr>
                                  </table>
                                </ItemTemplate>
                          </asp:DataList></td>
                      </tr>
                  </table>
                  <br />
                  <asp:SqlDataSource ID="SqlDataSource_Discharge_Heading" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                      SelectCommand="SELECT Discharge_Headings, Discharge_Headings_Id FROM Discharge_Headings ORDER BY Priority">
                  </asp:SqlDataSource>
                  <asp:SqlDataSource ID="SqlDataSource_Discharge_Datalist" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                      InsertCommand="Insert_Patient_Discharge_Info" InsertCommandType="StoredProcedure"
                      ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                      SelectCommand="SELECT Patient_Discharge_Info.Discharge_Heading, Patient_Discharge_Info.Description FROM Patient_Discharge_Info INNER JOIN Discharge_Headings ON Patient_Discharge_Info.Discharge_Heading_Id = Discharge_Headings.Discharge_Headings_Id WHERE (Patient_Discharge_Info.Yearly_No = @Yearly_No) AND (Patient_Discharge_Info.Reg_No = @Reg_No) ORDER BY Discharge_Headings.Priority"
                      UpdateCommandType="StoredProcedure">
                      <SelectParameters>
                          <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" />
                          <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" />
                      </SelectParameters>
                      <InsertParameters>
                          <asp:ControlParameter ControlID="DropDownList_Discharge_Heading" Name="Discharge_Heading_Id"
                              PropertyName="SelectedValue" Type="Int32" />
                          <asp:ControlParameter ControlID="TextBox_Description" DefaultValue="" Name="Description"
                              PropertyName="Text" Type="String" />
                          <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" Type="Decimal" />
                          <asp:SessionParameter DefaultValue="" Name="Reg_No" SessionField="registrationNo"
                              Type="String" />
                          <asp:ControlParameter ControlID="HiddenField_DischargeHeading" Name="Discharge_Heading"
                              PropertyName="Value" Type="String" />
                      </InsertParameters>
                  </asp:SqlDataSource>
                  <asp:HiddenField ID="HiddenField_DischargeHeading" runat="server" />
                  <asp:SqlDataSource ID="SqlDataSource_Shift_Insert" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                      InsertCommand="Pt_InnerDepartment_PatientForward" InsertCommandType="StoredProcedure"
                      ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" UpdateCommand="UPDATE  Payment Set Patient_Type='IPD' where PayID=@PayID">
                      <UpdateParameters>
                          <asp:SessionParameter Name="PayID" SessionField="PayId" />
                      </UpdateParameters>
                      <InsertParameters>
                          <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
                          <asp:SessionParameter Name="EmpID" SessionField="emp_id" Type="Int32" />
                          <asp:SessionParameter Name="PayID" SessionField="PayId" Type="Decimal" />
                          <asp:ControlParameter ControlID="DropDownList_SubDepartment" Name="ToSubDept" PropertyName="SelectedValue"
                              Type="Int32" />
                          <asp:SessionParameter Name="SendingDept" SessionField="SubDeptID" Type="Int32" />
                          <asp:Parameter DefaultValue="6" Name="iRequestTypeTo" Type="Int32" />
                          <asp:Parameter DefaultValue="1" Name="iRequestTypeBy" Type="Int32" />
                      </InsertParameters>
                  </asp:SqlDataSource>
                  <asp:SqlDataSource ID="SDC_Shift_To_Other" runat="server"></asp:SqlDataSource>
                  <br />
               
                <table border="0" width="100%" cellpadding="0" cellspacing="0">
                <tr>
                  <td align="right" width="25%" ></td><td  width="75%">

                  <asp:Button  ID="ButtonSave" runat="server" Text="Discharge"  />
                       <asp:Button ID="Button_Bill" runat="server"  Text="Calculate Bill" Visible="False" /></td>
                  </tr>
                  </table>                

                  <asp:Label CssClass="err"  ID="LabelMessage" runat="server" ></asp:Label>
				<asp:Label ID="Label_message" runat="server" CssClass="err"></asp:Label>
                  <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
            ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>" UpdateCommand="UPDATE Payment SET DischargeStatus = @DischargeStatus WHERE (RegNo = @RegNo) AND (PayID = @PayID)">
                    <UpdateParameters>
                      <asp:ControlParameter ControlID="RadioButtonList_Category" Name="DischargeStatus"
                          PropertyName="SelectedValue" />
                      <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                      <asp:SessionParameter Name="PayID" SessionField="YearlyNo" />
                    </UpdateParameters>
                  </asp:SqlDataSource>
                  <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                      SelectCommand="Select_Hospital_Dept" SelectCommandType="StoredProcedure">
                      <SelectParameters>
                          <asp:SessionParameter Name="Hospital_Id" SessionField="HospitalId" Type="Int32" />
                      </SelectParameters>
                  </asp:SqlDataSource>
             
                <asp:SqlDataSource ID="SqlDataSource_subDept" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                      SelectCommand="SELECT SubDept_Id, SubDept_Name FROM SubDepartment WHERE (Dept_Id = @Dept_Id) and SubDept_Id not in (Select SubDept_Id  from SubDepartment where SubDept_Id=@Sub_dept) and SubDept_Id <> 36">
                    <SelectParameters>
                      <asp:ControlParameter ControlID="DropDownList_Department" Name="Dept_Id" PropertyName="SelectedValue" />
                        <asp:SessionParameter Name="Sub_dept" SessionField="SubdeptID" />
                    </SelectParameters>
                  </asp:SqlDataSource>
                  <asp:SqlDataSource ID="SqlDataSource_Refer" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                      InsertCommand="INSERT INTO Forward_To_Sub_Dept(Reg_No, yearly_no, to_sub_Dept, by_doctor, by_sub_dept_id, forward_date, status, request_type_id) VALUES (@Reg_No, @yearly_no, @to_sub_Dept, @by_doctor, @by_sub_dept_id, Getdate() , @status, @request_type_id)"
                      ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" UpdateCommand="UPDATE Forward_To_Sub_Dept SET status = @status WHERE (Reg_No = @Reg_No) AND (yearly_no = @yearly_no) AND (to_sub_Dept = @to_sub_Dept)">
                    <InsertParameters>
                      <asp:SessionParameter Name="Reg_No" SessionField="RegistrationNo" />
                      <asp:SessionParameter Name="yearly_no" SessionField="YearlyNo" />
                      <asp:ControlParameter ControlID="DropDownList_SubDepartment" Name="to_sub_Dept" PropertyName="SelectedValue" />
                      <asp:SessionParameter Name="by_doctor" SessionField="emp_id" />
                      <asp:SessionParameter Name="by_sub_dept_id" SessionField="SubDeptID" />
                      <asp:Parameter DefaultValue="false" Name="status" />
                      <asp:Parameter DefaultValue="1" Name="request_type_id" />
                    </InsertParameters>
                    <UpdateParameters>
                      <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" />
                      <asp:SessionParameter Name="yearly_no" SessionField="YearlyNo" />
                      <asp:SessionParameter Name="to_sub_Dept" SessionField="subdeptid" />
                      <asp:Parameter DefaultValue="1" Name="status" />
                    </UpdateParameters>
                  </asp:SqlDataSource>
                  <asp:HiddenField ID="HiddenField_Next_Visist_Date" runat="server" />
                  <asp:DataList ID="dtlPresentingComplaintsMain" runat="server" DataSourceID="dsPrestingComplaintsMain"
                      RepeatColumns="1" RepeatDirection="Horizontal" Width="100%">
                      <ItemTemplate>
                          <ul class="medication_cnt">
                              <li style="border-bottom: #cccccc dotted 1px; border-right: 0; border-left: 0;"><strong
                                  class="mname">
                                  <asp:Label ID="Label_Date" runat="server" Text='<%# Eval("Date") %>' Visible="False"></asp:Label>
                                  <asp:Label ID="Complaint_NameLabel" runat="server" Style="color: #C00;" Text='<%# Eval("heading") %>'></asp:Label></strong></li>
                              <li style="border: 0; height: auto;">
                                  <asp:Label ID="Label_Description" runat="server" Text='<%# Eval("Description") %>'></asp:Label></li>
                          </ul>
                          <ul class="medication_cnt" style="border-bottom: 0px; border-right: 0px; border-left: 0px;">
                              <li style="border-right: 0px; border-left: 0px;">
                                  <asp:DataList ID="DataList_Presenting_Complaint" runat="server" DataSourceID="SqlDS_Presenting_Complaint"
                                      OnPreRender="DataList_Presenting_Complaint_PreRender" RepeatDirection="Horizontal"
                                      RepeatLayout="Flow">
                                      <ItemTemplate>
                                          <strong>
                                              <asp:Label ID="Sub_TypeLabel" runat="server" Text='<%# Eval("Sub_Type") %>'></asp:Label>
                                              :</strong>
                                          <asp:Label ID="ComponentNameLabel" runat="server" Text='<%# Eval("ComponentName") %>'></asp:Label>
                                          <asp:Label ID="datetimeLabel" runat="server" Text='<%# Eval("datetime") %>' Visible="False"></asp:Label>
                                          <span class="span">|</span>
                                      </ItemTemplate>
                                  </asp:DataList>
                              </li>
                          </ul>
                          <asp:SqlDataSource ID="SqlDS_Presenting_Complaint" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                              ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                              SelectCommand="SELECT Admin_Complaint_Element.Sub_Type, pt_Save_Presenting_Complaints.ComponentName, pt_Save_Presenting_Complaints.datetime&#13;&#10;FROM         pt_Save_Presenting_Complaints INNER JOIN&#13;&#10;                      Admin_Complaint_Element ON pt_Save_Presenting_Complaints.Sub_Type_ID = Admin_Complaint_Element.Sub_Type_ID&#13;&#10;WHERE     (pt_Save_Presenting_Complaints.YearlyNo = @YearlyNo) and (pt_Save_Presenting_Complaints.RegNo = @RegNo) and (pt_Save_Presenting_Complaints.Complaint_ID = @Complaint_ID)">
                              <SelectParameters>
                                  <asp:ControlParameter ControlID="HF_PayID" Name="YearlyNo" PropertyName="Value" />
                                  <asp:ControlParameter ControlID="HF_RegNo" Name="RegNo" PropertyName="Value" />
                                  <asp:ControlParameter ControlID="HF_Presenting_Complaint_ID" Name="Complaint_ID"
                                      PropertyName="Value" />
                              </SelectParameters>
                          </asp:SqlDataSource>
                          <asp:HiddenField ID="HF_Presenting_Complaint_ID" runat="server" Value='<%# Eval("Complaint_ID") %>' />
                          <asp:HiddenField ID="HF_PayID" runat="server" Value='<%# Eval("YearlyNo") %>' />
                          <asp:HiddenField ID="HF_RegNo" runat="server" Value='<%# Eval("RegNo") %>' />
                      </ItemTemplate>
                  </asp:DataList><asp:SqlDataSource ID="dsPrestingComplaintsMain" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                      SelectCommand="SELECT CONVERT (varchar, Pt_Presenting_Complaint_saveRecord.Date, 103) AS Date, Admin_Complaint_MainGroup.Complaint_Name + ' ' + CONVERT (varchar, Pt_Presenting_Complaint_saveRecord.Duration) + ' ' + Pt_Presenting_Complaint_saveRecord.Duration_Time AS heading, Pt_Presenting_Complaint_saveRecord.Description, Pt_Presenting_Complaint_saveRecord.Complaint_ID, Pt_Presenting_Complaint_saveRecord.YearlyNo, Pt_Presenting_Complaint_saveRecord.RegNo FROM Pt_Presenting_Complaint_saveRecord INNER JOIN Admin_Complaint_MainGroup ON Pt_Presenting_Complaint_saveRecord.Complaint_ID = Admin_Complaint_MainGroup.Complaint_ID WHERE (Pt_Presenting_Complaint_saveRecord.YearlyNo = @YearlyNo) AND (Pt_Presenting_Complaint_saveRecord.RegNo = @RegNo) ORDER BY Date">
                      <SelectParameters>
                          <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                          <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                      </SelectParameters>
                  </asp:SqlDataSource>
</td>
      </tr>
            
                          <asp:HiddenField ID="HiddenFieldToolTIp" runat="server" Value="true" /><asp:HiddenField ID="HiddenField1" runat="server" Value="true" />
            </table>
    <asp:DataList ID="DataList_Confirm_Prescrip" runat="server" DataKeyField="priscription_id"
        DataSourceID="SqlDataSource_Confirmed_Prescriptions" Width="100%">
        <ItemTemplate>
            <ul class="medication_cnt">
                <li style="border-right: 0px; border-left: 0px; border-bottom: #cccccc 1px dotted"><strong
                    class="mname">
                    <%# Eval("[Medicine Name]") %>
                </strong><span>|</span> Dosage : <span class="darkc">
                    <%# Eval("Doze") %>
                </span><span>|</span>Frequency :
                    <asp:Label ID="Label_Frequency" runat="server" ForeColor="Red" Text="Label"></asp:Label><span
                        class="darkc"><%#Eval("Dosage")%></span><span>|</span>Start Date : <span class="darkc">
                            <%# Eval("[Start Date]") %>
                        </span><span>|</span>For Days :
                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("days") %>'></asp:Label><span
                        class="darkc"></span><span>|</span><%# Eval("CT") %>&nbsp;
                    <asp:LinkButton ID="LinkButton_Edit" runat="server" CausesValidation="False" CommandName="Select"
                        CssClass="editit" ToolTip="Edit Medicine"></asp:LinkButton>
                    <asp:LinkButton ID="LinkButton_Delete" runat="server" CausesValidation="False" CommandName="Delete"
                        CssClass="cancel_btn" ToolTip="Delete Medicine"></asp:LinkButton>
                    <asp:CheckBox ID="CheckBox_Confirm" runat="server" ToolTip="Confirm Medicine" />
                    <asp:HiddenField ID="HiddenField_PrescriptionID" runat="server" Value='<%# Eval("priscription_id") %>' />
                    <asp:HiddenField ID="HiddenField_CT" runat="server" Value='<%# Eval("CT") %>' />
                    <asp:HiddenField ID="HiddenField_EndDate" runat="server" Value='<%# Eval("[End Date]") %>' />
                    <asp:HiddenField ID="HiddenField_Start_Date" runat="server" Value='<%# Eval("[Start Date]") %>' />
                    <asp:HiddenField ID="HiddenField_Dosage" runat="server" Value='<%# Eval("Dosage") %>' />
                    <asp:HiddenField ID="HiddenField_Doze" runat="server" Value='<%# Eval("Doze") %>' />
                    <asp:HiddenField ID="HiddenField_MedicineName" runat="server" Value='<%# Eval("[Medicine Name]") %>' />
                </li>
            </ul>
        </ItemTemplate>
        <EditItemTemplate>
            <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                <tr><td style="height: 18px"><asp:Label id="Label_1" runat="server" CssClass="red"></asp:Label>
                        <asp:DropDownList ID="DropDownList_frequencyName" runat="server" AutoPostBack="True"
                            DataSourceID="SqlDataSource_frequency" DataTextField="Name" DataValueField="id"
                            Width="100px">
                        </asp:DropDownList>
                    </td>
                    <td style="height: 18px">
                        <asp:TextBox ID="TextBox_Frequency" runat="server" AutoPostBack="True" Width="16px">1</asp:TextBox>
                    </td>
                </tr>
            </table>
            <asp:ImageButton ID="ImageButton_Frequency_ShowHide" runat="server" ImageUrl="../images_hacims/add.png" OnClick="ImageButton_Frequency_ShowHide_Click" />
            <asp:DataList
                ID="DataList_Frequency" runat="server" DataKeyField="Frequency_Sub_Id" DataSourceID="SqlDataSource_FrequencyDataList"
                RepeatColumns="10" RepeatDirection="Horizontal" Visible="false">
                <ItemTemplate>
                    <div class="medbg">
                        <asp:Label ID="FrequencyLabel" runat="server" Style="display: block; font-family: arial;
                            font-size: 9px;" Text='<%# Eval("Frequency") %>'></asp:Label>
                        <asp:TextBox ID="TextBox_dosage2" runat="server" Style="height: 12px; display: inline;"
                            Width="30px">1</asp:TextBox>
                        <asp:HiddenField ID="HF_F_S_Id" runat="server" Value='<%# Eval("Frequency_Sub_Id") %>' />
                    </div>
                </ItemTemplate>
            </asp:DataList>
            <asp:TextBox ID="TextBoxInstruction" runat="server" CssClass="input_txt" Width="99%"></asp:TextBox>
            Days :<asp:TextBox ID="TextBox_days" runat="server" AutoPostBack="True" CssClass="input_txt"
                Width="15px">1</asp:TextBox>
            <asp:DropDownList ID="DropDownList_route" runat="server" DataSourceID="SqlDataSource_route"
                DataTextField="Description" DataValueField="Id" Width="77px">
            </asp:DropDownList>
            <asp:DropDownList ID="DropDownList_dosage" runat="server" DataSourceID="SqlDataSource_dosage"
                DataTextField="Name" DataValueField="Name" Visible="False" Width="75px">
            </asp:DropDownList>
            <asp:TextBox ID="TextBox_dilution" runat="server" CssClass="input_txt" Visible="False"
                Width="25px"></asp:TextBox>
            <asp:HiddenField ID="HiddenField_MedCode" runat="server" />
            <asp:DropDownList ID="DropDownList_dilution" runat="server" DataSourceID="SqlDataSource_dilution"
                DataTextField="name" DataValueField="name" Visible="False" Width="65px">
            </asp:DropDownList>
            <asp:DropDownList ID="DropDownList_Medicine_Advice_Category" runat="server" DataSourceID="SqlDataSource_Medicine_Advice_Category"
                DataTextField="Medicine_Advice_Category_Name" DataValueField="Medicine_Advice_Category_ID"
                Visible="false">
            </asp:DropDownList>
            <igsch:WebDateChooser ID="WebDateChooserStartDate" runat="server" CssClass="drop_date"
                Value="2008-01-16" Width="100px">
                <CalendarLayout Culture="English (United Kingdom)">
                </CalendarLayout>
            </igsch:WebDateChooser>
            <igsch:WebDateChooser ID="WebDateChooserEndDate" runat="server" CssClass="drop_date"
                Value="2010-06-17" Visible="false" Width="100px">
                <AutoPostBack ValueChanged="True" />
                <CalendarLayout Culture="English (United Kingdom)">
                </CalendarLayout>
            </igsch:WebDateChooser>
            <asp:SqlDataSource ID="SqlDataSource_freq" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT     id, Name + ' (' + Occasion + ')' AS Name, CASE WHEN dbo.ufn_CountChar(Occasion, '+') > 0 THEN dbo.ufn_CountChar(Occasion, '+') ELSE 1000 END AS count&#13;&#10;FROM         Medicine_Frequency&#13;&#10;WHERE     (IS_Available = 1)">
            </asp:SqlDataSource>
        </EditItemTemplate>
    </asp:DataList>
    <asp:HiddenField ID="HiddenField_priscription_id" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Confirmed_Prescriptions" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
        DeleteCommand="DELETE FROM Pt_Prescription_Detail WHERE (priscription_id = @priscription_id)"
        SelectCommand="OPD_Encounter_Medication_prev" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="RegNo" SessionField="registrationno" Type="String" />
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
        </SelectParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="HiddenField_Prescription_Id" Name="priscription_id"
                PropertyName="Value" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Examination" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>"
        SelectCommand="SELECT Admin_Exam_Main_Heading.MH_Heading, OPD_Encounter_Form_Remarks.Remarks, Admin_Exam_Main_Heading.MH_Code FROM Admin_Exam_Main_Heading INNER JOIN OPD_Encounter_Form_Remarks ON Admin_Exam_Main_Heading.MH_Code = OPD_Encounter_Form_Remarks.MH_Code WHERE (OPD_Encounter_Form_Remarks.Yearly_No = @YearlyNo) AND (OPD_Encounter_Form_Remarks.Reg_No = @RegNo)">
        <SelectParameters>
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
            <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
        DataSourceID="SqlDataSourceDiagnosis" Style="display: none" Width="100%">
        <RowStyle CssClass="GridItem" />
        <Columns>
            <asp:BoundField DataField="ICD Name" HeaderText="Disease Name" SortExpression="ICD Name" />
            <asp:BoundField DataField="ICD Code" HeaderText="ICD10 Code" SortExpression="ICD Code" />
            <asp:BoundField DataField="Past" HeaderText="Past" SortExpression="Past" />
            <asp:BoundField DataField="Provisional" HeaderText="Provisional" SortExpression="Provisional" />
            <asp:BoundField DataField="Final" HeaderText="Final" SortExpression="Final" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:CheckBox ID="CheckBox4" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSourceDiagnosis" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
        SelectCommand="Pro_Select_pt_treatment" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
            <asp:SessionParameter Name="emp_id" SessionField="emp_id" Type="Decimal" />
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
        DataKeyNames="Diagnosis_ID" DataSourceID="SqlDataSourceDiagnosis" Width="961px">
        <Columns>
            <asp:BoundField DataField="ICD Name" HeaderText="Disease Name" SortExpression="ICD Name" />
            <asp:BoundField DataField="ICD Code" HeaderText="ICD Code" ReadOnly="True" SortExpression="ICD Code" />
            <asp:CheckBoxField DataField="Past" HeaderText="Past" SortExpression="Past" />
            <asp:CheckBoxField DataField="Provisional" HeaderText="Provisional" SortExpression="Provisional" />
            <asp:CheckBoxField DataField="Final" HeaderText="Final" SortExpression="Final" />
            <asp:BoundField DataField="Provisional_Val" HeaderText="Value" SortExpression="Provisional_Val" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:CheckBox ID="CheckBox5" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</div><br />
    <asp:DataList ID="DataList_Examination" runat="server" DataSourceID="SqlDataSource_Examination"
        Width="100%">
        <ItemTemplate>
            <ul class="medication_cnt">
                <li style="border-right: 0px; border-left: 0px; border-bottom: #cccccc 1px dotted"><strong
                    class="mname">
                    <asp:Label ID="MH_HeadingLabel" runat="server" Text='<%# Eval("MH_Heading") %>'> </asp:Label>
                     <asp:CheckBox ID="CheckBox1" runat="server" AutoPostBack="True" /></strong></li>
                <li style="border-right: 0px; border-top: 0px; padding-bottom: 4px; border-left: 0px;
                    padding-top: 4px; border-bottom: 0px; height: auto">
                    <asp:Label ID="RemarksLabel" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                    <asp:Label ID="Label_MHeadingCode" runat="server" Text='<%# Eval("MH_Code") %>'></asp:Label></li>
                     <br />
            </ul>
            <asp:DataList ID="DataList_ExaminationGroups" runat="server" DataKeyField="MG_Code"
                DataSourceID="SqlDataSource_ExaminationGroup">
                <ItemTemplate>
                    <asp:Label ID="MG_CodeLabel" runat="server" Text='<%# Eval("MG_Code") %>'></asp:Label><br />
                    <asp:Label ID="MG_NameLabel" runat="server" Text='<%# Eval("MG_Name") %>'></asp:Label>
                   
                    <br />
                </ItemTemplate>
            </asp:DataList>
            &nbsp;
            <asp:SqlDataSource ID="SqlDataSource_ExaminationDetail" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                SelectCommand="Select_PT_Exam_Groupwise" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="Label_MHeadingCode" Name="MH_Code" PropertyName="Text" />
                    <asp:SessionParameter Name="Reg_No" SessionField="RegistrationNo" Type="String" />
                    <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <ul class="medication_cnt" style="border-right: 0px; border-left: 0px; border-bottom: 0px">
                <li style="border-right: 0px; border-left: 0px">
                    <asp:DataList ID="DataList_ExaminationDetail" runat="server" DataSourceID="SqlDataSource_ExaminationDetail"
                        RepeatDirection="Horizontal" RepeatLayout="Flow" Width="100%">
                        <ItemTemplate>
                            <strong>
                                <asp:Label ID="e_NameLabel" runat="server" Text='<%# Eval("e_Name") %>'></asp:Label></strong>
                            :
                            <asp:Label ID="Exam_ResultLabel" runat="server" Text='<%# Eval("Exam_Result") %>'></asp:Label>
                            <span class="span">|</span>
                        </ItemTemplate>
                    </asp:DataList>
                </li>
            </ul>
            <asp:SqlDataSource ID="SqlDataSource_ExaminationGroup" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                SelectCommand="SELECT DISTINCT admin_Phy_Exam_MainGroup.MG_Code, admin_Phy_Exam_MainGroup.MG_Name FROM Admin_History_MainHeading_Group INNER JOIN admin_Phy_Exam_MainGroup ON Admin_History_MainHeading_Group.MH_Code = admin_Phy_Exam_MainGroup.MG_Code INNER JOIN admin_Phy_Exam_Elements ON admin_Phy_Exam_MainGroup.MG_Code = admin_Phy_Exam_Elements.MG_Code INNER JOIN Pt_physical_exam_saveRecord ON admin_Phy_Exam_Elements.e_Code = Pt_physical_exam_saveRecord.E_ID &#13;&#10;WHERE (Pt_physical_exam_saveRecord.RegNo = @RegNo) AND (Pt_physical_exam_saveRecord.YearlyNo = @YearlyNo) &#13;&#10;AND (Admin_History_MainHeading_Group.MH_Code = @MH_Code)">
                <SelectParameters>
                    <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                    <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                    <asp:ControlParameter ControlID="Label_MHeadingCode" Name="MH_Code" PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>
        </ItemTemplate>
    </asp:DataList>&nbsp;<asp:Button ID="Button1" runat="server" Text="Button" />
        <asp:TextBox ID="TextBox_Exam" runat="server" Height="100px" TextMode="MultiLine"
            Width="947px"></asp:TextBox><br />
        <asp:DataList ID="DataList_His" runat="server" DataSourceID="SqlDataSource_Hist_MG"
            Width="100%">
            <ItemTemplate>
                <br />
                <ul class="medication_cnt">
                    <li style="border-right: 0px; border-left: 0px; border-bottom: #cccccc 1px dotted"><strong
                        class="mname" style="margin-top: 0px">
                        <asp:Label ID="MG_NameLabel" runat="server" Text='<%# Eval("MH_Heading") %>'></asp:Label>
                        <asp:CheckBox ID="CheckBox2" runat="server" /></strong></li>
                    <li style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px;
                        height: auto">
                        <asp:Label ID="RemarksLabel" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label></li>
                </ul>
                <ul class="medication_cnt" style="border-right: 0px; border-left: 0px; border-bottom: 0px">
                    <li style="border-right: 0px; border-left: 0px">
                        <asp:DataList ID="DataList_His_Sub" runat="server" DataKeyField="ID" DataSourceID="SqlDS_His_Sub"
                            RepeatDirection="Horizontal" RepeatLayout="Flow" Width="100%">
                            <ItemTemplate>
                                <asp:Label ID="MH_HeadingLabel" runat="server" Text='<%# Eval("MH_Heading") %>' Visible="False"></asp:Label>
                                <strong>
                                    <asp:Label ID="MG_NameLabel" runat="server" Text='<%# Eval("MG_Name") %>'></asp:Label>
                                </strong>
                                <asp:Label ID="e_NameLabel" runat="server" Style="color: #666666;" Text='<%# Eval("e_Name") %>'></asp:Label>
                                <asp:Label ID="ev_CodeLabel" runat="server" Style="color: #006699;" Text='<%# Eval("Exam_Result") %>'></asp:Label>
                                <asp:Label ID="DateTmeLabel" runat="server" Text='<%# Eval("DateTme") %>' Visible="False"></asp:Label>
                                <span class="span">|</span>
                            </ItemTemplate>
                        </asp:DataList>
                    </li>
                </ul>
                <asp:SqlDataSource ID="SqlDS_His_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>"
                    SelectCommand="Select_Pt_HIS_Group_Wise" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="HF_RegNo" Name="Reg_No" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HF_YearlyNo" Name="Yearly_No" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HF_MH_Code" Name="MH_Code" PropertyName="Value" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HF_RegNo" runat="server" Value='<%# Eval("Reg_No") %>' />
                <asp:HiddenField ID="HF_YearlyNo" runat="server" Value='<%# Eval("Yearly_No") %>' />
                <asp:HiddenField ID="HF_MH_Code" runat="server" Value='<%# Eval("MH_Code") %>' />
            </ItemTemplate>
        </asp:DataList><asp:SqlDataSource ID="SqlDataSource_Hist_MG" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
            ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
            SelectCommand="SELECT &#13;&#10;                      'History' AS [Main Group], OPD_Encounter_Form_Remarks.Remarks, OPD_Encounter_Form_Remarks.MH_Code, Admin_History_Main_Heading.MH_Heading, &#13;&#10;                      OPD_Encounter_Form_Remarks.Reg_No, OPD_Encounter_Form_Remarks.Yearly_No&#13;&#10;FROM         OPD_Encounter_Form_Remarks INNER JOIN&#13;&#10;                      Admin_History_Main_Heading ON OPD_Encounter_Form_Remarks.MH_Code = Admin_History_Main_Heading.MH_Code&#13;&#10;WHERE     (OPD_Encounter_Form_Remarks.Yearly_No = @YearlyNo) AND (OPD_Encounter_Form_Remarks.Reg_No = @RegNo)&#13;&#10;order by Admin_History_Main_Heading.priority asc">
            <SelectParameters>
                <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Button ID="Button_His" runat="server" Text="Button" />
        &nbsp;&nbsp;
        <asp:TextBox ID="TextBox_His" runat="server" Height="116px" TextMode="MultiLine"
            Width="949px"></asp:TextBox><br />
        <br />
        <asp:SqlDataSource ID="SqlDataSourceTest" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
            ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
            SelectCommand="Select_Pt_Path_test_Recomm" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:SessionParameter Name="Reg_No" SessionField="RegistrationNo" Type="String" />
                <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <h1 class="h1" style="background-image: none; margin-left: 15px; width: 90%; box-shadow: none">
            <span style="padding-left: 0px; background-image: none">Lab Investigations</span></h1>
        <asp:DataList ID="DataList_Test" runat="server" DataSourceID="SqlDataSourceTest"
            Style="margin-left: 15px" Width="90%">
            <ItemTemplate>
                <ul class="medication_cnt">
                    <li style="border-right: 0px; border-left: 0px; border-bottom: #cccccc 1px dotted"><strong
                        class="mname">
                        <asp:Label ID="Label_TestDate" runat="server" Text='<%# Eval("TestAssignDate") %>'></asp:Label>
                        <asp:CheckBox ID="CheckBox3" runat="server" /></strong>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("TGName") %>'></asp:Label>
                        <asp:Label ID="Label3" runat="server" Text='<%# Eval("TB_Name") %>'></asp:Label></li>
                    <asp:DataList ID="DataList_Test_Sub" runat="server" DataSourceID="SqlDataSource_Test_Sub">
                        <ItemTemplate>
                            <li style="padding-bottom: 4px; height: auto"><strong>
                                <asp:Label ID="TGNameLabel" runat="server" Text='<%# Eval("TestName") %>'></asp:Label></strong>
                                :
                                <asp:Label ID="TB_NameLabel" runat="server" Text='<%# Eval("TCValue") %>'></asp:Label>
                            </li>
                        </ItemTemplate>
                    </asp:DataList>
                </ul>
                <asp:SqlDataSource ID="SqlDataSource_Test_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:Pathology2ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Pathology2ConnectionString.ProviderName %>"
                    SelectCommand="SELECT     Test.TestName, TestComponent.ComponentName, path_PatientTestResult.TCValue, TestSubGroup.TSGID, CONVERT(varchar, path_PatientTestResult.Date_Time, 107) &#13;&#10;                      AS Date_Time, TestComponent.TC_Range_Unit, TestComponent.TCID, Path_PatientTestResult_Main.RegNo, Path_PatientTestResult_Main.YearlyNo, &#13;&#10;                      Path_PatientTestResult_Main.Main_ID, TestSubGroup.TGID, Path_PatientTestResult_Main.Refrence_No&#13;&#10;FROM         Path_PatientTestResult_Main INNER JOIN&#13;&#10;                      path_PatientTestResult ON Path_PatientTestResult_Main.trmId = path_PatientTestResult.trmID INNER JOIN&#13;&#10;                      Test ON path_PatientTestResult.TId = Test.TID INNER JOIN&#13;&#10;                      TestSubGroup ON Test.TSGID = TestSubGroup.TSGID INNER JOIN&#13;&#10;                      TestComponent ON Test.TID = TestComponent.TID AND path_PatientTestResult.TCId = TestComponent.TCID&#13;&#10;WHERE       (Path_PatientTestResult_Main.Main_ID = @Main_ID)&#13;&#10;">
                    <SelectParameters>
                        <asp:Parameter Name="Main_ID" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenField_MainID" runat="server" Value='<%# Eval("Main_ID") %>' />
            </ItemTemplate>
        </asp:DataList><br />
        <h1 class="h1" style="background-image: none; margin-left: 15px; width: 90%; box-shadow: none">
            <span style="padding-left: 0px; background-image: none">Diagnostic Investigations</span></h1>
        <asp:DataList ID="DataList_Radiology" runat="server" DataSourceID="SqlDataSourceRadiology"
            Style="margin-left: 15px" Width="90%">
            <ItemTemplate>
                <ul class="medication_cnt">
                    <li style="border-right: 0px; border-left: 0px; border-bottom: #cccccc 1px dotted"><strong
                        class="mname">
                        <asp:Label ID="Label_Date" runat="server" Text='<%# Eval("DateTime") %>'></asp:Label></strong></li>
                    <asp:DataList ID="DataList_Radiology_Sub" runat="server" DataSourceID="SqlDataSource_Radiology_Sub">
                        <ItemTemplate>
                            <li style="border: 0; height: auto;"><strong>
                                <asp:Label ID="RIDLabel" runat="server" Text='<%# Eval("TGName") %>'></asp:Label></strong>
                                :
                                <asp:Label ID="RadiologyNameLabel" runat="server" Text='<%# Eval("tbname") %>'></asp:Label></li>
                        </ItemTemplate>
                    </asp:DataList>
                </ul>
                <asp:SqlDataSource ID="SqlDataSource_Radiology_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                    SelectCommand="SELECT DISTINCT Radiology.dbo.TestGroup.TGName, dbo.Radiology_TB_Name_1(Radiology_Order_Main.YearlyNo, Radiology_Order_Main.RegNo, &#13;&#10;                      Radiology.dbo.TestGroup.TGID) AS tbname&#13;&#10;FROM         Radiology_Order_Sub INNER JOIN&#13;&#10;                      Radiology_Order_Main ON Radiology_Order_Sub.Order_ID = Radiology_Order_Main.Order_ID INNER JOIN&#13;&#10;                      Radiology.dbo.Test_Booking ON Radiology_Order_Sub.TB_ID = Radiology.dbo.Test_Booking.TB_ID INNER JOIN&#13;&#10;                      Radiology.dbo.TestGroup ON Radiology.dbo.Test_Booking.MG_ID = Radiology.dbo.TestGroup.TGID&#13;&#10;WHERE  (Radiology_Order_Main.YearlyNo = @YearlyNo) AND (Radiology_Order_Main.RegNo =@RegNo) AND (CONVERT(varchar, Radiology_Order_Main.Date_Time, 103) &#13;&#10;                      = @Date)">
                    <SelectParameters>
                        <asp:Parameter Name="YearlyNo" />
                        <asp:Parameter Name="RegNo" />
                        <asp:Parameter Name="Date" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </ItemTemplate>
        </asp:DataList>
        <asp:SqlDataSource ID="SqlDataSourceRadiology" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
            SelectCommand="SELECT DISTINCT CONVERT(varchar, Date_Time, 103) AS DateTime&#13;&#10;FROM         Radiology_Order_Main&#13;&#10;WHERE     (YearlyNo = @PayID) and (RegNo = @RegNo)&#13;&#10;">
            <SelectParameters>
                <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" Type="String" />
                <asp:SessionParameter Name="PayID" SessionField="YearlyNo" Type="Decimal" />
            </SelectParameters>
        </asp:SqlDataSource>
 

 
    <asp:Label ID="LabelFooter" runat="server" Visible="false" Text=""></asp:Label>
    
           </div><!--pageContent-->
  </div><!--main_bx-->
  
    
  </asp:Content>