<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Job_Experience_view, App_Web_2qu1gl2y" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>


 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 <table width="100%" border="0" cellspacing="0" cellpadding="0" >
<tr>
<td class="leftnav" valign="top" >
<asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
<asp:Panel ID="Panel1" runat="server" Visible="False"></asp:Panel>
</td>
<td  style="width:auto;" valign="top" >
     
     


<asp:DetailsView
      ID="DetailsView1" runat="server" AutoGenerateRows="False" DataKeyNames="Job_Experience_ID"
      DataSourceID="SqlDataSource2" Width="100%" CssClass="Grid_1">
      <Fields>
          <asp:TemplateField HeaderText="Organization Name" SortExpression="Organization_Name">
              <EditItemTemplate>
                  <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Organization_Name") %>'></asp:TextBox>
              </EditItemTemplate>
              <InsertItemTemplate>
                  <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Organization_Name") %>'></asp:TextBox>
              </InsertItemTemplate>
              <ItemTemplate>
                  <asp:Label ID="Label1" runat="server" Text='<%# Bind("Organization_Name") %>'></asp:Label>
              </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Designation" SortExpression="Designation">
              <EditItemTemplate>
                  <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Designation") %>'></asp:TextBox>
              </EditItemTemplate>
              <InsertItemTemplate>
                  <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Designation") %>'></asp:TextBox>
              </InsertItemTemplate>
              <ItemTemplate>
                  <asp:Label ID="Label2" runat="server" Text='<%# Bind("Designation") %>'></asp:Label>
              </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="City" SortExpression="City">
              <EditItemTemplate>
                  <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("City") %>'></asp:TextBox>
              </EditItemTemplate>
              <InsertItemTemplate>
                  <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("City") %>'></asp:TextBox>
              </InsertItemTemplate>
              <ItemTemplate>
                  <asp:Label ID="Label3" runat="server" Text='<%# Bind("City") %>'></asp:Label>
              </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Country Name" SortExpression="Country_Name">
              <EditItemTemplate>
                  <asp:DropDownList ID="DropDownList_country" runat="server" DataSourceID="SqlDataSource_country"
                      DataTextField="CountryName" DataValueField="CountryCode" SelectedValue='<%# Bind("Country", "{0}") %>'
                      Width="142px">
                  </asp:DropDownList>
              </EditItemTemplate>
              <InsertItemTemplate>
                  <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Country_Name") %>'></asp:TextBox>
              </InsertItemTemplate>
              <ItemTemplate>
                  <asp:Label ID="Label4" runat="server" Text='<%# Bind("CountryName") %>'></asp:Label>
              </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Start Date" SortExpression="Start_Date">
              <EditItemTemplate>
                  <asp:TextBox ID="TextBox6" runat="server" Text='<%# Eval("Start_Date") %>'></asp:TextBox>
              </EditItemTemplate>
              <InsertItemTemplate>
                  <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("Start_Date") %>'></asp:TextBox>
              </InsertItemTemplate>
              <ItemTemplate>
                  <asp:Label ID="Label6" runat="server" Text='<%# Bind("Start_Date") %>'></asp:Label>
              </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Completion Date" SortExpression="Completion_Date">
              <EditItemTemplate>
                  <asp:TextBox ID="TextBox7" runat="server" Text='<%# Eval("Completion_Date") %>'></asp:TextBox>
              </EditItemTemplate>
              <InsertItemTemplate>
                  <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("Completion_Date") %>'></asp:TextBox>
              </InsertItemTemplate>
              <ItemTemplate>
                  <asp:Label ID="Label7" runat="server" Text='<%# Bind("Completion_Date") %>'></asp:Label>
              </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Responsibilities" SortExpression="Responsibilities">
              <EditItemTemplate>
                  <asp:TextBox ID="TextBox5" runat="server" Height="57px" Text='<%# Bind("Responsibilities") %>'
                      TextMode="MultiLine" Width="221px"></asp:TextBox>
              </EditItemTemplate>
              <InsertItemTemplate>
                  <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("Responsibilities") %>'></asp:TextBox>
              </InsertItemTemplate>
              <ItemTemplate>
                  <asp:Label ID="Label5" runat="server" Text='<%# Bind("Responsibilities") %>'></asp:Label>
              </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Telephone_Number" SortExpression="Telephone_Number">
              <EditItemTemplate>
                  <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Telephone_Number") %>'></asp:TextBox>
              </EditItemTemplate>
              <InsertItemTemplate>
                  <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("Telephone_Number") %>'></asp:TextBox>
              </InsertItemTemplate>
              <ItemTemplate>
                  <asp:Label ID="Label8" runat="server" Text='<%# Bind("Telephone_Number") %>'></asp:Label>
              </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Reason_for_Leaving" SortExpression="Reason_for_Leaving">
              <EditItemTemplate>
                  <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("Reason_for_Leaving") %>'></asp:TextBox>
              </EditItemTemplate>
              <InsertItemTemplate>
                  <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("Reason_for_Leaving") %>'></asp:TextBox>
              </InsertItemTemplate>
              <ItemTemplate>
                  <asp:Label ID="Label9" runat="server" Text='<%# Bind("Reason_for_Leaving") %>'></asp:Label>
              </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Detail" SortExpression="Detail">
              <EditItemTemplate>
                  <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("Detail") %>'></asp:TextBox>
              </EditItemTemplate>
              <InsertItemTemplate>
                  <asp:TextBox ID="TextBox10" runat="server" Text='<%# Bind("Detail") %>'></asp:TextBox>
              </InsertItemTemplate>
              <ItemTemplate>
                  <asp:Label ID="Label10" runat="server" Text='<%# Bind("Detail") %>'></asp:Label>
              </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField>
              <EditItemTemplate>
                  <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images/icon_ok.gif" />&nbsp;<asp:ImageButton
                      ID="ImageButton4" runat="server" CommandName="Cancel" ImageUrl="~/images/icon_err.gif" />
              </EditItemTemplate>
              <ItemTemplate>
                  <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/images/icon_edit.gif"
                      OnClientClick="return confirmation_edit(this)" />&nbsp;<asp:ImageButton ID="ImageButton2"
                          runat="server" CommandName="Delete" ImageUrl="~/images/icon_delete.gif" OnClientClick="return confirmation(this)" />
              </ItemTemplate>
          </asp:TemplateField>
      </Fields>
      <RowStyle CssClass="GridItem" />
      <AlternatingRowStyle CssClass="GridAltItem" />
  </asp:DetailsView>

