<%@ page title="" language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="HR_Staff_Full_Info, App_Web_ybbpntbq" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7DD5C3163F2CD0CB" namespace="Infragistics.WebUI.WebDataInput" tagprefix="igtxt" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
    .style1
    {
        width: 58%;
    }
        .style2
        {
            height: 16px;
        }
        .style4
        {
            height: 120px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    
    <table width="50%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
    <tr>
        <td align="right">
            Hospital:</td>
        <td class="style1">
            <asp:DropDownList ID="ddlHospital" runat="server" CssClass="dropbox" 
           Width="262px" DataSourceID="sdsHospital" DataTextField="Hospital_Name" 
           DataValueField="Hospital_ID" AutoPostBack="True" >
            </asp:DropDownList>
            <asp:SqlDataSource ID="sdsHospital" runat="server" 
           ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
           SelectCommand="SELECT 0 AS Hospital_ID, 'ALL' AS Hospital_Name UNION 
 SELECT distinct    Hospital.Hospital_ID, Hospital.Hospital_Name
FROM         Hospital ">
                
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td align="right" width="40%">
            Department : 
        </td>
        <td class="style1">
            <asp:DropDownList ID="Dropdownlistdepartment" runat="server"
					 DataSourceID="SqlDataSourceDepartment" DataTextField="Dept_Name"
                      DataValueField="Dept_ID"  CssClass="dropbox" Width="262px" 
            AutoPostBack="True" >
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td align="right" >
            Designation :  
        </td>
        <td class="style1">
            <asp:DropDownList ID="DropDownList_desg" runat="server"
                      CssClass="dropbox" DataSourceID="SqlDataSource_desg" DataTextField="Designation_Name"
                      DataValueField="Designation_ID" TabIndex="5" Width="262px"  AutoPostBack="true">
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td align="right">
            Emp No :</td>
        <td class="style1">
            <asp:TextBox ID="TextBox_Employee_EmpNO" runat="server"  Width="248px"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td align="right">
            Inf Type : 
        </td>
        <td class="style1">
        <span width = "25%"><asp:CheckBox ID="ck_RName" runat="server" text = "Relation Name"  /></span>
        <span width = "25%"><asp:CheckBox ID="ck_EDes" runat="server" text = "Designation"/></span>
          <span width = "25%"><asp:CheckBox ID="ck_CNIC" runat="server" Text = "CNIC"/></span>   
           <span width = "25%"><asp:CheckBox ID="ck_HAdres" runat="server"  Text = "Home Address"/>
            </span>   
           <br />
           <span width = "25%"><asp:CheckBox ID="ck_mail" runat="server" text = "Email"/></span>
        <span width = "25%"><asp:CheckBox ID="ck_P_adres" runat="server" text = "Present Address"/></span>
          <span width = "25%"><asp:CheckBox ID="ck_mobile" runat="server" text = "Mobile # " /></span>   
           <span width = "25%"><asp:CheckBox ID="ck_DOJ" runat="server"  text = "DOJ" />
            </span>   
      
        </td>
    </tr>
    <tr>
        <td align="right" >
    <%--<asp:HyperLink ID="HyperLink1" runat ="server" NavigateUrl="~/hr/EmployeeTypeList.aspx" Target ="_blank"  CssClass="btn_hacims">Search by Joining date</asp:HyperLink>--%>
        </td>
        <td class="style1">
            <asp:Button ID="btn_Seach" runat="server"  Text="Search" />
            <asp:Button ID="btn_Search" runat="server"  Text="View Report" />
        &nbsp;
            <asp:Button ID="btn_Export" runat="server"  Text="Export to Excel" />
            </td>
    </tr>
    <tr>
        <td align="right" colspan="2" >
            <asp:GridView ID="GridView1" runat="server" 
                DataKeyNames="EmpID" DataSourceID="SqlDataSource1" Width="100%" 
                CssClass="Grid_1">
                <Columns>
                <asp:TemplateField HeaderText="Sr#.">
     <itemtemplate>
          <%#Container.DataItemIndex + 1 %>                                                    
     </itemtemplate>
</asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
           
                
                
                SelectCommand="SELECT     Employee.EmpID, ISNULL(Employee.Prefix, '') + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') 
                      AS EmployeeName, ISNULL(Employee.Relation, '') + ' ' + ISNULL(Employee.RFName, '') + ' ' + ISNULL(Employee.RMName, ' ') + ' ' + ISNULL(Employee.RLName, ' ') 
                      AS RelationName, Department.Dept_Name, Designation.Designation_Name, CONVERT(varchar, Employee.DateOfBirth, 107) AS DateofBirth, CONVERT(varchar, 
                      Employee.JoinDate, 107) AS JoiningDate, Gender.Gender, Employee.CNIC, ISNULL(Employee.PayScale, '') AS PayScale, ISNULL(Employee.OfficeAdd, '') AS ofcadd, 
                      Employee.HomeAdd, ISNULL(Employee.email_address, '') AS Email, ISNULL(Employee.Present_address, '') AS Pre_add, ISNULL(Employee.Mobile_Number, '') 
                      AS Expr1, Employee.PMDC, Shift.Shift, Hospital.Hospital_Name, Nationality.Nationality_Name, Religion.Religion_name, Department.Dept_ID, 
                      Department.Hospital_ID, Designation.Designation_ID
FROM         Employee_Type RIGHT OUTER JOIN
                      Employee ON Employee_Type.Employee_Type_ID = Employee.Emp_Type LEFT OUTER JOIN
                      Hospital RIGHT OUTER JOIN
                      Department ON Hospital.Hospital_ID = Department.Hospital_ID ON Employee.DeptID = Department.Dept_ID LEFT OUTER JOIN
                      SubDepartment ON Employee.SubDeptId = SubDepartment.SubDept_Id LEFT OUTER JOIN
                      Designation ON Employee.DesignationID = Designation.Designation_ID LEFT OUTER JOIN
                      Gender ON Employee.SexID = Gender.Gender_ID LEFT OUTER JOIN
                      Shift ON Employee.Shift_Id = Shift.Shift_ID LEFT OUTER JOIN
                      Nationality ON Employee.Nationality = Nationality.Nationality_ID LEFT OUTER JOIN
                      Religion ON Employee.Religion = Religion.Religion_ID
WHERE      (Employee.ActiveStatus=1) AND (@Dept_ID =0 or Department.Dept_ID = @Dept_ID) AND (@Hospital_ID = 0 or Department.Hospital_ID = @Hospital_ID) AND 
                      (@Designation_ID = 0 or Designation.Designation_ID = @Designation_ID) and (@Empid=0 or Employee.Empid=@Empid)" >
                <SelectParameters>
                    
                    <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="Dept_ID" 
                        PropertyName="SelectedValue" DefaultValue="0" />
                    <asp:ControlParameter ControlID="ddlHospital" Name="Hospital_ID" 
                        PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="DropDownList_desg" Name="Designation_ID" 
                        PropertyName="SelectedValue" />
                   
                    <asp:ControlParameter ControlID="TextBox_Employee_EmpNO" DefaultValue="0" Name="Empid" PropertyName="Text"  />
                   
                </SelectParameters>
            </asp:SqlDataSource>
            </td>
    </tr>
    <tr>
        
        <td align="right" >
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style2" colspan="2">
            <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
            </rsweb:ReportViewer>
        </td>
    </tr>
    <tr>
        <td align="right" colspan="2" class="style4" >
    <asp:SqlDataSource ID="SqlDataSource_desg" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        
        
        SelectCommand="select  0 as Designation_ID, '---ALL---' as Designation_Name union 
SELECT   distinct    Designation.Designation_ID, Designation.Designation_Name
FROM       AssignedEmployee INNER JOIN
                      Employee ON AssignedEmployee.Desig_ID = Employee.DesignationID LEFT OUTER JOIN
                      Department ON Employee.DeptID = Department.Dept_ID RIGHT OUTER JOIN
                      Designation ON Employee.DesignationID = Designation.Designation_ID
WHERE     (AssignedEmployee.Admin_ID = @Admin_ID) AND(Employee.DeptID=@Dept_Id or  @Dept_Id=0) and (Department.Hospital_ID = @Hospital_ID or @Hospital_ID = 0)">
        <SelectParameters>
            <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="Dept_Id" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ddlHospital" Name="Hospital_ID" 
                PropertyName="SelectedValue" />
            <asp:SessionParameter Name="Admin_ID" SessionField="emp_Id" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" 
                ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" 
                
                SelectCommand="SELECT     Employee.EmpID, ISNULL(Employee.Prefix, '') + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') 
                      AS EmployeeName, CONVERT(varchar, Employee.Relation + ' ' + ISNULL(Employee.RFName, '') + ' ' + ISNULL(Employee.RLName, '')) AS Relation_name, 
                      convert(varchar,Employee.JoinDate,103) as JoinDate, LEFT(CONVERT(varchar, Employee.CNIC), 5) + '-' + SUBSTRING(CONVERT(varchar, Employee.CNIC), 6, 7) + '-' + RIGHT(CONVERT(varchar, 
                      Employee.CNIC), 1) AS CNIC, ISNULL(Employee.OfficeAdd, '') + ' ' + ISNULL(Employee.HomeAdd, '') AS Home_Address, 
                      CASE WHEN Employee.Present_address = 'same as above ' THEN Employee.HomeAdd ELSE Employee.Present_address END AS Present_Address, 
                      ISNULL(Employee.Mobile_Number,'') AS Mobile_no, ISNULL(Designation.Designation_Name,'') AS Designation, CONVERT(varchar, Employee.email_address) AS email, 
                      ISNULL(Department.Dept_Name,'') AS DeptName, ISNULL(Hospital.Hospital_Name,'') AS Hos_Name, ISNULL(Payscale.Pay_Scale_name,'') AS PayScale, ISNULL(Nationality.Nationality_Name,'') AS Nat_Name, 
                      ISNULL(Gender.Gender_Value,'') AS Gender, ISNULL(Employee_Type.Type,'')as EmpType
FROM         Employee_Type RIGHT OUTER JOIN
                      Employee INNER JOIN
                      Designation ON Employee.DesignationID = Designation.Designation_ID INNER JOIN
                      Employee AS Employee_1 ON Employee.EmpID = Employee_1.EmpID ON Employee_Type.Employee_Type_ID = Employee.Employee_Type_ID LEFT OUTER JOIN
                      Gender ON Employee.SexID = Gender.Gender_ID LEFT OUTER JOIN
                      Hospital LEFT OUTER JOIN
                      Department ON Hospital.Hospital_ID = Department.Hospital_ID ON Employee.DeptID = Department.Dept_ID RIGHT OUTER JOIN
                      Nationality ON Employee.Nationality = Nationality.Nationality_ID LEFT OUTER JOIN
                      Payscale ON Designation.Min_PayScale = Payscale.Pay_scale_ID">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlHospital" Name="hospital_ID" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="deptID" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="TextBox_Employee_EmpNO" Name="Empid" 
                PropertyName="Text" Type="Int32" DefaultValue="0" />
            <asp:ControlParameter ControlID="DropDownList_desg" Name="desig" 
                PropertyName="SelectedValue" Type="Int32" />
           
            <asp:SessionParameter Name="admin_id" SessionField="emp_id" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        
        SelectCommand="usp_selectDepartment" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlHospital" Name="Hospital_ID" 
                PropertyName="SelectedValue" />
            <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
        </td>
    </tr>
</table>
</asp:Content>

