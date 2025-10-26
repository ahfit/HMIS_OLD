<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="HR_emplyee_view_all, App_Web_2qu1gl2y" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.UltraWebChart.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebChart" TagPrefix="igchart" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


   <fieldset class="fset_1">
  <legend>Basic Information&nbsp;</legend></fieldset>
            
                <asp:DetailsView ID="DetailsView1" runat="server" CssClass="Grid_1"  
                    Width="100%" AutoGenerateRows="False" DataSourceID="SqlDataSource_Basic_Information">
                    <AlternatingRowStyle CssClass="GridAltItem" />
                    <Fields>
                        <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="True" SortExpression="Name" />
                        <asp:BoundField DataField="Relation Name" HeaderText="Relation Name" ReadOnly="True"
                            SortExpression="Relation Name" />
                        <asp:BoundField DataField="Date Of Birth" HeaderText="Date Of Birth" ReadOnly="True"
                            SortExpression="Date Of Birth" />
                        <asp:BoundField DataField="Place of birth" HeaderText="Place of birth" SortExpression="Place of birth" />
                        <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
                        <asp:BoundField DataField="Marital Status" HeaderText="Marital Status" SortExpression="Marital Status" />
                        <asp:BoundField DataField="Religion" HeaderText="Religion" SortExpression="Religion" />
                        <asp:BoundField DataField="Nationality" HeaderText="Nationality" SortExpression="Nationality" />
                        <asp:BoundField DataField="N.I.C No." HeaderText="N.I.C No." SortExpression="N.I.C No." />
                        <asp:BoundField DataField="Passport No." HeaderText="Passport No." SortExpression="Passport No." />
                        <asp:BoundField DataField="Medical Reg. No. (PMDC)" HeaderText="Medical Reg. No. (PMDC)"
                            SortExpression="Medical Reg. No. (PMDC)" />
                        <asp:BoundField DataField="Language Known" HeaderText="Language Known" SortExpression="Language Known" />
                        <asp:BoundField DataField="Domicile" HeaderText="Domicile" SortExpression="Domicile" />
                        <asp:BoundField DataField="Permanent Address" HeaderText="Permanent Address" SortExpression="Permanent Address" />
                        <asp:BoundField DataField="Tel" HeaderText="Tel" SortExpression="Tel" />
                        <asp:BoundField DataField="Present Address" HeaderText="Present Address" SortExpression="Present Address" />
                        <asp:BoundField DataField="Mobile" HeaderText="Mobile" SortExpression="Mobile" />
                        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                        <asp:BoundField DataField="District Name" HeaderText="District Name" SortExpression="District Name" />
                        <asp:BoundField DataField="Tehsil Name" HeaderText="Tehsil Name" SortExpression="Tehsil Name" />
                    </Fields>
                </asp:DetailsView>
                <asp:SqlDataSource ID="SqlDataSource_Basic_Information" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    SelectCommand="SELECT ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS Name, Employee.Relation + ' ' + ISNULL(Employee.RFName, '') + ' ' + ISNULL(Employee.RMName, '') + ' ' + ISNULL(Employee.RLName, '') AS [Relation Name], CONVERT (varchar, Employee.DateOfBirth, 103) AS [Date Of Birth], Employee.Place_of_birth AS [Place of birth], Gender.Gender, Employee.Marital_Status AS [Marital Status], Religion.Religion_name AS Religion, Nationality.Nationality_Name AS Nationality, Employee.CNIC AS [N.I.C No.], Employee.Passport_No AS [Passport No.], Employee.PMDC AS [Medical Reg. No. (PMDC)], Employee.Language_Known AS [Language Known], DISTRICT.DistrictName AS Domicile, Employee.HomeAdd AS [Permanent Address], Employee.OphoneNo AS Tel, Employee.Present_address AS [Present Address], Employee.Mobile_Number AS Mobile, Employee.email_address AS Email, DISTRICT_1.DistrictName AS [District Name], TEHSIL.TehsilName AS [Tehsil Name] FROM Employee LEFT OUTER JOIN TEHSIL ON Employee.tech_ID = TEHSIL.TehsilCode LEFT OUTER JOIN DISTRICT AS DISTRICT_1 ON Employee.dist_ID = DISTRICT_1.DistrictCode LEFT OUTER JOIN DISTRICT ON Employee.Domicile = DISTRICT.DistrictCode LEFT OUTER JOIN Nationality ON Employee.Nationality = Nationality.Nationality_ID LEFT OUTER JOIN Gender ON Employee.SexID = Gender.Gender_ID LEFT OUTER JOIN Religion ON Employee.Religion = Religion.Religion_ID&#13;&#10;where Employee.EmpID=@EmpID">
                    <SelectParameters>
                        <asp:SessionParameter Name="EmpID" SessionField="Enter_Emp_ID" />
                    </SelectParameters>
                </asp:SqlDataSource>
               
   <br>
