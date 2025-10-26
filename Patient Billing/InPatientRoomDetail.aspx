<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Patient_Billing_InPatientRoomDetail, App_Web_gswfk1g0" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="bxmain inner_content" style="width: 100%">
        <h2>
            <span>View Room/Bed Status</span></h2>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
            <tr>
                <td width="40%" align="right">
                    <strong>Department :</strong>&nbsp;
                </td>
                <td width="60%">
                    <asp:DropDownList ID="DDL_Department" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_Department"
                        DataTextField="Dept_Name" CssClass="dropbox" DataValueField="Dept_ID" Width="250px">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Department" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                        SelectCommand="SELECT        0 AS Dept_ID, '--ALL--' AS Dept_Name
UNION
SELECT        Department.Dept_ID, Department.Dept_Name
FROM            Department INNER JOIN
                         SubDepartment ON Department.Dept_ID = SubDepartment.Dept_Id
						 where SubDept_Type=1
						 order by Dept_Name ">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td width="40%" align="right">
                    <strong>Unit / Floor :</strong>&nbsp;
                </td>
                <td width="60%">
                    <asp:DropDownList ID="DropDownListFloor" runat="server" AutoPostBack="false" DataSourceID="SqlDataSourceFloor"
                        DataTextField="Ward_Name" CssClass="dropbox" DataValueField="Ward_id" Width="250px">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    &nbsp;&nbsp;
                    <asp:Button ID="btnViewReport"  runat="server" Text="View Report" />
                </td>
            </tr>
        </table>
    </div>
    <div style="color: brown; font-weight: bold; padding: 10px">
        Room/Bed Summary</div>
    
        <rsweb:ReportViewer ID="ReportViewer1" Width="100%" runat="server">
        </rsweb:ReportViewer>
   
    <br />
    <asp:SqlDataSource ID="SqlDataSourceFloor" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="select 0 as Ward_id,'--ALL--' as Ward_Name union SELECT DISTINCT  Ward_id,Ward_Name FROM  admin_Hospital_Wards WHERE (isDeleted = 0)">
        <SelectParameters>
            <asp:SessionParameter Name="SubDept_Id" SessionField="SubDeptID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldWard_Id" runat="server" />
    </asp:Content>
