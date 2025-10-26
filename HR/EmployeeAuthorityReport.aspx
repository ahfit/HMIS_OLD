<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="false" CodeFile="EmployeeAuthorityReport.aspx.vb" Inherits="HR_EmployeeAuthorityReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">


    </script>
    <style type="text/css">
        .style1 {
            width: 410px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <asp:ScriptManager ID="scriptManager1" runat="server"></asp:ScriptManager>
      <iframe id="frmPrint" name="IframeName" width="500" 
  height="200" runat="server" 
  style="display: none" ></iframe>
    <div class="bxmain inner_content" style="width: 100%">
        <h2><span>Employee Reporting Authortiy Report</span></h2>

        <table class="tbl_form">
            <tr>
                <td align="right" class="style1">
                    <strong>Hospital :</strong> </td>
                <td colspan="2">
                    <asp:DropDownList ID="DDL_Company" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Company" DataTextField="Hospital_Name"
                        DataValueField="Hospital_ID"
                        AutoPostBack="True" Style="margin-left: 0px">
                    </asp:DropDownList>




                    <asp:SqlDataSource ID="SDS_Company" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"></asp:SqlDataSource>




                </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    <strong> Authority Department :</strong></td>
                <td colspan="2">
                    <asp:DropDownList ID="DDL_Branch" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Branch" DataTextField="SubDept_Name"
                        DataValueField="SubDept_Id" AutoPostBack="True">
                    </asp:DropDownList>


                    <asp:SqlDataSource ID="SDS_Branch" runat="server"
                         ConnectionString="<%$ ConnectionStrings:Machine_AttendanceConnectionString %>"
                        SelectCommand="select 0 AS SubDept_Id, ' ---ALL--- ' AS SubDept_Name union
Select sd.SubDept_Id,SubDept_Name from SubDepartment sd
                        inner join Department D on sd.Dept_Id  = D.Dept_Id where D.Hospital_ID = @HospitalID
ORDER BY SubDept_Name">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DDL_Company" Name="HospitalID"
                                PropertyName="SelectedValue" />
                             <asp:SessionParameter Name="empid" SessionField="Emp_ID" Type="Int32" />
                
                        </SelectParameters>


                    </asp:SqlDataSource>


                    <%--<asp:SqlDataSource ID="SDS_Branch1" runat="server"
                         ConnectionString="<%$ ConnectionStrings:Machine_AttendanceConnectionString %>"
                        SelectCommand="
Select distinct SubDepartment.SubDept_Id,SubDept_Name from SubDepartment
inner join EmployeeReportingAuthority er on er.SubdeptId=SubDepartment.SubDept_Id
where er.EmpID=@empid
ORDER BY SubDept_Name">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DDL_Company" Name="HospitalID"
                                PropertyName="SelectedValue" />
                             <asp:SessionParameter Name="empid" SessionField="Emp_ID" Type="Int32" />
                
                        </SelectParameters>


                    </asp:SqlDataSource>--%>




                </td>
            </tr>
           
            <tr>
                <td align="right" class="style1">
                    <strong>Reporting Authority :</strong></td>
                <td colspan="2">
                    <asp:DropDownList ID="DDLReportingAuthortiy" runat="server"
                        CssClass="drop_down" DataSourceID="SdsReportingAuthority" DataTextField="Name"
                        DataValueField="EmpID">
                    </asp:DropDownList>


                  <asp:SqlDataSource ID="SdsReportingAuthority" runat="server"
                       ConnectionString="<%$ ConnectionStrings:HRConnectionString %>"
                        SelectCommand="select 0 As EmpID,' ---ALL--- ' AS Name union
                                        SELECT Employee.EmpID,  ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '')+' '+Cast(Employee.EmpID as varchar)+' '+' ('+Cast( Designation.Designation_Name as varchar )+')' AS Name
                                        FROM  Employee inner join Designation on Employee.DesignationID=Designation.Designation_ID	    
                                        WHERE 
                                        (Employee.ActiveStatus=1)  AND 
                                        (@SubDept_Id =0 or Employee.SubDeptId = @SubDept_Id) order by Name,EmpID"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DDL_Branch" Name="SubDept_Id"
                                PropertyName="SelectedValue" />
                             <asp:SessionParameter Name="empid" SessionField="Emp_ID" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <%--<asp:SqlDataSource ID="SDS_Employee" runat="server"
                       ConnectionString="<%$ ConnectionStrings:Machine_AttendanceConnectionString %>"
                        SelectCommand="SELECT     Employee.EmpID,  ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS Name
FROM         Employee

inner join EmployeeReportingAuthority ER on er.ReportingAuthorityEmpID=Employee.EmpID
WHERE     (@SubDept_Id =0 or Employee.SubDeptId = @SubDept_Id) and ER.EmpID=@empid  order by Name,EmpID"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DDL_Branch" Name="SubDept_Id"
                                PropertyName="SelectedValue" />
                             <asp:SessionParameter Name="empid" SessionField="Emp_ID" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>--%>




                </td>
            </tr>

             <tr>
                <td align="right" class="style1">
                    <strong> Employee Department :</strong></td>
                <td colspan="2">
                    <asp:DropDownList ID="DDL_EmpDept" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_EmpDept" DataTextField="SubDept_Name"
                        DataValueField="SubDept_Id" AutoPostBack="True">
                    </asp:DropDownList>


                    <asp:SqlDataSource ID="SDS_EmpDept" runat="server"
                         ConnectionString="<%$ ConnectionStrings:Machine_AttendanceConnectionString %>"
                        SelectCommand="select 0 AS SubDept_Id, ' ---ALL--- ' AS SubDept_Name union