<asp:HiddenField ID="HiddenField_Organization_Name"
          runat="server" />
      <asp:HiddenField ID="HiddenField_Designation" runat="server" />
      <asp:HiddenField ID="HiddenField_city" runat="server" />
      <asp:HiddenField ID="HiddenField_Country_Name" runat="server" />
      <asp:HiddenField ID="HiddenField_Responsibilities" runat="server" />

      <asp:HiddenField ID="HiddenField_fromDate" runat="server" />
      <asp:HiddenField ID="HiddenField_todate" runat="server" />
          <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
            DeleteCommand="DELETE FROM [Job_Experience] WHERE [Employee_ID] = @Employee_ID AND [Job_Experience_ID] = @Job_Experience_ID"
            InsertCommand="INSERT INTO [Job_Experience] ([Employee_ID], [Organization_Name], [Designation], [City], [Country], [Start_Date], [Completion_Date], [Responsibilities]) VALUES ( @Employee_ID,@Organization_Name, @Designation, @City, @Country, @Start_Date, @Completion_Date, @Responsibilities)"
            SelectCommand="SELECT Job_Experience.Employee_ID, Job_Experience.Job_Experience_ID, Job_Experience.Organization_Name, Job_Experience.Designation, Job_Experience.City, Country.CountryName, CONVERT (varchar, Job_Experience.Start_Date, 103) AS Start_Date, CONVERT (varchar, Job_Experience.Completion_Date, 103) AS Completion_Date, Job_Experience.Responsibilities, Job_Experience.Country, Job_Experience.Telephone_Number, Job_Experience.Reason_for_Leaving, Job_Experience.Detail FROM Job_Experience INNER JOIN Country ON Job_Experience.Country = Country.CountryCode WHERE (Job_Experience.Job_Experience_ID = @Job_Experience_ID) AND (Job_Experience.Employee_ID = @emp_ID)"
            UpdateCommand="UPDATE Job_Experience SET Organization_Name = @Organization_Name, Designation = @Designation, City = @City, Country = @Country, Responsibilities = @Responsibilities, Start_Date = @start_Date, Completion_Date = @Completion_Date, Telephone_Number = @Telephone_Number, Reason_for_Leaving = @Reason_for_Leaving, Detail = @Detail WHERE (Job_Experience_ID = @Job_Experience_ID)">
            <DeleteParameters>
              <asp:Parameter Name="Job_Experience_ID" Type="Int32" />
                <asp:SessionParameter Name="Employee_ID" SessionField="Enter_emp_ID" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="HiddenField_Organization_Name" Name="Organization_Name"
                    PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_Designation" Name="Designation" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_city" Name="City" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_Country_Name" Name="Country" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_Responsibilities" Name="Responsibilities"
                    PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_fromDate" Name="start_Date" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_todate" Name="Completion_Date" PropertyName="Value" />
                <asp:Parameter Name="Job_Experience_ID" />
                <asp:ControlParameter ControlID="HiddenField_tel_no" Name="Telephone_Number" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_reason_for_leaving" Name="Reason_for_Leaving"
                    PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_detail" Name="Detail" PropertyName="Value" />
            </UpdateParameters>
            <InsertParameters>
              <asp:SessionParameter Name="Employee_ID" SessionField="Enter_emp_ID" />
              <asp:ControlParameter ControlID="TextBox_organization_name" Name="Organization_Name"
                    PropertyName="Text" Type="String" />
              <asp:ControlParameter ControlID="TextBox_designation" Name="Designation" PropertyName="Text"
                    Type="String" />
              <asp:ControlParameter ControlID="TextBox_city" Name="City" PropertyName="Text" Type="String" />
              <asp:ControlParameter ControlID="DropDownList_country" Name="Country" PropertyName="SelectedValue"
                    Type="Int32" />
              <asp:ControlParameter ControlID="HiddenField_start_Date" Name="Start_Date" PropertyName="Value"
                    Type="DateTime" />
              <asp:ControlParameter ControlID="HiddenField_completion_Date" Name="Completion_Date"
                    PropertyName="Value" Type="DateTime" />
              <asp:ControlParameter ControlID="TextBox_Responsibilites" Name="Responsibilities"
                    PropertyName="Text" Type="String" />
            </InsertParameters>
              <SelectParameters>
                  <asp:QueryStringParameter Name="Job_Experience_ID" QueryStringField="Job_Experience_ID" />
                  <asp:SessionParameter Name="emp_ID" SessionField="Enter_emp_ID" />
              </SelectParameters>
          </asp:SqlDataSource>
      <asp:SqlDataSource ID="SqlDataSource_country" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
          SelectCommand="SELECT [CountryCode], [CountryName] FROM [Country]"></asp:SqlDataSource>
      <asp:HiddenField ID="HiddenField_detail" runat="server" />
      <asp:HiddenField ID="HiddenField_tel_no" runat="server" />
      <asp:HiddenField ID="HiddenField_reason_for_leaving" runat="server" />
     
</td>
</tr>
</table>
<br />
  </asp:Content>