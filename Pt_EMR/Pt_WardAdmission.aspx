<%@ Page Language="C#" MasterPageFile="~/hacims_masterpage_billing.master" AutoEventWireup="true" CodeFile="Pt_WardAdmission.aspx.cs" Inherits="Nursing_Pt_WardAdmission"  Async="True" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

 

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="LabelSideMenu" runat="server" Visible="false"></asp:Label>
   
     <table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr>
             <td colspan="2" valign="top">
                 <asp:DataList ID="DataList_AdmissionDetail" runat="server" DataSourceID="SqlDataSource_Admission_Detail" Visible="False">
                     <ItemTemplate>
                         Consultant:
                         <asp:Label ID="ConsultantLabel" runat="server" Text='<%# Eval("Consultant") %>'>
                         </asp:Label><br />
                         Admission_Diagnosis:
                         <asp:Label ID="Admission_DiagnosisLabel" runat="server" Text='<%# Eval("Admission_Diagnosis") %>'>
                         </asp:Label><br />
                         Order_By_Doctor:
                         <asp:Label ID="Order_By_DoctorLabel" runat="server" Text='<%# Eval("Order_By_Doctor") %>'>
                         </asp:Label><br />
                         Advice:
                         <asp:Label ID="AdviceLabel" runat="server" Text='<%# Eval("Advice") %>'></asp:Label><br />
                         Urgency:
                         <asp:Label ID="UrgencyLabel" runat="server" Text='<%# Eval("Urgency") %>'></asp:Label><br />
                         NoEdStay:
                         <asp:Label ID="NoEdStayLabel" runat="server" Text='<%# Eval("NoEdStay") %>'></asp:Label><br />
                         AnaesthesiaType:
                         <asp:Label ID="AnaesthesiaTypeLabel" runat="server" Text='<%# Eval("AnaesthesiaType") %>'>
                         </asp:Label><br />
                         Bloodrequired:
                         <asp:Label ID="BloodrequiredLabel" runat="server" Text='<%# Eval("Bloodrequired") %>'>
                         </asp:Label><br />
                         OT_Day:
                         <asp:Label ID="OT_DayLabel" runat="server" Text='<%# Eval("OT_Day") %>'></asp:Label><br />
                         OT_Room:
                         <asp:Label ID="OT_RoomLabel" runat="server" Text='<%# Eval("OT_Room") %>'></asp:Label><br />
                         ShiftID:
                         <asp:Label ID="ShiftIDLabel" runat="server" Text='<%# Eval("ShiftID") %>'></asp:Label><br />
                         ExpectedOPDate:
                         <asp:Label ID="ExpectedOPDateLabel" runat="server" Text='<%# Eval("ExpectedOPDate") %>'>
                         </asp:Label><br />
                         BloodGroup:
                         <asp:Label ID="BloodGroupLabel" runat="server" Text='<%# Eval("BloodGroup") %>'>
                         </asp:Label><br />
                         Entry_Date:
                         <asp:Label ID="Entry_DateLabel" runat="server" Text='<%# Eval("Entry_Date") %>'>
                         </asp:Label><br />
                         Rec_OP_Admission_Date:
                         <asp:Label ID="Rec_OP_Admission_DateLabel" runat="server" Text='<%# Eval("Rec_OP_Admission_Date") %>'>
                         </asp:Label><br />
                         Pre_OP_Required:
                         <asp:Label ID="Pre_OP_RequiredLabel" runat="server" Text='<%# Eval("Pre_OP_Required") %>'>
                         </asp:Label><br />
                         Type_ID:
                         <asp:Label ID="Type_IDLabel" runat="server" Text='<%# Eval("Type_ID") %>'></asp:Label><br />
                         Type_Name:
                         <asp:Label ID="Type_NameLabel" runat="server" Text='<%# Eval("Type_Name") %>'></asp:Label><br />
                         ICU_Stay:
                         <asp:Label ID="ICU_StayLabel" runat="server" Text='<%# Eval("ICU_Stay") %>'></asp:Label><br />
                         Ward_Admission:
                         <asp:Label ID="Ward_AdmissionLabel" runat="server" Text='<%# Eval("Ward_Admission") %>'>
                         </asp:Label><br />
                         CanDelayFor:
                         <asp:Label ID="CanDelayForLabel" runat="server" Text='<%# Eval("CanDelayFor") %>'>
                         </asp:Label><br />
                         Fit_Status:
                         <asp:Label ID="Fit_StatusLabel" runat="server" Text='<%# Eval("Fit_Status") %>'>
                         </asp:Label><br />
                         Operation_Minor:
                         <asp:Label ID="Operation_MinorLabel" runat="server" Text='<%# Eval("Operation_Minor") %>'>
                         </asp:Label><br />
                         <br />
                     </ItemTemplate>
                 </asp:DataList><asp:SqlDataSource ID="SqlDataSource_Admission_Detail" runat="server" ConnectionString="<%$ ConnectionStrings:OperationTheaterConnectionString %>"
                     ProviderName="<%$ ConnectionStrings:OperationTheaterConnectionString.ProviderName %>"
                     SelectCommand="SELECT     Pt_Operation_Recommended.Consultant, Pt_Operation_Recommended.Admission_Diagnosis, Pt_Operation_Recommended.Order_By_Doctor, &#13;&#10;                      Pt_Operation_Recommended.Advice, Pt_Operation_Recommended.Urgency, Pt_Operation_Recommended.NoEdStay, Pt_Operation_Recommended.AnaesthesiaType, &#13;&#10;                      Pt_Operation_Recommended.Bloodrequired, Pt_Operation_Recommended.OT_Day, Pt_Operation_Recommended.OT_Room, Pt_Operation_Recommended.ShiftID, &#13;&#10;                      Pt_Operation_Recommended.ExpectedOPDate, Pt_Operation_Recommended.BloodGroup, Pt_Operation_Recommended.Entry_Date, &#13;&#10;                      Pt_Operation_Recommended.Rec_OP_Admission_Date, Pt_Operation_Recommended.Pre_OP_Required, Pt_Operation_Recommended.Type_ID, &#13;&#10;                      Pt_Operation_Recommended.Type_Name, Pt_Operation_Recommended.ICU_Stay, Pt_Operation_Recommended.Ward_Admission, &#13;&#10;                      Pt_Operation_Recommended.CanDelayFor, Pt_Operation_Recommended.Fit_Status, Pt_Operation_Recommended.Operation_Minor&#13;&#10;FROM         Pt_Operation_Recommended INNER JOIN&#13;&#10;                      Payment ON Pt_Operation_Recommended.OP_Recommended_Id = Payment.Recomended_Id&#13;&#10;WHERE     (Payment.RegNo = @RegNo) AND (Payment.PayID = @PayID)">
                     <SelectParameters>
                         <asp:QueryStringParameter Name="RegNo" QueryStringField="regno" />
                         <asp:QueryStringParameter Name="PayID" QueryStringField="payid" />
                     </SelectParameters>
                 </asp:SqlDataSource>
             </td>
         </tr>
  <tr>
    <td valign="top" style="width: 47%"> <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
      <tr>
          <td align="right" width="40%">
                Arrival Status :</td>
          <td >
                <asp:DropDownList ID="ddlArrivalStatus" runat="server" 
                    DataSourceID="SqlDataSource_Arrival_status" DataTextField="Arrival_Status_name" 
                    DataValueField="Arrival_Status_ID">
                </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource_Arrival_status" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>" SelectCommand="SELECT [Arrival_Status_ID], [Arrival_Status_name] FROM [Arrival_Status]">
                    </asp:SqlDataSource>
          </td>
           
      </tr>
      <tr>
          <td align="right" width="40%">
                Activity Level :</td>
          <td >
                <asp:DropDownList ID="ddlActivityLevel" runat="server">
                    <asp:ListItem>Up &amp; About</asp:ListItem>
                    <asp:ListItem>AAT</asp:ListItem>
                    <asp:ListItem>Need Assistance</asp:ListItem>
                    <asp:ListItem>Bed Rest</asp:ListItem>
                </asp:DropDownList></td>
           
      </tr>
      <tr>
          <td align="right" width="40%">
                Patient Condition :</td>
          <td >
                <asp:DropDownList ID="ddlPatientCondition" runat="server">
                    <asp:ListItem>Stable</asp:ListItem>
                    <asp:ListItem>Serious</asp:ListItem>
                    <asp:ListItem>Critical</asp:ListItem>
                </asp:DropDownList></td>
           
      </tr>
         <tr>
                                            <td align="right" style="height: 18px" width="30%">Admission Type :</td>
                                            <td style="height: 18px">
                                                <asp:DropDownList ID="DDLAdmissionType" runat="server" Width="200px">
                                                    
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
      <tr>
          <td align="right" width="40%">
                Admitted Diagnoses :</td>
          <td >
                <asp:TextBox ID="txtAdmittedDiagnoses" runat="server" TextMode="MultiLine" Height="50px" ></asp:TextBox></td>
           
      </tr>
        <tr>
            <td align="right" width="40%" >
                Refer By :</td>
            <td >
                <asp:DropDownList ID="ddlReferBy" runat="server" DataSourceID="dsReferBy" Enabled="false" 
                    DataTextField="EmpName" DataValueField="EmpID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="dsReferBy" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>" 
                    SelectCommand="SELECT ISNULL(Prefix, '') + ' ' + ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS EmpName, EmpID FROM Employee where Is_Consultant =1  order By ISNULL(Prefix, '') + ' ' + ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '')">
                </asp:SqlDataSource>
            </td>
             
        </tr>
        <tr>
            <td align="right" >
                Consultant :</td>
            <td>
                <asp:DropDownList ID="ddlConsultant" runat="server" DataSourceID="dsConsultant" 
                    DataTextField="EmpName" DataValueField="EmpID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="dsConsultant" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>" 
                    SelectCommand="SELECT ISNULL(Prefix, '') + ' ' + ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS EmpName, EmpID FROM Employee where Is_Consultant =1 AND ActiveStatus=1  order By ISNULL(Prefix, '') + ' ' + ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '')">
                </asp:SqlDataSource>
                                <cc1:listsearchextender id="ListSearchExtender1" runat="server" targetcontrolid="ddlConsultant"></cc1:listsearchextender>
            </td>
        </tr>
        <tr>
            <td align="right" >
                Refer&nbsp; :</td>
            <td>
                <asp:TextBox ID="txtReferByInstitute" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right" >
                Type :</td>
            <td>
                <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                    <asp:ListItem Selected="True">Elective</asp:ListItem>
                    <asp:ListItem>Emergency</asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td align="right" >
                Patient Department :</td>
            <td>
                <asp:DropDownList ID="ddlPatientDepartment" runat="server" AutoPostBack="True" Enabled="false" 
                    DataSourceID="dsDepartment" DataTextField="Dept_Name" DataValueField="Dept_ID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="dsDepartment" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
                    SelectCommand="SELECT [Dept_ID], [Dept_Name] FROM [Department]">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="right" >
                Patient Category :</td>
            <td>
                <asp:DropDownList ID="ddlPatientSubDepartment" runat="server" Enabled="false" 
                    DataSourceID="dsSubDepartment" DataTextField="SubDept_Name" 
                    DataValueField="SubDept_Id">
                </asp:DropDownList>
                <asp:SqlDataSource ID="dsSubDepartment" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
                    SelectCommand="SELECT [SubDept_Id], [SubDept_Name] FROM [SubDepartment] WHERE ([Dept_Id] = @Dept_Id)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlPatientDepartment" Name="Dept_Id" 
                            PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="right" >
                Description :</td>
            <td>
                <asp:TextBox ID="txtDescription" TextMode ="MultiLine"  Height ="50px"   runat="server"></asp:TextBox>
            </td>
        </tr>
      
           

         
       
    </table>
       <div class="bxmain inner_content CollapsiblePanel" style="width: 99%; margin-bottom: 4px; padding-top: 0.6em;" >
                    <h2><span>Kin Information</span></h2>
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr class="rowStyle">
                            <td class="Myheading" style="width: 80px;">Name
                            </td>
                            <td width="24%">
                                <asp:TextBox ID="txtKinName" runat="server" TabIndex="18" SkinID="captxt" onKeyPress="return ValidateAlpha(event);"></asp:TextBox>
                            </td>
                            <td class="Myheading">
                                Relation With Patient
                            </td>
                            <td width="24%">
                                <asp:TextBox ID="txtRelationWithPatient" runat="server" TabIndex="19" SkinID="captxt"></asp:TextBox>
                            </td>
                        </tr>
                        <tr class="rowStyle">
                            <td class="Myheading" style="width: 80px;">
                                Contact # :
                            </td>
                            <td>
                                <asp:TextBox ID="txtKinContactNo" runat="server" TabIndex="20" SkinID="captxt" MaxLength="11"  onkeypress="return isNumberKey(event);"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtKinContactNo"
                                    ValidationGroup="s" ErrorMessage="*Enter Valid Contact No."></asp:RequiredFieldValidator>
                            </td>
                            <td class="Myheading">
                                Address
                            </td>
                            <td colspan="2">
                                <asp:TextBox ID="txtKinAddress" style="height:30px;margin-top:3px"  runat="server" TabIndex="21" SkinID="captxt" TextMode="MultiLine"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
    <br />
        <table>
     <tr>
            <td >&nbsp;
                </td>
            <td >
                <asp:Button ID="btnSave" runat="server" Text="Save & Admit" onclick="btnSave_Click" />
            
                <asp:Button ID="btnUpdate" runat="server" onclick="btnUpdate_Click" 
                    Text="Update" />
            </td>
        </tr>
            </table>
    <asp:SqlDataSource ID="dsWardAdmission" runat ="server" 
            ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>" 
            DeleteCommand="DELETE FROM PT_WardAdmission WHERE (Admit_ID = @Admit_ID)" 
            InsertCommand="INSERT INTO PT_WardAdmission(RegNo, YearlyNo, Admit_Date, Refer_By, ReferBy_Institute, Consultant_ID, Patient_Condition, Activity_level, Admitted_Diagnosis, Admited_by, Patient_SubDept_ID, Description, Admission_Type, Arrival_Status_ID) VALUES (@RegNo, @YearlyNo, GETDATE(), @Refer_By, @ReferBy_Institute, @Consultant_ID, @Patient_Condition, @Activity_level, @Admitted_Diagnosis, @Admited_by, @Patient_SubDept_ID, @Description, @Admission_Type, @Arrival_Status_ID)" 
            
            SelectCommand="SELECT PT_WardAdmission.Admit_Date, PT_WardAdmission.Refer_By, PT_WardAdmission.ReferBy_Institute, PT_WardAdmission.Patient_Condition, PT_WardAdmission.Activity_level, PT_WardAdmission.Admitted_Diagnosis, PT_WardAdmission.Description, PT_WardAdmission.Admission_Type, ISNULL(BasicDataInfo.dbo.Employee.Prefix, '') + ' ' + ISNULL(BasicDataInfo.dbo.Employee.EFName, '') + ' ' + ISNULL(BasicDataInfo.dbo.Employee.EMName, '') + ' ' + ISNULL(BasicDataInfo.dbo.Employee.ELName, '') AS ReferByName, ISNULL(Employee_1.Prefix, '') + ' ' + ISNULL(Employee_1.EFName, '') + ' ' + ISNULL(Employee_1.EMName, '') + ' ' + ISNULL(Employee_1.ELName, '') AS Consultant, PT_WardAdmission.Consultant_ID, BasicDataInfo.dbo.SubDepartment.SubDept_Name, PT_WardAdmission.Admit_ID, Arrival_Status.Arrival_Status_name, PT_WardAdmission.Arrival_Status_ID FROM PT_WardAdmission INNER JOIN BasicDataInfo.dbo.Employee ON PT_WardAdmission.Refer_By = BasicDataInfo.dbo.Employee.EmpID INNER JOIN BasicDataInfo.dbo.Employee AS Employee_1 ON PT_WardAdmission.Consultant_ID = Employee_1.EmpID INNER JOIN BasicDataInfo.dbo.SubDepartment ON PT_WardAdmission.Patient_SubDept_ID = BasicDataInfo.dbo.SubDepartment.SubDept_Id INNER JOIN Arrival_Status ON PT_WardAdmission.Arrival_Status_ID = Arrival_Status.Arrival_Status_ID WHERE (PT_WardAdmission.RegNo = @RegNo) AND (PT_WardAdmission.YearlyNo = @YearlyNo)" 
            UpdateCommand="UPDATE PT_WardAdmission SET Refer_By = @Refer_By, Arrival_Status_ID = @Arrival_Status_ID, Consultant_ID = @Consultant_ID, ReferBy_Institute = @ReferBy_Institute, Patient_Condition = @Patient_Condition, Activity_level = @Activity_level, Admitted_Diagnosis = @Admitted_Diagnosis, Patient_SubDept_ID = @Patient_SubDept_ID, Description = @Description, Admission_Type = @Admission_Type WHERE (Admit_ID = @Admit_ID)" >
        <SelectParameters>
            <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
        </SelectParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="grdWardAdmission" Name="Admit_ID" 
                PropertyName="SelectedPersistedDataKey" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="ddlReferBy" Name="Refer_By" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ddlArrivalStatus" Name="Arrival_Status_ID" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ddlConsultant" Name="Consultant_ID" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="txtReferByInstitute" Name="ReferBy_Institute" 
                PropertyName="Text" />
            <asp:ControlParameter ControlID="ddlPatientCondition" Name="Patient_Condition" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ddlActivityLevel" Name="Activity_level" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="txtAdmittedDiagnoses" 
                Name="Admitted_Diagnosis" PropertyName="Text" />
            <asp:ControlParameter ControlID="ddlPatientSubDepartment" 
                Name="Patient_SubDept_ID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="txtDescription" Name="Description" 
                PropertyName="Text" />
            <asp:ControlParameter ControlID="RadioButtonList1" Name="Admission_Type" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="grdWardAdmission" Name="Admit_ID" 
                PropertyName="SelectedValue" />
        </UpdateParameters>
        <InsertParameters>
            <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
            <asp:ControlParameter ControlID="ddlReferBy" Name="Refer_By" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="txtReferByInstitute" Name="ReferBy_Institute" 
                PropertyName="Text" />
            <asp:ControlParameter ControlID="ddlConsultant" Name="Consultant_ID" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ddlPatientCondition" Name="Patient_Condition" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ddlActivityLevel" Name="Activity_level" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="txtAdmittedDiagnoses" 
                Name="Admitted_Diagnosis" PropertyName="Text" />
            <asp:SessionParameter Name="Admited_by" SessionField="Emp_Id" />
            <asp:ControlParameter ControlID="ddlPatientSubDepartment" 
                Name="Patient_SubDept_ID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="txtDescription" Name="Description" 
                PropertyName="Text" />
            <asp:ControlParameter ControlID="RadioButtonList1" Name="Admission_Type" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ddlArrivalStatus"  
                Name="Arrival_Status_ID" PropertyName="SelectedValue" />
        </InsertParameters>
        </asp:SqlDataSource> </td>
    <td valign="top" >  
    
    
    
     <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <asp:Panel ID="pnl_Assign_Bed" runat="server" Width="98%" CssClass="bxmain" Style="margin-left:10px;">
                    <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                        <tr>
                            <td align="right" width="40%">
                                Unit / Floor :</td>
                            <td width="60%">
                                <asp:DropDownList ID="DropDownListFloor" runat="server" AutoPostBack="True" CssClass="dropbox"
                                    DataSourceID="SqlDataSourceWardFloor" DataTextField="Ward_Name" DataValueField="ward_id"
                                    Width="250px" OnSelectedIndexChanged="DropDownListFloor_SelectedIndexChanged">
                                </asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="Label1" runat="server" CssClass="err"></asp:Label>
                                :</td>
                            <td>
                                <asp:CheckBoxList ID="CheckBoxListRoom" runat="server"  DataSourceID="SqlDataSourceRoomBed"
                                    DataTextField="Bed_No" DataValueField="ward_Id" RepeatColumns="10" RepeatDirection="Horizontal"
                                     >
                                </asp:CheckBoxList>
                                <asp:RadioButtonList ID="RadioButtonListBeds" runat="server" CssClass="radlist" DataSourceID="SqlDataSourceBedRoom"
                                    DataTextField="Bed_No" DataValueField="Bed_id" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                </asp:RadioButtonList></td>
                        </tr>
                        <tr>
                            <td align="right">
                                </td>
                            <td>
                                
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                </td>
                            <td>
                                
                                <cc1:listsearchextender id="Listsearchextender2" runat="server" targetcontrolid="ddlReferBy">
        </cc1:listsearchextender>
                            </td>
                        </tr>
                        <tr>
                            <td >
                            </td>
                            <td >
                                <asp:Button ID="Button1" runat="server" CssClass="btn1" Text="Assign Bed" OnClick="Button1_Click" />&nbsp;<asp:Label
                                    ID="Label_script" runat="server"></asp:Label></td>
                        </tr>
                        <tr>
                            <td colspan="2" valign="top" >
                            <br />

                                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="Bed_No,ward_Id"
                                    OnPreRender="GridView2_PreRender" Width="98%" Style="margin-left:8px;">
                                    <Columns>
                                        <asp:BoundField DataField="Ward_id" HeaderText="Ward_id" SortExpression="Ward_id"
                                            Visible="False" />
                                        <asp:BoundField DataField="Bed_id" HeaderText="Bed_id" SortExpression="Bed_id" Visible="False" />
                                        <asp:BoundField DataField="SubDept_Name" HeaderText="Floor/Unit" SortExpression="SubDept_Name" />
                                        <asp:BoundField DataField="Bed_No" HeaderText="Bed/Room #" SortExpression="Bed_No" />
                                        <asp:BoundField DataField="Indoor_No" HeaderText="File #" SortExpression="Indoor_No" />
                                        <asp:BoundField DataField="Prefix" HeaderText="Prefix" SortExpression="Prefix" />
                                        <asp:BoundField DataField="PFName" HeaderText="PFName" SortExpression="PFName" />
                                        <asp:BoundField DataField="PMName" HeaderText="PMName" SortExpression="PMName" />
                                        <asp:BoundField DataField="PLName" HeaderText="PLName" SortExpression="PLName" />
                                        <asp:BoundField DataField="Relation_Name" HeaderText="Rel. Name" SortExpression="Relation Name" />
                                        <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
                                        <asp:BoundField DataField="Age" HeaderText="Age" SortExpression="Age" />
                                        <asp:BoundField DataField="Addmission_Date" HeaderText="Admission Date" SortExpression="Addmission Date" />
                                        <asp:CheckBoxField DataField="Bed_Status" HeaderText="Bed Status" SortExpression="Bed_Status"
                                            Visible="False" />
                                        <asp:BoundField DataField="Datedifference" HeaderText="Total Days" SortExpression="Datedifference" />
                                        <asp:BoundField DataField="Consultant_Name" HeaderText="Consultant Name" SortExpression="Consultant Name" />
                                    </Columns>
                                     <RowStyle CssClass="GridItem" />
