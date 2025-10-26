<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="false" CodeFile="RequestIssuePatientRecord.aspx.vb" Inherits="RecordManagement_RequestIssuePatientRecord" %>

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
    
    Request For Patient Record
    
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


<asp:GridView ID="GridViewSearch" runat="server" AllowPaging="True" AutoGenerateColumns="true"
                CssClass="Grid_1" Width="100%" PageSize="25"  >
              <RowStyle CssClass="GridItem" />
              <HeaderStyle CssClass="GridHeader" />            
              <AlternatingRowStyle CssClass="GridAltItem" />
              <Columns>
                  <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnIssueFile" OnClick="btnIssueFile_Click" CommandArgument='<%#Eval("Patient_File_ID") %>' runat="server" Text="Issue" Visible="false" />
                        <asp:Button ID="btnRecordActivity" OnClick="btnRecordActivity_Click"  CommandArgument='<%#Eval("Patient_File_ID") %>' runat="server" Text="Request" />
                        <asp:Button ID="btnReport" OnClick="btnReport_Click"   CommandArgument='<%#Eval("Patient_File_ID") %>' runat="server" Text="Report" Visible="false" />
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
                Department:
            </td>
            <td>
                <asp:DropDownList ID="ddlSubDept" runat="server" DataSourceID="sqlDs_SubDept" 
                    DataTextField="SubDept_Name" DataValueField="SubDept_Id" AutoPostBack="false">
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
                 runat="server" AutoPostBack="false">
                 </asp:DropDownList>

                 <asp:SqlDataSource ID="sqlDs_Consultant" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    ProviderName="System.Data.SqlClient" 
                    SelectCommand="
                   
SELECT     EmpID, Prefix + ' ' + LTRIM(RTRIM(ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, ''))) AS Name
FROM         Employee
WHERE    (ActiveStatus=1)and (Employee.Is_Consultant=1)
Order By LTRIM(RTRIM(ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '')))
                     ">
    
                     <SelectParameters>
                         <asp:ControlParameter ControlID="ddlSubDept" Name="DeptID" 
                             PropertyName="SelectedValue" />
                     </SelectParameters>
    
                </asp:SqlDataSource>
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
                <asp:Button ID="btn_Request" runat="server" Text="Request" />
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
    InsertCommand="usp_Insert_RequestPatient_Record_File_Activity" InsertCommandType="StoredProcedure"
  runat="server">
    <InsertParameters>
        <asp:ControlParameter ControlID="hfldFileId" Name="Patient_File_ID" PropertyName="Value" Type="Int32" />
        <asp:SessionParameter Name="EmpID" SessionField="emp_id" Type="Int32" />
        <asp:ControlParameter ControlID="ddlConsultant" Name="ConsultantID" PropertyName="SelectedValue" Type="Int32" />
        <asp:ControlParameter ControlID="ddlSubDept" Name="DeptID" PropertyName="SelectedValue" Type="Int32" />
    </InsertParameters>
 </asp:SqlDataSource>


</asp:Content>

