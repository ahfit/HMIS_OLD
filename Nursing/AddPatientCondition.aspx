<%@ Page Language="VB" AutoEventWireup="false"   CodeFile="AddPatientCondition.aspx.vb"  MasterPageFile="~/hacims_masterpage.master" Inherits="Nursing_AddPatientCondition" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../css_hacims/ck.js" type="text/javascript"></script>
<script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript"></script>

  
    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   
<table width="100%" border="0" cellspacing="0" cellpadding="0" >
<tr>
<td class="leftnav" valign="top" >
<asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
<asp:Panel ID="Panel1" runat="server" Visible="False"></asp:Panel>
</td>
<td  style="width:auto;" valign="top" >
     
   
     
        <asp:DataList ID="DataList_PatientINfo" runat="server" DataSourceID="SqlDataSource_DataList" Visible="false" Width="100%"
            >
            <ItemTemplate>
                <asp:Label ID="PrefixLabel" runat="server" Text='<%# Eval("Prefix") %>' Visible="False"></asp:Label><asp:Label
                    ID="PFNameLabel" runat="server" Text='<%# Eval("PFName") %>' Visible="False"></asp:Label><asp:Label
                        ID="PMNameLabel" runat="server" Text='<%# Eval("PMName") %>' Visible="False"></asp:Label><asp:Label
                            ID="PLNameLabel" runat="server" Text='<%# Eval("PLName") %>' Visible="False"></asp:Label> 
                
                <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
                    <tr>
                        <td width="25%" >
                            <asp:Label ID="Label_Patient" runat="server"></asp:Label></td>
                        <td width="25%" align="right">
                            Date Of Birth :</td>
                        <td width="25%">
                    <asp:Label ID="DateOfBirthLabel" runat="server" Text='<%# Eval("DateOfBirth") %>'></asp:Label></td>
                        <td width="25%" align="right">
                            MRN :
                        </td>
                        <td width="25%">
                            <asp:Label ID="PayIDLabel" runat="server" Text='<%# Eval("PayID") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td >
                            <asp:Label ID="GenderAgeLabel" runat="server" Text='<%# Eval("GenderAge") %>'></asp:Label></td>
                        <td align="right" >
                            Patient Type :
                        </td>
                        <td >
                    <asp:Label ID="Patient_TypeLabel" runat="server" Text='<%# Eval("Patient_Type") %>'></asp:Label></td>
                        <td align="right" >
                            CNIC : 
                        </td>
                        <td >
                            <asp:Label ID="CNICLabel" runat="server" Text='<%# Eval("CNIC") %>'></asp:Label></td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList>
        <br />
       

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="45%" valign="top"> 
        <div class="bxmain inner_content" style="width:98%;">
        <h2><span>Serious Condition</span></h2>
