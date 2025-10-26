<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="false" CodeFile="ViewPatientRecodIssueHistory.aspx.vb" Inherits="RecordManagement_ViewPatientRecodIssueHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

<script type ="text/javascript" >
    function resetform() { document.form1.reset(); document.form1.TextBoxYearlyNo.focus(); }
    function enablelist(a) {
        if (a.checked == true) {
            document.getElementById("dropdownlistDiagnosis").disabled = false;
        }
        else {

            document.getElementById("dropdownlistDiagnosis").disabled = true;
        }

    }
</script>

   <script src="../SpryAssets/mycollaps.js" type="text/javascript"></script>
  <link href="../SpryAssets/mycollaps.css" rel="stylesheet" type="text/css" />
  <script src="../css_hacims/ck.js" type="text/javascript"></script> 

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="bxmain PageHeading">
    
    Record Issue History
    
</div>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top"><div class="bx_rad" style="width:100%;">
<ul id="tp1">
      <li><strong>&nbsp;Patient Search</strong></li>
      <li>
              <asp:Panel ID="Panel2" runat="server"  Width="100%"></asp:Panel>
            
          <br />
<div align="center"> <asp:Button CssClass="btn1" ID="Button1" runat="server" Text="Search" /></div>
 <br /></li></ul></div>

</td>
  </tr>
  <tr>
    <td valign="top"><br/>
    
    <asp:Label CssClass="err"  ID="Label1" runat="server" ></asp:Label>

<br />


<asp:GridView ID="GridViewSearch" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                CssClass="Grid_1" Width="100%" PageSize="25"  >
              <RowStyle CssClass="GridItem" />
              <HeaderStyle CssClass="GridHeader" />            
              <AlternatingRowStyle CssClass="GridAltItem" />
              <Columns>
                  <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnIssueFile" OnClick="btnIssueFile_Click" CommandArgument='<%#Eval("Patient_File_ID") %>' runat="server" Text="Issue History" />
                    </ItemTemplate>
                            
                  </asp:TemplateField>
              </Columns>
              <PagerStyle CssClass="GridPager"  />
            </asp:GridView>
<asp:SqlDataSource ID="SqlDataSourceSearch" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"> </asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSourceDiagnosis" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                SelectCommand="SELECT [Diagnosis] FROM [Diagnosis]"></asp:SqlDataSource>

  
    
    </td>
  </tr>
</table>
<br />
    <asp:GridView ID="GridView1" DataSourceID="sqlDs_FileIssueHistory" Width="100%" 
        runat="server" AutoGenerateColumns="False" EnableModelValidation="True">
        <Columns>
            <asp:BoundField DataField="SubDept_Name" HeaderText="Sub Department" />
            <asp:BoundField DataField="Consultant_Name" HeaderText="Consultant" />
            <asp:BoundField DataField="Issued_To_Employee" HeaderText="Issued To" />
            <asp:BoundField DataField="Issued_By_Employee" HeaderText="Issued By" />
            <asp:BoundField DataField="Returned_To_Employee" HeaderText="Returned To" />
            <asp:BoundField DataField="Returned_By_Employee" HeaderText="Returned By" />
            <asp:BoundField DataField="Issue_Date" HeaderText="Issue Date" />
            <asp:BoundField DataField="Returned_Date" HeaderText="Returned Date" />
            <asp:BoundField DataField="Issued_Status" HeaderText="Issued Status" 
                Visible="False" />
        </Columns>
    </asp:GridView>

 <asp:SqlDataSource ID="sqlDs_FileIssueHistory"
    ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
    SelectCommand="SELECT SubDepartment.SubDept_Name, Consultant.Prefix + ' ' + ISNULL(Consultant.EFName, '') + ' ' + ISNULL(Consultant.ELName, '') AS Consultant_Name, 
Issue_To_Employee.Prefix + ' ' + ISNULL(Issue_To_Employee.EFName, '') + ' ' + ISNULL(Issue_To_Employee.ELName, '') AS Issued_To_Employee, 
Issued_By_Employee.Prefix + ' ' + ISNULL(Issued_By_Employee.EFName, '') + ' ' + ISNULL(Issued_By_Employee.ELName, '') AS Issued_By_Employee, 
Returned_To_Employee.Prefix + ' ' + ISNULL(Returned_To_Employee.EFName, '') + ' ' + ISNULL(Returned_To_Employee.ELName, '') AS Returned_To_Employee, 
Returned_By_Employee.Prefix + ' ' + ISNULL(Returned_By_Employee.EFName, '') + ' ' + ISNULL(Returned_By_Employee.ELName, '') AS Returned_By_Employee, 
A.Remarks, A.Issue_Date, A.Returned_Date, A.Issued_Status, A.Returned_Remarks, A.Patient_Record_File_Id
FROM         Record_Management.dbo.Patient_Record_File_Issue AS A INNER JOIN
SubDepartment ON A.Request_By_SubDept_Id = SubDepartment.SubDept_Id INNER JOIN
Employee AS Consultant ON A.Request_By_Consultant_Id = Consultant.EmpID INNER JOIN
Employee AS Issue_To_Employee ON A.Issued_To_Emp_Id = Issue_To_Employee.EmpID INNER JOIN
Employee AS Issued_By_Employee ON A.Issued_By_Emp_Id = Issued_By_Employee.EmpID INNER JOIN
Employee AS Returned_By_Employee ON A.Returned_By_Emp_Id = Returned_By_Employee.EmpID INNER JOIN
Employee AS Returned_To_Employee ON A.Returned_To_Emp_Id = Returned_To_Employee.EmpID
Where A.Patient_Record_File_Id = @Patient_Record_File_Id
ORDER BY A.Patient_Record_File_Issue_Id" runat="server">
    <SelectParameters>
        <asp:Parameter Name="Patient_Record_File_Id" Type="Int64" />
    </SelectParameters>
 </asp:SqlDataSource>
 
   <script type="text/javascript">

       var cookies = Spry.Utils.Cookie("read", "tabbedpanels");

       if (cookies == "true") {
           var tp1 = new Spry.Widget.CollapsiblePanel("tp1", { contentIsOpen: true });
       } else {
           var tp1 = new Spry.Widget.CollapsiblePanel("tp1", { contentIsOpen: false });
       }

       Spry.Utils.addUnLoadListener(function () {

           Spry.Utils.Cookie("create", "tabbedpanels", tp1.isOpen());

       });

 
</script>

</asp:Content>

