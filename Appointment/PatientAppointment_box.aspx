<%@ page language="VB" debug="true" autoeventwireup="false" inherits="PatientAppointmant_box, App_Web_cp5nrlwn" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="../css_hacims/class_reset.css" rel="stylesheet" type="text/css" media="screen, projection" />
    <link href="../css_hacims/class_forms.css" rel="stylesheet" type="text/css" media="screen, projection" />
    <!--[if IE]><link rel="stylesheet" href="../css_hacims/class_ie_form.css" type="text/css" media="screen, projection"/><![endif]-->

    <script type="text/javascript" src="SpryAssets/SpryCollapsiblePanel.js"></script>

    <script type="text/javascript" language="javascript">

function showAgedob(val)
{

 var age =document.getElementById('<%=textboxage.ClientID%>').value;
var date;
date=igedit_getById('<%=WebDateTimeEdit_DOB.ClientID%>').getText();
 if (date != "")
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
var val =igedit_getById('<%=WebDateTimeEdit_DOB.ClientID%>').getText();
var date = new Date(val);

if (age=="")
{
 if (date != "" && date != "Invalid Date")
{
var date1 = new Date();

var ageval =document.getElementById('<%=textboxage.ClientID%>');

ageval.value =  Math.floor((date1  - date)/((24*60*60*1000)*30*12));
}
}

else if (date != "") 
{
    if (date != "Invalid Date")
    {

        var date1 = new Date();
        var ageval =document.getElementById('<%=textboxage.ClientID%>');
        ageval.value =  Math.floor((date1  - date)/((24*60*60*1000)*30*12));
    }
}

  }


 function reloadParent() 
 {
    var thisHREF=document.location.href;
    var parentHREF=parent.location.href;
     var reloadFlag=parentHREF.split('?');      
     
     if(reloadFlag[1]== null) {
        parent.location.href=(parentHREF + '?' + thisHREF);
     }
     else if(reloadFlag[1]!=thisHREF) {
      parent.location.href=(reloadFlag[0] + '?' + thisHREF);
     }
  }



    </script>

    <script src="<%= Page.ResolveClientUrl("~/css_hacims/jquery.min.js") %>" type="text/javascript"
        language="javascript"></script>

    <script src="../css_hacims/clearbtn.js" type="text/javascript"></script>

    <style type="text/css">
        .auto-style1 {
            height: 18px;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div id="formds_items">
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <br />
            <div class="bx_rad">
                <ul id="CollapsiblePanel1">
                    <li><strong>&nbsp;Click here for Patient Search</strong></li>
                    <li>
                        <asp:Panel ID="Panel2" runat="server" Width="100%">
                        </asp:Panel>
                        <div align="center">
                            <asp:Button ID="Button1" runat="server" CausesValidation="False" CssClass="btn1"
                                Text="Search" />
                            <input class="btn_hacims" name="Clear" value="Clear" type="button" id="Button_clr" /></div>
                    </li>
                </ul>
            </div>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                
                <tr>                    
                    <td colspan="2">
                        <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="40%" align="right" style="height: 18px">
                        Patient Prefix :
                    </td>
                    <td style="height: 18px">
                        <asp:RadioButtonList ID="RadioButtonListPrefix" runat="server" RepeatDirection="Horizontal"
                            RepeatLayout="Flow" TabIndex="1">
                            <asp:ListItem Selected="True">Mr.</asp:ListItem>
                            <asp:ListItem>Mrs.</asp:ListItem>
                            <asp:ListItem>Miss</asp:ListItem>
                            <asp:ListItem>B/O</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Patient First Name :
                    </td>
                    <td>
                        <asp:TextBox ID="TextBoxPFName" runat="server" CssClass="input_txt" Style="background-color: #f9dde2"
                            TabIndex="1"></asp:TextBox>
                        <span style="font-size: 10pt; color: #d92542">* </span>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBoxPFName"
                            ErrorMessage="*"></asp:RequiredFieldValidator>
                        <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator_PFName" runat="server"
                            ControlToValidate="TextBoxPFName" ErrorMessage="Enter the Patient First Name in Correct Format"
                            ValidationExpression="([a-zA-Z])*"></asp:RegularExpressionValidator>--%>

                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Middle Name :
                    </td>
                    <td>
                        <asp:TextBox ID="TextBoxPMName" runat="server" CssClass="input_txt" TabIndex="2"></asp:TextBox>
                        <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator_PMNAme" runat="server"
                            ControlToValidate="TextBoxPMName" ErrorMessage="Enter the Patient Middle Name in Correct Format"
                            ValidationExpression="([a-zA-Z])*"></asp:RegularExpressionValidator>--%>

                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Last Name :
                    </td>
                    <td>
                        <asp:TextBox ID="TextBoxPLName" runat="server" CssClass="input_txt" TabIndex="3"></asp:TextBox>
                        <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator_PLName" runat="server"
                            ControlToValidate="TextBoxPLName" ErrorMessage="Enter the Patient Last Name in Correct Format"
                            ValidationExpression="([a-zA-Z])*"></asp:RegularExpressionValidator>--%>

                    </td>
                </tr>
                <tr>
                    <td align="right">
                        E-mail Address :
                    </td>
                    <td>
                        <asp:TextBox ID="TextBox_Emailaddress" runat="server" CssClass="input_txt" TabIndex="4"></asp:TextBox>
                        <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator_Email" runat="server"
                            ControlToValidate="TextBox_Emailaddress" ErrorMessage="Enter Email Address in Correct Format"
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>--%>

                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Cell No. :
                    </td>
                    <td>
                        <asp:TextBox ID="TextBoxCell1" runat="server" CssClass="input_txt" TabIndex="5" Width="35px"
                            MaxLength="4"></asp:TextBox>
                        -
                        <asp:TextBox ID="TextBoxCell2" runat="server" CssClass="input_txt" TabIndex="6" Width="152px"
                            MaxLength="7"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Res Phone No. :
                    </td>
                    <td>
                        <asp:TextBox ID="TextBox_Phone_1" runat="server" CssClass="input_txt" MaxLength="4"
                            TabIndex="7" Width="35px" Wrap="False"></asp:TextBox>
                        -
                        <asp:TextBox ID="TextBox_Phone_2" runat="server" CssClass="input_txt" MaxLength="2"
                            TabIndex="8" Width="35px"></asp:TextBox>
                        -
                        <asp:TextBox ID="TextBox_Phone_3" runat="server" CssClass="input_txt" MaxLength="7"
                            TabIndex="9" Width="105px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td align="right">
                        City :
                    </td>
                    <td>
                        <asp:DropDownList DataTextField="DistrictName" DataValueField="DistrictCode" ID="DropDownList_City"
                            runat="server" DataSourceID="SqlDataSource_City" TabIndex="10" Width="132px"
                            Style="height: 15x;">
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td align="right">
                        Appointment For Doctor :
                    </td>
                    <td>
                        <asp:DropDownList DataTextField="Name" DataValueField="EmpID" ID="DropDownListDoctor_id"
                            runat="server" DataSourceID="SqlDataSourceDoctor" TabIndex="11" Width="202px"
                            Style="height: 15x;" AutoPostBack="True">
                        </asp:DropDownList>
                        <asp:DropDownList DataTextField="S_Name" DataValueField="S_ID" ID="DropDownList_Services"
                            runat="server" DataSourceID="SqlDataSource_Doctor_Services" TabIndex="12" Width="100px"
                            Style="height: 15x; display :none" AutoPostBack="True">
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td align="right">
                        Appointment Date :
                    </td>
                    <td>
                        <igsch:WebDateChooser ID="WebDateChooser_AppointmentDate" runat="server" TabIndex="13"
                            CssClass="drop_date" Width="132px">
                            <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                            <AutoPostBack ValueChanged="True" />
                        </igsch:WebDateChooser>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Appointment Time :
                    </td>
                    <td>
                        <asp:DropDownList ID="DropDownList_TimeSlot" runat="server" Width="132px" DataTextField="Slot_Time"
                            DataValueField="Doctor_App_Slot_Id" TabIndex="14">
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td align="right">
                      Appointment Nature :
                    </td>
                    <td>
                        <asp:DropDownList ID="DropDownList_Purpose" runat="server" Width="133px" TabIndex="15">
                            <asp:ListItem Selected ="True">Initial Visit</asp:ListItem>
                            <asp:ListItem>Follow Up</asp:ListItem>
                            <asp:ListItem>Report Checking</asp:ListItem>
                            
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td align="right" class="auto-style1">
                         Appointment Type :
                    </td>
                    <td class="auto-style1">
                        <asp:DropDownList ID="DropDownList_VisitType" runat="server" Width="133px" TabIndex="15">
                            <asp:ListItem  Selected ="True">Normal</asp:ListItem>
                            <asp:ListItem>Add On</asp:ListItem>
                            <asp:ListItem>Waiting</asp:ListItem>
                            
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td align="right">
                         Appointment Source:
                    </td>
                    <td>
                        <asp:DropDownList ID="DropDownList_VisitSource" runat="server" Width="133px" TabIndex="15">
                            <asp:ListItem  Selected ="True">Phone</asp:ListItem>
                            <asp:ListItem>Walkin</asp:ListItem>
                            <asp:ListItem>Internet</asp:ListItem>
                            </asp:DropDownList>

                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Complaint :
                    </td>
                    <td>
                        <asp:TextBox ID="TextBoxComplaint" runat="server" CssClass="input_txt" TabIndex="16"></asp:TextBox></td>
                </tr>
                
                <tr>
                    <td align="right">
                        DOB :</td>
                    <td>
                        <igtxt:WebDateTimeEdit ID="WebDateTimeEdit_DOB" runat="server" CssClass="input_txt"
                            Culture="English (United Kingdom)" Style="background-color: #f9dde2" TabIndex="17"
                            Width="82px">
                        </igtxt:WebDateTimeEdit>
                        <span style="font-size: 10pt; color: #d92542">*
                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2"
                            runat="server" ControlToValidate="WebDateTimeEdit_DOB" ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                            <asp:TextBox
                                ID="textboxage" runat="server" AccessKey="a" CssClass="input_txt" TabIndex="18"
                                Width="29px"></asp:TextBox>&nbsp;<asp:DropDownList ID="DropDownListBIndicator" runat="server"
                                    AccessKey="y" TabIndex="19" Width="70px">
                                    <asp:ListItem Selected="True">Years</asp:ListItem>
                                    <asp:ListItem>Months</asp:ListItem>
                                    <asp:ListItem>Days</asp:ListItem>
                                    <asp:ListItem>Hours</asp:ListItem>
                                </asp:DropDownList>

                        </span>
                        <asp:HiddenField ID="HiddenField_DOB" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Referenced By :
                    </td>
                    <td>
                        <asp:TextBox ID="TextBox_Reference" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                        <td>
                            Remarks :
                        </td>
                         <td>
                             <asp:TextBox ID="TextBox_Remarks" runat="server" TextMode="MultiLine" Height ="50px" ></asp:TextBox>
                        </td>
                </tr>
                <tr>
                    <td align="right">
                    </td>
                    <td>
                        <asp:Button ID="ButtonSave" runat="server" CssClass="btn1" Text="Save"  />
                        <%--OnClientClick="reloadParent();"--%>

                    </td>
                </tr>
            </table>
            <br />
            <asp:GridView ID="GridViewSearch" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
                DataKeyNames="Registration No" AllowPaging="true" PageSize="10" Width="100%">
                <RowStyle CssClass="GridItem" />
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                                Text="Select"></asp:LinkButton>
                            <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("Prefix") %>' />
                            <asp:HiddenField ID="HiddenField2" runat="server" Value='<%# Eval("PFName") %>' />
                            <asp:HiddenField ID="HiddenField3" runat="server" Value='<%# Eval("PMName") %>' />
                            <asp:HiddenField ID="HiddenField4" runat="server" Value='<%# Eval("PLName") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <PagerStyle CssClass="GridPager" />
                <HeaderStyle CssClass="GridHeader" />
                <AlternatingRowStyle CssClass="GridAltItem" />
            </asp:GridView>
            <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                DataSourceID="SqlDataSourcePatient" EmptyDataText="No data" Width="100%">
                <RowStyle CssClass="GridItem" />
                <Columns>
                    <asp:BoundField DataField="Patient" HeaderText="Patient" SortExpression="Patient" />
                    <asp:BoundField DataField="AP_Date" HeaderText="Appointment Date" SortExpression="AP_Date" />
                    <asp:BoundField DataField="Appointment_Time" HeaderText="Appointment Time" SortExpression="Appointment_Time" />
                    <asp:BoundField DataField="Complaint" HeaderText="Complaint" SortExpression="Complaint" />
                    <asp:BoundField DataField="CellNo" HeaderText="CellNo" SortExpression="CellNo" />
                    <asp:BoundField DataField="pt_Phone" HeaderText="Phone No" SortExpression="pt_Phone" />
                    <asp:BoundField DataField="Doctor" HeaderText="Doctor" SortExpression="Doctor" />
                </Columns>
                <HeaderStyle CssClass="GridHeader" />
                <AlternatingRowStyle CssClass="GridAltItem" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSourcePatient" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" SelectCommand="SELECT Patient, AP_Date, Appointment_Time, Complaint, CellNo, Email_Address, Doctor, Pt_Name, pt_Phone FROM (SELECT ISNULL(Patient_Appointment.Prefix, '') + ' ' + ISNULL(Patient_Appointment.PFName, '') + ' ' + ISNULL(Patient_Appointment.PMName, '') + ' ' + ISNULL(Patient_Appointment.PLName, '') AS Patient, CONVERT (varchar, Patient_Appointment.Appointmant_DateTime, 103) AS AP_Date, Patient_Appointment.Appointment_Time, Patient_Appointment.Complaint, Patient_Appointment.CellNo, Patient_Appointment.Email_Address, ISNULL(Employee.Prefix, '') + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS Doctor, ISNULL(Patient_Appointment.PFName, '') + ' ' + ISNULL(Patient_Appointment.PMName, '') + ' ' + ISNULL(Patient_Appointment.PLName, '') AS Pt_Name, ISNULL(Patient_Appointment.Complaint, '') AS pt_Complaint, ISNULL(Patient_Appointment.CellNo, '') AS pt_Cell, ISNULL(Patient_Appointment.PhoneNo, '') AS pt_Phone FROM Patient_Appointment INNER JOIN Employee ON Patient_Appointment.For_Doctor = Employee.EmpID where (Patient_Appointment.Status = 1)  and Patient_Appointment.Reg_no=@Reg_no and Patient_Appointment.Appointmant_DateTime > getdate()) AS Patient_View">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HiddenField_Reg_no" Name="Reg_no" PropertyName="Value" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <asp:SqlDataSource ID="SqlDataSource_TimeSlot" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" SelectCommand="SELECT Admin_Doctor_Time_Slice.For_Day, Doctor_Appointment_Slot.App_No, LEFT (CONVERT (varchar, Doctor_Appointment_Slot.Slot_Time, 108), 5) AS Slot_Time, Doctor_Appointment_Slot.Doctor_App_Slot_Id, Week_Day.Day_Name, Admin_Doctor_Time_Slice.Doctor_ID FROM Admin_Doctor_Time_Slice INNER JOIN Doctor_Appointment_Slot ON Admin_Doctor_Time_Slice.Admin_Doctor_Time_ID = Doctor_Appointment_Slot.Admin_Doctor_Time_ID INNER JOIN Week_Day ON Admin_Doctor_Time_Slice.For_Day = Week_Day.Day_ID WHERE (Week_Day.Day_Name = @Day_Name) AND (Admin_Doctor_Time_Slice.Doctor_ID = @For_Doctor) AND (Doctor_Appointment_Slot.Doctor_App_Slot_Id NOT IN (SELECT DISTINCT Doctor_App_Slot_Id FROM Patient_Appointment WHERE (For_Doctor = @For_Doctor) AND (convert(varchar,Appointmant_DateTime,103) = Convert(varchar,@Appointmant_DateTime,103))))">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HiddenField_DayofWeek" Name="Day_Name" PropertyName="Value" />
                    <asp:ControlParameter ControlID="DropDownListDoctor_id" Name="For_Doctor" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="HiddenFieldAppointmentDateTime" Name="Appointmant_DateTime"
                        PropertyName="Value" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource_City" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" SelectCommand="SELECT DistrictName, DistrictCode FROM District">
            </asp:SqlDataSource>
            <asp:HiddenField ID="HiddenField_DayofWeek" runat="server" />
            <%--WHERE (Emp_Type = 'Consultant') --%>
            <asp:SqlDataSource ID="SqlDataSourceDoctor" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                SelectCommand="SELECT ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS Name, EmpID FROM Employee ORDER BY ISNULL(EFName, '')">
            </asp:SqlDataSource>
            <asp:HiddenField ID="HiddenField_AppTime" runat="server" />
            <asp:HiddenField ID="HiddenFieldAppointmentDateTime" runat="server" />
            <asp:SqlDataSource ID="SqlDataSource_Doctor_Services" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                DeleteCommand="DELETE FROM Doctor_Service WHERE (DS_ID = @DS_ID)" InsertCommand="Insert_Patient_services_out"
                InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                SelectCommand="SELECT Admin_Services.S_Name + '(' + CONVERT (varchar, Admin_Services.S_Amount) + ')' AS S_Name, Doctor_Service.Charges, Doctor_Service.Doctor_ID, Doctor_Service.DS_ID, Doctor_Service.Bank_Payment AS [Bank Charges], Admin_Services.S_Amount AS [Services Charges], Admin_Services.S_ID FROM Doctor_Service INNER JOIN Admin_Services ON Doctor_Service.Service_ID = Admin_Services.S_ID WHERE (Doctor_Service.Doctor_ID = @Doctor_ID)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownListDoctor_id" DefaultValue="" Name="Doctor_ID"
                        PropertyName="SelectedValue" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:ControlParameter ControlID="GridView1" Name="DS_ID" PropertyName="SelectedValue" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" Type="String" />
                    <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
                    <asp:SessionParameter Name="empid" SessionField="Emp_ID" Type="Int32" />
                    <asp:ControlParameter ControlID="HiddenField_S_ID" Name="S_ID" PropertyName="Value"
                        Type="Int32" />
                    <asp:ControlParameter ControlID="HiddenField_Amount" Name="Amount" PropertyName="Value"
                        Type="Int32" />
                    <asp:Parameter DefaultValue="0" Name="Payment_Status" />
                    <asp:SessionParameter DefaultValue="" Name="SubDept_ID" SessionField="SubDeptID"
                        Type="Int32" />
                    <asp:SessionParameter Name="Dept_ID" SessionField="dept_id" Type="Int32" />
                    <asp:ControlParameter ControlID="DropDownList_Employee_name" Name="Doctor_ID" PropertyName="SelectedValue"
                        Type="Int32" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:HiddenField ID="HiddenField_Reg_no" runat="server" />
            <br />
        </div>

        <script type="text/javascript">
<!--
var CollapsiblePanel1 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel1",{contentIsOpen:false});
//-->
        </script>

    </form>
</body>
</html>
