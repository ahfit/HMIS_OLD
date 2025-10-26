<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="false" CodeFile="ReceiveIssuedPatientRecords.aspx.vb" Inherits="RecordManagement_ReceiveIssuedPatientRecords" %>

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
    
    Receive Patients Records
    
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
                        <asp:Button ID="btnReceiveFile" OnClick="btnReceiveFile_Click" CommandArgument='<%#Eval("Patient_Record_File_Issue_Id") %>' runat="server" Text="Receive" />
                        <asp:HiddenField ID="hf_pf_Id"  Value ='<%#Eval("Patient_File_Id") %>' runat="server" />
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


<asp:Panel ID="pnlIssueFile" CssClass="lightbox" Visible="false" runat="server">
    <table>
               
        <tr>
            <td>Returned By</td>
            <td>
                <asp:DropDownList ID="ddlReturnedBy" DataSourceID="SqlDs_Employee" DataTextField="Name" DataValueField="EmpID"
                 runat="server">
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
            <td>Returned To</td>
            <td>
                <asp:DropDownList ID="ddlReturnedTo" DataSourceID="SqlDs_Employee" Enabled="false" DataTextField="Name" DataValueField="EmpID"
                 runat="server">
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
                <asp:HiddenField ID="hfldIssueFileId" runat="server" Value="0" />
                <asp:Button ID="btnRecieveRecord" runat="server" Text="Receive" />
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

 <asp:SqlDataSource ID="sqlDs_PatientRecordReceive"
    ConnectionString="<%$ ConnectionStrings:Record_ManagementConnectionString %>"
    UpdateCommand="usp_FileRecordReceived" UpdateCommandType="StoredProcedure"
  runat="server">
    <UpdateParameters>
        <asp:Parameter Name="Patient_Record_File_Issue_Id" Type="Int64" />
        <asp:Parameter Name="Returned_Date" Type="DateTime" />
        <asp:Parameter Name="Returned_By_Emp_Id" Type="Int32" />
        <asp:Parameter Name="Returned_To_Emp_Id" Type="Int32" />
        <asp:Parameter Name="Remarks" Type="String" />
    </UpdateParameters>
 </asp:SqlDataSource>
    <asp:HiddenField ID="hf_File_ID" runat="server" />

</asp:Content>

