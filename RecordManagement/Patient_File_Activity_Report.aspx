<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="~/RecordManagement/Patient_File_Activity_Report.aspx.cs" AutoEventWireup="true" Inherits="RecordManagement_Patient_File_Activity_Report" EnableEventValidation="false" Theme="theme_hacims" ViewStateEncryptionMode="Never" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="rview1" runat="server"></asp:ScriptManager>

    <div style="padding-bottom: 20px;">
        <asp:Button ID="btnReturn" Text="Return"
            runat="server" OnClick="btnReturn_Click" />
    </div>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
    </rsweb:ReportViewer>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Record_ManagementConnectionString %>"
        SelectCommand="SELECT
	
	A.Name,A.CNIC,A.Address,A.Phone,A.Relation,A.Remarks,A.DateTime
FROM Patient_Record_File F
INNER JOIN Patient_Record_File_Activity AS A
	ON F.Patient_File_ID = A.Patient_File_ID
WHERE A.Patient_File_ID=@Patient_File_ID">
        <SelectParameters>

            <asp:Parameter Name="Patient_File_ID" Type="Int32" />

        </SelectParameters>



    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:Record_ManagementConnectionString %>"
        SelectCommand="SELECT     ISNULL(BasicDataInfo.dbo.Employee.Prefix, '') + ' ' + ISNULL(BasicDataInfo.dbo.Employee.EFName, '') + ' ' + ISNULL(BasicDataInfo.dbo.Employee.ELName, '') 
                      AS Employee, Patient_Record_File.FileNo, Patient_Record_File_Issue.Remarks, CONVERT(varchar(20),Patient_Record_File_Issue.Issue_Date,105) AS Issue_Date, 
                      CONVERT(varchar(20),Patient_Record_File_Issue.Returned_Date,105)AS Returend_Date
FROM         Patient_Record_File INNER JOIN
                      Patient_Record_File_Activity ON Patient_Record_File.Patient_File_ID = Patient_Record_File_Activity.Patient_File_ID INNER JOIN
                      Patient_Record_File_Issue ON Patient_Record_File_Activity.Patient_File_ID = Patient_Record_File_Issue.Patient_Record_File_Id INNER JOIN
                      BasicDataInfo.dbo.Employee ON Patient_Record_File_Issue.Issued_To_Emp_Id = BasicDataInfo.dbo.Employee.EmpID
WHERE		Patient_Record_File_Activity.Patient_File_ID=@Patient_File_ID">
        <SelectParameters>

            <asp:Parameter Name="Patient_File_ID" Type="Int32" />

        </SelectParameters>



    </asp:SqlDataSource>
</asp:Content>

