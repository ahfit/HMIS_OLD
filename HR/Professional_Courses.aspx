<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Professional_Courses, App_Web_ybbpntbq" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>


 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


<table width="100%" border="0" cellspacing="0" cellpadding="0" >
<tr>
<td class="leftnav" valign="top" >
<asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
<asp:Panel ID="Panel1" runat="server" Visible="False"></asp:Panel>
</td>
<td  style="width:auto;" valign="top" >
     
     
     



<div class="bxmain">
  <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
  <tr>
    <td width="40%" align="right">Professional Course :</td>
    <td width="60%">
      <asp:TextBox ID="TextBox_Professional_Course" runat="server" CssClass="input_txt"   ></asp:TextBox>
      <asp:Label ID="Label3" runat="server" ForeColor="Red" Text="*"></asp:Label>
      <asp:RequiredFieldValidator ID="RequiredFieldValidator_professional_course" runat="server"
          ControlToValidate="TextBox_Professional_Course" ErrorMessage="*"></asp:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td align="right">Institute Name :</td>
    <td>
      <asp:TextBox ID="TextBox_Institute" runat="server" CssClass="input_txt"  ></asp:TextBox>
      <asp:Label ID="Label1" runat="server" ForeColor="Red" Text="*"></asp:Label>
      <asp:RequiredFieldValidator ID="RequiredFieldValidator_institute" runat="server"
        ControlToValidate="TextBox_Institute" ErrorMessage="*"></asp:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td align="right">Awarding Body :</td>
    <td>
      <asp:TextBox ID="TextBox_Awarding_Body" runat="server" CssClass="input_txt"  ></asp:TextBox>
      <asp:Label ID="Label2" runat="server" ForeColor="Red" Text="*"></asp:Label>
      <asp:RequiredFieldValidator ID="RequiredFieldValidator_awarding_body" runat="server"
        ControlToValidate="TextBox_Awarding_Body" ErrorMessage="*"></asp:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td align="right">Duration :</td>
    <td>
      <asp:TextBox ID="TextBox_Duration" runat="server" CssClass="input_txt"  ></asp:TextBox>
      <asp:Label ID="Label4" runat="server" ForeColor="Red" Text="*"></asp:Label>
      <asp:RequiredFieldValidator ID="RequiredFieldValidator_duration" runat="server" ControlToValidate="TextBox_Duration"
        ErrorMessage="*"></asp:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td align="right">
     Passing Year :
    </td>
    <td>
      <asp:TextBox ID="TextBox_Passing_Year" runat="server" CssClass="input_txt"  ></asp:TextBox>
      <asp:Label ID="Label5" runat="server" ForeColor="Red" Text="*"></asp:Label>
      <asp:RequiredFieldValidator ID="RequiredFieldValidator_passing_year" runat="server" ControlToValidate="TextBox_Passing_Year"
        ErrorMessage="*"></asp:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td align="right">
     Attach :
    </td>
    <td>
      <asp:FileUpload ID="FileUpload1" runat="server" Height="20px"  />
    </td>
  </tr>
  <tr>
    <td align="right">Detail : </td>
    <td>
      <asp:TextBox ID="TextBox_Detail" runat="server" CssClass="input_txt"
                  Height="65px" TextMode="MultiLine" Width="300px" ></asp:TextBox>
    </td>
  </tr>
  <tr>
    <td align="right">&nbsp;</td>
    <td>
      <asp:Button CssClass="btn1" ID="Button_continue" runat="server" Text="Save" />      
    </td>
  </tr>
  </table>

 
 </div>

