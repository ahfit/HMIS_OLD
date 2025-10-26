<%@ page language="VB" autoeventwireup="false" inherits="For_LGH_Employee, App_Web_ybbpntbq" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
<link href="images/employee.css" rel="stylesheet" type="text/css" />
<script language="javascript">
function openthis(a)
{
 window.location=a;
 }
</script>

</head>

<body>
<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_top.gif" width="1003" height="24" /></td>
  </tr>
  <tr>
    <td width="23" height="550" valign="top" class="left_border"><img src="images1/img_border_left.gif" width="23" height="15" /></td>
    <td width="957" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
        <td height="65" colspan="2" valign="top"><iframe 
      src="tabs.aspx" name="holder" width="957" marginwidth="0" height="97" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
      </tr>
      <tr>
        <td width="19" height="25" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td width="938" valign="middle" class="text_lables3">Professional Courses </td>
        </tr>
      <tr>
        <td height="462" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
          <!--DWLayoutTable-->
          <tr>
            <td width="20" rowspan="4" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td height="10" colspan="2" valign="top"><img src="images1/img_spacer2.gif" width="2" height="10" /></td>
                <td width="20" rowspan="4" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                </tr>
          <tr>
            <td width="188" rowspan="3" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <!--DWLayoutTable-->
              <tr>
                <td width="188" height="10"></td>
              </tr>
              <tr>
                <td height="30" align="center" valign="middle"><img src="images/img_menu_tab.gif" width="166" height="30" /></td>
              </tr>
              <tr>
                <td height="270" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <!--DWLayoutTable-->
                      <tr>
                        <td width="188" height="30" valign="middle" class="menu_up" onclick="openthis('Employee_Basic_info_edit.aspx')" onmouseover="this.className='menu_over'" onmouseout="this.className='menu_up'">Personal Information</td>
                      </tr>
                      <tr>
                        <td height="30" valign="middle" class="menu_up" onclick="openthis('Certification.aspx')" onmouseover="this.className='menu_over'" onmouseout="this.className='menu_up'">
                            Certifications/Diploma</td>
                      </tr>
                      <tr>
                        <td height="30" valign="middle" class="menu_over" onclick="openthis('Professional_Courses.aspx')" onmouseover="this.className='menu_over'" onmouseout="this.className='menu_over'">Professional Courses </td>
                      </tr>
                      <tr>
                        <td height="30" valign="middle" class="menu_up" onclick="openthis('Workshops_Seminar.aspx')" onmouseover="this.className='menu_over'" onmouseout="this.className='menu_up'">Workshops/Seminars</td>
                      </tr>
                      <tr>
                        <td height="30" valign="middle" class="menu_up" onclick="openthis('Education.aspx')" onmouseover="this.className='menu_over'" onmouseout="this.className='menu_up'">Education</td>
                      </tr>
                      <tr>
                        <td height="30" valign="middle" class="menu_up" onclick="openthis('skills.aspx')" onmouseover="this.className='menu_over'" onmouseout="this.className='menu_up'">Skills</td>
                      </tr>
                      <tr>
                        <td height="30" valign="middle" class="menu_up" onclick="openthis('Additional_Info.aspx')" onmouseover="this.className='menu_over'" onmouseout="this.className='menu_up'">Additional Info </td>
                      </tr>
                      <tr>
                        <td height="30" valign="middle" class="menu_up" onclick="openthis('Job_Experience.aspx')" onmouseover="this.className='menu_over'" onmouseout="this.className='menu_up'">Job Experience </td>
                      </tr>
                      <tr>
                        <td height="30" valign="middle" class="menu_up" onclick="openthis('Change_Password.aspx')" onmouseover="this.className='menu_over'" onmouseout="this.className='menu_up'">Change Password </td>
                      </tr>
                    
                                </table></td>
              </tr>
              <tr>
                <td height="208">&nbsp;</td>
              </tr>
              
            </table></td>
            <td width="729" height="10"></td>
          </tr>
          <tr>
            <td height="498" valign="top">   <fieldset class="fieldset2">
  <legend>Professional Courses</legend>
  <p>&nbsp; &nbsp;&nbsp;<table style="width: 714px">
          <tr>
              <td style="width: 100px; height: 21px">
                  <label class="label2" style="width: 27.41em">
                      Date of Commencement of Requirement :</label></td>
              <td style="width: 100px; height: 21px">
                  <igsch:WebDateChooser ID="WebDateChooser_D_of_comm_of_req" runat="server" NullDateLabel="">
                  </igsch:WebDateChooser>
              </td>
          </tr>
          <tr>
              <td style="width: 100px">
                  <label class="label2" style="width: 27.41em">
                      Date of Completion of Requirement :</label></td>
              <td style="width: 100px">
                  <igsch:WebDateChooser ID="WebDateChooser_D_of_comp_of_req" runat="server" NullDateLabel="">
                  </igsch:WebDateChooser>
              </td>
          </tr>
          <tr>
              <td style="width: 100px">
                  <label class="label2" style="width: 27.41em">
                      Date of Joining Honorary Job in LGH :</label></td>
              <td style="width: 100px">
                  <igsch:WebDateChooser ID="WebDateChooser_D_of_j_h_j_in_LGH" runat="server" NullDateLabel="">
                  </igsch:WebDateChooser>
              </td>
          </tr>
          <tr>
              <td style="width: 100px">
                  <label class="label2" style="width: 27.41em">
                      Date of Joining Paid Job in LGH :</label></td>
              <td style="width: 100px">
                  <igsch:WebDateChooser ID="WebDateChooser_d_of_j_p_j_in_LGH" runat="server" NullDateLabel="">
                  </igsch:WebDateChooser>
              </td>
          </tr>
          <tr>
              <td style="width: 100px">
                  <label class="label2" style="width: 27.41em">
                      CPSP / UHS Registration No. :</label></td>
              <td style="width: 100px">
                  <asp:TextBox ID="TextBox_CPSP_Number" runat="server"></asp:TextBox></td>
          </tr>
          <tr>
              <td style="width: 100px">
                  <label class="label2" style="width: 27.41em">
                      Name of Supervisor :</label></td>
              <td style="width: 100px">
                  <asp:TextBox ID="TextBox_name_of_Supervisor" runat="server"></asp:TextBox></td>
          </tr>
          <tr>
              <td style="width: 100px; height: 21px">
                  <label class="label2" style="width: 27.41em">
                      Detail of Rotation already done :</label></td>
              <td style="width: 100px; height: 21px">
                  <asp:TextBox ID="TextBox_detail_of_Rotation_a_D" runat="server"></asp:TextBox></td>
          </tr>
          <tr>
              <td style="width: 100px">
                  <label class="label2" style="width: 27.41em">
                      Date of Passing Intermediate Module Examination :</label></td>
              <td style="width: 100px">
                  <igsch:WebDateChooser ID="WebDateChooser_d_of_p_i_m_examination" runat="server" NullDateLabel="">
                  </igsch:WebDateChooser>
              </td>
          </tr>
      </table>
      &nbsp; &nbsp; &nbsp; &nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button CssClass="buttonSubmit" ID="Button_continue" runat="server" Text="Save" onmousedown="this.className='buttonSubmit'" onmouseover="this.className='buttonSubmitHovered'" onmouseout="this.className='buttonSubmit'" Width="65px"/>&nbsp;
  </p>
    &nbsp;
            </fieldset>
          <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
            DeleteCommand="DELETE FROM [For_LGH_Employee] WHERE [For_LGH_Employee] = @For_LGH_Employee"
            InsertCommand="INSERT INTO [For_LGH_Employee] ([Date_of_Completion_of_Requirement], [Date_of_Commencement_of_Requirement], [Date_of_Joining_Honorary_Job_in_LGH], [Date_of_Joining_Paid_Job_in_LGH], [CPSP_UHS_Registration_No], [Name_of_Supervisor], [Detail_of_Rotation_already_done], [Date_of_Passing_Intermediate_Module_Examination],[Employee_ID]) VALUES (@Date_of_Completion_of_Requirement, @Date_of_Commencement_of_Requirement, @Date_of_Joining_Honorary_Job_in_LGH, @Date_of_Joining_Paid_Job_in_LGH, @CPSP_UHS_Registration_No, @Name_of_Supervisor, @Detail_of_Rotation_already_done, @Date_of_Passing_Intermediate_Module_Examination,@Employee_ID)"
            SelectCommand="SELECT [For_LGH_Employee], [Date_of_Completion_of_Requirement], [Date_of_Commencement_of_Requirement], [Date_of_Joining_Honorary_Job_in_LGH], [Date_of_Joining_Paid_Job_in_LGH], [CPSP_UHS_Registration_No], [Name_of_Supervisor], [Detail_of_Rotation_already_done], [Date_of_Passing_Intermediate_Module_Examination] FROM [For_LGH_Employee]"
            UpdateCommand="UPDATE [For_LGH_Employee] SET [Date_of_Completion_of_Requirement] = @Date_of_Completion_of_Requirement, [Date_of_Commencement_of_Requirement] = @Date_of_Commencement_of_Requirement, [Date_of_Joining_Honorary_Job_in_LGH] = @Date_of_Joining_Honorary_Job_in_LGH, [Date_of_Joining_Paid_Job_in_LGH] = @Date_of_Joining_Paid_Job_in_LGH, [CPSP_UHS_Registration_No] = @CPSP_UHS_Registration_No, [Name_of_Supervisor] = @Name_of_Supervisor, [Detail_of_Rotation_already_done] = @Detail_of_Rotation_already_done, [Date_of_Passing_Intermediate_Module_Examination] = @Date_of_Passing_Intermediate_Module_Examination WHERE [For_LGH_Employee] = @For_LGH_Employee">
            <DeleteParameters>
                <asp:Parameter Name="For_LGH_Employee" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="Date_of_Completion_of_Requirement" Type="DateTime" />
                <asp:Parameter Name="Date_of_Commencement_of_Requirement" Type="DateTime" />
                <asp:Parameter Name="Date_of_Joining_Honorary_Job_in_LGH" Type="DateTime" />
                <asp:Parameter Name="Date_of_Joining_Paid_Job_in_LGH" Type="DateTime" />
                <asp:Parameter Name="CPSP_UHS_Registration_No" Type="String" />
                <asp:Parameter Name="Name_of_Supervisor" Type="String" />
                <asp:Parameter Name="Detail_of_Rotation_already_done" Type="String" />
                <asp:Parameter Name="Date_of_Passing_Intermediate_Module_Examination" Type="DateTime" />
                <asp:Parameter Name="For_LGH_Employee" Type="Int32" />
            </UpdateParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="HiddenField_D_of_comp_of_req" Name="Date_of_Completion_of_Requirement"
                    PropertyName="Value" Type="DateTime" />
                <asp:ControlParameter ControlID="HiddenField_D_of_comm_of_req" Name="Date_of_Commencement_of_Requirement"
                    PropertyName="Value" Type="DateTime" />
                <asp:ControlParameter ControlID="HiddenField_D_of_j_h_j_in_LGH" Name="Date_of_Joining_Honorary_Job_in_LGH"
                    PropertyName="Value" Type="DateTime" />
                <asp:ControlParameter ControlID="HiddenField_d_of_j_p_j_in_LGH" Name="Date_of_Joining_Paid_Job_in_LGH"
                    PropertyName="Value" Type="DateTime" />
                <asp:ControlParameter ControlID="TextBox_CPSP_Number" Name="CPSP_UHS_Registration_No"
                    PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="TextBox_name_of_Supervisor" Name="Name_of_Supervisor"
                    PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="TextBox_detail_of_Rotation_a_D" Name="Detail_of_Rotation_already_done"
                    PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="HiddenField_d_of_p_i_m_examination" Name="Date_of_Passing_Intermediate_Module_Examination"
                    PropertyName="Value" Type="DateTime" />
                <asp:SessionParameter Name="Employee_ID" SessionField="emp_ID" />
            </InsertParameters>
          </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenField_D_of_comm_of_req" runat="server" />
                <asp:HiddenField ID="HiddenField_D_of_comp_of_req" runat="server" />
                <asp:HiddenField ID="HiddenField_D_of_j_h_j_in_LGH" runat="server" />
                <asp:HiddenField ID="HiddenField_d_of_j_p_j_in_LGH" runat="server" />
                <asp:HiddenField ID="HiddenField_d_of_p_i_m_examination" runat="server" />
          </td>
          </tr>
          <tr>
            <td height="10"></td>
          </tr>
          
          
          
          

          
          
          
          
          

          
          
          <!--DWLayoutTable-->
          
          

          
          
          
          
          
          
          
          
          
          
          
          

          

          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          

          
          
          
          
          
          


          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          

          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          </table></td>
          </tr>
      

      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
    </table></td>
    <td width="33" valign="top" class="right_border" ><img src="images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_bottom.gif" width="1003" height="24" /></td>
  </tr>
  
  <tr>
    <td height="1"></td>
    <td></td>
    <td></td>
  </tr>
</table>
<script type="text/javascript" src="images1/flash_01.js"></script>
</form>
</body>
</html>