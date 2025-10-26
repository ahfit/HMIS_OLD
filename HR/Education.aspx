<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Education, App_Web_2qu1gl2y" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

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
     
     
<div class="bxmain" style="padding: 17px; width: 65%;">

<div>

<asp:FormView ID="FormView1" runat="server" DataKeyNames="EmpID" DataSourceID="dsEmployeeInfo"
                    HorizontalAlign="Left" Width="100%">
                    <ItemTemplate>
                    
                  <asp:Image ID="Image2" runat="server" Style="position:absolute; margin-left:25px; margin-top:60px;" 
                                            ImageUrl=' <%# Convert.ToString("~/DisplayPic.ashx?Emp_Id=") + Convert.ToString(Eval("EmpID")) %>' 
                                            Width="77px" Height="90px" />  
                    
                        <div class="bxinset radius4">
                          <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
     
    <td valign="top">  
    
 <ul class="empinfo">
 <li class="name" style="display:inline;">  <asp:Label ID="Label_EmpName" runat="server"    Text='<%# Eval("[Employee Name]") %>'   ToolTip="Employee Name"></asp:Label></li> <span class="splt">|</span> 
<li style="display:inline;"><asp:Label ID="Designation_NameLabel" runat="server" style="color:#c60c0c; font-weight:bold;"  Text='<%# Bind("Designation_Name") %>'></asp:Label> <asp:Label ID="Designation_NameLabel0" Visible="false" runat="server"  Text='<%# Convert.ToString("( ")+ Convert.ToString(Eval("SubDept_Name"))+Convert.ToString(" )") %>'></asp:Label></li><span class="splt">|</span>
<li class="div" style="display:inline;"><asp:Label ID="Designation_NameLabel1" runat="server" Text='<%# Eval("Dept_Name") %>'  ></asp:Label></li><span class="splt">|</span> 
<li style="display:inline;"> Emp #  <strong><asp:Label ID="RegistrationNo" runat="server" Text='<%# Eval("EmpNo") %>'  ToolTip="Patient Registration Number"></asp:Label></strong>
<span class="spl">|</span>
Join Date : <strong><asp:Label ID="Label_JoinDate" runat="server" Text='<%# Bind("JoinDate") %>' ToolTip="Patient Age"></asp:Label></strong>
<span class="spl">|</span>
 <strong><asp:Label ID="Label_CNIC" runat="server"  Visible="false"  Text='<%# Eval("CNIC") %>' ToolTip="Identity Card #"></asp:Label></strong>
 
<strong><asp:Label ID="LabelGender" Visible="false" runat="server"  Text='<%# Eval("Gender") %>' ToolTip="Patient Gender"></asp:Label></strong>
  </li></ul>                                     


</td>
  </tr>
</table>
</div>
                        
                    </ItemTemplate>
                </asp:FormView>
                
                
                <asp:SqlDataSource ID="dsEmployeeInfo" runat="server" 
            ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" 
            SelectCommand="Emp_BioData" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <%--<asp:ControlParameter ControlID="HiddenField_Emp_ID" DefaultValue="0" 
                    Name="EmpID" PropertyName="Value" />--%>
                <asp:QueryStringParameter Name="EmpID" DefaultValue="0" QueryStringField="Emp_Id" />
            </SelectParameters>
        </asp:SqlDataSource>

</div>


</div>

<div class="bxmain">