<table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
            <tr>
                <td width="23%" align="right" >
                    Condition :</td>
                <td width="77%">
                  <asp:DropDownList ID="DropDownList_Condition" runat="server" Width="202px">
                        <asp:ListItem Value="1">Seriously ILL</asp:ListItem>
                        <asp:ListItem Value="2">Very Seriously ILL</asp:ListItem>
                    </asp:DropDownList>                </td>
            </tr>
            <tr>
                <td align="right" >
            Start Date :</td>
                <td>
                  <igsch:WebDateChooser ID="WebDateChooser_Start" runat="server" CssClass="drop_date" Width="202px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
              <td align="right"  >Start Time :</td>
              <td ><igtxt:WebDateTimeEdit ID="WebDateTimeEdit_Start" runat="server" DisplayModeFormat="t" CssClass="input_txt"
                        EditModeFormat="t">
                    </igtxt:WebDateTimeEdit></td>
            </tr>
            <tr>
                <td align="right"  >
          End Date :</td>
                <td >
                  <igsch:WebDateChooser ID="WebDateChooser_End" runat="server" CssClass="drop_date" Width="202px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
              <td align="right"  >End Time :</td>
              <td ><igtxt:WebDateTimeEdit ID="WebDateTimeEdit_End" runat="server" DisplayModeFormat="t" CssClass="input_txt"
                        EditModeFormat="t">
                    </igtxt:WebDateTimeEdit></td>
            </tr>
            <tr>
              <td align="right"  >Activity&nbsp; Level :</td>
              <td > <asp:DropDownList ID="DropDownList_Arrival_Status" runat="server" DataSourceID="SqlDataSource_Arrival_status"
                        DataTextField="Arrival_Status_name" DataValueField="Arrival_Status_ID" >
                    </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource_Arrival_status" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>" SelectCommand="SELECT [Arrival_Status_ID], [Arrival_Status_name] FROM [Arrival_Status]">
                    </asp:SqlDataSource></td>
            </tr>
            <tr>
                <td align="right"  >
        Doctor Informed :</td>
                <td >
                    <asp:DropDownList ID="DropDownList_Doctors" runat="server" Width="202px" DataSourceID="SqlDataSource_Consultant" DataTextField="EmpName" DataValueField="EmpID">
                    </asp:DropDownList>                </td>
            </tr>
    <tr>
        <td align="right" >
            Canulas :</td>
        <td>
            <asp:CheckBoxList ID="CheckBoxList_Canulas" runat="server" RepeatDirection="Horizontal">
                <asp:ListItem>Right Arm</asp:ListItem>
                <asp:ListItem>Left Arm</asp:ListItem>
                <asp:ListItem>Left Foot</asp:ListItem>
                <asp:ListItem>Right Foot</asp:ListItem>
                <asp:ListItem>Scalp</asp:ListItem>
            </asp:CheckBoxList></td>
    </tr>
            <tr>
              <td align="right" >Counseling :</td>
              <td><asp:TextBox ID="TextBox_Counseling" runat="server" Width="350px" Height="35px"></asp:TextBox></td>
            </tr>
            <tr>
                <td align="right" >
      Comments :</td>
                <td>
              <asp:TextBox ID="TextBox_Comments" runat="server" Height="55px" TextMode="MultiLine"
                        Width="350px"></asp:TextBox></td>
            </tr>
            <tr><TD></TD>
                <td align="LEFT">
                    <asp:Button ID="Button_Save" runat="server" Text="Save"  /></td>
            </tr>
</table></div></td>
    <td   valign="top">  <asp:GridView ID="GridView_Record" runat="server" Width="100%" AutoGenerateColumns="False" DataSourceID="SqlDataSource_Record" DataKeyNames="ID">
                        <Columns>
                            <asp:BoundField DataField="RegNo" HeaderText="RegNo" SortExpression="RegNo" ReadOnly="True" />
                            <asp:BoundField DataField="YearlyNo" HeaderText="YearlyNo" SortExpression="YearlyNo" ReadOnly="True" />
                            <asp:TemplateField HeaderText="FromDate" SortExpression="FromDate">
                                <EditItemTemplate>
                                    <igsch:WebDateChooser ID="WebDateChooser_FromDate" runat="server" Width="50px" CssClass="drop_date" Value='<%# Eval("FromDate") %>'>
                                        <CalendarLayout Culture="English (United Kingdom)">
                                        </CalendarLayout>
                                    </igsch:WebDateChooser>
                                    <igtxt:WebDateTimeEdit ID="WebDateTimeEdit_FromTime"   Width="50px"    runat="server" Value='<%# Eval("FromTime") %>' DisplayModeFormat="t"
                                        EditModeFormat="t"  >
                                    </igtxt:WebDateTimeEdit>
                                    <asp:HiddenField ID="HiddenField_FromDate" runat="server" Value='<%# Eval("FromDate") %>' />
                                <asp:HiddenField ID="HiddenField_ID" runat="server" Value='<%# Eval("ID") %>' />
                                </EditItemTemplate>
                                <ItemTemplate>
<asp:Label ID="Label_FromDte" runat="server" Text='<%# Eval("FromDateTime") %>'></asp:Label>
                                                                    </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ToDate" SortExpression="ToDate">
                                <EditItemTemplate>
