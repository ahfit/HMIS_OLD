<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage.master" inherits="Patient_Registration_Pt_Appointment, App_Web_z30vvahv" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.UltraWebGrid.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>

  <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 <div class="bxmain">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
   
  <tr>
    <td width="40%" align="right">  Complaint : </td>
    <td  width="60%"> <asp:DropDownList ID="DropDownList_Complaint" runat="server" DataSourceID="SqlDataSourceDiagnosis"
            DataTextField="Diagnosis" DataValueField="DiagnosisID" TabIndex="2" Width="202px">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSourceDiagnosis" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
            SelectCommand="SELECT Diagnosis, DiagnosisID FROM Diagnosis ORDER BY Diagnosis"></asp:SqlDataSource></td>
  </tr>
  <tr>
    <td align="right"> <asp:Label ID="Label2" runat="server" Text="Other : "></asp:Label></td>
    <td >  <asp:TextBox ID="TextBoxDiagnosis" runat="server" AccessKey="f"
            CssClass="input_txt" TabIndex="3" Width="200px"></asp:TextBox></td>
  </tr>
  <tr>
    <td align="right">Department : </td>
    <td > <asp:DropDownList ID="DDLDepartment" runat="server" AccessKey="d" AutoPostBack="True"
            DataSourceID="SqlDataSourceDepartment" DataTextField="Dept_Name" DataValueField="Dept_ID"
            TabIndex="1" Width="100px">
            <asp:ListItem Value="6">Emergency : </asp:ListItem>
        </asp:DropDownList>
        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource_SubDept"
            DataTextField="SubDept_Name" DataValueField="SubDept_Id" Width="98px">
        </asp:DropDownList><asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server"
            ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
            SelectCommand="Select_Dept" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_SubDept" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
            SelectCommand="SELECT SubDept_Name, SubDept_Id, Dept_Id FROM SubDepartment WHERE (Dept_Id = @Dept_Id)&#13;&#10;Order by SubDept_Name">
            <SelectParameters>
                <asp:ControlParameter ControlID="DDLDepartment" Name="Dept_Id" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource></td>
  </tr>
  <tr>
    <td align="right">Doctor : </td>
    <td >  <asp:DropDownList ID="DropDownList_Consultant" runat="server" Width="202px" DataSourceID="SqlDataSource_Consultant" DataTextField="Name" DataValueField="EmpID">
        </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource_Consultant" runat="server"
            ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
            SelectCommand="SELECT ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS Name, EmpID, DeptID FROM Employee WHERE (DeptID = @DeptID) ORDER BY ISNULL(EFName, '')">
            <SelectParameters>
                <asp:ControlParameter ControlID="DDLDepartment" Name="DeptID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource></td>
  </tr>
  <tr>
    <td align="right">Appointment Date : </td>
    <td > <igsch:webdatechooser id="WebDateChooser_Date" runat="server" OnValueChanged="WebDateChooser_Date_ValueChanged" CssClass="drop_date" width="202px"></igsch:webdatechooser>
        <asp:HiddenField ID="HiddenFieldAppointmentNo" runat="server" /></td>
  </tr>
  <tr>
    <td align="right">Appointment Time : </td>
    <td > 
        <igtxt:webdatetimeedit id="WebDateTimeEdit1" runat="server" editmodeformat="t" DisplayModeFormat="t" CssClass="input_text" TabIndex="9"  ></igtxt:webdatetimeedit>
        <asp:HiddenField ID="HiddenField_Appointmant_DateTime" runat="server" /></td>
  </tr>
  
  <tr><td align="right">  Priority : </td><td >
        <asp:DropDownList ID="DropDownList_Priority" runat="server" Width="104px">
            <asp:ListItem Value="1">Normal</asp:ListItem>
            <asp:ListItem Value="2">Urgent</asp:ListItem>
      </asp:DropDownList></td></tr>
   <tr><td align="right">   Referred by : </td><td ><asp:TextBox ID="TextBox_Referral" runat="server" class="input_txt"
            TabIndex="5" Width="200px"></asp:TextBox></td></tr>
    <tr><td align="right"> Patient Type : </td><td ><asp:RadioButtonList
                    ID="RadioButtonList_Patient_Type" runat="server" DataSourceID="SqlDataSourcePatientType"
                    DataTextField="Patient_Type" DataValueField="Patient_Type_ID" RepeatColumns="6"
                    RepeatLayout="Flow">
      </asp:RadioButtonList><asp:SqlDataSource ID="SqlDataSourcePatientType" runat="server"
            ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
            SelectCommand="SELECT Patient_Type_ID, Patient_Type FROM Patient_Type"></asp:SqlDataSource>
        <asp:HiddenField ID="HiddenField_time" runat="server" />
    </td></tr>
     <tr><td align="right"></td><td ><asp:Button ID="Button_Save" runat="server" OnClick="Button_Save_Click" CssClass="btn1" Text="Save" /></td></tr>
     