<AlternatingRowStyle CssClass="GridAltItem" />
<PagerStyle CssClass="GridPager" />
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <asp:HiddenField ID="HiddenFieldWard_SubDept_ID" runat="server" />
                                <asp:HiddenField ID="HiddenField_EncrRegNo" runat="server" />
                                <asp:HiddenField ID="HiddenFieldBedID" runat="server" />
                                <asp:SqlDataSource ID="SqlDataSource_Grid" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                    SelectCommand="Pt_View_AssignBed" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DropDownListFloor" Name="SubDept_Id" PropertyName="SelectedValue"
                                            Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:HiddenField ID="HiddenFieldWard_Id" runat="server" />
                                <asp:HiddenField ID="HiddenFieldBedRoomCharges" runat="server" />
                                <asp:HiddenField ID="HiddenFieldSubDepartment" runat="server" />
                                <asp:SqlDataSource ID="SqlDataSource_Update" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                    UpdateCommand="&#13;&#10;&#13;&#10;UPDATE Ward_Beds SET Bed_Status = 1 WHERE (ward_Id = @ward_Id) AND (Bed_id = @Bed_ID) &#13;&#10;&#13;&#10;">
                                    <UpdateParameters>
                                        <asp:ControlParameter ControlID="HiddenFieldWard_Id" Name="ward_Id" PropertyName="Value" />
                                        <asp:ControlParameter ControlID="HiddenFieldBedID" Name="Bed_ID" PropertyName="Value" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSource_Insert" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                                    InsertCommand="Pt_InnerDepartment_PatientForward" InsertCommandType="StoredProcedure"
                                    ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" UpdateCommand="UPDATE  Payment Set Patient_Type='IPD' where PayID=@PayID">
                                    <InsertParameters>
                                        <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
                                        <asp:SessionParameter Name="EmpID" SessionField="emp_id" Type="Int32" />
                                        <asp:SessionParameter Name="PayID" SessionField="YearlyNo" Type="Decimal" />
                                        <asp:ControlParameter ControlID="HiddenFieldWard_SubDept_ID" Name="ToSubDept" PropertyName="Value"
                                            Type="Int32" />
                                        <asp:SessionParameter Name="SendingDept" SessionField="SubDeptID" Type="Int32" />
                                        <asp:Parameter DefaultValue="6" Name="iRequestTypeTo" Type="Int32" />
                                        <asp:Parameter DefaultValue="1" Name="iRequestTypeBy" Type="Int32" />
                                    </InsertParameters>
                                    <UpdateParameters>
                                        <asp:SessionParameter Name="PayID" SessionField="YearlyNo" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSourceUpdatePayment" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" UpdateCommand="Update_Payment_For_Consultant"
                                    UpdateCommandType="StoredProcedure">
                                    <UpdateParameters>
                                        <asp:ControlParameter ControlID="DropDownListConsultant" Name="DoctorID" PropertyName="SelectedValue" />
                                        <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                                        <asp:SessionParameter Name="PayID" SessionField="YearlyNo" />
                                        <asp:ControlParameter ControlID="DropDownListReferBy" Name="Refer_By_ID" PropertyName="SelectedValue"
                                            Type="Int32" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSourceWardFloor" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="Select_Ward_Check" SelectCommandType="StoredProcedure">
                                    
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSourceRoomBed" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                    SelectCommand="SELECT        Ward_Beds.ward_Id, Ward_Beds.Bed_No, Ward_Beds.Bed_Status, Ward_Beds.Bed_id FROM            admin_Hospital_Wards INNER JOIN
                         Ward_Beds ON admin_Hospital_Wards.Ward_id = Ward_Beds.ward_Id