<igsch:WebDateChooser ID="WebDateChooser_ToDate" CssClass="drop_date"  Width="50px"  runat="server" Value='<%# Eval("ToDate") %>'>
                                        <CalendarLayout Culture="English (United Kingdom)">
                                        </CalendarLayout>
                                    </igsch:WebDateChooser>
                                    <igtxt:WebDateTimeEdit ID="WebDateTimeEdit_ToDate"   Width="50px"   runat="server" Value='<%# Eval("ToTime") %>' DisplayModeFormat="t"
                                        EditModeFormat="t"  >
                                    </igtxt:WebDateTimeEdit>
                                    <asp:HiddenField ID="HiddenField_ToDate" runat="server" Value='<%# Eval("ToDate") %>' />
                                </EditItemTemplate>
                                <ItemTemplate>
                                <asp:Label ID="Label_ToDate" runat="server" Text='<%# Eval("ToDateTime") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Condition" SortExpression="Condition">
                                <EditItemTemplate>
<asp:DropDownList ID="DropDownList_Condition" runat="server"  Width="70px"  SelectedValue='<%# Eval("Condition_ID") %>'>
                                        <asp:ListItem Value="1" Selected="True">Seriously ILL</asp:ListItem>
                                        <asp:ListItem Value="2">Very Seriously ILL</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                               
                                  <asp:Label ID="Label_Condition" runat="server" Text='<%# Eval("Condition") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Doctor Informed" SortExpression="InformToDoctor">
                                <EditItemTemplate><asp:DropDownList ID="DropDownList_Doctor" runat="server" DataSourceID="SqlDataSource_Consultant"
                                        DataTextField="EmpName" DataValueField="EmpID" SelectedValue='<%# Eval("InformToDoctor") %>'
                                         Enabled="False">
                                </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSource_Consultant" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                        SelectCommand="SELECT Prefix + isnull(EFName,'') + ' ' + isnull(EMName,'') + ' ' + isnull(ELName,'') as EmpName , EmpID  FROM [Employee]">
                                    </asp:SqlDataSource>
                                </EditItemTemplate>
                                <ItemTemplate>
<asp:DropDownList ID="DropDownList_Doctor" runat="server" DataSourceID="SqlDataSource_Consultant"  Width="70px" 
                                        DataTextField="EmpName" DataValueField="EmpID" SelectedValue='<%# Eval("InformToDoctor") %>'
                                        Enabled="False">
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSource_Consultant" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                        SelectCommand="SELECT Prefix + isnull(EFName,'') + ' ' + isnull(EMName,'') + ' ' + isnull(ELName,'') as EmpName , EmpID  FROM [Employee]">
                                    </asp:SqlDataSource>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Counseling" SortExpression="Counseling">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox_Counseling" runat="server" Text='<%# Eval("Counseling") %>' Height="40px"  Enabled="False"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                <asp:Label ID="Label_Counseling" runat="server" Text='<%# Eval("Counseling") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Comments" SortExpression="Comments">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox_Comment" runat="server" Text='<%# Eval("Comments") %>' Height="40px" TextMode="MultiLine"  ></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                               
                                  <asp:Label ID="Label_Comment" runat="server" Text='<%# Eval("Comments") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Activity  Level" SortExpression="Arrival_Status_name">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList_Arrival_Status" runat="server" DataSourceID="SqlDataSource_Arrival_status"
                                        DataTextField="Arrival_Status_name" DataValueField="Arrival_Status_ID" SelectedValue='<%# Bind("Arrival_Status_ID", "{0}") %>'
                                        Width="100px">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Arrival_Status_name") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Canulas" HeaderText="Canulas" ReadOnly="True" SortExpression="Canulas" />
                            <asp:TemplateField ShowHeader="False">
                                <EditItemTemplate>
                                
                        <asp:ImageButton ID="ImageButton2" runat="server" CausesValidation="False" CommandName="update"
                                        ImageUrl="~/images_hacims/icon_ok.gif" Width="16px" Height="16px" />
                                    <asp:ImageButton ID="ImageButton3" runat="server" CausesValidation="False" CommandName="Cancel"
                                        ImageUrl="~/images_hacims/icon_err.gif" Width="14px" Height="15px" />
                                </EditItemTemplate>
                                <ItemTemplate>
                               <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/images_hacims/icon_edit.gif"
                                        OnClientClick="return confirmation_edit(this)" Width="16px" Height="16px" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView></td>
  </tr>
