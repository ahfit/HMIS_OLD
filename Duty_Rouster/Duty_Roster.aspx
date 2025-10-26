<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Duty_Roster, App_Web_eqmkimbh" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<%--<%@ Register Assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

<style type="text/css">

.Grid_1 {width:80%; }
.Grid_1 td {text-align:center; }
</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="bxmain">

 <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" > 
                          <tr>
                            <td width="25%" align="right" >Year :</td>
                              <td  align="left" >
                                <asp:DropDownList ID="DropDownList_Year" runat="server" AutoPostBack="True"  > </asp:DropDownList>
                              </td>
                            </tr>
                          <tr>
                            <td  align="right"  >Month :</td>
                            <td align="left" >
                              <asp:DropDownList ID="DropDownList_Month" runat="server"  > </asp:DropDownList>
                            </td>
                          </tr>
                          <tr>
                            <td  align="right"  >Department :</td>
                            <td align="left" >
                              <asp:DropDownList ID="DropDownListDepartment" runat="server" AutoPostBack="True"
                         DataSourceID="SqlDataSource_Dept" DataTextField="Dept_Name"
                        DataValueField="Dept_ID" > </asp:DropDownList>
                            </td>
                          </tr>
                          <tr>
                            <td  align="right"  >Sub Department :</td>
                            <td align="left" >
                              <asp:DropDownList ID="DropDownListSubDepartment" runat="server" AutoPostBack="True"
                         DataSourceID="SqlDataSourceSubDepartment" DataTextField="SubDept_Name"
                        DataValueField="SubDept_Id"  > </asp:DropDownList>
                            </td>
                          </tr>
                          <tr>
                            <td  align="right"  >Profession :</td>
                            <td align="left" >
                              <asp:DropDownList ID="DropDownList1" runat="server" Width="200px" AutoPostBack="True" DataSourceID="SqlDataSource_Profession" DataTextField="Profession_Name" DataValueField="Profession_Code"> </asp:DropDownList>
                            </td>
                          </tr>
                          <tr>
                            <td  align="right"  >Employee Name :</td>
                            <td align="left" >
                              <asp:CheckBoxList CssClass="text_titles_bold_normal"
                        DataTextField="empolyeeName" DataValueField="EmpID" ID="CheckBoxList_Emp" RepeatColumns="3" RepeatDirection="Horizontal" runat="server"
                          DataSourceID="SqlDataSourceEmployeeName"> </asp:CheckBoxList>
                            </td>
                          </tr>
                          <tr>
                            <td  align="right"  ></td>
                            <td align="left" >
                              <asp:Button ID="Button_Search" runat="server" Text="Search" />                              
                            </td>
                          </tr>
                 
  </table></div>
                  
                        <asp:SqlDataSource ID="SqlDataSource_Dept" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
            SelectCommand="Select_Dept" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceSubDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
            SelectCommand="SELECT SubDept_Name, SubDept_Id FROM SubDepartment WHERE (Dept_Id = @Deptid)">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownListDepartment" Name="Deptid" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceEmployeeName" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
            SelectCommand="SELECT Employee.EmpID, ISNULL(Employee.Prefix, ' ') + ' ' + ISNULL(Employee.EFName, ' ') + ' ' + ISNULL(Employee.EMName, ' ') + ' ' + ISNULL(Employee.ELName, ' ') + ' (' + Designation.Designation_Name + ') ' AS empolyeeName, Employee.DeptID, Employee.SubDeptId, Employee.Profession_Code FROM Employee INNER JOIN Designation ON Employee.DesignationID = Designation.Designation_ID WHERE (Employee.DeptID = @DeptID) AND (Employee.SubDeptId = @SubDeptID) AND (Employee.Profession_Code = @Profession_Code)">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownListDepartment" Name="DeptID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="DropDownListSubDepartment" Name="SubDeptID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="DropDownList1" Name="Profession_Code" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_Profession" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
            SelectCommand="Select * From Admin_Employee_Profession"></asp:SqlDataSource>
        <asp:HiddenField ID="HiddenField_Date_End" runat="server" />
        <asp:HiddenField ID="HiddenField_Date_Start" runat="server" />
        
   <br />
     <div align="center" >
<asp:Panel ID="Panel1" runat="server" Width="100%"> </asp:Panel> 
    </div>                 
<br />
<br />


</asp:Content>