</table></div>
<br />
     <asp:GridView ID="GridView1" runat="server" Width="100%" AutoGenerateColumns="False" DataSourceID="SqlDataSource_Save" DataKeyNames="Appoinment_ID" CssClass="Grid_1">
         <Columns>
             <asp:BoundField DataField="AppointmentNo" HeaderText="AppointmentNo" SortExpression="AppointmentNo" />
             <asp:BoundField DataField="Doctor Name" HeaderText="Doctor Name" SortExpression="Doctor Name" />
             <asp:BoundField DataField="Diagnosis" HeaderText="Diagnosis" SortExpression="Diagnosis" />
             <asp:BoundField DataField="Appointmant_DateTime" HeaderText="Appointmant Date" SortExpression="Appointmant_DateTime" />
             <asp:BoundField DataField="Priority" HeaderText="Priority" SortExpression="Priority" />
             <asp:BoundField DataField="Appointment_Time" HeaderText="Appointmant Time" SortExpression="Appointment_Time" />
             <asp:BoundField DataField="Dept_Name" HeaderText="Department Name" SortExpression="Dept_Name" />
             <asp:BoundField DataField="SubDept_Name" HeaderText="Sub Department Name" SortExpression="SubDept_Name" />
             <asp:CommandField ShowDeleteButton="True" />
         </Columns>
         <AlternatingRowStyle CssClass="GridAltItem" />
     </asp:GridView>
<br />
<br />

  
 
<asp:SqlDataSource ID="SqlDataSource_Save" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
            InsertCommand="INSERT INTO Patient_Appointment(Reg_No, For_Doctor, Complaint, Appointmant_DateTime, Priority, By_Emp_id, AppointmentNo, Other, Referred_by, Appointment_Time, Dept_ID, Sub_Dept_ID) VALUES (@Reg_No, @For_Doctor, @Complaint, @Appointmant_DateTime, @Priority, @By_Emp_id, @AppointmentNo, @Other, @Referred_by, @Appointment_Time, @Dept_ID, @Sub_Dept_ID)"
            SelectCommand="SELECT Patient_Appointment.Appoinment_ID, Patient_Appointment.AppointmentNo, Patient_Appointment.For_Doctor, Patient_Appointment.Complaint, CONVERT (varchar, Patient_Appointment.Appointmant_DateTime, 103) AS Appointmant_DateTime, Patient_Appointment.By_Emp_id, Patient_Appointment.Reg_No, Patient_Appointment.Priority, Patient_Appointment.Other, Patient_Appointment.Referred_by, Patient_Appointment.Appointment_Time, ISNULL(Employee.Prefix, '') + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS [Doctor Name], Diagnosis.Diagnosis, Department.Dept_Name, SubDepartment.SubDept_Name FROM Patient_Appointment INNER JOIN Employee ON Patient_Appointment.For_Doctor = Employee.EmpID LEFT OUTER JOIN Diagnosis ON Patient_Appointment.Complaint = Diagnosis.DiagnosisID LEFT OUTER JOIN SubDepartment ON Patient_Appointment.Sub_Dept_ID = SubDepartment.SubDept_Id LEFT OUTER JOIN Department ON Patient_Appointment.Dept_ID = Department.Dept_ID WHERE (Patient_Appointment.Reg_No = @registrationNo)" DeleteCommand="DELETE FROM Patient_Appointment WHERE (Appoinment_ID = @Appoinment_ID)">
            <InsertParameters>
                <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" />
                <asp:ControlParameter ControlID="DropDownList_Consultant" Name="For_Doctor" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="DropDownList_Complaint" Name="Complaint" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="HiddenField_Appointmant_DateTime" Name="Appointmant_DateTime"
                    PropertyName="Value" />
                <asp:ControlParameter ControlID="DropDownList_Priority" Name="Priority" PropertyName="SelectedValue" />
                <asp:SessionParameter Name="By_Emp_id" SessionField="Emp_Id" />
                <asp:ControlParameter ControlID="HiddenFieldAppointmentNo" Name="AppointmentNo" PropertyName="Value" />
                <asp:ControlParameter ControlID="TextBoxDiagnosis" Name="Other" PropertyName="Text" />
                <asp:ControlParameter ControlID="HiddenField_time" Name="Appointment_Time" PropertyName="Value" />
                <asp:ControlParameter ControlID="TextBox_Referral" Name="Referred_by" PropertyName="Text" />
                <asp:ControlParameter ControlID="DDLDepartment" Name="Dept_ID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="DropDownList1" Name="Sub_Dept_ID" PropertyName="SelectedValue" />
            </InsertParameters>
    <SelectParameters>
        <asp:SessionParameter Name="registrationNo" SessionField="registrationNo" />
    </SelectParameters>
    <DeleteParameters>
        <asp:Parameter Name="Appoinment_ID" />
    </DeleteParameters>
        </asp:SqlDataSource>
     
        
  </asp:Content>