</table>




                <br />

                  
                    <asp:SqlDataSource ID="SqlDataSource_Record" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" SelectCommand="SELECT Patient_Condition_Type.ID, CONVERT (varchar, Patient_Condition_Type.FromDate, 103) + ' ' + CONVERT (varchar, Patient_Condition_Type.FromDate, 108) AS FromDateTime, CONVERT (varchar, Patient_Condition_Type.FromDate, 103) AS FromDate, CONVERT (varchar, Patient_Condition_Type.FromDate, 108) AS FromTime, CONVERT (varchar, Patient_Condition_Type.ToDate, 103) + ' ' + CONVERT (varchar, Patient_Condition_Type.ToDate, 108) AS ToDateTime, CONVERT (varchar, Patient_Condition_Type.ToDate, 108) AS ToTime, CONVERT (varchar, Patient_Condition_Type.ToDate, 103) AS ToDate, Patient_Condition_Type.Condition, Patient_Condition_Type.Condition_ID, Patient_Condition_Type.InformToDoctor, Patient_Condition_Type.Counseling, Patient_Condition_Type.Comments, Patient_Condition_Type.RegNo, Patient_Condition_Type.YearlyNo, Arrival_Status.Arrival_Status_ID, Arrival_Status.Arrival_Status_name, Patient_Condition_Type.Canulas FROM Patient_Condition_Type INNER JOIN Arrival_Status ON Patient_Condition_Type.Activity_Level_ID = Arrival_Status.Arrival_Status_ID WHERE (Patient_Condition_Type.RegNo = @regno) AND (Patient_Condition_Type.YearlyNo = @yearlyno) ORDER BY Patient_Condition_Type.ID" UpdateCommand="SELECT     FromDate, ToDate&#13;&#10;FROM         Patient_Condition_Type">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="HiddenField_RegNo" Name="regno" PropertyName="Value" />
                            <asp:ControlParameter ControlID="HiddenField_YearlyNo" Name="yearlyno" PropertyName="Value" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSource_Consultant" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="SELECT Prefix + isnull(EFName,'') + ' ' + isnull(EMName,'') + ' ' + isnull(ELName,'') as EmpName , EmpID  FROM [Employee]">
                    </asp:SqlDataSource>
               
        <br />
      
        <asp:HiddenField ID="HiddenField_RegNo" runat="server" />
        <asp:HiddenField ID="HiddenField_YearlyNo" runat="server" />
      
<asp:SqlDataSource ID="SqlDataSource_DataList" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
            SelectCommand="SELECT     Patient.RegNo, Patient.Prefix, Patient.PFName, Patient.PMName, Patient.PLName,Gender.Gender + ', ' + convert(varchar,Patient.Age)+' ' +Patient.AgeType as GenderAge, Payment.PayID, convert(varchar,Patient.DateOfBirth,109) as DateOfBirth,  &#13;&#10;                      Patient.CNIC, Patient.Patient_Type&#13;&#10;FROM         Patient INNER JOIN&#13;&#10;                      Gender ON Patient.SexID = Gender.Gender_ID INNER JOIN&#13;&#10;                      Payment ON Patient.RegNo = Payment.RegNo&#13;&#10;where (Patient.RegNo = @RegNo)">
            <SelectParameters>
                <asp:ControlParameter ControlID="HiddenField_RegNo" Name="RegNo" PropertyName="Value" />
            </SelectParameters>
        </asp:SqlDataSource>
     </td>
</tr>
</table>  
      
<asp:Label ID="LabelFooter" runat="server" Text=""></asp:Label> 
 </asp:Content>