<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="false" CodeFile="EmpLeaveBalanceCalcu.aspx.vb" Inherits="HR_EmpLeaveBalanceCalcu" %>

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
        <h2><span>Emp Balance Leave Record</span></h2>

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
                    <strong> Sub Department :</strong></td>
                <td colspan="2">
                    <asp:DropDownList ID="DDL_Branch" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Branch" DataTextField="SubDept_Name"
                        DataValueField="SubDept_Id" AutoPostBack="True">
                    </asp:DropDownList>




                    <asp:SqlDataSource ID="SDS_Branch" runat="server"
                       ConnectionString="<%$ ConnectionStrings:HRConnectionString %>"
                        SelectCommand="usp_GetAuthoritySubDepartments" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DDL_Company" Name="HospitalID"
                                PropertyName="SelectedValue" />
                             <asp:SessionParameter Name="empid" SessionField="Emp_ID" Type="Int32" />
                
                        </SelectParameters>
                    </asp:SqlDataSource>

                <%--        SelectCommand="
Select 0 as SubDept_Id, '---ALL---' as SubDept_Name
union
Select SubDepartment.SubDept_Id,SubDept_Name from SubDepartment
inner join EmployeeReportingAuthority er on er.SubdeptId=SubDepartment.SubDept_Id
where er.EmpID=@empid
ORDER BY SubDept_Name">--%>


                </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    <strong>Employee :</strong></td>
                <td colspan="2">
                    <asp:DropDownList ID="DDL_Sold_By" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Employee" DataTextField="Employee_Name"
                        DataValueField="EmpID">
                    </asp:DropDownList>




                    <asp:SqlDataSource ID="SDS_Employee" runat="server"
                       ConnectionString="<%$ ConnectionStrings:HRConnectionString %>"
                         SelectCommand="usp_GetAuthorityDepartmentsAllEmployee" SelectCommandType="StoredProcedure"
                        ProviderName="<%$ ConnectionStrings:HRConnectionString.ProviderName %>">
                         <SelectParameters>
                            <asp:ControlParameter ControlID="DDL_Branch" Name="SubDeptId"
                                PropertyName="SelectedValue" />
                             <asp:Parameter Name="LevelId" DefaultValue="2"/>
                               <asp:sessionparameter name="EmpId" sessionfield="emp_id" type="Int32" />
                             
                        </SelectParameters>
                    </asp:SqlDataSource>

<%--
                    SelectCommand="SELECT 0 AS EmpID, ' ---ALL---' AS Name UNION 
SELECT     Employee.EmpID,  ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS Name
FROM         Employee

inner join EmployeeReportingAuthority ER on er.ReportingAuthorityEmpID=Employee.EmpID
WHERE     (@SubDept_Id =0 or Employee.SubDeptId = @SubDept_Id) and ER.EmpID=@empid  order by Name,EmpID"--%>

                </td>
            </tr>

            <tr>
                <td align="right" class="style1">
                    <strong>Start Date :</strong></td>
                <td colspan="2">
                    <igsch:WebDateChooser ID="WebDateChooser_Start_Date" runat="server" CssClass="drop_down">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                    <asp:HiddenField ID="HiddenField_Start_Date" runat="server" />
                </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    <strong>End Date :</strong></td>
                <td colspan="2">
                    <igsch:WebDateChooser ID="WebDateChooser_end_Date" runat="server" CssClass="drop_down">
                        <AutoPostBack CalendarMonthChanged="True" ValueChanged="True" />
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                    <asp:HiddenField ID="HiddenField_end_Date" runat="server" />
                </td>
            </tr>

            <tr style="visibility: hidden">
                <td align="right" class="style1">
                    <strong>Emp No :</strong></td>
                <td colspan="2"></b>
               <%-- <asp:TextBox ID="TextBox_Emp" runat="server"></asp:TextBox>
                <asp:HiddenField ID="HiddenField_empNo" runat="server" />--%>




                    <asp:TextBox ID="txtbox_EmpNo" runat="server"></asp:TextBox>




                </td>
            </tr>

            <tr style="visibility: hidden">
                <td align="right" class="style1">
                    <strong>Employee Status :</strong></td>
                <td colspan="2">
                    <asp:RadioButtonList ID="RBL_Emp_stat" runat="server"
                        RepeatDirection="Horizontal">
                        <asp:ListItem Value="3">All</asp:ListItem>
                        <asp:ListItem Selected="True" Value="1">Active</asp:ListItem>
                        <asp:ListItem Value="0">Deactive</asp:ListItem>
                        <asp:ListItem Value="2">Ex-employee</asp:ListItem>
                    </asp:RadioButtonList>




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

