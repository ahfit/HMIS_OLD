<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="For_LGH_Employee_edit, App_Web_ybbpntbq" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

 
 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script language="javascript">
function openthis(a)
{
 window.location=a;
 }
</script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False"
          CssClass="Grid_1" DataKeyNames="For_LGH_Employee" DataSourceID="SqlDataSource1"
        Width="100%">
          <Fields>
              <asp:TemplateField HeaderText="Date of Completion of Requirement" SortExpression="Date_of_Completion_of_Requirement">
                  <EditItemTemplate>
                      <asp:TextBox ID="TextBox1" runat="server" Text='<%# Eval("Date_of_Completion_of_Requirement", "{0}") %>'></asp:TextBox><br />
                  </EditItemTemplate>
                  <InsertItemTemplate>
                      <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Date_of_Completion_of_Requirement") %>'></asp:TextBox>
                  </InsertItemTemplate>
                  <ItemTemplate>
                      <asp:Label ID="Label1" runat="server" Text='<%# Bind("Date_of_Completion_of_Requirement") %>'></asp:Label>
                  </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Date of Commencement of Requirement" SortExpression="Date_of_Commencement_of_Requirement">
                  <EditItemTemplate>
                      <asp:TextBox ID="TextBox2" runat="server" Text='<%# Eval("Date_of_Commencement_of_Requirement", "{0}") %>'></asp:TextBox>
                  </EditItemTemplate>
                  <InsertItemTemplate>
                      <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Date_of_Commencement_of_Requirement") %>'></asp:TextBox>
                  </InsertItemTemplate>
                  <ItemTemplate>
                      <asp:Label ID="Label2" runat="server" Text='<%# Bind("Date_of_Commencement_of_Requirement") %>'></asp:Label>
                  </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Date of Joining Honorary Job in LGH" SortExpression="Date_of_Joining_Honorary_Job_in_LGH">
                  <EditItemTemplate>
                      <asp:TextBox ID="TextBox3" runat="server" Text='<%# Eval("Date_of_Joining_Honorary_Job_in_LGH", "{0}") %>'></asp:TextBox>
                  </EditItemTemplate>
                  <InsertItemTemplate>
                      <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Date_of_Joining_Honorary_Job_in_LGH") %>'></asp:TextBox>
                  </InsertItemTemplate>
                  <ItemTemplate>
                      <asp:Label ID="Label3" runat="server" Text='<%# Bind("Date_of_Joining_Honorary_Job_in_LGH") %>'></asp:Label>
                  </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Date of Joining Paid Job in LGH" SortExpression="Date_of_Joining_Paid_Job_in_LGH">
                  <EditItemTemplate>
                      <asp:TextBox ID="TextBox4" runat="server" Text='<%# Eval("Date_of_Joining_Paid_Job_in_LGH", "{0}") %>'></asp:TextBox>
                  </EditItemTemplate>
                  <InsertItemTemplate>
                      <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Date_of_Joining_Paid_Job_in_LGH") %>'></asp:TextBox>
                  </InsertItemTemplate>
                  <ItemTemplate>
                      <asp:Label ID="Label4" runat="server" Text='<%# Bind("Date_of_Joining_Paid_Job_in_LGH") %>'></asp:Label>
                  </ItemTemplate>
              </asp:TemplateField>
              <asp:BoundField DataField="CPSP_UHS_Registration_No" HeaderText="CPSP UHS Registration No"
                  SortExpression="CPSP_UHS_Registration_No" />
              <asp:BoundField DataField="Name_of_Supervisor" HeaderText="Name of Supervisor" SortExpression="Name_of_Supervisor" />
              <asp:BoundField DataField="Detail_of_Rotation_already_done" HeaderText="Detail of Rotation already done"
                  SortExpression="Detail_of_Rotation_already_done" />
              <asp:TemplateField HeaderText="Date of Passing Intermediate Module Examination" SortExpression="Date_of_Passing_Intermediate_Module_Examination">
                  <EditItemTemplate>
                      <asp:TextBox ID="TextBox5" runat="server" Text='<%# Eval("Date_of_Passing_Intermediate_Module_Examination", "{0}") %>'></asp:TextBox>
                  </EditItemTemplate>
                  <InsertItemTemplate>
                      <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("Date_of_Passing_Intermediate_Module_Examination") %>'></asp:TextBox>
                  </InsertItemTemplate>
                  <ItemTemplate>
                      <asp:Label ID="Label5" runat="server" Text='<%# Bind("Date_of_Passing_Intermediate_Module_Examination") %>'></asp:Label>
                  </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField>
                  <EditItemTemplate>
                      <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images/icon_ok.gif" />&nbsp;<asp:ImageButton
                          ID="ImageButton4" runat="server" CommandName="Cancel" ImageUrl="~/images/icon_err.gif" />
                  </EditItemTemplate>
                  <ItemTemplate>
                      <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/images/icon_edit.gif"
                          OnClientClick="return confirmation_edit(this)" />
                  </ItemTemplate>
              </asp:TemplateField>
          </Fields>
          <AlternatingRowStyle CssClass="GridAltItem" />
      </asp:DetailsView>


          <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
            DeleteCommand="DELETE FROM [For_LGH_Employee] WHERE [For_LGH_Employee] = @For_LGH_Employee"
            InsertCommand="INSERT INTO [For_LGH_Employee] ([Date_of_Completion_of_Requirement], [Date_of_Commencement_of_Requirement], [Date_of_Joining_Honorary_Job_in_LGH], [Date_of_Joining_Paid_Job_in_LGH], [CPSP_UHS_Registration_No], [Name_of_Supervisor], [Detail_of_Rotation_already_done], [Date_of_Passing_Intermediate_Module_Examination]) VALUES (@Date_of_Completion_of_Requirement, @Date_of_Commencement_of_Requirement, @Date_of_Joining_Honorary_Job_in_LGH, @Date_of_Joining_Paid_Job_in_LGH, @CPSP_UHS_Registration_No, @Name_of_Supervisor, @Detail_of_Rotation_already_done, @Date_of_Passing_Intermediate_Module_Examination)"
            SelectCommand="SELECT For_LGH_Employee, CONVERT (varchar, Date_of_Completion_of_Requirement, 103) AS Date_of_Completion_of_Requirement, CONVERT (varchar, Date_of_Commencement_of_Requirement, 103) AS Date_of_Commencement_of_Requirement, CONVERT (varchar, Date_of_Joining_Honorary_Job_in_LGH, 103) AS Date_of_Joining_Honorary_Job_in_LGH, CONVERT (varchar, Date_of_Joining_Paid_Job_in_LGH, 103) AS Date_of_Joining_Paid_Job_in_LGH, CPSP_UHS_Registration_No, Name_of_Supervisor, Detail_of_Rotation_already_done, CONVERT (varchar, Date_of_Passing_Intermediate_Module_Examination, 103) AS Date_of_Passing_Intermediate_Module_Examination FROM For_LGH_Employee WHERE (Employee_ID = @emp_ID)"
            UpdateCommand="UPDATE [For_LGH_Employee] SET [Date_of_Completion_of_Requirement] = @Date_of_Completion_of_Requirement, [Date_of_Commencement_of_Requirement] =@Date_of_Commencement_of_Requirement, [Date_of_Joining_Honorary_Job_in_LGH] = @Date_of_Joining_Honorary_Job_in_LGH, [Date_of_Joining_Paid_Job_in_LGH] = @Date_of_Joining_Paid_Job_in_LGH, [CPSP_UHS_Registration_No] = @CPSP_UHS_Registration_No, [Name_of_Supervisor] = @Name_of_Supervisor, [Detail_of_Rotation_already_done] = @Detail_of_Rotation_already_done, [Date_of_Passing_Intermediate_Module_Examination] =@Date_of_Passing_Intermediate_Module_Examination WHERE [For_LGH_Employee] = @For_LGH_Employee">
            <DeleteParameters>
                <asp:Parameter Name="For_LGH_Employee" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="HiddenField1" Name="Date_of_Completion_of_Requirement"
                    PropertyName="Value" Type="DateTime" />
                <asp:ControlParameter ControlID="HiddenField2" Name="Date_of_Commencement_of_Requirement"
                    PropertyName="Value" Type="DateTime" />
                <asp:ControlParameter ControlID="HiddenField3" Name="Date_of_Joining_Honorary_Job_in_LGH"
                    PropertyName="Value" Type="DateTime" />
                <asp:ControlParameter ControlID="HiddenField4" Name="Date_of_Joining_Paid_Job_in_LGH"
                    PropertyName="Value" Type="DateTime" />
                <asp:Parameter Name="CPSP_UHS_Registration_No" Type="String" />
                <asp:Parameter Name="Name_of_Supervisor" Type="String" />
                <asp:Parameter Name="Detail_of_Rotation_already_done" Type="String" />
                <asp:ControlParameter ControlID="HiddenField5" Name="Date_of_Passing_Intermediate_Module_Examination"
                    PropertyName="Value" Type="DateTime" />
                <asp:Parameter Name="For_LGH_Employee" Type="Int32" />
            </UpdateParameters>
            <InsertParameters>
                <asp:Parameter Name="Date_of_Completion_of_Requirement" Type="DateTime" />
                <asp:Parameter Name="Date_of_Commencement_of_Requirement" Type="DateTime" />
                <asp:Parameter Name="Date_of_Joining_Honorary_Job_in_LGH" Type="DateTime" />
                <asp:Parameter Name="Date_of_Joining_Paid_Job_in_LGH" Type="DateTime" />
                <asp:Parameter Name="CPSP_UHS_Registration_No" Type="String" />
                <asp:Parameter Name="Name_of_Supervisor" Type="String" />
                <asp:Parameter Name="Detail_of_Rotation_already_done" Type="String" />
                <asp:Parameter Name="Date_of_Passing_Intermediate_Module_Examination" Type="DateTime" />
            </InsertParameters>
              <SelectParameters>
                  <asp:SessionParameter Name="emp_ID" SessionField="emp_ID" />
              </SelectParameters>
          </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenField1" runat="server" />
                <asp:HiddenField ID="HiddenField2" runat="server" />
                <asp:HiddenField ID="HiddenField3" runat="server" />
                <asp:HiddenField ID="HiddenField4" runat="server" />
                <asp:HiddenField ID="HiddenField5" runat="server" />
          
          

          
          
          
          
          
 
  </asp:Content>