<fieldset class="fset_1">
                    <legend>Education</legend></fieldset>
 
      <asp:SqlDataSource ID="SqlDataSource_insert_Education" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
          InsertCommand="insert_Education" InsertCommandType="StoredProcedure" SelectCommand="SELECT Employee_ID, Degree, Recognized_Institute, To_Date, number, total, Percentage, No_of_Attempts, Degree_Program_ID FROM Education WHERE (Employee_ID = @Employee_ID)"
          UpdateCommand="UPDATE Education SET  Degree =@Degree, Recognized_Institute =@Recognized_Institute, To_Date =@To_Date, number =@number, total =@total, Percentage =@Percentage, No_of_Attempts =@No_of_Attempts&#13;&#10;where Employee_ID =@Employee_ID and Degree_Program_ID =@Degree_Program_ID">
          <SelectParameters>
              <asp:SessionParameter Name="Employee_ID" SessionField="Enter_Emp_ID" />
          </SelectParameters>
          <InsertParameters>
              <asp:SessionParameter Name="Employee_ID" SessionField="enter_emp_ID" Type="Int32" />
              <asp:Parameter DefaultValue="Secondary School Certificate" Name="Degree" Type="String" />
              <asp:ControlParameter ControlID="TextBox_sec_date" Name="To_Date" PropertyName="Text"
                  Type="Int32" />
              <asp:ControlParameter ControlID="TextBox_sec_obt_marks" Name="number" PropertyName="Text"
                  Type="Int32" />
              <asp:ControlParameter ControlID="TextBox_total_sec" Name="total" PropertyName="Text"
                  Type="Int32" />
              <asp:ControlParameter ControlID="TextBox_sec_age" Name="Percentage" PropertyName="Text"
                  Type="String" />
              <asp:ControlParameter ControlID="DropDownList_att_sec" Name="No_of_Attempts" PropertyName="SelectedValue"
                  Type="Int32" />
              <asp:Parameter DefaultValue="Higher Secondary Certificate" Name="Degree1" Type="String" />
              <asp:ControlParameter ControlID="TextBox_high_date" Name="To_Date1" PropertyName="Text"
                  Type="Int32" />
              <asp:ControlParameter ControlID="TextBox_high_obt_" Name="number1" PropertyName="Text"
                  Type="Int32" />
              <asp:ControlParameter ControlID="TextBox_total_high" Name="total1" PropertyName="Text"
                  Type="Int32" />
              <asp:ControlParameter ControlID="TextBox_high_age" Name="Percentage1" PropertyName="Text"
                  Type="String" />
              <asp:ControlParameter ControlID="DropDownList_att_high" Name="No_of_Attempts1" PropertyName="SelectedValue"
                  Type="Int32" />
              <asp:Parameter DefaultValue="MBBS 1st Prof." Name="Degree2" Type="String" />
              <asp:ControlParameter ControlID="TextBox_mbbs_1_date" Name="To_Date2" PropertyName="Text"
                  Type="Int32" />
              <asp:ControlParameter ControlID="TextBox_obt_mbbs_1" Name="number2" PropertyName="Text"
                  Type="Int32" />
              <asp:ControlParameter ControlID="TextBox_total_mbbs_1" Name="total2" PropertyName="Text"
                  Type="Int32" />
              <asp:ControlParameter ControlID="TextBox_mbbs_age_1" Name="Percentage2" PropertyName="Text"
                  Type="String" />
              <asp:ControlParameter ControlID="DropDownList_att_mbbs_1" Name="No_of_Attempts2"
                  PropertyName="SelectedValue" Type="Int32" />
              <asp:Parameter DefaultValue="MBBS 2nd Prof." Name="Degree3" Type="String" />
              <asp:ControlParameter ControlID="TextBox_mbbs_2_date" Name="To_Date3" PropertyName="Text"
                  Type="Int32" />
              <asp:ControlParameter ControlID="TextBox_obt_mbbs_2" Name="number3" PropertyName="Text"
                  Type="Int32" />
              <asp:ControlParameter ControlID="TextBox_total_mbbs_2" Name="total3" PropertyName="Text"
                  Type="Int32" />
              <asp:ControlParameter ControlID="TextBox_mbbs_age_2" Name="Percentage3" PropertyName="Text"
                  Type="String" />
              <asp:ControlParameter ControlID="DropDownList_att_mbbs_2" Name="No_of_Attempts3"
                  PropertyName="SelectedValue" Type="Int32" />
              <asp:Parameter DefaultValue="MBBS 3rd Prof." Name="Degree4" Type="String" />
              <asp:ControlParameter ControlID="TextBox_mbbs_3_date" Name="To_Date4" PropertyName="Text"
                  Type="Int32" />
              <asp:ControlParameter ControlID="TextBox_obt_mbbs_3" Name="number4" PropertyName="Text"
                  Type="Int32" />
              <asp:ControlParameter ControlID="TextBox_total_mbbs_3" Name="total4" PropertyName="Text"
                  Type="Int32" />
              <asp:ControlParameter ControlID="TextBox_mbbs_age_3" Name="Percentage4" PropertyName="Text"
                  Type="String" />
              <asp:ControlParameter ControlID="DropDownList_att_mbbs_3" Name="No_of_Attempts4"
                  PropertyName="SelectedValue" Type="Int32" />
              <asp:Parameter DefaultValue="MBBS 4th Prof." Name="Degree5" Type="String" />
              <asp:ControlParameter ControlID="TextBox_mbbs_4_date" Name="To_Date5" PropertyName="Text"
                  Type="Int32" />
              <asp:ControlParameter ControlID="TextBox_obt_mbbs_4" Name="number5" PropertyName="Text"
                  Type="Int32" />
              <asp:ControlParameter ControlID="TextBox_total_mbbs_4" Name="total5" PropertyName="Text"
                  Type="Int32" />
              <asp:ControlParameter ControlID="TextBox_mbbs_age_4" Name="Percentage5" PropertyName="Text"
                  Type="String" />
              <asp:ControlParameter ControlID="DropDownList_att_mbbs_4" Name="No_of_Attempts5"
                  PropertyName="SelectedValue" Type="Int32" />
              <asp:ControlParameter ControlID="TextBox_sec_Institution" Name="Recognized_Institute"
                  PropertyName="Text" Type="String" />
              <asp:ControlParameter ControlID="TextBox_High_Institution" Name="Recognized_Institute1"
                  PropertyName="Text" Type="String" />
              <asp:ControlParameter ControlID="TextBox_mbbs_1_institute" Name="Recognized_Institute2"
                  PropertyName="Text" Type="String" />
              <asp:ControlParameter ControlID="TextBox_mbbs_2_institution" Name="Recognized_Institut3"
                  PropertyName="Text" Type="String" />
              <asp:ControlParameter ControlID="TextBox_mbbs_3_institution" Name="Recognized_Institute4"
                  PropertyName="Text" Type="String" />
              <asp:ControlParameter ControlID="TextBox_mbbs_4_institution" Name="Recognized_Institute5"
                  PropertyName="Text" Type="String" />
              <asp:Parameter DefaultValue="1" Name="Degree_Program_ID" Type="Int32" />
              <asp:Parameter DefaultValue="2" Name="Degree_Program_ID1" Type="Int32" />
              <asp:Parameter DefaultValue="5" Name="Degree_Program_ID2" Type="Int32" />
              <asp:Parameter DefaultValue="6" Name="Degree_Program_ID3" Type="Int32" />
              <asp:Parameter DefaultValue="7" Name="Degree_Program_ID4" Type="Int32" />
              <asp:Parameter DefaultValue="8" Name="Degree_Program_ID5" Type="Int32" />
          </InsertParameters>
          <UpdateParameters>
              <asp:Parameter Name="Degree" />
              <asp:Parameter Name="Recognized_Institute" />
              <asp:Parameter Name="To_Date" />
              <asp:Parameter Name="number" />
              <asp:Parameter Name="total" />
              <asp:Parameter Name="Percentage" />
              <asp:Parameter Name="No_of_Attempts" />
              <asp:Parameter Name="Employee_ID" />
              <asp:Parameter Name="Degree_Program_ID" />
          </UpdateParameters>
      </asp:SqlDataSource>
      <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
          DataKeyNames="Employee_ID,Degree_Program_ID" DataSourceID="SqlDataSource_insert_Education"
          Width="100%">
          <Columns>
              <asp:BoundField DataField="Degree" HeaderText="Degree" SortExpression="Degree" />
              <asp:BoundField DataField="Recognized_Institute" HeaderText="Recognized Institute"
                  SortExpression="Recognized_Institute" />
              <asp:BoundField DataField="To_Date" HeaderText="Date" SortExpression="To_Date" />
              <asp:BoundField DataField="number" HeaderText="Number" SortExpression="number" />
              <asp:BoundField DataField="total" HeaderText="Total" SortExpression="total" />
              <asp:BoundField DataField="Percentage" HeaderText="%age" SortExpression="Percentage" />
              <asp:BoundField DataField="No_of_Attempts" HeaderText="Attempts" SortExpression="No_of_Attempts" />
          </Columns>
          <AlternatingRowStyle CssClass="GridAltItem" />
      </asp:GridView>
       
 <fieldset class="fset_1">   <legend>Job Experience</legend></fieldset>
                  
                        <asp:SqlDataSource ID="SqlDataSource_Job_Experience" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
                            DeleteCommand="DELETE FROM [Job_Experience] WHERE [Employee_ID] = @Employee_ID AND [Job_Experience_ID] = @Job_Experience_ID"
                            InsertCommand="INSERT INTO Job_Experience(Employee_ID, Organization_Name, Designation, City, Country, Start_Date, Completion_Date, Responsibilities, Image_name, Image_URL, To_Date) VALUES (@Employee_ID, @Organization_Name, @Designation, @City, @Country, @Start_Date, @Completion_Date, @Responsibilities, @Image_name, @Image_URL, @To_Date)"
                            SelectCommand="SELECT Job_Experience.Employee_ID, Job_Experience.Job_Experience_ID, Job_Experience.Organization_Name, Job_Experience.Designation, Job_Experience.City, Country.CountryName, CONVERT (varchar, Job_Experience.Start_Date, 103) AS Start_Date, CONVERT (varchar, Job_Experience.Completion_Date, 103) AS Completion_Date, Job_Experience.Responsibilities, Job_Experience.Image_name, Job_Experience.Image_URL FROM Job_Experience INNER JOIN Country ON Job_Experience.Country = Country.CountryCode INNER JOIN Employee ON Job_Experience.Employee_ID = Employee.EmpID WHERE (Employee.EmpID = @Emp_ID)"
                            UpdateCommand="UPDATE [Job_Experience] SET [Organization_Name] = @Organization_Name, [Designation] = @Designation, [City] = @City, [Start_Date] = @Start_Date, [Completion_Date] = @Completion_Date, [Responsibilities] = @Responsibilities WHERE [Employee_ID] = @Employee_ID AND [Job_Experience_ID] = @Job_Experience_ID&#13;&#10;&#13;&#10;update Job_Experience&#13;&#10;set country = (select Country_ID from Country where Country_Name = @Country_Name and [Employee_ID] = @Employee_ID AND [Job_Experience_ID] = @Job_Experience_ID)&#13;&#10;">
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
                            <SelectParameters>
                                <asp:SessionParameter Name="Emp_ID" SessionField="Enter_emp_ID" />
                            </SelectParameters>
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
                            </InsertParameters>
                        </asp:SqlDataSource>
                        <asp:GridView ID="GridView_Job_Experience" runat="server" AutoGenerateColumns="False"
                            CssClass="Grid_1" DataKeyNames="Employee_ID,Job_Experience_ID" DataSourceID="SqlDataSource_Job_Experience"
                            Width="100%">
                            <Columns>
                                <asp:BoundField DataField="Organization_Name" HeaderText="Organization Name" SortExpression="Organization_Name">
                                    <ControlStyle CssClass="txt_inside" Width="50px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Designation" HeaderText="Designation" SortExpression="Designation">
                                    <ControlStyle CssClass="txt_inside" Width="50px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Start_Date" HeaderText="Start Date" SortExpression="Start_Date">
                                    <ControlStyle CssClass="txt_inside" Width="40px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Completion_Date" HeaderText="Completion Date" SortExpression="Completion_Date">
                                    <ControlStyle CssClass="txt_inside" Width="40px" />
                                </asp:BoundField>
                                <asp:HyperLinkField DataNavigateUrlFields="Image_URL" DataNavigateUrlFormatString="Documents/{0}"
                                    DataTextField="Image_name" HeaderText="Images" />
                                <asp:HyperLinkField DataNavigateUrlFields="employee_ID,Job_Experience_ID" DataNavigateUrlFormatString="~/HR/Job_Experience_view.aspx?employee_ID={0}&amp;Job_Experience_ID={1}"
                                    HeaderText="View Detail" Text="view Detail" />
                            </Columns>
                            <AlternatingRowStyle CssClass="GridAltItem" />
                        </asp:GridView>
                       
                 
                <fieldset class="fset_1">
                    <legend>Other Documents</legend>
                     
                        <asp:SqlDataSource ID="SqlDataSource_Other_Documents" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
                            DeleteCommand="DELETE FROM [Job_Experience] WHERE [Employee_ID] = @Employee_ID AND [Job_Experience_ID] = @Job_Experience_ID"
                            InsertCommand="INSERT INTO Job_Experience(Employee_ID, Organization_Name, Designation, City, Country, Start_Date, Completion_Date, Responsibilities, Image_name, Image_URL, To_Date) VALUES (@Employee_ID, @Organization_Name, @Designation, @City, @Country, @Start_Date, @Completion_Date, @Responsibilities, @Image_name, @Image_URL, @To_Date)"
                            SelectCommand="SELECT Job_Experience.Employee_ID, Job_Experience.Job_Experience_ID, Job_Experience.Organization_Name, Job_Experience.Designation, Job_Experience.City, Country.CountryName, CONVERT (varchar, Job_Experience.Start_Date, 103) AS Start_Date, CONVERT (varchar, Job_Experience.Completion_Date, 103) AS Completion_Date, Job_Experience.Responsibilities, Job_Experience.Image_name, Job_Experience.Image_URL FROM Job_Experience INNER JOIN Country ON Job_Experience.Country = Country.CountryCode INNER JOIN Employee ON Job_Experience.Employee_ID = Employee.EmpID WHERE (Employee.EmpID = @Emp_ID)"
                            UpdateCommand="UPDATE [Job_Experience] SET [Organization_Name] = @Organization_Name, [Designation] = @Designation, [City] = @City, [Start_Date] = @Start_Date, [Completion_Date] = @Completion_Date, [Responsibilities] = @Responsibilities WHERE [Employee_ID] = @Employee_ID AND [Job_Experience_ID] = @Job_Experience_ID&#13;&#10;&#13;&#10;update Job_Experience&#13;&#10;set country = (select Country_ID from Country where Country_Name = @Country_Name and [Employee_ID] = @Employee_ID AND [Job_Experience_ID] = @Job_Experience_ID)&#13;&#10;">
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
                            <SelectParameters>
                                <asp:SessionParameter Name="Emp_ID" SessionField="Enter_emp_ID" />
                            </SelectParameters>
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
                            </InsertParameters>
                        </asp:SqlDataSource>
                        <asp:GridView ID="GridView_Other_Documents" runat="server" AutoGenerateColumns="False"
                            CssClass="Grid_1" Width="100%">
                            <AlternatingRowStyle CssClass="GridAltItem" />
                        </asp:GridView>
                  <asp:LinkButton ID="LinkButton1" runat="server">LinkButton</asp:LinkButton>
                   
              
            
  </asp:Content>
  
  
  