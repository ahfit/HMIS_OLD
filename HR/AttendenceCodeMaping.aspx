<%@ page enableeventvalidation="false" language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage.master" inherits="HR_Search_Employee, App_Web_ah1wcbj4" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7DD5C3163F2CD0CB"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>

  

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">



<div  >
    <asp:HiddenField ID="HiddenFieldPage_Name" runat="server" />
    <asp:HiddenField ID="HiddenFieldPage" runat="server" />
 <asp:Label ID="LabelDoctorName" runat="server" Visible="false" ></asp:Label> <asp:Label ID="Label_SubDepartment" runat="server"  Text="Label_SubDepartment" Visible="False"></asp:Label>
 <asp:Label ID="LabelDate" runat="server" Visible="false" ></asp:Label>
<div class="bxmain">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td align="right" width="40%">&nbsp;</td>
    <td colspan="3"> 
        <asp:RadioButtonList ID="RadioButtonList_Type" runat="server" 
            RepeatDirection="Horizontal" RepeatLayout="Flow">
            <asp:ListItem Selected="True" Value="0">Both</asp:ListItem>
            <asp:ListItem Value="1">Mapped</asp:ListItem>
            <asp:ListItem Value="2">Not Mapped</asp:ListItem>
        </asp:RadioButtonList>
                    </td>
  </tr>
  <tr>
    <td align="right" width="40%">Department :&nbsp;</td>
    <td width="60%"> <asp:DropDownList ID="Dropdownlistdepartment" runat="server"
					 DataSourceID="SqlDataSourceDepartment" DataTextField="Dept_Name"
                      DataValueField="Dept_ID" TabIndex="5" CssClass="dropbox" Width="252px" >
        </asp:DropDownList></td>
    <td width="60%"> Department :</td>
    <td width="60%"> 
        <asp:DropDownList ID="Dropdownlistdepartment_Access" runat="server"
					 DataSourceID="SqlDataSource_Department_Access" DataTextField="Dept_Name"
                      DataValueField="ID" TabIndex="5" CssClass="dropbox" 
            Width="170px"  >
        </asp:DropDownList></td>
  </tr>
  <tr>
    <td align="right" >Designation :&nbsp; </td>
    <td><asp:DropDownList ID="DropDownList_desg" runat="server"
                      CssClass="dropbox" DataSourceID="SqlDataSource_desg" DataTextField="Designation_Name"
                      DataValueField="Designation_ID" TabIndex="5" Width="252px" >
        </asp:DropDownList></td>
    <td>Designation :&nbsp; </td>
    <td><asp:DropDownList ID="DropDownList_desg_Access" runat="server"
                      CssClass="dropbox" 
            DataSourceID="SqlDataSource_Designation_Access" DataTextField="Designation"
                      DataValueField="Designation" TabIndex="5" Width="171px" 
             >
        </asp:DropDownList></td>
  </tr>
  
  <tr>
    <td align="right">Employee Name :&nbsp;</td>
    <td><asp:TextBox ID="TextBox_Employee_name" runat="server"  Width="248px"></asp:TextBox></td>
    <td>Employee Name :&nbsp;</td>
    <td><asp:TextBox ID="TextBox_Employee_name_access" runat="server"  Width="170px" 
            ></asp:TextBox></td>
  </tr>
  
  <tr>
    <td align="right">Attendence # :&nbsp;</td>
    <td>
        <asp:TextBox ID="TextBox_Attendence_No" runat="server"></asp:TextBox>
      </td>
    <td>Attendence # :&nbsp;</td>
    <td>
        <asp:TextBox ID="TextBox_Attendence_No_Access" runat="server"></asp:TextBox>
      </td>
  </tr>
  
  <tr>
    <td>&nbsp;</td>
    <td><asp:Button ID="Button_Search" runat="server" CssClass="btn1" Text="Search" /></td>
    <td>&nbsp;</td>
    <td><asp:Button ID="Button_Search_Acess" runat="server" CssClass="btn1" 
            Text="Search" /></td>
  </tr>

  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td align="left" colspan="2" valign="top">

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="Grid_1" Width="100%" AllowPaging="True" DataKeyNames="EmpID" Height="98px" AllowSorting="True" PageSize="50">
        <Columns>
            <asp:ButtonField CommandName="Select" DataTextField="EmployeeName" HeaderText="Employee Name" />
            <asp:HyperLinkField DataNavigateUrlFields="EmpID" DataNavigateUrlFormatString="~/hr/convert.aspx?Enter_emp_ID={0}"
                DataTextField="EmployeeName" HeaderText="Employee Name" Visible="False" />
            <asp:BoundField DataField="EmployeeName" HeaderText="Name" 
                SortExpression="EmployeeName" Visible="False" />
            <asp:BoundField DataField="RelationName" HeaderText="RelationName" SortExpression="RelationName" />
            <asp:BoundField DataField="CNIC" HeaderText="CNIC" SortExpression="CNIC" 
                Visible="False" />
            <asp:BoundField DataField="Join Date" HeaderText="Join Date" 
                SortExpression="Join Date" Visible="False" />
            <asp:BoundField DataField="Designation_Name" HeaderText="Designation" />
            <asp:BoundField DataField="Dept_Name" HeaderText="Department" 
                SortExpression="Dept_Name" />
            <asp:BoundField DataField="EmpID" HeaderText="EmpID" InsertVisible="False" ReadOnly="True"
                SortExpression="EmpID" Visible="False" />
            <asp:TemplateField HeaderText="Attendance Code">
                <ItemTemplate>
                    <table class="style1">
                        <tr>
                            <td>
                                <asp:TextBox ID="TextBox_Attendence_Code" runat="server" Height="22px" 
                                    Text='<%# Bind("Emp_No") %>' Width="58px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:ImageButton ID="ImageButton1" runat="server" CommandName="AttenUpdate" 
                                    ImageUrl="~/ig_images/go.gif" onclick="ImageButton1_Click" />
                            </td>
                        </tr>
                    </table>
                    <asp:HiddenField ID="HiddenField_EmpID" runat="server" 
                        Value='<%# EVal("EmpID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                        CommandArgument='<%#Container.DataItem("EMPId")%>' CommandName="DelEmployee" Text="Delete"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
        <PagerStyle CssClass="GridPager" />
    </asp:GridView>

      </td>
    <td align="left" colspan="2" valign="top">
        <asp:GridView ID="GridView_MsAccess" runat="server" AutoGenerateColumns="False" 
            CssClass="Grid_1" AllowPaging="True" PageSize="50">
            <Columns>
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                <asp:BoundField DataField="Designation" HeaderText="Designation" 
                    SortExpression="Designation" />
                <asp:BoundField DataField="Department" HeaderText="Department" 
                    SortExpression="Department" />
                <asp:BoundField DataField="Attendence_Code" HeaderText="Attendence Code" 
                    SortExpression="Attendence_Code" />
            </Columns>
        </asp:GridView>
      </td>
  </tr>