<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td width="40%" align="right">Qualification :</td>
    <td width="60%"><asp:DropDownList ID="DropDownList_Qualification" runat="server"
            AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="Qualification_name"
            DataValueField="Qualification_ID" > </asp:DropDownList>
      <asp:Label ID="Label13" runat="server" ForeColor="Red" Text="*"></asp:Label>
      <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="Add_DegreeProgram.aspx">Add Qualification & Degree</asp:HyperLink></td>
  </tr>
  <tr>
    <td align="right">Degree Program :</td>
    <td><asp:DropDownList ID="DropDownList_Degree_Program"
        runat="server"  DataSourceID="SqlDataSource3" DataTextField="Degree_Program_Name" DataValueField="Degree_Program_ID"> </asp:DropDownList>
      <asp:Label ID="Label1" runat="server" ForeColor="Red" Text="*"></asp:Label></td>
  </tr>
  <tr>
    <td align="right">Majors :</td>
    <td><asp:TextBox ID="TextBox_majors" runat="server"     ></asp:TextBox>
      <asp:Label ID="Label2" runat="server" ForeColor="Red" Text="*"></asp:Label>
      <asp:RequiredFieldValidator ID="RequiredFieldValidator_major" runat="server" ControlToValidate="TextBox_majors"
        ErrorMessage="*"></asp:RequiredFieldValidator></td>
  </tr>
  <tr>
    <td align="right">Institute  Name :</td>
    <td><asp:TextBox ID="TextBox_Institute" runat="server"     ></asp:TextBox> <asp:RequiredFieldValidator ID="RequiredFieldValidator_institute" runat="server"
        ControlToValidate="TextBox_Institute" ErrorMessage="*"></asp:RequiredFieldValidator></td>
  </tr>
    <tr>
        <td align="right" style="height: 18px">
            From Date :&nbsp;</td>
        <td style="height: 18px">
            <igsch:WebDateChooser ID="WebDateChooser_from_date" runat="server">
                <CalendarLayout Culture="English (United Kingdom)">
                </CalendarLayout>
            </igsch:WebDateChooser>
            <asp:HiddenField ID="HiddenField_from_date" runat="server" />
        </td>
    </tr>
  <tr>
    <td align="right">
        To Date :
      </td>
    <td>
        <igsch:WebDateChooser ID="WebDateChooser_todate" runat="server">
            <CalendarLayout Culture="English (United Kingdom)">
            </CalendarLayout>
        </igsch:WebDateChooser>
        <asp:HiddenField ID="HiddenField_to_date" runat="server" />
    </td>
  </tr>
  <tr>
    <td align="right">Grade :</td>
    <td><asp:DropDownList ID="DropDownList_grade" runat="server" Width="100px">
      <asp:ListItem></asp:ListItem>
      <asp:ListItem>A+</asp:ListItem>
      <asp:ListItem>A</asp:ListItem>
      <asp:ListItem>B</asp:ListItem>
      <asp:ListItem>C</asp:ListItem>
      <asp:ListItem>D</asp:ListItem>
      <asp:ListItem>E</asp:ListItem>
    </asp:DropDownList></td>
  </tr>
  <tr>
    <td align="right">CGPA :</td>
    <td><asp:TextBox ID="TextBox_cgpa" runat="server"     ></asp:TextBox></td>
  </tr>
  <tr>
    <td align="right">Obtained Marks :</td>
    <td><asp:TextBox ID="TextBox_Obtained_Marks" runat="server"     ></asp:TextBox></td>
  </tr>
  <tr>
    <td align="right">Total Marks :</td>
    <td><asp:TextBox ID="TextBox_Total_Marks" runat="server"     ></asp:TextBox></td>
  </tr>
  <tr>
    <td align="right">%age :</td>
    <td><asp:TextBox ID="TextBox_persentage" runat="server"     ></asp:TextBox></td>
  </tr>
  <tr>
    <td align="right">No. of Attempts :</td>
    <td><asp:DropDownList ID="DropDownList_no_of_attempts" runat="server"  Width="100px" >
      <asp:ListItem>1</asp:ListItem>
      <asp:ListItem>2</asp:ListItem>
      <asp:ListItem>3</asp:ListItem>
      <asp:ListItem>4</asp:ListItem>
      <asp:ListItem>5</asp:ListItem>
    </asp:DropDownList></td>
  </tr>
  <tr>
    <td align="right">Distinction :</td>
    <td><asp:RadioButtonList ID="RadioButtonList_distinction" runat="server" RepeatDirection="Horizontal"  >
      <asp:ListItem Value="1">Yes</asp:ListItem>
      <asp:ListItem Value="0">No</asp:ListItem>
    </asp:RadioButtonList></td>
  </tr>
  <tr>
    <td align="right"> Attach : </td>
    <td><asp:FileUpload ID="FileUpload1" runat="server" CssClass="link_spliter"
                         Width="202px" /></td>
  </tr>
  <tr>
    <td align="right">Research Work :</td>
    <td><asp:TextBox ID="TextBox_Research_Work" runat="server" Width="300px" Height="65px" TextMode="MultiLine"></asp:TextBox></td>
  </tr>
  <tr>
    <td align="right">Degree Verified By :</td>
    <td><asp:TextBox ID="txtDegreVerifiedBy" runat="server" Width="300px" Height="65px" ></asp:TextBox></td>
  </tr>
  <tr>
    <td align="right">Verification Sent Date :</td>
    <td>
        <igsch:WebDateChooser ID="wdc_VerfSentDate" runat="server">
                <CalendarLayout Culture="English (United Kingdom)">
                </CalendarLayout>
            </igsch:WebDateChooser>
            <asp:HiddenField ID="hfldVerSentDate" runat="server" />
    </td>
  </tr>
  <tr>
    <td align="right">Verification Received Date :</td>
    <td>
        <igsch:WebDateChooser ID="wdc_VerfReceivedDate" runat="server">
                <CalendarLayout Culture="English (United Kingdom)">
                </CalendarLayout>
            </igsch:WebDateChooser>
            <asp:HiddenField ID="hfldVerReceivedDate" runat="server" />
    </td>
  </tr>
  <tr>
    <td align="right">Verification Status :</td>
    <td><asp:TextBox ID="txtVerificationStatus" runat="server" Width="300px" Height="65px" TextMode="MultiLine"></asp:TextBox></td>
  </tr>
  <tr>
    <td align="right">Remarks :</td>
    <td><asp:TextBox ID="txtRemarks" runat="server" Width="300px" Height="65px" TextMode="MultiLine"></asp:TextBox></td>
  </tr>
  <tr>
    <td align="right"></td>
    <td><asp:Button  ID="Button_continue" runat="server" Text="Save"  /></td>
  </tr>
