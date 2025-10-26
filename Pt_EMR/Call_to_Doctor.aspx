<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage.master" inherits="Call_to_Doctor1, App_Web_p0fljamz" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>




 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

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
 
 
 <script src="../css_hacims/ck.js" type="text/javascript"></script>
<script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript"></script>

 
 </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 
 
  <table width="100%" border="0" cellspacing="0" cellpadding="0" >
<tr>
<td class="leftnav" valign="top" >
<asp:Label ID="LabelSideMenu" runat="server"></asp:Label>

</td>
<td  style="width:auto;" valign="top" >
     

 
 
 
<asp:Label ID="Label_message" runat="server" CssClass="err" ></asp:Label> 
<div class="bxmain">
<table cellpadding="0" cellspacing="0" class="tbl_form" width="100%" >
    <tr>
                     
                          <td width="25%" align="right" >
                             Department Name :</td>
                          <td   >
                              <asp:DropDownList AutoPostBack="True" 
                                  DataTextField="Dept_Name" DataValueField="Dept_ID" ID="DropDownListDeptName" runat="server" Width="265px" DataSourceID="SqlDataSourceDepartmentName">                              </asp:DropDownList></td>
    </tr>
                          
                      <tr>
                          <td align="right" >
                             Sub Department Name :</td>
                          <td >
                              <asp:DropDownList AutoPostBack="True" 
                                  DataTextField="SubDept_Name" DataValueField="SubDept_Id" ID="DropDownListSubDept" runat="server" Width="175px" DataSourceID="SqlDataSourceSubDepartmentName">                              </asp:DropDownList></td>
      </tr>
                      <tr>
                          <td align="right"  >
                             Doctor Name :</td>
                          <td  >
                              <asp:DropDownList 
                                  DataTextField="EmployeeName" DataValueField="EmpID" ID="DropDownListDoctorName" runat="server" Width="175px" DataSourceID="SqlDataSourceDoctorName">                              </asp:DropDownList></td>
      </tr>
    <tr>
        <td align="right" valign="top"  >
            Subject :</td>
        <td style="height: 18px">
        <asp:TextBox ID="TextBoxSubject" runat="server" TextMode="MultiLine" Width="90%" Height="50px"></asp:TextBox></td>
    </tr>
    <tr>
        <td align="right" >
        </td>
        <td >
            <asp:RadioButtonList ID="RadioButtonList_Call_type" runat="server" RepeatDirection="Horizontal">
                <asp:ListItem Selected="True">Consultation Only</asp:ListItem>
                <asp:ListItem>Managment Through Acute Phase</asp:ListItem>
                <asp:ListItem>Managment Through Entire Illness</asp:ListItem>
            </asp:RadioButtonList></td>
    </tr>
                      <tr>
                          <td align="right" valign="top" >
                            History :</td>
                          <td >
                              <asp:TextBox ID="TextBox_History" runat="server"  Height="50px" TextMode="MultiLine" Width="90%"></asp:TextBox></td>
      </tr>
                      <tr>
                          <td align="right" valign="top" >
                            Examination :</td>
                          <td >
                              <asp:TextBox ID="TextBox_examination" runat="server"  Height="50px" TextMode="MultiLine" Width="90%"></asp:TextBox></td>
      </tr>
                      <tr>
                          <td align="right" valign="top" >
                            Investigations : </td>
                          <td >
                              <asp:TextBox ID="TextBox_investigation" runat="server"  Height="50px" TextMode="MultiLine" Width="90%"></asp:TextBox></td>
      </tr>
                      <tr>
                          <td align="right" valign="top" > 
                            Provisional Diagnosis :</td>
                          <td >
                              <asp:TextBox ID="TextBox_PDiagnosis" runat="server"  Height="50px" TextMode="MultiLine" Width="90%"></asp:TextBox></td>
      </tr>
                      <tr>
                          <td align="right" valign="top" > 
                            Opinion Required For :</td>
                          <td >
                              <asp:TextBox ID="TextBox_opinion_Req_For" runat="server"  Height="50px" TextMode="MultiLine" Width="90%"></asp:TextBox></td>
      </tr>
                      
                      <tr>
                          <td align="right" valign="top" >
                             When Needed :</td>
                          <td align="left">
                            <table border="0" cellpadding="0" cellspacing="0" >
                              <tr>
                                <td>  <igsch:webdatechooser id="WebDateChooser1" runat="server" CssClass="drop_date"></igsch:webdatechooser></td>
                                <td><asp:TextBox CssClass="input_txt" ID="TextBoxHours" runat="server" Width="28px">00</asp:TextBox>
                                  <span  >HH</span></td>
                                <td><asp:TextBox CssClass="input_txt" ID="TextBoxMin" runat="server" Width="28px">00</asp:TextBox>
                                  <span  >Min</span></td>
                              </tr>
                            </table>                          </td>
                          </tr>
                      <tr>
                          <td ></td>
                          <td >
                              <asp:Button  ID="ButtonSave" runat="server" Text="Save" />
                           
                              <asp:Label CssClass="err"  ID="LabelMessage" runat="server" ></asp:Label></td>
      </tr> 
  </table></div>