WHERE        (Ward_Beds.Bed_Status = 0)and (Ward_Beds.ward_Id = @ward_Id)">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DropDownListFloor" Name="ward_Id" PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSourceBedRoom" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                    SelectCommand="SELECT        Ward_Beds.ward_Id, Ward_Beds.Bed_No, Ward_Beds.Bed_Status, Ward_Beds.Bed_id FROM            admin_Hospital_Wards INNER JOIN
                         Ward_Beds ON admin_Hospital_Wards.Ward_id = Ward_Beds.ward_Id
WHERE        (Ward_Beds.Bed_Status = 0) AND (Ward_Beds.ward_Id = @ward_Id)">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DropDownListFloor" Name="ward_Id" PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSourceEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                    SelectCommand="SELECT EmpID, ISNULL(EFName, ' ') + ' ' + ISNULL(EMName, ' ') + ' ' + ISNULL(ELName, ' ') AS [Employee Name] FROM Employee WHERE (Emp_Type = 'Consultant') ORDER BY [Employee Name]">
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSource_Refernces" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                    SelectCommand="SELECT  Refferer_ID as EmpID, isnull(Referer_Name,'') as [Employee Name] &#13;&#10;FROM         Doctor_Referneces&#13;&#10;union&#13;&#10;SELECT EmpID, ISNULL(EFName, ' ') + ' ' + ISNULL(EMName, ' ') + ' ' + ISNULL(ELName, ' ') AS [Employee Name] FROM Employee WHERE (Emp_Type = 'Consultant') &#13;&#10;ORDER BY [Employee Name]">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                    </table>
                </asp:Panel></td>
  </tr>
