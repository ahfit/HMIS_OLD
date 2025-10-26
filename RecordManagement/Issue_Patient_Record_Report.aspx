<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="Issue_Patient_Record_Report.aspx.cs" Inherits="RecordManagement_Issue_Patient_Record_Report" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:ScriptManager ID="rview1" runat="server"></asp:ScriptManager>
<div style=" padding-bottom:20px;"> <asp:Button ID="btnReturn" Text="Return" 
           runat="server" onclick="btnReturn_Click" />
   
           </div>
     
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
    </rsweb:ReportViewer>
     

    

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Record_ManagementConnectionString %>"
    SelectCommand="SELECT TOP(1)  PRFI.Patient_Record_File_Id, PRFI.Remarks, PRFI.Issue_Date,sub.SubDept_Name,
		ISNULL(cons.Prefix,'')+' '+ISNULL(cons.EFName,'')+' '+ISNULL(cons.EMName,'')+' '
		+ISNULL(cons.ELName,'') AS Consultant,
		ISNULL(empTo.Prefix,'')+' '+ISNULL(empTo.EFName,'')+' '+ISNULL(empTo.EMName,'')+' '
		+ISNULL(empTo.ELName,'') AS Issued_To,
		ISNULL(empBy.Prefix,'')+' '+ISNULL(empBy.EFName,'')+' '+ISNULL(empBy.EMName,'')+' '
		+ISNULL(empBy.ELName,'') AS Issued_By
		
FROM         Patient_Record_File_Issue AS PRFI INNER JOIN
                      BasicDataInfo.dbo.SubDepartment AS sub ON sub.SubDept_Id = PRFI.Request_By_SubDept_Id INNER JOIN
                      BasicDataInfo.dbo.Employee AS empTo ON empTo.EmpID = PRFI.Issued_To_Emp_Id INNER JOIN
                      BasicDataInfo.dbo.Employee AS empBy ON empBy.EmpID=PRFI.Issued_By_Emp_Id INNER JOIN
                      BasicDataInfo.dbo.Employee AS cons ON cons.EmpID=PRFI.Request_By_Consultant_Id
WHERE     (PRFI.Patient_Record_File_Id =@Patient_Record_File_Id)
ORDER BY PRFI.Patient_Record_File_Issue_Id DESC">
<SelectParameters>
    <asp:Parameter Name="Patient_Record_File_Id" Type="Int32" />
</SelectParameters>

</asp:SqlDataSource>
</asp:Content>