</table>
</div>


<br />

    <asp:HiddenField ID="HiddenField_CNIC" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_desg" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT [Designation_ID], [Designation_Name] FROM [Designation]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" 
            ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
            UpdateCommand="UPDATE Employee SET Emp_No = @Emp_No WHERE (EmpID = @EmpID)">
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenField_Attendence_Code" Name="Emp_No" 
                PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Emp_ID" Name="EmpID" 
                PropertyName="Value" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT [Dept_Name], [Dept_ID] FROM [Department] ORDER BY [Dept_Name]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_BPS" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" SelectCommand="SELECT DISTINCT Min_PayScale FROM Designation"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmpDelStatus" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        
        SelectCommand="SELECT [Dept_Name], [Dept_ID] FROM [Department] ORDER BY [Dept_Name]" 
        UpdateCommand="UPDATE Employee SET Is_Deleted = 1 WHERE (EmpID = @EmpID)">
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenField_Emp_ID" Name="EmpID" 
                PropertyName="Value" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Emp_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_Attendence_Code" runat="server" />
        <asp:SqlDataSource ID="SqlDataSource_Department_Access" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AccessTCPAttendanceConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:AccessTCPAttendanceConnectionString.ProviderName %>" 
            SelectCommand="SELECT ID, Dept_Name FROM HR_Dept"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_Designation_Access" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AccessTCPAttendanceConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:AccessTCPAttendanceConnectionString.ProviderName %>" 
            SelectCommand="SELECT distinct Custom_1 AS Designation FROM HR_Personnel">
        </asp:SqlDataSource>
        <igtxt:webmaskedit id="TextBox_CNIC" runat="server" inputmask="#####-#######-#" 
            CssClass="input_txt" Width="248px" Visible="False"></igtxt:webmaskedit>
        <br />
        <asp:SqlDataSource ID="SqlDataSource_attendence_From_Acess" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AccessTCPAttendanceConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:AccessTCPAttendanceConnectionString.ProviderName %>">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_attendence_From_Acess0" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AccessTCPAttendanceConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:AccessTCPAttendanceConnectionString.ProviderName %>" 
            SelectCommand="SELECT Per_Name AS Name, Custom_1 AS Designation, Dept_Name AS Department, Dept_ID, Per_Code AS Attendence_Code FROM HR_Personnel WHERE (CONVERT ([varchar], Code_Str) LIKE '%') ORDER BY Per_Name">
        </asp:SqlDataSource>
<br />
<br />


</div>



 </asp:Content>