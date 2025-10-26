<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="false" CodeFile="IssuePatientRecord.aspx.vb" Inherits="RecordManagement_IssuePatientRecord" %>

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
    
    Issue Patient Record
    
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
                        <asp:Button ID="btnIssueFile" OnClick="btnIssueFile_Click" CommandArgument='<%#Eval("Patient_File_ID") %>' runat="server" Text="Issue" />
                        <asp:Button ID="btnRecordActivity" OnClick="btnRecordActivity_Click"  CommandArgument='<%#Eval("Patient_File_ID") %>' runat="server" Text="Request" />
                        <asp:Button ID="btnReport" OnClick="btnReport_Click"   CommandArgument='<%#Eval("Patient_File_ID") %>' runat="server" Text="Report" />
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


<asp:Panel ID="pnlIssueFile"  Visible="false" runat="server" CssClass="lightbox">
    <table>
        <tr>
            <td>
                    Hospital:</td>
            <td>
                    <asp:DropDownList ID="ddl_Hospital" DataSourceID="sqlDs_Hospital" DataTextField="Hospital_Name" 
                        DataValueField="Hospital_ID" runat="server" AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sqlDs_Hospital" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
                        ProviderName="System.Data.SqlClient" 
                        SelectCommand="SELECT     Hospital_ID, Hospital_Name
FROM         Hospital
order by Hospital_Name">
                    </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                Department:
            </td>
            <td>
                <asp:DropDownList ID="ddlSubDept" runat="server" DataSourceID="sqlDs_SubDept" 
                    DataTextField="SubDept_Name" DataValueField="SubDept_Id" AutoPostBack="True">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sqlDs_SubDept" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
                    ProviderName="System.Data.SqlClient" 
                    SelectCommand="SELECT   SubDept_Id,SubDept_Name     
FROM            SubDepartment
WHERE        (SubDept_Type = 1)
order by SubDept_Name">
                    
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                Consultant :
            </td>
            <td>
                <asp:DropDownList ID="ddlConsultant" DataSourceID="sqlDs_Consultant" 
                    DataTextField="Name" DataValueField="EmpID"
                 runat="server" AutoPostBack="True">
                 </asp:DropDownList>

                 <asp:SqlDataSource ID="sqlDs_Consultant" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    ProviderName="System.Data.SqlClient" 
                    SelectCommand="
                   
SELECT     EmpID, Prefix + ' ' + ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS Name
FROM         Employee
WHERE     (employee.DeptID = @DeptID)and (ActiveStatus=1)and (Employee.Is_Consultant=1)">
    
                     <SelectParameters>
                         <asp:ControlParameter ControlID="ddlSubDept" Name="DeptID" 
                             PropertyName="SelectedValue" />
                     </SelectParameters>
    
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>Issued To</td>
            <td>
                <asp:DropDownList ID="ddlIssuedTo" DataSourceID="SqlDs_Employee" 
                    DataTextField="Name" DataValueField="EmpID"
                 runat="server" AutoPostBack="True">
                 </asp:DropDownList>

                <asp:SqlDataSource ID="SqlDs_Employee" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    ProviderName="System.Data.SqlClient" 
                    SelectCommand="
                    Select * From (SELECT     EmpID, Prefix + ' ' + IsNull(EFName,'') + ' ' + IsNull(EMName,'') + ' ' + IsNull(ELName,'') Name
FROM         Employee ) TMP
Order BY Name">
    
                </asp:SqlDataSource>

            </td>
        </tr>
        <tr>
            <td>Issued By</td>
            <td>
                <asp:DropDownList ID="ddlIssuedBy" DataSourceID="SqlDs_Employee" 
                    Enabled="false" DataTextField="Name" DataValueField="EmpID"
                 runat="server" AutoPostBack="True">
                 </asp:DropDownList>

            </td>
        </tr>
        <tr>
            <td>
             Remarks   
            </td>
            <td>
                <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" Rows="7" Height="200px" Width="400px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                
            </td>
            <td>
                
            </td>
        </tr>
        
        <tr>
            <td></td>
            <td>
                <asp:HiddenField ID="hfldFileId" runat="server" Value="0" />
                <asp:Button ID="btnRecieveRecord" runat="server" Text="Issue" />
                <asp:Button ID="btnClose" runat="server" Text="Close" />
                <asp:Button ID="btnPrint" runat="server" Text="Print" Visible="false" />
            </td>
        </tr>
    </table>
</asp:Panel>
 
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

 <asp:SqlDataSource ID="sqlDs_PatientRecordIssue"
    ConnectionString="<%$ ConnectionStrings:Record_ManagementConnectionString %>"
    InsertCommand="usp_CreateFileIssueRecord" InsertCommandType="StoredProcedure"
  runat="server">
    <InsertParameters>
        <asp:Parameter Name="Patient_Record_File_Issue_Id" Type="Int64" />
        <asp:Parameter Name="Patient_Record_File_Id" Type="Int64" />
        <asp:Parameter Name="Request_By_SubDept_Id" Type="Int32" />
        <asp:Parameter Name="Request_By_Consultant_Id" Type="Int32" />
        <asp:Parameter Name="Issued_To_Emp_Id" Type="Int32" />
        <asp:Parameter Name="Issued_By_Emp_Id" Type="Int32" />
        <asp:Parameter Name="Remarks" Type="string" />
        <asp:Parameter Name="Issue_Date" Type="DateTime" />
        <asp:Parameter Name="Issued_Status" Type="Int16" />
    </InsertParameters>
 </asp:SqlDataSource>


</asp:Content>