</table>

 
   </div>
   
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
        SelectCommand="SELECT [Qualification_ID], [Qualification_name] FROM [Qualification]">
    </asp:SqlDataSource>
  
      <asp:SqlDataSource
      ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
      SelectCommand="SELECT Degree_Program.Degree_Program_Name, Degree_Program.Degree_Program_ID, Qualification.Qualification_ID FROM Degree_Program INNER JOIN Qualification_Degree_Program ON Degree_Program.Degree_Program_ID = Qualification_Degree_Program.Degree_Program_ID INNER JOIN Qualification ON Qualification_Degree_Program.Qualification_ID = Qualification.Qualification_ID WHERE (Qualification.Qualification_ID = @Qualification_ID)">
      <SelectParameters>
          <asp:ControlParameter ControlID="DropDownList_Qualification" Name="Qualification_ID"
              PropertyName="SelectedValue" />
      </SelectParameters>
  </asp:SqlDataSource> 
            <asp:Label ID="Label6" runat="server" ForeColor="Red" Text="Date From is Less Than Date To"
                Visible="False"></asp:Label>
  <br>

<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Employee_ID,Degree_Program_ID"
            DataSourceID="SqlDataSource1" Width="100%"  >
            <Columns>
                <asp:BoundField DataField="Degree_Program_Name" HeaderText="Degree" SortExpression="Degree_Program_Name" />
                <asp:BoundField DataField="Majors" HeaderText="Majors" SortExpression="Majors" />
                <asp:BoundField DataField="Recognized_Institute" HeaderText="Recognized Institute"
                    SortExpression="Recognized_Institute" />
                <asp:BoundField DataField="From_Date" HeaderText="From Date" SortExpression="From_Date" />
                <asp:BoundField DataField="To_Date" HeaderText="To Date" SortExpression="To_Date" />
                <asp:HyperLinkField DataNavigateUrlFields="Image_URL" DataNavigateUrlFormatString="Documents/{0}"
                    DataTextField="Image_name" HeaderText="Images" Target="_blank" />
                <asp:HyperLinkField DataNavigateUrlFields="Degree_Program_ID,Employee_ID" DataNavigateUrlFormatString="~/HR/Education_view.aspx?Degree_Program_ID={0}&amp;Employee_ID={1}"
                    HeaderText="View Detail" Text="View Detail" />
            </Columns>
             
             
              <AlternatingRowStyle CssClass="GridAltItem" />
          </asp:GridView>
          <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:job ApplicationConnectionString %>'
            DeleteCommand="DELETE FROM [Education] WHERE [Employee_ID] = @Employee_ID AND [Degree_Program_ID] = @Degree_Program_ID"
            InsertCommand="INSERT INTO Education(Employee_ID, Degree_Program_ID, Majors, Recognized_Institute, To_Date, Grade, CGPA, Distinction, number, total, Research_Work, Qualification_Id, Image_name, Image_URL, Percentage, No_of_Attempts,from_date,Degree_Verified_By,Verification_Sent_Date,Verification_Received_date,Verification_Status,Remarks) VALUES (@Employee_ID, @Degree_Program_ID, @Majors, @Recognized_Institute, @To_Date, @Grade, @CGPA, @Distinction, @number, @total, @Research_Work, @Qualification_Id, @Image_name, @Image_URL, @Percentage, @No_of_Attempts,@from_date,@Degree_Verified_By,@Verification_Sent_Date,@Verification_Received_date,@Verification_Status,@Remarks)"
            SelectCommand="SELECT Education.Employee_ID, Education.Degree_Program_ID, Education.Majors, Education.Recognized_Institute, CONVERT (varchar, Education.From_Date, 103) AS From_Date, CONVERT (varchar, Education.To_Date, 103) AS To_Date, Education.Grade, Education.CGPA, Education.Distinction, Education.number, Education.total, Education.Research_Work, Education.Qualification_Id, Education.Image_name, Education.Image_URL, Degree_Program.Degree_Program_Name FROM Education INNER JOIN Degree_Program ON Education.Degree_Program_ID = Degree_Program.Degree_Program_ID WHERE (Education.Employee_ID = @Employee_ID)"
            UpdateCommand="UPDATE [Education] SET [Majors] = @Majors, [Recognized_Institute] = @Recognized_Institute, [From_Date] = @From_Date, [To_Date] = @To_Date, [Grade] = @Grade, [CGPA] = @CGPA, [Distinction] = @Distinction, [number] = @number, [total] = @total, [Research_Work] = @Research_Work, [Qualification_Id] = @Qualification_Id WHERE [Employee_ID] = @Employee_ID AND [Degree_Program_ID] = @Degree_Program_ID">
            <DeleteParameters>
                <asp:Parameter Name="Employee_ID" Type="Int32" />
                <asp:Parameter Name="Degree_Program_ID" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="Majors" Type="String" />
                <asp:Parameter Name="Recognized_Institute" Type="String" />
                <asp:Parameter Name="From_Date" Type="DateTime" />
                <asp:Parameter Name="To_Date" Type="DateTime" />
                <asp:Parameter Name="Grade" Type="String" />
                <asp:Parameter Name="CGPA" Type="Double" />
                <asp:Parameter Name="Distinction" Type="Boolean" />
                <asp:Parameter Name="number" Type="Int32" />
                <asp:Parameter Name="total" Type="Int32" />
                <asp:Parameter Name="Research_Work" Type="String" />
                <asp:Parameter Name="Qualification_Id" Type="Int32" />
                <asp:Parameter Name="Employee_ID" Type="Int32" />
                <asp:Parameter Name="Degree_Program_ID" Type="Int32" />
            </UpdateParameters>
            <InsertParameters>
                <asp:SessionParameter Name="Employee_ID" SessionField="Enter_emp_ID" Type="Int32" />
                <asp:ControlParameter ControlID="DropDownList_Degree_Program" Name="Degree_Program_ID"
                    PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="TextBox_majors" Name="Majors" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_Institute" Name="Recognized_Institute" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="HiddenField_to_date" Name="To_Date" PropertyName="Value" />
                <asp:ControlParameter ControlID="DropDownList_grade" Name="Grade" PropertyName="SelectedValue"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_cgpa" Name="CGPA" PropertyName="Text" Type="Double" />
                <asp:ControlParameter ControlID="RadioButtonList_distinction" Name="Distinction"
                    PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="TextBox_Obtained_Marks" Name="number" PropertyName="Text"
                    Type="Int32" />
                <asp:ControlParameter ControlID="TextBox_Total_Marks" Name="total" PropertyName="Text"
                    Type="Int32" />
                <asp:ControlParameter Name="Research_Work" Type="String" ControlID="TextBox_Research_Work" PropertyName="Text" />
                <asp:ControlParameter ControlID="DropDownList_Qualification" Name="Qualification_Id"
                    PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="HiddenField_fileName" Name="Image_name" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_file_URL" Name="Image_URL" PropertyName="Value" />
                <asp:ControlParameter ControlID="TextBox_persentage" Name="Percentage" PropertyName="Text" />
                <asp:ControlParameter ControlID="DropDownList_no_of_attempts" Name="No_of_Attempts"
                    PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="HiddenField_from_date" Name="from_date" PropertyName="Value" />
                <asp:ControlParameter ControlID="txtDegreVerifiedBy" Name="Degree_Verified_By" PropertyName="Text" />
                <asp:ControlParameter ControlID="hfldVerSentDate" Name="Verification_Sent_Date" PropertyName="Value" />
                <asp:ControlParameter ControlID="hfldVerReceivedDate" Name="Verification_Received_date" PropertyName="Value" />
                <asp:ControlParameter ControlID="txtVerificationStatus" Name="Verification_Status" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtRemarks" Name="Remarks" PropertyName="Text" />
            </InsertParameters>
              <SelectParameters>
                  <asp:SessionParameter Name="Employee_ID" SessionField="Enter_emp_ID" />
              </SelectParameters>
          </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenField_fileName" runat="server" />
                <asp:HiddenField ID="HiddenField_file_URL" runat="server" />
             
      
</td>
</tr>
</table>
 </asp:Content>