<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="HR_Job_Call_Letter, App_Web_ah1wcbj4" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="Infragistics2.WebUI.WebSchedule.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="ig_sched" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="bxmain">
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td width="40%" align="right"> Candidate
    Name :&nbsp; </td>
    <td width="60%"> 
      <asp:TextBox ID="TextBox_Candidate_Name" runat="server"></asp:TextBox>
     </td>
  </tr>
  <tr>
    <td align="right"> Test Interview Date :&nbsp; </td>
    <td><igsch:webdatechooser id="WebDateChooser_test_date" runat="server"></igsch:webdatechooser></td>
  </tr>
  <tr>
    <td align="right"> 
      Start Time :&nbsp; 
     </td>
    <td> <igtxt:webdatetimeedit id="WebDateTimeEdit_test_start_time" runat="server" editmodeformat="t" DataMode="Text"></igtxt:webdatetimeedit></td>
  </tr>
  <tr>
    <td align="right"> 
      End Time :&nbsp; 
      
     </td>
    <td><igtxt:webdatetimeedit id="WebDateTimeEdit_test_end_time" runat="server" editmodeformat="t" DataMode="Text"></igtxt:webdatetimeedit></td>
  </tr>
  <tr>
    <td align="right"> Description :&nbsp; </td>
    <td> 
      <asp:TextBox ID="TextBox_description" runat="server" Height="57px" TextMode="MultiLine" Width="181px"></asp:TextBox>
   </td>
  </tr>
  <tr>
    <td align="right">&nbsp;</td>
    <td> 
      <asp:Button CssClass="btn1" ID="Button_Save" runat="server" Text="Save" />      
   </td>
  </tr>
 </table>
 </div>
 

<br />
              <asp:SqlDataSource ID="SqlDataSource_job_test_call" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
            DeleteCommand="DELETE FROM [Job_Test_Call] WHERE [job_interview_call] = @job_interview_call" InsertCommand="INSERT INTO [Job_Test_Call] ([Job_Request_ID], [name], [test_date], [test_start_time], [test_end_time], [description]) VALUES (@Job_Request_ID, @name, @test_date, @test_start_time, @test_end_time, @description)"
            SelectCommand="SELECT job_interview_call, Job_Request_ID, name, test_date, test_start_time, test_end_time, description FROM Job_Test_Call"
            UpdateCommand="UPDATE [Job_Test_Call] SET [Job_Request_ID] = @Job_Request_ID, [name] = @name, [test_date] = @test_date, [test_start_time] = @test_start_time, [test_end_time] = @test_end_time, [description] = @description WHERE [job_interview_call] = @job_interview_call">
                <DeleteParameters>
                    <asp:Parameter Name="job_interview_call" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Job_Request_ID" Type="Int32" />
                    <asp:Parameter Name="name" Type="String" />
                    <asp:Parameter Name="test_date" Type="DateTime" />
                    <asp:Parameter Name="test_start_time" Type="String" />
                    <asp:Parameter Name="test_end_time" Type="String" />
                    <asp:Parameter Name="description" Type="String" />
                    <asp:Parameter Name="job_interview_call" Type="Int32" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="HiddenField_request_ID" Name="Job_Request_ID" PropertyName="Value"
                        Type="Int32" />
                    <asp:ControlParameter ControlID="TextBox_Candidate_Name" Name="name" PropertyName="Text"
                        Type="String" />
                    <asp:ControlParameter ControlID="HiddenField_test_date" Name="test_date" PropertyName="Value"
                        Type="DateTime" />
                    <asp:ControlParameter ControlID="HiddenField_start_Date" Name="test_start_time" PropertyName="Value"
                        Type="String" />
                    <asp:ControlParameter ControlID="HiddenField_end_date" Name="test_end_time" PropertyName="Value"
                        Type="String" />
                    <asp:ControlParameter ControlID="TextBox_description" Name="description" PropertyName="Text"
                        Type="String" />
                </InsertParameters>
              </asp:SqlDataSource>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="job_interview_call"
                    DataSourceID="SqlDataSource_job_test_call" Width="100%" CssClass="Grid_1">
                    <Columns>
                        <asp:BoundField DataField="name" HeaderText="Candidate Name" SortExpression="name" />
                        <asp:BoundField DataField="test_date" HeaderText="Date" SortExpression="test_date" />
                        <asp:BoundField DataField="test_start_time" HeaderText="Start Time" SortExpression="test_start_time" />
                        <asp:BoundField DataField="test_end_time" HeaderText="End Time" SortExpression="test_end_time" />
                        <asp:BoundField DataField="description" HeaderText="Description" SortExpression="description" />
                        <asp:TemplateField>
                            <EditItemTemplate>
                                <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images/icon_ok.gif" />&nbsp;<asp:ImageButton
                                    ID="ImageButton4" runat="server" CommandName="Cancel" ImageUrl="~/images/icon_err.gif" />
                            </EditItemTemplate>
                            <ItemTemplate>
                                &nbsp;<asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/images/icon_edit.gif"
                                    OnClientClick="return confirmation_edit(this)" />&nbsp;<asp:ImageButton ID="ImageButton2"
                                        runat="server" CommandName="Delete" ImageUrl="~/images/icon_delete.gif" OnClientClick="return confirmation(this)" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
<br />
    <asp:HiddenField ID="HiddenField_test_date" runat="server" />
    <asp:HiddenField ID="HiddenField_start_Date" runat="server" />
    <asp:HiddenField ID="HiddenField_end_date" runat="server" />
    <asp:HiddenField ID="HiddenField_request_ID" runat="server" />

  </asp:Content>