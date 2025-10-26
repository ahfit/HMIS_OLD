<%@ page title="" language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="HR_Single_Emp_Comp_Detail, App_Web_ah1wcbj4" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7DD5C3163F2CD0CB"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <script src="validate.js" type="text/javascript"></script>

 
    <asp:HiddenField ID="HiddenFieldPage_Name" runat="server" />
    <asp:HiddenField ID="HiddenFieldPage" runat="server" />
 <asp:Label ID="LabelDoctorName" runat="server" Visible="false" ></asp:Label> <asp:Label ID="Label_SubDepartment" runat="server"  Text="Label_SubDepartment" Visible="False"></asp:Label>
 <asp:Label ID="LabelDate" runat="server" Visible="false" ></asp:Label>
<div class="bxmain">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td align="right" width="40%">Department : </td>
    <td width="60%"> <asp:DropDownList ID="Dropdownlistdepartment" runat="server"
					 DataSourceID="SqlDataSourceDepartment" DataTextField="Dept_Name"
                      DataValueField="Dept_ID" TabIndex="5" CssClass="dropbox" Width="262px" >
        </asp:DropDownList></td>
  </tr>
  <tr>
    <td align="right" >Designation :  </td>
    <td><asp:DropDownList ID="DropDownList_desg" runat="server"
                      CssClass="dropbox" DataSourceID="SqlDataSource_desg" DataTextField="Designation_Name"
                      DataValueField="Designation_ID" TabIndex="5" Width="262px" >
        </asp:DropDownList></td>
  </tr>
  
  <tr>
    <td align="right">Employee Name : </td>
    <td><asp:TextBox ID="TextBox_Employee_name" runat="server"  Width="248px"></asp:TextBox></td>
  </tr>
  
  <tr>
    <td align="right">CNIC # : </td>
    <td><igtxt:webmaskedit id="TextBox_CNIC" runat="server" inputmask="#####-#######-#" CssClass="input_txt" Width="248px"></igtxt:webmaskedit></td>
  </tr>
  
  <tr>
    <td align="right">Employee Type : </td>
    <td>
        <asp:RadioButtonList ID="RBL_Employee_Type" runat="server" 
            DataSourceID="SqlDataSource_Emp_Type" DataTextField="Type" 
            DataValueField="Employee_Type_ID" RepeatDirection="Horizontal">
        </asp:RadioButtonList>
      </td>
  </tr>
  
  <tr>
    <td align="right" > 
    
    </td>
    <td>
        <asp:Button ID="Button_Report" runat="server"  Text="View Report" />
       
      </td>
  </tr>

</table>
</div>


<rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
</rsweb:ReportViewer>


<br />

    <asp:HiddenField ID="HiddenField_CNIC" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_desg" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT [Designation_ID], [Designation_Name] FROM [Designation]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlDs_Design" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT [Designation_ID], [Designation_Name] FROM [Designation]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" CancelSelectOnNullParameter="False"
        ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
        SelectCommand="usp_Search_Single_Employee" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="DeptID" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList_desg" Name="DesignationID" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_CNIC" Name="CNIC" 
                PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="TextBox_Employee_name" Name="Name" 
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="RBL_Employee_Type" Name="Emp_Type" 
                PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT     Department.Dept_Name + ' ( ' + Hospital.Hospital_Abb + ' ) ' Dept_Name, Department.Dept_ID 
FROM         Department Left Outer JOIN
                      Hospital ON Department.Hospital_ID = Hospital.Hospital_ID ORDER BY [Dept_Name]">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlDs_Dept" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT     Department.Dept_Name + ' ( ' + Hospital.Hospital_Abb + ' ) ' Dept_Name, Department.Dept_ID 
FROM         Department Left Outer JOIN
                      Hospital ON Department.Hospital_ID = Hospital.Hospital_ID ORDER BY [Dept_Name]">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource_Emp_Type" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="Select 0 as Employee_Type_ID,'All' as Type from Employee_Type
union
SELECT Employee_Type_ID, Type FROM Employee_Type">
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
<br />
<br />


 </asp:Content>