Select sd.SubDept_Id,SubDept_Name from SubDepartment sd
                        inner join Department D on sd.Dept_Id  = D.Dept_Id where D.Hospital_ID = @HospitalID
ORDER BY SubDept_Name">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DDL_Company" Name="HospitalID"
                                PropertyName="SelectedValue" />
                             <asp:SessionParameter Name="empid" SessionField="Emp_ID" Type="Int32" />
                
                        </SelectParameters>


                    </asp:SqlDataSource>


                    <%--<asp:SqlDataSource ID="SDS_Branch1" runat="server"
                         ConnectionString="<%$ ConnectionStrings:Machine_AttendanceConnectionString %>"
                        SelectCommand="
Select distinct SubDepartment.SubDept_Id,SubDept_Name from SubDepartment
inner join EmployeeReportingAuthority er on er.SubdeptId=SubDepartment.SubDept_Id
where er.EmpID=@empid
ORDER BY SubDept_Name">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DDL_Company" Name="HospitalID"
                                PropertyName="SelectedValue" />
                             <asp:SessionParameter Name="empid" SessionField="Emp_ID" Type="Int32" />
                
                        </SelectParameters>


                    </asp:SqlDataSource>--%>




                </td>
            </tr>
             <tr>
                <td align="right" class="style1">
                    <strong>Employee :</strong></td>
                <td colspan="2">
                    <asp:DropDownList ID="DDL_Sold_By" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Employee" DataTextField="Name"
                        DataValueField="EmpID">
                    </asp:DropDownList>


                    <asp:SqlDataSource ID="SDS_Employee" runat="server"
                       ConnectionString="<%$ ConnectionStrings:Machine_AttendanceConnectionString %>"
                        SelectCommand="select 0 As EmpID,' ---ALL--- ' AS Name union
                                        SELECT Employee.EmpID,  ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '')+' '+Cast(Employee.EmpID as varchar)+' '+' ('+Cast( Designation.Designation_Name as varchar )+')' AS Name
                                        FROM  Employee inner join Designation on Employee.DesignationID=Designation.Designation_ID	    
                                        WHERE 
                                        (Employee.ActiveStatus=1) 
                                        AND 
                                        (@SubDept_Id =0 or Employee.SubDeptId = @SubDept_Id) order by Name,EmpID"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
                        <SelectParameters>
                             <asp:ControlParameter ControlID="DDL_EmpDept" Name="SubDept_Id"
                                PropertyName="SelectedValue" />
                             <asp:SessionParameter Name="empid" SessionField="Emp_ID" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <%--<asp:SqlDataSource ID="SDS_Employee" runat="server"
                       ConnectionString="<%$ ConnectionStrings:Machine_AttendanceConnectionString %>"
                        SelectCommand="SELECT     Employee.EmpID,  ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS Name
FROM         Employee

inner join EmployeeReportingAuthority ER on er.ReportingAuthorityEmpID=Employee.EmpID
WHERE     (@SubDept_Id =0 or Employee.SubDeptId = @SubDept_Id) and ER.EmpID=@empid  order by Name,EmpID"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DDL_Branch" Name="SubDept_Id"
                                PropertyName="SelectedValue" />
                             <asp:SessionParameter Name="empid" SessionField="Emp_ID" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>--%>




                </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    <strong>Category :</strong> </td>
                <td colspan="2">
                    <asp:DropDownList ID="ddlCategory" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Category" DataTextField="Category"
                        DataValueField="CategoryId"
                        AutoPostBack="True" Style="margin-left: 0px">
                    </asp:DropDownList>




                    <asp:SqlDataSource ID="SDS_Category" runat="server"
                        ConnectionString="<%$ ConnectionStrings:HRConnectionString %>"
                        SelectCommand="select 0 As CategoryId,' ---ALL--- ' AS Category union select CategoryId, Category from HROperationCategory"></asp:SqlDataSource>




                </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    <strong>Reporting Level :</strong></td>
                <td colspan="2">
                    <asp:DropDownList ID="ddlLevels" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Levels" DataTextField="Level"
                        DataValueField="LevelId">
                    </asp:DropDownList>


                    <asp:SqlDataSource ID="SDS_Levels" runat="server"
                         ConnectionString="<%$ ConnectionStrings:HRConnectionString %>"
                        SelectCommand="select 0 As LevelId,' ---ALL--- ' AS Level union select LevelId,Level from HRAuthorityLevel">
                        <SelectParameters>
                
                        </SelectParameters>


                    </asp:SqlDataSource>


                </td>
            </tr>
            <tr>
                <td align="right" class="style1">&nbsp;</td>
                <td>&nbsp;</td>
                <td>
                    <asp:Button ID="btn_Report" runat="server" Text="View Report" CssClass="btn_hacims"
                        OnClick="btn_Report_Click" />
                </td>
            </tr>
        </table>
    </div>

   
    <input style="visibility: hidden" type="button" value="print" onclick="printSpecial()" id="btn_print" autofocus="autofocus" onload="Set_focus()"  />
    <br />
    <rsweb:ReportViewer ID="ReportViewer1" Width="100%" runat="server">
    </rsweb:ReportViewer>

</asp:Content>

