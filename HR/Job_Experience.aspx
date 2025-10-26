<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Job_Experience, App_Web_ah1wcbj4" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<table width="100%" border="0" cellspacing="0" cellpadding="0" >
<tr>
<td class="leftnav" valign="top" >
<asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
 
</td>
<td  style="width:auto;" valign="top" >
     
     
     

 
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td width="40%" align="right">Organization Name :</td>
    <td width="60%">
      <asp:TextBox ID="TextBox_organization_name" runat="server" CssClass="input_txt"  Width="248px" ></asp:TextBox>
      <asp:Label ID="Label13" runat="server" CssClass="red"  Text="*"></asp:Label>
      <asp:RequiredFieldValidator ID="RequiredFieldValidator_org_name" runat="server"  CssClass="red"  ControlToValidate="TextBox_organization_name"
          ErrorMessage="*"></asp:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td align="right">Designation :</td>
    <td>
      <asp:TextBox ID="TextBox_designation" runat="server" CssClass="input_txt" Width="248px" ></asp:TextBox>
      <asp:Label ID="Label1" runat="server" CssClass="red"  Text="*"></asp:Label>
      <asp:RequiredFieldValidator ID="RequiredFieldValidator_desig" runat="server" CssClass="red" ControlToValidate="TextBox_designation"
        ErrorMessage="*"></asp:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td align="right">City :</td>
    <td>
      <asp:TextBox ID="TextBox_city" runat="server" CssClass="input_txt"  Width="248px" ></asp:TextBox>
      <asp:Label ID="Label2" runat="server" CssClass="red"  Text="*"></asp:Label>
      <asp:RequiredFieldValidator ID="RequiredFieldValidator_city" runat="server"  CssClass="red"  ControlToValidate="TextBox_city" ErrorMessage="*"></asp:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td align="right"> Telephone Number :</td>
    <td>
      <asp:TextBox ID="TextBox_tel_no" runat="server"    Width="248px" ></asp:TextBox>
&nbsp; </td>
  </tr>
  <tr>
    <td align="right"> Reason for Leaving :</td>
    <td>
      <asp:TextBox ID="TextBox_reason_for_leaving" runat="server"    Width="248px" ></asp:TextBox>
    </td>
  </tr>
  <tr>
    <td align="right">Country :</td>
    <td>
      <asp:DropDownList ID="DropDownList_country" runat="server" DataSourceID="SqlDataSource1"
                        DataTextField="CountryName" DataValueField="CountryCode" Width="250px"  > </asp:DropDownList>
    </td>
  </tr>
  <tr>
    <td align="right">Start Date :</td>
    <td>
      <asp:HiddenField ID="HiddenField_start_Date" runat="server" />
    </td>
  </tr>
  <tr>
    <td align="right">Status : </td>
    <td>
      <asp:RadioButtonList ID="RadioButtonList1" runat="server"  RepeatLayout="flow"  RepeatDirection="Horizontal" AutoPostBack="True">
        <asp:ListItem>Completion</asp:ListItem>
        <asp:ListItem>To Date</asp:ListItem>
      </asp:RadioButtonList>
    </td>
  </tr>
  <tr>
    <td align="right">Attach : </td>
    <td><asp:Panel ID="Panel1" runat="server" Visible="False"><igsch:webdatechooser id="WebDateChooser_completion_Date" runat="server" Width="250px" NullDateLabel="1/1/1980" Value="1980-01-01"></igsch:webdatechooser>
      <asp:FileUpload ID="FileUpload1" runat="server" Height="20px" Width="248px" />
      <asp:HiddenField ID="HiddenField_completion_Date" runat="server" />
      </asp:Panel></td>
  </tr>
  <tr>
    <td align="right">Responsibilities :</td>
    <td>
      <asp:TextBox ID="TextBox_Responsibilites" runat="server" CssClass="input_txt"  Width="248px" Height="68px" TextMode="MultiLine"></asp:TextBox>
      <asp:Label ID="Label3" runat="server" CssClass="red"  Text="*"></asp:Label>
      <asp:RequiredFieldValidator ID="RequiredFieldValidator_responsibilities" runat="server"
          ControlToValidate="TextBox_Responsibilites" ErrorMessage="*"  CssClass="red" ></asp:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td align="right"> Detail :</td>
    <td>
      <asp:TextBox ID="TextBox_Detail" runat="server" CssClass="input_txt"  Width="248px" Height="68px" TextMode="MultiLine"></asp:TextBox>
      <asp:Label ID="Label5" runat="server" CssClass="red"  Text="*"></asp:Label>
      <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
          ControlToValidate="TextBox_Responsibilites"  CssClass="red"  ErrorMessage="*"></asp:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td align="right">&nbsp;</td>
    <td>
    <asp:Button CssClass="btn1" ID="Button_continue" runat="server" Text="Save" />    
    &nbsp;
    <asp:Label ID="Label4" runat="server" CssClass="err" Text="Start Date is Less Than Completion Date" Visible="False"></asp:Label>
    </td>
  </tr>
</table>


 <br>