<br />
          <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
            DeleteCommand="DELETE FROM [Professional_Courses] WHERE [Employee_ID] = @Employee_ID AND [Professional_Course_ID] = @Professional_Course_ID"
            InsertCommand="INSERT INTO Professional_Courses(Employee_ID, Professional_Course, Institute, Awarding_Body, Duration, Passing_Year, Detail, Image_name, Image_URL) VALUES (@Employee_ID, @Professional_Course, @Institute, @Awarding_Body, @Duration, @Passing_Year, @Detail, @Image_name, @Image_URL)"
            SelectCommand="SELECT Employee_ID, Professional_Course_ID, Professional_Course, Institute, Awarding_Body, Duration, Passing_Year, Image_name, Image_URL FROM Professional_Courses WHERE (Employee_ID = @emp)"
            UpdateCommand="UPDATE [Professional_Courses] SET [Professional_Course] = @Professional_Course, [Institute] = @Institute, [Awarding_Body] = @Awarding_Body, [Duration] = @Duration, [Passing_Year] = @Passing_Year,[Detail]=@Detail WHERE [Employee_ID] = @Employee_ID AND [Professional_Course_ID] = @Professional_Course_ID">
            <DeleteParameters>
              <asp:Parameter Name="Employee_ID" Type="Int32" />
              <asp:Parameter Name="Professional_Course_ID" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
              <asp:Parameter Name="Professional_Course" Type="String" />
              <asp:Parameter Name="Institute" Type="String" />
              <asp:Parameter Name="Awarding_Body" Type="String" />
              <asp:Parameter Name="Duration" Type="String" />
              <asp:Parameter Name="Passing_Year" Type="String" />
                <asp:Parameter Name="Detail" />
              <asp:Parameter Name="Employee_ID" Type="Int32" />
              <asp:Parameter Name="Professional_Course_ID" Type="Int32" />
            </UpdateParameters>
            <SelectParameters>
              <asp:SessionParameter Name="emp" SessionField="Enter_emp_ID" />
            </SelectParameters>
            <InsertParameters>
              <asp:SessionParameter Name="Employee_ID" SessionField="Enter_emp_ID" Type="Int32" />
              <asp:ControlParameter ControlID="TextBox_Professional_Course" Name="Professional_Course"
                    PropertyName="Text" Type="String" />
              <asp:ControlParameter ControlID="TextBox_Institute" Name="Institute" PropertyName="Text"
                    Type="String" />
              <asp:ControlParameter ControlID="TextBox_Awarding_Body" Name="Awarding_Body" PropertyName="Text"
                    Type="String" />
              <asp:ControlParameter ControlID="TextBox_Duration" Name="Duration" PropertyName="Text"
                    Type="String" />
              <asp:ControlParameter ControlID="TextBox_Passing_Year" Name="Passing_Year" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_Detail" Name="Detail" PropertyName="Text" />
                <asp:ControlParameter ControlID="HiddenField_fileName" Name="Image_name" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_file_URL" Name="Image_URL" PropertyName="Value" />
            </InsertParameters>
          </asp:SqlDataSource>
          <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Employee_ID,Professional_Course_ID"
            DataSourceID="SqlDataSource1" Width="100%" CssClass="Grid_1">
            <columns>
            <asp:BoundField DataField="Professional_Course" HeaderText="Professional Course"
                    SortExpression="Professional_Course" >
                <ControlStyle CssClass="txt_inside" Width="75px" />
            </asp:BoundField>
            <asp:BoundField DataField="Institute" HeaderText="Institute" SortExpression="Institute" >
                <ControlStyle CssClass="txt_inside" />
            </asp:BoundField>
            <asp:BoundField DataField="Awarding_Body" HeaderText="Awarding Body" SortExpression="Awarding_Body" >
                <ControlStyle CssClass="txt_inside" Width="75px" />
            </asp:BoundField>
            <asp:BoundField DataField="Duration" HeaderText="Duration" SortExpression="Duration" >
                <ControlStyle CssClass="txt_inside" Width="35px" />
            </asp:BoundField>
            <asp:BoundField DataField="Passing_Year" HeaderText="Passing Year" SortExpression="Passing_Year" >
                <ControlStyle CssClass="txt_inside" Width="35px" />
            </asp:BoundField>
                <asp:HyperLinkField DataNavigateUrlFields="Image_URL" DataNavigateUrlFormatString="Documents/{0}"
                    DataTextField="Image_name" HeaderText="Images" Target="_blank" />
                <asp:HyperLinkField DataNavigateUrlFields="Employee_ID,Professional_Course_ID" DataNavigateUrlFormatString="~/HR/Professional_Courses_view.aspx?Employee_ID={0}&amp;Professional_Course_ID={1}"
                    Text="View Detail" />
            </columns>
             
            <AlternatingRowStyle CssClass="GridAltItem" />
          </asp:GridView><br />
                <asp:HiddenField ID="HiddenField_fileName" runat="server" />
                <asp:HiddenField ID="HiddenField_file_URL" runat="server" />
 
 </td>
</tr>
</table>
 
  </asp:Content>