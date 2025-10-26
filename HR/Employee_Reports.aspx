<%@ page title="" language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="HR_Employee_Reports, App_Web_2qu1gl2y" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7DD5C3163F2CD0CB"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="validate.js" type="text/javascript"></script>

    <asp:ScriptManager ID="scriptManager1" runat="server"></asp:ScriptManager>

    <asp:HiddenField ID="HiddenFieldPage_Name" runat="server" />
    <asp:HiddenField ID="HiddenFieldPage" runat="server" />
    <asp:Label ID="LabelDoctorName" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="Label_SubDepartment" runat="server" Text="Label_SubDepartment" Visible="False"></asp:Label>
    <asp:Label ID="LabelDate" runat="server" Visible="false"></asp:Label>
    <div class="bxmain" style="height: 200px !important;">
        <div style="float: left;">
            <table width="500px" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="right" width="40%">
                        Hospital / College :
                    </td>
                    <td width="60%">
                        <asp:DropDownList ID="ddlHospitalCollege" runat="server" DataSourceID="sqlDs_HospitalCollege"
                            DataTextField="Hospital_Name" DataValueField="Hospital_ID" AutoPostBack="True">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sqlDs_HospitalCollege" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                            SelectCommand="SELECT Hospital_ID, Hospital_Name FROM Hospital"></asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td align="right" width="40%">
                        Department :
                    </td>
                    <td width="60%">
                        <asp:DropDownList ID="Dropdownlistdepartment" runat="server" DataSourceID="SqlDataSourceDepartment"
                            DataTextField="Dept_Name" DataValueField="Dept_ID" TabIndex="5" CssClass="dropbox"
                            Width="262px">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Designation :
                    </td>
                    <td>
                        <asp:DropDownList ID="DropDownList_desg" runat="server" CssClass="dropbox" DataSourceID="SqlDataSource_desg"
                            DataTextField="Designation_Name" DataValueField="Designation_ID" TabIndex="5"
                            Width="262px">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Employee Name :
                    </td>
                    <td>
                        <asp:TextBox ID="TextBox_Employee_name" runat="server" Width="248px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        CNIC # :
                    </td>
                    <td>
                        <igtxt:WebMaskEdit ID="TextBox_CNIC" runat="server" InputMask="#####-#######-#" CssClass="input_txt"
                            Width="248px">
                        </igtxt:WebMaskEdit>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Employee Type :
                    </td>
                    <td>
                        <asp:RadioButtonList ID="RBL_Employee_Type" runat="server" DataSourceID="SqlDataSource_Emp_Type"
                            DataTextField="Type" DataValueField="Employee_Type_ID" RepeatDirection="Horizontal">
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                        <asp:Button ID="Button_Search" runat="server" Text="Search" />
                        <asp:Label ID="Label1" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <div style="float: left;">
            <table>
                <tr>
                    <td>
                        Report :
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlReports" runat="server">
                            <asp:ListItem Text=" --- Select --- " Value="0"></asp:ListItem>
                            <asp:ListItem Text="File Label" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Job History" Value="2"></asp:ListItem>
                            <asp:ListItem Text="Summery Report" Value="3"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                        <asp:Button ID="btnShowReport" runat="server" Text="Show Report" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <br />
    <asp:Panel ID="pnlGridView1" runat="server">
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
            Width="100%" AllowPaging="false" DataKeyNames="EmpID" Height="98px" EnableModelValidation="True">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:CheckBox ID="chkSelectedEmp" runat="server" />
                        <asp:HiddenField ID="hfldEmpId" runat="server" Value='<%#Eval("EmpID")%>' />
                    </ItemTemplate>
                    <HeaderTemplate>
                        <asp:CheckBox ID="chkSelectedEmpHeader" AutoPostBack="true" OnCheckedChanged="chkSelectedEmpHeader_CheckedChanged"
                            runat="server" />
                    </HeaderTemplate>
                </asp:TemplateField>
                <%--<asp:TemplateField HeaderText="#">
                <ItemTemplate>
                    <%# Container.DataItemIndex + 1 %>
                    <asp:HiddenField ID="HiddenField_EmpId" runat="server" Value='<%# Eval("EmpID") %>' />
                </ItemTemplate>
            </asp:TemplateField>--%>
                <asp:BoundField HeaderText="Emp #" DataField="EmpID" />
                <asp:BoundField HeaderText="Employee Name" DataField="EmployeeName" />
                <asp:HyperLinkField DataNavigateUrlFields="EmpID" DataNavigateUrlFormatString="~/hr/convert.aspx?Enter_emp_ID={0}"
                    DataTextField="EmployeeName" HeaderText="Employee Name" Visible="False" />
                <asp:BoundField DataField="RelationName" HeaderText="RelationName" SortExpression="RelationName" />
                <asp:BoundField DataField="CNIC" HeaderText="CNIC" SortExpression="CNIC" />
                <asp:BoundField DataField="Join Date" HeaderText="Join Date" SortExpression="Join Date" />
                <asp:BoundField DataField="Designation_Name" HeaderText="Designation" />
                <asp:BoundField DataField="Dept_Name" HeaderText="Department" />
                <asp:BoundField DataField="DateOfBirth" HeaderText="Date of Birth" />
                <asp:BoundField DataField="HPhoneNo" HeaderText="House Phone #" />
                <asp:BoundField DataField="OphoneNo" HeaderText="Off. Phone #" />
                <asp:BoundField DataField="OfficeAdd" HeaderText="Off. Add." />
                <asp:BoundField DataField="HomeAdd" HeaderText="Home Add." />
                <asp:BoundField DataField="Marital_Status" HeaderText="Marital Status" />
            </Columns>
            <HeaderStyle CssClass="GridHeader" />
            <AlternatingRowStyle CssClass="GridAltItem" />
            <PagerStyle CssClass="GridPager" />
        </asp:GridView>
    </asp:Panel>
    <asp:Panel ID="pnlReport" runat="server">
        <rsweb:ReportViewer ID="ReportViewer1" Width="100%" Height="400px" runat="server">
        </rsweb:ReportViewer>
    </asp:Panel>

    <asp:HiddenField ID="HiddenField_CNIC" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_desg" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT [Designation_ID], [Designation_Name] FROM [Designation]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT [Dept_Name], [Dept_ID] FROM [Department] Where Hospital_ID = @Hospital_ID ORDER BY [Dept_Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlHospitalCollege" Name="Hospital_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Emp_Type" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="Select 0 as Employee_Type_ID,'All' as Type from Employee_Type
union
SELECT Employee_Type_ID, Type FROM Employee_Type"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_BPS" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT DISTINCT Min_PayScale FROM Designation"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmpDelStatus" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT [Dept_Name], [Dept_ID] FROM [Department] ORDER BY [Dept_Name]"
        UpdateCommand="UPDATE Employee SET Is_Deleted = 1 WHERE (EmpID = @EmpID)">
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenField_Emp_ID" Name="EmpID" PropertyName="Value" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Emp_ID" runat="server" />
    <br />
    <br />
</asp:Content>