<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
            SelectCommand="SELECT [CountryCode], [CountryName] FROM [Country]"></asp:SqlDataSource>
          <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
            DeleteCommand="DELETE FROM [Job_Experience] WHERE [Employee_ID] = @Employee_ID AND [Job_Experience_ID] = @Job_Experience_ID"
            InsertCommand="INSERT INTO Job_Experience(Employee_ID, Organization_Name, Designation, City, Country, Start_Date, Completion_Date, Responsibilities, Image_name, Image_URL, To_Date, Detail, Reason_for_Leaving, Telephone_Number) VALUES (@Employee_ID, @Organization_Name, @Designation, @City, @Country, @Start_Date, @Completion_Date, @Responsibilities, @Image_name, @Image_URL, @To_Date, @Detail, @Reason_for_Leaving, @Telephone_Number)"
            SelectCommand="SELECT Job_Experience.Employee_ID, Job_Experience.Job_Experience_ID, Job_Experience.Organization_Name, Job_Experience.Designation, Job_Experience.City, Country.CountryName, CONVERT (varchar, Job_Experience.Start_Date, 103) AS Start_Date, CONVERT (varchar, Job_Experience.Completion_Date, 103) AS Completion_Date, Job_Experience.Responsibilities, Job_Experience.Image_name, Job_Experience.Image_URL FROM Job_Experience INNER JOIN Country ON Job_Experience.Country = Country.CountryCode INNER JOIN Employee ON Job_Experience.Employee_ID = Employee.EmpID WHERE (Employee.EmpID = @Emp_ID)"
            UpdateCommand="UPDATE [Job_Experience] SET [Organization_Name] = @Organization_Name, [Designation] = @Designation, [City] = @City, [Start_Date] = @Start_Date, [Completion_Date] = @Completion_Date, [Responsibilities] = @Responsibilities WHERE [Employee_ID] = @Employee_ID AND [Job_Experience_ID] = @Job_Experience_ID

update Job_Experience
set country = (select Country_ID from Country where Country_Name = @Country_Name and [Employee_ID] = @Employee_ID AND [Job_Experience_ID] = @Job_Experience_ID)
">
            <DeleteParameters>
              <asp:Parameter Name="Employee_ID" Type="Int32" />
              <asp:Parameter Name="Job_Experience_ID" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
              <asp:Parameter Name="Organization_Name" />
              <asp:Parameter Name="Designation" />
              <asp:Parameter Name="City" />
              <asp:Parameter Name="Start_Date" />
              <asp:Parameter Name="Completion_Date" />
              <asp:Parameter Name="Responsibilities" />
              <asp:Parameter Name="Employee_ID" />
              <asp:Parameter Name="Job_Experience_ID" />
              <asp:Parameter Name="Country_Name" />
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
                <asp:ControlParameter ControlID="HiddenField_fileName" Name="Image_name" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_file_URL" Name="Image_URL" PropertyName="Value" />
                <asp:ControlParameter ControlID="RadioButtonList1" Name="To_Date" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="TextBox_Detail" Name="Detail" PropertyName="Text" />
                <asp:ControlParameter ControlID="TextBox_reason_for_leaving" Name="Reason_for_Leaving"
                    PropertyName="Text" />
                <asp:ControlParameter ControlID="TextBox_tel_no" Name="Telephone_Number" PropertyName="Text" />
            </InsertParameters>
              <SelectParameters>
                  <asp:SessionParameter Name="Emp_ID" SessionField="Enter_emp_ID" />
              </SelectParameters>
          </asp:SqlDataSource>
          <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Employee_ID,Job_Experience_ID"
            DataSourceID="SqlDataSource2" Width="100%" CssClass="Grid_1">
            <Columns>
            <asp:BoundField DataField="Organization_Name" HeaderText="Organization Name" SortExpression="Organization_Name" >
                <ControlStyle CssClass="txt_inside" Width="50px" />
            </asp:BoundField>
            <asp:BoundField DataField="Designation" HeaderText="Designation" SortExpression="Designation" >
                <ControlStyle CssClass="txt_inside" Width="50px" />
            </asp:BoundField>
            <asp:BoundField DataField="Start_Date" HeaderText="Start Date" SortExpression="Start_Date" >
                <ControlStyle CssClass="txt_inside" Width="40px" />
            </asp:BoundField>
            <asp:BoundField DataField="Completion_Date" HeaderText="Completion Date" SortExpression="Completion_Date" >
                <ControlStyle CssClass="txt_inside" Width="40px" />
            </asp:BoundField>
                <asp:HyperLinkField DataNavigateUrlFields="Image_URL" DataNavigateUrlFormatString="Documents/{0}"
                    DataTextField="Image_name" HeaderText="Images" />
                <asp:HyperLinkField DataNavigateUrlFields="employee_ID,Job_Experience_ID" DataNavigateUrlFormatString="~/HR/Job_Experience_view.aspx?employee_ID={0}&amp;Job_Experience_ID={1}"
                    HeaderText="View Detail" Text="view Detail" />
            </Columns>
             
            
              <AlternatingRowStyle CssClass="GridAltItem" />
          </asp:GridView>
                <asp:HiddenField ID="HiddenField_fileName" runat="server" />
                <asp:HiddenField ID="HiddenField_file_URL" runat="server" />
</td>
</tr>
</table>
  </asp:Content>