<br />
<asp:GridView ID="GridView_Call" runat="server" CssClass="Grid_1" AutoGenerateColumns="False" DataSourceID="SqlDataSourceForGrid" Width="100%" DataKeyNames="CTD_ID">
                          <RowStyle CssClass="GridItem" />
                          <HeaderStyle CssClass="GridHeader" />
                          <AlternatingRowStyle CssClass="GridAltItem" />
                          <Columns>
                              <asp:BoundField DataField="Doctor to call" HeaderText="Doctor to call" SortExpression="Doctor to call" />
                              <asp:BoundField DataField="When Needed" HeaderText="When Needed" SortExpression="When Needed" />
                              <asp:BoundField DataField="Department Name" HeaderText="Department Name" SortExpression="Department Name" />
                              <asp:BoundField DataField="SubDepartment Name" HeaderText="SubDepartment Name" SortExpression="SubDepartment Name" />
                              <asp:BoundField DataField="Call_Type" HeaderText="Call Type" SortExpression="Call_Type" />
                              <asp:HyperLinkField DataNavigateUrlFields="CTD_ID" DataNavigateUrlFormatString="~/pt_emr/Doctor_Call_Report.aspx?CTS_ID={0}"
                                  Target="_blank" Text="Report" />
                              <asp:ButtonField CommandName="select" Text="Add_Reply" />
                          </Columns>
    </asp:GridView>
    <br />
    
    
    <asp:Panel ID="Panel_Reply" runat="server" Visible="False" Width="100%" CssClass="lightbox_bg">
     
     <div class="lightbox">
      <table  cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
            <tr>
                <td  width="25%" align="right" valign="top">
                    Reply :</td>
                <td  >
                    <asp:TextBox ID="TextBox_Reply" runat="server" Height="85px" TextMode="MultiLine"
                        Width="90%"></asp:TextBox></td>
            </tr>
            <tr>
                <td align="right"  >
                    Reply Date :</td>
                <td  >
                    <asp:Label ID="Label_ReplyDate" runat="server" Enabled="False"></asp:Label></td>
            </tr>
            <tr>
                <td  align="right" >
                    Reply By :</td>
                <td  >
                    <asp:Label ID="Label_ReplyBy" runat="server" Enabled="False"></asp:Label></td>
            </tr>
            <tr>
                <td  >
                    <asp:SqlDataSource ID="SqlDataSource_ReplyUpdate" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                        UpdateCommand="UPDATE Call_To_Doctor SET Status =1, Reply =@Reply, Reply_By =@Reply_By, Reply_Datetime = GETDATE()&#13;&#10;WHERE (CTD_ID = @CTD_ID) ">
                        <UpdateParameters>
                            <asp:ControlParameter ControlID="HiddenField_CTS_ID" Name="CTD_ID" PropertyName="Value" />
                            <asp:ControlParameter ControlID="TextBox_Reply" Name="Reply" PropertyName="Text" />
                            <asp:SessionParameter Name="Reply_By" SessionField="emp_id" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                    <asp:HiddenField ID="HiddenField_CTS_ID" runat="server" />
                    <asp:SqlDataSource ID="SqlDataSource_Doctor_Services" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                        DeleteCommand="DELETE FROM Doctor_Service WHERE (DS_ID = @DS_ID)" InsertCommand="Insert_Doctor_Call_Services"
                        InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>">
                        <DeleteParameters>
                            <asp:ControlParameter ControlID="GridView1" Name="DS_ID" PropertyName="SelectedValue" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" Type="String" />
                            <asp:SessionParameter Name="YearlyNo" SessionField="PayId" Type="Decimal" />
                            <asp:SessionParameter Name="empid" SessionField="Emp_ID" Type="Int32" />
                            <asp:Parameter DefaultValue="0" Name="Payment_Status" />
                            <asp:SessionParameter DefaultValue="" Name="SubDept_ID" SessionField="SubDeptID"
                                Type="Int32" />
                            <asp:SessionParameter Name="Dept_ID" SessionField="dept_id" Type="Int32" />
                            <asp:SessionParameter Name="Doctor_ID" SessionField="Emp_Id" Type="Int32" />
                            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                </td>
                <td  >
                    <asp:Button ID="Button_Save" runat="server" Text="Save" />
                    <asp:Button ID="Button_Close" runat="server" Text="Close" /></td>
            </tr>
        </table></div>
    </asp:Panel>

                      <asp:SqlDataSource ID="SqlDataSourceDepartmentName" 
        runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                      
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="SELECT Dept_ID, Dept_Name FROM Department ORDER BY Dept_Name"> </asp:SqlDataSource>
                      <asp:SqlDataSource ID="SqlDataSourceSubDepartmentName" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="SELECT SubDept_Name, SubDept_Id FROM SubDepartment WHERE (Dept_Id = @DeptID)">
                        <SelectParameters>
                          <asp:ControlParameter ControlID="DropDownListDeptName" Name="DeptID" PropertyName="SelectedValue" />
                        </SelectParameters>
                      </asp:SqlDataSource>
                      <asp:SqlDataSource ID="SqlDataSourceDoctorName" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="SELECT ISNULL(Prefix, ' ') + ' ' + ISNULL(EFName, ' ') + ' ' + ISNULL(EMName, ' ') + ' ' + ISNULL(ELName, ' ') AS EmployeeName, EmpID FROM Employee WHERE (DeptID = @DeptID) AND (SubDeptId = @SubDeptId)">
                        <SelectParameters>
                          <asp:ControlParameter ControlID="DropDownListDeptName" Name="DeptID" PropertyName="SelectedValue" />
                          <asp:ControlParameter ControlID="DropDownListSubDept" Name="SubDeptId" PropertyName="SelectedValue" />
                        </SelectParameters>
                      </asp:SqlDataSource>
                      <asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>" ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>" SelectCommand="SELECT ISNULL(Employee.Prefix, '') + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS [Doctor to call], CONVERT (varchar, Call_To_Doctor.Call_Date, 107) + ' ' + CONVERT (varchar, Call_To_Doctor.When_Needed / 60) + ' H ' + CONVERT (Varchar, Call_To_Doctor.When_Needed % 60) + ' M ' AS [When Needed], Department.Dept_Name AS [Department Name], SubDepartment.SubDept_Name AS [SubDepartment Name], Call_To_Doctor.Call_Type, Call_To_Doctor.CTD_ID FROM Department INNER JOIN Employee ON Department.Dept_ID = Employee.DeptID INNER JOIN Call_To_Doctor ON Employee.EmpID = Call_To_Doctor.Doctor_ID INNER JOIN SubDepartment ON Employee.SubDeptId = SubDepartment.SubDept_Id WHERE (Call_To_Doctor.RegNo = @regno) AND (Call_To_Doctor.YearlyNo = @yearlyno)">
                        <SelectParameters>
                          <asp:SessionParameter Name="regno" SessionField="registrationNo" />
                          <asp:SessionParameter Name="yearlyno" SessionField="YearlyNo" />
                        </SelectParameters>
                      </asp:SqlDataSource>
                      <br />
<br />

     
     
</td>
</tr>
</table>
 

<asp:Label ID="LabelFooter" runat="server" Text="Label"></asp:Label>

 </asp:Content>