</table>



 <asp:GridView ID="grdWardAdmission" runat ="server" AutoGenerateColumns="False" Width ="100%" 
            DataKeyNames="Admit_ID" DataSourceID="dsWardAdmission" AllowPaging="True" 
            onselectedindexchanged="grdWardAdmission_SelectedIndexChanged" >
        <Columns>
            <asp:BoundField DataField="ReferByName" HeaderText="Refer By" ReadOnly="True" 
                SortExpression="ReferByName" />
            <asp:BoundField DataField="Consultant" HeaderText="Consultant" ReadOnly="True" 
                SortExpression="Consultant" />
            <asp:BoundField DataField="ReferBy_Institute" HeaderText="Refer By Institute" 
                SortExpression="ReferBy_Institute" />
            <asp:BoundField DataField="Patient_Condition" HeaderText="Patient Condition" 
                SortExpression="Patient_Condition" />
            <asp:BoundField DataField="Admission_Type" HeaderText="Admission Type" 
                SortExpression="Admission_Type" />
            <asp:BoundField DataField="Activity_level" HeaderText="Activity Level" 
                SortExpression="Activity_level" />
            <asp:BoundField DataField="Admitted_Diagnosis" HeaderText="Admitted Diagnosis" 
                SortExpression="Admitted_Diagnosis" />
            <asp:BoundField DataField="SubDept_Name" HeaderText="Patient Dept." 
                SortExpression="SubDept_Name" />
            <asp:BoundField DataField="Arrival_Status_name" HeaderText="Arrival Status" 
                SortExpression="Arrival_Status_name" />
            <asp:BoundField DataField="Description" HeaderText="Description" 
                SortExpression="Description" />
            <asp:BoundField DataField="Admit_Date" HeaderText="On Date" 
                SortExpression="Admit_Date" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                        CommandName="Delete" 
                        onclientclick="return confirm('Record will Be Deleted Permanently')" 
                        Text="Delete"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ShowSelectButton="True" />
            <asp:HyperLinkField DataNavigateUrlFields="Admit_ID" DataNavigateUrlFormatString="Admission_Report.aspx?Admit_ID={0}"
                Target="_blank" Text="Report" />
        </Columns>
        </asp:GridView>
  
   
    
    <asp:Label ID="LabelFooter" runat="server" Text=""></asp:Label>   
 
    
    
</asp:Content>

